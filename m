Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9185751780
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 06:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbjGMEd2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 00:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbjGMEdZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 00:33:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0462E4D;
        Wed, 12 Jul 2023 21:33:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57B55619B0;
        Thu, 13 Jul 2023 04:33:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF6D7C433C8;
        Thu, 13 Jul 2023 04:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689222803;
        bh=flFNBLqYvFeLZNQLriTkwdfj6kaOpgPPC7ZxyY3x/NI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bWD7mkL/xTbrZYmPhQJZYAhxD8+5KVcOoLHa7PPGR5XgMCDQkhuysVLUY+Gj+xHrw
         /O8aS5zNiQJ8CaPw9Vrx0fqB+a82ybRukl/rtycYjhVELStq5NB9BPpz/Ok9N/Oq/2
         9SYpZ+ABJDPVGf1WYsTZIn5C+UvPgkA4xpXU9+Of70KUogc91EfqtdTKdRHi1jNRe4
         NLbxBB0ZRIXZYp5qD5/DWGXoyXfUoL1etzQPABEmmYRH3nx3sz72VycW7aqrXYcPsr
         U7P2nJmOjQtmeLkQPGa5A1Uhe3OH6vdB794umJ9tiVAVwccoOBlm9JFBxtdSbhPmeP
         bYolawm+wC64A==
Date:   Wed, 12 Jul 2023 21:33:23 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: [PATCHv11 4/8] iomap: Fix possible overflow condition in
 iomap_write_delalloc_scan
Message-ID: <20230713043323.GD108251@frogsfrogsfrogs>
References: <cover.1688188958.git.ritesh.list@gmail.com>
 <c126c4aeecc436dce702a20e5100ed148598ff8b.1688188958.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c126c4aeecc436dce702a20e5100ed148598ff8b.1688188958.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 01, 2023 at 01:04:37PM +0530, Ritesh Harjani (IBM) wrote:
> folio_next_index() returns an unsigned long value which left shifted
> by PAGE_SHIFT could possibly cause an overflow on 32-bit system. Instead
> use folio_pos(folio) + folio_size(folio), which does this correctly.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Fixes: f43dc4dc3eff ("iomap: buffered write failure should not truncate the page cache")

With that added,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index e45368e91eca..cddf01b96d8a 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -933,7 +933,7 @@ static int iomap_write_delalloc_scan(struct inode *inode,
>  			 * the end of this data range, not the end of the folio.
>  			 */
>  			*punch_start_byte = min_t(loff_t, end_byte,
> -					folio_next_index(folio) << PAGE_SHIFT);
> +					folio_pos(folio) + folio_size(folio));
>  		}
> 
>  		/* move offset to start of next folio in range */
> --
> 2.40.1
> 
