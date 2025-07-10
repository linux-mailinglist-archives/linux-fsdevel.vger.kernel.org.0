Return-Path: <linux-fsdevel+bounces-54474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D36C3B0008C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 13:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96171644F21
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 11:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFDB2D979A;
	Thu, 10 Jul 2025 11:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNfcCdmy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C53944F;
	Thu, 10 Jul 2025 11:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752146926; cv=none; b=lHNiSmpXmAOuULvjAie0vp/Dlb6MyP8+ytz+Pd8ixqwKmMIzQ07qCbYq0FPi4SnecLXgiwM1D2bC9Alyy7b0V85AKTFLamYvO3CazvdYuCStBQQsC0d2Qv1pHYQQzy4EcMneVj2HG+/bOf8ENQ0UzZBaWTHQHtpnp6HkCIZ6F2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752146926; c=relaxed/simple;
	bh=T193y/o45vKooErS3/9Y2fIHg05WpHDCb0bo4F89VS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A44zlLQJOjamv3XPJRmphd8DcrAyC4ga377JMPgIcvc/Xpx0P50dm/83RVmJdX7jRHhXRGpbgwWJ5Khuy5IAvrtoZ/57Tt2EVVWv5ZnUEi1ojPAoQTWWlu7kqBlwDDrydJd3CyrwX5lIVsn3MoQ1KHArhK1GHlA77AewPY5YxEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNfcCdmy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98657C4CEE3;
	Thu, 10 Jul 2025 11:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752146925;
	bh=T193y/o45vKooErS3/9Y2fIHg05WpHDCb0bo4F89VS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jNfcCdmywKnWtypM+R05jThYUY+4kM8P6uDROS9nxqmIq/xTi3mus++0O1AsPT0Qr
	 cXfp4l//URol1DrQ6y3EOcXUS1IKoInN6lpqztwl4Vgx0d7cudVVRnxjqYb+EloMxk
	 AcXmn/tB07b3kfyOK4ly+OL/61wtc5kZtRrwkW5g42U3XPY+/Pg6lzzzB2U0fTQmOC
	 lvIFG2hiuxTce5aaZHOuHS4hgC3YQ8eB48Gezy5q3x1AnfL/h+EY6SIiUdeXCd3pKi
	 gT6oal6P9MoK/6Iko+8zUdrTL1TDdFl/zB8e16U+3Ps60bSSx/RcQugfFaRY64v8n6
	 SG99fUHB8fsMQ==
Date: Thu, 10 Jul 2025 13:28:42 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, 
	syzbot+895c23f6917da440ed0d@syzkaller.appspotmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] isofs: Verify inode mode when loading from disk
Message-ID: <20250710-milchglas-entzaubern-17d9e0440a55@brauner>
References: <20250709095545.31062-2-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250709095545.31062-2-jack@suse.cz>

On Wed, Jul 09, 2025 at 11:55:46AM +0200, Jan Kara wrote:
> Verify that the inode mode is sane when loading it from the disk to
> avoid complaints from VFS about setting up invalid inodes.
> 
> Reported-by: syzbot+895c23f6917da440ed0d@syzkaller.appspotmail.com
> CC: stable@vger.kernel.org
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

Thanks! You want me to throw that in vfs.fixes for this week?
Acked-by: Christian Brauner <brauner@kernel.org>

