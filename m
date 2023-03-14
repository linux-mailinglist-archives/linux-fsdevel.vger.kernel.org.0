Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5342E6BA293
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 23:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjCNWgf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 18:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjCNWge (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 18:36:34 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F2032E76
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Mar 2023 15:36:33 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32EMaLs3010373
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 18:36:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1678833382; bh=rWefUtYyK+Dtv/NQczxgCsKX4ck4TSN33wAHh0awudA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=UlhT5HDkaXWmvnoiea9rlk2G8QYDvj9uOYtrto0XlnToT9JPIBkErOZeLiRi/PjEv
         UXoK2UHaTkA8ScjDg4Ls9KF5XDTjoZ/eZaKgHaGLGfCn6JNMsxdgaRpCq+WXx5rbwb
         mHejKFkAmsi5wyBqudM8yP++7sq+gzMPtQLfdvyxSKNnmAHbCXXaAOFPiG+LbI3QiT
         zfxPw6S1c57Nl705drY6sJaxW4lwJMgRRl5ZiD1nR9HRi8Fc8G3q1GCSEa6IEvgr0i
         hOX3X16oLrP/4jtj/Ug/M9IN5FRzRtC4Z3p7PWhHjr4aeTgTv60b20tLDqqSzkYaA7
         f/1ZZGqiVjT/w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 1FA4E15C5830; Tue, 14 Mar 2023 18:36:21 -0400 (EDT)
Date:   Tue, 14 Mar 2023 18:36:21 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 10/31] ext4: Convert ext4_convert_inline_data_to_extent()
 to use a folio
Message-ID: <20230314223621.GY860405@mit.edu>
References: <20230126202415.1682629-1-willy@infradead.org>
 <20230126202415.1682629-11-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126202415.1682629-11-willy@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 26, 2023 at 08:23:54PM +0000, Matthew Wilcox (Oracle) wrote:
> Saves a number of calls to compound_head().

Is this left over from an earlier version of this patch series?  There
are no changes to calls to compound_head() that I can find in this
patch.

> @@ -565,10 +564,9 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
>  
>  	/* We cannot recurse into the filesystem as the transaction is already
>  	 * started */
> -	flags = memalloc_nofs_save();
> -	page = grab_cache_page_write_begin(mapping, 0);
> -	memalloc_nofs_restore(flags);
> -	if (!page) {
> +	folio = __filemap_get_folio(mapping, 0, FGP_WRITEBEGIN | FGP_NOFS,
> +			mapping_gfp_mask(mapping));
> +	if (!folio) {
>  		ret = -ENOMEM;
>  		goto out;
>  	}

Is there a reason why to use FGP_NOFS as opposed to using
memalloc_nofs_{save,restore}()?

I thought using memalloc_nofs_save() is considered the perferred
approach by mm-folks.

						- Ted
