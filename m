Return-Path: <linux-fsdevel+bounces-39339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDFEA12DDB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 22:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C6F11664D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 21:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640BD1DB366;
	Wed, 15 Jan 2025 21:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D01Lt0ca"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEFC1D61B7;
	Wed, 15 Jan 2025 21:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736977219; cv=none; b=fZH3vsB2PPEy4CLHti3G1HtCJK6Qs+T0Hta6sG1J8kIzlIrT8cAb88VgnJbFX0EyBijiWb/ytw0eRxHqlKSy4YNfRKOXJC+B1+KHl28F2+XMXUJp8baV0K2yekEpEByZ5YD5Ba2+xDoI8c+mj+uqPGIntk0bMklLcrE7F+tgLk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736977219; c=relaxed/simple;
	bh=6vboC0nCKtNL4IrreyugR1iZPp21Qld3yhPTbyqLIyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P85Oy3ZzvlEEpQVbxCCyLvxcxkgmsjPJWNUr8JhvHXrblJ9jUagThdkBit/2A5R9fL9GK+H4UTaPVJQ647pb0P5ryi49kW1MogYAtxzH/wECGTqZeG0yqK7Kk4HClv/ZZDbVd7iEqns6dyVnDGVP4UeczlKCae2FB1xKjyDDwmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D01Lt0ca; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B79DC4CED1;
	Wed, 15 Jan 2025 21:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736977219;
	bh=6vboC0nCKtNL4IrreyugR1iZPp21Qld3yhPTbyqLIyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D01Lt0caXMYuBRr7ugke1x2tbToe6mSq8c4XqofjgqsFGugmxaoYt9IHvMXKPh5M/
	 skWl7x6nM7t3qn4l15anJssTzj61ISkOzzaoOdeBGPoSYHLnDfpDzSAF6VTpLcJuJe
	 nL90NGxAWjVpzeNITfK49GGMbjHx/AgElVEME3Rwobl5Hsj2ZH7Yz6AltFPJsyGAQZ
	 5cRikue6tQgWECKNQ+G/ZCQKUKEmT3KlYErDhiFP/CaD5EJywbmgRTDdpg8+FbCHiC
	 0nOZYrP8lC3zQiwxB1e3Hb34thnhqGeUOEEY0ctgEAt8GvICvO4a8iVfr59fSIGB8n
	 gnTp5EPh3an/A==
Date: Wed, 15 Jan 2025 13:40:18 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	bfoster@redhat.com, nirjhar@linux.ibm.com, zlang@redhat.com,
	kernel-team@meta.com
Subject: Re: [PATCH v3 2/2] generic: add tests for read/writes from
 hugepages-backed buffers
Message-ID: <20250115214018.GF3557695@frogsfrogsfrogs>
References: <20250115183107.3124743-1-joannelkoong@gmail.com>
 <20250115183107.3124743-3-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115183107.3124743-3-joannelkoong@gmail.com>

On Wed, Jan 15, 2025 at 10:31:07AM -0800, Joanne Koong wrote:
> Add generic tests 758 and 759 for testing reads/writes from buffers
> backed by hugepages.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Reviewed-by: Brian Foster <bfoster@redhat.com>
> ---
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

Tabs, not spaces.

With that fixed,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

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
> 

