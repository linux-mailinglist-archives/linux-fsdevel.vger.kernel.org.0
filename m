Return-Path: <linux-fsdevel+bounces-40813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F39A27C92
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 21:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D798A1657BC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 20:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE88219A66;
	Tue,  4 Feb 2025 20:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="uJpmLWw8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232F62063DB
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Feb 2025 20:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738699967; cv=none; b=OPk2HTaEwV06z9JgBHwGdADlGboUcuIrYTZGfuochzzrR/XKTsqSg11paQjexry0XOVT5YBVTP/+Evf3aRmbmlFptw1J1cwRK2foDUlxvfFQ5R08LK2QMZ3yAnaFS9lXrQpeUqT0EKgP0AcF5GxT1RGYkgJUlK9P7nLVadxRD3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738699967; c=relaxed/simple;
	bh=gp/qKcceCIBFhzJB5w2WTr0ubjDqbrZuAp3vz+nOqwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJGTBSmQXwP0H1BMdUv0Xmud+tMEEeFAShbISIJkCk4fZkgSiGGmdSQiM73vjy7+bTqZlTCP64TTK1nBQxYAOhSzDKrHtu7rQF4iEfnANaDyvancBHnJIjw6OzQyfdLOR6YbZiAeR6HEEgbJayAkFQZxscRKfKoRA83q1T8y8Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=uJpmLWw8; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-215770613dbso82712985ad.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Feb 2025 12:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1738699965; x=1739304765; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JZakwx3hIZttBtHScOUEbEcec/nTeRPJ+CdcAVEs9PQ=;
        b=uJpmLWw8WyXFev/F2MCx3TLRcnZUZFgRL/0hINC6MC9aFSdmKG6jY//phnFTEIc9yg
         pYIIjOjUhaVzXBM6ter9gw06xjuVGfGystmBCf+mSMojsF+Qze8YWyXM58WntTtS9aAS
         CkZmwlaazJfMzcg+EOvO6nV4BVV9sjvn9h7HZGrnMOzPjOz8mS7MIEAS4DTzObzgXM9E
         vpEwcH+6e/yWjFLpYHoq4EQYMfqK8vIOMesBFCEU/67qipLEDUr+wcVPkEaFoukO+/mR
         HqrxQzLywy/brjDPAxcJiC6gIHanUd14CXgvG4j7WO2HWVrxf6qRZ+ybUMafTQarfLQt
         4NlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738699965; x=1739304765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZakwx3hIZttBtHScOUEbEcec/nTeRPJ+CdcAVEs9PQ=;
        b=N9zhLTopcg0ecZn5uoJV8d5pXC3LcgrphtLpQXcwEvC3GEd5Dy8T+uqbae3DC8xt0v
         cdkIIn8pXgENIXTKZSDzOx+PD6H0/dDjOUgj0Cj2zyGGR1nuYkbn3PbSXmbtHN2I4r2W
         /gj8apGUNp7VfPxItsa1deFijLHu9ahNUTT2yfI2fmMgK/4xjcAMiillcMRc96NyzMqr
         3pTCYnhJPBjVTAxSONE9aESeZoq8YNoiwwLRcafGf4WI0AbZixbWX6nOp9ODW/nEmxLv
         cVBGO3U1ggaTsNQnMf2e1QCM+nF1KaH/HxI2EvGxgPGrAtWC8jlL36HSgkH86rF07U4t
         UFzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB9GyU2f3A71qsKe+HVe15sSviPZWyxBOttHxGhKqdK4sZOsDwfLz+5XDhLN926xkGnoGKQA9wKpv8t6yZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsy14YXHe561f/ORSfutZMuWzTFaPW4/Q8lCRtxI0jFG6oz6KG
	cTFDaL4bt7vEbdh5ainQHNHyiFPhKq+g5HyoWrBDgBYgrS21blRrYOEs166QkJY=
X-Gm-Gg: ASbGncueDaSKn58VxXIkyBRMspHHu0bjAA5fXFsluwYs7GWio/JR+bz3cH+maKfqHnJ
	NUuZz4ab+5aUcjdUXesSVcxwONqp9m8ZkS17mv/l07XzQ5c60PrGdyYY84frVnBTC8a4f85nxII
	YwvR00gfPiZJJIv3cobkbe4D00OU0FtbbtPGDIJnZJDSkN2j+jAYF7GwYNIZYBSyX54oA9Hk/fr
	MDW/GQoq5MiHufMgkxmQxWK4vtOIuNYwRQHpKLeblt5KU/9earwiERifL0Pl3RrR+tyFDrHYbVB
	ZedR+aAwKFPJ9VZ2k5Aa6DB+PW4dBh4b2sx+dbVYaUHQZEpPwrIuSSn8c5RKwWjvkhM=
X-Google-Smtp-Source: AGHT+IGwLEGhvYlXmhivElW8iATNfxvrwUqd0N+S0un/akZ8NPdnmS/kHtUzgFQDwkzSpzERucIPaw==
X-Received: by 2002:a05:6a21:9011:b0:1e8:a14a:7b67 with SMTP id adf61e73a8af0-1ede88ad432mr106482637.26.1738699965334;
        Tue, 04 Feb 2025 12:12:45 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acebe384685sm10442964a12.17.2025.02.04.12.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 12:12:44 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tfPHl-0000000EeLL-1z56;
	Wed, 05 Feb 2025 07:12:41 +1100
Date: Wed, 5 Feb 2025 07:12:41 +1100
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	lsf-pc@lists.linux-foundation.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, djwong@kernel.org,
	dchinner@redhat.com, hch@lst.de, ritesh.list@gmail.com,
	jack@suse.cz, tytso@mit.edu, linux-ext4@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] extsize and forcealign design in filesystems
 for atomic writes
Message-ID: <Z6J0uZdSqv3gJEbA@dread.disaster.area>
References: <Z5nTaQgLGdD6hSvL@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <35939b19-088b-450e-8fa6-49165b95b1d3@oracle.com>
 <Z5pRzML2jkjL01F5@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <e00bac5d-5b6c-4763-8a76-e128f34dee12@oracle.com>
 <Z53JVhAzF9s1qJcr@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <4a492767-ee83-469c-abd1-484d0e3b46cb@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a492767-ee83-469c-abd1-484d0e3b46cb@oracle.com>

On Tue, Feb 04, 2025 at 12:20:25PM +0000, John Garry wrote:
> On 01/02/2025 07:12, Ojaswin Mujoo wrote:
> 
> Hi Ojaswin,
> 
> > > For my test case, I am trying 16K atomic writes with 4K FS block size, so I
> > > expect the software fallback to not kick in often after running the system
> > > for a while (as eventually we will get an aligned allocations). I am
> > > concerned of prospect of heavily fragmented files, though.
> > Yes that's true, if the FS is up long enough there is bound to be
> > fragmentation eventually which might make it harder for extsize to
> > get the blocks.
> > 
> > With software fallback, there's again the point that many FSes will need
> > some sort of COW/exchange_range support before they can support anything
> > like that.
> > 
> > Although I;ve not looked at what it will take to add that to
> > ext4 but I'm assuming it will not be trivial at all.
> 
> Sure, but then again you may not have issues with getting forcealign support
> accepted for ext4. However, I would have thought that bigalloc was good
> enough to use initially.
> 
> > 
> > > > I agree that forcealign is not the only way we can have atomic writes
> > > > work but I do feel there is value in having forcealign for FSes and
> > > > hence we should have a discussion around it so we can get the interface
> > > > right.
> > > > 
> > > I thought that the interface for forcealign according to the candidate xfs
> > > implementation was quite straightforward. no?
> > As mentioned in the original proposal, there are still a open problems
> > around extsize and forcealign.
> > 
> > - The allocation and deallocation semantics are not completely clear to
> > 	me for example we allow operations like unaligned punch_hole but not
> > 	unaligned insert and collapse range, and I couldn't see that
> > 	documented anywhere.
> 
> For xfs, we were imposing the same restrictions as which we have for
> rtextsize > 1.
> 
> If you check the following:
> https://lore.kernel.org/linux-xfs/20240813163638.3751939-9-john.g.garry@oracle.com/
> 
> You can see how the large allocunit value is affected by forcealign, and
> then check callers of xfs_is_falloc_aligned() -> xfs_inode_alloc_unitsize()
> to see how this affects some fallocate modes.
> 
> > 
> > - There are challenges in extsize with delayed allocation as well as how
> > 	the tooling should handle forcealigned inodes.
> 
> Yeah, maybe. I was only testing my xfs forcealign solution for dio (and no
> delayed alloc).

XFS turns off delalloc when extsize hints are set. See
xfs_buffered_write_iomap_begin() - it starts with:

	/* we can't use delayed allocations when using extent size hints */
        if (xfs_get_extsz_hint(ip))
                return xfs_direct_write_iomap_begin(inode, offset, count,
                                flags, iomap, srcmap);

and so it treats the allocation like a direct IO write and so
force-align should work with buffered writes as expected.

This delalloc constraint is a historic relic in XFS - now that we
use unwritten extents for delalloc we -could- use delalloc with
extsize hints; it just requires the delalloc extents to be aligned
to extsize hints.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

