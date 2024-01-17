Return-Path: <linux-fsdevel+bounces-8203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89600830EAE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 22:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC8D71C23DCD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 21:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C902554C;
	Wed, 17 Jan 2024 21:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="V3jnG8qS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ABC1E529
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jan 2024 21:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705527369; cv=none; b=bvlhpt6YWjVlstCIUAsB9V5AWpSDO1TTfi5hDF9B5P4pSiLnsURJlTOklerkmdPDYCu4//y/F2halPeJwvzM47CluuztkRrXc+MukgelZ+WckhCwDyBpWdHxUTN5xLbJTKlcz1brCv1LjDr9J6xSDdejdvtN/HmRYOY81uOA9Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705527369; c=relaxed/simple;
	bh=aWxMI8alMtC3NtfpNAGEh3WIf4tKcsFHgMph+2dGleg=;
	h=Received:DKIM-Signature:Received:Received:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:X-Google-Smtp-Source:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=E+ktE9+7gIP31ZQVykJTGLYx4zAqeRf5f4zah5Bdi7scA0vEqEf0O8W+h7o/tzEIpUld44b3hQIaGEdAKPlBnT1BkomKmFwHc9SztY5eR2S7Y/UfOLT0Vqc4st5URzLCVU1VGndUMhChBjTwLaa+RmXd9FZDmzElu/uw8QgDv1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=V3jnG8qS; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40HKUPq0018422
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jan 2024 16:02:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type : content-transfer-encoding; s=pps01;
 bh=fMUchkso6s3fP9eOieYdqWfmlTaKy5FN0CyilhqDPb4=;
 b=V3jnG8qSigp3ZjTUHvJ7h68jKAU9Bs7aSOk2TExqa/JCybtYsLSeUpFu5DjexsiItxTR
 kULetZvxH1MdDataAZ4jjl8e1mgNOGiRwvH2qlKcxzncMcfAHEOHrIM6KfqByz/ytJLn
 3Qvi4lEDF+inBCZtt6uZ5l/sXIxgDXhhkDZ9FS/URMWDXDj+SnsOfB4DDTN/PyH5PlKD
 PkbqXllZ8FYxgwUjIXlvmiknImCD/ams/dhnHnJ1IM1q2O5crgl3PZeiZVU/PjER0/Zj
 +WdfS4Nx1vXtEaAOB8WSJP3zwHUuI4sgTIgSaUO+SAS1+c2QAD5XES5jg9eWUUfflg32 uA== 
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 3vp0xs1vf1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jan 2024 16:02:19 -0500
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-205053ee2c0so46819fac.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jan 2024 13:02:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705525339; x=1706130139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fMUchkso6s3fP9eOieYdqWfmlTaKy5FN0CyilhqDPb4=;
        b=ct5Ps9H0QtvRfaI549q6pX10A/Nyz9OVkTLbxEuYzjqUAOetQ01Cw8wJyOU8CDreJC
         c9HxmenAEJMPT+Py7yBMFN4BnnOJuu7JW3Sil2uZ0dtA8pcnYjt8OcH4/Z4FfRIFRNyZ
         dvhiA+3qvOxmaRe2EixyiV2PUufk/7l5YQbWEdJFNX88kYvS9c1Jm7x4KBPYHrAkh8vy
         QjicVm+o0LRylA6aPQfpjaKJ4k6YLU1qwF2N2WgF2aw1l7eAy+rjD7dwPlgIVOGFBlGq
         3oDfiN9VTJ9Yd6nZQW8cE3HgSrdPJ1aQaeNg6RGiL6ftLJCR9/LJBVOOLjjT3k1DQ1CE
         SiOw==
X-Gm-Message-State: AOJu0YyKBY5yVqgtNVwITVN1cKySXXqLIW7mr7DPsKTOWCHbJAU4gES5
	2TVpDlioFLxZRohZ3E3F1jOXM8pJiyLIJhLkJ38R7t4dhhF+N+EzNQkkxXAISC9+6GCqIWwnZoT
	yHTIXK3ih2dkGfFhUwkA0udjfiNKtj670W6CXEAF/JczJo/S4c9mGgP84vEKrh+tKkQazM8uQlD
	s6PxYOMlndROuthvVhMrMozUQMkHkNdKurBQ==
X-Received: by 2002:a05:6870:a447:b0:204:f46f:4ec9 with SMTP id n7-20020a056870a44700b00204f46f4ec9mr597126oal.46.1705525338910;
        Wed, 17 Jan 2024 13:02:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUILMw6YmQTx0ZuzMghYzzLMbuHa138vTY/U8Od0Ji5loHnPxaCOVHAsSIGE0wMjDMZvCYzoFK1wHuuyQlxGk=
X-Received: by 2002:a05:6870:a447:b0:204:f46f:4ec9 with SMTP id
 n7-20020a056870a44700b00204f46f4ec9mr597122oal.46.1705525338677; Wed, 17 Jan
 2024 13:02:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALbthtcbD1bDYrQC6iNk6rMgBXO8LvH0kqxFh3=0nUdqm35Lsg@mail.gmail.com>
 <Zag6xv3N7VZ_HFVT@casper.infradead.org>
In-Reply-To: <Zag6xv3N7VZ_HFVT@casper.infradead.org>
From: Gabriel Ryan <gabe@cs.columbia.edu>
Date: Wed, 17 Jan 2024 16:02:13 -0500
Message-ID: <CALbthtcdfQakgj29pg-YkPPAqfmL67UE--q=Z923Cdb-+3svSQ@mail.gmail.com>
Subject: Re: Race in mm/readahead.c:140 file_ra_state_init / block/ioctl.c:497 blkdev_common_ioctl
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: DieDPBdCl7pFI-o8OpAaNCHwQaGMbhO1
X-Proofpoint-ORIG-GUID: DieDPBdCl7pFI-o8OpAaNCHwQaGMbhO1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_12,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=10 bulkscore=10 impostorscore=10 mlxlogscore=725
 priorityscore=1501 suspectscore=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401170150

Thank you for your response!

To clarify, the tool we are developing uses modified KCSAN watchpoints
in conjunction with additional enforced thread scheduling to expose
new races. Most of these races are harmless, but we are reporting ones
that appear potentially undesirable just in case they are real bugs.


On Wed, Jan 17, 2024 at 3:38=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Wed, Jan 17, 2024 at 03:08:47PM -0500, Gabriel Ryan wrote:
> > We found a race in the mm subsystem in kernel version v5.18-rc5 that
>
> What an odd kernel version to be analysing.  It's simultaneously almost
> two years old, and yet not an actual release.  You'd be better off
> choosing an LTS kernel as your version to analyse, something like v6.6
> or v6.1.  Or staying right on the bleeding edge and using something more
> recent like v6.7.
>
> > appears to be potentially harmful using a race testing tool we are
> > developing. The race occurs between:
> >
> > mm/readahead.c:140 file_ra_state_init
> >
> >     ra->ra_pages =3D inode_to_bdi(mapping->host)->ra_pages;
> >
> > block/ioctl.c:497 blkdev_common_ioctl
> >
> >     bdev->bd_disk->bdi->ra_pages =3D (arg * 512) / PAGE_SIZE;
> >
> >
> > which both set the ra->ra_pages value. It appears this race could lead
> > to undefined behavior, if multiple threads set ra->ra_pages to
> > different values simultaneously for a single file inode.
>
> Undefined behaviour from the C spec point of view, sure.  But from a
> realistic hardware/compiler point of view, not really.  These are going
> to be simple loads & stores. since bdi->ra_pages is an unsigned long.
> And if it does happen to be garbage, how much harm is really done?
> We'll end up with the wrong readahead value for a single open file.
> Performance might not be so great, but it's not like we're going to
> grant root access as a result.
>
> We should probably add READ_ONCE / WRITE_ONCE annotations to be
> certain the compiler doesn't get all clever, but that brings me to the
> question about why you're developing this tool.  We already have tooling
> to annoy people with these kinds of nitpicks (KCSAN).

