Return-Path: <linux-fsdevel+bounces-59496-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C116EB39DC4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 14:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8897046544E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 12:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DC530FF29;
	Thu, 28 Aug 2025 12:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLjkrKiZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88007464;
	Thu, 28 Aug 2025 12:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756385488; cv=none; b=B70BV9dz/ss1VO9E6y24SgMbGHeDNQoK90v/I72d5e0k0hCYnN2f6i4lVNRZPxX6Ft4cCfjATBLHxpIYYtDyC2OMHfTpqMUywXJe9Uha/wu+KDdALUNB4YilGwahhLxppOI9NR/2TYejqec/dY5r8itL7G30UfTOShpyrTvjP8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756385488; c=relaxed/simple;
	bh=LaJZWkK8WmsFUA1HJ6m6nWUwWxJWTtCpvMy0HO35z1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJxqpN88ihb4u05Po7jyso30tT2OrWops8LTp8R7HFcDccLshL9pKf97R7SQ294ja15a+cYtooRsSxUfiW8ixD/v2nEBpf2ppkVbLMO8LO+F97YZOX4xS21kEjQDlnRpEP1B4oMXqsUHh8YZUW8neQiSy19WG7m5MRU2sL3Jsi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLjkrKiZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9B0C4CEEB;
	Thu, 28 Aug 2025 12:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756385487;
	bh=LaJZWkK8WmsFUA1HJ6m6nWUwWxJWTtCpvMy0HO35z1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uLjkrKiZBjqRRcKwWUoS4+BMYEr48SZ9DlTxHzHIxWAYjxlBMAHOClS9iJ2thI7y+
	 /Vo+k2jGkyHOHK7XmbovN9DAe4WDHiKxVgjSWMf8qmfgq0wSD3ot3vq+4POM2hvlZj
	 fzis1lo0Ibl+GM1VASkoS68Kdkyg2W3v8eM05CCk11wQD3RC59UdQCHPNN+fo2Tjgi
	 2217xigBmD8z9/GOdjx80uny0pXdeUHWZotX7tr8Vd4SzsqfhfrryUP4EcqyZe19Oa
	 257TGz0Vv3XWQ8Kwki53yK6OjpEQYCTe33smBFxphblvIAwR4UQjmsSRcGkKl94zSP
	 yeXQ2StUlG1bg==
Date: Thu, 28 Aug 2025 14:51:23 +0200
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	kernel-team@fb.com, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	viro@zeniv.linux.org.uk, amir73il@gmail.com
Subject: Re: [PATCH v2 00/54] fs: rework inode reference counting
Message-ID: <20250828-hygiene-erfinden-81433fd05596@brauner>
References: <cover.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>

On Tue, Aug 26, 2025 at 11:39:00AM -0400, Josef Bacik wrote:
> v1: https://lore.kernel.org/linux-fsdevel/cover.1755806649.git.josef@toxicpanda.com/
> 
> v1->v2:

I've been through the series apart from the Documentation so far (I'll
read that later to see how it matches my own understanding.). To me this
all looks pretty great. The death of all these flags is amazing and if
we can experiment with the icache removal next that would be very nice.

So I wait for some more comments and maybe a final resend but I'm quite
happy. I'm sure I've missed subtleties but testing will hopefully also
shake out a few additional bugs.

