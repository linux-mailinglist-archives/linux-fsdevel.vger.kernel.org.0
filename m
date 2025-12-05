Return-Path: <linux-fsdevel+bounces-70817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B06ACA794E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 13:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BD993130287
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 12:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870FF30DD31;
	Fri,  5 Dec 2025 12:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0L9d4RD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9949D23EA81;
	Fri,  5 Dec 2025 12:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764938087; cv=none; b=b1o8ppfYz29aNsctsYuFO7ofnrPmjD4eb1EFdJvqEbbYXyhew/OsReUBRCupM2n98mO8iBiT7CQUjsO6UvVT1d89qMrxyvgfSVxkrF9Tnr++SBL1gkZrn/J72ht89cv83UVbBeUgm7n/x+/F4/ZigA4OtxBzLgiE+xSbna6HYpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764938087; c=relaxed/simple;
	bh=xHBhMlGkGdamCxTxSLV9OJsqVUcY7tHSnWJifkwPs6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NY5Tn5hGLgYQJQn2XDNqO5mGWzxF6bcda3j3QBKcBHc/x1KI3Hrf7mjyMl1Ee/Z7tGxm1RdDSuO7DyTvLok5hsVza1gGdShT4wo7QOsOgOzsROlYymX0ZiLU1bHgCQjCbVMjReAnz4HpRZjd7UhqkPCCqaXPGyxQpLabGAA/JQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0L9d4RD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4320EC4CEF1;
	Fri,  5 Dec 2025 12:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764938087;
	bh=xHBhMlGkGdamCxTxSLV9OJsqVUcY7tHSnWJifkwPs6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i0L9d4RDz4xK1pYgTFEXKF5K5iW2PCnDFFFxhvaN7dZ7RHYjbvPJyRiwFG1QVgKrV
	 tJSx3P96gckHw+WFlTl5su8Ny4FgzoiFkH2Eiq6LKOEawzqLJGYixMC+MetTwDJ8HZ
	 udqu7thsSC2m6Crhv8ie8OnYtE+3Lp/5Pg7Q2VRgn3c5m8dmqRf3KMdKouY4ROxTax
	 2eV4Sn0ijce1rXwWbwOi3YcJbcMDZK6bhAb0Rz7xnwgI/PytQxuV8BwP5CvbagGxaU
	 2nr7InQeNI9eMOukE12e/tqhF82qCY5kkXzi4G1tikQukgF1bmmmYWKGQfTm+0kGAN
	 Roty6X6yexmxA==
Date: Fri, 5 Dec 2025 13:34:42 +0100
From: Christian Brauner <brauner@kernel.org>
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org, 
	Linux FS Devel <linux-fsdevel@vger.kernel.org>, linux-unionfs@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: overlayfs test failures on kernels post v6.18
Message-ID: <20251205-kapern-pechvogel-06c3125c3809@brauner>
References: <CAHC9VhSaM6Hkbe+VHpRXir9OJd1=S=e1BB3zLkSTD+CXwXaqHg@mail.gmail.com>
 <CAFqZXNvL1ciLXMhHrnoyBmQu1PAApH41LkSWEhrcvzAAbFij8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFqZXNvL1ciLXMhHrnoyBmQu1PAApH41LkSWEhrcvzAAbFij8Q@mail.gmail.com>

> I can't see anything obviously wrong with that commit, though. Perhaps
> the author/maintainers will be able to spot the bug.

Hey, thanks for bisecting this. I just sent a fix for this issue.

