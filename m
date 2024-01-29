Return-Path: <linux-fsdevel+bounces-9392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF098409ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 16:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87A3DB23FD0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 15:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BE0153BCE;
	Mon, 29 Jan 2024 15:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q0HvbDS2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579E6153BC8;
	Mon, 29 Jan 2024 15:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706542177; cv=none; b=bfhnLE8sJPn+owqkvjMsVK+GnsivZAEL7TAGQJpYnJuo3VfXBG5RLCcRV8CoecS9AnojuCZQGQo1baDkxRZWkIZgzl3aEqnwqc66h4UGYSR8mD9cIHuLfwsR1HFq9eBeore1lyJh9y3vgirW2Vcy4AyffZSuxCoWvdyC+ArlDks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706542177; c=relaxed/simple;
	bh=DVIU5f/0s1xTiAVYDUxFxNiL/wgdqiW6RWz3Yy0N6eU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOrGSQK0qs21H7i+ASNLvtsnpZK1nVhSPO+N/9dbnDm2p/C7HfRXVRGhhBe0p5kzuiR6+hLSQyobnfSUE/7WYy6f2LTpcHg9MpavNAsdkhLho84NL/VyBiXG7ZnlDz5GfCIP2f/y2SWo2bvpwHuWrWXE7gtzvcZd+Q9iPkTV7Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q0HvbDS2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D487CC433C7;
	Mon, 29 Jan 2024 15:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706542176;
	bh=DVIU5f/0s1xTiAVYDUxFxNiL/wgdqiW6RWz3Yy0N6eU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q0HvbDS2WMAky5P9/vveAhYlGLOY+CahQsZIvtb6Ud2FsikTNX82J4dfO5ND4IpgR
	 aURHZFgtAr/5F2yAaNHj95PCQ0aVjZjPCQbdHQuj2U+TP8hCc9F7VkSF8ss2NLZF3Q
	 2xrTAAj9MX1BRDE6cmn1U8gtslnO1eK9XCGYlboBIDDQTVrp+uRbkWJG7GokGBqcN7
	 bhuoGIDdZW81jxKQaQSTf72Mzmg9k7LlxrIYQ3Aa2M/LdrcPFXaFnkR1sVsXHUKTBi
	 nSyBMZOSa/jblbtpW2FMRpK6jU6snEm21SWUcMGe4CL4HMCxp05UXMLIrvAUMoVUgY
	 la0VMUhyNIJuQ==
Date: Mon, 29 Jan 2024 16:29:32 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] fs,drivers: remove bdev_inode() usage outside of
 block layer and drivers
Message-ID: <20240129-lobpreisen-arterien-e300ee15dba8@brauner>
References: <20240129-vfs-bdev-file-bd_inode-v1-0-42eb9eea96cf@kernel.org>
 <20240129-vfs-bdev-file-bd_inode-v1-2-42eb9eea96cf@kernel.org>
 <20240129143709.GA568@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240129143709.GA568@lst.de>

On Mon, Jan 29, 2024 at 03:37:09PM +0100, Christoph Hellwig wrote:
> Most of these really should be using proper high level APIs.  The
> last round of work on this is here:
> 
> https://lore.kernel.org/linux-nilfs/4b11a311-c121-1f44-0ccf-a3966a396994@huaweicloud.com/

Are you saying that I should just drop this patch here?

