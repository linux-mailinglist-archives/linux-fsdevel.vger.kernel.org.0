Return-Path: <linux-fsdevel+bounces-7872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 837E282C0F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 14:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 320AB284550
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 13:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0386D1AE;
	Fri, 12 Jan 2024 13:40:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A981B25746;
	Fri, 12 Jan 2024 13:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from msexch01.omp.ru (10.188.4.12) by msexch01.omp.ru (10.188.4.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Fri, 12 Jan
 2024 16:40:17 +0300
Received: from msexch01.omp.ru ([fe80::4020:d881:621a:6b6b]) by
 msexch01.omp.ru ([fe80::4020:d881:621a:6b6b%5]) with mapi id 15.02.1258.012;
 Fri, 12 Jan 2024 16:40:17 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: Matthew Wilcox <willy@infradead.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Alexey Khoroshilov <khoroshilov@ispras.ru>, Sergey Shtylyov
	<s.shtylyov@omp.ru>, Karina Yankevich <k.yankevich@omp.ru>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 5.10 0/2] mm/truncate: fix issue in ext4_set_page_dirty()
Thread-Topic: [PATCH 5.10 0/2] mm/truncate: fix issue in ext4_set_page_dirty()
Thread-Index: AQHaRJvZs/ufXYdw80SbjgapkLNiNLDUiucAgAGlSY4=
Date: Fri, 12 Jan 2024 13:40:17 +0000
Message-ID: <3cd52f6e1b3d4daba35fb350e990e646@omp.ru>
References: <20240111143747.4418-1-r.smirnov@omp.ru>,<ZaAJwEg4rvleFuC9@casper.infradead.org>
In-Reply-To: <ZaAJwEg4rvleFuC9@casper.infradead.org>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-kse-serverinfo: msexch01.omp.ru, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 1/12/2024 9:53:00 AM
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

On Thu, 11 Jan 2024 15:31:12 +0000, Matthew Wilcox wrote:

> I do not understand the crash, and I do not understand why this patch
> would fix it.  Can you explain either?

The WARNING appears in the following location:
https://elixir.bootlin.com/linux/v5.10.205/source/fs/ext4/inode.c#L3693

Reverse bisection pointed at the 2nd patch as a fix, but after=20
backporting this patch to 5.10 branch I still hit the WARNING.
I noticed that there was some missing code compared to the original
patch:

if (folio_has_private(folio) && !filemap_release_folio(folio, 0))
         return 0;

Then I found a patch with this code before using folio, applied it,
and tests showed the WARNING disappeared. I also used the linux test
project to make sure nothing was broken. I'll try to dig a little
deeper and explain the crash.

Thanks for the reply.

