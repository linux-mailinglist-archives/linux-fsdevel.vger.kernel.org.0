Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BCF4C16AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 16:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242004AbiBWP0F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 10:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbiBWP0B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 10:26:01 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD56473B5;
        Wed, 23 Feb 2022 07:25:33 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-2d07ae0b1c4so214821327b3.11;
        Wed, 23 Feb 2022 07:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1BZ0n/VXuB4e+b9N79/HKBcV1lFL5+uSe4QaX/5c2kY=;
        b=V2NZd/1W3V3wsR/bZWYyX1ajF8T1xlMT/2MYjmionIym5JJTz6F7twH//YkxTeQXF0
         Kl20Sy5kTW/v6HoyzBLeCETx+N4AdOINs6qDKzRuG3W2fy+aXUDyv/m0zaPGncxe4I1u
         U3bUQiCGDQpT7A01SNUUM6g6qEuhVWOb/IRTr1AI0+1n8G8QcByT00Xo3SRhCOth+fsj
         y4xWLsZaDWB88jTXzBz44uVgddZfj/PLsM6onazKGdpTpjZPWMnoX9w615Dmc0u99a7t
         s0YnWE+yLWNVg3lL3Wg9hc5WjZwM0qWAWiMX9IUwTjThS7HKVT6Rog9SkZEqohzBzPNd
         5YYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1BZ0n/VXuB4e+b9N79/HKBcV1lFL5+uSe4QaX/5c2kY=;
        b=bGuJSTPBBfWFv5yy3GtmyPAo6JIOVnsOewYZLDHcedHRl3P/Z9MIwGsCXSTAHR34ob
         f27J0jC403vzqMKgzs64QNuNnsFFBWWqxgJFLvmB/KkByWTtWUTFbHkyG6Ixc3In2Jch
         oSVCsDxx9fwHy40xDH0aqiVv4zj4s16sEAuqCghxyJ5ZwAm+vPCCZC0Ke0SNkijXQwD2
         1jzIdMt9S3+bil8yBHVNFB82ifWt/v7BoumDPmrhSTwMVT/oaQQkY/GfzT9dA3JbYtDd
         PGVaI6Kdqk/XwHsKmSJranlqfENspV8vJuwbqDvGhJKYrc01/lTwayQ8YT9AnzhxZNTy
         jUtA==
X-Gm-Message-State: AOAM532/Z8Z7deW8pSiwfslbKoe8J/ew11U8onXb8He3EhbTrRMjeOqA
        1cY8vKczfeA68qcwVIZBn32MHdTskoJ1XOYSqIIGpGGc
X-Google-Smtp-Source: ABdhPJyeqHjhcCImk4QzATMuArw+7dpHnaPy8utN0ldunJqR5gL8RUjRcWxhwdTz3ztUkb43QesA9QxZjD6AkrjNkd8=
X-Received: by 2002:a0d:df81:0:b0:2d0:8db5:1a7e with SMTP id
 i123-20020a0ddf81000000b002d08db51a7emr133238ywe.359.1645629932664; Wed, 23
 Feb 2022 07:25:32 -0800 (PST)
MIME-Version: 1.0
References: <20220222154634.597067-1-hch@lst.de> <20220222154634.597067-4-hch@lst.de>
In-Reply-To: <20220222154634.597067-4-hch@lst.de>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Thu, 24 Feb 2022 00:25:20 +0900
Message-ID: <CAKFNMomTz6cpQNv1ABT6UaT8z=Ou98E9juoZupc71FUxN46_qg@mail.gmail.com>
Subject: Re: [PATCH 3/3] nilfs2: pass the operation to bio_alloc
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, "Theodore Ts'o" <tytso@mit.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-nilfs <linux-nilfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 23, 2022 at 12:46 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Refactor the segbuf write code to pass the op to bio_alloc instead of
> setting it just before the submission.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/nilfs2/segbuf.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Looks good for the 'for-5.18' branch of linux-block tree.

Thanks,
Ryusuke Konishi
