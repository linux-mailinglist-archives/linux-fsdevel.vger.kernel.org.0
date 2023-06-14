Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8B372F4BF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 08:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243115AbjFNG0r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 02:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242281AbjFNG0o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 02:26:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B9E199;
        Tue, 13 Jun 2023 23:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GAL8rYu1Idr0YOdnXNBIthABV/YsGkUhTmU/DBbzch8=; b=tvDzinqkrdr5HsvTJrFz63M6uM
        s38FyrvASnhlz58s1iCWQyO4ieh+ddqTrlYffk6YGHFCs1y5BsV1s6RdMFczPVMHrvHhofzB6IsA6
        9hmJKz9Rz36FWYHj+a2EUqh/4KB/Xs1HARqfQZiC1PdmZAXLFwAB8tm59uVn+zNjVHLeLjvGzS5qq
        almeyKHsarLuYOZzQKgNcw84/3bgIoydHoBeHOnrhd/OlHNFclDqtRGIJMsZR9JOP26ppFL8ZywOc
        abpa3Ut6d7aZ2ydfYcdZSPsE0uXeonEwBnNGTID5qoVkjc2eIcbGjStZZRhS1DBkfHLemIWiyNw3G
        JLkP8r4w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q9JxZ-00AQvZ-0a;
        Wed, 14 Jun 2023 06:26:25 +0000
Date:   Tue, 13 Jun 2023 23:26:25 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Sergei Shtepa <sergei.shtepa@veeam.com>, axboe@kernel.dk,
        hch@infradead.org, corbet@lwn.net, snitzer@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        willy@infradead.org, dlemoal@kernel.org, linux@weissschuh.net,
        jack@suse.cz, ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Donald Buczek <buczek@molgen.mpg.de>
Subject: Re: [PATCH v5 04/11] blksnap: header file of the module interface
Message-ID: <ZIldkb1pwhNsSlfl@infradead.org>
References: <20230612135228.10702-1-sergei.shtepa@veeam.com>
 <20230612135228.10702-5-sergei.shtepa@veeam.com>
 <ZIjsywOtHM5nIhSr@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIjsywOtHM5nIhSr@dread.disaster.area>
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

On Wed, Jun 14, 2023 at 08:25:15AM +1000, Dave Chinner wrote:
> > + * Return: 0 if succeeded, negative errno otherwise.
> > + */
> > +#define IOCTL_BLKSNAP_SNAPSHOT_APPEND_STORAGE					\
> > +	_IOW(BLKSNAP, blksnap_ioctl_snapshot_append_storage,			\
> > +	     struct blksnap_snapshot_append_storage)
> 
> That's an API I'm extremely uncomfortable with. We've learnt the
> lesson *many times* that userspace physical mappings of underlying
> file storage are unreliable.
> 
> i.e.  This is reliant on userspace telling the kernel the physical
> mapping of the filesystem file to block device LBA space and then
> providing a guarantee (somehow) that the mapping will always remain
> unchanged. i.e. It's reliant on passing FIEMAP data from the
> filesystem to userspace and then back into the kernel without it
> becoming stale and somehow providing a guarantee that nothing (not
> even the filesystem doing internal garbage collection) will change
> it.

Hmm, I never thought of this API as used on files that somewhere
had a logical to physical mapping applied to them.

Sergey, is that the indtended use case?  If so we really should
be going through the file system using direct I/O.

