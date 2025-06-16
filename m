Return-Path: <linux-fsdevel+bounces-51777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8639ADB42B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 16:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E13E53A1501
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 14:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F79C25A33A;
	Mon, 16 Jun 2025 14:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1cC0GTf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C548258CF6
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jun 2025 14:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750084818; cv=none; b=Fr2eHIepyu52agf9BQLTs2grNBKBNFaX7/5DcqhDZ9ACtwowSx0NSn2D8qP1E2gCpFxTO4cxqFgxg92RQzUwQn3lnJR5b+DWxPW4CziXb/0PBmsGKFsEnUOnrnlNXYVP0LXkbukwjOPHjUTWZOYTcMDlaIJ64Nhfy7xZz+NLwqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750084818; c=relaxed/simple;
	bh=u/ADNPVQfra7CZFRmcY4VC57OceeAVparI8VZLRHKY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UaenkurDcrQKgCwiWuAgTjIglAAxWTVOMf2tWXz+eDY7U2DsoYNvFxi61L8xtoAku0Q0HTElmfd3hhN1Cege9HGFR4IbZxK80nUYx8rEW8E/rGW9LqUgAM3Nk9DXG/uSeC2aBTzElDwIUdV3RodHeVS6g24T+sMSKUZDLICVOW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1cC0GTf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA72C4CEEA;
	Mon, 16 Jun 2025 14:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750084818;
	bh=u/ADNPVQfra7CZFRmcY4VC57OceeAVparI8VZLRHKY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b1cC0GTfHmHcewuRBrekoOUnsQ5lWiPRo2bRq3gZTGiuU1MvjQ3ny0XH6iX+CJib2
	 zqox2GfPwy+LjhNZHEce0gFGe+ILZ9OEXaq2t0ORqAje7o3lVVII1qLibuOBQJAC7N
	 NbjA9t3gNqH9dQ36sYd5pmW2kGHlPeCqmdXg0pGRLzqzEn+ALvD6OhlQdQjYxr0jsT
	 WzQPtj+B5m4CysF83rt5vVYqxqiJqpTRoqWDst2pvvGXUHKNrvPPe58dStcBrk0ffr
	 UIvbcoXAY0k538mw4UoBmAcBBbcg4PP0dobGn2wfJdJWuANS5wkwELdn0/iUxdCnTL
	 LKcQ1aM4UYLzw==
Date: Mon, 16 Jun 2025 16:40:14 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, neil@brown.name, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 3/8] spufs: switch to locked_recursive_removal()
Message-ID: <20250616-unsanft-gegolten-725b6c12e6c8@brauner>
References: <20250614060050.GB1880847@ZenIV>
 <20250614060230.487463-1-viro@zeniv.linux.org.uk>
 <20250614060230.487463-3-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250614060230.487463-3-viro@zeniv.linux.org.uk>

On Sat, Jun 14, 2025 at 07:02:25AM +0100, Al Viro wrote:
> ... and fix an old deadlock on spufs_mkdir() failures to populate
> subdirectory - spufs_rmdir() had always been taking lock on the
> victim, so doing it while the victim is locked is a bad idea.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Fwiw, I think simple_recursive_removal_locked() might be better.
It's longer and arguably uglier but it clearer communicates that its the
same helper as simple_recursive_removal() just with the assumption that
the caller already holds the lock.

Reviewed-by: Christian Brauner <brauner@kernel.org>

