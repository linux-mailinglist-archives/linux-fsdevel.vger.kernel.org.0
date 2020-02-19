Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 309C9163A39
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 03:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgBSCdq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 21:33:46 -0500
Received: from mail.hallyn.com ([178.63.66.53]:49412 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726799AbgBSCdq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 21:33:46 -0500
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id DB1D4F8F; Tue, 18 Feb 2020 20:33:43 -0600 (CST)
Date:   Tue, 18 Feb 2020 20:33:43 -0600
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>,
        smbarber@chromium.org, Seth Forshee <seth.forshee@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Phil Estes <estesp@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v3 03/25] proc: add /proc/<pid>/fsgid_map
Message-ID: <20200219023343.GC19144@mail.hallyn.com>
References: <20200218143411.2389182-1-christian.brauner@ubuntu.com>
 <20200218143411.2389182-4-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218143411.2389182-4-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 03:33:49PM +0100, Christian Brauner wrote:
> The /proc/<pid>/fsgid_map file can be written once to setup an fsgid mapping
> for a user namespace. Writing to this file has the same restrictions as writing
> to /proc/<pid>/fsgid_map.
> 
> root@e1-vm:/# cat /proc/13023/fsgid_map
>          0     300000     100000
> 
> Fsid mappings have always been around. They are currently always identical to
> the id mappings for a user namespace. This means, currently whenever an fsid
> needs to be looked up the kernel will use the id mapping of the user namespace.
> With the introduction of fsid mappings the kernel will now lookup fsids in the
> fsid mappings of the user namespace. If no fsid mapping exists the kernel will
> continue looking up fsids in the id mappings of the user namespace. Hence, if a
> system supports fsid mappings through /proc/<pid>/fs*id_map and a container
> runtime is not aware of fsid mappings it or does not use them it will it will
> continue to work just as before.
> 
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Acked-by: Serge Hallyn <serge@hallyn.com>

> ---
> /* v2 */
> unchanged
> 
> /* v3 */
> - Christian Brauner <christian.brauner@ubuntu.com>:
>   - Fix grammar in commit message.
> ---
>  fs/proc/base.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 5fb28004663e..1303cdd2e617 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2975,6 +2975,11 @@ static int proc_fsuid_map_open(struct inode *inode, struct file *file)
>  {
>  	return proc_id_map_open(inode, file, &proc_fsuid_seq_operations);
>  }
> +
> +static int proc_fsgid_map_open(struct inode *inode, struct file *file)
> +{
> +	return proc_id_map_open(inode, file, &proc_fsgid_seq_operations);
> +}
>  #endif
>  
>  static const struct file_operations proc_uid_map_operations = {
> @@ -3009,6 +3014,14 @@ static const struct file_operations proc_fsuid_map_operations = {
>  	.llseek		= seq_lseek,
>  	.release	= proc_id_map_release,
>  };
> +
> +static const struct file_operations proc_fsgid_map_operations = {
> +	.open		= proc_fsgid_map_open,
> +	.write		= proc_fsgid_map_write,
> +	.read		= seq_read,
> +	.llseek		= seq_lseek,
> +	.release	= proc_id_map_release,
> +};
>  #endif
>  
>  static int proc_setgroups_open(struct inode *inode, struct file *file)
> @@ -3195,6 +3208,7 @@ static const struct pid_entry tgid_base_stuff[] = {
>  #ifdef CONFIG_USER_NS
>  #ifdef CONFIG_USER_NS_FSID
>  	REG("fsuid_map",  S_IRUGO|S_IWUSR, proc_fsuid_map_operations),
> +	REG("fsgid_map",  S_IRUGO|S_IWUSR, proc_fsgid_map_operations),
>  #endif
>  	REG("uid_map",    S_IRUGO|S_IWUSR, proc_uid_map_operations),
>  	REG("gid_map",    S_IRUGO|S_IWUSR, proc_gid_map_operations),
> -- 
> 2.25.0
