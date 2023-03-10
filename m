Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A084B6B3513
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Mar 2023 04:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjCJDyC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 22:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCJDyB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 22:54:01 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88465B7DB5
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Mar 2023 19:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=V8JJBoZHl/XeAI1qBF9glR/e9T3zmJcaDJfb/kXaH98=; b=D4ry11yUWAUH1oMXQ5hZe2j3jw
        b0nqPMu2bcR5UXsMiI0XHH+52qHhw+yb7ccP+ge6oxH5WsMAsgspWyhizzxyW9ttNSzIBUFbZhjuk
        Z+PcCG48HYhH0g4D2apq8+L3zPr3AJslSNKUQ90pfcfOXTLXZKCRPe3ARn2xYwV56QUEyd/gZKhQT
        3BHnEhVL2gUdS1XYnoR8jM/Tm1vu3lH2Z7qo2mxgbp0wVEw0Uk+LlW+TIjFq/oqLfGl2s223XdZoG
        wpvRHzcSeJ6axSlPj6So/9jdQzKNk9C+leHSt1LVO/WpUPjbUobSZguga31cNHF4fdWSLl0r48K28
        CXq2ay5A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1paTpJ-00FCqC-1Z;
        Fri, 10 Mar 2023 03:53:53 +0000
Date:   Fri, 10 Mar 2023 03:53:53 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/3] ufs: don't flush page immediately for DIRSYNC
 directories
Message-ID: <20230310035353.GM3390869@ZenIV>
References: <20230307143125.27778-1-hch@lst.de>
 <20230307143125.27778-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307143125.27778-2-hch@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 07, 2023 at 03:31:23PM +0100, Christoph Hellwig wrote:
> We do not need to writeout modified directory blocks immediately when
> modifying them while the page is locked. It is enough to do the flush
> somewhat later which has the added benefit that inode times can be
> flushed as well. It also allows us to stop depending on
> write_one_page() function.
> 
> Ported from an ext2 patch by Jan Kara.

Umm...  I'll throw it in ufs pile, I guess (tomorrow - I'll need to
sort out Fabio's patches in the area as well; IIRC, the latest
had been in late December).
