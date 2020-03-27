Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66E61195CAC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Mar 2020 18:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbgC0R05 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Mar 2020 13:26:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55348 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgC0R05 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Mar 2020 13:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CjcexspCrEuAGvO/hySleT/JU2sq71KS3q2QXnc5p8k=; b=s0MISWrHoKtRwUiDDKoOpy+cBM
        UI66O9jDN+K1Pjn0DCksBQSOtqomHyRVCS4z1M4GoTjuP7l9SSs88IP+HV4F+q0LQu7DsLr8gJyIH
        smKoZNCOufJJX6TiPiEU2TiN4R5gJ7aO4j5itcb7oh+1H25wTEBI+pr8pNYVmRuRLvtLhIr+1eqCd
        D9+3om3smbm6qf20LF6u+slEbXBq5v4S+3MqG3NX98olku3ePe/JPlhQl+5PH1bdm+r5zmZh4nA7d
        TmXkZv+j9L5vxXXPcJpv1gAklEedGOLWfyZX17KjF60m0W8/gCqd9KPHIDRNfzBYsL1aCnQajVRX+
        4zWWVuFg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHsky-0007P2-H7; Fri, 27 Mar 2020 17:26:56 +0000
Date:   Fri, 27 Mar 2020 10:26:56 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 08/10] null_blk: Support REQ_OP_ZONE_APPEND
Message-ID: <20200327172656.GB21347@infradead.org>
References: <20200327165012.34443-1-johannes.thumshirn@wdc.com>
 <20200327165012.34443-9-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327165012.34443-9-johannes.thumshirn@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 28, 2020 at 01:50:10AM +0900, Johannes Thumshirn wrote:
> From: Damien Le Moal <damien.lemoal@wdc.com>
> 
> Support REQ_OP_ZONE_APPEND requests for zone mode null_blk devices.
> Use the internally tracked zone write pointer position as the actual
> write position, which is returned using the command request __sector
> field in the case of an mq device and using the command BIO sector in
> the case of a BIO device. Since the write position is used for data copy
> in the case of a memory backed device, reverse the order in which
> null_handle_zoned() and null_handle_memory_backed() are called to ensure
> that null_handle_memory_backed() sees the correct write position for
> REQ_OP_ZONE_APPEND operations.

I think moving null_zone_write earlier actually is a bug-fixd as is
as we should not touch memory if the zone condition or write pointer
isn't valid for a write.  I'd suggest splitting that out as a bug fix
and move it to the start of the series so that Jens can pick it up
ASAP.

Otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
