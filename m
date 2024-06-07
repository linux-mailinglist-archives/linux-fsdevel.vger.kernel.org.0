Return-Path: <linux-fsdevel+bounces-21249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9697D90083B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 17:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B90BD1C2571A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 15:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCE31991AF;
	Fri,  7 Jun 2024 15:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ulvxuLa9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE55198E8A;
	Fri,  7 Jun 2024 15:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717772696; cv=none; b=j1BooRZkDPgzuMlzXcGHf6+qF/P32nOrdRhXewL3gsdJmdG2wljouXCc4IzLDetgl18JWqmUV0SwVMMwIzQ4CggRDHm+AnSipkP0fnvsEAuK6whcTbH4MuqTgikkMxWa+2U39VIasNd4/ZSoQaSIlrsEGC/D8NJtVgqCp2xWkWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717772696; c=relaxed/simple;
	bh=xTJbenjVfHA1ltm0u80D23v5lEPXPg2FY+o7ukRMWbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sz1eMthsWY5jvOvmRgKnW1Q6p65RCddZLcCueIJVwTm3Mwo/D+wF0Mln6N24RtkUgsmdqRXq6+l+NzV2DlXB5Vs29JtWCWb5Jw8ahDDx67fR4G0ShjyWEarn0PWgNnXPijHwOc7xVo0rM1Qnx/ZTYo6aFRpYhSz3fb1/4yDgIi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ulvxuLa9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20C87C2BBFC;
	Fri,  7 Jun 2024 15:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717772695;
	bh=xTJbenjVfHA1ltm0u80D23v5lEPXPg2FY+o7ukRMWbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ulvxuLa9I0Gau+gWQk9QEVo1+5TErBRMH4UkJLQMHjDeLAdpwhXi1lhYCjzRWts4w
	 +Yaq1j0cYzrPm8DzVINcpMCPv3ypO9x0ET0/HMldBBvdi21VRdyu1YHVjMFtajj59Z
	 13tsPIu++/frcJL0KO8L+6vA/mfDmcRQii4qwz7zgdnpNwaBsIBwtB25mOxggh/9iu
	 nV/olNsgRtowZluYpcRt5OBln85cRgP6tmmrMKD0B2FhaQrC0hIQCBbkTRxbsYLSi5
	 xVKdygb83XXNEJ+VXwE46JtCtEhOia9wSkPjimKcoJSD/JwSSI5EjcJpR8NiSOAnp7
	 pwAKL4yvvg9Uw==
Date: Fri, 7 Jun 2024 17:04:49 +0200
From: Christian Brauner <brauner@kernel.org>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: Eugen Hristev <eugen.hristev@collabora.com>, 
	Christian Brauner <christian@brauner.io>, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org, 
	adilger.kernel@dilger.ca, tytso@mit.edu, chao@kernel.org, viro@zeniv.linux.org.uk, 
	jack@suse.cz, ebiggers@google.com, kernel@collabora.com
Subject: Re: [PATCH v18 0/7] Case insensitive cleanup for ext4/f2fs
Message-ID: <20240607-skaten-geophysik-685b6532b78e@brauner>
References: <20240606073353.47130-1-eugen.hristev@collabora.com>
 <87v82livv5.fsf@mailhost.krisman.be>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87v82livv5.fsf@mailhost.krisman.be>

> Christian, can you please take a look? Eric has also been involved in

Thanks! Looks good to me. I've picked it up for testing in -next.

