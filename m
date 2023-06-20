Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B320E737510
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 21:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjFTT2t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 15:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjFTT2q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 15:28:46 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F401704
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jun 2023 12:28:45 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-988aefaa44eso379410666b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jun 2023 12:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1687289324; x=1689881324;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XH1eTCKvssGWMBfvFrdgcklOsCxNlyt2GIpnc07LELQ=;
        b=BlynXctAWH1QRQ92/1liGst5sDK4J+VQcZkeHhN/JzMTNaMJ1YVs/a+8TpEn7V+e2z
         5rsT4otCl2HBLFcn3UZI9U8/bLdOsI5BJgt9hPBTvRlotni4E07NsF/Dwxb5rbyEmVrn
         Cp4ves6PTyv0l/TrGTJFH5VxYdufbQ6URbqso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687289324; x=1689881324;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XH1eTCKvssGWMBfvFrdgcklOsCxNlyt2GIpnc07LELQ=;
        b=Okh8E6SD2wUlAGbCCv4vmF1q/61eycShSLvVhCk8B54ba9JILYqPiwkgAi8fpCxerR
         0KB/JeW/tz256Bcxu+ubA9ahzeWW7VmhS93NZZJcOgN+NLwDXBP7fJJxM5WCOdZSskfg
         XD5bCATO+5fDQQu+7S5cDNj79zAKFhfuUV8w1b/cV9/HVgEoUWTXCncVKB4lKdPHrleL
         OiH3lcJCZCGwJpAa95IdZ3/LOh+Ap6C/XvGIQeEU+Yu3geuikZLHCozEQOk+hhvab9gy
         ubS0vJzKSoTHLkYnimAD9do6U9cGp/jV6f7jgNxZAyYiv/3xmDhgnoBeGuFeg4XjzDFC
         teiA==
X-Gm-Message-State: AC+VfDwtdhoBAkkAx5y65lhLgtH7hzKdH8utPfOedsAQXvH8iEnCI6b/
        1+uSvX4jAIFmuc11215jujJoZLmaRvClV84apwHVlg==
X-Google-Smtp-Source: ACHHUZ54HsxZXLKER+8ewm47xglhax+CzJ5iDEH3HsDCWTmmUgIaC+ahifuhHR5ouh2PxWWWI4v7558KxZAH1+RIWm0=
X-Received: by 2002:a17:906:6a0c:b0:988:bb33:53a8 with SMTP id
 qw12-20020a1709066a0c00b00988bb3353a8mr5382005ejc.9.1687289324011; Tue, 20
 Jun 2023 12:28:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230620151328.1637569-1-keiichiw@chromium.org> <20230620151328.1637569-3-keiichiw@chromium.org>
In-Reply-To: <20230620151328.1637569-3-keiichiw@chromium.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 20 Jun 2023 21:28:32 +0200
Message-ID: <CAJfpegton83boLEL7n-Tf6ON4Nq_g2=mTus7vhX2n0C+yuUC4w@mail.gmail.com>
Subject: Re: [PATCH 2/3] fuse: Add negative_dentry_timeout option
To:     Keiichi Watanabe <keiichiw@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, mhiramat@google.com,
        takayas@chromium.org, drosen@google.com, sarthakkukreti@google.com,
        uekawa@chromium.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 20 Jun 2023 at 17:14, Keiichi Watanabe <keiichiw@chromium.org> wrote:
>
> Add `negative_dentry_timeout` mount option for FUSE to cache negative
> dentries for the specified duration.

This is already possible, no kernel changes needed.  See e.g.
xmp_init() in libfuse/example/passthrough.c.

Thanks,
Miklos
