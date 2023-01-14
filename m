Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CB366A87C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jan 2023 02:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjANB7J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 20:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbjANB7D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 20:59:03 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79038BF22;
        Fri, 13 Jan 2023 17:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0Pch1iBSVz8G2YPFpmLPOf5HGOsU4koEPM8DeuS1iMg=; b=UhBaYATi8IehORYPIY4qgjJCXu
        0+nCD0LPdd9/yWS1hebEZHlpz+0cl8i8P0pwXkRguJyHSBR5m5JQlSgPVsBD8Z7aLwYTB04/hwQ7T
        Ewb9k7ggNAfDJIahAMrzRfThZ5fOxkhsF6dDoTbcOhx4dZ9nNXl7LpGdvbDQGJbsErnuqRvqaYyvj
        uJftPkXCBmRTx2YHjXSLRQoFYsHG6SEraiSqYBXveF+eTzxbAYRV6wV8YRAUNwjJD+WMwPF1MFuEm
        VzIRytohdr2xeG96TZNbF8xDfzJLNPmHucXjKH3HTkqylW8dpE/zdJ+pdJ+eYG2hVHmQEIsr0OkzI
        6OXZpzew==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pGVoV-001llh-1A;
        Sat, 14 Jan 2023 01:58:31 +0000
Date:   Sat, 14 Jan 2023 01:58:31 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Bart Van Assche <bart.vanassche@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Gilbert <dgilbert@interlog.com>
Subject: Re: [PATCH v5 3/9] iov_iter: Use IOCB/IOMAP_WRITE if available
 rather than iterator direction
Message-ID: <Y8IMR8BK3bLnr9ps@ZenIV>
References: <Y7+8r1IYQS3sbbVz@infradead.org>
 <167344725490.2425628.13771289553670112965.stgit@warthog.procyon.org.uk>
 <167344727810.2425628.4715663653893036683.stgit@warthog.procyon.org.uk>
 <15330.1673519461@warthog.procyon.org.uk>
 <Y8AUTlRibL+pGDJN@infradead.org>
 <Y8BFVgdGYNQqK3sB@ZenIV>
 <c6f4014e-d199-d5e8-515c-5ffcd9946c80@gmail.com>
 <yq1ilh9ucg3.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1ilh9ucg3.fsf@ca-mkp.ca.oracle.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 13, 2023 at 08:34:50PM -0500, Martin K. Petersen wrote:
> 
> Bart,
> 
> > I'm not sure that we still need the double copy in the sg driver. It
> > seems obscure to me that there is user space software that relies on
> > finding "0xec" in bytes not originating from a SCSI
> > device. Additionally, SCSI drivers that do not support residuals
> > should be something from the past.
> 
> Yeah. I'm not aware of anything that relies on this still. But obviously
> Doug has more experience in the app dependency department.

Are we guaranteed to know the accurate amount of data that got transferred
for all surviving drivers?  If we do, we can do accurate copy-out and all
apps will keep seeing what they currently do.  If we don't, the best we
can do is replacing copy-in + IO + copy-out with memset + IO + copy-out.
