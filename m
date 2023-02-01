Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73581686A70
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Feb 2023 16:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbjBAPeM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Feb 2023 10:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjBAPeJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:34:09 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DD8DBE4
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Feb 2023 07:33:58 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id bk15so52491108ejb.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Feb 2023 07:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FDt/fXK3xlImEm4AnpyFiZiyZ5/aLHdhtcx/5MB1rdc=;
        b=dUVu1E4hy8GExcS4r0+MaGM3+umrVVMfZLXrIkD0uIAiIKI2c+sY+YPjOCq09+Agwo
         VeLFI9bF8IjVe3myHp58Zvy42dlyosUainAo0IJbKfem7JsPlDZvncycoOeuD/tgFEKN
         rGXpJtx1rMBZ95T+ZKOKiakopFThF8HB/WbDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FDt/fXK3xlImEm4AnpyFiZiyZ5/aLHdhtcx/5MB1rdc=;
        b=7LlO+Iy0DLkIugPrKlIHKPJHZp8JdEd5HQKtWSs3gNewKwTDkwXzlcKp4D/aJiCLje
         BRxI4qp4wNwavUh7+9lINI6kx+K1Ro/2pBHg/M+Z1B/7JiBxla/wl5UpjgISX3evAhW0
         hazYpjwQ42vFK9WPodb+NQrxFngdm8oHM2ZZ/YpWVVhvp0GHJZEv9bYrn60KBwtnc3P8
         G1uZhWAGoYsb5aj5M+Lb+XvX7wlx3WBEnoiYqaWbgW3sm3AHmUOJdXetb6lEK2XTq7bR
         T44LwqPdsvZTRxSD4Z3SWH0qg1IHUkj2n9dyLBELJMX019W6kXpoutw3Wj7ZgDDDkyQ/
         269w==
X-Gm-Message-State: AO0yUKVxFaJqDc2upo10eQpOFG8d4dTMWjFarUQudx0UCKWhb21wrVsY
        HDv9g2w8O2cs1BK6GUX2XJ+h2LAu/vkQRGVsTC7fBHlgh473mg==
X-Google-Smtp-Source: AK7set85fgyjXCJs6yqaaGT+Y1bXaa6IOeamyPGpgzCszz6TU8+O1Y+mr32yKdHRCVaKuIKkoP0EEeZJlI2yIiCRwYM=
X-Received: by 2002:a17:906:c411:b0:887:7d91:d016 with SMTP id
 u17-20020a170906c41100b008877d91d016mr803397ejz.110.1675265636832; Wed, 01
 Feb 2023 07:33:56 -0800 (PST)
MIME-Version: 1.0
References: <20221213115147.26629-1-zyfjeff@linux.alibaba.com>
In-Reply-To: <20221213115147.26629-1-zyfjeff@linux.alibaba.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 1 Feb 2023 16:33:45 +0100
Message-ID: <CAJfpegvuwrAszXF31hy_6L92opE-TZef-km6HiMvU0Cf4krFXA@mail.gmail.com>
Subject: Re: [PATCH] fuse: remove duplicate check for nodeid
To:     zyfjeff <zyfjeff@linux.alibaba.com>
Cc:     linux-fsdevel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 13 Dec 2022 at 12:52, zyfjeff <zyfjeff@linux.alibaba.com> wrote:
>
> before this check, the nodeid has already been checked once, so
> the check here doesn't make an sense, so remove the check for
> nodeid here.
>
>             if (err || !outarg->nodeid)
>                     goto out_put_forget;
>
>             err = -EIO;
>     >>>     if (!outarg->nodeid)
>                     goto out_put_forget;
>
> Signed-off-by: zyfjeff <zyfjeff@linux.alibaba.com>

Applied, thanks.

Miklos
