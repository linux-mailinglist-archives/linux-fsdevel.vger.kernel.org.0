Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9024D663BA0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jan 2023 09:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238032AbjAJIrE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Jan 2023 03:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238144AbjAJIrA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Jan 2023 03:47:00 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4420D200B;
        Tue, 10 Jan 2023 00:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=usc4kPYlRKM7CFqadqNB7LyLIDZhCAK3LME1O0ZEeRg=; b=JsREblb429CWLXqPBC0bFmQk8C
        JxdIJaCgXBIfXkIDBmcRskjW5V6Mc6cXIKK8M+VnmzytQo8kN0QHdmN3r+dJ0RDsx7g/Pjd3zKbEP
        ZW/C5QsNeZLHODkjFvCJZ5VK/q/z9foF87SWSlTIztfRjcyWo0ZWZoxY6G/1Qz6wyACTrvD+5YclJ
        OXPE4FDEiaEdNDVJ866VtAkLGuiAB3oeEVO/raQmatCKzDXz+mN3Q0eo+w5oZAXgDafVvUHeRD1mI
        5cF8onl1ZCDW0LSdDjN9EqkGRnUUibxbyueYqIcoiJKkNE8r0KuB2SxPayRytNo/EdNvHhCPE/oD0
        HB2pvFpg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFAHN-005tNC-St; Tue, 10 Jan 2023 08:46:45 +0000
Date:   Tue, 10 Jan 2023 00:46:45 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Dave Chinner <dchinner@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC v6 04/10] iomap: Add iomap_get_folio helper
Message-ID: <Y70l9ZZXpERjPqFT@infradead.org>
References: <20230108213305.GO1971568@dread.disaster.area>
 <20230108194034.1444764-1-agruenba@redhat.com>
 <20230108194034.1444764-5-agruenba@redhat.com>
 <20230109124642.1663842-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109124642.1663842-1-agruenba@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 09, 2023 at 01:46:42PM +0100, Andreas Gruenbacher wrote:
> We can handle that by adding a new IOMAP_NOCREATE iterator flag and
> checking for that in iomap_get_folio().  Your patch then turns into
> the below.

Exactly.  And as I already pointed out in reply to Dave's original
patch what we really should be doing is returning an ERR_PTR from
__filemap_get_folio instead of reverse-engineering the expected
error code.

The only big question is if we should apply Dave's patch first as a bug
fix before this series, and I suspect we should do that.
