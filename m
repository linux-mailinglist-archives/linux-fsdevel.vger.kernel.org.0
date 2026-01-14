Return-Path: <linux-fsdevel+bounces-73764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03245D1FD02
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 16:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67AF33071A1D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 15:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCDA399011;
	Wed, 14 Jan 2026 15:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWMBQ7/1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B7A2F4A1B
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 15:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768404603; cv=none; b=ZCv1jbAFh7CKNCMsIDi1G2PkMc3O89od3lpZoJbpanmprl6yH2eHdUO5Hm5dFIUC0D+/XNNV9Zb4/vSgyGMsOezzSox7cfujzTohvF989yYvkbtvEwJIXs80VryyV9H3CV8AfsaxVDw+HOCC2RaPstOL7wQHGKg3dYDWlgCVwVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768404603; c=relaxed/simple;
	bh=/Ad+rw6JUy0AdUbpmI5SWwNNguld2Yz9S3zo4nSrVRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSkl5H6K9GCN9tZiVrxn/E7nf9yt9U+xtys/qV1pcajHv1PDhJ0SaZh078v1yh0pHeSTfcXkfcjiaUGcrrSTEv2dujVtiTQQ+ER+rdXm1hJsLcNqG5kSgm3e2LmfE/iorkWCSkMUmvFMBV46uq8ETyqXGb8UjjvZiQtPkWh2/f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWMBQ7/1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B25C4CEF7;
	Wed, 14 Jan 2026 15:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768404603;
	bh=/Ad+rw6JUy0AdUbpmI5SWwNNguld2Yz9S3zo4nSrVRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OWMBQ7/14GYEeE8hPCnwybwADBcTn4mq09pst+0aOdi+baOzoAJykZUiJ4ftBWDrQ
	 mGj96pLBgjp5oynvltbv9dMRkQq0MmQIAvrLW1IMa4HK7bhrP9dQWd/oCeZdg8vNfs
	 DfrH3c8V7fd09fiOMi7QaITO7tEWbR/HysjI4BuTT3LZbzqK9dTqwXRoL//qiMarjI
	 mtca8v6LyjKZmGXZSdcV0eSsPeHar/JKbze/O0WGuj4rnE2y5QDmQZi7GnKhraO+cL
	 3UN6Ct9BL7XBmChfLLaiHxF8u4xVQP/DDEgKRBQjK6o2ccVV/P2kYKh8zRyVLy6MR/
	 AMXqduV2CdjcA==
Date: Wed, 14 Jan 2026 16:29:59 +0100
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Luis Henriques <luis@igalia.com>, 
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 0/6] fuse: fixes and cleanups for expired dentry eviction
Message-ID: <20260114-frohnatur-umwegen-8e4ce0e3fc4b@brauner>
References: <20260114145344.468856-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260114145344.468856-1-mszeredi@redhat.com>

On Wed, Jan 14, 2026 at 03:53:37PM +0100, Miklos Szeredi wrote:
> This mini series fixes issues with the stale dentry cleanup patches added
> in this cycle.  In particular commit ab84ad597386 ("fuse: new work queue to
> periodically invalidate expired dentries") allowed a race resulting in UAF.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---

Do you want me to route those via vfs.fixes?
Btw, the Link: you provided in the first patch points to nothing on lore.

