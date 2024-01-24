Return-Path: <linux-fsdevel+bounces-8827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D426C83B493
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 23:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9C451C23CA4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 22:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEE8135A48;
	Wed, 24 Jan 2024 22:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ih/oWMND"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1F051021;
	Wed, 24 Jan 2024 22:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706134795; cv=none; b=fFxqyI7nBSISiVPWrFAe/io8iY1bHdrK1eIaCXbwZnbaKwoAgGg8JIaPzqaNyX1j1TUx/dkhtfUk2c2KKVZHmp9nmLOXnajAox0DPrDNWiXw1VHU8p+aCCeErw0+dZt2BNvB6Pf+SOXDlQnS/VQCDXFg01LzLZMCi+Jsq3BXTwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706134795; c=relaxed/simple;
	bh=mwSyI2tFMZCy/H1eNdpdEPpOtmy2Jgy7mh2Z+8VMiPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nsw6vjBp4Rjz+oN0dehW9sWopxrTkktftIZa4fEzr9aK2KtB5TJ1+cpd3wibiD8UIPhKCyLMDEg7eSq6ceTIlIGkoAzQCG5SU4asCxQiRTRfkQwvcObvDh0sMoic5IagH4bLxXiC8dRH1bX+zaMHR35meqkK4x7yy6zTlvmHVQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ih/oWMND; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20316C433F1;
	Wed, 24 Jan 2024 22:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706134794;
	bh=mwSyI2tFMZCy/H1eNdpdEPpOtmy2Jgy7mh2Z+8VMiPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ih/oWMND2dnnVsMARNU6ZDphtL5GBUZdlHf/n20Qb1OSUYKxNCa2Q6pdRs4zWyRZb
	 mWKUn/OtJlDaQoFktLMbtPnIfQAVhxzHdFZP6LU6gD9KVVjMft9/Zuv2yS6B+oTdgj
	 udM8vSewH/zBHqx4SmocSLMqRt81U6Qn0bDKnGQ6HBYr6aGqHNsjyMN9dka+nYl7WN
	 hm6DYs8dcxI86NJ+8a0bFqGbXsRMUgSkTFtzwhvByRlYuPaADLHyhZtKiNsKbhm2zx
	 xLwGooJlzbNz6vNUfVEr/nJcUID3dkMg97tQbZejI9eF2oPpcT5zRxwc9ZtbFJb4R+
	 rQD3QDCU8q+1g==
Date: Wed, 24 Jan 2024 14:19:52 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: jlayton@redhat.com, amir73il@gmail.com, trondmy@hammerspace.com,
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org
Subject: Re: [PATCH v5 2/2] fs: Create a generic is_dot_dotdot() utility
Message-ID: <20240124221952.GE1088@sol.localdomain>
References: <170575895658.22911.11462120546862746092.stgit@klimt.1015granger.net>
 <170575907468.22911.10976023123447238559.stgit@klimt.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170575907468.22911.10976023123447238559.stgit@klimt.1015granger.net>

On Sat, Jan 20, 2024 at 08:57:54AM -0500, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> De-duplicate the same functionality in several places by hoisting
> the is_dot_dotdot() utility function into linux/fs.h.
> 
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/crypto/fname.c    |    8 +-------
>  fs/ecryptfs/crypto.c |   10 ----------
>  fs/exportfs/expfs.c  |   10 ----------
>  fs/f2fs/f2fs.h       |   11 -----------
>  fs/namei.c           |    6 ++----
>  include/linux/fs.h   |   11 +++++++++++
>  6 files changed, 14 insertions(+), 42 deletions(-)

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric

