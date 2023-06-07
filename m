Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAA07254CC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 08:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238229AbjFGGxF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 02:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238219AbjFGGxD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:53:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196E81723;
        Tue,  6 Jun 2023 23:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qdfYIYojVcYjNoXK/W1a91XwzBREbIikTjBv4ES81yk=; b=ULIXIkLz6iT/AZXBI87i7wLXqf
        u5bg/xZbJt2vD+K2O4H8e0tzNu3Ton+SsXwn91dcq0Cnj1OpYWMV11QGS6vAOyzHTCtYACrxMTgz3
        9JKmTi8l1Q1VW8QcEOWMQtpfTToJalR6+Wn83Xh4g/wK4kjJHf9U7DtDAUh2kkQyksMfwwtz31cyX
        DieGRkbUTTIzqycLVbFQoVOV3htqwnG4szmOVX+vNiLTt5rfu1nAtNDju0i2o9K+sHbnzm66kDtSG
        sF1gFaCSmyUzFAQZpdBVjnr2DrtKlrgcCQZEj9HQQ9Ao4kUcTMvfXXXpPreAk2g/abq5N7dRmQqU7
        iEPYdrLA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q6n2S-004d3w-2s;
        Wed, 07 Jun 2023 06:53:00 +0000
Date:   Tue, 6 Jun 2023 23:53:00 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCHv8 4/5] iomap: Allocate iof in ->write_begin() early
Message-ID: <ZIApTPe8JaYmOnVp@infradead.org>
References: <cover.1686050333.git.ritesh.list@gmail.com>
 <1161fe2bb007361ae47d509e588e7f5b3b819208.1686050333.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161fe2bb007361ae47d509e588e7f5b3b819208.1686050333.git.ritesh.list@gmail.com>
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

On Tue, Jun 06, 2023 at 05:13:51PM +0530, Ritesh Harjani (IBM) wrote:
> We dont need to allocate an iof in ->write_begin() for writes where the
> position and length completely overlap with the given folio.
> Therefore, such cases are skipped.
> 
> Currently when the folio is uptodate, we only allocate iof at writeback
> time (in iomap_writepage_map()). This is ok until now, but when we are
> going to add support for per-block dirty state bitmap in iof, this
> could cause some performance degradation. The reason is that if we don't
> allocate iof during ->write_begin(), then we will never mark the
> necessary dirty bits in ->write_end() call. And we will have to mark all
> the bits as dirty at the writeback time, that could cause the same write
> amplification and performance problems as it is now.
> 
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

(and didn't I ack an earlier of this already?)
