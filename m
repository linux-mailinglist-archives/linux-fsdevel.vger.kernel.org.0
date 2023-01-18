Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929F8672C72
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 00:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjARXUH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 18:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjARXUG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:20:06 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC2245BD1;
        Wed, 18 Jan 2023 15:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1039+na1jtUCCImib6KJo2m62bE4SKXqFGgEyWsLhuM=; b=comCfaRwU8zOMXcvUvqjwcgqnA
        HvDAo4bfYzXJYdqk2UqRRsufTJ27ij7MlN99BHXJIatxI++hkDpXh9PB14qFC/ZZsaiVZPcjQ+3Bc
        m/kfrVgxu2u4a4TUpkj21SFGK7b8xkQVkHaMa1Eh8tZkA6NZgI9+xHm+JE/xepiUJdzj9FxoDZRRI
        N6DvQ5L2Icvt7TPqztnMEmxIyRbrtm5muumgaFfFbwrCpffCBKDj1E2y3WQU3vlUS33Mr8Ze3XMTZ
        foxnucTpFLF5sb4BDZjBQBWnkS0mh8j/nDwjGzUmCgiPH/6FTfCTLIH62HmV+isFFZvzoS8BDBut4
        1f8L3fMg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pIHin-002dUU-0P;
        Wed, 18 Jan 2023 23:19:57 +0000
Date:   Wed, 18 Jan 2023 23:19:57 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 05/34] iov_iter: Change the direction macros into an
 enum
Message-ID: <Y8h+naEJmlxIjyh1@ZenIV>
References: <Y8h9Q9fyUGBFsiMj@ZenIV>
 <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
 <167391051810.2311931.8545361041888737395.stgit@warthog.procyon.org.uk>
 <2704044.1674083861@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2704044.1674083861@warthog.procyon.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 18, 2023 at 11:17:41PM +0000, David Howells wrote:
> Al Viro <viro@zeniv.linux.org.uk> wrote:
> 
> > > Change the ITER_SOURCE and ITER_DEST direction macros into an enum and
> > > provide three new helper functions:
> > > 
> > >  iov_iter_dir() - returns the iterator direction
> > >  iov_iter_is_dest() - returns true if it's an ITER_DEST iterator
> > >  iov_iter_is_source() - returns true if it's an ITER_SOURCE iterator
> > 
> > What for?  We have two valid values -
> > 	1) it is a data source
> > 	2) it is not a data source
> > Why do we need to store that as an enum?
> 
> Compile time type checking.

Huh?  int-to-enum conversion is quiet; it would catch explicit
huge constants, but that's it...
