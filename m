Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6EDE1D59FA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 21:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgEOT0L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 15:26:11 -0400
Received: from raptor.unsafe.ru ([5.9.43.93]:50062 "EHLO raptor.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgEOT0K (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 15:26:10 -0400
Received: from comp-core-i7-2640m-0182e6 (ip-89-102-33-211.net.upcbroadband.cz [89.102.33.211])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by raptor.unsafe.ru (Postfix) with ESMTPSA id 4FC8020A0B;
        Fri, 15 May 2020 19:26:05 +0000 (UTC)
Date:   Fri, 15 May 2020 21:25:59 +0200
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot <syzbot+c1af344512918c61362c@syzkaller.appspotmail.com>,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, linux-security-module@vger.kernel.org,
        serge@hallyn.com, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: linux-next boot error: general protection fault in
 tomoyo_get_local_path
Message-ID: <20200515192559.e5ofmmzxdviierkb@comp-core-i7-2640m-0182e6>
References: <0000000000002f0c7505a5b0e04c@google.com>
 <c3461e26-1407-2262-c709-dac0df3da2d0@i-love.sakura.ne.jp>
 <87lfltcbc4.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lfltcbc4.fsf@x220.int.ebiederm.org>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.1 (raptor.unsafe.ru [5.9.43.93]); Fri, 15 May 2020 19:26:08 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 15, 2020 at 01:16:59PM -0500, Eric W. Biederman wrote:
> Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> writes:
> 
> > This is
> >
> >         if (sb->s_magic == PROC_SUPER_MAGIC && *pos == '/') {
> >                 char *ep;
> >                 const pid_t pid = (pid_t) simple_strtoul(pos + 1, &ep, 10);
> >                 struct pid_namespace *proc_pidns = proc_pid_ns(d_inode(dentry)); // <= here
> >
> >                 if (*ep == '/' && pid && pid ==
> >                     task_tgid_nr_ns(current, proc_pidns)) {
> >
> > which was added by commit c59f415a7cb6e1e1 ("Use proc_pid_ns() to get pid_namespace from the proc superblock").
> >
> > @@ -161,9 +162,10 @@ static char *tomoyo_get_local_path(struct dentry *dentry, char * const buffer,
> >         if (sb->s_magic == PROC_SUPER_MAGIC && *pos == '/') {
> >                 char *ep;
> >                 const pid_t pid = (pid_t) simple_strtoul(pos + 1, &ep, 10);
> > +               struct pid_namespace *proc_pidns = proc_pid_ns(d_inode(dentry));
> >
> >                 if (*ep == '/' && pid && pid ==
> > -                   task_tgid_nr_ns(current, sb->s_fs_info)) {
> > +                   task_tgid_nr_ns(current, proc_pidns)) {
> >                         pos = ep - 5;
> >                         if (pos < buffer)
> >                                 goto out;
> >
> > Alexey and Eric, any clue?
> 
> Looking at the stack backtrace this is happening as part of creating a
> file or a device node.  The dentry that is passed in most likely
> comes from d_alloc_parallel.  So we have d_inode == NULL.
> 
> I want to suggest doing the very simple fix:
> 
> -	if (sb->s_magic == PROC_SUPER_MAGIC && *pos == '/') {
> +	if (sb->s_magic == PROC_SUPER_MAGIC && *pos == '/' && denty->d_inode) {
> 
> But I don't know if there are any other security hooks early in lookup,
> that could be called for an already existing dentry.
> 
> So it looks like we need a version proc_pid_ns that works for a dentry,
> or a superblock.
> 
> Alex do you think you can code up an patch against my proc-next branch
> to fix this?

Sure.

-- 
Rgrds, legion

