Return-Path: <linux-fsdevel+bounces-54083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B4EAFB176
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 12:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DDB21AA1E65
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 10:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A244E288C8F;
	Mon,  7 Jul 2025 10:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8BaGOHS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26DE21C18D;
	Mon,  7 Jul 2025 10:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751885006; cv=none; b=kElQITMQ7Su8UCCVLuS6B3hwdmTo0SbNUGQpEoRvV8ny+iAQmEMQmXxSoOjqo2gDKTQXROxzMc99h0e1OuaGa4H5WlxbqiMLA6ynP5h8bOTrlj1s1oi7+YB5X0vx+J3NRaCpuO9KvMM+qYZ5dKfWEzz/1pVXHxlm3gOBqxxu9Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751885006; c=relaxed/simple;
	bh=stu3Q+QcTgR/93NiqjbzqAzFAk52VnU+GLSlhcLAUoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DO6T2Pl3UWqaugQjgt/ajF+MOv58kxuOY12QjG3/Z1YH6VXB+uzfQSMBNUEVqjojN5EY6cYXqMyP0muUYDh26EZTJTPcm1oJxvC4UFjmgQOxiUJo+DeLig8LwsrU+JCzfNQ7K3yK6vI/iea48o2JPVyNfyEv1XRZO1QUuGpD450=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8BaGOHS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64BC1C4CEE3;
	Mon,  7 Jul 2025 10:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751885005;
	bh=stu3Q+QcTgR/93NiqjbzqAzFAk52VnU+GLSlhcLAUoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R8BaGOHSrT207otTZdX0Si0QmQ27oW8daZwTMWBLLiMcSJCwdCV0bsTFeooN4VC+d
	 ybygqcRpXCDh06KJNgS5yjSJRCN9IixN/8XiJ8zi0jqpBYrBukEr90QbsQPcyHlMRQ
	 V2o/XBuaIptiuA6DWpuNOduaeurL8URH44S6z/j8rQ+xtcvFkL/FDlSEQf4CXtvv/9
	 Zr62Jeu0ffoVKlo+wPVLQPQ0227Yv0/7JQm2tIIoejEx0j5UsVAZJ1jmTK+S7TSvXx
	 QXMZCbY4qeHs+YG9zzryWpBecK65ylPOEQqjg1LTu2pHMqvNSAiX/1UyG7dsDGkLRO
	 X3vMTIVDJ1/Zg==
Date: Mon, 7 Jul 2025 12:43:19 +0200
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Tingmao Wang <m@maowtm.org>, 
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, Song Liu <song@kernel.org>, bpf@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, 
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	viro@zeniv.linux.org.uk, jack@suse.cz, kpsingh@kernel.org, mattbobrowski@google.com, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Subject: Re: [PATCH v5 bpf-next 0/5] bpf path iterator
Message-ID: <20250707-unnachahmlich-meditation-58a3ddcdaeda@brauner>
References: <>
 <4577db64-64f2-4102-b00e-2e7921638a7c@maowtm.org>
 <175089992300.2280845.10831299451925894203@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <175089992300.2280845.10831299451925894203@noble.neil.brown.name>

> Those are implementation details internal to namei.c.  Certainly this
> function wouldn't use all of the fields in nameidata, but it doesn't
> hurt to have a few fields in a struct on the stack which don't get used.
> Keeping the code simple and uniform is much more important.  Using

Exactly.

> Certainly vfs_walk_ancestors() would fallback to ref-walk if rcu-walk
> resulted in -ECHILD - just like all other path walking code in namei.c.
> This would be largely transparent to the caller - the caller would only
> see that the callback received a NULL path indicating a restart.  It
> wouldn't need to know why.

Yes, that's also what I mentioned in an earlier mail.

