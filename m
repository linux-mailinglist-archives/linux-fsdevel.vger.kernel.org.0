Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A0C78C4BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 15:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbjH2NCU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 09:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235888AbjH2NCB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:02:01 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10095CD2
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 06:01:57 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-500913779f5so6929873e87.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 06:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1693314115; x=1693918915;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hlwAy3lOkQ1qGj35w7AXnNlSgoKPnSYOIrYSqhjlQbY=;
        b=HOzR23aRY4TDqf+MeB2SdAWNkalp9PP4/roSpbNLv6t8ZwFKC53z7SLuKmdMP9obaV
         Ke7UOdDNSj6/jzHPnURZL858im2NHYWT+DHAo1IjBsAdbxF2feeNrF1ewTWL9b0mmkmT
         3RTKROmsDoBoCbFEh1KTusnO43hoFHi+bFu00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693314115; x=1693918915;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hlwAy3lOkQ1qGj35w7AXnNlSgoKPnSYOIrYSqhjlQbY=;
        b=Wf6lbXqjRkqApT2gCPzGZd1ZEMdqWxNR/dspMReVZaUrIgKAtOTCLXMk+A97ftk2KO
         de+N55KK0U+MyCmJUsMViYdN9Q90icqF7IiexGfWT91EVTXHbq08NCG0UZ1dwticOW/3
         68jUbOToQu9L0pFjGha7rLe7JVbd1tFe1v/EricxxiRQdPolUYjspEFwuAZkE6MwYuyY
         W7i3hVjtp7IEFHyrJ2u9+29b5/PkV5XmshSLDAI8Urbrr7czfGw0ZwA06XZgFjEn9iU8
         SdLXxyDl98FCIYsUYwGnr9QsURUWCVibrV7YK0phIziSdES/SwPuAoQ1tuBXL8abd3wo
         RqMg==
X-Gm-Message-State: AOJu0Yypn2BRNfIQ6gGpydH8TdjvVXb3jX9+mGA4gYK8ePHCK0N9z8Br
        aDSb509JHzteM1RnmaBD3hPSdCkQaGCay6bm3oDikPLmLATC6U7q
X-Google-Smtp-Source: AGHT+IHic8mAdxWG3XIFBG5ARhzvKXRdTBguBX1/Fm3ufBJZlBk0ay8APO8JNDYgpuLpyzTSO0FG/ZFB2sUq9HjxUpk=
X-Received: by 2002:a05:6512:368d:b0:4fe:179a:18d2 with SMTP id
 d13-20020a056512368d00b004fe179a18d2mr17751027lfs.21.1693314115235; Tue, 29
 Aug 2023 06:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230823223345.2775761-1-bschubert@ddn.com>
In-Reply-To: <20230823223345.2775761-1-bschubert@ddn.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 29 Aug 2023 15:01:44 +0200
Message-ID: <CAJfpegt74eBEJBUHxoDvn1WAzap1fiNOLDFCS6So5dX7YHxLdA@mail.gmail.com>
Subject: Re: [PATCH] [-next] fuse: Conditionally fill kstat in fuse_do_statx
To:     Bernd Schubert <bschubert@ddn.com>
Cc:     linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm,
        dsingh@ddn.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 24 Aug 2023 at 00:34, Bernd Schubert <bschubert@ddn.com> wrote:
>
> The code path
>
> fuse_update_attributes
>     fuse_update_get_attr
>         fuse_do_statx
>
> has the risk to use a NULL pointer for struct kstat *stat,
> although current callers of fuse_update_attributes
> only set request_mask to values that will trigger
> the call of fuse_do_getattr, which already handles the NULL
> pointer. Future updates might miss that fuse_do_statx does
> not handle it - it is safer to add a condition already
> right now.
>
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>

Applied, thanks.

Miklos
