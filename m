Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B53759C61F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Aug 2022 20:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237279AbiHVS1b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Aug 2022 14:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236362AbiHVS1X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Aug 2022 14:27:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D294C481F8;
        Mon, 22 Aug 2022 11:27:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61230612CA;
        Mon, 22 Aug 2022 18:27:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F3CBC433D6;
        Mon, 22 Aug 2022 18:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661192841;
        bh=Gh6irQCwtsKJ6eFKCfceqRMjx+rmz6M385gr7IrGoEk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=huOKrEA5mAlbzWgfvLn+VqRshn8OpPAHYhDTxEDynERxlmvcaSI3WtGM1asCy+ca3
         z3TbWV2YoqflNyuA5fCnQGXkNhfvFB5CK0HLqSqQWbu0VfxJAoTnRzNJfs+tJaFELc
         PXlG3bqP/YWzlUMyq0UMO4r7l778/b7RwdYEqIxxNftqqCNf44mU9reP/VLBiQncfk
         tvCLkZHFQFrMQZqQuqsffn0Q/fYb8+fDBcfVCUFsGYUGQXZEb6RBy5BBI44dJ32SX7
         VAXKH4EI3h5wanmVvEV1wIRcnuL0HZes0VDiLp7TgaBcGF7/zDfWrl+poZ6EyUOvng
         85wGjO2B7Qi+w==
Date:   Mon, 22 Aug 2022 11:27:19 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 0/2] ext4, f2fs: stop using PG_error for fscrypt and
 fsverity
Message-ID: <YwPKh9fWUJLnSEF/@sol.localdomain>
References: <20220815235052.86545-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815235052.86545-1-ebiggers@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 15, 2022 at 04:50:50PM -0700, Eric Biggers wrote:
> This series changes ext4 and f2fs to stop using PG_error to track
> decryption and verity errors.  This is a step towards freeing up
> PG_error for other uses, as discussed at
> https://lore.kernel.org/linux-fsdevel/Yn10Iz1mJX1Mu1rv@casper.infradead.org
> 
> Note: due to the interdependencies with fs/crypto/ and fs/verity/,
> I couldn't split this up into separate patches for each filesystem.
> I'd appreciate Acks from the ext4 and f2fs maintainers so that I can
> take these patches.  Otherwise I'm not sure how to move them forward.
> 
> Changed v1 => v2:
>    - Rebased onto v6.0-rc1 and resolved conflicts in f2fs.
> 
> Eric Biggers (2):
>   fscrypt: stop using PG_error to track error status
>   fsverity: stop using PG_error to track error status
> 
>  fs/crypto/bio.c         | 16 +++++++----
>  fs/ext4/readpage.c      | 16 +++++------
>  fs/f2fs/compress.c      | 64 ++++++++++++++++++++---------------------
>  fs/f2fs/data.c          | 64 +++++++++++++++++++++++------------------
>  fs/verity/verify.c      | 12 ++++----
>  include/linux/fscrypt.h |  5 ++--
>  6 files changed, 93 insertions(+), 84 deletions(-)
> 
> 
> base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868

I'd appreciate review from the f2fs folks on this series, as that's where the
most complex changes are.

- Eric
