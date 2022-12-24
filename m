Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926646558E9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Dec 2022 08:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiLXHWj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Dec 2022 02:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLXHWi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Dec 2022 02:22:38 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F5612AC8;
        Fri, 23 Dec 2022 23:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=2Fi47Fpyh+tJbjf8+uKyHTOeyVTr+BeFruENq8fY4qs=; b=eolPUk9U/R6vmIQCoVczaYs7fk
        QhgUm85n7w5YcHJyovsz5seV1/zp/K/bp6z9kanXjJZR70xGI6cmhxl4SN0h6lxrv3dj/Ert81SWC
        fKiCXm3kVxWfeHI8DryYJli15AzHcStujfcp7HbJIV9W0RsvGa0AuFnHAJyO0k+dB+m1gMxVnxGl/
        3LqQGs+yeIWXbPTla19zBjUd2pwPmnkLHLvSaqZ7pGe8w5B5iF6D6sZ3ZMVYb4QUnVTC1IXRuf4ik
        atZuI4uR+AmEpvE+F1dWuXW+6TZz6vnAYIy6ChIe9MQlA/soTskZXjyxHOnuNXpMBUg6Yz+ywdHDI
        +MIz6AIA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p8yrX-00FvxT-9f; Sat, 24 Dec 2022 07:22:31 +0000
Date:   Fri, 23 Dec 2022 23:22:31 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Andreas =?iso-8859-1?Q?Gr=FCnbacher?= 
        <andreas.gruenbacher@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Subject: Re: [RFC v3 2/7] iomap: Add iomap_folio_done helper
Message-ID: <Y6aot0pDtWl/c5Nb@infradead.org>
References: <20221216150626.670312-1-agruenba@redhat.com>
 <20221216150626.670312-3-agruenba@redhat.com>
 <Y6XDAG25Qumt/iyM@infradead.org>
 <CAHpGcMJAnyn_7hHvsPL5GAiwbJs_DX04+Tt0P+6jfi_kb7jGUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHpGcMJAnyn_7hHvsPL5GAiwbJs_DX04+Tt0P+6jfi_kb7jGUg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 23, 2022 at 09:54:34PM +0100, Andreas Grünbacher wrote:
> > But for the current version I don't really understand why the error
> > unwinding changes here.
> 
> Currently, we have this order of operations in iomap_write_begin():
> 
>   folio_unlock() // folio_put() // iomap_write_failed() // ->page_done()
> 
> and this order in iomap_write_end():
> 
>   folio_unlock() // ->page_done() // folio_put() // iomap_write_failed()
> 
> The unwinding in iomap_write_begin() works because this is the trivial
> case in which nothing happens to the page. We might just as well use
> the same order of operations there as in iomap_write_end() though, and
> when you switch to that, this is what you get.

Please document this in the commit message.
