Return-Path: <linux-fsdevel+bounces-8834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CCE83B75D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 03:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6D681C22C53
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 02:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EBC613A;
	Thu, 25 Jan 2024 02:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tt+MgVUA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DC91842;
	Thu, 25 Jan 2024 02:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706151078; cv=none; b=Xgy5WqHbEDNOUJZYHzAHcywcnXrbtDTXlTgS+/jNqwXgSIq1J0PIqNbsjzzVjHivRquE3cbgva/orhwre2JrcUh6i/Guf4k03RNeTXmcQq0qS5HdioPNHK8ooVsV2zDuSv837SxJYwqAYb4rgaer25JCMABWTWSEgpkZRp1PB70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706151078; c=relaxed/simple;
	bh=XAInFk0WFWd1bmvs0vQTX2Dqg3VbW5EExkT+v4E4z9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKmNLb6DWnSSiQsRGRoQ2xI9Sm6h4mFMpkhNl0Kc3n1Alj5mWUiSuW+TImrvK993L0684jSdQNsC5Zf2U/D+0rz8zVJ7SS3yDJnZXikb4/rXjtNjiH6omWllwsIaAiLKX4OYtjbNCsM7JiUpkr8Y+AyIvX0zL2bnCGXS6RmnaZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tt+MgVUA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8D0C433F1;
	Thu, 25 Jan 2024 02:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706151077;
	bh=XAInFk0WFWd1bmvs0vQTX2Dqg3VbW5EExkT+v4E4z9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tt+MgVUAAyNuQS03IytFSOwZ5RkSi3MCS9nRWO3cEk6RmdmofFv3pYeoilItLyrvS
	 59QQ2SRHM3ZFUNX7mkJEWAlmGVueFeeOd3NzDnHP0Eapsv8JcFpX0AG9mQ4nlpY2xj
	 ISIX82+Sp6lyKD4B9fFQoaNKxP096R77hgT8NfCYSVS7ePr7KSr+XqBlB7AOA/9/ux
	 dD0KkmV/FysMqLd4FfAFPLe2XwfIxbR/JwWGaDn4XT7lmREQDtJ11Wpp7J6UkfXsQQ
	 C3tOiMZU/S/R05IRjqOH70gMQ/lNrJ6Mc+p8HU4xkvva7mS70R6kMQsHR7PesMUyL/
	 VrIN105+v9Abw==
Date: Wed, 24 Jan 2024 18:51:15 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: viro@zeniv.linux.org.uk, jaegeuk@kernel.org, tytso@mit.edu,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, amir73il@gmail.com
Subject: Re: [PATCH v3 01/10] ovl: Reject mounting case-insensitive
 filesystems
Message-ID: <20240125025115.GA52073@sol.localdomain>
References: <20240119184742.31088-1-krisman@suse.de>
 <20240119184742.31088-2-krisman@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119184742.31088-2-krisman@suse.de>

On Fri, Jan 19, 2024 at 03:47:33PM -0300, Gabriel Krisman Bertazi wrote:
> ovl: Reject mounting case-insensitive filesystems

Overlayfs doesn't mount filesystems.  I think you might mean something like
reject case-insensitive lowerdirs?

> +	/*
> +	 * Root dentries of case-insensitive filesystems might not have
> +	 * the dentry operations set, but still be incompatible with
> +	 * overlayfs.  Check explicitly to prevent post-mount failures.
> +	 */
> +	if (sb_has_encoding(path->mnt->mnt_sb))
> +		return invalfc(fc, "case-insensitive filesystem on %s not supported", name);

sb_has_encoding() doesn't mean that the filesystem is case-insensitive.  It
means that the filesystem supports individual case-insensitive directories.

With that in mind, is this code still working as intended?

If so, can you update the comment and error message accordingly?

- Eric

