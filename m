Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0F6777A46
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 16:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234068AbjHJOPm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 10:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235243AbjHJOPl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:15:41 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2EA2718
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 07:15:37 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fe61ae020bso1443961e87.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 07:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1691676936; x=1692281736;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Tg1OZxePRMvpfAVQi5zlGTphJn3RX6udlX2XkOrIxJI=;
        b=m1WPRyOJK5J2RtaHJpGnFklnvmiUpTv5zQYSEjN0QB626gzakl2Tjv+SogDEeFzmTL
         T7MivciyGNaYP2136BlRBLUP41b3fDM3Z4ceGurbbF/ey2/mNEXnZy6P1dwMjzMqQBHw
         kTuJquGOCa6o9m9lZyItt8qKCFueSnh7op16w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691676936; x=1692281736;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tg1OZxePRMvpfAVQi5zlGTphJn3RX6udlX2XkOrIxJI=;
        b=Kz6TWVoyShbri4XwElT9lmIqRWi9tQXpBUpb2jduOcmwGX7AojTJF1HXvc6bnscs1z
         dVqY1an7j0cGsV1W8/Hw4RrIjM28JiKXvb3T++AkRqRjJgaMh4sVkKb54N42u1WZww5/
         9kZnQ7jWmjTJ+eyHhcYEXDR/0ZY7hmFZmcTISEjv1boguVbZEb7ryqqvpSGPOFvboOxr
         KjynHma48TsyH/tXTRR/qlpcA5FANUnaKYUlp7O9pW8QFQy88xpoPDCfwY1yumqJbx+X
         2TVs/GIGTqZSawbvE/Brj444sx/AXzb18k6nw3p8nIyKNjjquuvmV61eJX1ViT+KrSkp
         YiCw==
X-Gm-Message-State: AOJu0YzF2kIAveFbQytuTqT/7MeZnxSkteJ5RDUvdxBYu3f3AFujU7Mw
        93Pcz6sEq2n+x4rxsGb6SItxvY1try1xYT1o65W3pg==
X-Google-Smtp-Source: AGHT+IFVROCHVwMcd00b3T21L1/RKNl/wSLgtvb0IHkqIIfMovNiAgphRv+VmhP69wqlRsis7o251Ji4jqWscoBGCrc=
X-Received: by 2002:a2e:3e14:0:b0:2b9:c4ce:558f with SMTP id
 l20-20020a2e3e14000000b002b9c4ce558fmr1992963lja.37.1691676935639; Thu, 10
 Aug 2023 07:15:35 -0700 (PDT)
MIME-Version: 1.0
References: <202308100325.37A3P8fF000898@mse-db.zte.com.cn>
In-Reply-To: <202308100325.37A3P8fF000898@mse-db.zte.com.cn>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 10 Aug 2023 16:15:23 +0200
Message-ID: <CAJfpegtjQxPd-nncaf+7pvowSJHx+2mLgOZBJuCLXetnSCuqog@mail.gmail.com>
Subject: Re: Subject: [PATCH] nlookup missing decrement in fuse_direntplus_link
To:     ruan.meisi@zte.com.cn
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 10 Aug 2023 at 05:25, <ruan.meisi@zte.com.cn> wrote:
>
>
> From 53aad83672123dbe01bcef9f9026becc4e93ee9f Mon Sep 17 00:00:00 2001
>
> From: ruanmeisi <ruan.meisi@zte.com.cn>
>
> Date: Tue, 25 Apr 2023 19:13:54 +0800
>
> Subject: [PATCH] nlookup missing decrement in fuse_direntplus_link
>
>
> During our debugging of glusterfs, we found an Assertion
>
> failed error: inode_lookup >= nlookup, which was caused by the
>
> nlookup value in the kernel being greater than that in the FUSE
>
> file system.The issue was introduced by fuse_direntplus_link,
>
> where in the function, fuse_iget increments nlookup, and if
>
> d_splice_alias returns failure, fuse_direntplus_link returns
>
> failure without decrementing nlookup
>
> https://github.com/gluster/glusterfs/pull/4081
>
>
> Signed-off-by: ruanmeisi <ruan.meisi@zte.com.cn>

Thanks.   Patch looks good.

Please resend as plain text otherwise the mailing lists will reject it
and also tools will fail to handle it, so it can't be applied.

If you can't send as plain text, sending as an attachment is still better.

Thanks,
Miklos
