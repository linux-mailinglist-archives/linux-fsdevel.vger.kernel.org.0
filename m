Return-Path: <linux-fsdevel+bounces-23172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5E6927F24
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 01:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98C47284FCA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 23:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C461714431F;
	Thu,  4 Jul 2024 23:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="DrwVqXOp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B529F143867
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jul 2024 23:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720135562; cv=none; b=pYK7M2jrXluuCN0rM3ZLDLWbNZj4DVgh1P3KJGw7XdS3by7Me1eIdbfJHaMKxRPO0dhcKzg6wGk6dJ+sBTjGKs68acGRYpNKZK8aumzhdhb40Uzr5d7oUalHQPkX123TidckWTtU+164jaE3Oa9T23GN9ifow9DNpGnQMfaM20g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720135562; c=relaxed/simple;
	bh=sc+sfFgFnak6XBFb/1P4xCvzW/aJEMSFoZYu0lXlmYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKPp9edl/gx3iLFDFEEL/uPNY8mcrFFgkPmlqRo1HhY/aHlJHR3IY1fXcYcoMpGGZN+/SmuAv8IFLNK1Zqn7VOvCg2qdc2VNJHedVHLciZ0eClm7Dy9Uqb/K7tYjskqGwVp/Ehbq/0C4ZQ4Z51e/NrgtKvmCi+zpuNjabZLOLeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=DrwVqXOp; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70af22a9c19so763078b3a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jul 2024 16:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1720135560; x=1720740360; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YQuUbXTeCATfOJq+6G5otAsd//IBi6KlQnyDYRgmZHM=;
        b=DrwVqXOpOsXoqp9WWe/R4hGUMiwkQu2sQHtAlaZMZDntUqkqsxCmrWwIr4lqeuoEum
         eX1sErAq2Pd6m7BHBiPy+oV7BG2TvjiP903ETDJRvhRpctGrYOTItg78axfYDISpAIUB
         sEZS+Es68a3bD4IrISM4icwPDczDaL4rXHf3AnCYdMPY9O9ODVq53PtTgjODBH1v49tE
         cyqhR73s7SMJ1sClRbo3MHrVE+bUE/6xtWrlje0fHsCNUzeAO1xaFnI8f0K4c+DDn2QR
         QzwvD1AR0XZ8fj5AxaHAVpoi627yIzDqLJRuSu+yCrBhr6VwvAoIEzFIOTI2jkJZPRQ0
         nx3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720135560; x=1720740360;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YQuUbXTeCATfOJq+6G5otAsd//IBi6KlQnyDYRgmZHM=;
        b=n8KMClhDdkYOd5A0nJQmslpm+HpxjgzpkKrZHElI8gaAztBWn6qIxDwlXMbnjpR1Ia
         dYpwnt/2IHpoqdiekMRVz4/9xUJUJlWh8VNs45g7cMXHuRdg9xdO8cMQDJoaTT+DZSGk
         KPHxnMnxvI9FpGNACwLC/ssHpUPnjRSL+e9rouGXpvLUcnjRm8X6t6ul8iqWC1dpK2LZ
         LTCFApjPfmEh/Q15olm63ILM0/v/ltwrhWrvUgxtS1boQfqWo3rURkBqcrX2btsRC7JX
         BYKmu4UMTd5wjqtSuW5kYLHAnd9peBlFiLGN9TA6khbhQrhu63/aZWjncBT4pD+WAgIZ
         I4FA==
X-Forwarded-Encrypted: i=1; AJvYcCWuueYxEjSpebGce45pNtsSlrWX6qNMyYYpfC3o3xWw+JWSJEBTAOqdqX8Sv2/dhOHSx3+vQTLQZLVEjzTE7QtxX9GI+xGMF+aPgirD4g==
X-Gm-Message-State: AOJu0YxtWxzke1XcJ+ikjJLtem9hdpGOftx6ubjsyBifblhDGFdmMFtO
	dQlr4CXLcwcMvTe397rczhGiZ1cWduJoMmfeP1pudrghLGptJ+qtBKs2z++A/Xk=
X-Google-Smtp-Source: AGHT+IF9r/vf73P7S27Y6SGExS0fKX8f/udf+l46eEqaZc1p7k6ezMi050Ad+JapfLIDxV7oC1fgrg==
X-Received: by 2002:a05:6a00:2e2a:b0:704:2696:d08e with SMTP id d2e1a72fcca58-70b0094e317mr3283522b3a.13.1720135559882;
        Thu, 04 Jul 2024 16:25:59 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080256c9dcsm12742444b3a.74.2024.07.04.16.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 16:25:59 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sPVps-004N19-2J;
	Fri, 05 Jul 2024 09:25:56 +1000
Date: Fri, 5 Jul 2024 09:25:56 +1000
From: Dave Chinner <david@fromorbit.com>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Neil Brown <neilb@suse.de>, Mike Snitzer <snitzer@kernel.org>,
	Jeff Layton <jlayton@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Christoph Hellwig <hch@infradead.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: Security issue in NFS localio
Message-ID: <ZocvhIoQfzzhp+mh@dread.disaster.area>
References: <172004548435.16071.5145237815071160040@noble.neil.brown.name>
 <23DE2D13-1E1D-4EFE-9348-5B9055B30009@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23DE2D13-1E1D-4EFE-9348-5B9055B30009@oracle.com>

On Thu, Jul 04, 2024 at 07:00:23PM +0000, Chuck Lever III wrote:
> 
> 
> > On Jul 3, 2024, at 6:24 PM, NeilBrown <neilb@suse.de> wrote:
> > 
> > 
> > I've been pondering security questions with localio - particularly
> > wondering what questions I need to ask.  I've found three focal points
> > which overlap but help me organise my thoughts:
> > 1- the LOCALIO RPC protocol
> > 2- the 'auth_domain' that nfsd uses to authorise access
> > 3- the credential that is used to access the file
> > 
> > 1/ It occurs to me that I could find out the UUID reported by a given
> > local server (just ask it over the RPC connection), find out the
> > filehandle for some file that I don't have write access to (not too
> > hard), and create a private NFS server (hacking nfs-ganasha?) which
> > reports the same uuid and reports that I have access to a file with
> > that filehandle.  If I then mount from that server inside a private
> > container on the same host that is running the local server, I would get
> > localio access to the target file.

This seems amazingly complex for something that is actually really
simple.  Keep in mind that I am speaking from having direct
experience with developing and maintaining NFS client IO bypass
infrastructure from when I worked at SGI as an NFS engineer.

So, let's look at the Irix NFS client/server and the "Bulk Data
Service" protocol extensions that SGI wrote for NFSv3 back in the
mid 1990s.  Here's an overview from the 1996 product documentation
"Getting Started with BDSpro":

https://irix7.com/techpubs/007-3274-001.pdf

At least read chapter 1 so you grok the fundamentals of how the IO
bypass worked. It should look familiar, because it isn't very
different to how NFS over RDMA or client side IO for pNFS works.

Essentially, The NFS client transparently sent all the data IO (read
and write) over a separate communications channel for any IO that
met the size and alignment constraints. This was effectively a
"remote-IO" bypass that streamed data rather than packetised it
(NFS_READ/NFS_WRITE is packetised data with RTT latency issues).
By getting rid of the round trip latency penalty, data could be
sent/recieved at full network throughput rates.

[ As an aside, the BDS side channel was also the mechanism that used
by SGI for NFS over RDMA with custom full stack network offload
hardware back in the mid 1990s. NFS w/ BDS ran at about 800MB/s on
those networks on machines with 200MHz CPUs (think MIPS r10k). ]

The client side userspace has no idea this low level protocol
hijacking occurs, and it doesn't need to because all it changes
is the read/write IO speed. The NFS protocol is still used for all
authorisation, access checks, metadata operations, etc, and all that
changes is how NFS_READ and NFS_WRITE operations are performed.

The local-io stuff is no different - we're just using a different
client side IO path in kernel. We don't need a new protocol, nor do
we need userspace to be involved *at all*.  The kernel NFS client
can easily discover that it is on the same host as the server. The
server already does this "client is on the same host", so both will
then know they can *transparently* enable the localio bypass without
involving userspace at all.

The NFS protocol still provides all the auth, creds, etc to allow
the NFS client read and write access to the file. The NFS server
provides the client with a filehandle build by the underlying
filesystem for the file the NFS client has been permission to
access.

The local filesystem will accept that filehandle from any kernel
side context via the export ops for that filesystem. This provides
a mechanism for the NFS client to convert that to a dentry
and so open the file directly from the file handle. This is what the
server already does, so it should be able to share the filehandle
decode and open code from the server, maybe even just reach into the
server export table directly....

IOWs, we don't need to care about whether the mount is visible to
the NFS client - the filesystem *export* is visible to the *kernel*
and the export ops allow unfettered filehandle decoding. Containers
are irrelevant - the server has granted access to the file, and so
the NFS client has effective permissions to resolve the filehandle
directly..

Fundamentally, this is the same permission and access model that
pNFS is built on. Hence I don't understand why this local-io bypass
needs something completely new and seemingly very complex...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

