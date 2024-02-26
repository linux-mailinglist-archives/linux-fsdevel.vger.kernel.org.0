Return-Path: <linux-fsdevel+bounces-12752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B9B866A34
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 07:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A65BB1F22DC4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 06:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6961B94C;
	Mon, 26 Feb 2024 06:45:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817C418E2A;
	Mon, 26 Feb 2024 06:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708929927; cv=none; b=OpihSQFR9UiM5HP/NWDKrMpWjUxhhVBWoF2/XdNC6LuHEyfI6WjfBhU5tujaAB0FlX5hr9TDRvOC7NIh6lUNsz+Frh8NYc9JLaD1HsovpQ+PRLshbG4dFXeN0Rm7OkcgLZktRJTnM/iFRBj7BEzfq1oXpk64vyiOhdfUUhccFLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708929927; c=relaxed/simple;
	bh=bG/RoSHx8Aj05SCpiRuRNhObfYppzS0/xR+nU9px41s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N5bQ5wmUq0WbGq3NOhlWF+U7LDhh4Hp+84H3LB/yrjtOAx0srWX/mTmUwOIGZHSZYR8ldzB/S7khmUnac3JBGhJ9B1oe/A5Hiba0yU7BFWrRz9mSaszULKSDsIFGUF1rnFoyWjesGAee5XWtia9/YsMSmqhtCJJ9dIgfSkU/ffY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from msexch01.omp.ru (10.188.4.12) by msexch02.omp.ru (10.188.4.13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Mon, 26 Feb
 2024 09:45:13 +0300
Received: from msexch01.omp.ru ([fe80::485b:1c4a:fb7f:c753]) by
 msexch01.omp.ru ([fe80::485b:1c4a:fb7f:c753%5]) with mapi id 15.02.1258.012;
 Mon, 26 Feb 2024 09:45:13 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton
	<akpm@linux-foundation.org>, Alexey Khoroshilov <khoroshilov@ispras.ru>,
	Sergey Shtylyov <s.shtylyov@omp.ru>, Karina Yankevich <k.yankevich@omp.ru>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 5.10/5.15 v2 0/1 RESEND] mm/truncate: fix WARNING in
 ext4_set_page_dirty()
Thread-Topic: [PATCH 5.10/5.15 v2 0/1 RESEND] mm/truncate: fix WARNING in
 ext4_set_page_dirty()
Thread-Index: AQHaXoZYls/GR/0zTEaYvL5Vg1anPrEcPxk2
Date: Mon, 26 Feb 2024 06:45:12 +0000
Message-ID: <f406f7b3901e4471ab1ecd432aba695b@omp.ru>
References: <20240213140933.632481-1-r.smirnov@omp.ru>
In-Reply-To: <20240213140933.632481-1-r.smirnov@omp.ru>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-kse-serverinfo: msexch02.omp.ru, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 2/26/2024 4:56:00 AM
x-kse-attachment-filter-triggered-rules: Clean
x-kse-attachment-filter-triggered-filters: Clean
x-kse-bulkmessagesfiltering-scan-result: InTheLimit
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 13 Feb, 2024 14:09:33 +0000, Roman Smirnov wrote:
> Syzkaller reports warning in ext4_set_page_dirty() in 5.10 and 5.15
> stable releases. It happens because invalidate_inode_page() frees pages
> that are needed for the system. To fix this we need to add additional
> checks to the function. page_mapped() checks if a page exists in the
> page tables, but this is not enough. The page can be used in other places=
:
> https://elixir.bootlin.com/linux/v6.8-rc1/source/include/linux/page_ref.h=
#L71
>
> Kernel outputs an error line related to direct I/O:
> https://syzkaller.appspot.com/text?tag=3DCrashLog&x=3D14ab52dac80000
>
> The problem can be fixed in 5.10 and 5.15 stable releases by the
> following patch.
>
> The patch replaces page_mapped() call with check that finds additional
> references to the page excluding page cache and filesystem private data.
> If additional references exist, the page cannot be freed.
>
> This version does not include the first patch from the first version.
> The problem can be fixed without it.
>
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
>
> Link: https://syzkaller.appspot.com/bug?extid=3D02f21431b65c214aa1d6
>
> Previous discussion:
> https://lore.kernel.org/all/20240125130947.600632-1-r.smirnov@omp.ru/T/
>
> Matthew Wilcox (Oracle) (1):
>   mm/truncate: Replace page_mapped() call in invalidate_inode_page()
>
>  mm/truncate.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Hello.=20

Sorry to bother you, do you have any comments on the patch?


