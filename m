Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34FE674859
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jan 2023 01:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjATAyM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Jan 2023 19:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjATAyL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 19:54:11 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DD545F5E;
        Thu, 19 Jan 2023 16:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=b7srAW+gtFYq/oOlQokHfZ01Lnsj+6AOdclPYQRY58A=; b=g73EFRFs/Kx1HSPyD+g3KYmgea
        D3M3eO5Dhwm/B7NRF1N/HsyOSY8mr66ro6noUtju6Ue8zcJqK7vYbqfUbSYetivXS9GpYQvKGFnO0
        a44YIRu61NBRYHfddZuIjqCX4Q1UCUmqR9BC3gpuQ2HVmpc66pr0hG6n2vMO6nJjoxVZA+CHeJUoz
        vvh6c5/QsIYEULtjlrtmtxv2A9B+Col+tOomftg7eFTCAfaYGox2YEvhaPYgr3ZfUYHpngn0neZ8R
        t7Uynm1P/fwsrov8F+qYlAVqJgvvF+18cHTQBI45t4CJhqj+HgHnHApoD3MKrwdNTBHuqiLiev1CM
        2ci31cUw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pIffS-002tur-1N;
        Fri, 20 Jan 2023 00:54:06 +0000
Date:   Fri, 20 Jan 2023 00:54:06 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v3 4/4] fs/sysv: Replace kmap() with kmap_local_page()
Message-ID: <Y8nmLh0cyloTzfAN@ZenIV>
References: <20230119153232.29750-1-fmdefrancesco@gmail.com>
 <20230119153232.29750-5-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119153232.29750-5-fmdefrancesco@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 19, 2023 at 04:32:32PM +0100, Fabio M. De Francesco wrote:
> @@ -228,6 +239,12 @@ int sysv_delete_entry(struct sysv_dir_entry *de, struct page *page)
>  {
>  	struct inode *inode = page->mapping->host;
>  	loff_t pos = page_offset(page) + offset_in_page(de);
> +	/*
> +	 * The "de" dentry points somewhere in the same page whose we need the
> +	 * address of; therefore, we can simply get the base address "kaddr" by
> +	 * masking the previous with PAGE_MASK.
> +	 */
> +	char *kaddr = (char *)((unsigned long)de & PAGE_MASK);

er...  ITYM "therefore we can pass de to dir_put_page() and get rid of that kaddr
thing"...

Anyway, with that change the series rebased and applied on top of Christoph's sysv
patch.
