Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C16D674A86
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jan 2023 05:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjATEVM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Jan 2023 23:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjATEVL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 23:21:11 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F49418AB0;
        Thu, 19 Jan 2023 20:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eOaj5ya8NeJSoNv1ZVdr5PfSsgkKED2aWCxjWInzZHk=; b=Ri97XIO7jGbXUKdK86NYY6bzV2
        p56yOo7FjVWv6UAAIcirwrWKl+miSaO0HK5pW0ESmsHrAFqfdYUr21C7uGTvFAyACgPx/ZlNONWOt
        e1YzUBVxa/EEjOjytse5LrejWX91zK2GCBBX/WNwq8dAK881c/SZjDvpY2OGbqtEjex6CNZT/lij3
        0OZ59RRMAHjBAoiZzuC18t1mbL0W3afXsBYRVlrOnqh8mmkEOb8ASzhXYHs9tjN4atGIfQFWY02dN
        9apf6pkLqXPSbFhDgXrY70uMR9pjvNhIddKqOpTjxNwuA1xZu7xW/lsVXqH9dvbUhxq4jDQo1eKn0
        c46ZIuVA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pIitm-002vFI-2i;
        Fri, 20 Jan 2023 04:21:06 +0000
Date:   Fri, 20 Jan 2023 04:21:06 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v3 4/4] fs/sysv: Replace kmap() with kmap_local_page()
Message-ID: <Y8oWsiNWSXlDNn5i@ZenIV>
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

> -inline void dir_put_page(struct page *page)
> +inline void dir_put_page(struct page *page, void *page_addr)
>  {
> -	kunmap(page);
> +	kunmap_local(page_addr);

... and that needed to be fixed - at some point "round down to beginning of
page" got lost in rebasing...
