Return-Path: <linux-fsdevel+bounces-58054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F228CB2876A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 22:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18C431B62A66
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 20:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD8729993B;
	Fri, 15 Aug 2025 20:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="Cx/RWPy6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F383121C195;
	Fri, 15 Aug 2025 20:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755291210; cv=none; b=UZ+6cBDyjx22qzygDlsCWqMum4++8HKC40tUT7vL/ifJkHTHAR1YA4JP87//imu+UrBVKEo+ZmwF/v6ICRVCUTY6QgC3Oe8ChEahbtRZm5Y2trbr4GQMBhjA81Py0sCK2G9bkTjVTFpQBMcLVhYUSDOrnzrNMUArKK4kCYvwrX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755291210; c=relaxed/simple;
	bh=U/Ro8vz/iAp/7iBIzHwAUhMzP4MGPKMHRji3pFwym08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQN2sBB2yyaJ7M/j66hFhQePJSmVJEE8O1VJc/asXxEonXlWiSKVhKUlKwDmep92GOqO+tiyIyh22Sz9eihzirtA4dIqYUgk3NHb3u3CSvt0VYrOrMQMAxMMezpT4IsvMUmkR2q1o9cPvFRFEWDcvpIJuzfXAHyy9QxlkoNv8Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=Cx/RWPy6; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 27EE314C2D3;
	Fri, 15 Aug 2025 22:53:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1755291208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sC8Nx2zlJ569RHndJFpGErR2BoHbhdIvqK5HeCPv+/8=;
	b=Cx/RWPy6XkGb918pyNolHn4uGEaAQ1vfPDBUoMGkjBFqLI8nw3HsvQxv1Bk1DptR5lm/v+
	pFjZpmohnhpy/l+NWMn74sYYdbga/2yXUXJbqC8z9Jnvl+Hvt9nwlWtMkh215lmC8tKNab
	tTxds72ASkICX+tpvvsvaybfJQo86RTknqg1owD0tk/5oo8o5MkEPZTcFdGtikP7suYcgA
	Xk8lvlOxd4W2RTJAQ5WSgwlF2rxvCYqB3zsNcoVd+RTXKrxRFTCDw+urqKTiTJyW6CGN4P
	JvRQ6HPTXCP02jF09YaTemCbsVtm3BGgiU94850YJNHbKJahSQ/+5tCZrT/kMg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id df44282f;
	Fri, 15 Aug 2025 20:53:23 +0000 (UTC)
Date: Sat, 16 Aug 2025 05:53:08 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Eric Sandeen <sandeen@sandeen.net>, Eric Sandeen <sandeen@redhat.com>,
	v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ericvh@kernel.org, lucho@ionkov.net,
	linux_oss@crudebyte.com, dhowells@redhat.com
Subject: Re: [PATCH V2 0/4] 9p: convert to the new mount API
Message-ID: <aJ-eNBtjEuYidHiu@codewreck.org>
References: <20250730192511.2161333-1-sandeen@redhat.com>
 <aIqa3cdv3whfNhfP@codewreck.org>
 <6e965060-7b1b-4bbf-b99b-fc0f79b860f8@sandeen.net>
 <aJ6SPLaYUEtkTFWc@codewreck.org>
 <20250815-gebohrt-stollen-b1747c01ce40@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250815-gebohrt-stollen-b1747c01ce40@brauner>

Christian Brauner wrote on Fri, Aug 15, 2025 at 03:55:13PM +0200:
> Fyi, Eric (Sandeen) is talking about me, Christian Brauner, whereas you
> seem to be thinking of Christian Schoenebeck...

Ah, yes.. (He's also in cc, although is name doesn't show up in his
linux_oss@crudebyte mail)

Well, that makes more sense; I've picked up the patches now so I think
it's fine as it is but happy to drop the set if you have any reason to
want them, just let me know.
-- 
Dominique

