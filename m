Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C49B7416B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 18:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjF1Qr2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 12:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbjF1Qq5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 12:46:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F709F;
        Wed, 28 Jun 2023 09:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3p/6gRPbT1vLbxvPSCsO+AS87133UTz2Te2olPWVMi0=; b=fBygq+OhZHpmm+FqYPB0SYYJxs
        dkbSjX05mOg23yGibUfOMg7pvQ3le6IenSufrhalSwYSBW71vyRKtYLwC8vlc8cWL79BMLCHOsjj8
        5xkOKENSvOAR3j6C/cc11U3c8oDVlC84kqFkuSlN/rcCeX5kTlogHb9o1DA0gjBmyWPOIp6yOdsud
        AR8ksLyJ+cIp0crVLcb1X5U3Kg8B2PfSe8ftdn/x4qr8hWVdMdboCnweNPv9nnlJolQBZXHi8yhE5
        kgkgLc3gigu0XQxdPJOmT9Hl8kqZ42JwqSbmHd1AXDoXEpg9KetuWWyf7yjezUdlhkFnxsfhesijf
        SiFgptQw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qEYJO-00407Q-O0; Wed, 28 Jun 2023 16:46:34 +0000
Date:   Wed, 28 Jun 2023 17:46:34 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     axboe@kernel.dk, song@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, xiang@kernel.org, chao@kernel.org,
        huyue2@coolpad.com, jefflexu@linux.alibaba.com, hch@infradead.org,
        djwong@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/7] block: add queue_logical_block_mask() and
 bdev_logical_block_mask()
Message-ID: <ZJxj6odz49iB5Mmm@casper.infradead.org>
References: <20230628093500.68779-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628093500.68779-1-frank.li@vivo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 28, 2023 at 05:34:54PM +0800, Yangtao Li wrote:
> Introduce queue_logical_block_mask() and bdev_logical_block_mask()
> to simplify code, which replace (queue_logical_block_size(q) - 1)
> and (bdev_logical_block_size(bdev) - 1).

The thing is that I know what queue_logical_block_size - 1 does.
That's the low bits.  _Which_ bits are queue_logical_block_mask?
The high bits or the low bits?  And before you say "It's obviously",
we have both ways round in the kernel today.

I am not in favour of this change.  I might be in favour of bool
queue_logical_block_aligned(q, x), but even then it doesn't seem worth
the bits.
