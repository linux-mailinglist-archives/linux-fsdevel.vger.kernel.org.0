Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A92753C56
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jul 2023 15:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235844AbjGNN7G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jul 2023 09:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235849AbjGNN7F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jul 2023 09:59:05 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E47271E
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Jul 2023 06:59:02 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5774335bb2aso19521857b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Jul 2023 06:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689343142; x=1691935142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Swv5Bcf7XXC27U3qB8GpKA5mTHUh34P85QbbKegPGB8=;
        b=2xMiLXHwQaHNxTr8KmBQI+RIc0rKeCxMkpDxa0yTrXVekFKDfshFgoKK0BZ4DMkHSu
         7Uk2jWza42CZKliAlBhquMc1DLnvWtFLVEUa5vJLVJSwYDm3KXj5eBoNvmkFrMfCwIAv
         GMKnQI+LPUXE3Oxy1ruDFEKfJwIrseY4/SMB+despYIGmDIohGXYlMYV36BM9WJ8jerX
         caQT3Gm0YVfA8d1GcDlP6NGnaPoJSxh0flOGqH4C0+5Q3BSS3G5GbYMrrlDNi8S4S3js
         oebc7CqthteETUc1zMFLeD45Z6G6zeAz0EQ2wzwlmM6SvQdcXGi21egBq+NHfFf3KzG5
         EVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689343142; x=1691935142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Swv5Bcf7XXC27U3qB8GpKA5mTHUh34P85QbbKegPGB8=;
        b=U+mJ6jMxkD0fCV5/EtlY0oQv1c5r8EOvjqnI+ini05htfHwQnZDoxD5L+IzIf4x+yT
         BV6iljI8NpumjluVDDyMv5oWZ3Ne9DRdQ4yVJq8xpWAj0ThfCLhMMZ62InsVjdRrHLHF
         177+cIhxSWskhVzgpPIb1tZpaOCMZDhqcyyDyfmO/iPUuyWBmYVJOjrtCOVQDNOJPQW3
         wKi+fqdBEHqq2JTiiaPg0d6vWeBGTxJ2xHKbC2i0y1vM87Zv8BKPTgZeXFoF5GSq7zG2
         W+qcwUgTnN2ikjjyjKwKPFgFHEWzd8oQZAkQRAxGFDWtD1hZNV/bNp5a6nA53gePoE4Z
         M9Qw==
X-Gm-Message-State: ABy/qLZoiGDtkMrRCP5PQQ7TmjRFAlu9BVANsZnHpxqYFromjIBaoWT0
        S/VKUzv6aF1nLchUZLhgSXw1ihK7KLw0fn+Dx8VT/g==
X-Google-Smtp-Source: APBJJlFDMPv1jG+Hay7j6nblVJVsh4NVm+K/lDNnBfKgLSv4oj3inyJq9GzH4hMZJZTgUCwym0NSpw==
X-Received: by 2002:a0d:e647:0:b0:568:e6d9:7c1a with SMTP id p68-20020a0de647000000b00568e6d97c1amr4717324ywe.4.1689343141815;
        Fri, 14 Jul 2023 06:59:01 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id v72-20020a81484b000000b00569ff2d94f6sm2319083ywa.19.2023.07.14.06.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 06:59:01 -0700 (PDT)
Date:   Fri, 14 Jul 2023 09:59:00 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: small writeback fixes
Message-ID: <20230714135900.GE338010@perftesting>
References: <20230713130431.4798-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713130431.4798-1-hch@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 13, 2023 at 03:04:22PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series has various fixes for bugs found in inspect or only triggered
> with upcoming changes that are a fallout from my work on bound lifetimes
> for the ordered extent and better confirming to expectations from the
> common writeback code.
> 
> Note that this series builds on the "btrfs compressed writeback cleanups"
> series sent out previously.
> 
> A git tree is also available here:
> 
>     git://git.infradead.org/users/hch/misc.git btrfs-writeback-fixes
> 
> Gitweb:
> 
>     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/btrfs-writeback-fixes
> 
> Diffatat:
>  extent_io.c |  182 ++++++++++++++++++++++++++++++++++++------------------------
>  inode.c     |   16 +----
>  2 files changed, 117 insertions(+), 81 deletions(-)

You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to the series, thanks,

Josef
