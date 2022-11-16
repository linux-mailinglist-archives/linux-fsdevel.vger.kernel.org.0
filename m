Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B239462C3B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 17:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbiKPQOi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 11:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234122AbiKPQO2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:14:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2A8120B1;
        Wed, 16 Nov 2022 08:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GW/mPvUNa8ycmt36mg7tsVRrtOyrpDhOFXMAIJPJkOE=; b=fv/z8Vq6c3nCHc9j56W7inAPrc
        0dHcgJhI7otNJASZ17MhPMVxlFeyoYf4kkWas5Eo1Ec3GLZ11u690qlx7P/v7oNDWAqAIH8H8yfAD
        /1+ntBb76BGes/DskjfMzwy5tnJE3PtJshRQjDhtJe3GdRxa3iYgGlrg4SgbIsOz1xLUVMP3prz4Y
        CYEDn4nLle2PKtPXe6tjYaTxXNTKPX+uOVZ0Q2NsIXk+iTVqbBXGxNbargAbd+zNmaZW4alJOF63V
        hcY8gOY7GqI+y48QsSAg6GKHAhI6xNQtvE8qNC021YrYrfXYgoK0+mLFPHkKrKnIUnGGe6t1rneei
        zCHLsFCw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovL3H-005l8R-B4; Wed, 16 Nov 2022 16:14:15 +0000
Date:   Wed, 16 Nov 2022 08:14:15 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Jan Kara <jack@suse.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Dave Kleikamp <shaggy@kernel.org>,
        Bob Copeland <me@bobcopeland.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net,
        linux-karma-devel@lists.sourceforge.net, linux-mm@kvack.org
Subject: Re: [PATCH 2/9] ext2: remove ->writepage
Message-ID: <Y3UMV2mB5BkMM5PY@infradead.org>
References: <20221113162902.883850-1-hch@lst.de>
 <20221113162902.883850-3-hch@lst.de>
 <20221114104927.k5x4i4uanxskfs6m@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114104927.k5x4i4uanxskfs6m@quack3>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 14, 2022 at 11:49:27AM +0100, Jan Kara wrote:
> On Sun 13-11-22 17:28:55, Christoph Hellwig wrote:
> > ->writepage is a very inefficient method to write back data, and only
> > used through write_cache_pages or a a fallback when no ->migrate_folio
> > method is present.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Looks good! Feel free to add:

The testbot found a problem with this:

ext2_commit_chunk calls write_one_page for the IS_DIRSYNC case,
and write_one_page calls ->writepage.

So I think I need to drop this one for now (none of the other
file systems calls write_one_page).  And then think what best
to do about write_one_page/write_one_folio.  I suspect just
passing a writepage pointer to them might make most sense,
as they are only used by a few file systems, and the calling
convention with the locked page doesn't lend itself to using
->writepages.
