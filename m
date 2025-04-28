Return-Path: <linux-fsdevel+bounces-47491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7918A9EA04
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 09:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FC99188D425
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 07:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C445222565;
	Mon, 28 Apr 2025 07:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tm1enXHZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47F52222B3
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Apr 2025 07:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745826715; cv=none; b=Cdox1CCsc9QPZItxCGsImBs5Y8AHS3xsy+4u2LHpEWmGmF7a5gNOcZGKZtmknK8QXqvaZUCavrA96SLGKBe4a0zpLrpeqm22oc6CpsdEyr+EGqKiKV+dLbHcMDf1f63xx1StmarjDU6yyA1Znm+yOh2m9BXnqdUuLLqAoleC4ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745826715; c=relaxed/simple;
	bh=LSHAhn66y+8P2DqYumkZSIqkCJkEHZ/ljceKE6nx/CQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HN3LG0jAHmCk6CCrF3bTrLds3sqKXDykl2mF6SwLRM9qG0NEggcKS8ccrJfZgV8QtrnRTigdTCoC+WWODqJwAGo7R73GQBjgUU6KkPvgrHqQ6QtMabYFFOEqEEt8im+kEbPywYnvwi1Md8x1hdIuIxQazweMiCwKJ00an1ddg3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tm1enXHZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A09BEC4CEE4;
	Mon, 28 Apr 2025 07:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745826714;
	bh=LSHAhn66y+8P2DqYumkZSIqkCJkEHZ/ljceKE6nx/CQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tm1enXHZx2B+PjZYp5MFm6VBDg6YccvVg76+Lyio9kAN13UBNsZE5XcldpXixtHlS
	 KEepCY4MCaN7tKi3pG9CdDSqIS1i4s7+xKSJy8FuoX3lHEVsC6QFfMmseq81W5lWJT
	 r1Dox/WJjbJBid4Ku5nVGDWb7TdOyeLoJA5bsbsD/zSg/SnaU3INNjjmqA1nU2mfbR
	 PzGfEhaQpDLL3Fcdi9ci5KDpyUmLnewSy4DWXyXV0j+iV0QX/qVgXj/hOI09UrPmEn
	 U7KxIAiGom+KfvAlliEsHtFTut4icBYAXo5Ho9JkJzyj2+XH+9CBJ6A1GATXr5S9vR
	 ax2zCfAlTieyw==
Date: Mon, 28 Apr 2025 09:51:51 +0200
From: Christian Brauner <brauner@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [bug report] coredump: hand a pidfd to the usermode coredump
 helper
Message-ID: <20250428-unkoordiniert-ausnimmt-c47f4ac81ad8@brauner>
References: <aAua6ufHsy6qhMcs@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aAua6ufHsy6qhMcs@stanley.mountain>

On Fri, Apr 25, 2025 at 05:23:38PM +0300, Dan Carpenter wrote:
> Hello Christian Brauner,
> 
> Commit 4268b86fe0c7 ("coredump: hand a pidfd to the usermode coredump
> helper") from Apr 14, 2025 (linux-next), leads to the following
> Smatch static checker warning:
> 
> 	fs/coredump.c:556 umh_coredump_setup()
> 	warn: re-assigning __cleanup__ ptr 'pidfs_file'

It's only with CONFIG_DEBUG_VFS and I've already removed that assert
in-tree and should've shown up in linux-next. Thanks!

