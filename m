Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1DA7AA176
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 23:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjIUVCw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 17:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbjIUVCL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:02:11 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A021E9283E
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 11:13:45 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso158114866b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 11:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1695320023; x=1695924823; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GQSRwKbtZh1El+Fd/4aiLbZf0l9nxXycHTcgQx8uoyM=;
        b=eftgGZbZlMcyipWDvgRS5LOxiGliYf3MNTsgxXZAxJ1/7VB/i69GgVs8Sj9IKEAXhL
         D0t/+9Xr7m7vUe8AGS2hAkhJSm30gaSRQTr4TRfbUsH1oh1t0R7IEm6YT9TfGnL9Ec9Z
         oH6Udb6cp9JDUCfnVIN6IwhYlrHIVxAmCHBXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695320023; x=1695924823;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GQSRwKbtZh1El+Fd/4aiLbZf0l9nxXycHTcgQx8uoyM=;
        b=TdZLZFGXLNvZre8eVLLrEj4g7NwqEIiPixGz192vFlGivU4w+7jtyWrS1gvAz+9szk
         3RlyuQYQsZggIv4p2mrmlKhv2yK8STQ61/5HkJZpy1YVNvjyMpAzi1UfJkm/KR3GH7YE
         P8NzIcYI9633lTPVYjVi1AbWdHcATdusu6uYcZRGOTpgPYAusuXqsysmVvCZTs89SRZP
         DwLmnvCxwiSbFgp9SkuvilLJIWtxuvgEl983qYsvTwCr+ZzR1Kdp1KXmU3ZKW4fbeTc9
         1yhBgXKUDH9/89IHn3/01TLOexH9yKeh9/qpEVfNcAOm/0tvDo9SFsh5RBTVW/gz3r4y
         eVtQ==
X-Gm-Message-State: AOJu0YwrDSYHPvgpazgAUP3NLCj67REb0Ez6OcXSMXrDOho10jmYr8v1
        3gtC2vNWLGJ1Q06umObhEgv8lY0acD0zs/+p2CDSfeGYDD+UM/GI
X-Google-Smtp-Source: AGHT+IFLLf861BAeTJbNXgXRYdkX2Zg33xm4xoz4GXH5JJxO7GxkVJ1kzMkZktopiZobbTh5gpL8XVUwKMbqPS6cDHw=
X-Received: by 2002:a2e:9dc7:0:b0:2c0:1cfd:8698 with SMTP id
 x7-20020a2e9dc7000000b002c01cfd8698mr3748340ljj.36.1695288611582; Thu, 21 Sep
 2023 02:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230519125705.598234-1-amir73il@gmail.com> <CAOQ4uxibuwUwaLaJNKSifLHBm9G-Tgn67k_TKWKcN1+A4Rw-zg@mail.gmail.com>
 <CAJfpegucD6S=yUTzpQGsR6C3E64ve+bgG_4TGP7Y+0NicqyQ_g@mail.gmail.com>
 <CAOQ4uxjGWHnwd5fcp8VwHk59q=BftAhw0uYbdR-KmJCq3fpnDg@mail.gmail.com>
 <CAJfpegu2+aMaEmUCjem7em0om8ZWr0ENfvihxXMkSsoV-vLKrw@mail.gmail.com>
 <CAOQ4uxgySnycfgqgNkZ83h5U4k-m4GF2bPvqgfFuWzerf2gHRQ@mail.gmail.com>
 <CAOQ4uxi_Kv+KLbDyT3GXbaPHySbyu6fqMaWGvmwqUbXDSQbOPA@mail.gmail.com>
 <CAJfpegvRBj8tRQnnQ-1doKctqM796xTv+S4C7Z-tcCSpibMAGw@mail.gmail.com>
 <CAOQ4uxjBA81pU_4H3t24zsC1uFCTx6SaGSWvcC5LOetmWNQ8yA@mail.gmail.com>
 <CAJfpegs1DB5qwobtTky2mtyCiFdhO_Au0cJVbkHQ4cjk_+B9=A@mail.gmail.com> <CAOQ4uxgpLvATavet1pYAV7e1DfaqEXnO4pfgqx37FY4-j0+Zzg@mail.gmail.com>
In-Reply-To: <CAOQ4uxgpLvATavet1pYAV7e1DfaqEXnO4pfgqx37FY4-j0+Zzg@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 21 Sep 2023 11:30:00 +0200
Message-ID: <CAJfpegvS_KPprPCDCQ-HyWfaVoM7M2ioJivrKYNqy0P0GbZ1ww@mail.gmail.com>
Subject: Re: [PATCH v13 00/10] fuse: Add support for passthrough read/write
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@android.com>,
        fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 21 Sept 2023 at 11:17, Amir Goldstein <amir73il@gmail.com> wrote:

> I don't mind dropping the "inode bound" patch altogether
> and staying with server managed backing_id without support
> for auto-close-on-evict and only support per-file-auto-close
> as is already implemented in my POC.

Lets do that, then.

> IWO, if the server want to associate a backing file id with an
> inode on LOOKUP or on open, it has no problem is keeping
> this association in the server internally, replying to any open
> with the backing_id that it associated and closing the
> backing_id on FORGET or on the last close.

Right.   The only gain is when we want to omit the OPEN call.  But
that's definitely not urgent.

> Different FUSE files may have different open flags
> (e.g. O_RDONLY/O_RDWR/O_SYNC) so server may want to use
> different backing files for different FUSE files on the same inode,
> but perhaps this is not what you were asking?

Yes, this answers my question.

THanks,
Miklos
