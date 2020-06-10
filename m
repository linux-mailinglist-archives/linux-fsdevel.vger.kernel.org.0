Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6211F5AB7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 19:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgFJRmC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 13:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgFJRmC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 13:42:02 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AB3C03E96B;
        Wed, 10 Jun 2020 10:42:02 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jj4jY-006YSx-Ps; Wed, 10 Jun 2020 17:41:52 +0000
Date:   Wed, 10 Jun 2020 18:41:52 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Alexey Gladkov <gladkov.alexey@gmail.com>,
        syzbot <syzbot+4abac52934a48af5ff19@syzkaller.appspotmail.com>,
        adobriyan@gmail.com, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] proc: s_fs_info may be NULL when proc_kill_sb is called
Message-ID: <20200610174152.GS23230@ZenIV.linux.org.uk>
References: <0000000000002d7ca605a7b8b1c5@google.com>
 <20200610130422.1197386-1-gladkov.alexey@gmail.com>
 <87mu5azvxl.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mu5azvxl.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 10, 2020 at 12:12:54PM -0500, Eric W. Biederman wrote:

> >  {
> >  	struct proc_fs_info *fs_info = proc_sb_info(sb);
> >  
> > -	if (fs_info->proc_self)
> > -		dput(fs_info->proc_self);
> > +	if (fs_info) {
> > +		if (fs_info->proc_self)
> > +			dput(fs_info->proc_self);
> >  
> > -	if (fs_info->proc_thread_self)
> > -		dput(fs_info->proc_thread_self);
> > +		if (fs_info->proc_thread_self)
> > +			dput(fs_info->proc_thread_self);
> > +
> > +		put_pid_ns(fs_info->pid_ns);
> > +		kfree(fs_info);

While we are at it, dput(NULL) is an explicit no-op.
