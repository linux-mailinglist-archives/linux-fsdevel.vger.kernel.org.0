Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E7767D2F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 18:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjAZRYs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 12:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjAZRYr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 12:24:47 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF2FEF9F;
        Thu, 26 Jan 2023 09:24:46 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id 3so2629967vsq.7;
        Thu, 26 Jan 2023 09:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qHlmTunQ49C1Dpyk77Z4C3k4Cau4j+Xb//Hx9WL7A8k=;
        b=FcVVUD0R+CepEE82KTwR5p856vdMWJsT8H3faHwVqVudmDdIF4Lcfrg/SHWvuzVpWF
         KA1kLRC9qaFiYMLpexmhNHDdgVJLefzkTqzrfB096e/Nh7scJpPIASgZfXzCCsgbBObo
         BTqxf3peJlRY1R6MhO6OJbfFx0Fc5aAcwVL0v0vA9EkBPvf6OfaJbVZgOVqaqXDtAmd+
         bLwYoW1Us2QDe+hiDLMCAN7ceajba131vdEy/eZtQwB7bSeqLgQdh+6Q6+S2vwIvhii5
         yyOMBLagGZW37aZdWToQMqAEtPdoBK0EhksXhUNvoEWT6160ijCRlx0xf8Wmnr7UcnYZ
         WzAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qHlmTunQ49C1Dpyk77Z4C3k4Cau4j+Xb//Hx9WL7A8k=;
        b=pf8Yytdpg6y1JgNYatU9+FAF8UQgIsELYqqJAfDhyGdep36vFt7yHttlDBvBTo9Ib7
         g7h1jtRZnX0y7IYwAyP2qaQEHt9EO5hVZeKG6cpi6f7MtcRqOUXHZGFoZ5UGsVBAEYMF
         AK7mXe8XJfeQsWKDR3S548DDEaZSIhNyjcFyLe6h8M5aq4mo/U3atu4crrRmhB8V20GC
         tzPVOy468ZPvEWVHF8CyI5rlK1QlddW4URHHoXMZGO3gxnwbmNJuStmH+esEG8AUS92P
         86hqlXz5moURlSJe08Q6rzL8E0UyVPge1iKa7+ZtfzQvbDHc8pnqzWELJP1f3tlPy7qb
         aSxw==
X-Gm-Message-State: AFqh2kowFnTA2Vc2KUgHpFELMxQkp6T20yFsXi5WRS4cLp5UZSaiWWoj
        ME6ZqQd8h7wVLux88lJ7+LaJJ9pKhGaNIpdiWQlbuTXX8kY=
X-Google-Smtp-Source: AMrXdXstMx4Lc6leAXpj1VV45UXIVItPQZcy2o9t6/kD/JJrrhSQhYl4SzeJqctMxVoXgA7/dxFlIFpz/owb7AnAd4Y=
X-Received: by 2002:a05:6102:6c2:b0:3ce:bced:178 with SMTP id
 m2-20020a05610206c200b003cebced0178mr4927618vsg.84.1674753885888; Thu, 26 Jan
 2023 09:24:45 -0800 (PST)
MIME-Version: 1.0
References: <20230121065755.1140136-1-hch@lst.de> <20230121065755.1140136-8-hch@lst.de>
In-Reply-To: <20230121065755.1140136-8-hch@lst.de>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Fri, 27 Jan 2023 02:24:29 +0900
Message-ID: <CAKFNMonfM+=1vbqKgS3feW7Xyh=P6UdDu0RrnOYQrb+WhN+_Vw@mail.gmail.com>
Subject: Re: [PATCH 7/7] mm: return an ERR_PTR from __filemap_get_folio
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        cluster-devel@redhat.com, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nilfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 21, 2023 at 3:59 PM Christoph Hellwig wrote:
>
> Instead of returning NULL for all errors, distinguish between:
>
>  - no entry found and not asked to allocated (-ENOENT)
>  - failed to allocate memory (-ENOMEM)
>  - would block (-EAGAIN)
>
> so that callers don't have to guess the error based on the passed
> in flags.
>
> Also pass through the error through the direct callers:
> filemap_get_folio, filemap_lock_folio filemap_grab_folio
> and filemap_get_incore_folio.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

For

>  fs/nilfs2/page.c         |  6 +++---

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Thanks,
Ryusuke Konishi
