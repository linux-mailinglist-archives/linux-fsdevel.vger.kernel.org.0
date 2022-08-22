Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A6159C8C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Aug 2022 21:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238582AbiHVT0M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Aug 2022 15:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238611AbiHVTYJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Aug 2022 15:24:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EC91583A;
        Mon, 22 Aug 2022 12:21:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD949B818AB;
        Mon, 22 Aug 2022 19:21:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532E8C433D7;
        Mon, 22 Aug 2022 19:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661196116;
        bh=mgWtjVWoyx6ivVv6KqvRp9PNUZE+61+wnocBktCea/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CIFs7w+cOjoG4BduE0LbUS1ENxhhjU7JJzqn72xXr+ZLB3RpzO/QkWWY3ng4xKySB
         YXFCYUBJtkKG/eskdtYg/+xKiscWgupSY2/uxcdx7uc8dwA8KxDcetGyqgmWWRoUil
         XYqsqkCEKihHOJiDYVY/gmdt8gPwBs8ROSzQSXnx8EATmxvwAn4uB5a0X+MZZDFBCv
         F1EGyec7neAHgHcZVfCqAKNaFBZNaaxOl1VYe1j0sGVtblXVdiUXVSTnOQEhS6tH/b
         XIUEqTfRRK4c8OPWdupcRVgBwEZmSKKXgPoHKkZQGh18LOwgjjXU42YapqtH7v7Csl
         1P4cEan3FnB1A==
Date:   Mon, 22 Aug 2022 12:21:54 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-ext4@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 0/2] ext4, f2fs: stop using PG_error for fscrypt and
 fsverity
Message-ID: <YwPXUrawcKdy9qDx@sol.localdomain>
References: <20220815235052.86545-1-ebiggers@kernel.org>
 <YwPKh9fWUJLnSEF/@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwPKh9fWUJLnSEF/@sol.localdomain>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 22, 2022 at 11:27:19AM -0700, Eric Biggers wrote:
> On Mon, Aug 15, 2022 at 04:50:50PM -0700, Eric Biggers wrote:
> > This series changes ext4 and f2fs to stop using PG_error to track
> > decryption and verity errors.  This is a step towards freeing up
> > PG_error for other uses, as discussed at
> > https://lore.kernel.org/linux-fsdevel/Yn10Iz1mJX1Mu1rv@casper.infradead.org
> > 
> > Note: due to the interdependencies with fs/crypto/ and fs/verity/,
> > I couldn't split this up into separate patches for each filesystem.
> > I'd appreciate Acks from the ext4 and f2fs maintainers so that I can
> > take these patches.  Otherwise I'm not sure how to move them forward.
> > 
> > Changed v1 => v2:
> >    - Rebased onto v6.0-rc1 and resolved conflicts in f2fs.
> > 
> > Eric Biggers (2):
> >   fscrypt: stop using PG_error to track error status
> >   fsverity: stop using PG_error to track error status
> > 
> >  fs/crypto/bio.c         | 16 +++++++----
> >  fs/ext4/readpage.c      | 16 +++++------
> >  fs/f2fs/compress.c      | 64 ++++++++++++++++++++---------------------
> >  fs/f2fs/data.c          | 64 +++++++++++++++++++++++------------------
> >  fs/verity/verify.c      | 12 ++++----
> >  include/linux/fscrypt.h |  5 ++--
> >  6 files changed, 93 insertions(+), 84 deletions(-)
> > 
> > 
> > base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
> 
> I'd appreciate review from the f2fs folks on this series, as that's where the
> most complex changes are.
> 

There's already a merge conflict with f2fs/dev, in the second patch :-(

It's going to be hard get this series merged, due to cross-tree dependencies.

I'll try to take the first patch (which handles decryption only, and is smaller)
through the fscrypt tree for 6.1.  Then maybe the second patch can go through
the f2fs tree later.

- Eric
