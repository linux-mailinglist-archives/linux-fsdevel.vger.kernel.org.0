Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8526F177B29
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 16:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbgCCPzY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 10:55:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:33712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729577AbgCCPzY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 10:55:24 -0500
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5559120866;
        Tue,  3 Mar 2020 15:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583250924;
        bh=UGdXaHoMkI2mtHF9nsoYia1Fwcd76iZNyx5ZnrXedcs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YRoJVFSMzPTj9B2dJX4KD2NQin2bjap4pJVp8rJ8uAh6LBsdaBe/1PynQjLhWWiLh
         obdqnCWGgryQKoLQlxaXFBROkTja7CF4CCKuZnIDQV5b+Nn+i/HrhjdiIakEeZ/SWJ
         8TIuiuYMzO4bbn6F4huLsKk+4MC3QFyfkslK4ztU=
Message-ID: <e06d74ad7dc02fb3df9ab4ae26203a85ea2ed67e.camel@kernel.org>
Subject: Re: [PATCH] fcntl: Distribute switch variables for initialization
From:   Jeff Layton <jlayton@kernel.org>
To:     Kees Cook <keescook@chromium.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Alexander Potapenko <glider@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 03 Mar 2020 10:55:22 -0500
In-Reply-To: <202003022040.40A32072@keescook>
References: <20200220062243.68809-1-keescook@chromium.org>
         <202003022040.40A32072@keescook>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-03-02 at 20:41 -0800, Kees Cook wrote:
> On Wed, Feb 19, 2020 at 10:22:43PM -0800, Kees Cook wrote:
> > Variables declared in a switch statement before any case statements
> > cannot be automatically initialized with compiler instrumentation (as
> > they are not part of any execution flow). With GCC's proposed automatic
> > stack variable initialization feature, this triggers a warning (and they
> > don't get initialized). Clang's automatic stack variable initialization
> > (via CONFIG_INIT_STACK_ALL=y) doesn't throw a warning, but it also
> > doesn't initialize such variables[1]. Note that these warnings (or silent
> > skipping) happen before the dead-store elimination optimization phase,
> > so even when the automatic initializations are later elided in favor of
> > direct initializations, the warnings remain.
> > 
> > To avoid these problems, move such variables into the "case" where
> > they're used or lift them up into the main function body.
> > 
> > fs/fcntl.c: In function ‘send_sigio_to_task’:
> > fs/fcntl.c:738:20: warning: statement will never be executed [-Wswitch-unreachable]
> >   738 |   kernel_siginfo_t si;
> >       |                    ^~
> > 
> > [1] https://bugs.llvm.org/show_bug.cgi?id=44916
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Ping. Can someone pick this up, please?
> 
> Thanks!
> 
> -Kees
> 
> > ---
> >  fs/fcntl.c |    6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/fcntl.c b/fs/fcntl.c
> > index 9bc167562ee8..2e4c0fa2074b 100644
> > --- a/fs/fcntl.c
> > +++ b/fs/fcntl.c
> > @@ -735,8 +735,9 @@ static void send_sigio_to_task(struct task_struct *p,
> >  		return;
> >  
> >  	switch (signum) {
> > -		kernel_siginfo_t si;
> > -		default:
> > +		default: {
> > +			kernel_siginfo_t si;
> > +
> >  			/* Queue a rt signal with the appropriate fd as its
> >  			   value.  We use SI_SIGIO as the source, not 
> >  			   SI_KERNEL, since kernel signals always get 
> > @@ -769,6 +770,7 @@ static void send_sigio_to_task(struct task_struct *p,
> >  			si.si_fd    = fd;
> >  			if (!do_send_sig_info(signum, &si, p, type))
> >  				break;
> > +		}
> >  		/* fall-through - fall back on the old plain SIGIO signal */
> >  		case 0:
> >  			do_send_sig_info(SIGIO, SEND_SIG_PRIV, p, type);
> > 

Sure, looks straightforward enough. I'll pick it up for v5.7.

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>

