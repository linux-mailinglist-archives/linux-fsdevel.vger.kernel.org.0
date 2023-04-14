Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2049C6E2408
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 15:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjDNNMF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 09:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjDNNME (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 09:12:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793673A9C;
        Fri, 14 Apr 2023 06:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LL1q5+2/qoyTMAi0m5Inbcnk8ARxhmQA/eDmbuGrVFI=; b=Kh6UZuqbs5BYZHX/qXCrMWvBed
        sJUUix+JdjmyxKIEMeJJtEqqZgKn8yyQULC6IyHM46/A2tyZ6xZJmpmn0RK+tr5XQ+tBkknUMz6Rl
        p2VklbLcmZqQh5lqGXnQER9H/UtNUWCyo5itilat+q+I40osSQMULhltAr7xwqSL9sssNjHljay86
        HNZArBFFZTEuoIJ4Oqj1FBvOOsOJ3wphSEgn4DWTi6FibfUTG1r3bN1o58zgJ7EseaJNEAtERayoj
        Dhbi/isUG25Pm1jO3oSXXnCHeGtwr741SJfWpfZSQGyP5toHjMjdx/MdRmovRpqNYdkyefMjJfFjk
        k5s7BE3w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pnJDc-009eNP-38;
        Fri, 14 Apr 2023 13:12:00 +0000
Date:   Fri, 14 Apr 2023 06:12:00 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [RFCv3 02/10] libfs: Add __generic_file_fsync_nolock
 implementation
Message-ID: <ZDlRIEiEm+CRDJxG@infradead.org>
References: <cover.1681365596.git.ritesh.list@gmail.com>
 <e65768eb0fe145c803ba4afdc869a1757d51d758.1681365596.git.ritesh.list@gmail.com>
 <ZDjrvCbCwxN+mRUS@infradead.org>
 <20230414125148.du7r6ljdyzckoysh@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414125148.du7r6ljdyzckoysh@quack3>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 14, 2023 at 02:51:48PM +0200, Jan Kara wrote:
> On Thu 13-04-23 22:59:24, Christoph Hellwig wrote:
> > Still no fan of the naming and placement here.  This is specific
> > to the fs/buffer.c infrastructure.
> 
> I'm fine with moving generic_file_fsync() & friends to fs/buffer.c and
> creating the new function there if it makes you happier. But I think
> function names should be consistent (hence the new function would be named
> __generic_file_fsync_nolock()). I agree the name is not ideal and would use
> cleanup (along with transitioning everybody to not take i_rwsem) but I
> don't want to complicate this series by touching 13+ callsites of
> generic_file_fsync() and __generic_file_fsync(). That's for a separate
> series.

I would not change the existing function.  Just do the right thing for
the new helper and slowly migrate over without complicating this series.
