Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB7EA013E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2019 14:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfH1MFU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Aug 2019 08:05:20 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37089 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfH1MFU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Aug 2019 08:05:20 -0400
Received: by mail-pg1-f196.google.com with SMTP id d1so1369665pgp.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2019 05:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7G2znRv27BShdYiwf40X93IIg8DV9PlDtrar1+UObuQ=;
        b=AyuEs0saZAqIkPZrRunyqJ1MKwkPVRyV05nPhEif9MuL7rV2dkMS0fsYZR1bk9G5K4
         xbgowsSGywB+h6yTq2y08AuAHh2gYCeZwVTb/srFdLlPZAxuQisfCG4v7wQRX5ooeHPY
         iGMhGtrFA0oYMRgSBGTWKWzmn1vzDSehPh4cmMXGP7nWepsEKb4PptQLcr1EUZBqi+jI
         3zy5hu54W2XlzZK4QtvIO8JLJV3YHpwAMxN3hZAWZ6kyeBTybSrVIyqd8RNMyOZbalzL
         fmtJLhyZgo1GZChdU/PplOSp92qM5s59U24DwKHkxv3eYF2/i/NXAduxzOmcXUEJHttn
         ROeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7G2znRv27BShdYiwf40X93IIg8DV9PlDtrar1+UObuQ=;
        b=sh0ULFBfK61VcMifbs8qnxatllpf3wyEH/7SL7JMaoAhs94PWq6HwJw3Bs+Vq8OtSx
         33bkHoyK38POGKwOpG7s5eF7EGZIkocEIjIcxBKbE8yMJFCr7Acla3GEN0L1+K6bL4EN
         lmy8DN25bEyNvJURrZYjA9Jwy/o/XJFP7rn98mexIJG6css6jCDP2wXutUcgGWJNj6Rk
         Kg5pZ1FMKZziLmkmeNf4tBDC5VObfhwCm4/jgILTjKhDqPB0CTRIocSb5+obAKsYQFJc
         1JxIdgvybXNbnArqqyd5QbJ1Fm0LGknI6hU2pNX+E/3UdncIDOfaEQWQg7On5Njcc1xc
         aR3Q==
X-Gm-Message-State: APjAAAXg+DXZR5AfFp0tGuzwLMAtX6yfKiM19aQd68KSi3/puZCt+ykw
        FRNZLr8NuuI5EsPUq2bttm8K
X-Google-Smtp-Source: APXvYqwaCgvMK4Kf+1hvKZDOXMgeSrL23FErU37Y5siii8/1SL1+DtA+EiPzNTL0yYMuCBOxpi6srA==
X-Received: by 2002:a63:c1c:: with SMTP id b28mr3168474pgl.354.1566993918868;
        Wed, 28 Aug 2019 05:05:18 -0700 (PDT)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id q3sm4867456pfn.4.2019.08.28.05.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 05:05:18 -0700 (PDT)
Date:   Wed, 28 Aug 2019 22:05:11 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>, tytso@mit.edu,
        jack@suse.cz, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, aneesh.kumar@linux.ibm.com
Subject: Re: [PATCH 0/5] ext4: direct IO via iomap infrastructure
Message-ID: <20190828120509.GC22165@poseidon.bobrowski.net>
References: <20190812173150.AF04F5204F@d06av21.portsmouth.uk.ibm.com>
 <20190813111004.GA12682@poseidon.bobrowski.net>
 <20190813122723.AE6264C040@d06av22.portsmouth.uk.ibm.com>
 <20190821131405.GC24417@poseidon.bobrowski.net>
 <20190822120015.GA3330@poseidon.bobrowski.net>
 <20190822141126.70A94A407B@d06av23.portsmouth.uk.ibm.com>
 <20190824031830.GB2174@poseidon.bobrowski.net>
 <20190824035554.GA1037502@magnolia>
 <20190824230427.GA32012@infradead.org>
 <20190827095221.GA1568@poseidon.bobrowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827095221.GA1568@poseidon.bobrowski.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 27, 2019 at 07:52:23PM +1000, Matthew Bobrowski wrote:
> On Sat, Aug 24, 2019 at 04:04:27PM -0700, Christoph Hellwig wrote:
> > On Fri, Aug 23, 2019 at 08:55:54PM -0700, Darrick J. Wong wrote:
> > > I'm probably misunderstanding the ext4 extent cache horribly, but I keep
> > > wondering why any of this is necessary -- why can't ext4 track the
> > > unwritten status in the extent records directly?  And why is there all
> > > this strange "can merge" logic?  If you need to convert blocks X to Y
> > > to written state because a write to those blocks completed, isn't that
> > > just manipulation of a bunch of incore records?  And can't you just seek
> > > back and forth in the extent cache to look for adjacent records to merge
> > > with? <confuseD>
> > 
> > Same here.  I'm not an ext4 expert, but here is what we do in XFS, which
> > hopefully works in some form for ext4 a well:
> > 
> >  - when starting a direct I/O we allocate any needed blocks and do so
> >    as unwritten extent.  The extent tree code will merge them in
> >    whatever way that seems suitable
> >  - if the IOMAP_DIO_UNWRITTEN is set on the iomap at ->end_io time we
> >    call a function that walks the whole range covered by the ioend,
> >    and convert any unwritten extent to a normal written extent.  Any
> >    splitting and merging will be done as needed by the low-level
> >    extent tree code
> >  - this also means we don't need the xfs_ioen structure (which ext4)
> >    copied from for direct I/O at all (we used to have it initially,
> >    though including the time when ext4 copied this code).
> >  - we don't need the equivalent to the ext4_unwritten_wait call in
> >    ext4_file_write_iter because we serialize any non-aligned I/O
> >    instead of trying to optimize for weird corner cases
> 
> Yeah, so what you've detailed above is essentially the approach I've
> taken in my patch series...
> 
> What is not clear to me at this point though is whether it is still
> necessary to explicitly track unwritten extents via in-core inode
> attributes i.e. ->i_unwritten and ->i_state_flags under the new direct
> IO code path implementation, which makes use of the iomap
> infrastructure. Or, whether we can get away with simply not using
> these in-core inode attributes and rely just on checks against the
> extent record directly, as breifly mentioned by Darrick. I would think
> that this type of check would be enough, however the checks around
> whether the inode is currently undergoing direct IO were implemented
> at some point, so there must be a reason for having them
> (a9b8241594add)?

Maybe it's a silly question, although I'm wanting to clarify my
understanding around why it is that when we either try prepend or
append to an existing extent, we don't permit merging of extents if
the inode is undergoing direct IO?

--M
