Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51FA73F324
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 06:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjF0EDl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 00:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjF0EDj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 00:03:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D21E59;
        Mon, 26 Jun 2023 21:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FNs3BplCPpnzdNu8i3c1Y/TSPIbiewFjVDwcw/mDzZw=; b=T3rmNnOpj5XKSDGjcuQrs5ZBg4
        /nn2S/AteGGEHrBO0qfJU9TMNv/g38NgqwqQVavNNc+NpqIIwd6FzbE26Exa85Mm2izeWaL/tyEsI
        DkN1FWnNdsllVxQk6aDksH2AhMpr11JogGhCkxunKv8ogiz5ioqkZVckNXYXLxf+e6G4T09nNnjxw
        fAilwjhW+nZaA0yebzTpMEnq5sWsW1jHQdS8sT6BWvsXh7BQm/0nMBhJMA1kxDBW210uHZ73fl4Ap
        dlnfsMnCt66iTPaV02aFdD7iXITrxYxh/NVgV7sCE1Xzcm+FR5aaqvWER8ayQxn/z/yn36TAmJUG4
        iGOcf6rw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qDzvU-00Be61-1r;
        Tue, 27 Jun 2023 04:03:36 +0000
Date:   Mon, 26 Jun 2023 21:03:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 00/12] Convert write_cache_pages() to an iterator
Message-ID: <ZJpfmP9h4z8H4CkS@infradead.org>
References: <20230626173521.459345-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626173521.459345-1-willy@infradead.org>
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

On Mon, Jun 26, 2023 at 06:35:09PM +0100, Matthew Wilcox (Oracle) wrote:
> Dave Howells doesn't like the indirect function call imposed by
> write_cache_pages(), so refactor it into an iterator.  I took the
> opportunity to add the ability to iterate a folio_batch without having
> an external variable.
> 
> This is against next-20230623.  If you try to apply it on top of a tree
> which doesn't include the pagevec removal series, IT WILL CRASH because
> it won't reinitialise folio_batch->i and the iteration will index out
> of bounds.
> 
> I have a feeling the 'done' parameter could have a better name, but I
> can't think what it might be.

Heh, I actually have a local series with a minor subset of some of the
cleanups, but without the iterator conversion.
