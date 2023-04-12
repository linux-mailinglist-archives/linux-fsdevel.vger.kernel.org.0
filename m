Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9D96DF3F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Apr 2023 13:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjDLLn1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Apr 2023 07:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjDLLnW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:43:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6F11A2;
        Wed, 12 Apr 2023 04:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4RDlPZj6huWQXf9wPO/8vbSDC05lQlt4BDA+orp3WvQ=; b=4rqqYiKp1rLMovByAJ2i1MjUMe
        ibOx+uLL7mmqLmrkuiiqoy7wrqH7DJUq/X10wu1BgKRNFq2b0nLjl5zKMV5UG3CwhmpkF+qpdZzyW
        QIn88UxNVdzA0d1DqkeyfMtPsctBaFrxH9+TsmY+diXuTi7kT7lANxEBbL0liHML+xQNxtBlOdNza
        QZ1j5NHGmoya2Mz885ynLaM8GSxwfMTzR7squgmI+DnibVUtdQ1ia0HQ2QN0bCV5zPPMkGTy/lJow
        xft6750JrQaam/4gZmKny5R0c1phSzxjJa8BpSHMS7iSbHL9zxlFb3aJm5bz72rv1sgQLjR5Vzin4
        ZJSk5Srg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pmYsR-002vMZ-0A;
        Wed, 12 Apr 2023 11:43:03 +0000
Date:   Wed, 12 Apr 2023 04:43:03 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>
Subject: Re: [RFCv2 2/8] libfs: Add __generic_file_fsync_nolock implementation
Message-ID: <ZDaZR+zHcpUyNOND@infradead.org>
References: <cover.1681188927.git.ritesh.list@gmail.com>
 <6fad2ec25bccbbb9b3effbd18c2d6d6965b9a33c.1681188927.git.ritesh.list@gmail.com>
 <ZDTvrmFR1/nXUqMl@infradead.org>
 <ZDVTjX/ZtJZWkHyD@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDVTjX/ZtJZWkHyD@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 11, 2023 at 01:33:17PM +0100, Matthew Wilcox wrote:
> On Mon, Apr 10, 2023 at 10:27:10PM -0700, Christoph Hellwig wrote:
> > On Tue, Apr 11, 2023 at 10:51:50AM +0530, Ritesh Harjani (IBM) wrote:
> > > +/**
> > > + * __generic_file_fsync_nolock - generic fsync implementation for simple
> > > + * filesystems with no inode lock
> > 
> > No reallz need for the __ prefix in the name.
> 
> It kind of makes sense though.
> 
> generic_file_fsync does the flush
> __generic_file_fsync doesn't do the flush
> __generic_file_fsync_nolock doesn't do the flush and doesn't lock/unlock

Indeed.  Part of it is that the naming is a bit horrible.
Maybe it should move to buffer.c and be called generic_buffer_fsync,
or generic_block_fsync which still wouldn't be perfect but match the
buffer.c naming scheme.

> 
> > > +extern int __generic_file_fsync_nolock(struct file *, loff_t, loff_t, int);
> > 
> > No need for the extern.  And at least I personally prefer to spell out
> > the parameter names to make the prototype much more readable.
> 
> Agreed, although I make an exception for the 'struct file *'.  Naming that
> parameter adds no value, but a plain int is just obscene.
> 
> int __generic_file_fsync_nolock(struct file *, loff_t start, loff_t end,
> 		bool datasync);

While I agree that it's not needed for the file, leaving it out is a bit
silly.

> (yes, the other variants don't use a bool for datasync, but they should)

.. including the ->fsync prototype to make it work ..
