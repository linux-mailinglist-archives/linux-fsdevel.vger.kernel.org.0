Return-Path: <linux-fsdevel+bounces-12616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2974861B03
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 18:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 523EB1F270C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 17:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE41D142636;
	Fri, 23 Feb 2024 17:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FULkRoDK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CC712D758;
	Fri, 23 Feb 2024 17:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708711188; cv=none; b=QsR0D0u2S0Ih2wRO1twIh8PqargRk7PRZYIb1/x+FpqVUhsr0pmGgX4oqXGZwqK4dSkUV5V1t8jQ3MC9QCkVrYH7UhpZUmHS1Jsrs+zT1bzxJzBS5/kW6C5Bzbuup3OO1q4+FZabIWSKhZjCH8VPi5E+ERMvpI8/B3gA2XyPqu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708711188; c=relaxed/simple;
	bh=yjXKXlzIT1gS1GoeXj15BtCc2qSvC775H+yC8jnLqww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fuI6dIEaDat3ZCSS+7Qe4IZmTaPOBr0CZJt/omlk8MIGBELBStGXmEvm9LD80VTYA/YyCrlIfC5QaKwFiOMOk1aRvXcuuyABfKmyDSXDH7/9GPu2G6g1GO8pGWqYa+xRTn3OH6ySFiVtHlP7Is9OkWLHc0OV/HwSXpaUhX+F6u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FULkRoDK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08251C433C7;
	Fri, 23 Feb 2024 17:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708711188;
	bh=yjXKXlzIT1gS1GoeXj15BtCc2qSvC775H+yC8jnLqww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FULkRoDKMSrCWza4BnlTCzKFl3yhaQG4xGFUjbVFHaCW+VMyxap32BZ6g5AfzLWMI
	 XMeHBeyya0ApZwYynz3BiFeUU3mcbdoTEIysAOvrKL0mmnJXiBgu+4wK2H5JebeZlH
	 NuOTWajjr+muLscVkoXNLXxV06bejNEC+o9He6MQvcByxc79GMX2TP0VXLrAEt7Dk0
	 1fubcHYEpEilPLWIorFZl6EXX5xOeOGhFSCT+ms+/iJ4ctyozGp/Rx0OcexZtFeaBn
	 IpS9+j2bra3rkhCh6EhzLP8HVEQir/R17BYLlX9KIDaWQ3MLpdootiterrg25LfQvp
	 w/TBjq1uGOUow==
Date: Fri, 23 Feb 2024 09:59:46 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, chandan.babu@oracle.com,
	djwong@kernel.org
Subject: Re: [PATCH v4 05/25] fs: add FS_XFLAG_VERITY for verity files
Message-ID: <20240223175946.GB1112@sol.localdomain>
References: <20240212165821.1901300-1-aalbersh@redhat.com>
 <20240212165821.1901300-6-aalbersh@redhat.com>
 <20240223042304.GA25631@sol.localdomain>
 <ck7uzvtsfxikgpvdxw5mwvds5gq2errja7qhru7liy5akijcdg@rlodrbskdprz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ck7uzvtsfxikgpvdxw5mwvds5gq2errja7qhru7liy5akijcdg@rlodrbskdprz>

On Fri, Feb 23, 2024 at 01:55:21PM +0100, Andrey Albershteyn wrote:
> On 2024-02-22 20:23:04, Eric Biggers wrote:
> > On Mon, Feb 12, 2024 at 05:58:02PM +0100, Andrey Albershteyn wrote:
> > > +FS_IOC_FSGETXATTR
> > > +-----------------
> > > +
> > > +Since Linux v6.9, FS_XFLAG_VERITY (0x00020000) file attribute is set for verity
> > > +files. The attribute can be observed via lsattr.
> > > +
> > > +    [root@vm:~]# lsattr /mnt/test/foo
> > > +    --------------------V- /mnt/test/foo
> > > +
> > > +Note that this attribute cannot be set with FS_IOC_FSSETXATTR as enabling verity
> > > +requires input parameters. See FS_IOC_ENABLE_VERITY.
> > 
> > The lsattr example is irrelevant and misleading because lsattr uses
> > FS_IOC_GETFLAGS, not FS_IOC_FSGETXATTR.
> > 
> > Also, I know that you titled the subsection "FS_IOC_FSGETXATTR", but the text
> > itself should make it super clear that FS_XFLAG_VERITY is only for
> > FS_IOC_FSGETXATTR, not FS_IOC_GETFLAGS.
> 
> Sure, I will remove the example. Would something like this be clear
> enough?
> 
>     FS_IOC_FSGETXATTR
>     -----------------
> 
>     Since Linux v6.9, FS_XFLAG_VERITY (0x00020000) file attribute is set for verity
>     files. This attribute can be checked with FS_IOC_FSGETXATTR ioctl. Note that
>     this attribute cannot be set with FS_IOC_FSSETXATTR as enabling verity requires
>     input parameters. See FS_IOC_ENABLE_VERITY.

It's better, but I'd probably put FS_IOC_FSGETXATTR in the first sentence.
Like: Since Linux v6.9, the FS_IOC_FSGETXATTR ioctl sets FS_XFLAG_VERITY
(0x00020000) in the returned flags when the file has verity enabled.

- Eric

