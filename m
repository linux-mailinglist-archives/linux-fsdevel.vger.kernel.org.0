Return-Path: <linux-fsdevel+bounces-9919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C99A8461A1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 20:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DCDFB2D940
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 19:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206C985650;
	Thu,  1 Feb 2024 19:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ie3bMClr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6897D8563F;
	Thu,  1 Feb 2024 19:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706817438; cv=none; b=Pp2rJH/XZB7pJVa7KljK3ykXVijptNKi5ZxusYkBM9k7jMuQSKD4J19NLOOwgJXWRF2i9IdOCdncSeA8/8TmeTvTnoGuHW9mIeiST2t2TITsaJsXZk25pnuyl7DiDskqg6KWQtZcHqGFNVAUaK0eBeXEe5iyBJfFLWSwdwU8Ls8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706817438; c=relaxed/simple;
	bh=RZ5fBi48705fltwCeyS5V8KUznyLis81CG8pY6CYXgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMyFhXymEOPKxT9EJ2xC0Jq75dBXgbNmFD0Hqg6Gq1cT+e1PmI9NCZF9li9S4tDeZh5nwVYe+cmLuedSkTXG1grp9y7sk4vYPWGJokR0bhCWnxmppaWTTqPQkyDsEuGNz0LYTSs+DkXqdDU8hSmbzbGNPisrUW8Cs4lxhhVk+LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ie3bMClr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3C5C433F1;
	Thu,  1 Feb 2024 19:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706817437;
	bh=RZ5fBi48705fltwCeyS5V8KUznyLis81CG8pY6CYXgE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ie3bMClrlUwfLKNo/dfKSG+BkfmRZLb0duGXaeNALGsPmoqjVJpNHf84HCOl07y4q
	 Ilm5AcF0sW6i9fyqLPNppZ5AwU4jwdcXalS/QewbYyyNFwooNdQbn+IXtkY7qKoxHa
	 bzjndaiB2qkQ73RAPuBn2Uj87bm+nU7/Ji6o1luNLKDpQsdTHAFJybkXxAIQWsaY51
	 DcLzRSVGKUwlnuDCjz2QMTrzcN0zjfbMuA8iIz5JzJz08jhXF4l+KiMnnx0Pd44kNA
	 Op0r0O3n5TYtU/GhC/vbAbzuyDF6DUyONP465G7IbrDhwXWY4c4pYYU/TiQh784wGC
	 FahGw8eA7CmuA==
Date: Thu, 1 Feb 2024 11:57:17 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-bcache@vger.kernel.org, linux-bcachefs@vger.kernel.org,
	Dave Chinner <david@fromorbit.com>, Theodore Ts'o <tytso@mit.edu>,
	Coly Li <colyli@suse.de>
Subject: Re: [PATCH 4/5] time_stats: Promote to lib/
Message-ID: <20240201195717.GF6184@frogsfrogsfrogs>
References: <20240126220655.395093-1-kent.overstreet@linux.dev>
 <20240126220655.395093-4-kent.overstreet@linux.dev>
 <20240127015352.GB6184@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240127015352.GB6184@frogsfrogsfrogs>

Note that I needed the following patch to fix some build errors:

diff --git a/lib/time_stats.c b/lib/time_stats.c
index a5b9f149e2c6a..6618b1c35d700 100644
--- a/lib/time_stats.c
+++ b/lib/time_stats.c
@@ -6,6 +6,7 @@
 #include <linux/time.h>
 #include <linux/time_stats.h>
 #include <linux/spinlock.h>
+#include <linux/module.h>
 
 static const struct time_unit time_units[] = {
 	{ "ns",		1		 },
@@ -29,6 +30,7 @@ const struct time_unit *pick_time_units(u64 ns)
 
 	return u;
 }
+EXPORT_SYMBOL_GPL(pick_time_units);
 
 static void quantiles_update(struct quantiles *q, u64 v)
 {
@@ -262,3 +264,7 @@ void time_stats_init(struct time_stats *stats)
 	spin_lock_init(&stats->lock);
 }
 EXPORT_SYMBOL_GPL(time_stats_init);
+
+MODULE_AUTHOR("Kent Overstreet?");
+MODULE_DESCRIPTION("time statistics library");
+MODULE_LICENSE("GPL");

