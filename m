Return-Path: <linux-fsdevel+bounces-52020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC513ADE5D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 10:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDFDD1882B68
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 08:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A39191F66;
	Wed, 18 Jun 2025 08:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EP4W0ekK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B14277C8E
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 08:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750236012; cv=none; b=SPq/ejKa4qVcSXNpw+C2GOhiBp6JU7vv2vvu4B0RN9hbps0s3aTcf3/BaCrDuCyPFfkqFQ6maiBtDXngs1rriQW4dLhCccAS2+d4shuavHw8A543B19i2AQemcAeWl66hWKxGZm+r/JBys4vZamYV6Trxg/ognFNuD6wOnMAnh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750236012; c=relaxed/simple;
	bh=So/d6X4N5kfRZAVaLvLNqFDAQlWMMW/4h6r4krbIbLY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1i+C+9kj6p0ui/RQHfwC6XJ7+y4mGQ1HVv8G9OGEyRwSrLpoa1kWE7xoip+EsPr4BnidVBF/SsPZtqTPfy4LMzPnu3qXb9rjz2yu0Mp6lZYkmCrrgt+Js1RhPKynSdGAfK0TL9XExoGds4Sq6dyteeKC+/SaEN8mNUIg9QEA+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EP4W0ekK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130E1C4CEE7;
	Wed, 18 Jun 2025 08:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750236011;
	bh=So/d6X4N5kfRZAVaLvLNqFDAQlWMMW/4h6r4krbIbLY=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=EP4W0ekK4ONdX3ORiOaCXhRnCnkdAJ7w1PbIZRxU/ID9Q/65eU3kr26HtltLzLaNi
	 p6jgoQCpeyJ6phy5mGREgiQgdnTRTp3iAvaJ6ib2dE5pIH64yWNYC/grtCcOBaLYQR
	 +vwh5q76Z6+TCMkR7r1v8yCwdY4YXawOpOYSrS1q0IIzJyjEC9sO+benCHWIvQS+2c
	 G8f0XJ28O3qmWHOJ9apkB6+3RB++DcXmf+jdoVZswruul5W6+Tl8I8937aBWkb+eD7
	 mRw+sfAKxZpep8Ryi4ZtRvk+w15E2eLuB9oa7H+u8T3HtjjTP9zmJhJfj5FOvDUyDQ
	 SMkIAmo2eWVlQ==
Date: Wed, 18 Jun 2025 10:40:08 +0200
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v2 1/2] pidfs: keep pidfs dentry stashed once created
Message-ID: <20250618-einfrieren-faxnummer-26dc38e6311e@brauner>
References: <20250617-work-pidfs-v2-0-529ca1990401@kernel.org>
 <20250617-work-pidfs-v2-1-529ca1990401@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250617-work-pidfs-v2-1-529ca1990401@kernel.org>

> @@ -2234,8 +2239,15 @@ int path_from_stashed(struct dentry **stashed, struct vfsmount *mnt, void *data,
>  		return PTR_ERR(dentry);
>  
>  	/* Added a new dentry. @data is now owned by the filesystem. */
> -	path->dentry = stash_dentry(stashed, dentry);
> -	if (path->dentry != dentry)
> +	if (sops->stash_dentry)
> +		res = sops->stash_dentry(stashed, dentry);
> +	else
> +		res = stash_dentry(stashed, dentry);
> +	if (IS_ERR(res))
> +		return PTR_ERR(res);

Missing dput(). Fixed in-tree.

