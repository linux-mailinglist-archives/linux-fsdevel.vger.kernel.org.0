Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1CEE7A9D5E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 21:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjIUTba (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 15:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjIUTak (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:30:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9350A241;
        Thu, 21 Sep 2023 12:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pzyLj/te+pJ0atcMca8/O/Us6PqNEkR5Xz0Y5l8NnVg=; b=piInYrEt+X8wmDUC3mgNPb793R
        jZ0VFH+yzLf8eaEMHzbrcWvpyVoX40KpY4tRZiidjcjvcObuvInNIAexDPnyjVDhFFlzpA8A8YIbt
        mUYiA9jkEzEDfLkXLsR22hzdIPxnLWbSY+4D5AYRPtIXaSD9xn3iVahsnbaMfI6k+gGyDQthT1Du2
        zwnsTQqjoba0c1BrWlqRknzw9MuTjFciAvP57R25pWEdRcEPZzIFWR5II8DHJK87Xpq904uL/wf8D
        dSg3g5D+gjNuCP78rFmUe7Exa2TL2oAKTJ0S29NGj/RH5PZ+gGp1Al7zlG6XBRIGrSPlYA5Jkvw2W
        /EhWfKfw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qjPKU-00DghM-7I; Thu, 21 Sep 2023 19:27:14 +0000
Date:   Thu, 21 Sep 2023 20:27:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 00/13] Pass data temperature information to zoned UFS
 devices
Message-ID: <ZQyZEqXJymyFWlKV@casper.infradead.org>
References: <20230920191442.3701673-1-bvanassche@acm.org>
 <ZQtHwsNvS1wYDKfG@casper.infradead.org>
 <1522d8ec-6b15-45d5-b6d9-517337e2c8cf@acm.org>
 <ZQv07Mg7qIXayHlf@x1-carbon>
 <8781636a-57ac-4dbd-8ec6-b49c10c81345@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8781636a-57ac-4dbd-8ec6-b49c10c81345@acm.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 21, 2023 at 07:27:08AM -0700, Bart Van Assche wrote:
> On 9/21/23 00:46, Niklas Cassel wrote:
> > Considering that this API (F_GET_FILE_RW_HINT / F_SET_FILE_RW_HINT) was
> > previously only used by NVMe (NVMe streams).
> 
> That doesn't sound correct to me. I think support for this API was added
> in F2FS in November 2017 (commit 4f0a03d34dd4 ("f2fs: apply write hints
> to select the type of segments for buffered write")). That was a few
> months after NVMe stream support was added (June 2017) by commit
> f5d118406247 ("nvme: add support for streams and directives").
> 
> > Should NVMe streams be brought back? Yes? No?
> 
> From commit 561593a048d7 ("Merge tag 'for-5.18/write-streams-2022-03-18'
> of git://git.kernel.dk/linux-block"): "This removes the write streams
> support in NVMe. No vendor ever really shipped working support for this,
> and they are not interested in supporting it."

It sounds like UFS is at the same stage that NVMe got to -- standard
exists, no vendor has committed to actually shipping it.  Isn't bringing
it back a little premature?
