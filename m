Return-Path: <linux-fsdevel+bounces-56532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 239EDB18829
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 22:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 142917A93AD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 20:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C4420102B;
	Fri,  1 Aug 2025 20:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtDeiYyj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6C51F09A8;
	Fri,  1 Aug 2025 20:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754080392; cv=none; b=PcoL+2ZVRjhkv41AKqueAGENMp3kdpv6+5CFgiTMWGUnVlJ1q+YbNvuE8rLJEQNraS4FXb8l1msnjRq/jie8H6VcXPsh+UuNwRDrgE/rBtwnHMqO9xpzbCs9zsv2M0KDudnEZrXIhsu+LBEYdEJSu4Glao0Nem52vz8fZ/asmXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754080392; c=relaxed/simple;
	bh=9XXTNFkKX93ExU4nU5y0vLDtpfUfoFdrzbVoAJHQ7QI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=jjATwDyA5+a8/8XNRUO2Q+Or9w8P1JKVGIac9hauf9T7LopXMwBR2Fm+T7s/TQqG3VP9a9dydhxln9G/iu7J0r9FjngGhpnBf6u38rQHYxXZuHq/tfoG7hjABfK7kxW/Up+uxAQBCx3WVsMIIIvOArlXhXB9bz+ZjzzVslvztJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtDeiYyj; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-313910f392dso1194095a91.2;
        Fri, 01 Aug 2025 13:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754080390; x=1754685190; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IonNFwNibXi0ML1RRQsO+uszmDRGLvxUJiVCLku6uLA=;
        b=RtDeiYyjOzxqP8Bzco44aM4/xqWLlXYMQQkh0BFGiu8/QUUOBeGX3+OlPO3yehfA4h
         M9jRKUTAeowEjV0URV44vPdMjFxrx2KU68UmxTHQgw4pOK5X6YJ5NJ02N9N/fdgeBZPh
         IFpomT0LSnuuuzTQZ642SPIaJSA6uxkdfnAkpL7BDhxF/zn5TS5Cwrd7pv7EKGm1hrvB
         sdfKYWmx346l7aP1bmiP/9me/WLvTWkSaazTjyrnC+YdLRafhWZ3rA5SNAFpER+YW2Pk
         QdGpXVErfYIfaPd7V0i/AZQdrttsSFYgCcXZXDcKlgnnJCiCz+lncXJ7qS838NfPYTCi
         Uj6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754080390; x=1754685190;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IonNFwNibXi0ML1RRQsO+uszmDRGLvxUJiVCLku6uLA=;
        b=Fnwg4yJlcNSYjGWj3e0IH8K3pQNxVtw2lRQcOJJ8LFNmmsylOOU58UBsajgEA5G87Y
         rxeEGb9RBP1457rL65zOYNJHZd1Gm90GVgvLjisiDYZjPbwh+F7tWJ9Fy0vITWlvSb44
         FG6dP30TcTzos76pT+yViov4M1nylqk/c/5nwRIfCEQBl8NuMBVV+tBvzu08zUXwL72v
         iX1+fJJYR/RVNLQER4qCqysEr4CAcn9LZMm9qgjOYVJiC7dJ5QCBfIGOTm8olDjiPSyU
         WBYw/t/dDKEzkYNqJ47E7fVhxoh6uW9aP/Wa6/3ZbnMPvQOugcec2YF/krjgIom4SJqz
         kE4w==
X-Forwarded-Encrypted: i=1; AJvYcCWFTZQsz1w3+39BAOP3AGWMNX7CRocu9leEXnLFzNPvLeJ5AETp4Z4kpX3DIOo/2Ha1SNBFn3NLCzCKy16h@vger.kernel.org
X-Gm-Message-State: AOJu0YwjrbkfLY+Ohoolkyj/A5ov/sO3X/blD+hiyzCnEJeCQuKlEovm
	PPUCVW0xw0azsug3mX3DgqilxEmXAz4OXAXGIGjq/WVYFO3DOA2UjBkf
X-Gm-Gg: ASbGncvKIUhZ57ijiSc+nVBlNfQLuGg8oc3PQIpJhUJUWseAkfqK7jVyp2M7+FTddA2
	I5bcKyhPac2mEkTkfY1vu3hT1u9iwIaJtblg59Yzoi39+w5rGWetgT3pnOK5JJxZ3PSwKf+SYh0
	TQ4yFaPAD3CwnOUZqhkKWNccLYmjpo4HaDZql3hE9EHx4Bq0JXFGts2scGetf4i+iCvewwwUhj1
	B68KSlwIGlcJkYnGjH0cLcM/WfKAuAa1geDeB0KbLHSbtNe2zoVg93WGZA3TtW/2lQauvqcFntR
	H4RbcZCzUF7oQtku1CS2fIDz+jUw/CiiqsgL2Yqi5d0foERe7VW28JxeSTahbwDfoJP9mqtGouT
	rrUkY2sWSOIK3yog=
X-Google-Smtp-Source: AGHT+IFisPucr0CBbFVrCHTeWl3rbbexa+jkEhE0hr71lCEb65aY3v93pnZdskCuDFj6KWJuNeWBNA==
X-Received: by 2002:a17:90b:3d91:b0:31f:1744:e7fd with SMTP id 98e67ed59e1d1-321162cb314mr1061211a91.31.1754080389710;
        Fri, 01 Aug 2025 13:33:09 -0700 (PDT)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3207eba6bb8sm5503919a91.4.2025.08.01.13.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 13:33:09 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, "Darrick J . Wong" <djwong@kernel.org>, John Garry <john.g.garry@oracle.com>
Subject: Re: [RFC 2/2] generic: Add integrity tests for O_DSYNC and RWF_DSYNC writes
In-Reply-To: <20250801201805.6h7sa2oyrvhnalph@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Date: Sat, 02 Aug 2025 01:59:18 +0530
Message-ID: <87plderdk1.fsf@gmail.com>
References: <28abb8a0c4031ce07b475bf9026eedc23892868b.1753964363.git.ritesh.list@gmail.com> <9b2427b42e8716c359a36624fd6363f71583941b.1753964363.git.ritesh.list@gmail.com> <20250801201805.6h7sa2oyrvhnalph@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Zorro Lang <zlang@redhat.com> writes:

> On Thu, Jul 31, 2025 at 06:05:55PM +0530, Ritesh Harjani (IBM) wrote:
>> This test verifies the data & required metadata (e.g. inode i_size for extending
>> writes) integrity when using O_DSYNC and RWF_DSYNC during writes operations,
>> across buffered-io, aio-dio and dio, in the event of a sudden filesystem
>> shutdown after write completion.
>> 
>> Man page of open says that -
>> O_DSYNC provides synchronized I/O data integrity completion, meaning
>> write operations will flush data to the underlying hardware, but will
>> only flush metadata updates that are required to allow a subsequent read
>> operation to complete successfully.
>> 
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>  tests/generic/737     | 30 +++++++++++++++++++++++++++++-
>>  tests/generic/737.out | 21 +++++++++++++++++++++
>>  2 files changed, 50 insertions(+), 1 deletion(-)
>> 
>> diff --git a/tests/generic/737 b/tests/generic/737
>> index 99ca1f39..0f27c82b 100755
>> --- a/tests/generic/737
>> +++ b/tests/generic/737
>> @@ -4,7 +4,8 @@
>>  #
>>  # FS QA Test No. 737
>>  #
>> -# Integrity test for O_SYNC with buff-io, dio, aio-dio with sudden shutdown.
>> +# Integrity test for O_[D]SYNC and/or RWF_DSYNC with buff-io, dio, aio-dio with
>> +# sudden shutdown.
>>  # Based on a testcase reported by Gao Xiang <hsiangkao@linux.alibaba.com>
>>  #
>> 
>> @@ -21,6 +22,15 @@ _require_aiodio aio-dio-write-verify
>>  _scratch_mkfs > $seqres.full 2>&1
>>  _scratch_mount
>> 
>> +echo "T-0: Create a 1M file using buff-io & RWF_DSYNC"
>> +$XFS_IO_PROG -f -c "pwrite -V 1 -D -S 0x5a 0 1M" $SCRATCH_MNT/testfile.t1 > /dev/null 2>&1
>> +echo "T-0: Shutdown the fs suddenly"
>> +_scratch_shutdown
>> +echo "T-0: Cycle mount"
>> +_scratch_cycle_mount
>> +echo "T-0: File contents after cycle mount"
>> +_hexdump $SCRATCH_MNT/testfile.t1
>> +
>>  echo "T-1: Create a 1M file using buff-io & O_SYNC"
>>  $XFS_IO_PROG -fs -c "pwrite -S 0x5a 0 1M" $SCRATCH_MNT/testfile.t1 > /dev/null 2>&1
>>  echo "T-1: Shutdown the fs suddenly"
>> @@ -48,5 +58,23 @@ _scratch_cycle_mount
>>  echo "T-3: File contents after cycle mount"
>>  _hexdump $SCRATCH_MNT/testfile.t3
>> 
>> +echo "T-4: Create a 1M file using DIO & RWF_DSYNC"
>> +$XFS_IO_PROG -fdc "pwrite -V 1 -S 0x5a -D 0 1M" $SCRATCH_MNT/testfile.t4 > /dev/null 2>&1
>> +echo "T-4: Shutdown the fs suddenly"
>> +_scratch_shutdown
>> +echo "T-4: Cycle mount"
>> +_scratch_cycle_mount
>> +echo "T-4: File contents after cycle mount"
>> +_hexdump $SCRATCH_MNT/testfile.t4
>> +
>> +echo "T-5: Create a 1M file using AIO-DIO & O_DSYNC"
>> +$AIO_TEST -a size=1048576 -D -N $SCRATCH_MNT/testfile.t5 > /dev/null 2>&1
>> +echo "T-5: Shutdown the fs suddenly"
>> +_scratch_shutdown
>> +echo "T-5: Cycle mount"
>> +_scratch_cycle_mount
>> +echo "T-5: File contents after cycle mount"
>> +_hexdump $SCRATCH_MNT/testfile.t5
>
> I always hit "No such file or directory" [1], is this an expected test failure
> which you hope to uncover?

Yes, we will need this fix [1] from Jan. Sorry I missed to add that in the commit
message. Could you please give it a try with the fix maybe?

[1]:
https://lore.kernel.org/linux-fsdevel/20250730102840.20470-2-jack@suse.cz/

-ritesh


>
> [1]
> # diff -u /root/git/xfstests/tests/generic/737.out /root/git/xfstests/results//generic/737.out.bad
> --- /root/git/xfstests/tests/generic/737.out    2025-08-02 04:04:57.334489725 +0800
> +++ /root/git/xfstests/results//generic/737.out.bad     2025-08-02 04:12:08.167934723 +0800
> @@ -28,16 +28,14 @@
>  *
>  100000
>  T-4: Create a 1M file using DIO & RWF_DSYNC
>  T-4: Shutdown the fs suddenly
>  T-4: Cycle mount
>  T-4: File contents after cycle mount
> -000000 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  >ZZZZZZZZZZZZZZZZ<
> -*
> -100000
> +od: /mnt/scratch/testfile.t4: No such file or directory
>  T-5: Create a 1M file using AIO-DIO & O_DSYNC
>  T-5: Shutdown the fs suddenly
>  T-5: Cycle mount
>  T-5: File contents after cycle mount
> -000000 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  >ZZZZZZZZZZZZZZZZ<
> -*
> -100000
> +od: /mnt/scratch/testfile.t5: No such file or directory
>
>> +
>>  status=0
>>  exit
>> diff --git a/tests/generic/737.out b/tests/generic/737.out
>> index efe6ff1f..2bafeefa 100644
>> --- a/tests/generic/737.out
>> +++ b/tests/generic/737.out
>> @@ -1,4 +1,11 @@
>>  QA output created by 737
>> +T-0: Create a 1M file using buff-io & RWF_DSYNC
>> +T-0: Shutdown the fs suddenly
>> +T-0: Cycle mount
>> +T-0: File contents after cycle mount
>> +000000 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  >ZZZZZZZZZZZZZZZZ<
>> +*
>> +100000
>>  T-1: Create a 1M file using buff-io & O_SYNC
>>  T-1: Shutdown the fs suddenly
>>  T-1: Cycle mount
>> @@ -20,3 +27,17 @@ T-3: File contents after cycle mount
>>  000000 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  >ZZZZZZZZZZZZZZZZ<
>>  *
>>  100000
>> +T-4: Create a 1M file using DIO & RWF_DSYNC
>> +T-4: Shutdown the fs suddenly
>> +T-4: Cycle mount
>> +T-4: File contents after cycle mount
>> +000000 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  >ZZZZZZZZZZZZZZZZ<
>> +*
>> +100000
>> +T-5: Create a 1M file using AIO-DIO & O_DSYNC
>> +T-5: Shutdown the fs suddenly
>> +T-5: Cycle mount
>> +T-5: File contents after cycle mount
>> +000000 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  >ZZZZZZZZZZZZZZZZ<
>> +*
>> +100000
>> --
>> 2.49.0
>> 
>> 

