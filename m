Return-Path: <linux-fsdevel+bounces-11317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1235852990
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 08:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7103F1F24010
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 07:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0464E1755F;
	Tue, 13 Feb 2024 07:07:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F331114291;
	Tue, 13 Feb 2024 07:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707808047; cv=none; b=XxDsxEyJ9MPFssNkEt8XI5yjfY3HD0rYnqnmXxy6m0TyjaaRAk4U9iwseQLp3bKyAm8pOPF7skzMu0QzaIN1gAriw6H7OSY3EPIGwpyVXMiY9VSiio8WU8hTO3jLTF3pPqoLgO1IwjtNg6yZN0nt+1E/EbBhvgKJKjiDsd3XRnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707808047; c=relaxed/simple;
	bh=O6d/vJXQj7Gc9Eo1VuCw/vG3wPs+yLmqdGjxCSZb1oU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uMaqaSTRTq/Ehdct0/W7m4gK+s5O6kLKh208FW0dirEmF9EHgMz/Txv+ULiEfH3R+8DbaUiuD1QeZkJLiQHTc4lVgvHOf/8rKz57GDn7mjjtSZju2m5g8vHBsyBrAMAJrri4UHVOx995pMovnAh5B5EtilNskw4dBnienuGf2WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from msexch01.omp.ru (10.188.4.12) by msexch02.omp.ru (10.188.4.13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 13 Feb
 2024 10:07:18 +0300
Received: from msexch01.omp.ru ([fe80::485b:1c4a:fb7f:c753]) by
 msexch01.omp.ru ([fe80::485b:1c4a:fb7f:c753%5]) with mapi id 15.02.1258.012;
 Tue, 13 Feb 2024 10:07:18 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Alexey Khoroshilov <khoroshilov@ispras.ru>, Sergey Shtylyov
	<s.shtylyov@omp.ru>, Karina Yankevich <k.yankevich@omp.ru>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-ext4@vger.kernel.org"
	<linux-ext4@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>, Andreas Dilger
	<adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>
Subject: Re: [PATCH 5.10/5.15 v2 0/1 RFC] mm/truncate: fix WARNING in
 ext4_set_page_dirty()
Thread-Topic: [PATCH 5.10/5.15 v2 0/1 RFC] mm/truncate: fix WARNING in
 ext4_set_page_dirty()
Thread-Index: AQHaT4/Qs4jFNwbjC0COwuMxHerW67DqXhoAgAX2vwCAAFxZAIAAGIKAgBcs0mw=
Date: Tue, 13 Feb 2024 07:07:18 +0000
Message-ID: <d25ec449ffce4e568637a418edc4221c@omp.ru>
References: <20240125130947.600632-1-r.smirnov@omp.ru>
 <ZbJrAvCIufx1K2PU@casper.infradead.org>
 <20240129091124.vbyohvklcfkrpbyp@quack3>
 <Zbe5NBKrugBpRpM-@casper.infradead.org>,<20240129160939.jgrhzrh5l2paezvp@quack3>
In-Reply-To: <20240129160939.jgrhzrh5l2paezvp@quack3>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-kse-serverinfo: msexch02.omp.ru, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 2/13/2024 4:30:00 AM
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

Is there something else to do to make the patch accepted?=

