Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A34570A428
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 May 2023 03:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjETBGn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 21:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjETBGm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 21:06:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC824FA;
        Fri, 19 May 2023 18:06:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36450657F0;
        Sat, 20 May 2023 01:06:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8FDC433D2;
        Sat, 20 May 2023 01:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684544800;
        bh=rso2Q4gXYI0YTNN43fHXcTzoQQl/M7xpKFkpD2wxPj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NNIfKVKtYxOIsdU47u7w7tgGz1iKChFiTXI2RIwnMkRQjANq9mdQLXt7OK4GT4o7D
         RawRgAAazHT/HR+6IglKZd7ET8bvUT+CRKp3OxkyVSlNuS6E+l8Y2nEJ/rHaEOa7x6
         N9lty5LoG/5xMiu0PafMA1k3HupB1p57Hbluht/iwQGEdyeIDoAPXQCqedY9dCqsmK
         DR61cdNk+wOSUwGQpCER/oSvB5e6ESMrSNGrrQgVIYsL8qbWfK7Wywp7tOpl4u34RE
         uAONlNNVnNEwtxnikgu1GJaiubsYDSsWIhxmb6YlJmnRXCaSr89npzMCSqQI1564iD
         l9n6l46KkDN5w==
Date:   Fri, 19 May 2023 18:06:38 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: Re: [PATCH 6/5] ext4: Call fsverity_verify_folio()
Message-ID: <20230520010638.GA836@sol.localdomain>
References: <cover.1684122756.git.ritesh.list@gmail.com>
 <20230516192713.1070469-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516192713.1070469-1-willy@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 16, 2023 at 08:27:13PM +0100, Matthew Wilcox (Oracle) wrote:
> Now that fsverity supports working on entire folios, call
> fsverity_verify_folio() instead of fsverity_verify_page()
> 
> Reported-by: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/ext4/readpage.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
> index 6f46823fba61..3e7d160f543f 100644
> --- a/fs/ext4/readpage.c
> +++ b/fs/ext4/readpage.c
> @@ -334,7 +334,7 @@ int ext4_mpage_readpages(struct inode *inode,
>  					  folio_size(folio));
>  			if (first_hole == 0) {
>  				if (ext4_need_verity(inode, folio->index) &&
> -				    !fsverity_verify_page(&folio->page))
> +				    !fsverity_verify_folio(folio))
>  					goto set_error_page;
>  				folio_mark_uptodate(folio);
>  				folio_unlock(folio);
> -- 

Reviewed-by: Eric Biggers <ebiggers@google.com>

(Though I must mention that doing weird things like "PATCH 6/5" makes life hard
for scripts that operate on patch series...)

- Eric
