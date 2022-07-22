Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8FA57D913
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 05:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbiGVDo3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jul 2022 23:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbiGVDo2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jul 2022 23:44:28 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E3B76452
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jul 2022 20:44:26 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-2ef5380669cso35892157b3.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jul 2022 20:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=puv6KQYZaqXR85z5wvkylMHiqN9HYSrVPWoRAapKd+o=;
        b=zW+xYGhpnwuTc3lh4kLFMkShJJjIdesdKLZka4viCvbxVCYBlbkbuVAZO37toEpcMM
         S9meI9g+7HpqNBVmzlZ+xuITh0TvA71WkLXvJUyz0KspWWCFSIXtNEDW77TXyRTcFI9F
         3tHacym7ONILWRsXXXwcKKtxgS4S+qdcvZIb2ZM8WKPn9frOT7FTdSc3XM244dU2XdzH
         zLYRFKmB4MQ/vcMnT0TxMaBk18Ea52k8GYnGJ+P83asQYOGdqX60yT+AMfDpyqLdmZOp
         wYcBIGhmRhWUQ8OTB2akDfrjP5ROLEAhL016553eA+jXzCjeh3voCo3NF+LonahbUj8T
         WJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=puv6KQYZaqXR85z5wvkylMHiqN9HYSrVPWoRAapKd+o=;
        b=OHCQz//puGBvYmGsgd3tNi5MpiMzRUY8hRda+i4wEsPpwEPFaeVK+WUZA2Je7Cxkly
         bCUYdvmKctZtR/DZzfqr20iUlpzOLdMfd6pFCcrt4PRwfcADSmddBUdl/JfnHN6aYTl2
         TWCvqHrhHMrrqMu2QMCFoc50IXZpO674dSXdmNDBofy7zmm3e/dkKSx1HqWyajNmOk5/
         wTmlDJQfHInB7/l2GX8aHzi3w+0WcNU0CZV85cshaCIpb2nerPDjl/AIfNPkrRAVFT4R
         hPiQbmQVgJ/zHTFj/WnIQnxj9LMzoEOhCW6dEQLpztsEWL9lnzrl/EIajoD+hRD2q3yZ
         bOCQ==
X-Gm-Message-State: AJIora8Wd4SRYNXe7NfS7PwovSg5/nimhEr6/wsSNFEWnZZYYXSAXYv7
        1uqgawWfXHu7lAzpJ3pvjT2iVzdNngiAnmQk4WJOOw==
X-Google-Smtp-Source: AGRyM1snbOwx3NX1L9HyAA+TKj3fcab7Fudn6kbA90xmW3pzbx8tFk04sl6OqWAaZ+i5EC0/UAVx6NMccJaPVc3X1is=
X-Received: by 2002:a81:190f:0:b0:31e:66e3:79e0 with SMTP id
 15-20020a81190f000000b0031e66e379e0mr1429927ywz.331.1658461465704; Thu, 21
 Jul 2022 20:44:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220721081617.36103-1-zhangyuchen.lcr@bytedance.com> <Ytl772fRS74eIneC@bombadil.infradead.org>
In-Reply-To: <Ytl772fRS74eIneC@bombadil.infradead.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 22 Jul 2022 11:43:49 +0800
Message-ID: <CAMZfGtXjK2BgpwTOGsWdKs9-3i0X9ohdbXJk=0DAmpEKUymS5w@mail.gmail.com>
Subject: Re: [RFC] proc: fix create timestamp of files in proc
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Zhang Yuchen <zhangyuchen.lcr@bytedance.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Christoph Hellwig <hch@lst.de>, linux-api@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 22, 2022 at 12:16 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Thu, Jul 21, 2022 at 04:16:17PM +0800, Zhang Yuchen wrote:
> > A user has reported a problem that the /proc/{pid} directory
> > creation timestamp is incorrect.
>
> The directory?
>
> > He believes that the directory was created when the process was
> > started, so the timestamp of the directory creation should also
> > be when the process was created.
>
> A quick glance at Documentation/filesystems/proc.rst reveals there
> is documentation that the process creation time is the start_time in
> the stat file for the pid. It makes absolutely no mention of the
> directory creation time.
>

Hi Luis,

Right.

> The directory creation time has been the way it is since linux history [0]
> commit fdb2f0a59a1c7 ("[PATCH] Linux-0.97.3 (September 5, 1992)) and so this
> has been the way .. since the beginning.
>
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/
>
> The last change was by Deepa to correct y2038 considerations through
> commit 078cd8279e659 ("fs: Replace CURRENT_TIME with current_time() for
> inode timestamps").
>
> Next time you try to report something like this please be very sure
> to learn to use git blame, and then git blame foo.c <commit-id>~1 and
> keep doing this until you get to the root commit, this will let you
> determine *how long has this been this way*. When you run into a
> commit history which lands to the first git commit on linux you can
> use the above linux history.git to go back further as I did.
>

A good instruction for a newbie.

> > The file timestamp in procfs is the timestamp when the inode was
> > created. If the inode of a file in procfs is reclaimed, the inode
> > will be recreated when it is opened again, and the timestamp will
> > be changed to the time when it was recreated.
>
> The commit log above starts off with a report of the directory
> of a PID. When does the directory of a PID change dates when its
> respective start_time does not? When does this reclaim happen exactly?
> Under what situation?
>

IMHO, when the system is under memory pressure, then the proc
inode can be reclaimed, it is also true when we `echo 3 >
/proc/sys/vm/drop_caches`. After this operation, the proc inode's
timestamp is changed.

> And if that is not happening, can you name *one* file in a process
> directory under proc which does get reclaimed for, for which this
> does happen?
>
> > In other file systems, this timestamp is typically recorded in
> > the file system and assigned to the inode when the inode is created.
>
> I don't understand, which files are we reclaiming in procfs which
> get re-recreated which your *user* is having issues with? What did
> they report exactly, I'm *super* curious what your user reported
> exactly. Do you have a bug report somewhere? Or any information
> about its bug report. Can you pass it on to Muchun for peer review?
> What file were they monitoring and what tool were they using which
> made them realize there was a sort of issue?
>
> > This mechanism can be confusing to users who are not familiar with it.
>
> Why are they monitoring it? Why would a *new* inode having a different
> timestamp be an issue as per existing documentation?
>

Maybe the users think the timestamp of /proc/$pid directory is equal to
the start_time of a process, I think it is because of a comment of
shortage about the meaning of the timestamp of /proc files.

> > For users who know this mechanism, they will choose not to trust this time.
> > So the timestamp now has no meaning other than to confuse the user.
>
> That is unfair given this is the first *user* to report confusion since
> the inception of Linux, don't you think?
>
> > It needs fixing.
>
> A fix is for when there is an issue. You are not reporting a bug or an
> issue, but you seem to be reporting something a confused user sees and
> perhaps lack of documentation for something which is not even tracked
> or cared for. This is the way things have been done since the beginning.
> It doesn't mean things can't change, but there needs to be a good reason.
>
> The terminology of "fix" implies something is broken. The only thing
> seriouly broken here is this patch you are suggesting and the mechanism
> which is enabling you to send patches for what you think are issues and
> seriously wasting people's time. That seriously needs to be fixed.
>
> > There are three solutions. We don't have to make the timestamp
> > meaningful, as long as the user doesn't trust the timestamp.
> >
> > 1. Add to the kernel documentation that the timestamp in PROC is
> >    not reliable and do not use this timestamp.
> >    The problem with this solution is that most users don't read
> >    the kernel documentation and it can still be misleading.
> >
> > 2. Fix it, change the timestamp of /proc/pid to the timestamp of
> >    process creation.
> >
> >    This raises new questions.
> >
> >    a. Users don't know which kernel version is correct.
> >
> >    b. This problem exists not only in the pid directory, but also
> >       in other directories under procfs. It would take a lot of
> >       extra work to fix them all. There are also easier ways for
> >       users to get the creation time information better than this.
> >
> >    c. We need to describe the specific meaning of each file under
> >       proc in the kernel documentation for the creation time.
> >       Because the creation time of various directories has different
> >       meanings. For example, PID directory is the process creation
> >       time, FD directory is the FD creation time and so on.
> >
> >    d. Some files have no associated entity, such as iomem.
> >       Unable to give a meaningful time.
> >
> > 3. Instead of fixing it, set the timestamp in all procfs to 0.
> >    Users will see it as an error and will not use it.
> >
> > I think 3 is better. Any other suggestions?
> >
> > Signed-off-by: Zhang Yuchen <zhangyuchen.lcr@bytedance.com>
>
> The logic behind this patch is way off track, a little effort
> alone should have made you reach similar conflusions as I have.
> Your patch does your suggested step 3), so no way! What you are
> proposing can potentially break things! Have you put some effort
> into evaluating the negative possible impacts of your patch? If
> not, can you do that now?  Did you even *boot* test your patch?
>
> It makes all of the proc files go dated back to Jan 1 1970.
>
> How can this RFC in any way shape or form have been sent with
> a serious intent?
>
> Sadly the lack of any serious consideration of the past and then
> for you to easily suggest to make a new change which could easily
> break existing users makes me needing to ask you to please have
> one of your peers at bytedance.com such as Muchun Song to please
> review your patches prior to you posting them, because otherwise
> this is creating noise and quite frankly make me wonder if you
> are intentially trying to break things.
>
> Muchun Song, sorry but can you please help here ensure that your
> peers don't post this level of quality of patches again? It would be
> seriously appreciated.
>

It's my bad. Sorry. I should review it carefully. Zhang Yuchen is a newbie
for Linux kernel development, I think he just want to point out the potential
confusion to the users. Yuchen is not sure if this change is the best, I suspect
this is why there is RFC is the patch's subject. I think at least we
should point
it out in Documentation/filesystems/proc.rst so that users can know what does
the timestamp of proc files/directories mean.

Thanks.

> Users exist for years without issue and now you want to change things
> for a user which finds something done which is not documented and want
> to purposely *really* change things for *everyone* to ways which have
> 0 compatibility with what users may have been expecting before.
>
> How can you conclude this?
>
> This suggested patch is quite alarming.
>
>   Luis
>
> Below is just nonsense.
>
> > ---
> >  fs/proc/base.c        | 4 +++-
> >  fs/proc/inode.c       | 3 ++-
> >  fs/proc/proc_sysctl.c | 3 ++-
> >  fs/proc/self.c        | 3 ++-
> >  fs/proc/thread_self.c | 3 ++-
> >  5 files changed, 11 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > index 0b72a6d8aac3..af440ef13091 100644
> > --- a/fs/proc/base.c
> > +++ b/fs/proc/base.c
> > @@ -1892,6 +1892,8 @@ struct inode *proc_pid_make_inode(struct super_block *sb,
> >       struct proc_inode *ei;
> >       struct pid *pid;
> >
> > +     struct timespec64 ts_zero = {0, 0};
> > +
> >       /* We need a new inode */
> >
> >       inode = new_inode(sb);
> > @@ -1902,7 +1904,7 @@ struct inode *proc_pid_make_inode(struct super_block *sb,
> >       ei = PROC_I(inode);
> >       inode->i_mode = mode;
> >       inode->i_ino = get_next_ino();
> > -     inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
> > +     inode->i_mtime = inode->i_atime = inode->i_ctime = ts_zero;
> >       inode->i_op = &proc_def_inode_operations;
> >
> >       /*
> > diff --git a/fs/proc/inode.c b/fs/proc/inode.c
> > index fd40d60169b5..efb1c935fa8d 100644
> > --- a/fs/proc/inode.c
> > +++ b/fs/proc/inode.c
> > @@ -642,6 +642,7 @@ const struct inode_operations proc_link_inode_operations = {
> >  struct inode *proc_get_inode(struct super_block *sb, struct proc_dir_entry *de)
> >  {
> >       struct inode *inode = new_inode(sb);
> > +     struct timespec64 ts_zero = {0, 0};
> >
> >       if (!inode) {
> >               pde_put(de);
> > @@ -650,7 +651,7 @@ struct inode *proc_get_inode(struct super_block *sb, struct proc_dir_entry *de)
> >
> >       inode->i_private = de->data;
> >       inode->i_ino = de->low_ino;
> > -     inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
> > +     inode->i_mtime = inode->i_atime = inode->i_ctime = ts_zero;
> >       PROC_I(inode)->pde = de;
> >       if (is_empty_pde(de)) {
> >               make_empty_dir_inode(inode);
> > diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> > index 021e83fe831f..c670f9d3b871 100644
> > --- a/fs/proc/proc_sysctl.c
> > +++ b/fs/proc/proc_sysctl.c
> > @@ -455,6 +455,7 @@ static struct inode *proc_sys_make_inode(struct super_block *sb,
> >       struct ctl_table_root *root = head->root;
> >       struct inode *inode;
> >       struct proc_inode *ei;
> > +     struct timespec64 ts_zero = {0, 0};
> >
> >       inode = new_inode(sb);
> >       if (!inode)
> > @@ -476,7 +477,7 @@ static struct inode *proc_sys_make_inode(struct super_block *sb,
> >       head->count++;
> >       spin_unlock(&sysctl_lock);
> >
> > -     inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
> > +     inode->i_mtime = inode->i_atime = inode->i_ctime = ts_zero;
> >       inode->i_mode = table->mode;
> >       if (!S_ISDIR(table->mode)) {
> >               inode->i_mode |= S_IFREG;
> > diff --git a/fs/proc/self.c b/fs/proc/self.c
> > index 72cd69bcaf4a..b9e572fdc27c 100644
> > --- a/fs/proc/self.c
> > +++ b/fs/proc/self.c
> > @@ -44,9 +44,10 @@ int proc_setup_self(struct super_block *s)
> >       self = d_alloc_name(s->s_root, "self");
> >       if (self) {
> >               struct inode *inode = new_inode(s);
> > +             struct timespec64 ts_zero = {0, 0};
> >               if (inode) {
> >                       inode->i_ino = self_inum;
> > -                     inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
> > +                     inode->i_mtime = inode->i_atime = inode->i_ctime = ts_zero;
> >                       inode->i_mode = S_IFLNK | S_IRWXUGO;
> >                       inode->i_uid = GLOBAL_ROOT_UID;
> >                       inode->i_gid = GLOBAL_ROOT_GID;
> > diff --git a/fs/proc/thread_self.c b/fs/proc/thread_self.c
> > index a553273fbd41..964966387da2 100644
> > --- a/fs/proc/thread_self.c
> > +++ b/fs/proc/thread_self.c
> > @@ -44,9 +44,10 @@ int proc_setup_thread_self(struct super_block *s)
> >       thread_self = d_alloc_name(s->s_root, "thread-self");
> >       if (thread_self) {
> >               struct inode *inode = new_inode(s);
> > +             struct timespec64 ts_zero = {0, 0};
> >               if (inode) {
> >                       inode->i_ino = thread_self_inum;
> > -                     inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
> > +                     inode->i_mtime = inode->i_atime = inode->i_ctime = ts_zero;
> >                       inode->i_mode = S_IFLNK | S_IRWXUGO;
> >                       inode->i_uid = GLOBAL_ROOT_UID;
> >                       inode->i_gid = GLOBAL_ROOT_GID;
> > --
> > 2.30.2
> >
