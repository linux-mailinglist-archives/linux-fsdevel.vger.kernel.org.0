Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5827757D14A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jul 2022 18:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbiGUQSP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jul 2022 12:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbiGUQR0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jul 2022 12:17:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97641EAD0;
        Thu, 21 Jul 2022 09:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WgzZa30sO+MTxtlA0G94jkaG79sJrQmGOgNm2L7+a4M=; b=G488QPpAKdPaCXlw2obmqR+nGs
        NvfabYxXM4ZkKo3kBSH7a3JJkXYXPjgnhNjKd437BaEQyUCAk1bv03U85k5IfLYHa0EXI9/SVHf7v
        K8ro5wxfUW2Y/af4rDz2ZHi0FFX0T1AR5XIlDW1ah6XTivivF13xRtxT7vjayOSrJqVxZ0GAe6NLa
        aOQJ6zEdMveM7HszD2oeCnlbRzs5skq32IgThd9aOjhbqlr63J7ENEZ0spLU70yDsA5m+eukzPg3d
        r7GgRmIXtid+rjtKILjEdgGEJk7xPw5AGJi0lmsDJysRBpwQY8rKgR8hJWoqfwgcB7CuYdGIvq3qb
        wTqy5grw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEYr1-009my1-T0; Thu, 21 Jul 2022 16:16:47 +0000
Date:   Thu, 21 Jul 2022 09:16:47 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Zhang Yuchen <zhangyuchen.lcr@bytedance.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Muchun Song <songmuchun@bytedance.com>,
        linux-api@vger.kernel.org
Cc:     keescook@chromium.org, yzaikin@google.com,
        songmuchun@bytedance.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] proc: fix create timestamp of files in proc
Message-ID: <Ytl772fRS74eIneC@bombadil.infradead.org>
References: <20220721081617.36103-1-zhangyuchen.lcr@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721081617.36103-1-zhangyuchen.lcr@bytedance.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 21, 2022 at 04:16:17PM +0800, Zhang Yuchen wrote:
> A user has reported a problem that the /proc/{pid} directory
> creation timestamp is incorrect.

The directory?

> He believes that the directory was created when the process was
> started, so the timestamp of the directory creation should also
> be when the process was created.

A quick glance at Documentation/filesystems/proc.rst reveals there
is documentation that the process creation time is the start_time in
the stat file for the pid. It makes absolutely no mention of the
directory creation time.

The directory creation time has been the way it is since linux history [0]
commit fdb2f0a59a1c7 ("[PATCH] Linux-0.97.3 (September 5, 1992)) and so this
has been the way .. since the beginning.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/

The last change was by Deepa to correct y2038 considerations through
commit 078cd8279e659 ("fs: Replace CURRENT_TIME with current_time() for
inode timestamps").

Next time you try to report something like this please be very sure
to learn to use git blame, and then git blame foo.c <commit-id>~1 and
keep doing this until you get to the root commit, this will let you
determine *how long has this been this way*. When you run into a
commit history which lands to the first git commit on linux you can
use the above linux history.git to go back further as I did.

> The file timestamp in procfs is the timestamp when the inode was
> created. If the inode of a file in procfs is reclaimed, the inode
> will be recreated when it is opened again, and the timestamp will
> be changed to the time when it was recreated.

The commit log above starts off with a report of the directory
of a PID. When does the directory of a PID change dates when its
respective start_time does not? When does this reclaim happen exactly?
Under what situation?

And if that is not happening, can you name *one* file in a process
directory under proc which does get reclaimed for, for which this
does happen?

> In other file systems, this timestamp is typically recorded in
> the file system and assigned to the inode when the inode is created.

I don't understand, which files are we reclaiming in procfs which
get re-recreated which your *user* is having issues with? What did
they report exactly, I'm *super* curious what your user reported
exactly. Do you have a bug report somewhere? Or any information
about its bug report. Can you pass it on to Muchun for peer review?
What file were they monitoring and what tool were they using which
made them realize there was a sort of issue?

> This mechanism can be confusing to users who are not familiar with it.

Why are they monitoring it? Why would a *new* inode having a different
timestamp be an issue as per existing documentation?

> For users who know this mechanism, they will choose not to trust this time.
> So the timestamp now has no meaning other than to confuse the user.

That is unfair given this is the first *user* to report confusion since
the inception of Linux, don't you think?

> It needs fixing.

A fix is for when there is an issue. You are not reporting a bug or an
issue, but you seem to be reporting something a confused user sees and
perhaps lack of documentation for something which is not even tracked
or cared for. This is the way things have been done since the beginning.
It doesn't mean things can't change, but there needs to be a good reason.

The terminology of "fix" implies something is broken. The only thing
seriouly broken here is this patch you are suggesting and the mechanism
which is enabling you to send patches for what you think are issues and
seriously wasting people's time. That seriously needs to be fixed.

> There are three solutions. We don't have to make the timestamp
> meaningful, as long as the user doesn't trust the timestamp.
> 
> 1. Add to the kernel documentation that the timestamp in PROC is
>    not reliable and do not use this timestamp.
>    The problem with this solution is that most users don't read
>    the kernel documentation and it can still be misleading.
> 
> 2. Fix it, change the timestamp of /proc/pid to the timestamp of
>    process creation.
> 
>    This raises new questions.
> 
>    a. Users don't know which kernel version is correct.
> 
>    b. This problem exists not only in the pid directory, but also
>       in other directories under procfs. It would take a lot of
>       extra work to fix them all. There are also easier ways for
>       users to get the creation time information better than this.
> 
>    c. We need to describe the specific meaning of each file under
>       proc in the kernel documentation for the creation time.
>       Because the creation time of various directories has different
>       meanings. For example, PID directory is the process creation
>       time, FD directory is the FD creation time and so on.
> 
>    d. Some files have no associated entity, such as iomem.
>       Unable to give a meaningful time.
> 
> 3. Instead of fixing it, set the timestamp in all procfs to 0.
>    Users will see it as an error and will not use it.
> 
> I think 3 is better. Any other suggestions?
>
> Signed-off-by: Zhang Yuchen <zhangyuchen.lcr@bytedance.com>

The logic behind this patch is way off track, a little effort
alone should have made you reach similar conflusions as I have.
Your patch does your suggested step 3), so no way! What you are
proposing can potentially break things! Have you put some effort
into evaluating the negative possible impacts of your patch? If
not, can you do that now?  Did you even *boot* test your patch?

It makes all of the proc files go dated back to Jan 1 1970.

How can this RFC in any way shape or form have been sent with
a serious intent?

Sadly the lack of any serious consideration of the past and then
for you to easily suggest to make a new change which could easily
break existing users makes me needing to ask you to please have
one of your peers at bytedance.com such as Muchun Song to please
review your patches prior to you posting them, because otherwise
this is creating noise and quite frankly make me wonder if you
are intentially trying to break things.

Muchun Song, sorry but can you please help here ensure that your
peers don't post this level of quality of patches again? It would be
seriously appreciated.

Users exist for years without issue and now you want to change things
for a user which finds something done which is not documented and want
to purposely *really* change things for *everyone* to ways which have
0 compatibility with what users may have been expecting before.

How can you conclude this?

This suggested patch is quite alarming.

  Luis

Below is just nonsense.

> ---
>  fs/proc/base.c        | 4 +++-
>  fs/proc/inode.c       | 3 ++-
>  fs/proc/proc_sysctl.c | 3 ++-
>  fs/proc/self.c        | 3 ++-
>  fs/proc/thread_self.c | 3 ++-
>  5 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 0b72a6d8aac3..af440ef13091 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -1892,6 +1892,8 @@ struct inode *proc_pid_make_inode(struct super_block *sb,
>  	struct proc_inode *ei;
>  	struct pid *pid;
>  
> +	struct timespec64 ts_zero = {0, 0};
> +
>  	/* We need a new inode */
>  
>  	inode = new_inode(sb);
> @@ -1902,7 +1904,7 @@ struct inode *proc_pid_make_inode(struct super_block *sb,
>  	ei = PROC_I(inode);
>  	inode->i_mode = mode;
>  	inode->i_ino = get_next_ino();
> -	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
> +	inode->i_mtime = inode->i_atime = inode->i_ctime = ts_zero;
>  	inode->i_op = &proc_def_inode_operations;
>  
>  	/*
> diff --git a/fs/proc/inode.c b/fs/proc/inode.c
> index fd40d60169b5..efb1c935fa8d 100644
> --- a/fs/proc/inode.c
> +++ b/fs/proc/inode.c
> @@ -642,6 +642,7 @@ const struct inode_operations proc_link_inode_operations = {
>  struct inode *proc_get_inode(struct super_block *sb, struct proc_dir_entry *de)
>  {
>  	struct inode *inode = new_inode(sb);
> +	struct timespec64 ts_zero = {0, 0};
>  
>  	if (!inode) {
>  		pde_put(de);
> @@ -650,7 +651,7 @@ struct inode *proc_get_inode(struct super_block *sb, struct proc_dir_entry *de)
>  
>  	inode->i_private = de->data;
>  	inode->i_ino = de->low_ino;
> -	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
> +	inode->i_mtime = inode->i_atime = inode->i_ctime = ts_zero;
>  	PROC_I(inode)->pde = de;
>  	if (is_empty_pde(de)) {
>  		make_empty_dir_inode(inode);
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index 021e83fe831f..c670f9d3b871 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -455,6 +455,7 @@ static struct inode *proc_sys_make_inode(struct super_block *sb,
>  	struct ctl_table_root *root = head->root;
>  	struct inode *inode;
>  	struct proc_inode *ei;
> +	struct timespec64 ts_zero = {0, 0};
>  
>  	inode = new_inode(sb);
>  	if (!inode)
> @@ -476,7 +477,7 @@ static struct inode *proc_sys_make_inode(struct super_block *sb,
>  	head->count++;
>  	spin_unlock(&sysctl_lock);
>  
> -	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
> +	inode->i_mtime = inode->i_atime = inode->i_ctime = ts_zero;
>  	inode->i_mode = table->mode;
>  	if (!S_ISDIR(table->mode)) {
>  		inode->i_mode |= S_IFREG;
> diff --git a/fs/proc/self.c b/fs/proc/self.c
> index 72cd69bcaf4a..b9e572fdc27c 100644
> --- a/fs/proc/self.c
> +++ b/fs/proc/self.c
> @@ -44,9 +44,10 @@ int proc_setup_self(struct super_block *s)
>  	self = d_alloc_name(s->s_root, "self");
>  	if (self) {
>  		struct inode *inode = new_inode(s);
> +		struct timespec64 ts_zero = {0, 0};
>  		if (inode) {
>  			inode->i_ino = self_inum;
> -			inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
> +			inode->i_mtime = inode->i_atime = inode->i_ctime = ts_zero;
>  			inode->i_mode = S_IFLNK | S_IRWXUGO;
>  			inode->i_uid = GLOBAL_ROOT_UID;
>  			inode->i_gid = GLOBAL_ROOT_GID;
> diff --git a/fs/proc/thread_self.c b/fs/proc/thread_self.c
> index a553273fbd41..964966387da2 100644
> --- a/fs/proc/thread_self.c
> +++ b/fs/proc/thread_self.c
> @@ -44,9 +44,10 @@ int proc_setup_thread_self(struct super_block *s)
>  	thread_self = d_alloc_name(s->s_root, "thread-self");
>  	if (thread_self) {
>  		struct inode *inode = new_inode(s);
> +		struct timespec64 ts_zero = {0, 0};
>  		if (inode) {
>  			inode->i_ino = thread_self_inum;
> -			inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
> +			inode->i_mtime = inode->i_atime = inode->i_ctime = ts_zero;
>  			inode->i_mode = S_IFLNK | S_IRWXUGO;
>  			inode->i_uid = GLOBAL_ROOT_UID;
>  			inode->i_gid = GLOBAL_ROOT_GID;
> -- 
> 2.30.2
> 
