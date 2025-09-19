Return-Path: <linux-fsdevel+bounces-62229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A147B89730
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 14:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FBE11C2332C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 12:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23A7311C06;
	Fri, 19 Sep 2025 12:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUDPFrf3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA4430CD8F;
	Fri, 19 Sep 2025 12:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758284897; cv=none; b=gR6IcnlbVSIYn3NdbnWI9prYIZIriy2PERHByUBsGpZO36zGKH9r0mA9fB2EwoaKouM/XgfTLe5t9REkx0RE78YjQDAnNm2YJf6NTya61LWglnDfbddRWEYM9Z25962zOD3RRfEOCiNdtGe+9+okMcLlLQzmA2Kr6mU7jThcykI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758284897; c=relaxed/simple;
	bh=QhX8AH5MtVUOK9BL2PRy+sv8z6nwtfAy40h0RBCMH5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTOK43ZDIzxnTrV4g+peHph+vZMIxKay9rKu46hPS4aEJjbjtTveq5mAMZgnEbGFdsAJjTuK3fuJJJA/qV4KrXrgs4rzbLltejnM7f/KAX4dTzKOiojPi3PEMSbLvYBO1OvV6bPUDry7Hs0ywnIJVLFJpJs0CzA8e3y/hyQbNUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUDPFrf3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC15DC4CEF0;
	Fri, 19 Sep 2025 12:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758284896;
	bh=QhX8AH5MtVUOK9BL2PRy+sv8z6nwtfAy40h0RBCMH5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PUDPFrf3RdC2sYapaMukOjNsgMPnhq+ORpmDSmGfxf+VvQ6TKLZy4YRc2EEi9UAaF
	 sBm7KBgR39FeFD8TygEuqsjxgf/lyRSW/v3dd6qAUF3n1BbltrDlaiPvSLcMpLcbiU
	 vBvubNXymnbqOd+cJ2kzqGHFe/eaP5hsg1ZeJ7zJruKBT1Mw5chvPJ8UxtcwC1fwRQ
	 GpKBv884yoHskqA90TVrj7BjU5LhnugrgKlRgJ5RUcoAxZYd06ktSbm/5oaROvWRLi
	 wf0c+4R1xQNOwklAXLRYJC/uWi4FWvnGOI22+PyEzf/W4zFO7Urc60VZ1MQ5eOXFvP
	 rLFJW65/Hf0Yg==
Date: Fri, 19 Sep 2025 14:28:08 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Mark Brown <broonie@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	netdev@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH v2 04/33] block: use extensible_ioctl_valid()
Message-ID: <20250919-apparat-zeitraffer-a52a9de75d43@brauner>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
 <20250912-work-namespace-v2-4-1a247645cef5@kernel.org>
 <02da33e3-6583-4344-892f-a9784b9c5b1b@sirena.org.uk>
 <aMlouk_55OXZv8w5@stanley.mountain>
 <dg5xugicejwym44ibxl24st3xgicga6dzryoxvklqoix3an6js@qkcpc5ig7n56>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dg5xugicejwym44ibxl24st3xgicga6dzryoxvklqoix3an6js@qkcpc5ig7n56>

On Thu, Sep 18, 2025 at 03:17:54PM +0200, Jan Kara wrote:
> Christian, this bug still seems to be present in your vfs.all branch. Can
> you please fix it up? Thanks!

Sorry, I fixed this now!

