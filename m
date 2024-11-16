Return-Path: <linux-fsdevel+bounces-35027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6B29D013D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Nov 2024 23:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAA521F22FEC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Nov 2024 22:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A661B0F12;
	Sat, 16 Nov 2024 22:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="YXg7K+7D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A0D19004A;
	Sat, 16 Nov 2024 22:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731795627; cv=none; b=MBMNSnIJ0x3P5C5pempr0IZiRts2A0YiXqLhKMRPXdLvd0vuZmdSVed5b1VOzZ6aeoM7DuJTLDIf1skTF8LdWSf5TgKNNreRx0DmrBJhwRGsgCQvUqAfXT3je+Ls6asR28ielnHIyMHSOnzv8P2yGtUpAMheQDYND3Pjf+ifSWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731795627; c=relaxed/simple;
	bh=zG3lsvkchGGddMCV5F5tTsLTAmiTZzRvR7QUvDg8d8k=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Mic/bQOoNaNjsaYjV+FBNAlX9brL6zmnhtAF2GAiUfjEgE++OxarKZJv7V0wuL9gJaOVuswtTwxu5KiwjTcI6trE6p2eikPNtJAF2bujMxd+iyVpQMlrii/7xVFrV7W4RSNnFGC9D4lLX4SoUQwZiyCvIdJWrFYalnIon7ptJkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=YXg7K+7D; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B33FC403E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1731795616; bh=rnLOFZZDEy+qyRI0xpVNtGzIX3qjRaGSTJ7RXKfL49w=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=YXg7K+7Dg2WW9s8rfxbke9ShI3MTXLbJgwgFGQ0ixdkgISr5G6wmLhBLpp4gnnDRl
	 snWsKiwKEIpdUwQx3j7bQOxFCg9O6nGdYOpRChB4wuHYXwNfd7hFCPIf8GJiJWCU5E
	 a7ADoN90g4dF0sJ3RGaCZOepnzfbPtrz/qmB7TZmvTwOXYx9EvxXS5wSMXVrvGOTTh
	 NprtpKcOtYKJlkrgsojbACxTrYsDbHHLpNyqKR+QUZmxLaOodWx0kN6x516Tz6k5TU
	 z2VNLpsc53uhCPyHbFlAzBJxmCH9qpP65iclUbYVTba+ouCIWOEY/xn257LjhU8KTs
	 VhUHSQ4i9BHWA==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id B33FC403E5;
	Sat, 16 Nov 2024 22:20:16 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, pasha.tatashin@soleen.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org,
 akpm@linux-foundation.org, derek.kiernan@amd.com, dragan.cvetic@amd.com,
 arnd@arndb.de, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
 brauner@kernel.org, jack@suse.cz, tj@kernel.org, hannes@cmpxchg.org,
 mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, Liam.Howlett@oracle.com,
 lorenzo.stoakes@oracle.com, vbabka@suse.cz, jannh@google.com,
 shuah@kernel.org, vegard.nossum@oracle.com, vattunuru@marvell.com,
 schalla@marvell.com, david@redhat.com, willy@infradead.org,
 osalvador@suse.de, usama.anjum@collabora.com, andrii@kernel.org,
 ryan.roberts@arm.com, peterx@redhat.com, oleg@redhat.com,
 tandersen@netflix.com, rientjes@google.com, gthelen@google.com
Subject: Re: [RFCv1 4/6] misc/page_detective: Introduce Page Detective
In-Reply-To: <20241116175922.3265872-5-pasha.tatashin@soleen.com>
References: <20241116175922.3265872-1-pasha.tatashin@soleen.com>
 <20241116175922.3265872-5-pasha.tatashin@soleen.com>
Date: Sat, 16 Nov 2024 15:20:15 -0700
Message-ID: <87cyiukehs.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pasha Tatashin <pasha.tatashin@soleen.com> writes:

> Page Detective is a kernel debugging tool that provides detailed
> information about the usage and mapping of physical memory pages.
>
> It operates through the Linux debugfs interface, providing access
> to both virtual and physical address inquiries. The output, presented
> via kernel log messages (accessible with dmesg), will help
> administrators and developers understand how specific pages are
> utilized by the system.
>
> This tool can be used to investigate various memory-related issues,
> such as checksum failures during live migration, filesystem journal
> failures, general segfaults, or other corruptions.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  Documentation/misc-devices/index.rst          |   1 +
>  Documentation/misc-devices/page_detective.rst |  78 ++

This seems like a strange place to bury this document - who will look
for it here?  Even if it is truly implemented as a misc device (I didn't
look), the documentation would belong either in the admin guide or with
the MM docs, it seems to me...?

Thanks,

jon

