Return-Path: <linux-fsdevel+bounces-43853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7278AA5E8DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 01:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B68AC3B5252
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 23:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FDA1DE896;
	Wed, 12 Mar 2025 23:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="efgLDDwf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6BB1EF099
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 23:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741823999; cv=none; b=rRY2CQsXZ3uFh9vJTpA6qf2PBdodnShSzVaXQaK+5Ul6h+B5ZWaWi1XY3iRFi5SUWBdFZoQPRF59+A/VOssEJZKA0DG3eODlYZqiisv5p6eMXJb7UwnKtDCdYtGzLC6Z2sMWHxaMhZF2RNSyfh5CI4VMEkg+9nRVNRj93embaG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741823999; c=relaxed/simple;
	bh=t0tZTSGtr4UWsHEiOdyc/1GE5qfFf7wDTtBzSRIEYng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ku70a5e87qRsagmho2Woz8qcQkSV9J245a5oV3wyIbcILXFL8W1yV0L2hX1ybaVRvpCeNtI3yx1Ye9ZfmOVPxNRQVcEWb6inin5uohFIe8eiLDQ6CWmwa2oQz3LiKXX4irIKmb6J6k81+DMTdar8SQ21j9ZNZOeEyGmDTJoSMoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=efgLDDwf; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-225b5448519so7342745ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 16:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1741823997; x=1742428797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yytaLmBYctbIRkoKABXnhpi2qYihFcFQJbj0+Q55xFU=;
        b=efgLDDwfCH9znTe26cuC83tVPXAlx6Mu+UmDx7nv5tQ51iV887eFj1MvlRNyaQ3wZO
         PArU9JIPVeHbX1HzJ0gMVgAoFtoKBtV/VwKFrSMu1ahZ4CFofjLH5VszIFGkuDvsFBzC
         mvxmDQgJ62I10pY4ocxC6lh5cYOp3xZ9SE+ViL5Z034Lp4P7fyPy9hQ3o3lwmhLw1++d
         qaKr0o5iwwiqTvpVuEZMmTONsKvtVhx8C2F1Crrvxqr6+qJnu1hmKmJXHkosPJ7aDxTb
         77zjx/3ISpJ8P3AGxtSj73k1RKVcFcLn9Ru9GV1Jg+VYqXoRGtn/DdRHeAPEfOPyhv4+
         HvKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741823997; x=1742428797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yytaLmBYctbIRkoKABXnhpi2qYihFcFQJbj0+Q55xFU=;
        b=Jsl7a3kvGHabhmRuk9wnZ5f1KiAGqHyiGkTbrfVyeJDmHN4u+HqaGSXa1grfM7Cjpo
         s3+7IMndsT3cB+u5p2ce7Dkhu8SYrsafZZkTdBq9JB2bVb9XTrOR+1JLk4z9o4wO4SI1
         UyUdzcDvGjIGnczWf6+givXaqgrB7i1/qB/YN+99yhe2oV+Rc9kLNGEwnPwmhSK357+T
         /BJUcNJyx5RHoyoKHYxD1zOGSPWPSbQk1DkXlkLsAoO/i/v+1rUPB8V/U9qD2ZtpWkLn
         qlqwlVjHejEXk8eWDtB4B8EdKPq7ywQ5EfFSrw1YDUyvhi/XM4llvF3apRc0qDIC38yG
         1lhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfZMSFPqniVUcpjzBwiS4WwbApMeflyRdul0m1G7wJV9Nx6pQFZG6mOlFHME9BW2xXeJu+xRBqa+d6wZd8@vger.kernel.org
X-Gm-Message-State: AOJu0YxJEpfl758mvVFFyHb6x4YFKULktAX4TxeDsbGlyNOmzzMtOSvS
	zIWK7ZGqnt+m8Ox7VAn4X0lYY1uDJDstP4/b/LYd1SGHqBlBu+hVFwx3cMhcLZY=
X-Gm-Gg: ASbGncv+v/HUR7XywfXSe2N13xFRjugk8NLQemHzwufj0fEIKN1BEde2w0eFeU0wXk/
	BNbDtmifswy/NXy+rvc7yVL041AoF66A3G7PEOYCPspl7aWalmFZr7XEUwQSX9wFE6NtGO3l5m6
	Cx04/WUzBQKFDyHgaPK0p0Zvvrc+MKOKTlm4PCoAwQPzAuIMNXnPG12IsR26KAVLs7onDna2gOI
	t7KjRjNCl5LzFxoUycwXgrzm8WupHyTMcMhDTfbCMwHScW0N+1tbI67C+ejYFRt1mq356Yawr/f
	DQGXUThFwZpHxGA5ZO+itKsH7LPFzMFWiBoppw8AL7afDmImdkd7vFwqbASw45eR0p1s+ZJ8OyD
	/PsDfRuNd+c3c6h6mxi/emamjfGgYDX0=
X-Google-Smtp-Source: AGHT+IG4RCxcrmTYAq5F1HE82NxgYxY0Zc/jsHH0E4Gd1id1R+9jO5XGlN+xR0DEb3WE960pzuGqyw==
X-Received: by 2002:a17:902:e5d2:b0:223:66bc:f1de with SMTP id d9443c01a7336-22428a9810dmr352747475ad.21.1741823996781;
        Wed, 12 Mar 2025 16:59:56 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30138f8ca8fsm38113a91.31.2025.03.12.16.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 16:59:56 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tsVzN-0000000CMFO-0mqW;
	Thu, 13 Mar 2025 10:59:53 +1100
Date: Thu, 13 Mar 2025 10:59:53 +1100
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: John Garry <john.g.garry@oracle.com>, brauner@kernel.org,
	djwong@kernel.org, cem@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH RFC v5 10/10] iomap: Rename ATOMIC flags again
Message-ID: <Z9If-X3Iach3o_l3@dread.disaster.area>
References: <20250310183946.932054-1-john.g.garry@oracle.com>
 <20250310183946.932054-11-john.g.garry@oracle.com>
 <Z9E0JqQfdL4nPBH-@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9E0JqQfdL4nPBH-@infradead.org>

On Wed, Mar 12, 2025 at 12:13:42AM -0700, Christoph Hellwig wrote:
> On Mon, Mar 10, 2025 at 06:39:46PM +0000, John Garry wrote:
> > Dave Chinner thought that names IOMAP_ATOMIC_HW and IOMAP_ATOMIC_SW were
> > not appropopiate. Specifically because IOMAP_ATOMIC_HW could actually be
> > realised with a SW-based method in the block or md/dm layers.
> > 
> > So rename to IOMAP_ATOMIC_BIO and IOMAP_ATOMIC_FS.
> 
> Looking over the entire series and the already merged iomap code:
> there should be no reason at all for having IOMAP_ATOMIC_FS.
> The only thing it does is to branch out to
> xfs_atomic_write_sw_iomap_begin from xfs_atomic_write_iomap_begin.
> 
> You can do that in a much simpler and nicer way by just having
> different iomap_ops for the bio based vs file system based atomics.

Agreed - I was going to suggest that, but got distracted by
something else and then forgot about it when I got back to writing
the email...

> I agree with dave that bio is a better term for the bio based
> atomic, but please use the IOMAP_ATOMIC_BIO name above instead
> of the IOMAP_BIO_ATOMIC actually used in the code if you change
> it.

Works for me.

> >   */
> >  static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
> > -		const struct iomap *iomap, bool use_fua, bool atomic_hw)
> > +		const struct iomap *iomap, bool use_fua, bool bio_atomic)
> 
> Not new here, but these two bools are pretty ugly.
> 
> I'd rather have a
> 
>     blk_opf_t extra_flags;
> 
> in the caller that gets REQ_FUA and REQ_ATOMIC assigned as needed,
> and then just clear 

Yep, that is cleaner..

-Dave.
-- 
Dave Chinner
david@fromorbit.com

