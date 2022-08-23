Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7950E59EBBC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 21:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbiHWTDC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 15:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233417AbiHWTCr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:02:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17AE6BD7D;
        Tue, 23 Aug 2022 10:35:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 391BD336D9;
        Tue, 23 Aug 2022 17:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661275917;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k0ks80j7Oad7m+qauu8Z4TAZTDJEgaZRum5ZNUCrL30=;
        b=BmFTIqCkILUYsistd/v/t7Wcameutnc6Uh9zOCOf8JiWKdWZ6Ajxyag5Vfq+mAm0hMDRTI
        YfLrlgi4viQHLwp1CtNqoahnMDfvcntiGAJXFEKd/yTEdyuX/9D3Hf3/DCfuzoEV5YTOKG
        GXzFYzN8tLbokoMi4obQN1l0IOuQXg0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661275917;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k0ks80j7Oad7m+qauu8Z4TAZTDJEgaZRum5ZNUCrL30=;
        b=VOQyCer4+nqwPdtU2qYRvacNJcaJjDV3YzIpYwxM1zcz/LIgk1uPCD2aN1aIJkgfVtMLaz
        2vIf0jsKUE6wJLAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE03713A89;
        Tue, 23 Aug 2022 17:31:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zWchOQwPBWOiTAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 23 Aug 2022 17:31:56 +0000
Date:   Tue, 23 Aug 2022 19:26:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] Convert to filemap_get_folios_contig()
Message-ID: <20220823172642.GJ13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220816175246.42401-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816175246.42401-1-vishal.moola@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 16, 2022 at 10:52:39AM -0700, Vishal Moola (Oracle) wrote:
> This patch series replaces find_get_pages_contig() with
> filemap_get_folios_contig(). I've run xfstests on btrfs. I've also
> tested the ramfs changes. I ran some xfstests on nilfs2, and its
> seemingly fine although more testing may be beneficial.
> ---
> 
> v2:
>   - Removed an unused label in nilfs2
> 
> Vishal Moola (Oracle) (7):
>   filemap: Add filemap_get_folios_contig()
>   btrfs: Convert __process_pages_contig() to use
>     filemap_get_folios_contig()
>   btrfs: Convert end_compressed_writeback() to use filemap_get_folios()
>   btrfs: Convert process_page_range() to use filemap_get_folios_contig()
>   nilfs2: Convert nilfs_find_uncommited_extent() to use
>     filemap_get_folios_contig()
>   ramfs: Convert ramfs_nommu_get_unmapped_area() to use
>     filemap_get_folios_contig()
>   filemap: Remove find_get_pages_contig()
> 
>  fs/btrfs/compression.c           | 26 ++++++------
>  fs/btrfs/extent_io.c             | 33 +++++++--------
>  fs/btrfs/subpage.c               |  2 +-
>  fs/btrfs/tests/extent-io-tests.c | 31 +++++++-------

I've tested the whole branch in my fstest setup, no issues found and
did a light review of the code changes, looks ok as well.

How do you want get the patches merged? As it's an API conversion I can
ack it and let it go via the mm tree. So far there are no conflicts with
our btrfs development patches, I assume it'll be a clean merge in the
future too.

>  fs/nilfs2/page.c                 | 39 ++++++++----------
>  fs/ramfs/file-nommu.c            | 50 ++++++++++++----------
>  include/linux/pagemap.h          |  4 +-
>  mm/filemap.c                     | 71 +++++++++++++++++++-------------
>  8 files changed, 134 insertions(+), 122 deletions(-)
> 
> -- 
> 2.36.1
