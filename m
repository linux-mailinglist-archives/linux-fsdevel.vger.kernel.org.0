Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAD2316B368
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 22:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgBXV5o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Feb 2020 16:57:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41384 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbgBXV5n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Feb 2020 16:57:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IhFcixf6xB7flTgkTYeOnbWlEpWZuV6CKSy7ZQez0WI=; b=Xsl1VicGy/cUMy3nKSfLYsp4JQ
        XuauTs+SlYeSgQlRLvumnWjOr2cplAYv962X+iwgIS1cxx+dgzmOltxe84qM829HlpGa7tIVs0rCR
        UHY9vePWsKoMCOJwVPvOJVEDVFCToUF9yNOI+tB8g0de/RYeV2SMFMNQdVuKQtuM7NwbEbskf1eLg
        dUXO0x+mn96sZpwZlnDzQxbegLQ/KMtN7w/7oKgd1oDm9ELzK0l9J7YruyW3Oz774Ix0HS0VLNMdY
        vEye7QuENdlHLI1W4ae0sgNhwCA9TIm6YccKAq+w4+qAYpIVZfjL3mSg7AgI6bRAZf2eZBA7qbemA
        dCabWfIw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6LjT-0006S8-Ch; Mon, 24 Feb 2020 21:57:43 +0000
Date:   Mon, 24 Feb 2020 13:57:43 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "cluster-devel@redhat.com" <cluster-devel@redhat.com>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v7 14/24] btrfs: Convert from readpages to readahead
Message-ID: <20200224215743.GA24044@infradead.org>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-15-willy@infradead.org>
 <SN4PR0401MB35987D7B76007B93B1C5CE5E9B130@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200220134849.GV24185@bombadil.infradead.org>
 <20200220154658.GA19577@infradead.org>
 <20200220155452.GX24185@bombadil.infradead.org>
 <20200220155727.GA32232@infradead.org>
 <20200224214347.GH13895@infradead.org>
 <20200224215414.GR24185@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224215414.GR24185@bombadil.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 24, 2020 at 01:54:14PM -0800, Matthew Wilcox wrote:
> > First I think the implicit ARRAY_SIZE in readahead_page_batch is highly
> > dangerous, as it will do the wrong thing when passing a pointer or
> > function argument.
> 
> somebody already thought of that ;-)
> 
> #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))

Ok.  Still find it pretty weird to design a primary interface that
just works with an array type.
