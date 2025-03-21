Return-Path: <linux-fsdevel+bounces-44677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A26A6B477
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 07:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A18457A9864
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 06:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E171EDA0D;
	Fri, 21 Mar 2025 06:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BIOkUoSN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FC31EB184
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Mar 2025 06:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742538913; cv=none; b=FtxVBqR3fDTiHqSDHUDK+nX0G++2a0gOnv6+yofOWidtPbWzaaCbPq5+2USDjuidLaDrG86g+g1YQpQqqLjPQnZOhwX9qAxNbv4ZZkLOtyCEaa3B/FHRo8vK/xOy6eHZaV1+eOguEF7Kv7xPteieVuiMcfGW/7M+eUfyl8paPvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742538913; c=relaxed/simple;
	bh=ypno/VfSFoHOwVqheRJVTlW/U5+RXZSu9hpvuqS8ryc=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=GTVx51DPKxRVYc/lF36J+ZIiWIb/1SOOAZ3zchqStUy8G28uqcFKUVAKi3Z5XYXbCS4UAfnI1yHEXy0JgtBX0V+9nuLhdrZoxJfYHrySHnOux712bfTdlomYumUYiN66heiA2KLhUzYv4fkEkTIZr/uiiWfa+W6swxKbRkDzFr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=BIOkUoSN; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250321063503epoutp04db2a4c8df8c988d2db8bef3a463d7ea5~uveZ7jjhh2096620966epoutp04m
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Mar 2025 06:35:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250321063503epoutp04db2a4c8df8c988d2db8bef3a463d7ea5~uveZ7jjhh2096620966epoutp04m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1742538903;
	bh=rgXBgm2j3OYKUDvQQeIioghWI/eaGLrzGCp2iTJH39Y=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=BIOkUoSNbE5RUDFrsKpm7lWu3VaumgiuSwVytA+lXoJotilQiw7EBqSZ6E+YVQ1ID
	 qLlDDqBoQo1VFovGwjBPONVpw/gA6aUUKU10daktSs7iJqSb4C2xO3F9g3Ou3ga3tp
	 qixiYMurHnRr0j+1jFDDOgjJ0R+tSWellSD1S5rM=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTP id
	20250321063503epcas1p3a317c22f6b03526139896c3b9807332e~uveZh7yjM2008420084epcas1p3Q;
	Fri, 21 Mar 2025 06:35:03 +0000 (GMT)
Received: from epcpadp1new (unknown [182.195.40.141]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4ZJt3V7317z4x9Pr; Fri, 21 Mar
	2025 06:35:02 +0000 (GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
	20250321061945epcas1p439de78c05f457d53c2afa962c281636e~uvRDYlDpW0146001460epcas1p4f;
	Fri, 21 Mar 2025 06:19:45 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250321061945epsmtrp1ba2b6490db22e6883c18d245b5764263~uvRDXvUIe2174821748epsmtrp1N;
	Fri, 21 Mar 2025 06:19:45 +0000 (GMT)
X-AuditID: b6c32a2a-38bf570000004a05-d4-67dd05010a26
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	16.5E.18949.1050DD76; Fri, 21 Mar 2025 15:19:45 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250321061945epsmtip1087de96b0e989478930ecb3355251fd8~uvRDNvC1Y1126911269epsmtip1M;
	Fri, 21 Mar 2025 06:19:45 +0000 (GMT)
From: "Sungjong Seo" <sj1557.seo@samsung.com>
To: <Yuezhang.Mo@sony.com>, <linkinjeon@kernel.org>
Cc: <sjdev.seo@gmail.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <cpgs@samsung.com>,
	<stable@vger.kernel.org>, "'Yeongjin Gil'" <youngjin.gil@samsung.com>
In-Reply-To: <PUZPR04MB6316CA3B8281D08C2A85435A81D82@PUZPR04MB6316.apcprd04.prod.outlook.com>
Subject: RE: [PATCH] exfat: fix random stack corruption after get_block
Date: Fri, 21 Mar 2025 15:19:45 +0900
Message-ID: <1296674576.21742538902983.JavaMail.epsvc@epcpadp1new>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQGqPMDwLKOI+5AXW2VZtJVBhfOd4ANqS2Y2AmcVG+WzsUpqUA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42LZdlhJTpeR9W66QdcHQ4uXhzQtJk5bymyx
	Z+9JFovLu+awWbz4sIHNYsHGR4wWM/Y/Zbe4/uYhqwOHx85Zd9k9Nq3qZPPo27KK0aN9wk5m
	j8+b5AJYo7hsUlJzMstSi/TtErgy9u76wlKwi7vi5PzVjA2MJ9i6GDk5JARMJJpudAPZXBxC
	ArsZJa49e8TcxcgBlJCSOLhPE8IUljh8uBii5DmjxI7JPYwgvWwCuhJPbvxkBrFFBEwlvlyG
	mMkssJ9R4tlcPYiGJ4wS7WeWgSU4BWIlZv4/xwRiCwu4S0xp3ckCYrMIqEpMenwFzOYVsJLo
	v7CFFcIWlDg58wkLxFA9ifXr5zBC2PIS29/OYYZ4QEFi96ejrBBHOEnsXA9TLyIxu7ONeQKj
	8Cwko2YhGTULyahZSFoWMLKsYpRMLSjOTc8tNiwwykst1ytOzC0uzUvXS87P3cQIjiotrR2M
	e1Z90DvEyMTBeIhRgoNZSYRXpON2uhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeb697U4QE0hNL
	UrNTUwtSi2CyTBycUg1MmY3+5w9/6O24bzaX5Ywac20Qz/4pdcIMRm557536i+SLEj/r345g
	i5TKst59PTK6trxVfHvbv2tyVh/S+X82T+Yqf/BavcI4yUamdv55e4MM4b+5KX6nesxjGIRf
	8/HX5r3OvXH628YzXwVnNySt08/Jva+2ZduzN6zsTxZ3/9xu8Wv2lyMWCRfa1NR9nlZPLki/
	unr2fzuvmqa9K1MFfs+133pcc2OV6RaNBYmFX7KYfyavCFxs6WKmJufIyjqzrOhfvGu3qtyR
	QJX5VyuYKuUtXqqfyNzTFPDp9fwYc3Upm8dbFM/bTpU54fmG29p4lYpdVdr682ukF+lKz78V
	zJq6M1atfctD5qhoRSWW4oxEQy3mouJEAAeoXfYZAwAA
X-CMS-MailID: 20250321061945epcas1p439de78c05f457d53c2afa962c281636e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-CPGSPASS: Y
X-ArchiveUser: EV
X-Hop-Count: 3
X-CMS-RootMailID: 20250320052646epcas1p384845fdc17bf572784c99ca81cd4c9dc
References: <CGME20250320052646epcas1p384845fdc17bf572784c99ca81cd4c9dc@epcas1p3.samsung.com>
	<158453976.61742448904639.JavaMail.epsvc@epcpadp1new>
	<PUZPR04MB6316CA3B8281D08C2A85435A81D82@PUZPR04MB6316.apcprd04.prod.outlook.com>

Hi Yuezhang,
> Subject: Re: [PATCH] exfat: fix random stack corruption after get_block
> 
> +                       /*
> +                        * No buffer_head is allocated.
> +                        * (1) bmap: It's enough to fill bh_result without
I/O.
> +                        * (2) read: The unwritten part should be filled
with 0
> +                        *           If a folio does not have any buffers,
> +                        *           let's returns -EAGAIN to fallback to
> +                        *           per-bh IO like
block_read_full_folio().
> +                        */
> +                       if (!folio_buffers(bh_result->b_folio)) {
> +                               err = -EAGAIN;
> +                               goto done;
> +                       }
> 
> bh_result is set as mapped by map_bh(), should we need to clear it if
> return an error?
I looked a little deeper into do_mpage_readpage() and
block_read_full_folio(), and from a security perspective, it seems that
unmap is necessary in all error situations. Otherwise, unwritten areas
may be exposed.

> 
> +
> +                       BUG_ON(size > sb->s_blocksize);
> 
> This check is equivalent to the following condition and is not necessary.
> 
>                 } else if (iblock == valid_blks &&
>                            (ei->valid_size & (sb->s_blocksize - 1))) {

Yes, I think so, I'll remove it with v2.

Thanks




