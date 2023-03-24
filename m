Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6E86C8853
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 23:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjCXW35 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 18:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbjCXW34 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 18:29:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70DC9030;
        Fri, 24 Mar 2023 15:29:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F2F8B8263C;
        Fri, 24 Mar 2023 22:29:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6997C433EF;
        Fri, 24 Mar 2023 22:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679696993;
        bh=AAbNs8yXqUH1VLSX1EbrMvKD4w9xN6cND5bc44EXnNs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oub1ERdZpGa3VXfqNJirfBHoExS41xguPkv2XJ0Yn6CIYq2Uj0hWsuDUfxH4zLOyl
         TuPfAJRDy1U+yYcDKhvEQurhpP0MALiu8x/6PLJJ5q6Gu3SQqvQOe7kd7vtZ1SuCoV
         eT0rp5WEz7VHugRV8OFFXrt7yI7sIUsaJS01ZuFOlMcb6vA6qBdYXew+TfVSfgXDzf
         vR0jrgsgvKNNI2CCXFKeyTMw4DCBAzkeZU1v8DhD28tlABtLeuEqCzocGXI4kLHMWj
         NwBk3heZKxnNTrRzR7JPyVo2Hop0Hf5sZOjKjbyjdcCyYefBcTSFE2QL5YMa+Ctdef
         H7Q8Td4itDxOw==
Date:   Fri, 24 Mar 2023 15:29:51 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 23/29] ext4: Convert ext4_mpage_readpages() to work on
 folios
Message-ID: <20230324222951.GA5083@sol.localdomain>
References: <20230324180129.1220691-1-willy@infradead.org>
 <20230324180129.1220691-24-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324180129.1220691-24-willy@infradead.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 24, 2023 at 06:01:23PM +0000, Matthew Wilcox (Oracle) wrote:
>  		if (first_hole != blocks_per_page) {
> -			zero_user_segment(page, first_hole << blkbits,
> -					  PAGE_SIZE);
> +			folio_zero_segment(folio, first_hole << blkbits,
> +					  folio_size(folio));
>  			if (first_hole == 0) {
> -				if (ext4_need_verity(inode, page->index) &&
> -				    !fsverity_verify_page(page))
> +				if (ext4_need_verity(inode, folio->index) &&
> +				    !fsverity_verify_page(&folio->page))
>  					goto set_error_page;

This can use fsverity_verify_folio().

- Eric
