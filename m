Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D76D72D986
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 07:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240100AbjFMFub (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 01:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240095AbjFMFu1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 01:50:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C5693;
        Mon, 12 Jun 2023 22:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pv13t75OeaLi0Wnedj8EISboR7Hj3/TyA2pQxdDC4e8=; b=hXcSNk2KPdcQyfjrbkKlXoE5A8
        zHE+DOIDMV94Qeo3me/ZgOieikMcg1ilrc+v5wbdLQ9JogD4Tp+qS4GVyG7b8qYngNk7BsRW5aLFb
        tF6rnwSpJ51d2rtfmaVN4nxRoZavhXjKNyyEMaMSFDaeFxlomjvwlAmZFXmPUtZaaAAorhnJBIm+H
        vblo1Smiv8csEcFKVVkhbdxBms8UhjBa35xnir36Rqty6Zt38WM/zYPriU2n5rYkNd6gXeWDW+X9R
        tGgf9hgo8YIeMREAWS7aGdCIMOh/tnWsg+y63di0f0e7kAWjMdnQ7L24EHgCMLczmFIF9jQXwmDb2
        fN0lqz+Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q8wuy-0070IZ-2V;
        Tue, 13 Jun 2023 05:50:12 +0000
Date:   Mon, 12 Jun 2023 22:50:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Sergei Shtepa <sergei.shtepa@veeam.com>, axboe@kernel.dk,
        hch@infradead.org, corbet@lwn.net, snitzer@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        willy@infradead.org, dlemoal@kernel.org, linux@weissschuh.net,
        jack@suse.cz, ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 00/11] blksnap - block devices snapshots module
Message-ID: <ZIgDlA/nMQIMqeLU@infradead.org>
References: <20230612135228.10702-1-sergei.shtepa@veeam.com>
 <20230612161911.GA1200@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612161911.GA1200@sol.localdomain>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 12, 2023 at 09:19:11AM -0700, Eric Biggers wrote:
> On Mon, Jun 12, 2023 at 03:52:17PM +0200, Sergei Shtepa wrote:
> > Hi all.
> > 
> > I am happy to offer a improved version of the Block Devices Snapshots
> > Module. It allows to create non-persistent snapshots of any block devices.
> > The main purpose of such snapshots is to provide backups of block devices.
> > See more in Documentation/block/blksnap.rst.
> 
> How does blksnap interact with blk-crypto?
> 
> I.e., what happens if a bio with a ->bi_crypt_context set is submitted to a
> block device that has blksnap active?
> 
> If you are unfamiliar with blk-crypto, please read
> Documentation/block/inline-encryption.rst
> 
> It looks like blksnap hooks into the block layer directly, via the new
> "blkfilter" mechanism.  I'm concerned that it might ignore ->bi_crypt_context
> and write data to the disk in plaintext, when it is supposed to be encrypted.

Yeah.  Same for integrity.  I guess for now the best would be to
not allow attaching a filter to block devices that have encryption or
integrity enabled and then look into that as a separate project fully
reviewed by the respective experts.

