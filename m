Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7307A495A62
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jan 2022 08:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378862AbiAUHM7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jan 2022 02:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245097AbiAUHM6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jan 2022 02:12:58 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC15C061574;
        Thu, 20 Jan 2022 23:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3xQuu5tx1EVXpvy8gXk3sJ9oqDEqzzzoX73hPh5DOfA=; b=q8Mnz0Gu2GNpfhG/y3b/jMfQWZ
        mrffWaQqN4RqOjJuC4ulhiTWsAkL/RACkK6FG43IXgNrMmZ2ObvkbaNdiwzYoorsoRl43aRSgDFDl
        GjEvNumk7JqTJq9J6ggkGCUYci/n+AXZ5zEGP8/NG6QsGIn+KdsUUitgTHMGzVG7b0cOfSwHdMZvD
        21D9iTrO/B9kHAYKo2GVNsUx1xxKLpW7+/eUQLNaVaN/yVYE2izpcQ2WOte5HOGUcujc7WjqBwK3V
        VWrIsvlUxABtXb2ZoKLsrZkhJD+qMBbGE6i2Mi6YVINqkulvo8ShP2gqaF5FOMpt71no8rw0g0Cv2
        +1gJdHPw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nAo6S-00E1l5-Pa; Fri, 21 Jan 2022 07:12:56 +0000
Date:   Thu, 20 Jan 2022 23:12:56 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v10 0/5] add support for direct I/O with fscrypt using
 blk-crypto
Message-ID: <Yepc+JcZiICsJfTQ@infradead.org>
References: <20220120071215.123274-1-ebiggers@kernel.org>
 <YekdnxpeunTGfXqX@infradead.org>
 <20220120171027.GL13540@magnolia>
 <YenIcshA706d/ziV@sol.localdomain>
 <20220120210027.GQ13540@magnolia>
 <20220120220414.GH59729@dread.disaster.area>
 <Yenm1Ipx87JAlyXg@sol.localdomain>
 <20220120235755.GI59729@dread.disaster.area>
 <20220121023603.GH13563@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121023603.GH13563@magnolia>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 20, 2022 at 06:36:03PM -0800, Darrick J. Wong wrote:
> Sure.  How's this?  I couldn't think of a real case of directio
> requiring different alignments for pos and bytecount, so the only real
> addition here is the alignment requirements for best performance.

While I see some benefits of adding the information to a catchall like
statx we really need to be careful to not bloat the structure like
crazy.

> struct statx {
> ...
> 	/* 0x90 */
> 	__u64	stx_mnt_id;
> 
> 	/* Memory buffer alignment required for directio, in bytes. */
> 	__u32	stx_dio_mem_align;
> 
> 	/* File range alignment required for directio, in bytes. */
> 	__u32	stx_dio_fpos_align_min;

So this really needs a good explanation why we need both iven that we
had no real use case for this.

> 	/* File range alignment needed for best performance, in bytes. */
> 	__u32	stx_dio_fpos_align_opt;

And why we really care about this.  I guess you want to allow sector
size dio in reflink setups, but discourage it.  But is this really as
important?

> 	/* Maximum size of a directio request, in bytes. */
> 	__u32	stx_dio_max_iosize;

I know XFS_IOC_DIOINFO had this, but does it really make much sense?
Why do we need it for direct I/O and not buffered I/O?
