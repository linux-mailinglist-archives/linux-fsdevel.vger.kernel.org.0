Return-Path: <linux-fsdevel+bounces-17120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BD38A81AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 13:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2EB2286FB9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 11:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D8B13C818;
	Wed, 17 Apr 2024 11:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPw9WebT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950E86A02E;
	Wed, 17 Apr 2024 11:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713351928; cv=none; b=HLoDJ79wX+F7d8b+sLvzOhV5VUwg+KVogbVYBTKU65pX3Rn79gCwKcRRuQcGX64mouugIhf2RcJnJNP9nRHoXAxCuTPDQAz1rOuQB3feRsKkC6saTPiPjqxUWZ3ZowbkMz/S4/BUsEy/yUbzUxMLj7PoPnVHmxc+4+Uike1ctCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713351928; c=relaxed/simple;
	bh=teEzSd3t8z1ez9VtLi7vPomBjT66jWsI4eWJ21jqIfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmDC+TWPL8JdEH7Qv0eANWvFpxqg7TsrivYrMXZVDEoBOFj7OuvxaZ7MPqGi2A/2vbTELO1/caBO99T3Ry4GvIqY1s0lBcxUM2x6/1Y/9CfEFpBbzRN5cChFSrUThZCYGSno6Q4lin9c3RSUY70si6KCwiL1VJipe5ZY4m2Qqk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPw9WebT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20362C2BD10;
	Wed, 17 Apr 2024 11:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713351928;
	bh=teEzSd3t8z1ez9VtLi7vPomBjT66jWsI4eWJ21jqIfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oPw9WebT/45Zz6/7Cw9s908tfZTVC17kagwvCLVUKj5NuKsbNtKEvAdW4GPqUFPx/
	 SB1N1sjHKjqKJsx7U8vNjW4FLSVNIjTGfL06B0ZRd6uGi74QIYmJnA5S5RW3ruJ/EK
	 9rKbsGX/etaU4XjOheO48LjyWmHUoJKinoi3kFodCSHHLSXJ5o5o/MPZMgX30HUJJt
	 VGDoVZJ4JptHZSeLtrtwpitMqLwh9Bty9CWyp32/Pzq2K/BmD/lzhZR87MUiiuzIWO
	 QtfLwSLAB3bUZJzSjXYFy73aFGF5u7b1NjtHk0g01yGB/+OxEd0cL/nkRLTl6lqH1Y
	 23cs1Blr0ZB+A==
Date: Wed, 17 Apr 2024 13:05:22 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>, Yu Kuai <yukuai1@huaweicloud.com>, hch@lst.de, 
	axboe@kernel.dk, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH 01/11] block_device: add a pointer to struct
 address_space (page cache of bdev)
Message-ID: <20240417-senkrecht-sinkt-95bb7d77d7fa@brauner>
References: <20240411144930.GI2118490@ZenIV>
 <20240411145346.2516848-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240411145346.2516848-1-viro@zeniv.linux.org.uk>

On Thu, Apr 11, 2024 at 03:53:36PM +0100, Al Viro wrote:
> points to ->i_data of coallocated inode.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

I've picked all of this into vfs.super btw. I still want to go through
your reply but as you know I'm a bit time-constrained for a bit more. :/

