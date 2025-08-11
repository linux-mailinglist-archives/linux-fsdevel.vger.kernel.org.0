Return-Path: <linux-fsdevel+bounces-57443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 117D0B2185E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 00:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C06666802B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 22:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3832E5407;
	Mon, 11 Aug 2025 22:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="DJs51zFL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6122E425B
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 22:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754951390; cv=none; b=h4dBxQ9GMR5mkBAGOEohrLsdkGHxs3le//cLHqVmZuaSB0gaNNooRSPTrGWqrqTMCy5O8H96m+jO4XNysSruA8WP629O7hnibThtaptL4V6OBkCenkD9n3V/Knftk3u+XFsQHR/oR1J1Hiy/DwMNxF4/dDfsPf9GaDtd8wdnaPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754951390; c=relaxed/simple;
	bh=PMDEEIrVR4LcjKeT+FuaDVksS6DA0F9s2pn9QeLfY1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MEWoWQo0aYpppTFuMO5jP8PwA8AZJtOqir5JtwWnG7uqZEtM0dSUixhI3uAc4OuxOCtFs7KjNUceq/QsYSTdDcCuDkSNJ7863z0U2YmjDoqw0Ra+jbn/ayMKYvtT5p7reSqstRYW0oXBvwfDN/wbXK0Sfo1VSFDP/2rUOHNpWWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=DJs51zFL; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Received: from pps.filterd (m0167069.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BMCNtQ009123
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 18:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=AE5q
	aVqXBGVV5Dn43rDR9xCaZLA3qjgL/c+3+4/geUg=; b=DJs51zFLcbziotKNHaFC
	QyOQsIGKvsowydM3Lae/IoQKkvjZSvhogiUxH0DC3m/ZI57b2gLyUTx9qdN5Qm6b
	0p+5aq77ddIh0xqUBKDf2r1sfzljtdOpQbt0Ox28TL+WZ11FtiyVtQBdOi/0Snks
	9A5ksIGOO/VTdIEYj3vxSEeqReMX4ZFxKj80KqceDaVfHestaz8bNuENd3BjVEd6
	qgP1FhZViBicuVqHGl2eW6jd68MzRnsch97MWdS0TLPHj5mfc/+BS5mlMou3QMud
	kqkXKXWlnh+wwizm/Vs6uwkBkpeZyNmxkdJa9VQay/nVxQQGDdODNwXtlH+b6KGM
	tg==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 48ejwk375u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 18:29:47 -0400 (EDT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-70e72e81fafso67952807b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 15:29:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754951386; x=1755556186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AE5qaVqXBGVV5Dn43rDR9xCaZLA3qjgL/c+3+4/geUg=;
        b=YV8k5GzYlBVUmT/CPNKW2lNIzAS4/gDTwyroSE3h1w3J2ZPI/Qz4oitNflNxMuSxEC
         32uo77Mob5HL6UqPO/EYFafi/Earo2l57WuN2Dr0VX0CjxMNMFhEdSYS5HRIsrBpcDBp
         o+He+6JwAna6GxX6lx8wsopvCYfo/SV/6vg1jYb1WBgr2BQUi1PrwO478zVFGbzugXBg
         d25rXxNBPcUZXqazUvBlgrXrX7VBrHAjsCE/TCFP3+mgxQ6ZzLrgLgn2PiZGqCKNi2qb
         aWLM5eO+/tP9FRzgp76t7TjOAtMYNMXV6G/YFm8XxDgJQNBRSmAd8ntTWOR8rt3/4HKk
         oqdg==
X-Forwarded-Encrypted: i=1; AJvYcCVNe7HbTr0tBN5Wk6E09aO18tRZwFiSa7w3F+v6n5ug60aNAW2SKdbwmv9CrkreQ9e7raXKcoPAMInr2vAr@vger.kernel.org
X-Gm-Message-State: AOJu0YwSAkBxELmVP+Oto5U0M+DmU9ws/ZOE1Q39+wb/iOsI1jyio2cG
	AmcbPCVWZq0k7QC/+PR/LemXZOaeZEDT2FF+2+q3K6NhnfW3vu91ou4xn5BtJXCy1tu5gEuFfif
	IyLyBtev+yw6bthYotadTP9LFHvMUnCJ8EYmwpJfmRtbLXV1QSwSv3z6g35AsJ5Kg8NJGcpGNWL
	YYQ4cDFGW7Fqb3m8jkPagDPLICG40UtzCfwiSPqw==
X-Gm-Gg: ASbGncsCpMLkQ+oEnEzbCU/dxFtb05F2aBiH0vu4Bv6/Msyerhjlc2AQI3kyij/tsks
	P9edbNeTShA29ez+vjYcOB8HWMzUAGYmDXYnjZI8jRrBjphOL/uwtkMyw6t1zLbcNngRtU6TLf2
	Cbrsmz5InYi52gS2hW+wYo
X-Received: by 2002:a05:690c:d8b:b0:71a:a9c:30dd with SMTP id 00721157ae682-71bf0ceec37mr215180997b3.2.1754951386375;
        Mon, 11 Aug 2025 15:29:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4xutuahTdVuDHkB9pGR6PFw62RaMQhcwg1ni+TzXpZI6Q7aTCGZIxYCTxWjI4ddw5HKpnz5sRl2TAesf7Otk=
X-Received: by 2002:a05:690c:d8b:b0:71a:a9c:30dd with SMTP id
 00721157ae682-71bf0ceec37mr215180627b3.2.1754951385770; Mon, 11 Aug 2025
 15:29:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811-vboxsf_folio-v1-1-fe31a8b37115@columbia.edu> <aJpqw4HhLVsXiWvt@casper.infradead.org>
In-Reply-To: <aJpqw4HhLVsXiWvt@casper.infradead.org>
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 12 Aug 2025 01:29:34 +0300
X-Gm-Features: Ac12FXzIpGdHBMABXIL57Onr3abs54wsPYwfjVfBU0PYd6jel03kHRX93Ov0EEg
Message-ID: <CAKha_srnh8HOMdHPp1Dd9drMhtM+oROvC3UDx+N2wiFvwDe-YA@mail.gmail.com>
Subject: Re: [PATCH] vboxsf: Convert vboxsf_write_end() to use kmap_local_folio()
To: Matthew Wilcox <willy@infradead.org>
Cc: Hans de Goede <hansg@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: Y_31gTGEpIAQVQ_6FaWUf6vpdk0uZvMi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDE2MCBTYWx0ZWRfX3xcG10e+ZHy7
 NHy3l9MnqfTdq18RzEddUTsrIF4dpCM1UMZr7AezpzEZ7LqoEfHh3HAgZph5iWw3esEvjEq2stE
 Cj1A5Psumi7+OALEbaiDQjTYv/wzDklj/ERAYyCEKq4jgYmPHAw+i39NSI/0+5vRFvUZZCxFJfN
 WeRe9vupLwrHKklaymEkOpHso60pt36Zz/xN71OVtjsOMsepuqQFh3yW3Jmbn4Aax4XFwJu0mto
 fQKgjOwiunM7FvxCDrxxdkRFF3l3MKmtWYjliXVUeAbmeC5DN5Ulb29cLR/mM6MSSD3zB0nqgkV
 t+3IQwh1FG/+Ca86lRQ+3omBNKo5lso9kt6xRatUpFoWAIxZBhprtpZlxVpJK9l0VcHV/eti2Oz
 rwAPzX5s
X-Proofpoint-GUID: Y_31gTGEpIAQVQ_6FaWUf6vpdk0uZvMi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_05,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=10 bulkscore=10 phishscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 impostorscore=0 mlxlogscore=687 mlxscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110160

On Tue, Aug 12, 2025 at 1:12=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
> On Mon, Aug 11, 2025 at 05:42:00PM -0400, Tal Zussman wrote:
> > Now that vboxsf_write_end() takes a folio, convert the kmap() call to
> > kmap_local_folio(). This removes two instances of &folio->page as
> > well.
> >
> > Compile-tested only.
>
> Yeah ... I don't know if this is safe or not.  Needs actual testing.

Could you elaborate on why this might be unsafe? I assumed that (1) this is
similar to the conversion done in vboxsf_writepages() and (2) that the
kmap() call here could be simply converted to kmap_local_page() and then to
kmap_local_folio(), but clearly I'm missing something...

