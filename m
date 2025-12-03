Return-Path: <linux-fsdevel+bounces-70562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48607C9F6AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 16:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 536013000959
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 15:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B9631961F;
	Wed,  3 Dec 2025 15:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="Z+Us54k7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939CC3195FB;
	Wed,  3 Dec 2025 15:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764774291; cv=none; b=mFymIY6MDiDzVRR8DxLYcbnslV+sgbOOhdFR1G+UPMAT6PbB/gpBnCEmM11zQ4/HsD48bLHxdpmDnavqJxCzmUMXCpcCwwHHKje43/vus/SIo6Qkl7XlQ7eLI4qhYZCltoIvWA+koizz6N8FDQZNq98htk+7GvRomlnRJKd587s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764774291; c=relaxed/simple;
	bh=T8ms1WcQVOIxEyZthB7YUiFTBuQHprL7hEGnbLFBJP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SD4TTsB5xKa0mANDKZ8oK5uuJ+OhNukbxg7nxOSmyV9SkNab1nGahJmAy8jsKv84Id1OEGR6DC+ogJ5o5SE8CjUNnVr9Op5pmgMbc8DLAxN9uNeJ9oG6sWu+IkisKfgTQKC17ULv3uALNjpM0EaRULZ76mT8G6gzPJ8XCDAqMME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=Z+Us54k7; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 2EA3814C2D6;
	Wed,  3 Dec 2025 16:04:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1764774281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=36FRYFsxMH2qjWK3MdPzV9wfli6X/mz5VG8zURIgZPo=;
	b=Z+Us54k79XHg6Q79rxHJ8pvOptAqYYXvjWza7nLcZo3jdX6fsKnxFY+vnLmNt5tcGeWYEL
	DKeOQJBqGF1T2oAl8Ffr1lnCyn567Lavu9Gw36orkwJvhRZnvpDpYl5JqqqFfpaQJYRjHk
	nt/ArkYSHLvE4z264Un7GFb2I3mb54Rar1+H3JeYGamgm2UU1tMKM/XLLffjmpSo/AIR5/
	vALOnnxLn5+BV1zgiBthBnLyT1CGHfVLuG0w2cyMmlxHdvjtTa8Z1u4DwfFIToF8GX7Dk7
	D8XKHjCC39IaKFvcDUNpY2OPkOGwTn6zd5Mn25mjuzfYpTpP4UHXD4Q5uCTnmA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 690ba842;
	Wed, 3 Dec 2025 15:04:36 +0000 (UTC)
Date: Thu, 4 Dec 2025 00:04:21 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
	eadavis@qq.com, Remi Pommarel <repk@triplefau.lt>
Subject: Re: [PATCH V3 5/4] 9p: fix cache option printing in v9fs_show_options
Message-ID: <aTBRdeUvqF4rX778@codewreck.org>
References: <20251010214222.1347785-1-sandeen@redhat.com>
 <20251010214222.1347785-5-sandeen@redhat.com>
 <54b93378-dcf1-4b04-922d-c8b4393da299@redhat.com>
 <20251202231352.GF1712166@ZenIV>
 <c1d0a33e-768a-45ee-b870-e84c25b04896@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c1d0a33e-768a-45ee-b870-e84c25b04896@redhat.com>

Eric Sandeen wrote on Tue, Dec 02, 2025 at 07:09:42PM -0600:
> >> -		seq_printf(m, ",cache=%x", v9ses->cache);
> >> +		seq_printf(m, ",cache=0x%x", v9ses->cache);
> > 
> > What's wrong with "cache=%#x"?
> 
> Nothing, presumably - I did not know this existed TBH.
> 
> (looks like that usage is about 1/10 of 0x%x currently)

I don't have any preference here, but I've folded in %#x when applying
because why not -- I've been seeing it slightly more often lately so I
guess it's the "modern way" of doing this.

(I got curious and this SPECIAL flag in lib/vsprintf.c has been around
since at least the first 2.6.12-rc2 git commit, so there's nothing new
about it and I suspect it'll never quite be popular...)

-- 
Dominique Martinet | Asmadeus

