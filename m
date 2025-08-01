Return-Path: <linux-fsdevel+bounces-56531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF62FB1880A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 22:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB10316DC12
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 20:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EC520F07C;
	Fri,  1 Aug 2025 20:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GcNUWnBr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D819184524
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Aug 2025 20:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754079497; cv=none; b=iT1USLHSybQG/bLfyq+1tTq71RAG8li9xQ8niL07vmBYryXU3motbag65oqER16KXtE489fI7alCrWYk1Ul42jJt3oZZHWComAkzWTpYcwdRLXiwEkAjcX+0Kmj5SZMMHmXKPyWzbVnJP1LDHdTktml2eh+8lzTk4VUDOX0+fAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754079497; c=relaxed/simple;
	bh=uMkFiq6AZJwmIkFvE8ChgRTD51SuL7/Yyz2Dw604GGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wmodbfb07sPuSgHGVRViyJsR+Ii2f6wEoNX4Z/DPiE0NJO5aI2LslkcIRKiPPXR0PI3iVbSgKXRHHbYpHhDwupyUivCTtglNgIBpSGMwR9lFrww/7C7fqVR4v1x3hGiMvtsZEZYQhT38Rb6WlJ5bQakY+ls56YYygcjG7hj4Vzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GcNUWnBr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754079495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K7fmOopcTxDoSThpjeI/4cWAq0iS9rqmpGCXd3gUbIU=;
	b=GcNUWnBr1RKPEAwonBdoJQq27+UfArTyymBkkPh/uTayXEvHYTau+HRw3pJqi3m1lkm8xd
	ATRVBsXYOy3DSUypKZq77brP7XBjwpuJ1xzPRgrICGRHzpLSyViYi3xHrrZY8WGJS3V6KG
	SFNryIlB2f/+6M1qygdk01GkU7AVjxA=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-KiXeXtuROdOJrpOTr30Ekw-1; Fri, 01 Aug 2025 16:18:11 -0400
X-MC-Unique: KiXeXtuROdOJrpOTr30Ekw-1
X-Mimecast-MFC-AGG-ID: KiXeXtuROdOJrpOTr30Ekw_1754079491
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b38d8ee46a5so2269685a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Aug 2025 13:18:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754079491; x=1754684291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7fmOopcTxDoSThpjeI/4cWAq0iS9rqmpGCXd3gUbIU=;
        b=lD7Mb6EBMsLq2+J9p1P8w4cinICRa0zknLgJ9xe3eB9ift59GX6AMrwSVeqBnFXNUz
         vSuEoroWnJ86kT0exn7mCzhtTNmerEcb//AsIL1/Kp9+tW+v9BH+ZPGapUz6vSLqFEQs
         SlS66qf83PN2uLTIYSoYIjdklxcg7F0fXirJrCxc2x7tkyIx0jfSN5z9JlpEx5iacqOK
         C2mRlCsCROsQRkTaVFT3/SLbHE5il9BILqtzB1rlN45tUOABeKx0yCl98TCsTnn3g5up
         jkcOzDUq2ABxR8LKMDDmZy+blsonqRxyrTa9c2mXvP24l447H9cPXENwTOZfubxBiqSd
         /3Rg==
X-Forwarded-Encrypted: i=1; AJvYcCWnxU+qjFRQ8jimnYB84mu7x8Sgt3UBFPtNJ0Hy6ktKjPDu7zxyIM5qEjWbeh+7rQpe6Gqti87/0l7/uqd7@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Apl+6B9Gw5ieWpjYHZrlWdV04Nun5oiAgiCr8Fu2OE/AJUIu
	4lY1neAOJpp9vrFZB7SLEkZ/tgR77/FTfj0tUFo3mGkeoYVIBYHVsUUr3ZWMB1TOXw/nsjbrRAE
	qMs+J6fIWDqQTvlFNDhbKWB5+3v04swUhjNFKAGmMT1cDQUguB7q+G8P18WRVTwEjySw=
X-Gm-Gg: ASbGncv/kxEhu+72zEIUum+MvC4zWsu8nOFWFHYfDDbfoom/q44S6KoywSFUJyM3KZC
	+F8cdAnCVnaWb24EIj/LlwQWJTom+tUaRVJBrDjy9KXXRDjLWv8XxqIsOEzSp/g2fjDWlUY2K0R
	a56CNs3w6LwdVIYOh0EK9bLsLwKLRigoOpQFcPXwz3Gwt9O4dyp6WgjQaE/ZYCa3Vb5xM+CJJLB
	9ArxmAMfmIqUj+Ut1sAhv01Jzbp3l1INmAQFetHr3QZ1YhreJq6HxLgKZ9zA1Hg0Hk6nwZapR18
	S1GiIUFZ8dfLRyTJdM2kKsTGxUDt34NR6fxcH1gReiXVTZd0YjEa2tlcVa60MN9L3ViQ2xNsOtl
	0WuPo
X-Received: by 2002:a05:6a20:9194:b0:238:351a:f960 with SMTP id adf61e73a8af0-23df91b34aemr1471821637.23.1754079490596;
        Fri, 01 Aug 2025 13:18:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnzxdlMr0kIE/UaMgUjepudz7ra/RPe6/qih6kTRpTDvU2Nw2pt+5LvbeotXDB7/B318tkrw==
X-Received: by 2002:a05:6a20:9194:b0:238:351a:f960 with SMTP id adf61e73a8af0-23df91b34aemr1471799637.23.1754079490222;
        Fri, 01 Aug 2025 13:18:10 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce6fe4bsm4837616b3a.9.2025.08.01.13.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 13:18:09 -0700 (PDT)
Date: Sat, 2 Aug 2025 04:18:05 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Jan Kara <jack@suse.cz>, "Darrick J . Wong" <djwong@kernel.org>,
	John Garry <john.g.garry@oracle.com>
Subject: Re: [RFC 2/2] generic: Add integrity tests for O_DSYNC and RWF_DSYNC
 writes
Message-ID: <20250801201805.6h7sa2oyrvhnalph@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <28abb8a0c4031ce07b475bf9026eedc23892868b.1753964363.git.ritesh.list@gmail.com>
 <9b2427b42e8716c359a36624fd6363f71583941b.1753964363.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b2427b42e8716c359a36624fd6363f71583941b.1753964363.git.ritesh.list@gmail.com>

On Thu, Jul 31, 2025 at 06:05:55PM +0530, Ritesh Harjani (IBM) wrote:
> This test verifies the data & required metadata (e.g. inode i_size for extending
> writes) integrity when using O_DSYNC and RWF_DSYNC during writes operations,
> across buffered-io, aio-dio and dio, in the event of a sudden filesystem
> shutdown after write completion.
> 
> Man page of open says that -
> O_DSYNC provides synchronized I/O data integrity completion, meaning
> write operations will flush data to the underlying hardware, but will
> only flush metadata updates that are required to allow a subsequent read
> operation to complete successfully.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  tests/generic/737     | 30 +++++++++++++++++++++++++++++-
>  tests/generic/737.out | 21 +++++++++++++++++++++
>  2 files changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/generic/737 b/tests/generic/737
> index 99ca1f39..0f27c82b 100755
> --- a/tests/generic/737
> +++ b/tests/generic/737
> @@ -4,7 +4,8 @@
>  #
>  # FS QA Test No. 737
>  #
> -# Integrity test for O_SYNC with buff-io, dio, aio-dio with sudden shutdown.
> +# Integrity test for O_[D]SYNC and/or RWF_DSYNC with buff-io, dio, aio-dio with
> +# sudden shutdown.
>  # Based on a testcase reported by Gao Xiang <hsiangkao@linux.alibaba.com>
>  #
> 
> @@ -21,6 +22,15 @@ _require_aiodio aio-dio-write-verify
>  _scratch_mkfs > $seqres.full 2>&1
>  _scratch_mount
> 
> +echo "T-0: Create a 1M file using buff-io & RWF_DSYNC"
> +$XFS_IO_PROG -f -c "pwrite -V 1 -D -S 0x5a 0 1M" $SCRATCH_MNT/testfile.t1 > /dev/null 2>&1
> +echo "T-0: Shutdown the fs suddenly"
> +_scratch_shutdown
> +echo "T-0: Cycle mount"
> +_scratch_cycle_mount
> +echo "T-0: File contents after cycle mount"
> +_hexdump $SCRATCH_MNT/testfile.t1
> +
>  echo "T-1: Create a 1M file using buff-io & O_SYNC"
>  $XFS_IO_PROG -fs -c "pwrite -S 0x5a 0 1M" $SCRATCH_MNT/testfile.t1 > /dev/null 2>&1
>  echo "T-1: Shutdown the fs suddenly"
> @@ -48,5 +58,23 @@ _scratch_cycle_mount
>  echo "T-3: File contents after cycle mount"
>  _hexdump $SCRATCH_MNT/testfile.t3
> 
> +echo "T-4: Create a 1M file using DIO & RWF_DSYNC"
> +$XFS_IO_PROG -fdc "pwrite -V 1 -S 0x5a -D 0 1M" $SCRATCH_MNT/testfile.t4 > /dev/null 2>&1
> +echo "T-4: Shutdown the fs suddenly"
> +_scratch_shutdown
> +echo "T-4: Cycle mount"
> +_scratch_cycle_mount
> +echo "T-4: File contents after cycle mount"
> +_hexdump $SCRATCH_MNT/testfile.t4
> +
> +echo "T-5: Create a 1M file using AIO-DIO & O_DSYNC"
> +$AIO_TEST -a size=1048576 -D -N $SCRATCH_MNT/testfile.t5 > /dev/null 2>&1
> +echo "T-5: Shutdown the fs suddenly"
> +_scratch_shutdown
> +echo "T-5: Cycle mount"
> +_scratch_cycle_mount
> +echo "T-5: File contents after cycle mount"
> +_hexdump $SCRATCH_MNT/testfile.t5

I always hit "No such file or directory" [1], is this an expected test failure
which you hope to uncover?

[1]
# diff -u /root/git/xfstests/tests/generic/737.out /root/git/xfstests/results//generic/737.out.bad
--- /root/git/xfstests/tests/generic/737.out    2025-08-02 04:04:57.334489725 +0800
+++ /root/git/xfstests/results//generic/737.out.bad     2025-08-02 04:12:08.167934723 +0800
@@ -28,16 +28,14 @@
 *
 100000
 T-4: Create a 1M file using DIO & RWF_DSYNC
 T-4: Shutdown the fs suddenly
 T-4: Cycle mount
 T-4: File contents after cycle mount
-000000 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  >ZZZZZZZZZZZZZZZZ<
-*
-100000
+od: /mnt/scratch/testfile.t4: No such file or directory
 T-5: Create a 1M file using AIO-DIO & O_DSYNC
 T-5: Shutdown the fs suddenly
 T-5: Cycle mount
 T-5: File contents after cycle mount
-000000 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  >ZZZZZZZZZZZZZZZZ<
-*
-100000
+od: /mnt/scratch/testfile.t5: No such file or directory

> +
>  status=0
>  exit
> diff --git a/tests/generic/737.out b/tests/generic/737.out
> index efe6ff1f..2bafeefa 100644
> --- a/tests/generic/737.out
> +++ b/tests/generic/737.out
> @@ -1,4 +1,11 @@
>  QA output created by 737
> +T-0: Create a 1M file using buff-io & RWF_DSYNC
> +T-0: Shutdown the fs suddenly
> +T-0: Cycle mount
> +T-0: File contents after cycle mount
> +000000 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  >ZZZZZZZZZZZZZZZZ<
> +*
> +100000
>  T-1: Create a 1M file using buff-io & O_SYNC
>  T-1: Shutdown the fs suddenly
>  T-1: Cycle mount
> @@ -20,3 +27,17 @@ T-3: File contents after cycle mount
>  000000 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  >ZZZZZZZZZZZZZZZZ<
>  *
>  100000
> +T-4: Create a 1M file using DIO & RWF_DSYNC
> +T-4: Shutdown the fs suddenly
> +T-4: Cycle mount
> +T-4: File contents after cycle mount
> +000000 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  >ZZZZZZZZZZZZZZZZ<
> +*
> +100000
> +T-5: Create a 1M file using AIO-DIO & O_DSYNC
> +T-5: Shutdown the fs suddenly
> +T-5: Cycle mount
> +T-5: File contents after cycle mount
> +000000 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  >ZZZZZZZZZZZZZZZZ<
> +*
> +100000
> --
> 2.49.0
> 
> 


