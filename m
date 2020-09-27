Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E91F27A0B2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Sep 2020 14:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgI0MEk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Sep 2020 08:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgI0MEk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Sep 2020 08:04:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17479C0613CE;
        Sun, 27 Sep 2020 05:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3yHqJ6vX2gxZUI8YCJ4GLsFUiXcWJYaONkJBncby4OY=; b=hgvjEqJFSzls9uiRaGd3elF1vz
        ORkDAJ+4oo6pKY3abbi3iBss7hjm69lSgbiBbowMZHn4khUyoTXfNHhNCW0T0Qg3GDkHMWh1qnZP1
        IrslSTktukBAtx73dlx7FW/0TMGcndQLtl5MbZfIqyOdxjmycRi0RX0iajVEzcYux2oUHrViKz6XC
        0bM3kFsD85m0U6OVAgEl63w+Ep9vxs0oEyKqDgFA/PT0rp13X1U5V0tysrICh1ErkqD1iKG2aJ8fL
        9yRsYWGo9688wdXLnPt4vqWvKM7RApQARixu3g4l2S1kwEgelJUJB6qQC+MSvYFq9u8YXciAQYvjN
        Vn7k06/A==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kMVPv-0007N1-Vw; Sun, 27 Sep 2020 12:04:36 +0000
Date:   Sun, 27 Sep 2020 13:04:35 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Qian Cai <cai@redhat.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH] iomap: Set all uptodate bits for an Uptodate page
Message-ID: <20200927120435.GC7714@casper.infradead.org>
References: <CA+icZUVO65ADxk5SZkZwV70ax5JCzPn8PPfZqScTTuvDRD1smQ@mail.gmail.com>
 <20200924200225.GC32101@casper.infradead.org>
 <CA+icZUV3aL_7MptHbradtnd8P6X9VO-=Pi2gBezWaZXgeZFMpg@mail.gmail.com>
 <20200924235756.GD32101@casper.infradead.org>
 <CA+icZUWcx5hBjU35tfY=7KXin7cA5AAY8AMKx-pjYnLCsQywGw@mail.gmail.com>
 <CA+icZUWMs5Xz5vMP370uUBCqzgjq6Aqpy+krZMNg-5JRLxaALA@mail.gmail.com>
 <20200925134608.GE32101@casper.infradead.org>
 <CA+icZUV9tNMbTC+=MoKp3rGmhDeO9ScW7HC+WUTCCvSMpih7DA@mail.gmail.com>
 <20200925155340.GG32101@casper.infradead.org>
 <CA+icZUWmF_7P7r-qmxzR7oz36u_Wy5HA6fh5zFFZd1D-aZiwkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUWmF_7P7r-qmxzR7oz36u_Wy5HA6fh5zFFZd1D-aZiwkQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 27, 2020 at 01:31:15PM +0200, Sedat Dilek wrote:
> > I would suggest that you try applying just the assertion to Linus'
> > kernel, then try to make it fire.  Then apply the fix and see if you
> > can still make the assertion fire.
> >
> > FWIW, I got it to fire with generic/095 from the xfstests test suite.
> 
> With...
> 
> Linux v5.9-rc6+ up to commit a1bf fa48 745a ("Merge tag 'scsi-fixes'
> of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi")
> ...and...
> 
>  xfstests-dev up to commit 75bd80f900ea ("src/t_mmap_dio: do not build
> if !HAVE_AIO")
> 
> ...I have seen in my first run of...
> 
> [ generic/095 ]
> 
> dileks@iniza:~/src/xfstests-dev/git$ sudo ./check generic/095
> FSTYP         -- ext4

There's the first problem in your setup; you need to be checking XFS
to see this problem.  ext4 doesn't use iomap for buffered IO yet.

> PLATFORM      -- Linux/x86_64 iniza 5.9.0-rc6-7-amd64-clang-cfi
> #7~bullseye+dileks1 SMP 2020-
> 09-27
> MKFS_OPTIONS  -- /dev/sdb1

I'm using "-m reflink=1,rmapbt=1 -i sparse=1 -b size=1024"

