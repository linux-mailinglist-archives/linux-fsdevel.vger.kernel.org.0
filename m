Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010246671AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 13:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbjALMHu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 07:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbjALMHE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 07:07:04 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D804C762
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jan 2023 04:01:59 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 56D9334A31;
        Thu, 12 Jan 2023 12:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673524918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9Jnv7AxT2AW1qUNGcOFAcNJ68VOaO6yli3UdH9+R8r8=;
        b=eSkMLM6Ep5LO5WhAEh36iJl8EhFEfeofZ4ZTiccZUS4FbtvHLI2g3EAVhPsvzDB/UbLa7e
        TFDjMfOad/QQlKivJlGPfW/0KcTC8w1vmxE1w5fT6+zRLLA24RT6cc9ONjmZB9ORoVyK1s
        ERDBDxWX83C1Ihnn9ED+RvabqvSovjk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673524918;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9Jnv7AxT2AW1qUNGcOFAcNJ68VOaO6yli3UdH9+R8r8=;
        b=zErymu8GCywBbtT82CEGRdVi6XsFTq6wBykRYpiBiASp0pHsGUr/Wwnj9ynuXrTq8PiNNY
        ssyqHI93o1Ukb7AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 48F6813585;
        Thu, 12 Jan 2023 12:01:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eMnGEbb2v2M8PQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 12 Jan 2023 12:01:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C3767A0744; Thu, 12 Jan 2023 13:01:57 +0100 (CET)
Date:   Thu, 12 Jan 2023 13:01:57 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/12] Start converting buffer_heads to use folios
Message-ID: <20230112120157.7z4lq4enb4rkwc4f@quack3>
References: <20221215214402.3522366-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215214402.3522366-1-willy@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 15-12-22 21:43:50, Matthew Wilcox (Oracle) wrote:
> I was hoping that filesystems would convert from buffer_heads to iomap,
> but that's not happening particularly quickly.  So the buffer_head
> infrastructure needs to be converted from being page-based to being
> folio-based.  This is the initial patchset that I hope Andrew will take
> for 6.3.  I have a lot of followup patches, but many of them should go
> through individual filesystem trees (ext4, f2fs, etc).  They can wait
> for 6.4.

FWIW I went through all the patches and they look fine to me so feel free
to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> Matthew Wilcox (Oracle) (12):
>   buffer: Add b_folio as an alias of b_page
>   buffer: Replace obvious uses of b_page with b_folio
>   buffer: Use b_folio in touch_buffer()
>   buffer: Use b_folio in end_buffer_async_read()
>   buffer: Use b_folio in end_buffer_async_write()
>   page_io: Remove buffer_head include
>   buffer: Use b_folio in mark_buffer_dirty()
>   gfs2: Replace obvious uses of b_page with b_folio
>   jbd2: Replace obvious uses of b_page with b_folio
>   nilfs2: Replace obvious uses of b_page with b_folio
>   reiserfs: Replace obvious uses of b_page with b_folio
>   mpage: Use b_folio in do_mpage_readpage()
> 
>  fs/buffer.c                   | 54 +++++++++++++++++------------------
>  fs/gfs2/glops.c               |  2 +-
>  fs/gfs2/log.c                 |  2 +-
>  fs/gfs2/meta_io.c             |  2 +-
>  fs/jbd2/commit.c              |  8 ++----
>  fs/jbd2/journal.c             |  2 +-
>  fs/mpage.c                    |  2 +-
>  fs/nilfs2/btnode.c            |  2 +-
>  fs/nilfs2/btree.c             |  2 +-
>  fs/nilfs2/gcinode.c           |  2 +-
>  fs/nilfs2/mdt.c               |  4 +--
>  fs/nilfs2/segment.c           |  2 +-
>  fs/reiserfs/journal.c         |  4 +--
>  fs/reiserfs/tail_conversion.c |  2 +-
>  include/linux/buffer_head.h   |  5 +++-
>  mm/page_io.c                  |  1 -
>  16 files changed, 47 insertions(+), 49 deletions(-)
> 
> -- 
> 2.35.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
