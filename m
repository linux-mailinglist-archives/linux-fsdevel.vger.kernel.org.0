Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5F676375F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 15:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbjGZNUo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 09:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjGZNUn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 09:20:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB46128;
        Wed, 26 Jul 2023 06:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JtKnJq+4OdOCb8ygvaESWFnDZX1W13EfB4+pNIQ8HQw=; b=d1jVnzBunFdUNsVPdzSq7i9TNm
        X8sn3CpOIXl8dCzWeKyY6EHGLKXp84/h1froaEp/kQbupUdNJsjzV2n/GJjrLAR6ues5s5rWYuT6A
        kMqNXjlNqTuyseVJS35MkMIBRY2qcaD/2y2N9yu6wZye9ivF9onzX4hr0kese2PljIGyXLw5X15Fk
        eNe1uubvCOtkhgcKnTjl9E8NX9IXuGy1rH/2bKfsoXMn5ijCLRnO5ZLIF5rEcEE7tzpm9LFhPJxwL
        JgOdaYFGXgav3Zq38hmPEdpFDvR7IYUYj/UkbVLLVJ4ufUonrCv2ABuuqNrncVEs6ePcZf0B/NKmM
        O/kSVNSg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qOeRW-00AWGY-0E;
        Wed, 26 Jul 2023 13:20:42 +0000
Date:   Wed, 26 Jul 2023 06:20:42 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 04/20] block: Add some exports for bcachefs
Message-ID: <ZMEdqvzAUbQPs0io@infradead.org>
References: <20230712211115.2174650-1-kent.overstreet@linux.dev>
 <20230712211115.2174650-5-kent.overstreet@linux.dev>
 <ZL61WIpYp/tJ6XH1@infradead.org>
 <20230725030037.minycb3oxubajuqw@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725030037.minycb3oxubajuqw@moria.home.lan>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 24, 2023 at 11:00:37PM -0400, Kent Overstreet wrote:
> In short, iomap is heavily callback based, the bcachefs io paths are
> not - we pass around data structures instead. I discussed this with
> people when iomap was first being written, but iomap ended up being a
> much more conservative approach, more in line with the old buffer heads
> code where the generic code calls into the filesystem to obtain
> mappings.
> 
> I'm gradually convincing people of the merits of the bcachefs approach -
> in particular reducing indirect function calls is getting more attention
> these days.

FYI, Matthew has had patches that convert iomap to be an iterator,
and I've massage the first half of them and actuall got them in
before.  I'd much rather finish off that work (even if only for
direct I/O initially) than adding another direct I/O code.  But
even with out that we should be able to easily pass more private
data, in fact btrfs makes pretty heavy use of that.
