Return-Path: <linux-fsdevel+bounces-60362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB2EB45A13
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 16:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 068865A5E58
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 14:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E1E35FC15;
	Fri,  5 Sep 2025 14:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dac1A/TQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07DB1D79BE;
	Fri,  5 Sep 2025 14:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757081279; cv=none; b=IlOOOb7mMY1AtkXLgGeAjXSo1KZtd+hNKnmjVqLNISrzDw9sFlWqdV5yC8wBkhQX47+8lIProw0nsG332tassNFrTGtoumToJYN8BqDx9GCnROZFTFByxlk7BpvR2oDOoZY6sU2unj1j12+ANrdMdNQ8ZNxGC5mTIKbLCMKq6Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757081279; c=relaxed/simple;
	bh=D7ilWtLEL/M8Lnilo8+XiVASUwlDJivUteumgIELcp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kR2AzYU+Wo47qWVUoDqwpRuWCMdTwT1AF2MEBiUvic9XjgS5nwqBWwjCgldA8OK2NwynGKirOfgf1YXw5zOttLJhVpKs7w6CRl+7cLh+0Khj5VAQassd4JFHrdqnFfFme9YnOfqz31nNWg6LIdB1eV8cN6jliN5YxzmhXhrDjF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dac1A/TQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98653C4CEF1;
	Fri,  5 Sep 2025 14:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757081279;
	bh=D7ilWtLEL/M8Lnilo8+XiVASUwlDJivUteumgIELcp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dac1A/TQgJlddaHi2gJ+rrhAuU80FHe55XD4QfoZ15+ClY3eFPbaAyU2t7ByT8JkR
	 o/daTTD0TNQxvvaLJ7IJYtC8e50o4QhZjpkixx4gEgi5oqs2w5CxSNcYhkwd2hyHve
	 6n6ekWRvVpukPKJLVYusFjGby5MUx+2xtxrn0n6wMmtLYbQeXFYJtCVB9n4irE4T8K
	 ny1MjcZm4jfRKPYzLsWb3lxUbmV528sQIRQJ57uRYPkIeYadn2o5hBgq95reM4nZGf
	 /fL2pAFgI+4ezpDnvv1xH1SBle3rNM5CqeEuoU+SjNpYJglpzlo14M0PNujWb0dXyV
	 8h9IxMjCLtBeQ==
Date: Fri, 5 Sep 2025 16:07:54 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, kernel-team@fb.com, amir73il@gmail.com, 
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [WIP RFC PATCH] fs: retire I_WILL_FREE
Message-ID: <20250905-frohe-anbinden-0af1a85f11ab@brauner>
References: <20250902145428.456510-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250902145428.456510-1-mjguzik@gmail.com>

> For the life of me I could not figure out if write_inode_now() is legal
> to call in ->evict_inode later and have no means to test, so I devised a

Welcome to our meticulously documented and simultaneously
self-explanatory codebase.

