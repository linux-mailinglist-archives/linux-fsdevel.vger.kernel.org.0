Return-Path: <linux-fsdevel+bounces-16145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E948899356
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 04:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA661B2471B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 02:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED0F12B8B;
	Fri,  5 Apr 2024 02:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8gp+Vn6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2F817BDC;
	Fri,  5 Apr 2024 02:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712285172; cv=none; b=AqAESYFpRPkxUzVZNdHBfwZVkkHnoH6RifOGOu7ok/e1J7b9XaLMWNn/uLhpwrZ76N8US+m1W7uAWMrbbc+x4sEYAeFNBGu+lkHkL34wSj3ifsrmzr4Ervm+LPVhE6F6eFQjbtuHHdUb+ghHrfk8xWF443uhv0nU63L4glU5Wik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712285172; c=relaxed/simple;
	bh=GDKLQ+m6QBpK4sfyVDYw9Nxh6vuX1tX9WutpImi4lic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TxgFKNsh2W8eBuX4g0fikPhc/iNH4X2wO0netlEZNlErf3IVS7FfTMtxA0TUgjxv4FzDszmlE+kJcBXH+DpmbFt+OdDl4vYBpKPq4eV+v2o3+FtgiRv3kSY1fIxL364SaMoe0m4KtRH+3NvBTz0ibvnSU7Y/gMdXAcmTpujSTUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8gp+Vn6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4207C433C7;
	Fri,  5 Apr 2024 02:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712285172;
	bh=GDKLQ+m6QBpK4sfyVDYw9Nxh6vuX1tX9WutpImi4lic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j8gp+Vn6RFJqPoiKMFJRXsAVsUzIzrhB8HbpTN3Jk52Zp4KLpBefy2Y4mKvLUFhzP
	 AT9UpHO/KucmB8gztWEkDkX1pTDkP5rR2wzwDrmTs84YeCOVCqu8uEEN2/gdtMg8fD
	 AMGHzKFonSp9/XVmHYGA+bDnJys7QAF5oWk4fnyywqlC6dVaIR0P706aMutD3Rm6E6
	 hOtXvgQTiM+ciarbsAGDVHA/WtWHshTS8yFxlhTCxMInf9EKv8NiZDfyu4FxAgAj8j
	 QrfPaE2l4HoKJ8EbKcr94jEf1B5fxOlASYgRXHxClWVo+CXk34FGkvO42ydH5qCf0N
	 NBXDssWoPDx8w==
Date: Thu, 4 Apr 2024 22:46:09 -0400
From: Eric Biggers <ebiggers@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: aalbersh@redhat.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH 07/13] fsverity: pass the new tree size and block size to
 ->begin_enable_verity
Message-ID: <20240405024609.GE1958@quark.localdomain>
References: <171175867829.1987804.15934006844321506283.stgit@frogsfrogsfrogs>
 <171175867981.1987804.2143506550606185399.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171175867981.1987804.2143506550606185399.stgit@frogsfrogsfrogs>

On Fri, Mar 29, 2024 at 05:34:30PM -0700, Darrick J. Wong wrote:
> diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
> index 52de58d6f021f..030d7094d80fc 100644
> --- a/include/linux/fsverity.h
> +++ b/include/linux/fsverity.h
> @@ -82,6 +82,8 @@ struct fsverity_operations {
>  	 * Begin enabling verity on the given file.
>  	 *
>  	 * @filp: a readonly file descriptor for the file
> +	 * @merkle_tree_size: total bytes the new Merkle tree will take up
> +	 * @tree_blocksize: the new Merkle tree block size

"new Merkle tree block size" is confusing because there's no old Merkle tree
block size here.  Maybe delete "new" from the above two lines.

- Eric

