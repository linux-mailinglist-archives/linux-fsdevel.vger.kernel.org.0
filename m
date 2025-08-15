Return-Path: <linux-fsdevel+bounces-58053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD21B28760
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 22:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F1C14E1410
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 20:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918E12BDC3E;
	Fri, 15 Aug 2025 20:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="MMS4D2j+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5B01E2602;
	Fri, 15 Aug 2025 20:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755290972; cv=none; b=B8Ucy1Miv/cIBOJXkucXDZ9aKJvJBf7ywi7m1YdFKePC57w8tHCNwTeMWyBlBUBXW0u0VgVp6vcbIDoAO6kconlhy9v95hjY9mmTmxuIaNWKtVapNkhboIXkrmCTp7Pfou3YOKoETaiFP1wjqIpCkWja4h2q4EqHasXGxBQCBI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755290972; c=relaxed/simple;
	bh=vT+tDKPxo0KUw1Hlfw/M0wJ3peG5bCfuumo+RuHxKIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUacox0R+TktWVDTlwDu0BEkBTsQTtQWiccE8IeKuOa2giQFzItfWXZGog7K5/ySzwuE+Wye2rK3WgnfcDME9YQxQDaom1Vpxb/B/i9lfzMcYDhc2MP48WWrmmAnrBjfFyBW4bIn+g8tMiAcc13OaBTddn85NPjs1EIpYtkbN5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=MMS4D2j+; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id D9E2114C2D3;
	Fri, 15 Aug 2025 22:49:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1755290967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HPhmjiq2J+FT0At5wfNjodTVpwV1k67zDG95jY/AKZ8=;
	b=MMS4D2j+8VfPogQzJhPQ/qZsnXDDqFtkYhMZftHUqiHD4X4qDinuqmUQp/zCIsiEwmUEk/
	9DRUVXWt+g2TFpoXQhRIE9z3ynUwVCXoKRGKeXkfPkTmke6j6SjilzR/5NWuAgGuY3dcqx
	9SSfsYcsMStsAjoh3VcGKGv4v2dkxWO9L6yTqQHPxMnNsSufOo8cFS2eG1MTACb9CjzKgu
	difj1EbNtsztIuWjJhtHYHqi73sdCFeWUy9GQz07BEn+fd14GfrZRk82sH22TARd4k/25d
	jASAKr6M/EaqwbGowyU1ik6GxKlMMAPEd5krghOTWB5alSstdJ4+mmMSrWp0Kw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id c855c45e;
	Fri, 15 Aug 2025 20:49:22 +0000 (UTC)
Date: Sat, 16 Aug 2025 05:49:07 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Maximilian Bosch <maximilian@mbosch.me>, Ryan Lahfa <ryan@lahfa.xyz>,
	Christian Theune <ct@flyingcircus.io>,
	Arnout Engelen <arnout@bzzt.net>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Howells <dhowells@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 0/2] iterate_folioq bug when offset==size (Was:
 [REGRESSION] 9pfs issues on 6.12-rc1)
Message-ID: <aJ-dQ2QN26h24Nz9@codewreck.org>
References: <20250813-iot_iter_folio-v3-0-a0ffad2b665a@codewreck.org>
 <20250815-scheckig-depesche-5de55f7855d1@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250815-scheckig-depesche-5de55f7855d1@brauner>

Hi Christian,

Christian Brauner wrote on Fri, Aug 15, 2025 at 04:16:33PM +0200:
> Applied to the vfs.fixes branch of the vfs/vfs.git tree.
> Patches in the vfs.fixes branch should appear in linux-next soon.

I'm not sure which is better as this is halfway between vfs and mm,
but Andrew seems to have picked this up in the mm tree:
- patch1 to mm-hotfixes-unstable
https://lkml.kernel.org/r/20250813231639.B7E61C4CEEB@smtp.kernel.org
- patch2 to mm-nonmm-unstable
https://lkml.kernel.org/r/20250813231515.7AADEC4CEF5@smtp.kernel.org

(and both patches are in -next right now, so I expect you'll get pinged
by Stephen in a bit...)


Thanks,
-- 
Dominique Martinet | Asmadeus

