Return-Path: <linux-fsdevel+bounces-70427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30036C9A0D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 06:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11AD43A5113
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 05:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D411DFDB8;
	Tue,  2 Dec 2025 05:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a8mBqG/M";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jXqhEPyG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1FD1CD2C
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Dec 2025 05:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764652072; cv=none; b=q6CcO4sToTO8R4CKaK/vDJODe2I/gZci3+/AWAfq3sG3qb9WApoqQ0ydBlcBCJ44B/52XYGQK+EQUMl9vjuc649QkUjYjVcn0I2hM5LvXdzbmxbjnsgMQ/JyGhPyYUY5wCdrkXs916HpO3MvP6Bu7urtxVAv8RUDi1I7Mt8elGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764652072; c=relaxed/simple;
	bh=vDML9m+UxaGF5r1IhyFPtHXB15YBXn2gcIq2UL1CYfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FKwa0k/0Fhwk8Nb7irBGQk4lKEd+SpK5BfZL1387AvjS90dC+tekuLzmwJEASA/SJ4a4jLXHoXyysd7BuYhOFuQQOybWCniq7kD6VrxNUZebepjL3VnIzKYy6bx6VGG6BvuaYjCEM5Vw7Xj6BXHG4EPtNhV1ZQKJNJWL1SIOmdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a8mBqG/M; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jXqhEPyG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764652069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UeSHa2vVcmGoYrd3r8sFlYLUPMwEfaTwEKwTR4fP+Vo=;
	b=a8mBqG/MFieoi+lXTgQe4yy9VuYZpiobgbh17eh9uHk8+lJcJDMTaILS+EPpbVHYbapV/U
	QCT+Hsn1tY+z02kQXDdPFXNOkmbeBEAJOdMfC7YvYSInEORiVACu00HNs5PgWqyeVTdgOQ
	eEPSpnqDL2lig4kl8lZu846YaD27Vcw=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-cPjD9pUNOv2tZ2x6y7HrJQ-1; Tue, 02 Dec 2025 00:07:48 -0500
X-MC-Unique: cPjD9pUNOv2tZ2x6y7HrJQ-1
X-Mimecast-MFC-AGG-ID: cPjD9pUNOv2tZ2x6y7HrJQ_1764652067
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-29848363458so93766865ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Dec 2025 21:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764652067; x=1765256867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UeSHa2vVcmGoYrd3r8sFlYLUPMwEfaTwEKwTR4fP+Vo=;
        b=jXqhEPyG2MxE+HLymS2ydoXvhJE2ZZM7gCXLpR/6u7XsVX09QmDkIAAqI4Q5FcL+kK
         sRMsErwo2zk1XOD2wlitEv4JNlipLxCsAHvuKbmVtY4uFD9GABEU79Jkjmdk0UkHRMNT
         UczzAhNClObnW0BuQZavp8eqS9jrzfWpZPV47dtZwQed/LclM54dXlHBMVi4A4C/dxBc
         zWXE6WNRuk0/75fvQT37AuDTIyg7HiGxrOw8TEnbhhY9DojQReIHivlMAjC+HHsCUH0o
         5woutfL+aOE2bKpNjEjB2+/pS0kJLuo4IC4Za84eVd4viS0y0I2Ph9au05EpnR1nlIWy
         KvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764652067; x=1765256867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UeSHa2vVcmGoYrd3r8sFlYLUPMwEfaTwEKwTR4fP+Vo=;
        b=Bd2LOKVuCanoCJBjVnI+aPNQDefjrVGiAGQlwFeMX3J5tCLDlLx1ApE5DimzUKiOmu
         Cp/Lrk2xyv2BCnp6/l8//lLblqQF7LvsRDyiE4Enbyjde43D7XboRfVVHfW/DFm8sMe3
         UnpuzW/w/1ZcIWE2ZG4yxgQL1JMn560Ne6OOF0oJCWzkCdYIC6Ctrc4T468qroUvm8MI
         Jr2TfbuXH5M6CoPCjp89krQQzZrySlQoVfFK9C/Jl738eyc6zmodBy4BsocZx7DHJGEg
         i/V6+AyfXLyXtS1/AVJXZ8fCpj14zWhY5rWiaFtM3MXgVrqrai6Tp6iSyYC6hKHEQclG
         cCEg==
X-Forwarded-Encrypted: i=1; AJvYcCVNaanGRK1jtNXS3IYfVa6CMvZKKUx2h2h7in6V00BYvf3Se7J+IPKbMZBquPrPYEIFAoVN/oXpZswJLghv@vger.kernel.org
X-Gm-Message-State: AOJu0Yxas1YHa7j+gqRIxggX2binc2Od5KbPJASFUcaNQSxmsgb1aohP
	Z1FR8v5oKksz1q7E9a0s/bzUfNONRwYv1tLzSCvQoApBfpirNJxZUvP1qkZCiby0psmsnerm7iC
	Bz8Irlb0okKGAN8G7Z3SGQvzocFpMVrpK5jvRQKKgNEszwGSJO1Vs/n2+5gg6pjmTBTY=
X-Gm-Gg: ASbGncvU9oVShTF2MqqTm+lqBAvUQsUn5dBG7knLSnLBr1tlA7KidtQ6hUzMpeqnD4Y
	vo3j3f8XmWDPFH8IczywDZyZNiYA/6WIf+jm45VeFb1Q69XronLW4zb48ACllza/PJEQbsBlJU7
	qsjy+joDkzzc47+1bDtBwJnNAPpMD4Ls3DJ8YB4PGUIuf99ewop77gQpnci13I6M1OmvebI//iA
	5EoejScD4MfY9o3FTJPvCDz/dax2QurGhmePRrnQCqZD4FYMhMPe9fJqOSCT4dXUsRIixF1hYIK
	0IXJ5GjiEhs0r5LbRC/oYvMWoq+pMEYl69rO1/4UEq+Z55XVBqotwTb22pP6KG5aHC9TO0QNNGA
	iiwG9V4XJExhUx4DO0uSot4e+sm1CRCBt4gHJ+6YqGLcHFtU+vw==
X-Received: by 2002:a17:903:b84:b0:290:cd9c:1229 with SMTP id d9443c01a7336-29b6bec4961mr409475575ad.19.1764652067236;
        Mon, 01 Dec 2025 21:07:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFd7eTfczZwORLSJHT6qu06NI2nq5xDtGv3b8o/cmw+GmF8P8G58rrpr6KmXy+oW7FEZjWbVQ==
X-Received: by 2002:a17:903:b84:b0:290:cd9c:1229 with SMTP id d9443c01a7336-29b6bec4961mr409475245ad.19.1764652066644;
        Mon, 01 Dec 2025 21:07:46 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bce2e676esm138125475ad.0.2025.12.01.21.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 21:07:46 -0800 (PST)
Date: Tue, 2 Dec 2025 13:07:41 +0800
From: Zorro Lang <zlang@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH fstests v2 2/3] generic: add test for directory
 delegations
Message-ID: <20251202050741.p6iakv5fbmnrzxmy@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251119-dir-deleg-v2-0-f952ba272384@kernel.org>
 <20251119-dir-deleg-v2-2-f952ba272384@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119-dir-deleg-v2-2-f952ba272384@kernel.org>

On Wed, Nov 19, 2025 at 10:43:04AM -0500, Jeff Layton wrote:
> With the advent of directory delegation support coming to the kernel,
> add support for testing them to the existing locktest.c program, and add
> testcases for all of the different ways that they can be broken.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---

Hi Jeff,

Glad to get you patches to fstests again :)

>  common/locktest       |  14 +-
>  common/rc             |  10 ++
>  src/locktest.c        | 423 ++++++++++++++++++++++++++++++++++++++++++++++++--
>  tests/generic/999     |  22 +++
>  tests/generic/999.out |   2 +
>  5 files changed, 456 insertions(+), 15 deletions(-)
> 

[snip]

> diff --git a/tests/generic/999 b/tests/generic/999
> new file mode 100755
> index 0000000000000000000000000000000000000000..1392e98c937d65d2d6402f1eb5822f22bc265342
> --- /dev/null
> +++ b/tests/generic/999
> @@ -0,0 +1,22 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2019 Intel, Corp.  All Rights Reserved.
> +#
> +# FSQA Test No. XXX

     FS QA Test No. 999

Please don't change the format which xfstests/new generate. Other
script (e.g. tools/mvtest) depends on that :)

> +#
> +# lease test
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/locktest
> +
> +_require_test
> +_require_test_fcntl_advisory_locks
> +_require_test_fcntl_setdeleg
> +
> +_run_dirleasetest
> +
> +exit

_exit 0

Oh, I guess you didn't use ./new to create this test case, you copied it from
g/131 or g/571. I'd recommend using ./new to create a new test case :)

> diff --git a/tests/generic/999.out b/tests/generic/999.out
> new file mode 100644
> index 0000000000000000000000000000000000000000..c2a252d46cdcd730cf1ed2c503fa9631e9fcdd06
> --- /dev/null
> +++ b/tests/generic/999.out
> @@ -0,0 +1,2 @@
> +QA output created by 999
> +success!
> 
> -- 
> 2.51.1
> 
> 


