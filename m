Return-Path: <linux-fsdevel+bounces-48434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CA0AAF088
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 03:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6D131C22EFE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 01:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BEB18DB01;
	Thu,  8 May 2025 01:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="wCEc8g/h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEEC1E502
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 May 2025 01:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746666809; cv=none; b=X9sKabRqEaW1Ft68g7FgdFk/SNqlPJ96ToeTonqobdyk6BqhRiW1AuMF0Y1R18j/A6+th1FTra5f/NDht4S1Lcg7rsu4Q0mF7wwi+7UMAq8b7glC/f4P/ZPbk6d+3OvXv5Hu9lGhjcj00/DHazqBQIp04Mw+/ViZw5nKz+F5/EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746666809; c=relaxed/simple;
	bh=BDSykI2E8bE4xhQDYdkvnvhZpciUcUNgBJ5QUMem4Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ujjRTVvHrWr6GJLFi93MAlxrFckpz3urJducLZpZa/TUdoYgF5JqNh+GNmKQy5ReuPvaCg1vSs4j+imLfZiwD0gIr73EJOJ+Vnp2cHa+U/NiD8wFKDgH7mhOcZ6GKLIdzzG9IiA5HpnQofyLVZgJhQtX36K+TQ+gjhBNs7v3wpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=wCEc8g/h; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-af50f56b862so236895a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 May 2025 18:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1746666807; x=1747271607; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sbbzzTE3KYEGvV266s4O0aBBC9K6qVrKmRZI7U4ZVBU=;
        b=wCEc8g/hQel1/CoKh/OcI/8N1+aln1pKDl2a3BZjWYMiEZlfNrPvcDs3qxeMdAzufA
         95AnVKQGA3ns9Kt1J6FY61rnNkRmLIaSG6gcn3Q/wVENLEqP0bON4eivj1AtbnqvLmXn
         aEGapj3wPgFxHblWPVVo5nSSi/efk0BnAyEHsnosZKMgZQ633X425jarrlpCPHo7dmYi
         6jIcRA/PQmM2YR5gyjtU+NyzYu4E3GXR7bi3ET5Vg13+V3vJmczU+nVfdiyBFWTvX7r4
         IvXusFrYTviFGTHkb01zzLLOTn3M9MxjXyBuTRztTVEhnEfz7/oJzoRJsZBXPfweT/nU
         iZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746666807; x=1747271607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbbzzTE3KYEGvV266s4O0aBBC9K6qVrKmRZI7U4ZVBU=;
        b=NYY35AyPoBCsjWBy+01T8dHK6yKdFm5s2xe76DKYXXlDZ4dN7ACT/tKltNccsaJvDw
         sUeJFSukTVabpsmf0J9SWgqCTTQ4XCPzZUGj9uPTMijnPC1C5tchtx4WHvAHQEOTvJis
         6sM5N896RZYsf2m9Rb2QOc0ktemsk0s2bBhGoRj0ZaPMl3iczwn9nLN44HMW20kZXf0z
         8bRI4DBrsKW0y1soDuuuqihEjATL2LdK1WRfNh4VmE8chOPzPqYkOjTP9aW8pkoHeJDW
         ND9Zi7KrksyrhgLjtlFUUgToVnKd/5fklZWqETTo5IsclBkGOWJWnsZOAHvbj8XXjK25
         Vv+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZcbsxOQZxN9KpP6JDwFUyzECe5dJ3LfP1d/tnQqA8EMzoeKXRrY5YWJmqGjCVbhuuRkEw8MXzoCU0kVOu@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx55w6IvKXgrcGq2BDM+0rfGag87dxrnptsPUA0XP3wxPACjOd
	9KWC+Qmad5bH44N96GoQspJIt6RQRKsKgv8yjVSDdeeYkMD4mIWGyfqBsR8vx2I=
X-Gm-Gg: ASbGncuQXPLo7oq0seiIazlOFzmqZ6ZVTfjL2C3p0JJM5km2ZXejFRk9etoFtPJ7iTE
	XSmHNktaq4M5SzU3lhvgKQfi5kOwvpo1eD4VbjS4ihWR0Q1kyYPubuZUfvk5KctrWfTKRj+9ZsQ
	eFxYgtfBZeX0wcEbEyWX/J5WDWxsZerBIqrhbCrapv6/XFKWOCPoWdkKFFCzuA74zu0SCwO6qOx
	nQtN42YLVcXWhQiq4Gwp8miMNFpQA0u1BGz3QPeGyr7eHfilYi/VDprh4ZZ7oejgf9Z+AN7sg5a
	7LeirMhFVy4IZQUm30o6OMGN7nvuB3yEH1/Tnpl56hQGn/K62ZGvxZv9Yi0FZrLCHmsIVcbCRWs
	XSDfDnFZQoAYr1Q==
X-Google-Smtp-Source: AGHT+IG//ycYvi6kOcuuO68LXeKSwnrGdpvwaRuS7wiVSi2aoHOJKzsXsJrdRbd4Avnb7+6KnL1VUg==
X-Received: by 2002:a17:90b:4a51:b0:2ee:af31:a7bd with SMTP id 98e67ed59e1d1-30aac184d78mr7589256a91.5.1746666807561;
        Wed, 07 May 2025 18:13:27 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30ad4f89b7dsm908812a91.47.2025.05.07.18.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 18:13:26 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uCppD-00000000jrq-12BE;
	Thu, 08 May 2025 11:13:23 +1000
Date: Thu, 8 May 2025 11:13:23 +1000
From: Dave Chinner <david@fromorbit.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Jens Axboe <axboe@kernel.dk>, Chris Mason <clm@meta.com>,
	Anna Schumaker <anna@kernel.org>
Subject: Re: performance r nfsd with RWF_DONTCACHE and larger wsizes
Message-ID: <aBwFM27NZ8t3aeH8@dread.disaster.area>
References: <370dd4ae06d44f852342b7ee2b969fc544bd1213.camel@kernel.org>
 <aBqNtfPwFBvQCgeT@dread.disaster.area>
 <8039661b7a4c4f10452180372bd985c0440f1e1d.camel@kernel.org>
 <aBrKbOoj4dgUvz8f@dread.disaster.area>
 <79560cc9-6931-417d-8491-182e4ff77666@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79560cc9-6931-417d-8491-182e4ff77666@oracle.com>

On Wed, May 07, 2025 at 09:43:05AM -0400, Chuck Lever wrote:
> On 5/6/25 10:50 PM, Dave Chinner wrote:
> > Ok, so buffered writes (even with RWF_DONTCACHE) are not processed
> > concurrently by XFS - there's an exclusive lock on the inode that
> > will be serialising all the buffered write IO.
> > 
> > Given that most of the work that XFS will be doing during the write
> > will not require releasing the CPU, there is a good chance that
> > there is spin contention on the i_rwsem from the 15 other write
> > waiters.
> 
> This observation echoes my experience with a client pushing 16MB
> writes via 1MB NFS WRITEs to one file. They are serialized on the server
> by the i_rwsem (or a similar generic per-file lock). The first NFS WRITE
> to be emitted by the client is as fast as can be expected, but the RTT
> of the last NFS WRITE to be emitted by the client is almost exactly 16
> times longer.

Yes, that is the symptom that will be visible if you just batch
write IO 16 at a time. If you allow AIO submission up to a depth
of 16 (i.e. first 16 submit in a batch, then submit new IO in
completion batch sizes) then there is always 16 writes on the wire
instead of it trailing off like 16 -> 0, 16 -> 0, 16 -> 0.

This would at least keep the pipeline full, but it does nothing to
address the IO latency of the server side serialisation.

There is some work in progress to allow concurrent buffered writes
in XFS, and this would largely solve this issue for the NFS
server...

> I've wanted to drill into this for some time, but unfortunately (for me)
> I always seem to have higher priority issues to deal with.

It's really an XFS thing, not an NFS server problem...

> Comparing performance with a similar patch series that implements
> uncached server-side I/O with O_DIRECT rather than RWF_UNCACHED might be
> illuminating.

Yes, that will directly compare concurrent vs serialised submission,
but O_DIRECT will also include IO completion latency in the write
RTT, so overall write throughput can still go down.

In my experience, Improving NFS IO throughput is all about
maximising the number of OTW requests in flight (client side) whilst
simultaneously minimising the latency of individual IO operations
(server side). RWF_DONTCACHE makes the latency of individual
operations somewhat worse, O_DIRECT makes the latency quite a bit
worse. O_DIRECT, however, can mitigate IO latency via concurrency,
but RWF_DONTCACHE cannot (yet).

Hence it is no surprise to me that, everything else being equal,
these server side options actually reduce throughput rather than
improve it...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

