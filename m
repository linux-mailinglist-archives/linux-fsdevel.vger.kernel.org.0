Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B92F68A515
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Feb 2023 22:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbjBCV6Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Feb 2023 16:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233888AbjBCV6O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Feb 2023 16:58:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C4A79CAE;
        Fri,  3 Feb 2023 13:57:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C99F6200E;
        Fri,  3 Feb 2023 21:57:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9ABC433D2;
        Fri,  3 Feb 2023 21:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675461473;
        bh=FovPIQM6HFKOKI1lzW4J7FSLHFT+bkGyLmq55x6SG7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OYUbcZH0ZCBGSKlJil0dsPrgMpYPFO78WNXNSEDsIC2Ii0sSq21VgJ4io2YRuyVdj
         VLaltmnqze8tx9ts0rN5xovk3UCDYUZ7PCeMdt03RXwUFXUYW8RIt3mXBnsTDeLJ7b
         YFnptCIh0vmtbRuGZNV+v27GdRhCVIjzss746nHrXvnv6YE5mdzy3OBZlRJwKFWhF+
         282/9kXyIlo+sruhVLj4UnufGPc0kXb9/3LJ0e95TwkyIS2xQQKrChvk6tfQzwPms0
         8SBefQAaAcyraOueuAALeXKMtfoUOCsd4aB+/OC+UEGsmEXbjXlK24+daIw9enbhwp
         eQVhnACGqzXEg==
Date:   Fri, 3 Feb 2023 13:57:51 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] fscrypt: support decrypting data from large folios
Message-ID: <Y92DX1eB9HT58YJ1@sol.localdomain>
References: <20230127224202.355629-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127224202.355629-1-ebiggers@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 27, 2023 at 02:42:02PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Try to make the filesystem-level decryption functions in fs/crypto/
> aware of large folios.  This includes making fscrypt_decrypt_bio()
> support the case where the bio contains large folios, and making
> fscrypt_decrypt_pagecache_blocks() take a folio instead of a page.
> 
> There's no way to actually test this with large folios yet, but I've
> tested that this doesn't cause any regressions.
> 
> Note that this patch just handles *decryption*, not encryption which
> will be a little more difficult.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  Documentation/filesystems/fscrypt.rst |  4 ++--
>  fs/buffer.c                           |  4 ++--
>  fs/crypto/bio.c                       | 10 ++++------
>  fs/crypto/crypto.c                    | 28 ++++++++++++++-------------
>  fs/ext4/inode.c                       |  6 ++++--
>  include/linux/fscrypt.h               |  9 ++++-----
>  6 files changed, 31 insertions(+), 30 deletions(-)

Applied to https://git.kernel.org/pub/scm/fs/fsverity/linux.git/log/?h=for-next

(I used the fsverity tree instead of the fscrypt tree, so that I could resolve
the conflict with "fs/buffer.c: support fsverity in block_read_full_folio()" in
the fsverity tree.)

- Eric
