Return-Path: <linux-fsdevel+bounces-39095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFF0A0C5B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 00:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C382D18881CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 23:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB241FA168;
	Mon, 13 Jan 2025 23:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="OEi9RZWe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E2C1F8EF2
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2025 23:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736811072; cv=none; b=UEFKXqMm+ytoVZYhjK+9ZZ1tTfRflc+/yFh4MFGIat5sLtRsKNlJfVsimw16NoxqMHCzJAmhY8N8SWtQ+6A8oaOnBv90Lho86Fd+4Mc+GbwNCP6idxw0aPIoJUkyGtz2iazlkaOqFiXSCNFqx3t5ZFfe+CwgAsvJNQ0dq1CiY60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736811072; c=relaxed/simple;
	bh=RQNEgMVZ3jdjWGkwteTw7G3R79xb9EZG+o28jVwOSGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFqE9kkwBeEB0uADEtymYtCaTzkylxi6mxgY3/vUHPw/VBjHztrpJgt3SAhTH4JgGj2FweWbhFQkYyxVOzPzEpRM5zSH5ZHrKoQGMWA2/VNlDKmF/DQJTD1XBngQrYcmukeA3sWDW3A3JodzEaKdJmvbI1bKRIBt28CqVDe4i0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=OEi9RZWe; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ef72924e53so8150133a91.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2025 15:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1736811069; x=1737415869; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gQgs4ZsUfHeQxidvqeNv50mofvCHobU0pmsmPe1lRIM=;
        b=OEi9RZWeufLNLEjdc1mnip7KMy6bgDZVhnOKxUFhwSY0tzxQROMLc0PQvsIOaS0e8t
         5DyTvtcdvblczf03To2328Xuf0WDJ83sxHIRCKG1sRrCyqvaxFGZZb87+zn5vBpbzheS
         RHt4p8mxxCTGiis6X0GtgB1WoECd5pUKL4TUk33SKQMUzpiPrlSYdIvlYeyB/EM5vGoZ
         ZxILcmdYO0w1qut+osWso7tecpDEtsHXyH1k7jYOz6hXEXc0O2aPLimOmdaKKNVyk9wT
         UDf233T2u5KQA/64c62STWqrY3/XQ5EB9apOB5gMKlQAA9n34VtlH0OBzOZlagqcjtCA
         qR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736811069; x=1737415869;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gQgs4ZsUfHeQxidvqeNv50mofvCHobU0pmsmPe1lRIM=;
        b=DxbRJ57gxrW2DgD6Qa715bu8i1hmkyxvvQ0bNltFGeqGhuZYvEfaV2GP2ROPsAGTfd
         RmPF8Tb2PI5qx30EkNa6rVTP1q645d/QRteIfymKm56nI2HYalbw4Q0uGOzdA6JwGqZf
         XPX9bPwudlwsy8vL9EO8DYAnSGGkUP74iCAXtB3HgdxRhGyL/wfc8EkJf3GfY3HMTJUn
         C+OZCwgSLUDKOtX9shfg9alMGHMSSi38R49zoTgS+kNTSzCWh4E2p9IsOs2mCgQEum23
         4gcN86xmvEWOTHRv3siCK7wZM1zYBrF/VC3YLyu8+sA1JELuW57vPCiYEq6XtnXd4L/e
         /TZg==
X-Forwarded-Encrypted: i=1; AJvYcCVHu6C7ZhCknFGMH/dcXQAVbwWuUHSkaDjCSPXuS2ouYo7F3WIUY1rhIXiGV12mnZaB4VLN3jY+fOdIK1UU@vger.kernel.org
X-Gm-Message-State: AOJu0YxplpCblCOvsA/WkOtW1sN59MVtbqsfzW4IZS3dN1Otu9mEOR2c
	nbYcuk6Yt/wwtcBatipPDaVfBK2noDSjh5RfZIFZbCeuYHg6NNqXeQFbLC6QCVQ=
X-Gm-Gg: ASbGncsr+mzvBJxeIZ2yCGBMM3aC0Umd85DAfoCgOmH0ElJWylY469jorQaApQAzTKd
	pYWj1ou0XPSPAXchxliGB2IUlV70A20cc2dT8CMRWuwV+JsCMp8A8t05D8YF8tSFrwfBnQfMa/W
	201w+HwaA10wDncfAOVxmgyO0912KEF5vHK+abgLYRMytxHQzHe8Nm433mmXg3bb0o38zFhNDYf
	0Ux1cWOJCu8wSxSIaSEqnlyCy+Rq0VOvqTYRUNM+F/NPOxDLJG/9LcvTK5X5UK1qztYClCJZ/EC
	7rclZPLoAXgl1IzkQux/BA==
X-Google-Smtp-Source: AGHT+IGw+hgC5CWVetAVnvDjsQX1qXGp/YClLIwI/abXQJP1xhhEPAXtUQSwAQytUR5eJauEsP8/xw==
X-Received: by 2002:a17:90b:2544:b0:2ee:c9b6:c267 with SMTP id 98e67ed59e1d1-2f548eaea9emr34600226a91.9.1736811069118;
        Mon, 13 Jan 2025 15:31:09 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f12fcfbsm58257755ad.82.2025.01.13.15.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 15:31:08 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tXTth-00000005XEM-3QwX;
	Tue, 14 Jan 2025 10:31:05 +1100
Date: Tue, 14 Jan 2025 10:31:05 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Artem S. Tashkinov" <aros@gmx.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Spooling large metadata updates / Proposal for a new API/feature
 in the Linux Kernel (VFS/Filesystems):
Message-ID: <Z4WiOUZizUok2VAs@dread.disaster.area>
References: <ba4f3df5-027b-405e-8e6e-a3630f7eef93@gmx.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba4f3df5-027b-405e-8e6e-a3630f7eef93@gmx.com>

On Sat, Jan 11, 2025 at 09:17:49AM +0000, Artem S. Tashkinov wrote:
> Hello,
> 
> I had this idea on 2021-11-07, then I thought it was wrong/stupid, now
> I've asked AI and it said it was actually not bad,

Which shows just how poor "AI" is at analysing complex systems.

> so I'm bringing it
> forward now:
> 
> Imagine the following scenarios:
> 
>  * You need to delete tens of thousands of files.
>  * You need to change the permissions, ownership, or security context
> (chmod, chown, chcon) for tens of thousands of files.
>  * You need to update timestamps for tens of thousands of files.
> 
> All these operations are currently relatively slow because they are
> executed sequentially, generating significant I/O overhead.

Yes, they are executed sequentially by the -application- not the
filesystem. i.e. the performance limiter is application concurrency,
not the filesystem.

> What if these operations could be spooled and performed as a single
> transaction?

You get nothing extra - they'd still executed "sequentially" within
the transaction. Operational concurrency is required to speed up
these operations, and we have io_uring and/or threads for that...

> By bundling metadata updates into one atomic operation,
> such tasks could become near-instant or significantly faster.

No. The filesystem still has to do exactly the same amount of work
to modify thousands of files. Transactional atomicity has nothing to
do with the cost of modification of an otherwise unrelated set of
filesystem objects...

The overhead of 'rm -rf' could be optimised, but the filesystem
would still have to do the directory traversal first to find all the
inodes that have to be unlinked/rmdir'd and process them before the
parent directory is freed. i.e. we can make it *look fast*, but it
still has largely the same cost in terms of IO, CPU and memory
overhead.

And, of course, operations like sync() would have to block on an
offloaded 'rm -rf' operation. That is likely to cause people
more unexpected issues than userspace implementing a concurrent 'rm
-rf' based on sub-dir concurrency....

> This would
> also reduce the number of writes, leading to less wear and tear on
> storage devices.

Not for a typical journalling filesystem. They aggregate and
journal delta changes efficiently, then do batched writeback of the
modified metadata efficiently, eliding all writes possible. 

> Does this idea make sense? If it already exists, or if there’s a reason
> it wouldn’t work, please let me know.

Filesystems can already do operations concurrently. As long as
concurrency for directory traversal based operations is done on a
per-directory level, they scale out to the inherent concurrency the
filesytem can provide.

In the case of XFS, we can scale out to around 600-700,000 file
creates/s, about 1 million chmod/chown/chcon/futimes modifications
per second and about 500,000 unlinks per second. With some VFS
scalablility mods, we can get up around the 1 million file creates/s
mark....

IOWs, if application are having problems with sequential filesystem
operations being slow, the problem is generally application level
algorithms and concurrency and not the filesystem implementations or
syscall interfaces.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

