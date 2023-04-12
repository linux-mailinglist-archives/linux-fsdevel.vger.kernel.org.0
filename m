Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D306DF409
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Apr 2023 13:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjDLLp3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Apr 2023 07:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjDLLp2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:45:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3AC9C;
        Wed, 12 Apr 2023 04:45:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D9E251F890;
        Wed, 12 Apr 2023 11:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681299925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mESrJnTzm2y58henCgzCU9PCm8C7jVKTEVEsRs//lzk=;
        b=BbgVtPjM9egpg70/sSFltKsb64f/A8zX+kVtG3nQ8E54BE1yiZvlNZXgxwRrSqSMmbMlfI
        TWnUkqjIEzZZAevly8G0KmNVqoThiIZYOQlbe3lcH6gSOLvAPThNlbHvu+S9UpJWA8Tibb
        A7yrANkRutl8YwOBrmKevFghYRaUIec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681299925;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mESrJnTzm2y58henCgzCU9PCm8C7jVKTEVEsRs//lzk=;
        b=wGvKfFAI76TLGeAd12Lo2SRdD1zJV07HuOk2NWoe4dLqrP4CQAfZ/dkt/zKkWwb0Hpa4Gm
        AmrQxOgYXNwLC6AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CDF3913498;
        Wed, 12 Apr 2023 11:45:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SMM4MtWZNmQtQAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 12 Apr 2023 11:45:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 620DAA0732; Wed, 12 Apr 2023 13:45:25 +0200 (CEST)
Date:   Wed, 12 Apr 2023 13:45:25 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>
Subject: Re: [RFCv2 0/8] ext2: DIO to use iomap
Message-ID: <20230412114525.m7rjvq3pr3aad2al@quack3>
References: <cover.1681188927.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1681188927.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Ritesh!

On Tue 11-04-23 10:51:48, Ritesh Harjani (IBM) wrote:
> Please find the series which moves ext2 direct-io to use modern iomap interface.
> 
> Here are some more details -
> 1. Patch-1: Fixes a kernel bug_on problem with ext2 dax code (found during code
>    review and testing).
> 2. Patch-2: Adds a __generic_file_fsync_nolock implementation as we had
>    discussed.
> 3. Patch-3 & Patch-4: Moves ext4 nojournal and ext2 to use _nolock method.
> 4. Patch-5: This is the main patch which moves ext2 direct-io to use iomap.
>    (more details can be found in the patch)
> 5. Patch-6: Kills IOMAP_DIO_NOSYNC flag as it is not in use by any filesystem.
> 6. Patch-7: adds IOCB_STRINGS macro for use in trace events for better trace
>    output of iocb flags.
> 7. Patch-8: Add ext2 trace point for DIO.
> 
> Testing:
> =========
> This passes ext2 "auto" group testing for fstests. There were no new failures
> with this patches.

I went through the patches and I have no further comments besides what has
been already said. So feel free to update patches based on other feedback,
I'll do the last round of review and can queue the patches to my tree.

								Honza

> 
> 
> Ritesh Harjani (IBM) (8):
>   ext2/dax: Fix ext2_setsize when len is page aligned
>   libfs: Add __generic_file_fsync_nolock implementation
>   ext4: Use __generic_file_fsync_nolock implementation
>   ext2: Use __generic_file_fsync_nolock implementation
>   ext2: Move direct-io to use iomap
>   iomap: Remove IOMAP_DIO_NOSYNC unused dio flag
>   fs.h: Add IOCB_STRINGS for use in trace points
>   ext2: Add direct-io trace points
> 
>  fs/ext2/Makefile      |   2 +-
>  fs/ext2/ext2.h        |   1 +
>  fs/ext2/file.c        | 127 +++++++++++++++++++++++++++++++++++++++++-
>  fs/ext2/inode.c       |  57 +++++++++++--------
>  fs/ext2/trace.c       |   5 ++
>  fs/ext2/trace.h       |  61 ++++++++++++++++++++
>  fs/ext4/fsync.c       |  31 +++++------
>  fs/iomap/direct-io.c  |   2 +-
>  fs/libfs.c            |  43 ++++++++++++++
>  include/linux/fs.h    |  15 +++++
>  include/linux/iomap.h |   6 --
>  11 files changed, 303 insertions(+), 47 deletions(-)
>  create mode 100644 fs/ext2/trace.c
>  create mode 100644 fs/ext2/trace.h
> 
> --
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
