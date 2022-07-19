Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5D457A6BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jul 2022 20:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238680AbiGSStb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jul 2022 14:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237103AbiGSSta (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jul 2022 14:49:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109AA564C2;
        Tue, 19 Jul 2022 11:49:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C7BA61639;
        Tue, 19 Jul 2022 18:49:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE970C341C6;
        Tue, 19 Jul 2022 18:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658256568;
        bh=/K91o+qKLCbtKDi3/tG73ZWIzxIa2IRxn4bwgg8SU6s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TsFKLx4sa6WI7xRr8hTRSHdiETDX2u3xEXj/tlEC+1Mu31zXJrvYI9xURGhNqpvv9
         Xw5+dYbEKmi3mHt6FnWaQjGenneQUuX/FaRUs10zZ81E+9Jerlw+s9wJ0+Ajm/ra14
         5aJMLLJs7mEPG03TE9mbq4q9RQy+Ua/jQ6IeRIqDpdZ3l37548dMP/JJKn4eapN21r
         gk900x3bkTn5tkq9RZghLYoJ3Xh1rP2qIWVmhtwpA77VS5HuTiLxV/xiGroLDuWidY
         CZxany2wmb4+hrU1m+Jc0SClz/Dv39lFIVoaPIPexo8HhhCRJEbmqteDXodOOeOxeE
         12Nwjs9wLN4RA==
Date:   Tue, 19 Jul 2022 11:49:27 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 0/2] ext4, f2fs: stop using PG_error for fscrypt and
 fsverity
Message-ID: <Ytb8typAESKplJAN@sol.localdomain>
References: <20220627065050.274716-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627065050.274716-1-ebiggers@kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 26, 2022 at 11:50:48PM -0700, Eric Biggers wrote:
> This series changes ext4 and f2fs to stop using PG_error to track
> decryption and verity errors.  This is a step towards freeing up
> PG_error for other uses, as discussed at
> https://lore.kernel.org/linux-fsdevel/Yn10Iz1mJX1Mu1rv@casper.infradead.org
> 
> Note: due to the interdependencies with fs/crypto/ and fs/verity/, I
> couldn't split this up into separate patches for each filesystem.
> 
> Eric Biggers (2):
>   fscrypt: stop using PG_error to track error status
>   fsverity: stop using PG_error to track error status
> 
>  fs/crypto/bio.c         | 16 +++++++----
>  fs/ext4/readpage.c      | 16 +++++------
>  fs/f2fs/compress.c      | 61 ++++++++++++++++++++---------------------
>  fs/f2fs/data.c          | 60 +++++++++++++++++++++-------------------
>  fs/verity/verify.c      | 12 ++++----
>  include/linux/fscrypt.h |  5 ++--
>  6 files changed, 88 insertions(+), 82 deletions(-)
> 
> 
> base-commit: 0840a7914caa14315a3191178a9f72c742477860

Any thoughts on this patchset from anyone?

- Eric
