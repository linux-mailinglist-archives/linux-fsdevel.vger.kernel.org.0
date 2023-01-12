Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A1B668573
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 22:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240753AbjALVci (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 16:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240443AbjALVby (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 16:31:54 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F82D6951E;
        Thu, 12 Jan 2023 13:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mgdwqYrKEs0wRNGjZq0hKD7IgBnja7zUOIc1FWuUR30=; b=NO+Ca+4ptuLtw+D2tpMoaIL+cC
        fIf4BreZay/H0EwopveluCLrPzqsijXsTEyNM75IZ5H1vQSYeG5u5gmmyIQrlDZledZlgOwE0YPD1
        ayKvWyF9lLZKA/9sFT7Njn8sEYRy8byi59tfzkG9qTrHRN9P8iHM/FYoGGUmsMvIY/hceyCAu40/z
        uxmYf33HVSF8nO9MeKY5PwmoUpYeJQhj3GhMLbUjzQn0nP+DXYWMuzJeyfK8ze37Lt3CaMp6Hfeej
        yOL7H32eTwV7QPl2NglZXEAZR9wPLDdLy1fvNCJCDMwJoMW+ab2uKpCCC/5ndcqQjiVwUd4lBWhfW
        BGiJBuEA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pG4vO-001Yop-2R;
        Thu, 12 Jan 2023 21:15:50 +0000
Date:   Thu, 12 Jan 2023 21:15:50 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/9] iov_iter: Add a function to extract a page list
 from an iterator
Message-ID: <Y8B4hpF5czsk7pK1@ZenIV>
References: <167344725490.2425628.13771289553670112965.stgit@warthog.procyon.org.uk>
 <167344728530.2425628.9613910866466387722.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167344728530.2425628.9613910866466387722.stgit@warthog.procyon.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 11, 2023 at 02:28:05PM +0000, David Howells wrote:

> +ssize_t iov_iter_extract_pages(struct iov_iter *i,
> +			       struct page ***pages,
> +			       size_t maxsize,
> +			       unsigned int maxpages,
> +			       unsigned int gup_flags,
> +			       size_t *offset0,
> +			       unsigned int *cleanup_mode)

This cleanup_mode thing is wrong.  It's literally a trivial
function of ->user_backed and ->data_source - we don't
even need to look at the ->type.

Separate it into an inline helper and be done with that;
don't carry it all over the place.

It's really "if not user-backed => 0, otherwise it's FOLL_PIN or FOLL_GET,
depending upon the direction".
