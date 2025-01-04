Return-Path: <linux-fsdevel+bounces-38390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40ED5A0141C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2025 12:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FC731883AAE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2025 11:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A291BBBCF;
	Sat,  4 Jan 2025 11:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZQtzIi2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289941953BB
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Jan 2025 11:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735990183; cv=none; b=ceG10Qn33NtZ183/vTNo4dHua0lKQJkKoJTu9BZhssVFp5YCk6jcnha3JQcupdiI+mwiN/WQuUxZrSCd9BPG1BlJqawpkho+7uFLO4aDlLWfmPdZTXJapj22m63YcRufgHiYs2Kx/s7NyBNtEU3cdebryR3eh9/ZrhUCaTrvhHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735990183; c=relaxed/simple;
	bh=WSvusGxkP9CIComqoqcMe0McARfsPf9dGEDG3vMNNwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SceRoKymRFunelp8BnBSO0yL2rjRfnUGH/Qlsk3i4IbIUJEB7TiPVhqTSn3Cj3tK52p9WO4oPhUyksrqfGmQSOSr1myh1AHoQTe5bZfEKJedYiH+nGWs0xzqyQ1X+m4tc1BEYNa0Kuw7eneCk3oRt8/BW6KNJ5VUO4IhI3y5tJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZQtzIi2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0207C4CED1;
	Sat,  4 Jan 2025 11:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735990182;
	bh=WSvusGxkP9CIComqoqcMe0McARfsPf9dGEDG3vMNNwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KZQtzIi2MHgbBGoaO+XjlCS58BPOYiDPWS2lwoCLBhW0vQsk1Dk3qTXj2UAicVZhf
	 zFW57MqpkAITzpM8Piyjr08tA4xaR29U30njGLCuzz9+9jp0YNvto/ZKpdgUWQRIIZ
	 jR3AlmTNS5rvuDx8Lnw8hO77/KkEOhXxoSbYZDzW4mp7EQnin3GktUAw3vgH9oT/DY
	 ZT0myaHQMRKBn3PIrXAJFyK5W4BLg8EBqKLd4PvTSPsqSpeWBXMqF9aYVqZAHIZkZX
	 UffOVZe4ooKLaZUYC3KGf0zOTh95LJKzr4N9lARzFPNizxIcow2xInh37Ujob6BN9R
	 M+IsPNCcXgA4A==
Date: Sat, 4 Jan 2025 12:29:38 +0100
From: Christian Brauner <brauner@kernel.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: cel@kernel.org, Hugh Dickins <hughd@google.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	yukuai3@huawei.com, yangerkun@huaweicloud.com, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v6 4/5] libfs: Replace simple_offset end-of-directory
 detection
Message-ID: <20250104-goldbarren-gehalt-bb5039a20c69@brauner>
References: <20241220153314.5237-1-cel@kernel.org>
 <20241220153314.5237-5-cel@kernel.org>
 <pguxas3azhbjaf5peijhzzaul45h26lmh44or2vsulpxbnvv7m@apmmkc3mewq5>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pguxas3azhbjaf5peijhzzaul45h26lmh44or2vsulpxbnvv7m@apmmkc3mewq5>

On Mon, Dec 23, 2024 at 11:30:47AM -0500, Liam R. Howlett wrote:
> * cel@kernel.org <cel@kernel.org> [241220 10:33]:
> > From: Chuck Lever <chuck.lever@oracle.com>
> > 
> > According to getdents(3), the d_off field in each returned directory
> > entry points to the next entry in the directory. The d_off field in
> > the last returned entry in the readdir buffer must contain a valid
> > offset value, but if it points to an actual directory entry, then
> > readdir/getdents can loop.
> > 
> > This patch introduces a specific fixed offset value that is placed
> > in the d_off field of the last entry in a directory. Some user space
> > applications assume that the EOD offset value is larger than the
> > offsets of real directory entries, so the largest possible offset
> > value is reserved for this purpose. This new value is never
> > allocated by simple_offset_add().
> > 
> > When ->iterate_dir() returns, getdents{64} inserts the ctx->pos
> > value into the d_off field of the last valid entry in the readdir
> > buffer. When it hits EOD, offset_readdir() sets ctx->pos to the EOD
> > offset value so the last entry is updated to point to the EOD marker.
> > 
> > When trying to read the entry at the EOD offset, offset_readdir()
> > terminates immediately.
> > 
> > It is worth noting that using a Maple tree for directory offset
> > value allocation does not guarantee a 63-bit range of values --
> > on platforms where "long" is a 32-bit type, the directory offset
> > value range is still 0..(2^31 - 1).
> 
> I have a standing request to have 32-bit archs return 64-bit values.  Is

Yes, an allocation mechanism for 64-bit values on 32-bit would be very
nice to have.

