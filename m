Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF94378DBC7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238383AbjH3Shn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244608AbjH3N2V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:28:21 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60747198
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 06:28:18 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2bd0d19a304so52837081fa.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 06:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1693402096; x=1694006896; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S7LyCS8f54I95JzN266LLfD3Y19mQjqooq3TeyMxz7M=;
        b=ppmAx/6DaQhZTbtSdRxjhljhqcXEbhawP5V/OBiciEirKhfW0fQ8NVbkxSDWNpc8XC
         cmFccyGljGM8Gsa8ferJENvDrVEC2HPPHH0EhbiOrYqwb2qAzuZk9zb6fuAk7FqaThEh
         LtXctxDfOWUG/rBu1OxVarwnqrTDVwCay/XuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693402096; x=1694006896;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S7LyCS8f54I95JzN266LLfD3Y19mQjqooq3TeyMxz7M=;
        b=cO0HIYFi0VPOxgmSjiyxRVX7e3f9Vypb1k57xmvX2NqJPAqTPAJDa8nPxiAvOzH1d8
         dOdCLufsuC0euZMGaluK0Np80ExNdysZ6FJucGXfUeO7foS0lRcc82o/QLfn2PK+xTD7
         3hb1KFF7ujHOGb7cfkg2mHnXVE5Gl7bsNb6cu9ZWHh6TeeRLS2IA/9dxirBkIdKIkLJw
         sqLP/aA0KsVJpMbsMDO3VY46Ii9mn282zx0vFdsxBas7KsgRG6j5ThB6cR6ai+fCVodI
         kEP0zbnl5XLuKqtdConasswb8fR4pFkSlnE/ZL3d2bXTKqhz7ycfli7EJmoMvxh2KoVg
         SqNw==
X-Gm-Message-State: AOJu0YxlrBZ6QnxcTjYp2Qc3NMKfcF9PQeAHNJBqAxcpkYGzYvzbKdQ8
        xq1auoxfjXrtDXD+ax2daS4L4xac1oBucsMZE45R7w==
X-Google-Smtp-Source: AGHT+IF/rbYXkifYsvtcjDk46RVDjB40NmswaIspkHcOC/MDUKsfPmX+KF5aT+G+ukxFIrVl17/MgGdzte1AmfNdb5I=
X-Received: by 2002:a2e:854a:0:b0:2bc:eaec:e23f with SMTP id
 u10-20020a2e854a000000b002bceaece23fmr1980277ljj.43.1693402096565; Wed, 30
 Aug 2023 06:28:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230829161116.2914040-1-bschubert@ddn.com> <20230829161116.2914040-4-bschubert@ddn.com>
In-Reply-To: <20230829161116.2914040-4-bschubert@ddn.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 30 Aug 2023 15:28:04 +0200
Message-ID: <CAJfpegsGLTiWvjfoZs9fAQ0xWK-QBwtAXe5_Msr_jiY4Rjssxg@mail.gmail.com>
Subject: Re: [PATCH 3/6] fuse: Allow parallel direct writes for O_DIRECT
To:     Bernd Schubert <bschubert@ddn.com>
Cc:     linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm,
        dsingh@ddn.com, Hao Xu <howeyxu@tencent.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 29 Aug 2023 at 18:11, Bernd Schubert <bschubert@ddn.com> wrote:
>
> Take a shared lock in fuse_cache_write_iter. This was already
> done for FOPEN_DIRECT_IO in
>
> commit 153524053bbb ("fuse: allow non-extending parallel direct
> writes on the same file")
>
> but so far missing for plain O_DIRECT. Server side needs
> to set FOPEN_PARALLEL_DIRECT_WRITES in order to signal that
> it supports parallel dio writes.

Hmm, I think file_remove_privs() needs exclusive lock (due to calling
notify_change()).   And the fallback case also.

Need to be careful with such locking changes...

Thanks,
Miklos
