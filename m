Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B62B6E3D71
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 04:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjDQC1c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Apr 2023 22:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjDQC1b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Apr 2023 22:27:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E27B2136;
        Sun, 16 Apr 2023 19:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=msiZ6WOWh9wYm2rgjnQHKfX3Kq3D4bGwJU71qMcPnJ4=; b=iGcPEtF5QzvOLyPzaLt8fcJh2m
        0Rq+8ns3zLjAFbbL2aPK2iSbHXmfxiz5wuOcVEMzDmN/LdrGCwnLrZh3YdaY+CIPmHwo3r0PPrF/0
        skI5fKi7HUQMoCGrxUDOso/qn58hHllRGeSSL/D06UPgPtJaZOZraIEnYjGratkP1W0ZFL7Qw3G3s
        aGpfaiulpzl06117hh5a6mOj+kw6pM06G5Mi00OlApM3ycjq7Ea46WqPOlYbvnnsEWK1SUFJbCIHg
        3HMvlpWQmqo+JHI116oQRWKJ1kRL6we/ZhzvFN+QpOhk5GpTuZj8OJFhv3wj6vY+uac2Q6uVnoRMe
        ScsAD2IA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1poEaM-00Eh1s-1B;
        Mon, 17 Apr 2023 02:27:18 +0000
Date:   Sun, 16 Apr 2023 19:27:18 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Pankaj Raghav <p.raghav@samsung.com>, brauner@kernel.org,
        willy@infradead.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [RFC 0/4] convert create_page_buffers to create_folio_buffers
Message-ID: <ZDyuhmcc9OeJGUcJ@bombadil.infradead.org>
References: <CGME20230414110825eucas1p1ed4d16627889ef8542dfa31b1183063d@eucas1p1.samsung.com>
 <20230414110821.21548-1-p.raghav@samsung.com>
 <1e68a118-d177-a218-5139-c8f13793dbbf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e68a118-d177-a218-5139-c8f13793dbbf@suse.de>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 14, 2023 at 03:47:13PM +0200, Hannes Reinecke wrote:
> @@ -2333,13 +2395,15 @@ int block_read_full_folio(struct folio *folio,
> get_block_t *get_block)
>         if (IS_ENABLED(CONFIG_FS_VERITY) && IS_VERITY(inode))
>                 limit = inode->i_sb->s_maxbytes;
> 
> -       VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
> -
>         head = create_folio_buffers(folio, inode, 0);
>         blocksize = head->b_size;
>         bbits = block_size_bits(blocksize);
> 
> -       iblock = (sector_t)folio->index << (PAGE_SHIFT - bbits);
> +       if (WARN_ON(PAGE_SHIFT < bbits)) {
> +               iblock = (sector_t)folio->index >> (bbits - PAGE_SHIFT);
> +       } else {
> +               iblock = (sector_t)folio->index << (PAGE_SHIFT - bbits);
> +       }
>         lblock = (limit+blocksize-1) >> bbits;
>         bh = head;
>         nr = 0;

BTW I See this pattern in:

fs/mpage.c: do_mpage_readpage()
fs/mpage.c: __mpage_writepage()

A helper might be in order.

  Luis
