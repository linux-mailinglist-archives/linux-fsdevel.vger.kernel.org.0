Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0317F11016C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 16:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfLCPmf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 10:42:35 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:50160 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfLCPmf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 10:42:35 -0500
Received: from [81.92.17.147] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1icAHg-0004aI-Cd; Tue, 03 Dec 2019 15:40:16 +0000
Date:   Tue, 3 Dec 2019 16:40:13 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     linux-kernel@vger.kernel.org,
        Henning Schild <henning.schild@siemens.com>,
        Dmitry Safonov <dima@arista.com>, linux-api@vger.kernel.org,
        containers@lists.linux-foundation.org,
        Jann Horn <jannh@google.com>, Greg Kurz <groug@kaod.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        linux-fsdevel@vger.kernel.org,
        =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
        dhowells@redhat.com
Subject: Re: [PATCH v7 1/1] ns: add binfmt_misc to the user namespace
Message-ID: <20191203154012.opirpicsuc6ou3cx@wittgenstein>
References: <20191107140304.8426-1-laurent@vivier.eu>
 <20191107140304.8426-2-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191107140304.8426-2-laurent@vivier.eu>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 07, 2019 at 03:03:04PM +0100, Laurent Vivier wrote:
> This patch allows to have a different binfmt_misc configuration
> for each new user namespace. By default, the binfmt_misc configuration
> is the one of the previous level, but if the binfmt_misc filesystem is
> mounted in the new namespace a new empty binfmt instance is created and
> used in this namespace.
> 
> For instance, using "unshare" we can start a chroot of another
> architecture and configure the binfmt_misc interpreter without being root
> to run the binaries in this chroot.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> Acked-by: Andrei Vagin <avagin@gmail.com>
> ---
>  fs/binfmt_misc.c               | 115 +++++++++++++++++++++++++--------
>  include/linux/user_namespace.h |  15 +++++
>  kernel/user.c                  |  14 ++++
>  kernel/user_namespace.c        |   3 +
>  4 files changed, 119 insertions(+), 28 deletions(-)
> 
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index cdb45829354d..ba5f0d2ade96 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -40,9 +40,6 @@ enum {
>  	VERBOSE_STATUS = 1 /* make it zero to save 400 bytes kernel memory */
>  };
>  
> -static LIST_HEAD(entries);
> -static int enabled = 1;
> -
>  enum {Enabled, Magic};
>  #define MISC_FMT_PRESERVE_ARGV0 (1 << 31)
>  #define MISC_FMT_OPEN_BINARY (1 << 30)
> @@ -62,10 +59,7 @@ typedef struct {
>  	struct file *interp_file;
>  } Node;
>  
> -static DEFINE_RWLOCK(entries_lock);
>  static struct file_system_type bm_fs_type;
> -static struct vfsmount *bm_mnt;
> -static int entry_count;
>  
>  /*
>   * Max length of the register string.  Determined by:
> @@ -82,18 +76,37 @@ static int entry_count;
>   */
>  #define MAX_REGISTER_LENGTH 1920
>  
> +static struct binfmt_namespace *binfmt_ns(struct user_namespace *ns)
> +{
> +	struct binfmt_namespace *b_ns;
> +
> +	while (ns) {
> +		b_ns = READ_ONCE(ns->binfmt_ns);
> +		if (b_ns)
> +			return b_ns;
> +		ns = ns->parent;
> +	}
> +	/* as the first user namespace is initialized with
> +	 * &init_binfmt_ns we should never come here
> +	 * but we try to stay safe by logging a warning
> +	 * and returning a sane value
> +	 */
> +	WARN_ON_ONCE(1);
> +	return &init_binfmt_ns;
> +}
> +
>  /*
>   * Check if we support the binfmt
>   * if we do, return the node, else NULL
>   * locking is done in load_misc_binary
>   */
> -static Node *check_file(struct linux_binprm *bprm)
> +static Node *check_file(struct binfmt_namespace *ns, struct linux_binprm *bprm)
>  {
>  	char *p = strrchr(bprm->interp, '.');
>  	struct list_head *l;
>  
>  	/* Walk all the registered handlers. */
> -	list_for_each(l, &entries) {
> +	list_for_each(l, &ns->entries) {
>  		Node *e = list_entry(l, Node, list);
>  		char *s;
>  		int j;
> @@ -135,17 +148,18 @@ static int load_misc_binary(struct linux_binprm *bprm)
>  	struct file *interp_file = NULL;
>  	int retval;
>  	int fd_binary = -1;
> +	struct binfmt_namespace *ns = binfmt_ns(current_user_ns());
>  
>  	retval = -ENOEXEC;
> -	if (!enabled)
> +	if (!ns->enabled)
>  		return retval;
>  
>  	/* to keep locking time low, we copy the interpreter string */
> -	read_lock(&entries_lock);
> -	fmt = check_file(bprm);
> +	read_lock(&ns->entries_lock);
> +	fmt = check_file(ns, bprm);
>  	if (fmt)
>  		dget(fmt->dentry);
> -	read_unlock(&entries_lock);
> +	read_unlock(&ns->entries_lock);
>  	if (!fmt)
>  		return retval;
>  
> @@ -611,19 +625,19 @@ static void bm_evict_inode(struct inode *inode)
>  	kfree(e);
>  }
>  
> -static void kill_node(Node *e)
> +static void kill_node(struct binfmt_namespace *ns, Node *e)
>  {
>  	struct dentry *dentry;
>  
> -	write_lock(&entries_lock);
> +	write_lock(&ns->entries_lock);
>  	list_del_init(&e->list);
> -	write_unlock(&entries_lock);
> +	write_unlock(&ns->entries_lock);
>  
>  	dentry = e->dentry;
>  	drop_nlink(d_inode(dentry));
>  	d_drop(dentry);
>  	dput(dentry);
> -	simple_release_fs(&bm_mnt, &entry_count);
> +	simple_release_fs(&ns->bm_mnt, &ns->entry_count);
>  }
>  
>  /* /<entry> */
> @@ -653,6 +667,9 @@ static ssize_t bm_entry_write(struct file *file, const char __user *buffer,
>  	struct dentry *root;
>  	Node *e = file_inode(file)->i_private;
>  	int res = parse_command(buffer, count);
> +	struct binfmt_namespace *ns;
> +
> +	ns = binfmt_ns(file->f_path.dentry->d_sb->s_user_ns);

Sorry for being so late to the party.

The naked dereferences here are not very pretty and also likely mean you
access the wrong dentry when you do (weird but possible) things like:

mount -t overlay overlay -o lowerdir=/proc/sys/fs/binfmt_misc,workdir=/work,upperdir=/upper /merged

(which might already cause trouble in other parts of this code)

so I think it's better if you replace 
file->f_path.dentry->d_sb->s_user_ns
with
file_dentry(file)->d_sb->s_user_ns
in places where you do naked dereferences now.
