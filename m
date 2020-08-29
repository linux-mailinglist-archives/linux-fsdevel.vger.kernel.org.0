Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014E5256519
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Aug 2020 08:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbgH2Gkt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Aug 2020 02:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgH2Gkt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Aug 2020 02:40:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE917C061236;
        Fri, 28 Aug 2020 23:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7l+Em9gvBvWd82kjcq938GwighvalU0zZ6jp3z8HlSI=; b=hr+xuOKarpl9EfqKCjkFM5KlYc
        527XyEupWB/z+YMisYTw5goBiZWS0iGPO/sgBY+bXs1DjcGnz3T7OOlGdsI7LoNswS0GSccwNNI2G
        T0I5vOvoTFT/i6J3Vu1E/DnFcU47xy2gEHv4ciK1Z2m33LwjaMgahdsR3qLf2mKndFJxZYowODfPx
        N58VYJzgJsUfm8dIjwu5ydyrTvxqWlgCvzoAhJiYy195VsEtYuxLODFwGqvyrhT6K5LHhpSb1U+MX
        MA15xXjMyHhNg2neyDtZCz3p6Q6xFaBhdzmoDZu3x9mE/x0dHHkzxMBs/sYQmyuzVet4QGdezQpBf
        5auA6M4g==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBuXZ-0007Vf-Rk; Sat, 29 Aug 2020 06:40:41 +0000
Date:   Sat, 29 Aug 2020 07:40:41 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        yebin <yebin10@huawei.com>,
        linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH RFC 2/2] block: Do not discard buffers under a mounted
 filesystem
Message-ID: <20200829064041.GA23205@infradead.org>
References: <20200825120554.13070-1-jack@suse.cz>
 <20200825120554.13070-3-jack@suse.cz>
 <20200825121616.GA10294@infradead.org>
 <F9505A56-F07B-4308-BE42-F75ED76B4E3C@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F9505A56-F07B-4308-BE42-F75ED76B4E3C@dilger.ca>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 28, 2020 at 02:21:29AM -0600, Andreas Dilger wrote:
> On Aug 25, 2020, at 6:16 AM, Christoph Hellwig <hch@infradead.org> wrote:
> > 
> > On Tue, Aug 25, 2020 at 02:05:54PM +0200, Jan Kara wrote:
> >> Discarding blocks and buffers under a mounted filesystem is hardly
> >> anything admin wants to do. Usually it will confuse the filesystem and
> >> sometimes the loss of buffer_head state (including b_private field) can
> >> even cause crashes like:
> > 
> > Doesn't work if the file system uses multiple devices.
> 
> It's not _worse_ than the current situation of allowing the complete
> destruction of the mounted filesystem.  It doesn't fix the problem
> for XFS with realtime devices, or ext4 with a separate journal device,
> but it fixes the problem for a majority of users with a single device
> filesystem.
> 
> While BLKFLSBUF causing a crash is annoying, BLKDISCARD/BLKSECDISCARD
> under a mounted filesystem is definitely dangerous and wrong.
> 
> What about checking for O_EXCL on the device, indicating that it is
> currently in use by some higher level?

That actually seems like a much better idea.
