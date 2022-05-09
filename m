Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF04351FE46
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 15:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236072AbiEIN12 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 09:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235803AbiEIN1L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 09:27:11 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA00514FC92
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 May 2022 06:23:16 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 249DNAcX032030
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 May 2022 09:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1652102591; bh=eAntDpaBfCPFFFxzwzO0D7YV18/5KgBGIL9i4Sb8KmI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=qTM6gdeEjOPAEv3oB7upw4Q55NLj9V0VqsWZnoamafCqvJurqyHnQF6i1jnhYN0os
         pa8aatLwJQ5ezvgLTZbnylzMRPl+dNM7ndTCRICdn/bcncqAdWVNz+Xm04U+jqKzUJ
         n/fILzqUTNfIIYYYQ5BOCbYgsXh9+8zQqKfvjm3p5+RVbzQgebBGH1hgg4D7Z7XyuH
         2YGLnTVKjPj5BfAk96K/e9gZs3LHLQksPCBEi5WRhlO7bfMFv9/DjN1CSs9690gUvm
         A2XNDlX03geEzVoXh+VyS4eHIMMvZDeWFlMq+OIWanKPxkgPTe3rHjrTW9xKi8AXTb
         d1uhpsFvr/oUQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 43D5015C3F0A; Mon,  9 May 2022 09:23:10 -0400 (EDT)
Date:   Mon, 9 May 2022 09:23:10 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 24/26] jbd2: Convert release_buffer_page() to use a folio
Message-ID: <YnkVvr6UR2NQLbWi@mit.edu>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508203247.668791-1-willy@infradead.org>
 <20220508203247.668791-25-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220508203247.668791-25-willy@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 08, 2022 at 09:32:45PM +0100, Matthew Wilcox (Oracle) wrote:
> Saves a few calls to compound_head().
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Theodore Ts'o <tytso@mit.edu>

... although I have one question:

> -	get_page(page);
> +	folio_get(folio);
>  	__brelse(bh);
> -	try_to_free_buffers(page);
> -	unlock_page(page);
> -	put_page(page);
> +	try_to_free_buffers(&folio->page);

The patches in this series seem to assume that the folio contains only
a single page.  Or at least, a *lot* more detailed auditing to make
sure the right thing would happen if a page happens to be a member of
a folio with more than a single page.

Should we be adding some kind of WARN_ON to check this particular
assumption?

					- Ted
