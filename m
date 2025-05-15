Return-Path: <linux-fsdevel+bounces-49093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA2AAB7E20
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 08:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC2121896243
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 06:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E263296D2C;
	Thu, 15 May 2025 06:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Pg2oSOkg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1B38F6B;
	Thu, 15 May 2025 06:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747291005; cv=none; b=rORMFN0zerQH8w/f7j6VqzfUzPx+jRayApuCmO238+GphSMo4eQsagwvGTeDo7OHkxpjF6uYT0T+ejW8oQ3rUT8ohpTWuQKMuyr7F7XLJuZ+tEtLgSzGTpvVX39YEeddn0Ao7EpLj7YdOPaoF4mFRW6r6eFZ2CSGBJPfrnOfqFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747291005; c=relaxed/simple;
	bh=mAWACcbgCQjfBG0zUlUGFmA6qWKqO3wNro0jZrQNGFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RWkhH/xRM1P+tlm3FlYwDssCd6js4X4Ku1/DJGnrA3lmRUJivJPWUJBH79BHxwTWWqkWuDg6QNUE9uOyyGGsWsj9pV3wVr15HOhSJqgIxnNjirGmsy0vna4Ua0B+oVmx9/+Z3K8oyG4MoZmg9DUCRlDFzu/2PG3fPVdoNbtk9tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Pg2oSOkg; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1747290986;
	bh=mAWACcbgCQjfBG0zUlUGFmA6qWKqO3wNro0jZrQNGFA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=Pg2oSOkgfuaqGthsU75V7s/w/0TPhAT4wD1SF7fK3kQqHuxHpXZUImt+btAsAEXqB
	 y9AkqMS9OmWXEr7DM8Ej//oVt/kuVVHKZJEsN8zibEL9ElnU50Qi98P2cRra46n+nV
	 bmD+qRGa0EE0Dpw0qdWx3mKx7RvXk69s7e7a91+A=
X-QQ-mid: esmtpsz20t1747290983t8ac72b44
X-QQ-Originating-IP: 2JMmng1bOHlWlBsbdCu9ql2FwCNRLbUun0qhecmRrrk=
Received: from mail-yw1-f169.google.com ( [209.85.128.169])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 15 May 2025 14:36:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13543139004244045060
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-703cd93820fso5280297b3.2;
        Wed, 14 May 2025 23:36:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVj78Bfi59q99JdxPMv67yZPWoM1CN9ngPvEm63dasOXJgYxpd7gd2lEFLn6nWsb5f1J0X2VP94EteZBRsM@vger.kernel.org, AJvYcCXZeJqmjWTdGw7JYySiYZxwC71Od4m7PPJNkzWVY8g1OV+NzHU2dKqOu++51uomV6WnevnfDTiaVkodw16s@vger.kernel.org
X-Gm-Message-State: AOJu0YxIIZ/Ah4s+4wBnTuMvCvYCjfI3Fje1UETtge2AXxvt7tJKLBSU
	obbNTpZrgP5MO/ZACpVJYbPggbHSRyHMGGNZV9PvDAfefmLMkmvOjhaD8ZXi8yaWJH/bW0fMnkX
	0bbz7bBRZs1OyB8aai5X8R7/miRA=
X-Google-Smtp-Source: AGHT+IFoEpdCFhKbCLBX8zmOYMArHOET33DR4T79OJLTP/LXAE5lnsp3yv3tUOzLmbqqgWBGhoppNmu0wLRrQBgzrGU=
X-Received: by 2002:a05:690c:6a03:b0:707:48a7:ea74 with SMTP id
 00721157ae682-70c945a0d6cmr16925007b3.22.1747290981225; Wed, 14 May 2025
 23:36:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250511084859.1788484-3-chenlinxuan@uniontech.com> <CAJfpegtJ423afKvQaai8EeFrP4soep6LrA3jZg4A1oth3Fi2gg@mail.gmail.com>
In-Reply-To: <CAJfpegtJ423afKvQaai8EeFrP4soep6LrA3jZg4A1oth3Fi2gg@mail.gmail.com>
From: Chen Linxuan <chenlinxuan@uniontech.com>
Date: Thu, 15 May 2025 14:36:09 +0800
X-Gmail-Original-Message-ID: <A0DCB600E7D575B0+CAC1kPDNvU-F=09Dsm1DW43Xrm1e4T3BQ0K5j7R1PHrQ-Ju0i6g@mail.gmail.com>
X-Gm-Features: AX0GCFsiP56tFX9xzTLsc-CJDt0yjYb09zQeXIqbaazIALgozwSe1-4VjEohzyg
Message-ID: <CAC1kPDNvU-F=09Dsm1DW43Xrm1e4T3BQ0K5j7R1PHrQ-Ju0i6g@mail.gmail.com>
Subject: Re: [PATCH v4] fs: fuse: add more information to fdinfo
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Chen Linxuan <chenlinxuan@uniontech.com>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: Nc/J2CUvEttVObEk7AbQv23lDniBxsy/fQPA20/MxUDhia5i+H8RZdyE
	OvIaWNU5EKFV4TtoJnDA9QPVKcQgrVHozLF4t7kiNwa8SiN7mJJWnjKhhdr55WoujBYmtCH
	waXlQ68WsiUv9+29j+yAv6WjongZw+QwrHTXOFEWpAq3drcCbC6Hl7ATStuFgbDer/1XLNY
	JKiLiP6XGmZMvcEjz1/Yc8G+ik727fguD/ChzjK2Cm7xrJ74bkRjHYxdOf74bN5BLnTdkDx
	COlsSKEqwLIK6d6taASsqBpMsfD44qEmQnGdyEGFvXT4mui117KhECTZ86ycOZFy1h/iTQ4
	DfCOQF2KZz2UlAmeylj1qemQX/vnKIRE5CudtEQUrkuMuD5PSaNL2Yh2g5eEmOtUqpWv4dU
	2Wwt8MSeR5PhVLkuMITyMp+5JxexRQLBfMHIg6RKJLdkfNRSSrFz8OETO99UhBUYYsLT2xd
	WS6czwFZZTk6fSNNYFimDTHrL9iWgde5efdGGzcq9PPEKe9jFcKCyiXLG//SrYN2cHUtPdD
	VbyKFtI7lrf+I/LhlYHVGA/H0gr4Q2S4PsjNpEL3dSfPw3g5W0CLl39um/vMj1G2TAcaX/K
	rPRKaop+4Obx2j4wR6PdCagr6QfWYm1KkkrkeOrVTlgHWuRIEyaG7mGIHKltA0xxpSWYWq1
	EVyIStTheLbi8wSh/DW50IJXHA8hZc9Hyn98OwtsK1n1Wu1D5PFJpk4xVFccBn71YyvO2WP
	Qkqibcy52wjpMzdvbETTLX42gTUqnZTwAl6NRXfULa7qC09DGR4SoavVY2xvjlLUBQGSS1C
	O6HqXLChu1YamHK470NLj67rg1/fQnYamNCCd51HUvvPKh9rRzQa9vTRyKTGcPMjA3PXjDK
	WmT7+d7VnB1t3cbVIB3ar4TcOpnk9Ie+9+/Ewd5BZA+0yEnuxr9gIWqhZyzbFg6Soh30+kM
	qGGItiqjekrG2TsSzCCaKEdi5ljQrcgg7vuJAOJKXHWONqqJSesdcyn76N07LXX4KV9ZnTf
	0hcsqZCRlHqGFpVl1AsxTPU0k0SosS7KMy/i/z4h9rJ3PB0ciQDOcFaRGOkiA/V+Xj4xoLZ
	A==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

On Mon, May 12, 2025 at 2:55=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:

> What I meant is adding this to fuse_dev_operations.

But it doesn't seem like exposing this information here would be a bad
idea either, does it?
For example, if a system administrator wants to write a script to
abort the FUSE connection
corresponding to a specific directory,
the script could use this information to locate the relevant connection.

Thanks,
Chen Linxuan

