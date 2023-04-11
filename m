Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85E36DDAE9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 14:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjDKMdY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 08:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjDKMdX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 08:33:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6952A2D6B;
        Tue, 11 Apr 2023 05:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=G1Acalzr88ZqqPHx98X1fWhGAgT2HLaxE6Li8jbXb70=; b=FlUh03J3Bp75ls7S0aE+bNLgK1
        35UunEpUktNDfNJ+l6h7I2i8a2OQWOdmxIKBSDF+86J4CKMIjD9XZKSkqGk1uHAdr59iDuDVfHh1O
        K4l55jpD7SOq5Z+HYQ9S2pxSwT/sXg2fgZf8mN5bCl1ZjjG/nwEV1hGwUoS+0u5NtzDKW7MRT7vw2
        d6okRJoziYSGx+ICCPYRgK6S6LB0pjdhpBCqMak5I883N1qIdlxgJqYg9ZZC2SDDGAc+b29PUid/T
        AYNXNlhHBg2k5S7XO/vtBMDJvb/VFpmjDzjffpdpgA8/xgqgxF5MsqmwuJz/h3UQQGMaw52k9ltyH
        QcZyukyA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pmDBV-005tl6-F1; Tue, 11 Apr 2023 12:33:17 +0000
Date:   Tue, 11 Apr 2023 13:33:17 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>
Subject: Re: [RFCv2 2/8] libfs: Add __generic_file_fsync_nolock implementation
Message-ID: <ZDVTjX/ZtJZWkHyD@casper.infradead.org>
References: <cover.1681188927.git.ritesh.list@gmail.com>
 <6fad2ec25bccbbb9b3effbd18c2d6d6965b9a33c.1681188927.git.ritesh.list@gmail.com>
 <ZDTvrmFR1/nXUqMl@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDTvrmFR1/nXUqMl@infradead.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 10, 2023 at 10:27:10PM -0700, Christoph Hellwig wrote:
> On Tue, Apr 11, 2023 at 10:51:50AM +0530, Ritesh Harjani (IBM) wrote:
> > +/**
> > + * __generic_file_fsync_nolock - generic fsync implementation for simple
> > + * filesystems with no inode lock
> 
> No reallz need for the __ prefix in the name.

It kind of makes sense though.

generic_file_fsync does the flush
__generic_file_fsync doesn't do the flush
__generic_file_fsync_nolock doesn't do the flush and doesn't lock/unlock

> > +extern int __generic_file_fsync_nolock(struct file *, loff_t, loff_t, int);
> 
> No need for the extern.  And at least I personally prefer to spell out
> the parameter names to make the prototype much more readable.

Agreed, although I make an exception for the 'struct file *'.  Naming that
parameter adds no value, but a plain int is just obscene.

int __generic_file_fsync_nolock(struct file *, loff_t start, loff_t end,
		bool datasync);

(yes, the other variants don't use a bool for datasync, but they should)
