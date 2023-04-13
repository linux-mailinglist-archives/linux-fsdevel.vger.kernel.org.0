Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5F86E0A9F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Apr 2023 11:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjDMJwS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 05:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjDMJwQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:52:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F65293FE;
        Thu, 13 Apr 2023 02:52:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 448AC63AD4;
        Thu, 13 Apr 2023 09:52:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF22C433EF;
        Thu, 13 Apr 2023 09:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681379527;
        bh=tOciDCp8qi8DHPLg2Ate0CMyTYDMlL8JRb3MMdcifxI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dJ4W4Ln0REqvIdNrpovgLlnuk9oU7FpEW+l215+FxemvQCDTCDt0P1IAtJkP079HW
         RpWSPVZLFXztDQmqHoAUVkkFdMbF13Uz5VCLBNgLY3V58BzIVnzv0HXLNKb94Ok/Nn
         eZyVT9IU7ZVIFcO4+9rplOiGO9VYNo07Zci20JC7byCCqijpXc2nBiowc2rnP2UUjh
         gdEw7wIbkmNp29YuwQndSHIY99YKj4Ld4RGSswaQ7LT6pTsgOec5ekfGblU6bsWni1
         osdFq+a+q6rHBX2U20sIBhVjZb9uxxR44NPQjH/y4pq7CpFLwfCuMw1jqTTyHQFly5
         h8ewOnUYYkTeQ==
Date:   Thu, 13 Apr 2023 11:51:59 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>
Subject: Re: [RFCv2 2/8] libfs: Add __generic_file_fsync_nolock implementation
Message-ID: <20230413-gewichen-ziehung-3ced0ad0982b@brauner>
References: <cover.1681188927.git.ritesh.list@gmail.com>
 <6fad2ec25bccbbb9b3effbd18c2d6d6965b9a33c.1681188927.git.ritesh.list@gmail.com>
 <ZDTvrmFR1/nXUqMl@infradead.org>
 <ZDVTjX/ZtJZWkHyD@casper.infradead.org>
 <ZDaZR+zHcpUyNOND@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZDaZR+zHcpUyNOND@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 12, 2023 at 04:43:03AM -0700, Christoph Hellwig wrote:
> On Tue, Apr 11, 2023 at 01:33:17PM +0100, Matthew Wilcox wrote:
> > On Mon, Apr 10, 2023 at 10:27:10PM -0700, Christoph Hellwig wrote:
> > > On Tue, Apr 11, 2023 at 10:51:50AM +0530, Ritesh Harjani (IBM) wrote:
> > > > +/**
> > > > + * __generic_file_fsync_nolock - generic fsync implementation for simple
> > > > + * filesystems with no inode lock
> > > 
> > > No reallz need for the __ prefix in the name.
> > 
> > It kind of makes sense though.
> > 
> > generic_file_fsync does the flush
> > __generic_file_fsync doesn't do the flush
> > __generic_file_fsync_nolock doesn't do the flush and doesn't lock/unlock
> 
> Indeed.  Part of it is that the naming is a bit horrible.
> Maybe it should move to buffer.c and be called generic_buffer_fsync,
> or generic_block_fsync which still wouldn't be perfect but match the
> buffer.c naming scheme.
> 
> > 
> > > > +extern int __generic_file_fsync_nolock(struct file *, loff_t, loff_t, int);
> > > 
> > > No need for the extern.  And at least I personally prefer to spell out
> > > the parameter names to make the prototype much more readable.
> > 
> > Agreed, although I make an exception for the 'struct file *'.  Naming that
> > parameter adds no value, but a plain int is just obscene.
> > 
> > int __generic_file_fsync_nolock(struct file *, loff_t start, loff_t end,
> > 		bool datasync);
> 
> While I agree that it's not needed for the file, leaving it out is a bit
> silly.

I think we should just be consistent and try to enforce that the
parameter name is added in new patches. It's often easier for grepping
and there's really not a lot of value in leaving it out in general.
