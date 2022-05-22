Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD97C530337
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 May 2022 15:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345739AbiEVNIB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 May 2022 09:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345553AbiEVNIA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 May 2022 09:08:00 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5590939835
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 May 2022 06:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H4KwOg2qaQybKhZIpSaxnY34IynZLLNZOOjYTnOklYw=; b=cPnn7jgxgR8ZyxaBwUILCRgzOT
        92kZkCzwzz4b3iG1hBan7oAU672RMSsKSNgKxeJCZfkgFvw+ZdQo+zlXEB4yn0yIJd033lOCfQn8u
        ab1+LUm1E28CMbvQynY9quCRVLNa0pBb+H6L+0faSmj4qSUUME6CscaVdZ2HG2qclTIVpajezYwct
        sYXpMdibyLPVmPkkP7ats/knmkdYbDTRkICeYFmOcDDGDs1aUp8t8Cyfdzk9vOCEDF9yFmiiNYmKz
        1vWq6zD6dqF0uibhsi8T7n3morcCNaD2Kb1kIPfqd9W9mOktv8/974D3lImQWmyq5XbHNgHVoLLwT
        ikk/YlFA==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nslJL-00HBIi-6B; Sun, 22 May 2022 13:07:55 +0000
Date:   Sun, 22 May 2022 13:07:55 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] what to do with IOCB_DSYNC?
Message-ID: <Yoo1q1+ZRrjBP2y3@zeniv-ca.linux.org.uk>
References: <70b5e4a8-1daa-dc75-af58-9d82a732a6be@kernel.dk>
 <f2547f65-1a37-793d-07ba-f54d018e16d4@kernel.dk>
 <20220522074508.GB15562@lst.de>
 <YooPLyv578I029ij@casper.infradead.org>
 <YooSEKClbDemxZVy@zeniv-ca.linux.org.uk>
 <Yoobb6GZPbNe7s0/@casper.infradead.org>
 <20220522114540.GA20469@lst.de>
 <e563d92f-7236-fbde-14ee-1010740a0983@kernel.dk>
 <YooxLS8Lrt6ErwIM@zeniv-ca.linux.org.uk>
 <96aa35fc-3ff7-a3a1-05b5-9fae5c9c1067@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96aa35fc-3ff7-a3a1-05b5-9fae5c9c1067@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 22, 2022 at 07:02:01AM -0600, Jens Axboe wrote:
> +static void iter_uaddr_advance(struct iov_iter *i, size_t size)
> +{
> +}

How could that possibly work?  At the very least you want to do
what xarray does - you *must* decrement ->count and shift ->iov_offset.
Matter of fact, I'd simply go with a bit of reorder and had it go
for if (iter_is_uaddr(i) || iter_is_xarray(i)) in there...
