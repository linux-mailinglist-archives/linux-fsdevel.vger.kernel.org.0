Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A783AEAB1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 16:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhFUOFy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 10:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbhFUOFx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 10:05:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767B5C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jun 2021 07:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gRLyJWK1hdc8Go660mI/8AbGpSuSlpNpfI7Y9UE5SvI=; b=Fkn/52N1+naubrw6iewUAvNXNR
        XtfPUbajVGQNJYWx4Tpr7b8V5/OrFCeniR9WCvuiX8XErpvNXzpUGxWO1aYVuPsa/P95ZZSIAl5zt
        NhEbWwbG9ubTF2L4O9ICha67DyvyJXRkzIQz/fgJ0IMagXo29icMbPFZzqYKNC0X187TRKiE4iaxD
        KS/1jvU/9mHnWKZjwQ+67BCZysHeR3SPgPH1Y5sfk4jmlRlxH2EPhVJDME6QA5hkDQeTvOfGpdGcA
        tOmaGqZUarLV0NSiyY7EglrEdcAFX+MEYrnTq3DCzi6YnGkYyv+SR0DQVNwkcbDYi7TCst8JT6mWf
        MJMEx9+Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvKW3-00D9tK-Or; Mon, 21 Jun 2021 14:03:14 +0000
Date:   Mon, 21 Jun 2021 15:03:07 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [RFC] what to do with IOCB_DSYNC?
Message-ID: <YNCcG97WwRlSZpoL@casper.infradead.org>
References: <YM/hZgxPM+2cP+I7@zeniv-ca.linux.org.uk>
 <20210621135958.GA1013@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621135958.GA1013@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 21, 2021 at 03:59:58PM +0200, Christoph Hellwig wrote:
> What about just setting O_DSYNC in f_flags at open time if a superblock
> has SB_SYNCHRONOUS set?  That means the flag won't be picked up for open
> files when SB_SYNCHRONOUS is set at remount time, but I'm not even sure
> we need to support it for remount.

i suggested that to viro last night, and he pointed out that ioctl(S_SYNC)
would also not be reflected in open files.  that's more of a concern,
i think.  if only we had the revoke() infrastructure (ie could walk
currently-open files on an inode).
