Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B741BB5C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 07:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgD1FT7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 01:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725917AbgD1FT6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 01:19:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C01C03C1A9;
        Mon, 27 Apr 2020 22:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N449VoWVR375Ueo46T0G2hb5JRZUT8vtjXxmy+kIL1M=; b=ejvrm4cY1yi+VTSCq/t35ySQyX
        UPercnk+hk9IJM/1hiaxfTZnhuAUZKJLcTDqAnOhGhTbH7t2HYgu560oHc3D2+l5Cn34+crYZhQFQ
        Cwak6HIDVECaaNRVzEN1HBXHvRwz9zBGQVZpiJP5Ebvv/t5abbG/KGRs2Lh0InESVWPk9wGYg47Us
        DdM/Ux4lqUNnrcuGuo/Tz7GgeYs80wNbXlUzywNEkdE6mkms9v39QHeKHoKVkqJJj6EMkP7EPJ0l+
        vZ0W3pJd7gUXalqLQB4ULw2ydhQp2xEmvF6tlfO4qLLpKizPgdivo/DqLzb3yTj3zah1VUvkM3L/8
        oni4IHig==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTIey-0004fp-Vi; Tue, 28 Apr 2020 05:19:56 +0000
Date:   Mon, 27 Apr 2020 22:19:56 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Satya Tangirala <satyat@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v10 02/12] block: Keyslot Manager for Inline Encryption
Message-ID: <20200428051956.GB24105@infradead.org>
References: <20200408035654.247908-1-satyat@google.com>
 <20200408035654.247908-3-satyat@google.com>
 <20200422092250.GA12290@infradead.org>
 <20200428021441.GA52406@google.com>
 <20200428024614.GA251491@gmail.com>
 <20200428025708.GB251491@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428025708.GB251491@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 27, 2020 at 07:57:08PM -0700, Eric Biggers wrote:
> Or maybe 'struct blk_ksm_keyslot' should contain a pointer to the
> 'struct blk_crypto_key' rather than a copy of it?  If we did that, then:
> 
> - Each duplicate blk_crypto_key would use its own keyslot and not interfere with
>   any others.
> 
> - blk_crypto_evict_key() would be *required* to be called.
> 
> - It would be a kernel bug if blk_crypto_evict_key() were called with any
>   pending I/O, so WARN_ON_ONCE() would be the right thing to do.
> 
> - The hash function used to find a key's keyslot would be
>   hash_ptr(blk_crypto_key, ksm->log_slot_hashtable_size) instead of
>   SipHash(key=perboot_key, data=raw_key).
>   
> I might be forgetting something; was there a reason we didn't do that?
> It wouldn't be as robust against users forgetting to call
> blk_crypto_evict_key(), but that would be a bug anyway.

The above sounds pretty sensible to me (but I'm everything but an expert
in the area).
