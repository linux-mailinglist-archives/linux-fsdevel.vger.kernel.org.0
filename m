Return-Path: <linux-fsdevel+bounces-26528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A76BA95A4E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 20:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC31F1C22C9D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 18:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475DB1B5303;
	Wed, 21 Aug 2024 18:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U810XPiD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F811B2ED8
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 18:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724266024; cv=none; b=pgcVTSErGZQdbBStYe90Dnhh85WwtjnXDtjBCDEOoAacHo1jXxYpmOjfRH7ZK9r8Ms2CswW/HJZlGYOWSxHTLejebHNdd39XV0Y3VWrtLXBn0Q/qAOvxfyU8V1+YoELBY09p6N2dF4EhjCqXDqOYTmvkhb1PTu6RO6I70gvakGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724266024; c=relaxed/simple;
	bh=W9Hyq6Il41NvtHVMGjlZLIU+xP8f0gf2RcjpKVRqm80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o3TRdeEr2/DNGLGWfiaGmNVkY/GRNhEKx+jCa9xbO6NfVfOY/mqeNI8Gy78AhD7xPH7EQw4ggmuXZN2m9ynFBTo6Wp/uBsWp61pC8WVL1IiN9w9iC5PyH2MzQPz1yOEjvoWKTu4swgdR72UwHHTaIT26nCQEGlz/tGc8ROVnJCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U810XPiD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724266022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t3HwX0urRRVamqrd2OG6BEVxWEdfk5MbvAIpPHwQ/pM=;
	b=U810XPiDgVz1KetNRIcnFdC4EiYy7gTgUm4I8VjXzkfqJisYPFqvETpFm/ESrILC7HrAZR
	fAXmrZjrMjS2jhZcQ+QZoeupYew4uxuAheVWGHrU37LhjzYzwMXK17HHg1Pqn4rrQ2gvjN
	wdIEjoy4bmGPULuqlcfoQF5T5SIXxTo=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-AOA-5VSyPjma6CTrSMHeSg-1; Wed, 21 Aug 2024 14:46:58 -0400
X-MC-Unique: AOA-5VSyPjma6CTrSMHeSg-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-71429090d44so845281b3a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 11:46:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724266017; x=1724870817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3HwX0urRRVamqrd2OG6BEVxWEdfk5MbvAIpPHwQ/pM=;
        b=JpBFAiYnR1wJcNqeMXIR++LB15Fm5kCRQvE8TOBBtFOtrHSNJJLILYNhwxub2CCf8b
         Cy1x2mu2oRgLzhgPbRizQ69FK36otwLkyOkAZlIjz3ZBiN2qESVNqIOuLF3V9aFbW9Qd
         kkw+z7bU28ng+bLk+NZNFqeZA3wUBZa95Uq1q11oRqPzuL0kvMKU91mKXN5pnpRlG+be
         81ieifjdZG9CzO19cv/FeuuWBgFBK8KNlrPyAtahnb1MquIjDyCVp1MqopGAu9jnWfb1
         zxfcPF5jNDh+FzkgAyA6jqaDs/zNuCpz5fXuPAJkRKFVJmDYkmYx/R1UoSvk6lnj0uru
         MJpw==
X-Forwarded-Encrypted: i=1; AJvYcCU6EAm25Evx9KXyAfLwpRAby4Blc7kV7qCcnGIcGJYndoDEy1r5vIrRkUosyoZ++K49EWaG4HI2VIOe+voH@vger.kernel.org
X-Gm-Message-State: AOJu0YxOLar37qE4p5NHHgBvDYwmUd8Iw/shuLtpSglho1NVoAL9NY/C
	Iav9sACbnVHWQ3EHRwAM8aO8qm/zvyldPwM6QILiFxmyZDcBbXuD0yQ6CPhqRK6jI0YzkuzOj1E
	s/MtEupie4niebBukk2u3yPz8wF5HLEoh7S8P7vpKe/O6vJTKhekb+d3bp73I29s=
X-Received: by 2002:a05:6a00:4b10:b0:714:2069:d90e with SMTP id d2e1a72fcca58-7142354ccd6mr3761370b3a.26.1724266017409;
        Wed, 21 Aug 2024 11:46:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTVQbwYr3xDyB+2yy0tUVPKts85eVqVshKQfM1kr1bAaaAiv7Zipo+038I6s5nWX1sKWBFyA==
X-Received: by 2002:a05:6a00:4b10:b0:714:2069:d90e with SMTP id d2e1a72fcca58-7142354ccd6mr3761345b3a.26.1724266016909;
        Wed, 21 Aug 2024 11:46:56 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714209bf529sm1958615b3a.160.2024.08.21.11.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 11:46:56 -0700 (PDT)
Date: Thu, 22 Aug 2024 02:46:53 +0800
From: Zorro Lang <zlang@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH fstests v2] generic/755: test that inode's ctime is
 updated on unlink
Message-ID: <20240821184653.dbwzyp2tiblsmkzw@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240820-master-v2-1-41703dddcc32@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820-master-v2-1-41703dddcc32@kernel.org>

On Tue, Aug 20, 2024 at 03:48:25PM -0400, Jeff Layton wrote:
> I recently found and fixed a bug in btrfs where it wasn't updating the
> citme on the target inode when unlinking [1]. Add a fstest for this.
> 
> [1]: https://lore.kernel.org/linux-btrfs/20240812-btrfs-unlink-v1-1-ee5c2ef538eb@kernel.org/
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> HCH suggested I roll a fstest for this problem that I found in btrfs the
> other day. This just creates a file and a hardlink to it, statx's it and
> then unlinks the hardlink and statx's it again. The ctimes are then
> compared.
> ---
> Changes in v2:
> - Turn it into a shell script.
> - Link to v1: https://lore.kernel.org/r/20240813-master-v1-1-862678cc4000@kernel.org
> ---
>  tests/generic/755     | 38 ++++++++++++++++++++++++++++++++++++++
>  tests/generic/755.out |  2 ++
>  2 files changed, 40 insertions(+)
> 
> diff --git a/tests/generic/755 b/tests/generic/755
> new file mode 100755
> index 000000000000..68da3b20073f
> --- /dev/null
> +++ b/tests/generic/755
> @@ -0,0 +1,38 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024, Jeff Layton <jlayton@kernel.org>
> +#
> +# FS QA Test No. 755
> +#
> +# Create a file, stat it and then unlink it. Does the ctime of the
> +# target inode change?
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +_require_test
> +_require_test_program unlink-ctime
                         ^^^^
This V2 shouldn't require this program, it's cause this case _notrun directly.
The 3bc2ac2f8f0b ("btrfs: update target inode's ctime on unlink") has been merged,

I'll remove this "_require_test_program" line, and add:
[ "$FSTYP = btrfs"] && _fixed_by_kernel_commit 3bc2ac2f8f0b \
	"btrfs: update target inode's ctime on unlink"

when I merge this patch. Others looks good to me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks,
Zorro

> +
> +testfile="$TEST_DIR/unlink-ctime1.$$"
> +testlink="$TEST_DIR/unlink-ctime2.$$"
> +
> +rm -f $testfile $testlink
> +touch $testfile
> +ln $testfile $testlink
> +
> +time1=$(stat -c "%Z" $testfile)
> +
> +sleep 2
> +unlink $testlink
> +
> +time2=$(stat -c "%Z" $testfile)
> +
> +unlink $testfile
> +
> +if [ $time1 -eq $time2 ]; then
> +	echo "Target's ctime did not change after unlink!"
> +fi
> +
> +echo Silence is golden
> +status=0
> +exit
> diff --git a/tests/generic/755.out b/tests/generic/755.out
> new file mode 100644
> index 000000000000..7c9ea51cd298
> --- /dev/null
> +++ b/tests/generic/755.out
> @@ -0,0 +1,2 @@
> +QA output created by 755
> +Silence is golden
> 
> ---
> base-commit: f5ada754d5838d29fd270257003d0d123a9d1cd2
> change-id: 20240813-master-e3b46de630bd
> 
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 
> 


