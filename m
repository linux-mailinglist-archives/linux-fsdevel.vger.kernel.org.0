Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB4D404952
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 13:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235499AbhIILdD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 07:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234507AbhIILdC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 07:33:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46706C061575;
        Thu,  9 Sep 2021 04:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BfKEljguWPXGr4e3LXDH03SVJxLaZjb+EKBRx/u+o70=; b=EwatQv8pZFD06Pjcvm9Srfbpyf
        7yQTt9GjXjYiPICNt37b2mmQcExhyIkRlhUhtkBnEtH+9hUUhEIEb6H48USmxOGfbe0P/8dgOF7Il
        Rl7Sw4l8LVK6tFFsnAR6Ddzzy581bGk9BIdKoVE6V2cuOUAyWlLgSL9YiWvCObd2GLi6csVj1Gvq4
        LwyE9T+pNdLDopS66+PHKs0b74tGXRGnvMxdoKzeJoo0uPkeRXBPwoZGrycyke3wmtlrpYeDyRN9Q
        n6LBpZItlDI292lHeaOkidFObb16Q64qUEGQ2heZDvnVgx6KRPKF6T9fDcLWAuCOAv6F0nWhcnmY/
        WV2NfEUg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOIGT-009lZE-Mp; Thu, 09 Sep 2021 11:30:51 +0000
Date:   Thu, 9 Sep 2021 12:30:45 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ocfs2-devel@oss.oracle.com
Subject: Re: [PATCH v7 16/19] iomap: Add done_before argument to iomap_dio_rw
Message-ID: <YTnwZU8Q0eqBccmM@infradead.org>
References: <20210827164926.1726765-1-agruenba@redhat.com>
 <20210827164926.1726765-17-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827164926.1726765-17-agruenba@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

What about just passing done_before as an argument to
iomap_dio_complete? gfs2 would have to switch to __iomap_dio_rw +
iomap_dio_complete instead of iomap_dio_rw for that, and it obviously
won't work for async completions, but you force sync in this case
anyway, right?
