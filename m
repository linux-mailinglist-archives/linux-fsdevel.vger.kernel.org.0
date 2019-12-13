Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE2211E9BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 19:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbfLMSHp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Dec 2019 13:07:45 -0500
Received: from lizzard.sbs.de ([194.138.37.39]:51424 "EHLO lizzard.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728550AbfLMSHp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Dec 2019 13:07:45 -0500
X-Greylist: delayed 973 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Dec 2019 13:07:41 EST
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
        by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id xBDHpCBL028096
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Dec 2019 18:51:12 +0100
Received: from md1za8fc.ad001.siemens.net ([139.25.69.101])
        by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id xBDHpCx6023322;
        Fri, 13 Dec 2019 18:51:12 +0100
Date:   Fri, 13 Dec 2019 18:51:10 +0100
From:   Henning Schild <henning.schild@siemens.com>
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     <linux-kernel@vger.kernel.org>, Dmitry Safonov <dima@arista.com>,
        <linux-fsdevel@vger.kernel.org>,
        "James Bottomley" <James.Bottomley@HansenPartnership.com>,
        Eric Biederman <ebiederm@xmission.com>,
        <linux-api@vger.kernel.org>, Andrei Vagin <avagin@gmail.com>,
        =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>,
        "Greg Kurz" <groug@kaod.org>, Jann Horn <jannh@google.com>,
        <containers@lists.linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH v7 1/1] ns: add binfmt_misc to the user namespace
Message-ID: <20191213185110.06b52cf4@md1za8fc.ad001.siemens.net>
In-Reply-To: <7cb245ed-f738-7991-a09b-b27152274b9f@vivier.eu>
References: <20191107140304.8426-1-laurent@vivier.eu>
        <20191107140304.8426-2-laurent@vivier.eu>
        <7cb245ed-f738-7991-a09b-b27152274b9f@vivier.eu>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

that is a very useful contribution, which will hopefully be considered.

Tested-by: Henning Schild <henning.schild@siemens.com>

Having a private binfmt_misc allows having different interpreters
(paths to them) for the same format in each namespace. Imagine chroots
of different architectures where the static qemu is in a different
place i.e. /usr/bin/qemu-arm-static, vs
/sbin/qemu-arm-static, or /home/dev/qemu/qemu-arm-static

And it also eventually allows setting up binfmt_misc for a chroot
without requiring root.

Henning

Am Tue, 3 Dec 2019 10:44:44 +0100
schrieb Laurent Vivier <laurent@vivier.eu>:

> Ping
> 
> Thanks,
> Laurent
> 
> Le 07/11/2019 à 15:03, Laurent Vivier a écrit :
> > This patch allows to have a different binfmt_misc configuration
> > for each new user namespace. By default, the binfmt_misc
> > configuration is the one of the previous level, but if the
> > binfmt_misc filesystem is mounted in the new namespace a new empty
> > binfmt instance is created and used in this namespace.
> > 
> > For instance, using "unshare" we can start a chroot of another
> > architecture and configure the binfmt_misc interpreter without
> > being root to run the binaries in this chroot.
> > 
> > Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> > Acked-by: Andrei Vagin <avagin@gmail.com>
> > ---
> >  fs/binfmt_misc.c               | 115
> > +++++++++++++++++++++++++-------- include/linux/user_namespace.h |
> > 15 +++++ kernel/user.c                  |  14 ++++
> >  kernel/user_namespace.c        |   3 +
> >  4 files changed, 119 insertions(+), 28 deletions(-)
> > 
> > diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> > index cdb45829354d..ba5f0d2ade96 100644
> > --- a/fs/binfmt_misc.c
> > +++ b/fs/binfmt_misc.c
> > @@ -40,9 +40,6 @@ enum {
> >  	VERBOSE_STATUS = 1 /* make it zero to save 400 bytes
> > kernel memory */ };
> >  
> > -static LIST_HEAD(entries);
> > -static int enabled = 1;
> > -
> >  enum {Enabled, Magic};
> >  #define MISC_FMT_PRESERVE_ARGV0 (1 << 31)
> >  #define MISC_FMT_OPEN_BINARY (1 << 30)
> > @@ -62,10 +59,7 @@ typedef struct {
> >  	struct file *interp_file;
> >  } Node;
> >  
> > -static DEFINE_RWLOCK(entries_lock);
> >  static struct file_system_type bm_fs_type;
> > -static struct vfsmount *bm_mnt;
> > -static int entry_count;
> >  
> >  /*
> >   * Max length of the register string.  Determined by:
> > @@ -82,18 +76,37 @@ static int entry_count;
> >   */
> >  #define MAX_REGISTER_LENGTH 1920
> >  
> > +static struct binfmt_namespace *binfmt_ns(struct user_namespace
> > *ns) +{
> > +	struct binfmt_namespace *b_ns;
> > +
> > +	while (ns) {
> > +		b_ns = READ_ONCE(ns->binfmt_ns);
> > +		if (b_ns)
> > +			return b_ns;
> > +		ns = ns->parent;
> > +	}
> > +	/* as the first user namespace is initialized with
> > +	 * &init_binfmt_ns we should never come here
> > +	 * but we try to stay safe by logging a warning
> > +	 * and returning a sane value
> > +	 */
> > +	WARN_ON_ONCE(1);
> > +	return &init_binfmt_ns;
> > +}
> > +
> >  /*
> >   * Check if we support the binfmt
> >   * if we do, return the node, else NULL
> >   * locking is done in load_misc_binary
> >   */
> > -static Node *check_file(struct linux_binprm *bprm)
> > +static Node *check_file(struct binfmt_namespace *ns, struct
> > linux_binprm *bprm) {
> >  	char *p = strrchr(bprm->interp, '.');
> >  	struct list_head *l;
> >  
> >  	/* Walk all the registered handlers. */
> > -	list_for_each(l, &entries) {
> > +	list_for_each(l, &ns->entries) {
> >  		Node *e = list_entry(l, Node, list);
> >  		char *s;
> >  		int j;
> > @@ -135,17 +148,18 @@ static int load_misc_binary(struct
> > linux_binprm *bprm) struct file *interp_file = NULL;
> >  	int retval;
> >  	int fd_binary = -1;
> > +	struct binfmt_namespace *ns = binfmt_ns(current_user_ns());
> >  
> >  	retval = -ENOEXEC;
> > -	if (!enabled)
> > +	if (!ns->enabled)
> >  		return retval;
> >  
> >  	/* to keep locking time low, we copy the interpreter
> > string */
> > -	read_lock(&entries_lock);
> > -	fmt = check_file(bprm);
> > +	read_lock(&ns->entries_lock);
> > +	fmt = check_file(ns, bprm);
> >  	if (fmt)
> >  		dget(fmt->dentry);
> > -	read_unlock(&entries_lock);
> > +	read_unlock(&ns->entries_lock);
> >  	if (!fmt)
> >  		return retval;
> >  
> > @@ -611,19 +625,19 @@ static void bm_evict_inode(struct inode
> > *inode) kfree(e);
> >  }
> >  
> > -static void kill_node(Node *e)
> > +static void kill_node(struct binfmt_namespace *ns, Node *e)
> >  {
> >  	struct dentry *dentry;
> >  
> > -	write_lock(&entries_lock);
> > +	write_lock(&ns->entries_lock);
> >  	list_del_init(&e->list);
> > -	write_unlock(&entries_lock);
> > +	write_unlock(&ns->entries_lock);
> >  
> >  	dentry = e->dentry;
> >  	drop_nlink(d_inode(dentry));
> >  	d_drop(dentry);
> >  	dput(dentry);
> > -	simple_release_fs(&bm_mnt, &entry_count);
> > +	simple_release_fs(&ns->bm_mnt, &ns->entry_count);
> >  }
> >  
> >  /* /<entry> */
> > @@ -653,6 +667,9 @@ static ssize_t bm_entry_write(struct file
> > *file, const char __user *buffer, struct dentry *root;
> >  	Node *e = file_inode(file)->i_private;
> >  	int res = parse_command(buffer, count);
> > +	struct binfmt_namespace *ns;
> > +
> > +	ns = binfmt_ns(file->f_path.dentry->d_sb->s_user_ns);
> >  
> >  	switch (res) {
> >  	case 1:
> > @@ -669,7 +686,7 @@ static ssize_t bm_entry_write(struct file
> > *file, const char __user *buffer, inode_lock(d_inode(root));
> >  
> >  		if (!list_empty(&e->list))
> > -			kill_node(e);
> > +			kill_node(ns, e);
> >  
> >  		inode_unlock(d_inode(root));
> >  		break;
> > @@ -695,6 +712,7 @@ static ssize_t bm_register_write(struct file
> > *file, const char __user *buffer, struct inode *inode;
> >  	struct super_block *sb = file_inode(file)->i_sb;
> >  	struct dentry *root = sb->s_root, *dentry;
> > +	struct binfmt_namespace *ns;
> >  	int err = 0;
> >  
> >  	e = create_entry(buffer, count);
> > @@ -718,7 +736,9 @@ static ssize_t bm_register_write(struct file
> > *file, const char __user *buffer, if (!inode)
> >  		goto out2;
> >  
> > -	err = simple_pin_fs(&bm_fs_type, &bm_mnt, &entry_count);
> > +	ns = binfmt_ns(file->f_path.dentry->d_sb->s_user_ns);
> > +	err = simple_pin_fs(&bm_fs_type, &ns->bm_mnt,
> > +			    &ns->entry_count);
> >  	if (err) {
> >  		iput(inode);
> >  		inode = NULL;
> > @@ -727,12 +747,16 @@ static ssize_t bm_register_write(struct file
> > *file, const char __user *buffer, 
> >  	if (e->flags & MISC_FMT_OPEN_FILE) {
> >  		struct file *f;
> > +		const struct cred *old_cred;
> >  
> > +		old_cred = override_creds(file->f_cred);
> >  		f = open_exec(e->interpreter);
> > +		revert_creds(old_cred);
> >  		if (IS_ERR(f)) {
> >  			err = PTR_ERR(f);
> >  			pr_notice("register: failed to install
> > interpreter file %s\n", e->interpreter);
> > -			simple_release_fs(&bm_mnt, &entry_count);
> > +			simple_release_fs(&ns->bm_mnt,
> > +					  &ns->entry_count);
> >  			iput(inode);
> >  			inode = NULL;
> >  			goto out2;
> > @@ -745,9 +769,9 @@ static ssize_t bm_register_write(struct file
> > *file, const char __user *buffer, inode->i_fop =
> > &bm_entry_operations; 
> >  	d_instantiate(dentry, inode);
> > -	write_lock(&entries_lock);
> > -	list_add(&e->list, &entries);
> > -	write_unlock(&entries_lock);
> > +	write_lock(&ns->entries_lock);
> > +	list_add(&e->list, &ns->entries);
> > +	write_unlock(&ns->entries_lock);
> >  
> >  	err = 0;
> >  out2:
> > @@ -772,7 +796,9 @@ static const struct file_operations
> > bm_register_operations = { static ssize_t
> >  bm_status_read(struct file *file, char __user *buf, size_t nbytes,
> > loff_t *ppos) {
> > -	char *s = enabled ? "enabled\n" : "disabled\n";
> > +	struct binfmt_namespace *ns =
> > +
> > binfmt_ns(file->f_path.dentry->d_sb->s_user_ns);
> > +	char *s = ns->enabled ? "enabled\n" : "disabled\n";
> >  
> >  	return simple_read_from_buffer(buf, nbytes, ppos, s,
> > strlen(s)); }
> > @@ -780,25 +806,28 @@ bm_status_read(struct file *file, char __user
> > *buf, size_t nbytes, loff_t *ppos) static ssize_t
> > bm_status_write(struct file *file, const char __user *buffer,
> > size_t count, loff_t *ppos) {
> > +	struct binfmt_namespace *ns;
> >  	int res = parse_command(buffer, count);
> >  	struct dentry *root;
> >  
> > +	ns = binfmt_ns(file->f_path.dentry->d_sb->s_user_ns);
> >  	switch (res) {
> >  	case 1:
> >  		/* Disable all handlers. */
> > -		enabled = 0;
> > +		ns->enabled = 0;
> >  		break;
> >  	case 2:
> >  		/* Enable all handlers. */
> > -		enabled = 1;
> > +		ns->enabled = 1;
> >  		break;
> >  	case 3:
> >  		/* Delete all handlers. */
> >  		root = file_inode(file)->i_sb->s_root;
> >  		inode_lock(d_inode(root));
> >  
> > -		while (!list_empty(&entries))
> > -			kill_node(list_first_entry(&entries, Node,
> > list));
> > +		while (!list_empty(&ns->entries))
> > +			kill_node(ns,
> > list_first_entry(&ns->entries,
> > +						       Node,
> > list)); 
> >  		inode_unlock(d_inode(root));
> >  		break;
> > @@ -825,24 +854,53 @@ static const struct super_operations s_ops = {
> >  static int bm_fill_super(struct super_block *sb, struct fs_context
> > *fc) {
> >  	int err;
> > +	struct user_namespace *ns = sb->s_user_ns;
> >  	static const struct tree_descr bm_files[] = {
> >  		[2] = {"status", &bm_status_operations,
> > S_IWUSR|S_IRUGO}, [3] = {"register", &bm_register_operations,
> > S_IWUSR}, /* last one */ {""}
> >  	};
> >  
> > +	/* create a new binfmt namespace
> > +	 * if we are not in the first user namespace
> > +	 * but the binfmt namespace is the first one
> > +	 */
> > +	if (READ_ONCE(ns->binfmt_ns) == NULL) {
> > +		struct binfmt_namespace *new_ns;
> > +
> > +		new_ns = kmalloc(sizeof(struct binfmt_namespace),
> > +				 GFP_KERNEL);
> > +		if (new_ns == NULL)
> > +			return -ENOMEM;
> > +		INIT_LIST_HEAD(&new_ns->entries);
> > +		new_ns->enabled = 1;
> > +		rwlock_init(&new_ns->entries_lock);
> > +		new_ns->bm_mnt = NULL;
> > +		new_ns->entry_count = 0;
> > +		/* ensure new_ns is completely initialized before
> > sharing it */
> > +		smp_wmb();
> > +		WRITE_ONCE(ns->binfmt_ns, new_ns);
> > +	}
> > +
> >  	err = simple_fill_super(sb, BINFMTFS_MAGIC, bm_files);
> >  	if (!err)
> >  		sb->s_op = &s_ops;
> >  	return err;
> >  }
> >  
> > +static void bm_free(struct fs_context *fc)
> > +{
> > +	if (fc->s_fs_info)
> > +		put_user_ns(fc->s_fs_info);
> > +}
> > +
> >  static int bm_get_tree(struct fs_context *fc)
> >  {
> > -	return get_tree_single(fc, bm_fill_super);
> > +	return get_tree_keyed(fc, bm_fill_super,
> > get_user_ns(fc->user_ns)); }
> >  
> >  static const struct fs_context_operations bm_context_ops = {
> > +	.free		= bm_free,
> >  	.get_tree	= bm_get_tree,
> >  };
> >  
> > @@ -861,6 +919,7 @@ static struct file_system_type bm_fs_type = {
> >  	.owner		= THIS_MODULE,
> >  	.name		= "binfmt_misc",
> >  	.init_fs_context = bm_init_fs_context,
> > +	.fs_flags	= FS_USERNS_MOUNT,
> >  	.kill_sb	= kill_litter_super,
> >  };
> >  MODULE_ALIAS_FS("binfmt_misc");
> > diff --git a/include/linux/user_namespace.h
> > b/include/linux/user_namespace.h index fb9f4f799554..16e6f3a97a01
> > 100644 --- a/include/linux/user_namespace.h
> > +++ b/include/linux/user_namespace.h
> > @@ -52,6 +52,18 @@ enum ucount_type {
> >  	UCOUNT_COUNTS,
> >  };
> >  
> > +#if IS_ENABLED(CONFIG_BINFMT_MISC)
> > +struct binfmt_namespace {
> > +	struct list_head entries;
> > +	rwlock_t entries_lock;
> > +	int enabled;
> > +	struct vfsmount *bm_mnt;
> > +	int entry_count;
> > +} __randomize_layout;
> > +
> > +extern struct binfmt_namespace init_binfmt_ns;
> > +#endif
> > +
> >  struct user_namespace {
> >  	struct uid_gid_map	uid_map;
> >  	struct uid_gid_map	gid_map;
> > @@ -86,6 +98,9 @@ struct user_namespace {
> >  #endif
> >  	struct ucounts		*ucounts;
> >  	int ucount_max[UCOUNT_COUNTS];
> > +#if IS_ENABLED(CONFIG_BINFMT_MISC)
> > +	struct binfmt_namespace *binfmt_ns;
> > +#endif
> >  } __randomize_layout;
> >  
> >  struct ucounts {
> > diff --git a/kernel/user.c b/kernel/user.c
> > index 5235d7f49982..092b2b4d47a6 100644
> > --- a/kernel/user.c
> > +++ b/kernel/user.c
> > @@ -20,6 +20,17 @@
> >  #include <linux/user_namespace.h>
> >  #include <linux/proc_ns.h>
> >  
> > +#if IS_ENABLED(CONFIG_BINFMT_MISC)
> > +struct binfmt_namespace init_binfmt_ns = {
> > +	.entries = LIST_HEAD_INIT(init_binfmt_ns.entries),
> > +	.enabled = 1,
> > +	.entries_lock =
> > __RW_LOCK_UNLOCKED(init_binfmt_ns.entries_lock),
> > +	.bm_mnt = NULL,
> > +	.entry_count = 0,
> > +};
> > +EXPORT_SYMBOL_GPL(init_binfmt_ns);
> > +#endif
> > +
> >  /*
> >   * userns count is 1 for root user, 1 for init_uts_ns,
> >   * and 1 for... ?
> > @@ -67,6 +78,9 @@ struct user_namespace init_user_ns = {
> >  	.keyring_name_list =
> > LIST_HEAD_INIT(init_user_ns.keyring_name_list), .keyring_sem =
> > __RWSEM_INITIALIZER(init_user_ns.keyring_sem), #endif
> > +#if IS_ENABLED(CONFIG_BINFMT_MISC)
> > +	.binfmt_ns = &init_binfmt_ns,
> > +#endif
> >  };
> >  EXPORT_SYMBOL_GPL(init_user_ns);
> >  
> > diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> > index 8eadadc478f9..f42c32269e20 100644
> > --- a/kernel/user_namespace.c
> > +++ b/kernel/user_namespace.c
> > @@ -191,6 +191,9 @@ static void free_user_ns(struct work_struct
> > *work) kfree(ns->projid_map.forward);
> >  			kfree(ns->projid_map.reverse);
> >  		}
> > +#if IS_ENABLED(CONFIG_BINFMT_MISC)
> > +		kfree(ns->binfmt_ns);
> > +#endif
> >  		retire_userns_sysctls(ns);
> >  		key_free_user_ns(ns);
> >  		ns_free_inum(&ns->ns);
> >   
> 

