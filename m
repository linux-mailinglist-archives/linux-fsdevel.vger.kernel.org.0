Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6596B6B3503
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Mar 2023 04:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjCJDtU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 22:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjCJDtS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 22:49:18 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024F6F185A
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Mar 2023 19:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=g6V4Gxmi7X46KWy9Z1dTCBI/CizDod1edUe5jdg4m7c=; b=weIxlQrFrH7JIGKKgO7T578Uqr
        /B8fR68jTGhqMsVGfpT/BaxWruuQhBjZNIMB9XMxB0sW8UP62PBmwYpssTyZKzpULDbKJzjWrXwTj
        I99A/OB0VxIVkDAOP8a/oSy7dpjnKIz8A9uOOqKBIT/YNj5MES4V7s8ac+XfXwc0/X8cTUNeEtMtR
        +qVhEcd7dIzgYWUKwYXTPXqbNBRffvUn3c6iIspER2+Ua/yg5eMsqtDwjDTvBNR+x8U+OcnYtjOKa
        Bdl98syii3w2Cdn2FWAjs7JBZeL1guzZpNrBHxdr3Wk0zCA2+SU5WxYm3HXJgg0Bwjl0sKLKbqWMM
        BPPgR+rA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1paTka-00FCme-19;
        Fri, 10 Mar 2023 03:49:00 +0000
Date:   Fri, 10 Mar 2023 03:49:00 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 2/3] ocfs2: don't use write_one_page in
 ocfs2_duplicate_clusters_by_page
Message-ID: <20230310034900.GL3390869@ZenIV>
References: <20230307143125.27778-1-hch@lst.de>
 <20230307143125.27778-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307143125.27778-3-hch@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 07, 2023 at 03:31:24PM +0100, Christoph Hellwig wrote:
> Use filemap_write_and_wait_range to write back the range of the dirty
> page instead of write_one_page in preparation of removing write_one_page
> and eventually ->writepage.

That one is in vfs.git #work.misc (sorry, missed -next last cycle).
