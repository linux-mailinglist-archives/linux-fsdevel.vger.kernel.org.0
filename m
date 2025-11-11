Return-Path: <linux-fsdevel+bounces-67907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6473C4D4C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 12:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30A4742202C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 11:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AA73587D2;
	Tue, 11 Nov 2025 10:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKJFap5K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C4F351FBA;
	Tue, 11 Nov 2025 10:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858594; cv=none; b=AYImdjLGghh9qZSglhDm0l1PirtP+oXN6HVyfAHs0djNHtpwIvL0GQCthCj3DHTcfHu77R3VslXq40TZLZY2gC3gE3rDvZMTSUKYyPwvMbaPw9DqRHt0sGWO7mdUqT7mhfRxwn1I3CMeaTNbzGlLkg7/zzzR1A/ISjj/+ZiDnB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858594; c=relaxed/simple;
	bh=LLE8UQmsCCogkZVKSd1TLbVt9gs72Jh93jqozm60ebU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iec2gDv1rUEBirXI4Jne/94u4LELAMHEsqW8KHQ3BjfAuWxX27xztHAxznbpErv6teiicOkO6nCcp1K2d4E+GDy+wAnAaHKIdGwwxzM/C89fd9heItDFtTNMdFd+ZGqaf9llcw2m+ac/BDHHPyGsFSIVY5LOBQyloQggOoreKZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKJFap5K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313A8C4CEF7;
	Tue, 11 Nov 2025 10:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762858594;
	bh=LLE8UQmsCCogkZVKSd1TLbVt9gs72Jh93jqozm60ebU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YKJFap5K6aImcv2glJeiNMSpxrwhX6LrxJE9jB2o/nF/WyKkn1WH6018FXJoi/UCP
	 kwILmx0XpLJxYnaUhsyl42/On0deramtMNIHMDakZ3XBWX3DBuNSISALizcXkP5J1g
	 As9tysDbaFlf4n4MhlGm4iCSknWQmP/uRA7y3UcgxHHrHNeSX1vdVQgCeGvYZzT/xd
	 4kN6IgSEXZHZeuWLm2Bdu2rfQ3za3HSpRsHwoEVGtapRsGF7Y0ZMbazAjnKP+Hw6s1
	 1ehJojThYLaGzj/AfbW9ZcFiZLxCIHI4qKUiP0ztlFxRlVs0DdQDmb3wCyvyfh4liI
	 CUKpd3rfxq+1w==
Date: Tue, 11 Nov 2025 11:56:27 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Ard Biesheuvel <ardb@kernel.org>, linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	jack@suse.cz, raven@themaw.net, miklos@szeredi.hu, neil@brown.name, 
	a.hindborg@kernel.org, linux-mm@kvack.org, linux-efi@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, kees@kernel.org, rostedt@goodmis.org, gregkh@linuxfoundation.org, 
	linux-usb@vger.kernel.org, paul@paul-moore.com, casey@schaufler-ca.com, 
	linuxppc-dev@lists.ozlabs.org, john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org
Subject: Re: [PATCH v2 22/50] convert efivarfs
Message-ID: <20251111-tolerant-profan-0aff1cc76691@brauner>
References: <20251028210805.GP2441659@ZenIV>
 <CAMj1kXF6tvg6+CL_1x7h0HK1PoSGtxDjc0LQ1abGQBd5qrbffg@mail.gmail.com>
 <9f079d0c8cffb150c0decb673a12bfe1b835efc9.camel@HansenPartnership.com>
 <20251029193755.GU2441659@ZenIV>
 <CAMj1kXHnEq97bzt-C=zKJdV3BK3EDJCPz3Pfyk52p2735-4wFA@mail.gmail.com>
 <20251105-aufheben-ausmusterung-4588dab8c585@brauner>
 <423f5cc5352c54fc21e0570daeeddc4a58e74974.camel@HansenPartnership.com>
 <20251105-sohlen-fenster-e7c5af1204c4@brauner>
 <20251105-vorbild-zutreffen-fe00d1dd98db@brauner>
 <20251109204018.GH2441659@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251109204018.GH2441659@ZenIV>

On Sun, Nov 09, 2025 at 08:40:18PM +0000, Al Viro wrote:
> On Wed, Nov 05, 2025 at 02:43:34PM +0100, Christian Brauner wrote:
> 
> > -static void filesystems_freeze_callback(struct super_block *sb, void *unused)
> > +static void filesystems_freeze_callback(struct super_block *sb, void *bool_freeze_all)
> >  {
> > +	bool freeze_all = *(bool *)bool_freeze_all;
> > +
> >  	if (!sb->s_op->freeze_fs && !sb->s_op->freeze_super)
> >  		return;
> >  
> > +	if (!freeze_all) {
> 
> Minor nitpick: do we even need a dereference here?  Just check
> whether the argument is NULL and adjust the caller...

Yup, sounds good.

