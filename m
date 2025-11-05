Return-Path: <linux-fsdevel+bounces-67131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2B6C35EC8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 14:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 526504200E4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 13:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B76A324B39;
	Wed,  5 Nov 2025 13:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQP+QvOX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CFC236A73;
	Wed,  5 Nov 2025 13:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762350490; cv=none; b=V686AhXgazxQfZYmghuQE+56zSs65uC4kQ7CcC89CWi3Lw64Hmit4vu63xVF7DlZsTl7wNCIiuPDcMU/zOB0lEIBY/WwUo1Mr5BSsWNkc/dzoJhtS2NSnU9fNstH3/0o0TMU/mlEVNYgpWCSZT4Yo4SvtoBoo36wPib0Qri/8IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762350490; c=relaxed/simple;
	bh=Y/WC8N7PHX07YjQWrc8LSpK7K/PgvP/HlvVRSpu1Ijc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzwNWx/Qp+Rx0OG9osSeE2bfEhnU8B/b4byC38f9pCFoEtZfmmIAhGauy3Xru14iEHfAjFbliZbrihS7rzgwx334OJQXWO8nxkI+e3+Gg3a0tv+ssI/3hkxLFvB5fXQc25MXbspVODDCNy+Ub/wJ2P66+VqtmMLeEA/sQQp1vUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQP+QvOX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD9BDC4CEF8;
	Wed,  5 Nov 2025 13:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762350490;
	bh=Y/WC8N7PHX07YjQWrc8LSpK7K/PgvP/HlvVRSpu1Ijc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZQP+QvOXpExulyD8Pol21uBTvRAzmRxRZ+5JCaAJ4bXGB7rl770roY1pdjxh88vHb
	 YZAJQT4CNErHGe5ZwuPnz2Be/CbJpGNayKGLa9IHqvbCw6rO/H5OkIlVp753mxj7Ee
	 222DQ2yCg9V1RA+NiOUVzFz/gFAK2oZL80NzIyfzlkpMOiyNu3iy9AuATXGFCaEJYl
	 qbEgH7EHigtjZ9MfyCHTTTs/eP5TCzmidblQiTkdsB1SJjYDJb+yK31cX2cBjhowM2
	 /a1dO0xGUKu/gWAJ7wOA2L7qdYdzKRiTwMdTr8fSVPC9bFZ6kMvwCSx/NoMRltEQnG
	 TK8a95d3CSjSA==
Date: Wed, 5 Nov 2025 14:48:06 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] fs: start to split up fs.h
Message-ID: <20251105-noten-bewiesen-3862ad2d7aea@brauner>
References: <20251104-work-fs-header-v1-0-fb39a2efe39e@kernel.org>
 <aQtJRisTtkX-Jzen@infradead.org>
 <20251105-nippen-forsten-dabf4d7508eb@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251105-nippen-forsten-dabf4d7508eb@brauner>

On Wed, Nov 05, 2025 at 02:13:32PM +0100, Christian Brauner wrote:
> On Wed, Nov 05, 2025 at 04:55:34AM -0800, Christoph Hellwig wrote:
> > On Tue, Nov 04, 2025 at 03:46:31PM +0100, Christian Brauner wrote:
> > > Take first steps to split up fs.h. Add fs_super_types.h and fs_super.h
> > > headers that contain the types and functions associated with super
> > > blocks respectively.
> > 
> > We have this nice concept called directories for namespace prefixes.
> > Why not include/linux/fs/*.h for all these split out bits?
> 
> Sure, fine by me. Some do it differently. For example, mm has mm_* too.
> But yeah, the fs/ layout is fine.

/me raises eye-brows:

blk-cgroup.h          blkdev.h              blk-mq.h              blktrace_api.h
blk-crypto.h          blk-integrity.h       blkpg.h               blk_types.h
blk-crypto-profile.h  blk-mq-dma.h          blk-pm.h

What sort of mix-and-match bonanza have you got going on over there?

