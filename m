Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E3B67D7FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 22:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbjAZVym (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 16:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbjAZVyf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 16:54:35 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A5A611DD;
        Thu, 26 Jan 2023 13:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JJwCfXL4BYUpCEb2XPDFHx9R/zNmK1q+22jJU+x9B7c=; b=ktqSuYI3IdQfkyDAWZIMLp5SLn
        eOY0i9SJtPz38FegUd7y7e9/3KGwB+S6nF5cNWJlqKc6FOzTCHBMqczRirZC5wwSc9UF8JytYWfJO
        tSSScv4TV3KgvVYaybT2eIv6p/Vk+yqT4YGi3ZobBApeDhQCaHIDjIvaDeevF5PNxlupjfcN1dQ1l
        75GPZdXUaA/aw0NkPLXu/N/xsvjixuWSde/ZEOMlRa3yZmhABUvM0N0eIpXghdfXNeJ+3uSxOVyeN
        F4z2/2t325lgo84QNfxo1vs/g8vTSr3ojEOENqvWpFuXEg0Ore49vRihkyNMm3SULCvp41EDv9j84
        bOW4Mr7g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pLACG-004K1b-2x;
        Thu, 26 Jan 2023 21:54:17 +0000
Date:   Thu, 26 Jan 2023 21:54:16 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v11 1/8] iov_iter: Define flags to qualify page
 extraction.
Message-ID: <Y9L2iFZlC4CFwN4t@ZenIV>
References: <20230126141626.2809643-1-dhowells@redhat.com>
 <20230126141626.2809643-2-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126141626.2809643-2-dhowells@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 26, 2023 at 02:16:19PM +0000, David Howells wrote:

> +typedef unsigned int iov_iter_extraction_t;

> +/* Flags for iov_iter_get/extract_pages*() */
> +/* Allow P2PDMA on the extracted pages */
> +#define ITER_ALLOW_P2PDMA	((__force iov_iter_extraction_t)0x01)

That __force makes sense only if you make it a bitwise type -
otherwise it's meaningless.  IOW, either turn the typedef into

typedef unsigned int __bitwise iov_iter_extraction_t;

or lose __force in the cast...
