Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7704F6F5B8B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 17:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjECPyR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 11:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjECPyQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 11:54:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB37E1992
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 May 2023 08:54:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 69A7B229DB;
        Wed,  3 May 2023 15:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683129253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=od0EVsy8UznIoL+Zwfmk1n1t6ccq/cOyBAiielREKuY=;
        b=PX+tLsQ+1dHUfe9WNnK8rncqooCs7oO6cm5pird2sHU44dthjo8fyvE2MSyrd2mYfiqd6l
        Uv8lVslOOXyFkHd8/s5Am1k5xjujJYXkB/p0yzaM4upT80kgyk/ZxmqkpKHQGY+rUX4haa
        W6Y7aFyfHqzJoe71qLj2AM/F0/kPrXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683129253;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=od0EVsy8UznIoL+Zwfmk1n1t6ccq/cOyBAiielREKuY=;
        b=EZcTwdC+TP9XMCRvupNyRrLZO9Nj3FOtPS45UVrLCf8KVixur2yKqJPlIb/wngmC6vmFr8
        nW9Mu606j+NaXFCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5C10313584;
        Wed,  3 May 2023 15:54:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id M9toFqWDUmQddAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 03 May 2023 15:54:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E129DA0744; Wed,  3 May 2023 17:54:12 +0200 (CEST)
Date:   Wed, 3 May 2023 17:54:12 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     akpm@linux-foundation.org, jack@suse.cz,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        dhowells@redhat.com, marc.dionne@auristor.com,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH 2/2] afs: fix the afs_dir_get_folio return value
Message-ID: <20230503155412.a7t4fhtlnvxojdoq@quack3>
References: <20230503154526.1223095-1-hch@lst.de>
 <20230503154526.1223095-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503154526.1223095-2-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 03-05-23 17:45:26, Christoph Hellwig wrote:
> Keep returning NULL on failure instead of letting an ERR_PTR escape to
> callers that don't expect it.
> 
> Fixes: 66dabbb65d67 ("mm: return an ERR_PTR from __filemap_get_folio")
> Reported-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/afs/dir_edit.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/afs/dir_edit.c b/fs/afs/dir_edit.c
> index f0eddccbdd9541..e2fa577b66fe0a 100644
> --- a/fs/afs/dir_edit.c
> +++ b/fs/afs/dir_edit.c
> @@ -115,11 +115,12 @@ static struct folio *afs_dir_get_folio(struct afs_vnode *vnode, pgoff_t index)
>  	folio = __filemap_get_folio(mapping, index,
>  				    FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
>  				    mapping->gfp_mask);
> -	if (IS_ERR(folio))
> +	if (IS_ERR(folio)) {
>  		clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
> -	else if (folio && !folio_test_private(folio))
> +		return NULL;
> +	}
> +	if (!folio_test_private(folio))
>  		folio_attach_private(folio, (void *)1);
> -
>  	return folio;
>  }
>  
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
