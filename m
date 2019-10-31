Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 454F2EB678
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2019 18:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbfJaR5N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Oct 2019 13:57:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46678 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfJaR5N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Oct 2019 13:57:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NThx6lFDqYVUr8TtZn2As6WtB1ixtvpCPRZvtqpGcXA=; b=ADMS9XgHFzJN0W1JfbZOHcYuL
        WiwTGHuVjC1n+3eMJNmhdIbz8gFKURJs9caDViGVRC0/LRLSAewysAzmbCbE857kBBaMHhzx169aJ
        qLVbcdRAhHa1rcpAp2ewHvzqCXabKXLwgyfrepFLq8VTTAOhE3m0T46SK5oR8Y2o0CAsSqIO/2BKU
        wiY6jiotsGlPpJggeBS9wju445XW8VNja6QIoyRCk6tTnhevhPK2D8XaO8haqs3725gL36ew0vYi2
        E3bM9R3Kj6G1dgV7xgy5Q7/X8GJyzzRhn6qgsq0jtC7RZv9o44Wvk4792saRO1BMlwMJzslEYo12K
        o7wccmCzg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iQEh7-0007t1-1b; Thu, 31 Oct 2019 17:57:13 +0000
Date:   Thu, 31 Oct 2019 10:57:13 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v5 3/9] block: blk-crypto for Inline Encryption
Message-ID: <20191031175713.GA23601@infradead.org>
References: <20191028072032.6911-1-satyat@google.com>
 <20191028072032.6911-4-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028072032.6911-4-satyat@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 28, 2019 at 12:20:26AM -0700, Satya Tangirala wrote:
> We introduce blk-crypto, which manages programming keyslots for struct
> bios. With blk-crypto, filesystems only need to call bio_crypt_set_ctx with
> the encryption key, algorithm and data_unit_num; they don't have to worry
> about getting a keyslot for each encryption context, as blk-crypto handles
> that. Blk-crypto also makes it possible for layered devices like device
> mapper to make use of inline encryption hardware.
> 
> Blk-crypto delegates crypto operations to inline encryption hardware when
> available, and also contains a software fallback to the kernel crypto API.
> For more details, refer to Documentation/block/inline-encryption.rst.

Can you explain why we need this software fallback that basically just
duplicates logic already in fscrypt?  As far as I can tell this fallback
logic actually is more code than the actual inline encryption, and nasty
code at that, e.g. the whole crypt_iter thing.
