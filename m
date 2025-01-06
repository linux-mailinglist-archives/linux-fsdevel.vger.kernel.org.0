Return-Path: <linux-fsdevel+bounces-38443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA5FA02A4E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 16:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 611F31886673
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 15:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F361DE880;
	Mon,  6 Jan 2025 15:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="imxJSdDn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C8D1DE8A3
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jan 2025 15:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177511; cv=none; b=KGnlFzIonbuoxCP60i30f9IExKZiNt2Bm9J6U7SijZNtT25CVFPMLk60Ijx4GJWcFLmxwPjTtfRuNLTQBs/zmsHhxpp5qv/o4pAOJxQYNMxoKJHvVF0Iw+8hmfcRF5uOq/qNBv5xh3IgFWZR32iGwzRXOjLeIMDGRT3pnMiBbCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177511; c=relaxed/simple;
	bh=RypHaYqDesIWv1/rIUgulsvBkMwQFOfBPNdvBEqP+rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pU5y4i+/S5dTnQ/+0kGFpsimypFYxNo9zKYZZOWed6yAhd1wDjuqypXZ6wbZvG7032c7OV/U5RYak67lVYhROaNZriUF9Rz3LJsMLwxVeAC5+rQiEDvR8cbAUYomcZ+7cVH2HqBrg7Kt7c+6MwAX2sVbqvKb16oJu+lHThK12II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=imxJSdDn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736177505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GSXCqBkYFjWO0klsYMxwaMxfUqviIRzijzsebr0SSTw=;
	b=imxJSdDnSiNa6m2GANbuw0K8Lrtl4BLFz4GbcP/5QpocrKApFFOlXiL1vtCXtvQlEJ6zo4
	eh7N0lZ86/D7rCoXqUboDGWqYCYAHUD+updWrUTRqIlwswTX8hpssC/8AG9l0FsqfB/a/0
	6UD042IheFQI9Z0M2vwLOCQsUT0trG0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-53-UX73vBqfOGi4q0ECSSWuJA-1; Mon,
 06 Jan 2025 10:31:39 -0500
X-MC-Unique: UX73vBqfOGi4q0ECSSWuJA-1
X-Mimecast-MFC-AGG-ID: UX73vBqfOGi4q0ECSSWuJA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 91ADE1954233;
	Mon,  6 Jan 2025 15:31:38 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.122])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8CB963000197;
	Mon,  6 Jan 2025 15:31:37 +0000 (UTC)
Date: Mon, 6 Jan 2025 10:33:44 -0500
From: Brian Foster <bfoster@redhat.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	djwong@kernel.org, nirjhar@linux.ibm.com, kernel-team@meta.com
Subject: Re: [PATCH v2 2/2] generic: add tests for read/writes from
 hugepages-backed buffers
Message-ID: <Z3v3ty-8-_hm2WFR@bfoster>
References: <20241227193311.1799626-1-joannelkoong@gmail.com>
 <20241227193311.1799626-3-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241227193311.1799626-3-joannelkoong@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Fri, Dec 27, 2024 at 11:33:11AM -0800, Joanne Koong wrote:
> Add generic tests 758 and 759 for testing reads/writes from buffers
> backed by hugepages.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  common/rc             | 13 +++++++++++++
>  tests/generic/758     | 22 ++++++++++++++++++++++
>  tests/generic/758.out |  4 ++++
>  tests/generic/759     | 26 ++++++++++++++++++++++++++
>  tests/generic/759.out |  4 ++++
>  5 files changed, 69 insertions(+)
>  create mode 100755 tests/generic/758
>  create mode 100644 tests/generic/758.out
>  create mode 100755 tests/generic/759
>  create mode 100644 tests/generic/759.out
> 
> diff --git a/common/rc b/common/rc
> index 1b2e4508..825e350e 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3016,6 +3016,19 @@ _require_xfs_io_command()
>  	fi
>  }
>  
> +# check that the system supports transparent hugepages
> +_require_thp()
> +{
> +    if [ ! -e /sys/kernel/mm/transparent_hugepage/enabled ]; then
> +	    _notrun "system doesn't support transparent hugepages"
> +    fi
> +
> +    thp_status=$(cat /sys/kernel/mm/transparent_hugepage/enabled)
> +    if [[ $thp_status == *"[never]"* ]]; then
> +	    _notrun "system doesn't have transparent hugepages enabled"
> +    fi
> +}
> +
>  # check that kernel and filesystem support direct I/O, and check if "$1" size
>  # aligned (optional) is supported
>  _require_odirect()
> diff --git a/tests/generic/758 b/tests/generic/758
> new file mode 100755
> index 00000000..e7cd8cdc
> --- /dev/null
> +++ b/tests/generic/758
> @@ -0,0 +1,22 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# FS QA Test No. 758
> +#
> +# fsx exercising reads/writes from userspace buffers
> +# backed by hugepages
> +#
> +. ./common/preamble
> +_begin_fstest rw auto quick
> +
> +. ./common/filter
> +
> +_require_test
> +_require_thp
> +
> +run_fsx -N 10000            -l 500000 -h
> +run_fsx -N 10000  -o 8192   -l 500000 -h
> +run_fsx -N 10000  -o 128000 -l 500000 -h
> +
> +status=0
> +exit
> diff --git a/tests/generic/758.out b/tests/generic/758.out
> new file mode 100644
> index 00000000..af04bb14
> --- /dev/null
> +++ b/tests/generic/758.out
> @@ -0,0 +1,4 @@
> +QA output created by 758
> +fsx -N 10000 -l 500000 -h
> +fsx -N 10000 -o 8192 -l 500000 -h
> +fsx -N 10000 -o 128000 -l 500000 -h
> diff --git a/tests/generic/759 b/tests/generic/759
> new file mode 100755
> index 00000000..514e7603
> --- /dev/null
> +++ b/tests/generic/759
> @@ -0,0 +1,26 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# FS QA Test No. 759
> +#
> +# fsx exercising direct IO reads/writes from userspace buffers
> +# backed by hugepages
> +#
> +. ./common/preamble
> +_begin_fstest rw auto quick
> +
> +. ./common/filter
> +
> +_require_test
> +_require_odirect
> +_require_thp
> +
> +psize=`$here/src/feature -s`
> +bsize=`$here/src/min_dio_alignment $TEST_DIR $TEST_DEV`
> +
> +run_fsx -N 10000            -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W -h
> +run_fsx -N 10000  -o 8192   -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W -h
> +run_fsx -N 10000  -o 128000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W -h
> +
> +status=0
> +exit
> diff --git a/tests/generic/759.out b/tests/generic/759.out
> new file mode 100644
> index 00000000..86bb66ef
> --- /dev/null
> +++ b/tests/generic/759.out
> @@ -0,0 +1,4 @@
> +QA output created by 759
> +fsx -N 10000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W -h
> +fsx -N 10000 -o 8192 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W -h
> +fsx -N 10000 -o 128000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W -h
> -- 
> 2.47.1
> 


