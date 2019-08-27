Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8EBE9E4EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2019 11:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbfH0Jwc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Aug 2019 05:52:32 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36920 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728808AbfH0Jwc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Aug 2019 05:52:32 -0400
Received: by mail-pf1-f194.google.com with SMTP id y9so13420997pfl.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2019 02:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y+Hx7d/m4wprfVAziyvHQsP5nHRV1o00I9AIkIwGmBI=;
        b=oR8FYwqyxnUNtWn9qDiZuFshumZRSt9tmRikWYbDag77666pzk94O4GjoYqiO7vc9C
         mEwlKH5xjHhyNheZbKl8W7DlS/COtYiMYs8IIWube+emNCjTPBPB6oh450j8E91Ahqci
         mcH9qTDlYoohq/RkYrEkvTs60+1mAp4AxiwrUeusvQP8rbXapNP4T6RB1xoyxoX2REhW
         RlVmzf8Vi9ZJsumrU621TBW9SBVRz/NyzO/HsBsD6JrF747VcucSlSPxezLZQQVHnv6l
         pscJjdMPYuUEz57xSOH1BLzHxry6PCdYjmYq5wEWlO0x6r8SyGcqLY2w3a9rPg/VKwck
         9JAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y+Hx7d/m4wprfVAziyvHQsP5nHRV1o00I9AIkIwGmBI=;
        b=ZXG8pHl+QnnLJI9G15PjZqdZNijii+98Jo+Uzl/5LRBmUnTa6DApfQDUY3h+Hig3Io
         3NljLEqiyymjueiTYoGRJOUNk1YDjg7m8IBuzotgxLvu7fBu8cvIja2c6174Pi0WE9ng
         w1oj5ZIPxWL5leWMt1yFOtGBROIyOugZB+cNKSOqmRwakWf2P0iV2SswR7+b2KsFbur9
         gY0YKu5EYJe6dTT2M0ek7CA5ijCSotYqp+7+bZ8dqaGWyo3qrXX7AK4lEvOGMKwIVw/1
         nvitbyToIRK+H1B+h1ynekTX+rcB2w66Uo0es3UMmuQPQRwTJbpf41xYSYZLwMwM847E
         wpyQ==
X-Gm-Message-State: APjAAAU6AMj97un1Dc7uv0xSqe8bbxClVPLjWB9u9PIIOmi1l1Czv0bV
        b1aEt8MwwoF7TU/rRm7ZSm0f
X-Google-Smtp-Source: APXvYqzscS+XMU6obO2Ex2JLNcSixvi3mTvrraxDm0d8nX0LBExX6zTY1+QlXK5Bs9Yk3wGsl/CORw==
X-Received: by 2002:a17:90a:33ed:: with SMTP id n100mr24625174pjb.19.1566899550316;
        Tue, 27 Aug 2019 02:52:30 -0700 (PDT)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id z63sm14239181pfb.163.2019.08.27.02.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 02:52:29 -0700 (PDT)
Date:   Tue, 27 Aug 2019 19:52:23 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>, tytso@mit.edu,
        jack@suse.cz, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, aneesh.kumar@linux.ibm.com
Subject: Re: [PATCH 0/5] ext4: direct IO via iomap infrastructure
Message-ID: <20190827095221.GA1568@poseidon.bobrowski.net>
References: <cover.1565609891.git.mbobrowski@mbobrowski.org>
 <20190812173150.AF04F5204F@d06av21.portsmouth.uk.ibm.com>
 <20190813111004.GA12682@poseidon.bobrowski.net>
 <20190813122723.AE6264C040@d06av22.portsmouth.uk.ibm.com>
 <20190821131405.GC24417@poseidon.bobrowski.net>
 <20190822120015.GA3330@poseidon.bobrowski.net>
 <20190822141126.70A94A407B@d06av23.portsmouth.uk.ibm.com>
 <20190824031830.GB2174@poseidon.bobrowski.net>
 <20190824035554.GA1037502@magnolia>
 <20190824230427.GA32012@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190824230427.GA32012@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 24, 2019 at 04:04:27PM -0700, Christoph Hellwig wrote:
> On Fri, Aug 23, 2019 at 08:55:54PM -0700, Darrick J. Wong wrote:
> > I'm probably misunderstanding the ext4 extent cache horribly, but I keep
> > wondering why any of this is necessary -- why can't ext4 track the
> > unwritten status in the extent records directly?  And why is there all
> > this strange "can merge" logic?  If you need to convert blocks X to Y
> > to written state because a write to those blocks completed, isn't that
> > just manipulation of a bunch of incore records?  And can't you just seek
> > back and forth in the extent cache to look for adjacent records to merge
> > with? <confuseD>
> 
> Same here.  I'm not an ext4 expert, but here is what we do in XFS, which
> hopefully works in some form for ext4 a well:
> 
>  - when starting a direct I/O we allocate any needed blocks and do so
>    as unwritten extent.  The extent tree code will merge them in
>    whatever way that seems suitable
>  - if the IOMAP_DIO_UNWRITTEN is set on the iomap at ->end_io time we
>    call a function that walks the whole range covered by the ioend,
>    and convert any unwritten extent to a normal written extent.  Any
>    splitting and merging will be done as needed by the low-level
>    extent tree code
>  - this also means we don't need the xfs_ioen structure (which ext4)
>    copied from for direct I/O at all (we used to have it initially,
>    though including the time when ext4 copied this code).
>  - we don't need the equivalent to the ext4_unwritten_wait call in
>    ext4_file_write_iter because we serialize any non-aligned I/O
>    instead of trying to optimize for weird corner cases

Yeah, so what you've detailed above is essentially the approach I've
taken in my patch series...

What is not clear to me at this point though is whether it is still
necessary to explicitly track unwritten extents via in-core inode
attributes i.e. ->i_unwritten and ->i_state_flags under the new direct
IO code path implementation, which makes use of the iomap
infrastructure. Or, whether we can get away with simply not using
these in-core inode attributes and rely just on checks against the
extent record directly, as breifly mentioned by Darrick. I would think
that this type of check would be enough, however the checks around
whether the inode is currently undergoing direct IO were implemented
at some point, so there must be a reason for having them
(a9b8241594add)?

--M
