Return-Path: <linux-fsdevel+bounces-39199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4552EA1152C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 00:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 978E43A7931
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 23:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D54214A71;
	Tue, 14 Jan 2025 23:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="ercJg6pM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0F720CCF5
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 23:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736896502; cv=none; b=VSYiqnO8HnqVbCFx7PGwoDWGFB0ZZPj5Oq4a05B9AhxcUH1DD1cAiEDe+mKFEWANWbqn26caNrsDcRdW69WdWC+NwkAI/ztqRGsHXZeSNUcUKpWfGfCKU//u81E+EkaJVi9xJDzR9OfAQy2FSTRrdcivmNFik2zTeb5K7KxLsnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736896502; c=relaxed/simple;
	bh=Ku6IWsTkFsv6GMoIpnDvn94d1zg54qScIiut5gwfQng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQE+fHjmxFmEaDiR5jNYNoch+t1kMLS+I4bv4xyTHVJD/5ytsgU2GU8uQNQHOQrad08ehkjVqa8plhRDMZqtb4lNVeIGgFNasjBOpBduyfFnG6DFjsrceAvGE1Q6TWo5Sy+M1nDfQ+nuhLivTCYMKkMsGYLJaGgYroPgdjQkBZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=ercJg6pM; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2167141dfa1so4853885ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 15:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1736896500; x=1737501300; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EeZxW1zCzlr+JrfmRQmFydF0o1xRvBF9Y2l5yWErmxw=;
        b=ercJg6pMVxbdKdR+0bXWok8JN/GhbGpY1VDreApfIFwJRPozSWW46ZuQVa8+GEDebQ
         YBC6faQah+nJfuxqpA8OqnEibnPqaV86bxe9Z0brZoAEbMSTnwyjb9AjL9rC8xX9b0VB
         vWxWKrS9Sa6TgdRCqZTRLB2Gj2JIeO6JqvJgDceiOpz9/dkVcnllL1a1N1xC154b9fOe
         1d+pI4q7qi3mMY4hWypLl4hhCzRSx67L3P7jlVQulWfgZEsEFLhkWcLZnjyTpNT8vwZ7
         plqe9RCCCGKFLZbDCzDYXXfKedywPUxI7cve2Xm026rYe51dGg3LkxZ19Cf9yNPSeEzB
         yKvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736896500; x=1737501300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EeZxW1zCzlr+JrfmRQmFydF0o1xRvBF9Y2l5yWErmxw=;
        b=DVroLKnZHjEMNXBW+jnjXr3U8mBHWWnorgoR95BVu59xIiYmozb+uZ9DLqLPtoiXP9
         J5aTkFJQgfUdTADG3zY7H+3itEEDH0m1qa77+576ThWwRW0N94A0veNCNVQvVElT+pOZ
         m3dgBatjJXCLvuqmnEzALZMV6i+Vv5SbVJN9WiGuydEqaaccVa/CiJVIrYMnqwC3Eq6f
         cenmsEDyP5+S3RALFr0g2I+va3bSAhx79FtsvKFj6KbK3PdYizMz4R/Xvj6/ZC2OsiHX
         R+Oly0kx5lxXT+BASoHfUF/hlp4MPidv4FLWCYQm7+Fkf2KDeXUStYkIFFL9f5dep7aF
         lvaw==
X-Forwarded-Encrypted: i=1; AJvYcCWYNcPS2xOrGqQ73qVK23HUcwne+4FY016BN+Yv6iD7gEqGFgbduxukA7MvAzZHRXPRq0nTpmFN/eH23x/B@vger.kernel.org
X-Gm-Message-State: AOJu0YyK43DTP47tOPQsiPFoWu8WeevOYBQxB1aUUt13ISye34IAsjNt
	jzYjJ7KLHvw6Mni/mvwdq/u5gq31pirYXOmPBDoaJf8KlWNMSLx9KsggCIrcztHoHMJnBFPSjBU
	N
X-Gm-Gg: ASbGncvxhZc/354smGGiwQYQyL2ydfetAH4uxo4ouVDxvraahR2EgRzCLPdk99rb4Kx
	bwM+8YrBzgEMU0NVyUZ2O0309xp3WlRgXYx+4tkX42P5VcFDu0sN5zCGa1R8kk4/5Kj+ltmw47V
	cdQNU9MIxyGOmvIo0nXZH7Fy2dEDcZnYk41GvMI5r7XOxFHAODL6YlR0QhegmffHSukZb8PHU/+
	gs3G7Ot9kF3t/l/zY7H4BiPPCFAZSIUAUMcY2dyoYHvPVWwSmy3uRKzh+aZUuvrzG9tmYpnoTCT
	q63kBf6C5ndK0uofeZARrDdCiqScRUjW
X-Google-Smtp-Source: AGHT+IGPe701b0TiJbUgOXs5XC6XzeWPSLFYvyoyE234qjSY/ozCb65VqSGjAJ1Qx7pa4gIqb0AXpQ==
X-Received: by 2002:a17:902:ecc1:b0:21a:874f:1de1 with SMTP id d9443c01a7336-21bf0ce086emr10791965ad.21.1736896499802;
        Tue, 14 Jan 2025 15:14:59 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f10f839sm71626055ad.15.2025.01.14.15.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 15:14:59 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tXq7c-00000005wYY-26ph;
	Wed, 15 Jan 2025 10:14:56 +1100
Date: Wed, 15 Jan 2025 10:14:56 +1100
From: Dave Chinner <david@fromorbit.com>
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] Implementing the NFS v4.2 WRITE_SAME
 operation: VFS or NFS ioctl() ?
Message-ID: <Z4bv8FkvCn9zwgH0@dread.disaster.area>
References: <f9ade3f0-6bfc-45da-a796-c22ceaeb4722@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9ade3f0-6bfc-45da-a796-c22ceaeb4722@oracle.com>

[Please word wrap email text at 68-72 columns]

Anna, I think we need to consider how to integrate this
functionality across then entire storage stack, not just for NFS
client/server optimisation.  My comments are made with this in mind.

On Tue, Jan 14, 2025 at 04:38:03PM -0500, Anna Schumaker wrote:
> I've seen a few requests for implementing the NFS v4.2 WRITE_SAME
> [1] operation over the last few months [2][3] to accelerate
> writing patterns of data on the server, so it's been in the back
> of my mind for a future project. I'll need to write some code
> somewhere so NFS & NFSD can handle this request. I could keep any
> implementation internal to NFS / NFSD, but I'd like to find out if
> local filesystems would find this sort of feature useful and if I
> should put it in the VFS instead.

How closely does this match to the block device WRITE_SAME
(SCSI/NVMe) commands? I note there is a reference to this in the
RFC, but there are no details given.

i.e. is this NFS request something we can pass straight through to
the server side storage hardware if it supports hardware WRITE_SAME
commands, or do they have incompatible semantics?

If the two are compatible, then I think we really want server side
hardware offload to be possible. That requires the filesystem to
allocate/map the physical storage and then call into the block layer
to either offload it to the hardware or emulate it in software
(similar to how blkdev_issue_zeroout() works).

> I was thinking I could keep it simple, and model a function call
> based on write(3) / pwrite(3) to write some pattern N times
> starting at either the file's current offset or at a user-provide
> offset. Something like:
>
> write_pattern(int filedes, const void *pattern, size_t nbytes, size_t count);
> pwrite_pattern(int filedes, const void *pattern, size_t nbytes, size_t count, offset_t offset);

Apart from noting that pwritev2(RWF_ENCODED) would have been able to
support this, I'll let other people decide what the best
user/syscall API will be for this.

> I could then construct a WRITE_SAME call in the NFS client using
> this information. This seems "good enough" to me for what people
> have asked for, at least as a client-side interface. It wouldn't
> really help the server, which would still need to do several
> writes in a loop to be spec-compliant with writing the pattern to
> an offset inside the "application data block" [4] structure.

Right, so we need both NFS client side and server side local fs
support for the WRITE_SAME operation.

That implies we should implement it at the VFS as a file method.
i.e. ->write_same() at a similar layer to ->write_iter().

If we do that, then both the NFS client and the NFS server can use
the same VFS interface, and applications can use WRITE_SAME on both
NFS and local filesystems directly...

> But maybe I'm simplifying this too much, and others would find the
> additional application data block fields useful? Or should I keep
> it all inside NFS, and call it with an ioctl instead of putting it
> into the VFS?

I think a file method for VFS implementation is the right way to do
this because it allows both client side server offload and server
side hardware offload through the local filesystem. It also provides
a simple way to check if the filesystem supports the functionality
or not...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

