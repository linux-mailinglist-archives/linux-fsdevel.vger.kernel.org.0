Return-Path: <linux-fsdevel+bounces-50511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4032BACCD49
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 20:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D61C93A65FB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 18:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D1C289802;
	Tue,  3 Jun 2025 18:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afGfQwAB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B52A70838;
	Tue,  3 Jun 2025 18:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748976261; cv=none; b=upXuSdYFBTQDz0m4y5grXel4K/8g7gSOrrwXw5NNfJmhFSrFvCZ3UeL/X3+JN5UwH84RWIMTis6DBRNxoI6UwkU4o+Oy4kVr69ji/LQNaBs3PU/cTprKoDgvKogEMqFKF9LdXl/ija/SgzXCqhIhZ3WciNhh38Xb8Wo2T2Il3+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748976261; c=relaxed/simple;
	bh=kodLS+QWhmuNMP+v3PzSQXtQlgT5vF/I0/hmfZ4lc3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NRwlxQLKMQZezB6LRJT9exmc2cHsqOt/CRgroUfMmq/DODYLS3EUMWkOFzB58E5mgkHRd/+mzUoJVFl+MbsqotMiB7SZchcl1LChQDFLE8Q5q+T1Q2qHvMalfKp1sk2LMEwktIkQYQnaet8FPYorkbr6XXApB6KliPcGF8EyTE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afGfQwAB; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-606741e8e7cso4092094a12.1;
        Tue, 03 Jun 2025 11:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748976258; x=1749581058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0DvWbuDLUoO7ErrohXGCExSMjuVuaKb+GBvjSB+E00=;
        b=afGfQwABiB/M82pI2KF5HQTPrZd5V6Is7aYkNdXteaQwbskob1q0EuKk7NPl/BH5ks
         L2+Fmz2/O9g6xgQ7Tm+b/fqT9i52myXkzmsB62UHlfk/zfgXgOQ9q0y/Ho+siGb0xKKd
         znercZKlI5Gs1o/hXRnggtUxm+LfNscnJ00lMy3VRFqEVNAqOc1pUfB8k8neJzBJx/ab
         /tWJXSX2FLJYXcYwB0gb1eDKufamj066ePVW9/58BtM+bAJPGCdQhqJ/osjFfEaAcxz5
         kOFbcGkemxrvzWO0YhgwH1+eaaXlBRDYy4rZiQxnipTfylHFK8vhUpZmTSUi4K+yjVFd
         8o8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748976258; x=1749581058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/0DvWbuDLUoO7ErrohXGCExSMjuVuaKb+GBvjSB+E00=;
        b=hWODgdBpfl1BVlJaN2hIwVH4GJ/xdWBKwzwm4rTdDZ/c/Ww23Q9r+/s1okyrpdSZ+B
         tOR9l1af5ceapDx9UC/bLOQ0Na66Ae1H3CGSakmvRVgwKHRjc8myS5IVAI8n7cUXpfWT
         9yxVh39jgbIHLk35uQO2dG0d/VhyNDBp90oSbdSbvmMspoo+wv1leZhtPW9oQgx0q1Sn
         hjk2p5Gsq6SVSVf4WjzvM8Bqmn2/LfRIR2SHm060Eoenh8yy5XOuAKrSiRZB1X0OI7/9
         PYsZ8J5mvBCFM97FfiLv8uHumDgA+gennyXZpd4X21dHLYzAfnUl9ROWxcXPji+7tOwX
         gqrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYaOZdLt2WVMfUN+Jkn2UXBmUzYYl9pOs3Zt7f/HrMn0+zCPrdh0trlE8DzVt4IFaZgFk3SzlAeGU9iUtnvw==@vger.kernel.org, AJvYcCWzAeEuqQbnqCMuyTxZMy860w2UPGCKTZkK3c7AH2LrYusQ0j+UCrwTujdUcqN2H2m1NnbfMywRxFaRXA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5rXsiXIDYLZN2tXv0a6yQ0vOkYiSpwNwiFjzGT9dKJkJC1Bw4
	zuyeI32cILnEtJOfP4vrxbewBqjHfXVsiRLv6H/Z9eldPg4nhlzFF0zzLFBDNR9wt4fLNiITEdG
	rkofWMqqqyQtJXyVvvlPuX2TUOWSPeQ==
X-Gm-Gg: ASbGncvS6Y3eiPgv44dT+0HocA12+nnL5HNJV4JUulyC1k5Wg8imrp1SgJGsXRuItt0
	Ina2k6pLThjcyyelkxBSUdjm4DlekbnF83upsJewQeMB7OJyNJF2ek0h7QPsRCevKYPeSfK3jx4
	ehPAAOqh7NI5B8wtZWxgGQa9iuvkQSVVUDe7WPS9jhUmgjUPkCto8+amPSS6X402Y0keA7PFmzI
	w==
X-Google-Smtp-Source: AGHT+IEs48eGV/yYnuq5ExP3pqhgunc55G7M40bY+DKgGUucnWB75pzlsaT2LodybL3f+yzfheTROoMkZa/rmJWl/WU=
X-Received: by 2002:a17:906:c152:b0:ad8:9a3b:b26e with SMTP id
 a640c23a62f3a-adb3259898dmr1669949366b.56.1748976257399; Tue, 03 Jun 2025
 11:44:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250527105950epcas5p1b53753ab614bf6bde4ffbf5165c7d263@epcas5p1.samsung.com>
 <20250527104237.2928-1-anuj20.g@samsung.com> <yq1jz60gmyv.fsf@ca-mkp.ca.oracle.com>
 <fec86763-dd0e-4099-9347-e85aa4a22277@samsung.com> <20250529175934.GB3840196@google.com>
 <20250530-raumakustik-herren-962a628e1d21@brauner>
In-Reply-To: <20250530-raumakustik-herren-962a628e1d21@brauner>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Wed, 4 Jun 2025 00:13:38 +0530
X-Gm-Features: AX0GCFvwO5lsGraBvpJZkiNUSp0pPDzNHUTg1ycHX8ayt_yOU5uUMSBV8DahhNI
Message-ID: <CACzX3Av0uR5=zOXuTvcu2qovveYSmeVPnsDZA1ZByx2KLNJzEA@mail.gmail.com>
Subject: Re: [RFC] fs: add ioctl to query protection info capabilities
To: Christian Brauner <brauner@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	"Anuj Gupta/Anuj Gupta" <anuj20.g@samsung.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, jack@suse.cz, 
	axboe@kernel.dk, viro@zeniv.linux.org.uk, hch@infradead.org, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	joshi.k@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Hm, I wonder whether we should just make all of this an extension of the
> new file_getattr() system call we're about to add instead of adding a
> separate ioctl for this.

Hi Christian,
Thanks for the suggestion to explore file_getattr() for exposing PI
capabilities. I spent some time evaluating this path.

Block devices don=E2=80=99t implement inode_operations, including fileattr_=
get,
so invoking file_getattr() on something like /dev/nvme0n1 currently
returns -EOPNOTSUPP.  Supporting this would require introducing
inode_operations, and then wiring up fileattr_get in the block layer.

Given that, I think sticking with an ioctl may be the cleaner approach.
Do you see this differently?

Thanks,
Anuj

