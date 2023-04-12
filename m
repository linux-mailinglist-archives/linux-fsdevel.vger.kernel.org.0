Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05E36DF3FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Apr 2023 13:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjDLLoL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Apr 2023 07:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjDLLoK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:44:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2600F1726;
        Wed, 12 Apr 2023 04:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zuZMIQCS0LHbO7voMgTqb3Zs+sNbCvDT8BF+XruU1yg=; b=ApQPbn1hKC04z+1uKyJvjE19nm
        mlUchr6cLiZ9MCP7pyQY2V3E9lNZ0zSvNd4L7johFUzQHeUpjbNxXoQSxCIKHHsqmbSlxxmOLTGeQ
        +QUYT0AzW4GM78faXomy2hMTWdy4nALiyQuVltujv199dX09R07anzuuGhyxkDsPbGQDR1WtLfPqA
        LaJfOwDu1A7kcWgRE2G6AiVjRAePkDxFJ0E/ScoIoQBU29M5SGu0RMh9+qcs3UPge6i7KKOlA93cy
        76zzpUSgcBIcXfyjkcMpfRDRvcXba7KO62Q8R+1x+mVoEehnuDjdbV/aoBa1Bdgq5EEi4MoUhXueL
        KIQu/bCw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pmYtL-002vUm-00;
        Wed, 12 Apr 2023 11:43:59 +0000
Date:   Wed, 12 Apr 2023 04:43:58 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>
Subject: Re: [RFCv2 5/8] ext2: Move direct-io to use iomap
Message-ID: <ZDaZfuq+wi5KKRfs@infradead.org>
References: <ZDT0JFmwg/9ijdcv@infradead.org>
 <87wn2izbpn.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wn2izbpn.fsf@doe.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 11, 2023 at 08:51:24PM +0530, Ritesh Harjani wrote:
> >> +	if ((flags & IOMAP_WRITE) && (offset + length > i_size_read(inode)))
> >
> > No need for the second set of inner braces here either.
> 
> It's just avoids any confusion this way.

Does it?  Except for some really weird places it is very unusual in
the kernel.  To me it really does add confusion.
