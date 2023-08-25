Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C9A787D5E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 03:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236914AbjHYB4o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Aug 2023 21:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239670AbjHYB4i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Aug 2023 21:56:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40900A8
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Aug 2023 18:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zGOmB18RB1OY5AGgTsleumk2XgvNgUMI8iEL9xumJk0=; b=ZXvSVtmTyf6k6h6o4XNApeq6M/
        d4w7hC/lTkT+pCjDE23uFVXoFt69E9bn5T2kuJWhbfLFk/1mAwKyhPUxu4OQJX3ytUHtTxfxN1enb
        bRBjaWDq0jfSeENUAyqpL/Sju4/HAHtemBgg5p2Dy76FRoPv4gk+OYJhVwMLCz2nAztWGiTIGy/6u
        Isf1Hjh2oxdnb/g1jGj54l64m4odwRujObylUra0tMDRPbqM93afXB5PkefPcVWxrX1Oj4cjuWit+
        JIj+K8V0NiFUXOVGbGAndfMUWrX6w2b8i0dD14T4rI/UijI7zLCtPiVjXsgvw9MJbbgtH5g5rc9qu
        jmG95iFg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qZM3o-00EMuv-Hq; Fri, 25 Aug 2023 01:56:28 +0000
Date:   Fri, 25 Aug 2023 02:56:28 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Atul Raut <rauji.raut@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+e295147e14b474e4ad70@syzkaller.appspotmail.com
Subject: Re: pagevec: Fix array-index-out-of-bounds error
Message-ID: <ZOgKTO612u1Fn7PB@casper.infradead.org>
References: <20230825001720.19101-1-rauji.raut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825001720.19101-1-rauji.raut@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 24, 2023 at 05:17:21PM -0700, Atul Raut wrote:
>  ntfs_evict_inode+0x20/0x48 fs/ntfs3/inode.c:1790

No.  This is your clue.  ntfs corrupts memory.  You can't take bug
reports involving ntfs seriously.  Ignore everything tagged with ntfs.

> In folio_batch_add, which contains folios rather
> than fixed-size pages, there is a chance that the
> array index will fall outside of bounds.
> Before adding folios, examine the available space to fix.

This is definitely the wrong fix.

>  static inline unsigned folio_batch_add(struct folio_batch *fbatch,
>  		struct folio *folio)
>  {
> -	fbatch->folios[fbatch->nr++] = folio;
> +	if (folio_batch_space(fbatch))
> +		fbatch->folios[fbatch->nr++] = folio;

Did you look at what folio_batch_space() actually does?

static inline unsigned int folio_batch_space(struct folio_batch *fbatch)
{
        return PAGEVEC_SIZE - fbatch->nr;
}

So if fbatch->nr is 255, what will it return?  How will
folio_batch_add() behave?

The right way to fix this problem is to find the data corrupter in NTFS.
You can't "fix" it anywhere else.
