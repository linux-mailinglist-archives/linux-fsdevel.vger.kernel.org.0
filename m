Return-Path: <linux-fsdevel+bounces-38758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78592A07FA9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 19:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65354168EBB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 18:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E5B19CD0B;
	Thu,  9 Jan 2025 18:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GyF5p9Bd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFACB19B59C
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jan 2025 18:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736446767; cv=none; b=uaSNuRgL1+SYp598nRnHF4g8Al54z4TmQ+uSpDBfU54OKcCt9MuFXF28xTx48aGjJyRrKj4erXsk6sL6EnXTu8rI96aIjRiJoHk4c23jqFa+DHfeJzpD4tAO1QJGg/IYLZ2etBBYeLLFDjo2LuXLx9F7S6Kdn8IioDASlfR/pL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736446767; c=relaxed/simple;
	bh=mDRgJuIFRng3hmlsm/4ED0AEjd2kOpo2NzQ9qtXi+II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Svc4bXT0MJioFbYK89HmbJk7KLLfO/zn4FTesOcieadNEAR14YKn1LwB8QAx+7FXixAncsXSpUjV0hprMfZJWOaxsSd7apasA+oSoKld254hIcz0Y5vaH7l8CtY/ujZUqM7u7Rd08Yk7roTxuuefgRXj4AM6WnYndCWSDHMeyvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GyF5p9Bd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736446762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lfJmIra0ne6TmR+G1rnLUESQEt4RTuCy0vegz6T9XIc=;
	b=GyF5p9Bd27Q7KlOBEsYNYst7/2via8LqsoyEH7NemDjDCoEWVcNdmFzjojRzLYNaoefJ+p
	Ydd+kl0nOiz7t+ksGCFy46LtwhPdOxERCyWLVv8yvXWt+kQcmcN2vOT+O85B2UB1SJbnAe
	5qCMdinPDRi/d+d7063/HiM7waKRUS8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-28nbJiSrNya4P0Ka3eVXDQ-1; Thu, 09 Jan 2025 13:19:21 -0500
X-MC-Unique: 28nbJiSrNya4P0Ka3eVXDQ-1
X-Mimecast-MFC-AGG-ID: 28nbJiSrNya4P0Ka3eVXDQ
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ef9204f898so2060704a91.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jan 2025 10:19:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736446760; x=1737051560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfJmIra0ne6TmR+G1rnLUESQEt4RTuCy0vegz6T9XIc=;
        b=sO6oWc3xwMwP8TsxviwbWwrvSX66cXN6h6e3Sgpqy7816b2EJuBujIIVOxd1IKdoBI
         0OTS728/QV1W8bTBuiWiwlPvGCe1LBGoGOOdhLaXZo2IPgdR8uYCqTDbzvn25cTad6/q
         54jrn/DfRxCHdWGHBW/tVfdfauKRJC8tfRZnxQ8dyU423WI0nmWlz87gCpmFB3qLrlIa
         tqpo4HVPZlP67C3+nHI7250UyEebqF0BNxSTtNVic9sUOrZSUrTktyKz0IUrvt+Dfwqi
         AwTgRPsLblj8iTWDeTxJwArDyw5QTnl9ALv5/S+KX++XLNRhL4e8eIpM+qQBDfSWDUNJ
         0R1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmB4mCxmL7o1u6j0DIL8poXBQk826h2/yMzJ6odIFxZLUGnO5OFGWFLw1EZe2d2AeZX66Z0tRdcRtjdiNU@vger.kernel.org
X-Gm-Message-State: AOJu0Yya4vN/B/Xgvdxv/mecXFfJKyVDd778f789chon8McL+Dx7lpL1
	F+cR4WZAl5tyCA/D75NVe5LLwN3OuZljHObokTgKn9b43MrbMI80evIVhgL2GYcLMW8PfNhfQlX
	9V1wz9wYRitha6iCffwxakS/k3hcsfR104rFBcnUDF2PCISgISeW43qsyH8NR4lc=
X-Gm-Gg: ASbGnct5tTAT0h6pUrXUmSZi6cyCn6wSvQxj1+02Cz2yVFdxnpEcq1nH3FsqoGJPXLv
	qr/wEFFGwvM3hOQj911wOP8rU7tTddsOSH/2QmWFApc2RfG8OYBNrDSTliO1f46MKY78f84fYeN
	sEcvemR5TnPKWYqyUqJ6oAbEdOHMtFj81bm49ZawN1GeK27ApJ8XWIitO1KXMk4XeRHVWVa/TXP
	B9hXj9wr5lZTxALglQ0sFINPSQDMevGNUjLwZaIh8DhRnQcoaGZ8f+YZIgf/WSaOK7/poVoyP9x
	8OFrIjxP/8Fus6pQPfAkeg==
X-Received: by 2002:a17:90b:3d09:b0:2ee:a6f0:f54 with SMTP id 98e67ed59e1d1-2f548f33baemr10916209a91.13.1736446760111;
        Thu, 09 Jan 2025 10:19:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOY5fNCvK6mHVj7nIEA5eP+vmjWIUdzctq4BbMz+IQYvvcswifKbIGEbRsFy1lGlU1r9VIlA==
X-Received: by 2002:a17:90b:3d09:b0:2ee:a6f0:f54 with SMTP id 98e67ed59e1d1-2f548f33baemr10916179a91.13.1736446759726;
        Thu, 09 Jan 2025 10:19:19 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f54a2ad2basm3959447a91.24.2025.01.09.10.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 10:19:19 -0800 (PST)
Date: Fri, 10 Jan 2025 02:19:14 +0800
From: Zorro Lang <zlang@redhat.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: fstests@vger.kernel.org, zlang@kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, willy@infradead.org,
	ojaswin@linux.ibm.com, djwong@kernel.org, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [xfstests PATCH v3] generic: add a partial pages zeroing out test
Message-ID: <20250109181914.xffhgu2x75eh4m2u@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250108084407.1575909-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108084407.1575909-1-yi.zhang@huaweicloud.com>

On Wed, Jan 08, 2025 at 04:44:07PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> This addresses a data corruption issue encountered during partial page
> zeroing in ext4 which the block size is smaller than the page size [1].
> Add a new test which is expanded upon generic/567, this test performs a
> zeroing range test that spans two partial pages to cover this case, and
> also generalize it to work for non-4k page sizes.
> 
> Link: https://lore.kernel.org/linux-ext4/20241220011637.1157197-2-yi.zhang@huaweicloud.com/ [1]
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
> v2->v3:
>  - Put the verifyfile in $SCRATCH_MNT and remove the overriding
>    _cleanup.
>  - Correct the test name.
> v1->v2:
>  - Add a new test instead of modifying generic/567.
>  - Generalize the test to work for non-4k page sizes.
> v2: https://lore.kernel.org/fstests/20241225125120.1952219-1-yi.zhang@huaweicloud.com/
> v1: https://lore.kernel.org/fstests/20241223023930.2328634-1-yi.zhang@huaweicloud.com/
> 
>  tests/generic/758     | 68 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/758.out |  3 ++
>  2 files changed, 71 insertions(+)
>  create mode 100755 tests/generic/758
>  create mode 100644 tests/generic/758.out
> 
> diff --git a/tests/generic/758 b/tests/generic/758
> new file mode 100755
> index 00000000..bf0a342b
> --- /dev/null
> +++ b/tests/generic/758
> @@ -0,0 +1,68 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Huawei.  All Rights Reserved.
> +#
> +# FS QA Test No. 758
> +#
> +# Test mapped writes against zero-range to ensure we get the data
> +# correctly written. This can expose data corruption bugs on filesystems
> +# where the block size is smaller than the page size.
> +#
> +# (generic/567 is a similar test but for punch hole.)
> +#
> +. ./common/preamble
> +_begin_fstest auto quick rw zero
> +
> +# Import common functions.
> +. ./common/filter
> +
> +_require_scratch
> +_require_xfs_io_command "fzero"
> +
> +verifyfile=$SCRATCH_MNT/verifyfile
> +testfile=$SCRATCH_MNT/testfile
> +
> +pagesz=$(getconf PAGE_SIZE)

There's a common helper "_get_page_size" to do this.

> +
> +_scratch_mkfs > /dev/null 2>&1
> +_scratch_mount
> +
> +_dump_files()
> +{
> +	echo "---- testfile ----"
> +	_hexdump $testfile
> +	echo "---- verifyfile --"
> +	_hexdump $verifyfile
> +}
> +
> +# Build verify file, the data in this file should be consistent with
> +# that in the test file.
> +$XFS_IO_PROG -f -c "pwrite -S 0x58 0 $((pagesz * 3))" \
> +		-c "pwrite -S 0x59 $((pagesz / 2)) $((pagesz * 2))" \
> +		$verifyfile | _filter_xfs_io >> /dev/null
                                             ????????
                                             >> $seqres.full ?

> +
> +# Zero out straddling two pages to check that the mapped write after the
> +# range-zeroing are correctly handled.
> +$XFS_IO_PROG -t -f \
> +	-c "pwrite -S 0x58 0 $((pagesz * 3))" \
> +	-c "mmap -rw 0 $((pagesz * 3))" \
> +	-c "mwrite -S 0x5a $((pagesz / 2)) $((pagesz * 2))" \
> +	-c "fzero $((pagesz / 2)) $((pagesz * 2))" \
> +	-c "mwrite -S 0x59 $((pagesz / 2)) $((pagesz * 2))" \
> +	-c "close"      \
> +$testfile | _filter_xfs_io > $seqres.full
                              ^^
                              >> $seqres.full

I'll help to make above tiny changes when I merge it, others looks good
to me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

> +
> +echo "==== Pre-Remount ==="
> +if ! cmp -s $testfile $verifyfile; then
> +	echo "Data does not match pre-remount."
> +	_dump_files
> +fi
> +_scratch_cycle_mount
> +echo "==== Post-Remount =="
> +if ! cmp -s $testfile $verifyfile; then
> +	echo "Data does not match post-remount."
> +	_dump_files
> +fi
> +
> +status=0
> +exit
> diff --git a/tests/generic/758.out b/tests/generic/758.out
> new file mode 100644
> index 00000000..d01c1959
> --- /dev/null
> +++ b/tests/generic/758.out
> @@ -0,0 +1,3 @@
> +QA output created by 758
> +==== Pre-Remount ===
> +==== Post-Remount ==
> -- 
> 2.39.2
> 


