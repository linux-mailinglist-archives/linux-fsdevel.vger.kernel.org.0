Return-Path: <linux-fsdevel+bounces-27283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7287F96005A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 06:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D2451C2145A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 04:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BEF5A4D5;
	Tue, 27 Aug 2024 04:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="G+gl7nFz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D192168B1;
	Tue, 27 Aug 2024 04:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724733512; cv=none; b=kVIkO2CEfjVIaJvGgYtu6V70bMOwDE24+74NdCwIwVd4Z28/VOFJN7q83GEoUNQ1/ASSX/7ZnlygtWo7phLyWm9KX/yVAnB+Cv5m4A7X/U+FEp4xL7Qa+YFKBY5Wt+8bpanC4CtXd1p6z3GRiFzfP2KBeOjtAeWieMBDE78EWUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724733512; c=relaxed/simple;
	bh=c6pKoqwuk772POxvjRR0/RQgGntmel0WU6LXGtNzUvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kO+iAsKuhUVND/4+uMSEFpm4UHALFEH/2YSc/oBx8pWZwrEDASNJF7tqm74UdyQRWoZOX7Rza0+DiN+pE2QzqnW2Tpbi5UGcWsHdcM4Z9FzYBCrM8f1l48mRpz+tXefFkCIeWs0lqt/Rbfx/r2Qu/NNAr792KcFHAZOTwii/Hjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=G+gl7nFz; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id A70BA14C1E1;
	Tue, 27 Aug 2024 06:38:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1724733503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OnUOFfa1cXvnH0vOKRLWJ6eyfhXm7lycmgGX8luzNU8=;
	b=G+gl7nFzeTofUcm536xpOmm3Qw/J3YD2DA7/AVAd83QME9pVbEoosQksjVWi1/HCMZcfJ5
	1azFTqhIalv1JIfR74tCSWnxaAA/nKmMVxTAMtuy5BG/KHVWlCJfQp1v/h+4VA3gwUJoV+
	Am8NofUvQEQC7cr27qJQ3+mA798vWkaEhGBNwa8ojcCYa52ZRrDC7w+E8xCegyCJ7Jj6Y/
	OYM0UNPvbm22X6IeM2w7ZCjRTGYGoqZ3symSV1GP0dd0oVE9Tmw9UYd8gkxPDqV+hkrWLw
	38uGDtuXRSeRPilAgrashdU5X3BpvXQksLZ35ypFTbwiySug/XgEo5HZ6c5Dyw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 1599ead8;
	Tue, 27 Aug 2024 04:38:17 +0000 (UTC)
Date: Tue, 27 Aug 2024 13:38:02 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Steve French <smfrench@gmail.com>
Cc: Forest <forestix@nom.one>, David Howells <dhowells@redhat.com>,
	Steve French <sfrench@samba.org>,
	Shyam Prasad N <nspmangalore@gmail.com>,
	Rohith Surabattula <rohiths.msft@gmail.com>,
	Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, regressions@lists.linux.dev,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [REGRESSION] cifs: Subreq overread in dmesg, invalid argument &
 no data available in apps
Message-ID: <Zs1YKh8H0dEX126X@codewreck.org>
References: <37fncjpgsq45becdf2pdju0idf3hj3dtmb@sonic.net>
 <CAH2r5mtZAGg4kC8ERMog=X8MRoup3Wcp1YC7j+d08pXsifXCCg@mail.gmail.com>
 <CAH2r5mt99dz9AjEYvMpBUXoNLePdbK5p0OuH0Lq1tf4m+ExLpw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH2r5mt99dz9AjEYvMpBUXoNLePdbK5p0OuH0Lq1tf4m+ExLpw@mail.gmail.com>

Steve French wrote on Mon, Aug 26, 2024 at 11:27:33PM -0500:
> I have also confirmed your theory that the regressions (there are
> multiple) were likely caused by the netfs change added between
> 6.11-rc3 and 6.11-rc4:
>         " 9p: Fix DIO read through netfs"
> 
> But reverting the cifs.ko part of that patch alters the error but does
> not completely fix the problem, so the netfs change is also related

David sent a bunch of cifs fixes including this patch:
https://lore.kernel.org/r/20240823200819.532106-8-dhowells@redhat.com
"netfs, cifs: Fix handling of short DIO read"


I don't have any samba server around to try myself, did you have a
chance to have a look?

That "9p" commit touches all netfs filesystems and definitely shouldn't
have been labeled 9p (even if it does fix a 9p regression from an
earlier netfs commit...), and this all feels a bit like falling forward
but hopefully we can get this all fixed by the time 6.11 is ready...
-- 
Dominique

