Return-Path: <linux-fsdevel+bounces-50027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92636AC788C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 08:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CAC0A4316C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 06:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75055253925;
	Thu, 29 May 2025 06:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FrQjX5Ax"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499F8156CA;
	Thu, 29 May 2025 06:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748498728; cv=none; b=AV0UhDDkVsXzQx9YPbbs7HI3ljkno0FDzhrUzJHdLLqDeDVzAW/2AYDBVznwzQKSA7gkPcQhW81TheR762ibfz7ZZTGdEwd8uEXBNTYJ9W2LILtNgETqqGWe1WNwK8QNHyLGT4fv2CjMSXSC5KA67ZPanyGhvaHgOTd9R5NLziU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748498728; c=relaxed/simple;
	bh=+K6x7KQc4CJrNoyePfZ4Pg9lH2cvNL6WJZsoIRkefEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XVZ7LnGBgVv2NCuas6JEBpkp2Ce+GktnxjxKvtSZ0X+VfP9ukq8JBk0X+fgg6sb059TsFisdyH7pnm1DshUK6xq2iYUjALY0d2R2V0Km/xcnXeWHfymauHiJ/CkQQfbH9DR5gBdBgoEm7nnkr5HGdUro6OPoJPB2BPVzESppcHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FrQjX5Ax; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6faacf5d5adso6778536d6.1;
        Wed, 28 May 2025 23:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748498726; x=1749103526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DsnlFjDSAerLByUBZIaZMjb7C0c0RFSEQQmuGUUljbg=;
        b=FrQjX5AxOyPb3cirrb69tdqCoTCvhav9Wm7odZtGS0QM7YRdWrqR0MmzynYrFwZKV3
         M6mp/qNUzb6HfM1f5QJu1bLMGjo/sHroi/uCbB4k/aerYcSp67PgvCcV+vrj64Ib7mHB
         Fr8nzk4e9T9EfToE105nXKshdT5eHHnsJlngQAOFWeVf6T1kvnv2leZsjm4kr+RV602d
         n1DuoLYUamtC71b4KELOuqtM+I+8eIFVux/mv89g+s0jVGkVmPbmaJQ5R6krndlleWT9
         Y3MCqKF8L1j70cyRXCPZrd7bmjwTTGJY77xGkZJXivY9Gd+sB1Yv3kUCiB59+2F3sqeQ
         uNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748498726; x=1749103526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DsnlFjDSAerLByUBZIaZMjb7C0c0RFSEQQmuGUUljbg=;
        b=DL5JJMIPyXbLbszRcyDTC8oUyylfovdkAla/B4M6z1AKwjHi+cVNP32JqiLgTBDsPu
         yInX7XgHyklSL42jjTkMizsGP9/4WjFRb/M2swrLVBTfeJkOzVa3p3HnQAv4Kzfr9863
         yknBsvxcq/5KF7zInRX9otJWRVKn5uLkhfo36FfdF9QTWshzaHrWPOIPQSwOYKCwhPWs
         HJTB22fVQLP6XOXmx+GOBhsqxyabNEzYPZzSwWynHdebs1IAeDL72Ng9jnBbCCzroLK4
         EBcxAxlKRHhum9nwDHqtoxWfI5oyrFedvfINwlU1Z5OBJlOhV6SuFPVlYleSW6oObeGo
         MLXg==
X-Forwarded-Encrypted: i=1; AJvYcCWYHD4kMOcgmlOakxgEnc1LqNgfXgRBO7MHMqzGQQlmgII7Bf/8iHbN3jj+AgwVJTFD9+mxHKaHTlqS@vger.kernel.org, AJvYcCXInQrrRJI6yaDye4DlNP8IhiAgS7Q5yj0yxqtX8+xsNC2gEMxhfEL9CmsEub9U68nSCLDrUzYdZpbbaz9v@vger.kernel.org
X-Gm-Message-State: AOJu0Yyry7DnviQ1xlmISo7qlNrCcrm2tFQhlj4KglLKV0PgBj00QYqh
	zkwvoGyYiytmFUo7HTouz46LPOSapD4bxfcMJ1U0qtRUNKPRalHArs3xtNTClM/sElrEMFO4Moq
	voyJBS++aWlC8+pUkuZvzjkxNSiRYIIBZmFpkbftJ8A==
X-Gm-Gg: ASbGnctD5taFFbGjd42yr2EasrxGt/NlkdUuZyQ9dDxTczExYekI4mFLGUU1egCBtNn
	guLTYbeKwtVFFUbIREMyUaLmUTY6CgFdvBgWTGPXiJC8gxpjawoo1dnbqeeMItx6S57V0I3Qcgt
	Ur4f3j/sLZx4HIWkxuNctFf8vHtq0y892ngA==
X-Google-Smtp-Source: AGHT+IEuvhXh0q0XunBL7hdWtxMSjK6T8vZYlT8D5ycyUymcCIchHuQNFLVpJ83JaAgNw+3Zt6XsLkx3SFQ7qhbrnOE=
X-Received: by 2002:a05:6214:16f:b0:6fa:c492:2db7 with SMTP id
 6a1803df08f44-6fac83fca77mr13682876d6.13.1748498726027; Wed, 28 May 2025
 23:05:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALOAHbDm7-byF8DCg1JH5rb4Yi8FBtrsicojrPvYq8AND=e6hQ@mail.gmail.com>
 <aDfkTiTNH1UPKvC7@dread.disaster.area>
In-Reply-To: <aDfkTiTNH1UPKvC7@dread.disaster.area>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 29 May 2025 14:04:50 +0800
X-Gm-Features: AX0GCFumJN9FCQqwq2gOC8i0dvtOfc4c7C5sjsOBzj4u1ndUMpYQvDn6iLFGhU4
Message-ID: <CALOAHbBNMM-pZD+8+7SQ7EyWZCbYSFHpvBzjewDYh_ZWEmz46w@mail.gmail.com>
Subject: Re: [QUESTION] xfs, iomap: Handle writeback errors to prevent silent
 data corruption
To: Dave Chinner <david@fromorbit.com>
Cc: Christian Brauner <brauner@kernel.org>, djwong@kernel.org, cem@kernel.org, 
	linux-xfs@vger.kernel.org, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 12:36=E2=80=AFPM Dave Chinner <david@fromorbit.com>=
 wrote:
>
> On Thu, May 29, 2025 at 10:50:01AM +0800, Yafang Shao wrote:
> > Hello,
> >
> > Recently, we encountered data loss when using XFS on an HDD with bad
> > blocks. After investigation, we determined that the issue was related
> > to writeback errors. The details are as follows:
> >
> > 1. Process-A writes data to a file using buffered I/O and completes
> > without errors.
> > 2. However, during the writeback of the dirtied pagecache pages, an
> > I/O error occurs, causing the data to fail to reach the disk.
> > 3. Later, the pagecache pages may be reclaimed due to memory pressure,
> > since they are already clean pages.
> > 4. When Process-B reads the same file, it retrieves zeroed data from
> > the bad blocks, as the original data was never successfully written
> > (IOMAP_UNWRITTEN).
> >
> > We reviewed the related discussion [0] and confirmed that this is a
> > known writeback error issue. While using fsync() after buffered
> > write() could mitigate the problem, this approach is impractical for
> > our services.
>
> Really, that's terrible application design.  If you aren't checking
> that data has been written successfully, then you get to keep all
> the broken and/or missing data bits to yourself.

It=E2=80=99s difficult to justify this.

>
> However, with that said, some history.
>
> XFS used to keep pages that had IO errors on writeback dirty so they
> would be retried at a later time and couldn't be reclaimed from
> memory until they were written. This was historical behaviour from
> Irix and designed to handle SAN environments where multipath
> fail-over could take several minutes.
>
> In these situations writeback could fail for several attempts before
> the storage timed out and came back online. Then the next write
> retry would succeed, and everything would be good. Linux never gave
> us a specific IO error for this case, so we just had to retry on EIO
> and hope that the storage came back eventually.
>
> This is different to traditional Linux writeback behaviour, which is
> what is implemented now via iomap. There are good reasons for this
> model:
>
> - a filesystem with a dirty page that can't be written and cleaned
>   cannot be unmounted.
>
> - having large chunks of memory that cannot be cleaned and
>   reclaimed has adverse impact on system performance
>
> - the system can potentially hang if the page cache is dirtied
>   beyond write throttling thresholds and then the device is yanked.
>   Now none of the dirty memory can be cleaned, and all new writes
>   are throttled....

I previously considered whether we could avoid clearing PG_writeback
for these pages. To handle unwritten pagecache pages more safely, we
could maintain their PG_writeback status and introduce a new
PG_write_error flag. This would explicitly mark pages that failed disk
writes, allowing the reclaim mechanism to skip them and avoid
potential deadlocks.

>
> > Instead, we propose introducing configurable options to notify users
> > of writeback errors immediately and prevent further operations on
> > affected files or disks. Possible solutions include:
> >
> > - Option A: Immediately shut down the filesystem upon writeback errors.
> > - Option B: Mark the affected file as inaccessible if a writeback error=
 occurs.
>
> Go look at /sys/fs/xfs/<dev>/error/metadata/... and configurable
> error handling behaviour implemented through this interface.
>
> Essential, XFS metadata behaves as "retry writes forever and hang on
> unmount until write succeeds" by default. i.e. similar to the old
> data IO error behaviour. The "hang on unmount" behaviour can be
> turned off by /sys/fs/xfs/<dev>/error/fail_at_unmount, and we can
> configured different failure handling policies for different types
> of IO error. e.g. fail-fast on -ENODEV (e.g. device was unplugged
> and is never coming back so shut the filesystem down),
> retry-for-while on -ENOSPC (e.g. dm-thinp pool has run out of space,
> so give some time for the pool to be expanded before shutting down)
> and retry-once on -EIO (to avoid random spurious hardware failures
> from shutting down the fs) and everything else uses the configured
> default behaviour....

Thank you for your clear guidance and detailed explanation.

>
> There's also good reason the sysfs error heirarchy is structured the
> way it is - it leaves open the option for expanding the error
> handling policies to different IO types (i.e. data and metadata). It
> even allows different policies for different types of data devices
> (e.g. RT vs data device policies).
>
> So, got look at how the error configuration code in XFS is handled,
> consider extending that to /sys/fs/xfs/<dev>/error/data/.... to
> allow different error handling policies for different types of
> data writeback IO errors.

That aligns perfectly with our expectations.

>
> Then you'll need to implement those policies through the XFS and
> iomap IO paths...

I will analyze how to implement this effectively.

--=20
Regards
Yafang

