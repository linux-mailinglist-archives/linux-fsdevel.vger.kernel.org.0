Return-Path: <linux-fsdevel+bounces-71164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4137DCB756F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 00:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00E723014A1B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 23:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE6A2BDC02;
	Thu, 11 Dec 2025 23:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="r9ilj/ji"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C2E288C86
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Dec 2025 23:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765494789; cv=none; b=uifgidKn8Qo5IGxhQeZfhTyOG6Pvu0alO+1gvr+qMB4TcYL6QSTGwJVHkINg+FpIFq+NzRc7bVlaH96gODzAgS0tGfedccDwiFdoQ+bb1TWcfRfn7y219gRhVV9wzNX00cYwmTxxE+fTnZb9miyen5P3yEVZAEpRsK4ud/IUd5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765494789; c=relaxed/simple;
	bh=+SItKWheGOCfJZiVx/abGIZN0q7nJm9pgeN1VExwXjs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iZjWF+mrx4R42wvVwpIRT8zX2FpZlrJ7C62FJEd4pgomjAyPRyjAw/F4YSewJu5R9IQ4OMbACTpTbLv6J/oNAC3IgKNl3RrxUaGed3rnMqIquyUv6dqTgJAxDp/6/xsYA0heULbFEWdDNkitMt34oxxX0Qp/3QfOWoQUISLkm3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=r9ilj/ji; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-29e93ab7ff5so7812545ad.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Dec 2025 15:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1765494786; x=1766099586; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ep1Ckut8sp7EgQ95W6RLTx5bAu00UGPglt77ENNDVlQ=;
        b=r9ilj/jiUoZipAyK09Qg3ZpJIc8Y77C0F1+yykEqhM6+6BsE2IQhHONMb0oaYcwn/N
         EwpOkL5IrT+IKZFbWNKBXD+XHzmn+QPxVWt0cE22Eb+B1kfUwDHYCW2q1cWeS0T+IDE+
         5JBiSsqDABl4YonRWhVKYwYnLf/Mgy93+UjtfJ/SyYxbLvrmL3xUTPhFThC0uLonYs7F
         fjWeJQz1nxH3yWG0GegCHabAwG630S4l3ezy7ygxVoqCJ2R5OIaKloYXQEksM54ceqZx
         wIa0Zxkb1kkvuM1hv5YDJipBdU1fwjJkts0Audzn+R5kNEBaX6C/b+h/Vorv6bZmk7h7
         E5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765494786; x=1766099586;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ep1Ckut8sp7EgQ95W6RLTx5bAu00UGPglt77ENNDVlQ=;
        b=uOMb2UecI4uYjPon7XdUgH9dmxi5Ei+A+j5UBNdZwd4tW2HWkTAr2eh6uiipd+NeiB
         mPl44BcXl97aFnX4DU7deEWPLU9tvbvA53W+tAltwbI+sBjWg+RnAwXuw8xmKTKzifLH
         Lg2RTfQxz3D0y/pDkn0eAVN3tosvu3U9hA3BODdjYaBTE/AOeWBVTzg2W8rxCZgPQsYL
         HvbCm3ixo7ePS6XwH3lDdPg5TryXbS7OJ4+F5UsSz/7LZ5dMJVIHPVBiQ0YxZUbZduB5
         +iLGEP0AWVr6PJvyxGs/AFrngeaSn4IUAU/xwWGt8RJHeTIBQS2ccUW4dknZMKkQ5Pdf
         jwGg==
X-Gm-Message-State: AOJu0YzKmBjj2gr03pQY2+KCRt8Ad/IYnaeDQEEdtRR6Qx9uUfIfnxpz
	lgKybhCRoGSpyaaM1g738a1oDr16GSsJAK0mm4HNh/i5SK1yUkY9yY2loWU+Oq6pBC8snUGFpyP
	L2B7M1VsBfQ==
X-Gm-Gg: AY/fxX5/xN5XB3KFrp4+fWFkkXDnHpHwCy3W1+rGWISBrdiicFSgNyzusKzOurS0zOj
	whYYAPdfgIaiMm8M41NN8D6mlLNbcPbikxUBTC6ZylMuMrgDaaGi3LqO0phGX3jc+4mo/JflLyx
	4x/cFj6Unc0PMw5WWQhyn4wAboOvhHOQ3JgJAsi/2TkcVhp+HkfTWc//CZF1NRlx8H6eI9o2Jrb
	UURuLloNJWpoQraK1zmsU+2TGdVQPde3pny6tGMDQgLuubdKfqCSWYik7Vi55wiFs0dyFGW1/MC
	LCDlnS1x/rcD0TGVBgHJo+T1L5KZd4PR2/XuVZTI1AwymxxEv5uT/wEOORGFC82EwKsdv9cvfvS
	rE3YSdyBq2V7GH2GIUXQ70+P8xppBmpmRBYY1xhSjyh9mJJ0tLpFQW3fHMJypxdJCqykzbfN8Jp
	dhT6XSod+5y4rUqe1Pd0b9rS4ZpYxqkhHHVwDT9dTniow=
X-Google-Smtp-Source: AGHT+IEAuOQpJuBcBVuPvr8tINKODigjiIkgzbINCo9pRxRax9QFKpjeA1yhbFOKEpZ2X9QT0bqzrw==
X-Received: by 2002:a17:903:1250:b0:295:6122:5c42 with SMTP id d9443c01a7336-29f23b6f3fbmr2690415ad.24.1765494786058;
        Thu, 11 Dec 2025 15:13:06 -0800 (PST)
Received: from [172.16.2.132] (fs98a5732b.tkyc510.ap.nuro.jp. [152.165.115.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe3ba59bsm25923a91.7.2025.12.11.15.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 15:13:05 -0800 (PST)
Message-ID: <3a143f53da945f7bad35aaff7bb40b1b6255d5ba.camel@dubeyko.com>
Subject: Re: [PATCH] HFS: btree: fix missing error check after
 hfs_bnode_find()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Haotian Zhang <vulab@iscas.ac.cn>, glaubitz@physik.fu-berlin.de, 
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 11 Dec 2025 15:13:01 -0800
In-Reply-To: <20251209021401.1854-1-vulab@iscas.ac.cn>
References: <20251209021401.1854-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-12-09 at 10:14 +0800, Haotian Zhang wrote:
> In hfs_brec_insert() and hfs_brec_update_parent(), hfs_bnode_find()
> may return ERR_PTR() on failure, but the result was used without
> checking, risking NULL pointer dereference or invalid pointer usage.
>=20
> Add IS_ERR() checks after these calls and return PTR_ERR()
> on error.
>=20
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> ---
> =C2=A0fs/hfs/brec.c | 4 ++++
> =C2=A01 file changed, 4 insertions(+)
>=20
> diff --git a/fs/hfs/brec.c b/fs/hfs/brec.c
> index e49a141c87e5..afa1840a4847 100644
> --- a/fs/hfs/brec.c
> +++ b/fs/hfs/brec.c
> @@ -149,6 +149,8 @@ int hfs_brec_insert(struct hfs_find_data *fd,
> void *entry, int entry_len)
> =C2=A0			new_node->parent =3D tree->root;
> =C2=A0		}
> =C2=A0		fd->bnode =3D hfs_bnode_find(tree, new_node->parent);
> +		if (IS_ERR(fd->bnode))
> +			return PTR_ERR(fd->bnode);
> =C2=A0
> =C2=A0		/* create index data entry */
> =C2=A0		cnid =3D cpu_to_be32(new_node->this);
> @@ -449,6 +451,8 @@ static int hfs_brec_update_parent(struct
> hfs_find_data *fd)
> =C2=A0			new_node->parent =3D tree->root;
> =C2=A0		}
> =C2=A0		fd->bnode =3D hfs_bnode_find(tree, new_node->parent);
> +		if (IS_ERR(fd->bnode))
> +			return PTR_ERR(fd->bnode);
> =C2=A0		/* create index key and entry */
> =C2=A0		hfs_bnode_read_key(new_node, fd->search_key, 14);
> =C2=A0		cnid =3D cpu_to_be32(new_node->this);

Frankly speaking, I am not sure that we need to add this check.
Because, we are trying to find the parent node that already has been
found in above logic of the method. So, we should have the parent node
available. Potentially, logic could work in wrong way, but we should
already have a reported bug already.

Even if this check makes sense, then we cannot simply return the error
code here. If you check the following logic, then you can see that we
call hfs_bnode_put() for the new node. So, if this check doesn't do
this in the case of error, then we create the leak here.

Have you ever reproduced the issue that you are trying to fix?

Thanks,
Slava.

