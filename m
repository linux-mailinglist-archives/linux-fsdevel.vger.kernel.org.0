Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956B8730133
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 16:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245392AbjFNOHi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 10:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245366AbjFNOHe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:07:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB713172E;
        Wed, 14 Jun 2023 07:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7zKVnjvzit87w4LvMJMfhzArUJCjxSyS9z+9JMuufv0=; b=tEAtQCHhfR4Vb3SCSgPJ0NazMr
        isWCiYg7499DEFizrwQiervPnffzp/TurF1vFQCf0XGRCc0yT6KucKJdx7pNy093snkYZxYFo1kOl
        WBdEHOihJKfaEA3PrmEFokNco80EXoNE6C4Gey9Vctt/U6iVvaM5X3bE1hWwV6coGWAx8nNWZLG3d
        FARfb2/mVfruNpVGZ9s54BUq8BNfgXC/tzbVoYvJQTWzBussVf7prhn0fcW85KCSJbcm0Oc4wmdRD
        CRfOsZ7lqiWHsmVTInHiN7qreFJAjBZyjO4//29ctzD4K2VHCv64Iu2vQHlFtwbmWYwK83cEM8n8I
        QyAy5xzw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q9R9Y-00BrUL-2D;
        Wed, 14 Jun 2023 14:07:16 +0000
Date:   Wed, 14 Jun 2023 07:07:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>, axboe@kernel.dk,
        corbet@lwn.net, snitzer@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, dchinner@redhat.com, willy@infradead.org,
        dlemoal@kernel.org, linux@weissschuh.net, jack@suse.cz,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Donald Buczek <buczek@molgen.mpg.de>
Subject: Re: [PATCH v5 04/11] blksnap: header file of the module interface
Message-ID: <ZInJlD70tMKoBi7T@infradead.org>
References: <20230612135228.10702-1-sergei.shtepa@veeam.com>
 <20230612135228.10702-5-sergei.shtepa@veeam.com>
 <ZIjsywOtHM5nIhSr@dread.disaster.area>
 <ZIldkb1pwhNsSlfl@infradead.org>
 <733f591e-0e8f-8668-8298-ddb11a74df81@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <733f591e-0e8f-8668-8298-ddb11a74df81@veeam.com>
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

On Wed, Jun 14, 2023 at 11:26:20AM +0200, Sergei Shtepa wrote:
> This code worked quite successfully for the veeamsnap module, on the
> basis of which blksnap was created. Indeed, such an allocation of an
> area on a block device using a file does not look safe.
> 
> We've already discussed this with Donald Buczek <buczek@molgen.mpg.de>.
> Link: https://github.com/veeam/blksnap/issues/57#issuecomment-1576569075
> And I have planned work on moving to a more secure ioctl in the future.
> Link: https://github.com/veeam/blksnap/issues/61
> 
> Now, thanks to Dave, it becomes clear to me how to solve this problem best.
> swapfile is a good example of how to do it right.

I don't actually think swapfile is a very good idea, in fact the Linux
swap code in general is not a very good place to look for inspirations
:)

IFF the usage is always to have a whole file for the diff storage the
over all API is very simple - just pass a fd to the kernel for the area,
and then use in-kernel direct I/O on it.  Now if that file should also
be able to reside on the same file system that the snapshot is taken
of things get a little more complicated, because writes to it also need
to automatically set the BIO_REFFED flag.  I have some ideas for that
and will share some draft code with you.
