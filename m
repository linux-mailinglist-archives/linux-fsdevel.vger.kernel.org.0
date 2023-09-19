Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DBE7A6458
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 15:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbjISNGr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 09:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjISNGq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:06:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438A1EC;
        Tue, 19 Sep 2023 06:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vG4Tzf8kO0LcYLw+cZi1qYlZspJjy+O6YTZUkpkEyuI=; b=CIE0ya6ucqYQAvryNkDuSTAm9k
        NPgkr3zmhN8Hban2XWHPThsg9/nlIp/ZAtOQIz4Fvp5UOCY8y8q3jv0twkC/5m8C3icPQZxCaFhuw
        aYuHM8P8bwzXylhGBHqoh48NXEt3+0zyDlDxbZq4vJTH1AWpS+0PiivpHN5lyNtpkL1ib7zU/Q6kj
        khYJAPWBVNSzhlkoZlqQwpyBYZwRtybWua479pBO6mACsk43W5DcjN1kPcpusDM956b0LAMqnQYc9
        nm3C4rann0EzGNbm9waRDU9NV/S7jfcHa1zapYylXuZQ5YxiU3iI23KOQowBjNVLjVQFKhaVCPTjj
        oXJZFWfA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qiaR3-00HMAE-Fa; Tue, 19 Sep 2023 13:06:37 +0000
Date:   Tue, 19 Sep 2023 14:06:37 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        reiserfs-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 11/26] nilfs2: Convert nilfs_copy_page() to
 nilfs_copy_folio()
Message-ID: <ZQmc3VHOIh3jOG8Z@casper.infradead.org>
References: <20230919045135.3635437-1-willy@infradead.org>
 <20230919045135.3635437-12-willy@infradead.org>
 <CAKFNMonjfsWBageg6vfWok9vvNEzjhXiqCCb+=cDFuwnTER95A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKFNMonjfsWBageg6vfWok9vvNEzjhXiqCCb+=cDFuwnTER95A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 19, 2023 at 10:01:27PM +0900, Ryusuke Konishi wrote:
> When I tried to test the patchset against 6.6-rc2, I encountered the
> following error during the build:
> 
>  ERROR: modpost: "folio_copy" [fs/nilfs2/nilfs2.ko] undefined!
> 
> It looks like "folio_copy" is not exported to modules.
> 
> I'll correct this manually for now and proceed with the review and
> testing, but could you please fix this build issue in some way ?

Thanks!  I'll export the symbol.  I did build nilfs2 as a module, but I
just did it with "make fs/" which doesn't run modpost.  Appreciate the
testing.
