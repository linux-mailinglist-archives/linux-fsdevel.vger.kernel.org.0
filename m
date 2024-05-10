Return-Path: <linux-fsdevel+bounces-19240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8F88C1C21
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 03:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECA532855FC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 01:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3FD13B7AE;
	Fri, 10 May 2024 01:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QsVeC5/b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F212313A886;
	Fri, 10 May 2024 01:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715304356; cv=none; b=g0QwKIg8i7tmiUYTamMQ28pBzYC7A+QE4bxDXcsQ7UP8+npISEPffIGulsaPY++jThmMi34RBLBfaIOq0kfsGb1IA8S6kj88h3/sTkyxMxPrVVz2L3463kaa84cVJ3N5IDQ7mzW/0ravkm0aOU0bjubfG89t0Jw5s4R/V1j6mI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715304356; c=relaxed/simple;
	bh=Yu7c1ifrsrVOFyS9oevLBygV88/BTD88Mmi6Ca8A52k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exINvLK+mo6CCpraj43DLc5S2uZrl3Z/JV9zy0y6VhzHZo0PZqH7+kwP69aI1UTsZUZmEXAKOjavlfdW1qD/OB7dVdv/PHTfSY9R/cvZSxLmyydkc2pnNAUdn9tuB2EjVauYFCt1lraO9VThvSkSu8x6IWCWNX7O+2JWypaZxgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QsVeC5/b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A0DAC116B1;
	Fri, 10 May 2024 01:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715304355;
	bh=Yu7c1ifrsrVOFyS9oevLBygV88/BTD88Mmi6Ca8A52k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QsVeC5/bO7SkLYnTpKSD+ulUFB67gVQ42OQV4Rtb5NkMyjHLhcgDH2FPHDPSRdPpB
	 2vANBlmZ4lVrxm43+uAL16ppLssifZz1ueIgruCT2lwWS3y2mXTuGEBy2h1lir+rdv
	 INxwSRdJfw9GETkEe/SM3y+RiKT5PGf+B+bA2Eh2EsTKj4uYg2b5xZ40RujAzlXkKO
	 8I+TqXKYoHRYn9C4vHTOaLyoEYHAAf+zwogWyhOVJnJIg8RkqrOKE63WDTNQ+VA169
	 6gNw7MKmaxrEAGDobMw2L354gG6+dYXP5ylyt8aGnXK80VeseYmfK9N+Qk+yd6dnII
	 hhL2pWuVKVcaA==
Date: Fri, 10 May 2024 01:25:53 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	jaegeuk@kernel.org, chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, krisman@suse.de,
	Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH v16 9/9] f2fs: Move CONFIG_UNICODE defguards into the
 code flow
Message-ID: <20240510012553.GH1110919@google.com>
References: <20240405121332.689228-1-eugen.hristev@collabora.com>
 <20240405121332.689228-10-eugen.hristev@collabora.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405121332.689228-10-eugen.hristev@collabora.com>

On Fri, Apr 05, 2024 at 03:13:32PM +0300, Eugen Hristev wrote:
> From: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> Instead of a bunch of ifdefs, make the unicode built checks part of the
> code flow where possible, as requested by Torvalds.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> [eugen.hristev@collabora.com: port to 6.8-rc3]
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> ---
>  fs/f2fs/namei.c | 10 ++++------
>  fs/f2fs/super.c |  8 ++++----
>  2 files changed, 8 insertions(+), 10 deletions(-)

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric

