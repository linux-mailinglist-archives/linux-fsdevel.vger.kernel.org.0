Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F48644995
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Dec 2022 17:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbiLFQoH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Dec 2022 11:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiLFQoG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Dec 2022 11:44:06 -0500
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA4B1CF;
        Tue,  6 Dec 2022 08:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=+fdSl/kYCg7nbvsMKTNFAWCRsV4WafVthknWQQZ1q80=; b=e0fXLPfrOKcDyV3144phEfwEeS
        76kEesj4ESPkLiNvah+GfXAELTB9adC7KCQ8GNyLqeOBd3rmYFjv1BRhi7xtffaTbyDrhiho8d9FL
        Fa+itvkwwW8KQAof8oLCUY/XEaKPE4T4fNfo1nHNidOwc+uuICmkSB+d69OwD+/0IvVRiMo/PQbt4
        xyAFWxwHS4G8z8LT9rNA8oinoRN/MdLsFp3x3bz+tvxEJSQ1FzaNIC13OuqnAN5k7B8cOX7iJ2Sar
        beSYR+eLV5WIsdfxGLIhxGl5XZ6GoLixn/SHXSdv0m1nSBRIArj9yX0QGiSxRSYWAqN4x9TlGdBCp
        sJsN/03Q==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1p2b2j-001rFJ-VP; Tue, 06 Dec 2022 09:43:42 -0700
Message-ID: <0d62615c-57d1-922b-5ebc-32faabf33327@deltatee.com>
Date:   Tue, 6 Dec 2022 09:43:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-CA
To:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>, John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org
References: <166997419665.9475.15014699817597102032.stgit@warthog.procyon.org.uk>
 <166997421646.9475.14837976344157464997.stgit@warthog.procyon.org.uk>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <166997421646.9475.14837976344157464997.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: dhowells@redhat.com, viro@zeniv.linux.org.uk, hch@lst.de, jhubbard@nvidia.com, willy@infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@infradead.org, jlayton@kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v3 2/4] iov_iter: Add a function to extract a page list
 from an iterator
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2022-12-02 02:43, David Howells wrote:
> Add a function, iov_iter_extract_pages(), to extract a list of pages from
> an iterator.  The pages may be returned with a reference added or a pin
> added or neither, depending on the type of iterator and the direction of
> transfer.
> +static ssize_t iov_iter_extract_user_pages(struct iov_iter *i,
> +					   struct page ***pages, size_t maxsize,
> +					   unsigned int maxpages,
> +					   size_t *offset0,
> +					   unsigned int *cleanup_mode)

If this is going to be a general replacement for iov_iter_get_pages()
it's going to need to pass through gup_flags. My recent patchset added
versions with these and I think it should be in during the next merge
cycle. [1]

Thanks,

Logan


[1] https://lore.kernel.org/all/20221021174116.7200-4-logang@deltatee.com/
