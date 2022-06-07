Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9783C53FD9F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 13:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243030AbiFGLha (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 07:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243011AbiFGLh2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 07:37:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B85DFD3;
        Tue,  7 Jun 2022 04:37:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63FF8B81F6A;
        Tue,  7 Jun 2022 11:37:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B4A4C385A5;
        Tue,  7 Jun 2022 11:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654601841;
        bh=8ssLmPCQc0kBEOnMpM83QxMMmjw3G4wZmE/Q52LHRZ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ulrnZ3VWWAYqxXyKMLlRANtahVN2YqNjS+95EKiyA31F59Kxv56ZxZvJeFNL2v8u2
         HARW/OKmP9vrlxSdZNnaH3ij+7H8UlnfzOCQ1oxjz9vjsiisWeP8YGHgOUWaKE3RXJ
         0Qgq8LuNiEDX/vIkZ2FV2oYFDoYmwavNlOFsB8uPO+joCcntqxsuAWdrO2LcLkXq03
         5jcBhpDEojRYyn7qDO7vem729Q325Cpl+yLlRoju9/CWrk0f33UnA9Hak8u2vJNDYY
         93upScTvvcZE6v6bgLLYedRNMRE70uLsyv1JUV94v403BBEPVF5OmKnH6DlbYWYvUg
         /f4lOE8iShQ3Q==
Date:   Tue, 7 Jun 2022 13:37:16 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mm@kvack.org, linux-nilfs@vger.kernel.org
Subject: Re: [PATCH 00/10] Convert to filemap_get_folios()
Message-ID: <20220607113716.aec2o7onzu3re2o4@wittgenstein>
References: <20220605193854.2371230-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220605193854.2371230-1-willy@infradead.org>
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 05, 2022 at 08:38:44PM +0100, Matthew Wilcox wrote:
> This patch series removes find_get_pages_range(), pagevec_lookup()
> and pagevec_lookup_range(), converting all callers to use the new
> filemap_get_folios().  I've only run xfstests over ext4 ... some other
> testing might be appropriate.
> 
> Matthew Wilcox (Oracle) (10):
>   filemap: Add filemap_get_folios()
>   buffer: Convert clean_bdev_aliases() to use filemap_get_folios()
>   ext4: Convert mpage_release_unused_pages() to use filemap_get_folios()
>   ext4: Convert mpage_map_and_submit_buffers() to use
>     filemap_get_folios()
>   f2fs: Convert f2fs_invalidate_compress_pages() to use
>     filemap_get_folios()
>   hugetlbfs: Convert remove_inode_hugepages() to use
>     filemap_get_folios()
>   nilfs2: Convert nilfs_copy_back_pages() to use filemap_get_folios()
>   vmscan: Add check_move_unevictable_folios()
>   shmem: Convert shmem_unlock_mapping() to use filemap_get_folios()
>   filemap: Remove find_get_pages_range() and associated functions
> 
>  fs/buffer.c             | 26 +++++++--------
>  fs/ext4/inode.c         | 40 ++++++++++++-----------
>  fs/f2fs/compress.c      | 35 +++++++++-----------
>  fs/hugetlbfs/inode.c    | 44 ++++++++-----------------
>  fs/nilfs2/page.c        | 60 +++++++++++++++++-----------------
>  include/linux/pagemap.h |  5 ++-
>  include/linux/pagevec.h | 10 ------
>  include/linux/swap.h    |  3 +-
>  mm/filemap.c            | 72 +++++++++++++++++------------------------
>  mm/shmem.c              | 13 ++++----
>  mm/swap.c               | 29 -----------------
>  mm/vmscan.c             | 55 ++++++++++++++++++-------------
>  12 files changed, 166 insertions(+), 226 deletions(-)

The conversion seems fairly straightforward, so looks good to me.
Acked-by: Christian Brauner (Microsoft) <brauner@kernel.org>
