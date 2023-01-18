Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B670671D4C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 14:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjARNQJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 08:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjARNPQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:15:16 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEEC4ABCB;
        Wed, 18 Jan 2023 04:39:26 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id b18so2229139uan.11;
        Wed, 18 Jan 2023 04:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DJFKWs0jtm8hl4SVQnbbNh8Row9y5eHKj6s/8aaU3Dc=;
        b=izjy3J56LC2vDJ9QPNh4r4lgIxhWhk1J56p6SfOTDw2JZkn+shbwEwoyXp21gR6yxR
         1rY5IuMxP6MS311QQBVzqoNh+OXoUk/450On2SRyTzaCdYuhaCV/VWrcRd6YQe9E4EFO
         y0DYwqLcbbz/6VYh6GmLrfe25EswlJWkHji8ax2XQ+oyYKDLPTOi1mwhb3lRlfasv7Kv
         KG2zT54RLJ6wzWC4fCTrNXJr8pMNMgLlb4L2sW9/dtxmd4S26UoGO7IX9U3gMldE73fm
         1BVMC3SihRKssJhAXbmOG7SeNX1kZZqCeUaEi4MYMU/1VGkTr0TAQCkY+z5LiJCYouV4
         lZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DJFKWs0jtm8hl4SVQnbbNh8Row9y5eHKj6s/8aaU3Dc=;
        b=5Fi/K2eaECFenOCM1mEAdoNFHi1jF+b2NUE2FFqouJYbIevO2Al2bR60PXNi1ZX1zt
         i4+8HR2o3TJAeDmvI2xI+ZgaHQMrYVNJIO2zMlq1YGAU3diGHIoY+c16TdLnZVqrM1TE
         8EunOCKgANZbeS71qOY5spK1EePoEeiLHP/Sw7zBxRVfHkIGPPCWRyKMIyMFsFfTP86y
         Qx0dZRHy+puuXyBHdwb2RHeqr/9jCO0/NkK7zHOu8en0BdIf/0M50qD9CNTQv6devJx4
         fo2SXU6m76AIXwRM6tdvFdB34Ap1l21AsDD1GumL33dYr6ITsfwMOIH8CHK2FipotiKp
         1ucw==
X-Gm-Message-State: AFqh2kpGco+d4PxiqD9k/63zuKEQvEA9zAbqKK+cni0EnPtz11QBRexF
        X/gDk6fcXFVyjaaSrZSA8HPU/gdZtWzWs9jh7gw=
X-Google-Smtp-Source: AMrXdXuYI0XqwMDQVyPl+VYMuyHTTEt0gz5eK89H6wdmtU2BkYDhCb6M0sSqHefS5y6aUxLq2IwbOZgPl/R9bgjDaww=
X-Received: by 2002:ab0:278a:0:b0:5f4:34e9:f5a4 with SMTP id
 t10-20020ab0278a000000b005f434e9f5a4mr745938uap.51.1674045565693; Wed, 18 Jan
 2023 04:39:25 -0800 (PST)
MIME-Version: 1.0
References: <20230118094329.9553-1-hch@lst.de> <20230118094329.9553-10-hch@lst.de>
In-Reply-To: <20230118094329.9553-10-hch@lst.de>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Wed, 18 Jan 2023 21:39:08 +0900
Message-ID: <CAKFNMomcjvUSh-nS1MqptYdiT-1frRsmHgx2mHBBm_588kprrQ@mail.gmail.com>
Subject: Re: [PATCH 9/9] mm: return an ERR_PTR from __filemap_get_folio
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

On Wed, Jan 18, 2023 at 7:41 PM Christoph Hellwig wrote:
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

As for the comments describing the return values of these callers,
isn't it necessary to rewrite the value from NULL in case of errors ?

Regards,
Ryusuke Konishi
