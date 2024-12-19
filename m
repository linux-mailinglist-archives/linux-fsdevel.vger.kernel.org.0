Return-Path: <linux-fsdevel+bounces-37858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14ED39F82C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 19:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 300591899E71
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 17:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD911A0BFB;
	Thu, 19 Dec 2024 17:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Amy0BJEC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7224D199234;
	Thu, 19 Dec 2024 17:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734630772; cv=none; b=lu19nbHQzoT+SJVYfKX8vwAx5dqrro3YVxejNoQJPadGcVCaGtxbfvyNXyGNyVQtEWb5rGG41LHi0dqVc1tIjHPi5XAsuz0ha1Mp5H8czKridOkTnfdexZP6rx9XxQcEtQ581lFtGmLb5PPhjbet43FsMjjLlNqlkcPy5WGbmHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734630772; c=relaxed/simple;
	bh=F/ejyaow6rzNUPRFErXeyw1aHICk0FHlQOdXhIUJSRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5GazYr55QWMPnrmxGccNnhHpfs2XvWePF7ym/7kuZQUScY4SfKj54wi0Hbl1LOmm2g+yOAfjT19Db0rat+5g/JLjE15S/cakgFuf4dofz1xk/LqY33XLKg+ki1eKVH5NMhI9bZShIZHpw7wnjC/pTUhVE3pIdtcVFvnyWW+CX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Amy0BJEC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E72AC4CECE;
	Thu, 19 Dec 2024 17:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734630772;
	bh=F/ejyaow6rzNUPRFErXeyw1aHICk0FHlQOdXhIUJSRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Amy0BJECkEjmRtM2EIXUbeU0sRN7VydsbOtPl5C9iFnhLtduT69JjvzNKYdQqDSuP
	 Kzhc8rjOLlcMxX6mdHoZEdbQaJAUfRchtvFJOymHhpW1shfL3tiVz5rB1pUiCiviNk
	 ky5JCo/716MGo0LUweGNcwzaPGay7lWz9HrTPTy6NXTkmx4pt9K5hpb8fDVZ1WEJSR
	 QHEE7Pp7rfcCFBxSjXiugH0HyW1CvICAnvc1/jk8Ps4c8iFp2L6r3nKaJrwsOfYrym
	 Q9Oic83m3pz+Yn5ILp52D7ccQKERx9Oie7cvRvZFslLmEWw0wiXzInHrEChVbCYHZ/
	 WJlLNcdcLCojA==
Date: Thu, 19 Dec 2024 09:52:51 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 2/2] generic: add tests for read/writes from
 hugepages-backed buffers
Message-ID: <20241219175251.GH6160@frogsfrogsfrogs>
References: <20241218210122.3809198-1-joannelkoong@gmail.com>
 <20241218210122.3809198-3-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218210122.3809198-3-joannelkoong@gmail.com>

On Wed, Dec 18, 2024 at 01:01:22PM -0800, Joanne Koong wrote:
> Add generic tests 758 and 759 for testing reads/writes from buffers
> backed by hugepages.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  common/rc             | 10 ++++++++++
>  tests/generic/758     | 23 +++++++++++++++++++++++
>  tests/generic/758.out |  4 ++++
>  tests/generic/759     | 24 ++++++++++++++++++++++++
>  tests/generic/759.out |  4 ++++
>  5 files changed, 65 insertions(+)
>  create mode 100755 tests/generic/758
>  create mode 100644 tests/generic/758.out
>  create mode 100755 tests/generic/759
>  create mode 100644 tests/generic/759.out
> 
> diff --git a/common/rc b/common/rc
> index 1b2e4508..33af7fa7 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3016,6 +3016,16 @@ _require_xfs_io_command()
>  	fi
>  }
>  
> +# check that the kernel and system supports huge pages
> +_require_thp()
> +{
> +    thp_status=$(cat /sys/kernel/mm/transparent_hugepage/enabled)
> +    if [[ $thp_status == *"[never]"* ]]; then
> +	    _notrun "system doesn't support transparent hugepages"
> +    fi
> +    _require_kernel_config CONFIG_TRANSPARENT_HUGEPAGE

Will /sys/kernel/mm/transparent_hugepage/ exist if
CONFIG_TRANSPARENT_HUGEPAGE=n ?

Or put another way, if /sys/kernel/mm/transparent_hugepage/ doesn't
exist, is that a sign that hugepages aren't enabled?

> +}
> +
>  # check that kernel and filesystem support direct I/O, and check if "$1" size
>  # aligned (optional) is supported
>  _require_odirect()
> diff --git a/tests/generic/758 b/tests/generic/758
> new file mode 100755
> index 00000000..b3bd6e5b
> --- /dev/null
> +++ b/tests/generic/758
> @@ -0,0 +1,23 @@
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
> +# Import common functions.

No need for ^^ this comment.  Same with 759.

--D

> +. ./common/filter
> +
> +_require_test
> +_require_thp
> +
> +run_fsx -N 10000   	    -l 500000 -h
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
> index 00000000..6dfe2b86
> --- /dev/null
> +++ b/tests/generic/759
> @@ -0,0 +1,24 @@
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
> +# Import common functions.
> +. ./common/filter
> +
> +_require_test
> +_require_odirect
> +_require_thp
> +
> +run_fsx -N 10000            -l 500000 -Z -R -W -h
> +run_fsx -N 10000  -o 8192   -l 500000 -Z -R -W -h
> +run_fsx -N 10000  -o 128000 -l 500000 -Z -R -W -h
> +
> +status=0
> +exit
> diff --git a/tests/generic/759.out b/tests/generic/759.out
> new file mode 100644
> index 00000000..18d21229
> --- /dev/null
> +++ b/tests/generic/759.out
> @@ -0,0 +1,4 @@
> +QA output created by 759
> +fsx -N 10000 -l 500000 -Z -R -W -h
> +fsx -N 10000 -o 8192 -l 500000 -Z -R -W -h
> +fsx -N 10000 -o 128000 -l 500000 -Z -R -W -h
> -- 
> 2.47.1
> 
> 

