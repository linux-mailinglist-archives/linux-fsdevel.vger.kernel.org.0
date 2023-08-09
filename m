Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B5C775650
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 11:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjHIJ1M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 05:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjHIJ1L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 05:27:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FC219BC
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Aug 2023 02:27:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9F71A1F38C;
        Wed,  9 Aug 2023 09:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691573229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4/nJQNjaMMEHAsgznZRbLNZIMyktkhNvdUrfDdvlYvM=;
        b=IHQMNq8Tq+rYMJOt0e2M/BgViK71BiFS4IH5rQGNBNleLCmeOSVUCQCdBUdwAEt/yAyarS
        vFzOtuMQz81vRMpWFnG2pp/dVbA4G1Sgz1p6omECBqL4Q7d0k9ZiFo9/h60R6p8F/rTfoR
        9zVHoE2tfyiikTBIzS55Qrsniy6l+XM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691573229;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4/nJQNjaMMEHAsgznZRbLNZIMyktkhNvdUrfDdvlYvM=;
        b=hFblZAA7SKTxBgwQ16EX+ziQHczbuEEobqNLv6+1YVapmvL81QQ9Pw0RLcpnvjJfX6PrO0
        Uh5dbExvTRZpn5Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 82DAF133B5;
        Wed,  9 Aug 2023 09:27:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Pu3qH+1b02RLEQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 09 Aug 2023 09:27:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8D4F6A0769; Wed,  9 Aug 2023 11:27:08 +0200 (CEST)
Date:   Wed, 9 Aug 2023 11:27:08 +0200
From:   Jan Kara <jack@suse.cz>
To:     Hugh Dickins <hughd@google.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleksandr Tymoshenko <ovt@google.com>,
        Carlos Maiolino <cem@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Miklos Szeredi <miklos@szeredi.hu>, Daniel Xu <dxu@dxuuu.xyz>,
        Chris Down <chris@chrisdown.name>, Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Pete Zaitcev <zaitcev@redhat.com>,
        Helge Deller <deller@gmx.de>,
        Topi Miettinen <toiwoton@gmail.com>,
        Yu Kuai <yukuai3@huawei.com>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH vfs.tmpfs 5/5] mm: invalidation check mapping before
 folio_contains
Message-ID: <20230809092708.e3tzvdjjvu7hwcjq@quack3>
References: <e92a4d33-f97-7c84-95ad-4fed8e84608c@google.com>
 <f0b31772-78d7-f198-6482-9f25aab8c13f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0b31772-78d7-f198-6482-9f25aab8c13f@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 08-08-23 21:36:12, Hugh Dickins wrote:
> Enabling tmpfs "direct IO" exposes it to invalidate_inode_pages2_range(),
> which when swapping can hit the VM_BUG_ON_FOLIO(!folio_contains()): the
> folio has been moved from page cache to swap cache (with folio->mapping
> reset to NULL), but the folio_index() embedded in folio_contains() sees
> swapcache, and so returns the swapcache_index() - whereas folio->index
> would be the right one to check against the index from mapping's xarray.
> 
> There are different ways to fix this, but my preference is just to order
> the checks in invalidate_inode_pages2_range() the same way that they are
> in __filemap_get_folio() and find_lock_entries() and filemap_fault():
> check folio->mapping before folio_contains().
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>

Makes sense. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/truncate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/truncate.c b/mm/truncate.c
> index 95d1291d269b..c3320e66d6ea 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -657,11 +657,11 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
>  			}
>  
>  			folio_lock(folio);
> -			VM_BUG_ON_FOLIO(!folio_contains(folio, indices[i]), folio);
> -			if (folio->mapping != mapping) {
> +			if (unlikely(folio->mapping != mapping)) {
>  				folio_unlock(folio);
>  				continue;
>  			}
> +			VM_BUG_ON_FOLIO(!folio_contains(folio, indices[i]), folio);
>  			folio_wait_writeback(folio);
>  
>  			if (folio_mapped(folio))
> -- 
> 2.35.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
