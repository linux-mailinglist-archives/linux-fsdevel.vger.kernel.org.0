Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376BA78938F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Aug 2023 05:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjHZDBi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 23:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbjHZDBD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 23:01:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F7A2102;
        Fri, 25 Aug 2023 20:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/t99BOhi4t8fFyLsA0HkxR5J9ImbE27XQSEoywW+MYA=; b=M+odSL2L37bmljkhKVSUJ2DMtS
        qLl8A84u4EUlvd/WxpYz/eKTH+XGAt7JZIvKPcU9flvk4bJWDrtE8Oj23ICyK59Oy2+VKbaq6hsCL
        bAj8DmSFaLOKeRM6NUV9LSnZell3P0F3zFOg+/q3bSXiZTX9mWjz1+wvAePUIMbpSnSzrOw5FYVL1
        BxEDh1UmXkL3CaX/3eHsmgOCsB0erflDtIt7SPwcW8m9idUnIrQAQ31RC/uyd2HI2AQdC217xl/Uy
        xbgK6dhSVLMi8w4pXOI8UxrF0bbCU7u8/GbhGrZis3WHZcTVa4e6mgeUjoz9MjPy3VQp+PRN+sYZR
        DElRylfw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qZjXg-003C6b-EF; Sat, 26 Aug 2023 03:00:52 +0000
Date:   Sat, 26 Aug 2023 04:00:52 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc:     Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 09/15] ceph: Use a folio in ceph_filemap_fault()
Message-ID: <ZOlq5HmcdYGPwH2i@casper.infradead.org>
References: <20230825201225.348148-1-willy@infradead.org>
 <20230825201225.348148-10-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825201225.348148-10-willy@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 25, 2023 at 09:12:19PM +0100, Matthew Wilcox (Oracle) wrote:
> +++ b/fs/ceph/addr.c
> @@ -1608,29 +1608,30 @@ static vm_fault_t ceph_filemap_fault(struct vm_fault *vmf)
>  		ret = VM_FAULT_SIGBUS;
>  	} else {
>  		struct address_space *mapping = inode->i_mapping;
> -		struct page *page;
> +		struct folio *folio;
>  
>  		filemap_invalidate_lock_shared(mapping);
> -		page = find_or_create_page(mapping, 0,
> +		folio = __filemap_get_folio(mapping, 0,
> +				FGP_LOCK|FGP_ACCESSED|FGP_CREAT,
>  				mapping_gfp_constraint(mapping, ~__GFP_FS));
> -		if (!page) {
> +		if (!folio) {

This needs to be "if (IS_ERR(folio))".  Meant to fix that but forgot.

