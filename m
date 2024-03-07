Return-Path: <linux-fsdevel+bounces-13857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 121DB874CA4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 11:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAA93283831
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 10:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1D5127B69;
	Thu,  7 Mar 2024 10:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACeHsAnb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC9D83CA9
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Mar 2024 10:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709808364; cv=none; b=WQ6AdqU0vCJcbK5kg/SZuX+ueTcaDgR/BWW/EYeqNyXCWU1gyt04XpJU5jXSojrv6isBeZ/F1YuwEmJptsuND0vPDlhGpTIXO2/GM6rQl8myl5o5sglts+gLx1Wf+h8ctb1oGi+d+oOE21aBWB2v848ABeEoxDBujsVs88XclLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709808364; c=relaxed/simple;
	bh=28T7aDiv+0JpHXnY5aFECCvvkSp0ZHPva8vQV4qDAHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ktwf3blZNgm9bZdRN+B15CvseTGtOGPF/1JMaM7C7iYutGPoMSHH3fLAV0jhDBoGwRNIRdmsOA8dWdmaPvHwStoMLDpr2l2+wMDEzbAhj7uptndr2I42JzEgYEYECgJ4f+o2kPQl/ONEOTgWUL3Q8H+C9eRka0WnDIo+zAYb6bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACeHsAnb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F7BC433C7;
	Thu,  7 Mar 2024 10:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709808363;
	bh=28T7aDiv+0JpHXnY5aFECCvvkSp0ZHPva8vQV4qDAHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ACeHsAnb3cwLoFnulFkcinhb7epPaF/c55XZj2m5nQJ1pJvzeLulMFiBH4TZHT1xC
	 BJoT5emLpqWz8rWrQzPSJDnfARaCEscCgcqVewmk4olOZ9nt+pWkuyRpqTpW+17Bw1
	 cfbFx9okRNJVSm7pNXg3bHWTKvJBX3w5vjFRzvYiPEuA7e7UShPJQR7YSJV6N9ALkj
	 nfVtQ+E+lNq++WlX7/IV322774n49W9JIVTw+OKht02y5+W6fcdFQIQwJMtODkqUhE
	 XJmSDJyelW5cCMvWEt/eLgONqafMJ67zo5V74YQgDldsTNlWxC7+MuuXMqnBhobyk0
	 bOF00GwIg/Flg==
Date: Thu, 7 Mar 2024 11:45:59 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Mikulas Patocka <mpatocka@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] tmpfs: don't interrupt fallocate with EINTR
Message-ID: <20240307-kultur-ankam-39d311604493@brauner>
References: <ef5c3b-fcd0-db5c-8d4-eeae79e62267@redhat.com>
 <20240305-abgas-tierzucht-1c60219b7839@brauner>
 <20240306174911.ixwy2kto33cfjueq@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240306174911.ixwy2kto33cfjueq@quack3>

On Wed, Mar 06, 2024 at 06:49:11PM +0100, Jan Kara wrote:
> Hello,
> 
> On Tue 05-03-24 09:42:27, Christian Brauner wrote:
> > On Mon, Mar 04, 2024 at 07:43:39PM +0100, Mikulas Patocka wrote:
> > > I have a program that sets up a periodic timer with 10ms interval. When
> > > the program attempts to call fallocate on tmpfs, it goes into an infinite
> > > loop. fallocate takes longer than 10ms, so it gets interrupted by a
> > > signal and it returns EINTR. On EINTR, the fallocate call is restarted,
> > > going into the same loop again.
> > > 
> > > fallocate(19, FALLOC_FL_KEEP_SIZE, 0, 206057565) = -1 EINTR (Přerušené volání systému)
> > > --- SIGALRM {si_signo=SIGALRM, si_code=SI_TIMER, si_timerid=0, si_overrun=0, si_int=0, si_ptr=NULL} ---
> > > sigreturn({mask=[]})                    = -1 EINTR (Přerušené volání systému)
> > > fallocate(19, FALLOC_FL_KEEP_SIZE, 0, 206057565) = -1 EINTR (Přerušené volání systému)
> > > --- SIGALRM {si_signo=SIGALRM, si_code=SI_TIMER, si_timerid=0, si_overrun=0, si_int=0, si_ptr=NULL} ---
> > > sigreturn({mask=[]})                    = -1 EINTR (Přerušené volání systému)
> > > fallocate(19, FALLOC_FL_KEEP_SIZE, 0, 206057565) = -1 EINTR (Přerušené volání systému)
> > > --- SIGALRM {si_signo=SIGALRM, si_code=SI_TIMER, si_timerid=0, si_overrun=0, si_int=0, si_ptr=NULL} ---
> > > sigreturn({mask=[]})                    = -1 EINTR (Přerušené volání systému)
> > > fallocate(19, FALLOC_FL_KEEP_SIZE, 0, 206057565) = -1 EINTR (Přerušené volání systému)
> > > --- SIGALRM {si_signo=SIGALRM, si_code=SI_TIMER, si_timerid=0, si_overrun=0, si_int=0, si_ptr=NULL} ---
> > > sigreturn({mask=[]})                    = -1 EINTR (Přerušené volání systému)
> > > 
> > > Should there be fatal_signal_pending instead of signal_pending in the
> > > shmem_fallocate loop?
> > > 
> > > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > > 
> > > ---
> > >  mm/shmem.c |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > Index: linux-2.6/mm/shmem.c
> > > ===================================================================
> > > --- linux-2.6.orig/mm/shmem.c	2024-01-18 19:18:31.000000000 +0100
> > > +++ linux-2.6/mm/shmem.c	2024-03-04 19:05:25.000000000 +0100
> > > @@ -3143,7 +3143,7 @@ static long shmem_fallocate(struct file
> > >  		 * Good, the fallocate(2) manpage permits EINTR: we may have
> > >  		 * been interrupted because we are using up too much memory.
> > >  		 */
> > > -		if (signal_pending(current))
> > > +		if (fatal_signal_pending(current))
> > 
> > I think that's likely wrong and probably would cause regressions as
> > there may be users relying on this?
> 
> I understand your concern about userspace regressions but is the EINTR
> behavior that useful? Sure, something can be relying on terminating

I don't know.

> fallocate(2) with any signal but since tmpfs is the only filesystem having

Hugetlbfs has the same logic.

> this behavior, it is fair to say there are even higher chances some
> application will be surprised by this behavior when used on tmpfs as
> Mikulas was? So I wouldn't be that opposed to this change. *But* tmpfs has
> a comment explaining the signal_pending() check:
> 
>                 /*
>                  * Good, the fallocate(2) manpage permits EINTR: we may have
>                  * been interrupted because we are using up too much memory.
>                  */
> 
> Now I'd expect the signal to be fatal in this case but we definitely need
> to make sure this is the case if we want to consider changing the test.

Right now fallocate() is restartable. You could get EINTR and then
retry. Changing this to fatal_signal_pending() would mean that this
property is lost. The task will have to be wiped.

If this is only done for the sake of the OOM killer then we can probably
try and change it. But then we'd need to also reflect that on the
manpage.

