Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE3881D5A94
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 22:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgEOUOY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 16:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbgEOUOY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 16:14:24 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CA9C061A0C;
        Fri, 15 May 2020 13:14:23 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZgiT-009GPf-NM; Fri, 15 May 2020 20:13:57 +0000
Date:   Fri, 15 May 2020 21:13:57 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Alexey Gladkov <gladkov.alexey@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        syzbot <syzbot+c1af344512918c61362c@syzkaller.appspotmail.com>,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, linux-security-module@vger.kernel.org,
        serge@hallyn.com, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: linux-next boot error: general protection fault in
 tomoyo_get_local_path
Message-ID: <20200515201357.GG23230@ZenIV.linux.org.uk>
References: <0000000000002f0c7505a5b0e04c@google.com>
 <c3461e26-1407-2262-c709-dac0df3da2d0@i-love.sakura.ne.jp>
 <72cb7aea-92bd-d71b-2f8a-63881a35fad8@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72cb7aea-92bd-d71b-2f8a-63881a35fad8@i-love.sakura.ne.jp>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 16, 2020 at 12:36:28AM +0900, Tetsuo Handa wrote:
> On 2020/05/16 0:18, Tetsuo Handa wrote:
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
> > 
> 
> A similar bug (racing inode destruction with open() on proc filesystem) was fixed as
> commit 6f7c41374b62fd80 ("tomoyo: Don't use nifty names on sockets."). Then, it might
> not be safe to replace dentry->d_sb->s_fs_info with dentry->d_inode->i_sb->s_fs_info .

Could you explain why do you want to bother with d_inode() anyway?  Anything that
does dentry->d_inode->i_sb can bloody well use dentry->d_sb.  And that's never
changed over the struct dentry lifetime - ->d_sb is set on allocation and never
modified afterwards.
