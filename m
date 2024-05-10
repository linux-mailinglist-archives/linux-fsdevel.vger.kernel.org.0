Return-Path: <linux-fsdevel+bounces-19239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 811CC8C1C1C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 03:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A7C6283623
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 01:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF89613B7AE;
	Fri, 10 May 2024 01:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsgwgbYB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117C013AA59;
	Fri, 10 May 2024 01:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715304342; cv=none; b=aqRdpp9dysYD5AucXmKpQsuh3qWEom08ZSfGN3aeQZCDOhua27TqteVI070ctPF0XH1WxMACr/1NPDKWiYg5T4FWAVXquYsf7RLEV3EmJpqREsntrck3krxgLCmYTdm65rjv2y+Ad7pfLLknENfyUsGwrRI1/cHwa7PnUe3Ms3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715304342; c=relaxed/simple;
	bh=AcFmfnE2SjS9n37wQ7KWN0OORIobOYPwAzFfJDvf0d0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hI4iCwQLsaNy3PkI7CK5gFyl9qeBXEcO1hJU0Coc+PjUrJZhAn8h4XCymgW3OOfSoKrGkJfFFbxUaYZxRbnd/UsgsoBp0RYqGrVFk6gnyxQD1u1cxch3PNxIQLbT7IK9D+5AxhWTd5Hhoz05koc7gkNkpxUmKH/yBMCil6swz+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsgwgbYB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C48E6C116B1;
	Fri, 10 May 2024 01:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715304341;
	bh=AcFmfnE2SjS9n37wQ7KWN0OORIobOYPwAzFfJDvf0d0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NsgwgbYBQqgOLYZTyt2LSVvl3VOMIZc2ON7mdOseE1h+gq4YbC/GeE0ME8wFWBU0e
	 Snm7cJatEr62rHkiAXBemkZz/f/3MUfBdApBnBIzYHQYtq6ytrajNPc7hmijIQDM8E
	 7Snvyo1CwyW6+Mg808mRm0KCtK1F0UPJYddyjY/Vd6rfU2TTGdQHFQ/XfuI3CmOFrb
	 MJkjynpB3Uyr7pLve/0GoKrcxzxTsy86bM/QI7/slSebH+8EAwbggMxFkPo58gJq+g
	 qblgZwXPnHfN970fUaAEQ5unqFYrFLfS1ufHuidziOXN7U2PRzWmru96EqBTE2TUUu
	 czkl/is1dHVCw==
Date: Fri, 10 May 2024 01:25:39 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	jaegeuk@kernel.org, chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, krisman@suse.de,
	Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH v16 8/9] ext4: Move CONFIG_UNICODE defguards into the
 code flow
Message-ID: <20240510012539.GG1110919@google.com>
References: <20240405121332.689228-1-eugen.hristev@collabora.com>
 <20240405121332.689228-9-eugen.hristev@collabora.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405121332.689228-9-eugen.hristev@collabora.com>

On Fri, Apr 05, 2024 at 03:13:31PM +0300, Eugen Hristev wrote:
> From: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> Instead of a bunch of ifdefs, make the unicode built checks part of the
> code flow where possible, as requested by Torvalds.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> [eugen.hristev@collabora.com: port to 6.8-rc3]
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> ---
>  fs/ext4/crypto.c | 10 ++--------
>  fs/ext4/ext4.h   | 33 +++++++++++++++++++++------------
>  fs/ext4/namei.c  | 14 +++++---------
>  fs/ext4/super.c  |  4 +---
>  4 files changed, 29 insertions(+), 32 deletions(-)

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric

