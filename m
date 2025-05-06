Return-Path: <linux-fsdevel+bounces-48302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F0AAAD103
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 00:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6A233B181D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 22:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D5D21A44D;
	Tue,  6 May 2025 22:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="gQ9gGkSi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8C021579F
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 May 2025 22:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746570683; cv=none; b=H9Zya9zpenjhIc8iDHXWbK3482kCstKbWKcIqrtgtyTaFHFWKRQS3itEfRK97QABxT9zLWnEdmDfxpBircHbyz+HkHLcpVTEixWWLfMy/oIGaxKOewuUoIshdWK9q5dPq0gaMnvnYANIfPACwj0PZr4+OZ3vLSPxTOzV8E+RayU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746570683; c=relaxed/simple;
	bh=X87u2AFw0RBjpOF81knenxpiGMcsB+hy1wEw/AZFCgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okbc0EJzjS/01ApKlpWEa3xfzWgB07oKDi7tlzDgJHFvi9pk5JL1XCFZ8yBsmPiVuwBA6G/0oCrrNFckBi0mqzBfBjZTrnIybXz+CetRnvh0Jmy1/fsVwV+RnwJ0zB3NcABpT1+PasIi4UhFU7cUtj3PnRr+ePjgJQMJDNT8mFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=gQ9gGkSi; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7369ce5d323so5636508b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 May 2025 15:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1746570680; x=1747175480; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w/UMMj2Em65CblfZXEVKRUG2M/JosI/quCwMUnTdV2A=;
        b=gQ9gGkSi0rhN0V5ts5D93hoC2pbE8UGmiCJCdONlQo1axqgco9tXgpkEK+8vZtK9WQ
         U0L5UdIm0KhEdhY5gGeaqF484xluqAIWED7rI/Ieneeh+kUgTMJe9Pd7v+fDAPzzRdPS
         GhiprMBZEtb4XDDHAvviJRmhxC4rxa1OytR6A15QXn3D8JWI1ZK8IZFwWkUzt59mfQwP
         eyuuUiDVOAB7Okskpqx6egG9/8kytWzqp5RBIrmGO6D2T6n4SZQLPQgRIorq/r6cJf7r
         3nDWi/Tumr/RdZ6+goNOEXZoveJ6yKRm7qc5BLOa3i911T7gKn6RpPpUz1iUb7B3ozLM
         9Wfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746570680; x=1747175480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/UMMj2Em65CblfZXEVKRUG2M/JosI/quCwMUnTdV2A=;
        b=sSE+LRq6KtXuEZ2+Bq2RwSNwBXGZkmG8p1ubeL5lNoD1y28JBVIZqDeAIa/rL1dWdK
         iE/3XbhWTGt843y6SLBWlH3JzmOlK2+KR5YE6XV4tfadN/7unt9jWPJv04kxA6AfLnYj
         9ieWDXuVM2XmGbZAUiljs/8rwDQJezwJMMiC7uMZ2POoZHRhrH7UCf+Gi4Jydiffu1Bd
         3bKYmWC1a/lti2SaJ51j7tV7TcSAZAJGfb2QbLPI4iyFs0x0izubPAHLt73bwbbhi/oD
         gukkKxQRygYqOQIZjGRBqNqR2QkEjG8PbU7SYob90/M8n/j/WLmwq+qbq37xAvsHttzW
         RVCw==
X-Gm-Message-State: AOJu0Yzn+Ci8qbcjXQ8ikeYwB7xjo4X5HmykGg23sAyoMBL2+2ZgIdm5
	2msDYEaNsr0xKL463kF0Ko22znU30r32VtdEGW18HCFDrXfm6pnwDTjR+CH4L88AB3biEcSueKK
	W
X-Gm-Gg: ASbGnctTTedL4w+8wCoyaT8/+qex4uqBPjOkKTXprnGyRNW1E5mJjtD+2ENS6BbpAYX
	hdRZVLP8+GHIO/hZwQzJlYymkpzW/cvozZLZv3mRo7fZMELGSZNTp2RKdEUBezoys8lS0Bvr+cX
	KfGYh4+Y7DA81JX+Uo3AlujDE3G+DV8ZbLbyY9a+P2nBlR4BhsK7fKOGkhDG/iCyFEkqyhMM1p7
	C7YgIxsGCishGlO8sj66gg17oUflJAcUX3otlrWA6xaVQ3qBAdvPn1HRAsWTv3Mzn6ClSu08dVO
	dQNwbaocXBm6FySep1VB12KulqMt4iP6pifMmUnR0QobhuggYRoa9tX3Oyy4XZ80jvCtUCNZqwr
	LAKdCN1baZ+zIHQ==
X-Google-Smtp-Source: AGHT+IFKV1zVvycjJmPL2bxLVcFHfxLB+9k14rK3DqApNa5bCEuer0R2fvn+6NVRCbA+EZAO53O5sg==
X-Received: by 2002:a05:6a00:f99:b0:740:9c06:1cff with SMTP id d2e1a72fcca58-7409cfdc557mr1028579b3a.23.1746570680440;
        Tue, 06 May 2025 15:31:20 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74059020dd4sm9571729b3a.117.2025.05.06.15.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 15:31:19 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uCQon-00000000HNy-0TjW;
	Wed, 07 May 2025 08:31:17 +1000
Date: Wed, 7 May 2025 08:31:17 +1000
From: Dave Chinner <david@fromorbit.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Jens Axboe <axboe@kernel.dk>, Chris Mason <clm@meta.com>,
	Anna Schumaker <anna@kernel.org>
Subject: Re: performance r nfsd with RWF_DONTCACHE and larger wsizes
Message-ID: <aBqNtfPwFBvQCgeT@dread.disaster.area>
References: <370dd4ae06d44f852342b7ee2b969fc544bd1213.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <370dd4ae06d44f852342b7ee2b969fc544bd1213.camel@kernel.org>

On Tue, May 06, 2025 at 01:40:35PM -0400, Jeff Layton wrote:
> FYI I decided to try and get some numbers with Mike's RWF_DONTCACHE
> patches for nfsd [1]. Those add a module param that make all reads and
> writes use RWF_DONTCACHE.
> 
> I had one host that was running knfsd with an XFS export, and a second
> that was acting as NFS client. Both machines have tons of memory, so
> pagecache utilization is irrelevant for this test.

Does RWF_DONTCACHE result in server side STABLE write requests from
the NFS client, or are they still unstable and require a post-write
completion COMMIT operation from the client to trigger server side
writeback before the client can discard the page cache?

> I tested sequential writes using the fio-seq_write.fio test, both with
> and without the module param enabled.
> 
> These numbers are from one run each, but they were pretty stable over
> several runs:
> 
> # fio /usr/share/doc/fio/examples/fio-seq-write.fio

$ cat /usr/share/doc/fio/examples/fio-seq-write.fio
cat: /usr/share/doc/fio/examples/fio-seq-write.fio: No such file or directory
$

What are the fio control parameters of the IO you are doing? (e.g.
is this single threaded IO, does it use the psync, libaio or iouring
engine, etc)

> wsize=1M:
> 
> Normal:      WRITE: bw=1034MiB/s (1084MB/s), 1034MiB/s-1034MiB/s (1084MB/s-1084MB/s), io=910GiB (977GB), run=901326-901326msec
> DONTCACHE:   WRITE: bw=649MiB/s (681MB/s), 649MiB/s-649MiB/s (681MB/s-681MB/s), io=571GiB (613GB), run=900001-900001msec
> 
> DONTCACHE with a 1M wsize vs. recent (v6.14-ish) knfsd was about 30%
> slower. Memory consumption was down, but these boxes have oodles of
> memory, so I didn't notice much change there.

So what is the IO pattern that the NFSD is sending to the underlying
XFS filesystem?

Is it sending 1M RWF_DONTCACHE buffered IOs to XFS as well (i.e. one
buffered write IO per NFS client write request), or is DONTCACHE
only being used on the NFS client side?

> I wonder if we need some heuristic that makes generic_write_sync() only
> kick off writeback immediately if the whole folio is dirty so we have
> more time to gather writes before kicking off writeback?

You're doing aligned 1MB IOs - there should be no partially dirty
large folios in either the client or the server page caches.

That said, this is part of the reason I asked about both whether the
client side write is STABLE and  whether RWF_DONTCACHE on
the server side. i.e. using either of those will trigger writeback
on the serer side immediately; in the case of the former it will
also complete before returning to the client and not require a
subsequent COMMIT RPC to wait for server side IO completion...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

