Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67BE1D7F2B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 May 2020 18:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgERQuq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 12:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgERQup (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 12:50:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7874C061A0C;
        Mon, 18 May 2020 09:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kZ1kt/vvSWLV22qkWN7aKlxZz7wcX+WgFj2oUslFSoQ=; b=j3ozo5YHhZD8k6To6Kx6JYBtFf
        3ro7WFhgIcFxk9sM8YyXJMP1ljUysW3CEYKqKWLP2qaP1VCDz6hG1+RO2o48RMHX57B2pgMWsTRHm
        6qBznsPTqj9W41MCa36Vj34K2scnpByyAH9hk4n4QgEXgqPsfPMqKctkdvqZ7CGVT9Kiu7m2eG0Xg
        Z2S552l1JSMN6/ihF5mjDfESDw9j42b5Dk/ljZbE4GQkDocvWkFANRe792+jf+a62b7+a2MOwkY6h
        9rT/3ag8Svxuei5DS+/8LTm1jF4aabP4NRraZDwyB4/0lNAIu6kjG/Hr6ujWcERiWB5IZCd5yGJ4J
        yiJHceqg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jaiyS-0000NI-EH; Mon, 18 May 2020 16:50:44 +0000
Date:   Mon, 18 May 2020 09:50:44 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Satya Tangirala <satyat@google.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v13 00/12] Inline Encryption Support
Message-ID: <20200518165044.GA23230@infradead.org>
References: <20200514003727.69001-1-satyat@google.com>
 <20200514051053.GA14829@sol.localdomain>
 <8fa1aafe-1725-e586-ede3-a3273e674470@kernel.dk>
 <20200515074127.GA13926@infradead.org>
 <20200515122540.GA143740@google.com>
 <20200515144224.GA12040@infradead.org>
 <20200515170059.GA1009@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515170059.GA1009@sol.localdomain>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 15, 2020 at 10:00:59AM -0700, Eric Biggers wrote:
> The fallback is actually really useful.  First, for testing: it allows all the
> filesystem code that uses inline crypto to be tested using gce-xfstests and
> kvm-xfstests, so that it's covered by the usual ext4 and f2fs regression testing
> and it's much easier to develop patches for.  It also allowed us to enable the
> inlinecrypt mount option in Cuttlefish, which is the virtual Android device used
> to test the Android common kernels.  So, it gets the kernel test platform as
> similar to a real Android device as possible.
> 
> Ideally we'd implement virtualized inline encryption as you suggested.  But
> these platforms use a mix of VMM's (QEMU, GCE, and crosvm) and storage types
> (virtio-blk, virtio-scsi, and maybe others; none of these even have an inline
> encryption standard defined yet).  So it's not currently feasible.

Not that you don't need to implement it in the hypervisor.  You can
also trivially wire up for things like null_blk.

> Second, it creates a clean design where users can just use blk-crypto, and not
> have to implement a second encryption implementation.

And I very much disagree about that being a clean implementation.  It is
fine if the user doesn't care, but you should catch this before hitting
the block stack and do the encryption there without hardware blk-crypt
support.
