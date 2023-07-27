Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6469764A70
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 10:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbjG0IJm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 04:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbjG0IJ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 04:09:28 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AE45B8B
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 01:06:02 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-52229f084beso881373a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 01:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1690445108; x=1691049908;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZWtXR7LVkybOJgX2GhbyDEnyLzObeaTk8DzYL13yHO8=;
        b=LKqIodi8vg0//8W9tRrrZWDmaDb0cm5QwIcAZyqaoCGLUio8kiti/jDxxB2h5yLtAC
         vd7gX7cr9ONFuAEuYLwzLdSn++rxE98wtUPO0B89LmE0pWjyYzgeDk93Q+281VYEIhja
         OgYuj/6a1uGJ5DWXCvUcNenVbS7FeQf9dbOpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690445108; x=1691049908;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWtXR7LVkybOJgX2GhbyDEnyLzObeaTk8DzYL13yHO8=;
        b=F992OEpZvSfMi6NTovH5lC3fnZt9Kna91lIPgFn8Jj2QNipIWb7j4XWJBzohM55RSR
         n4ouhimgBzri3x937rEkAQuVCpHcoAZIoxP4HSdzEYQKiQn2NiudiHVRb3JRSW0r7SNA
         TFbsGtRF7Zmg2mKMrhUKUZGbPOrAQaUSGi/Zd/Hnf6Vt85ox5vKkdSOGSmNRK4sw8nyT
         GTIZjTb7n2E24DXpqIl2Kvk6isCsky/6+jQVON70rKeFDZEUeRMf8IWSq6n2aHGW5zuL
         gI5MX7qx+rd89i21DNJowXZMjPw5vK+g44hqFxSoxC6uUwneZU9SPR9SgnFuz0qOoA0J
         Zq/Q==
X-Gm-Message-State: ABy/qLZp5E2YUgeXy0TOXKOyxZwYm1PV1ZxlWTdo+ZpIkFtATxQnTw1i
        yIYCLrWZmauk172pLdxTLbjKTD9N0CUpwAG38E+4WQ==
X-Google-Smtp-Source: APBJJlGlAz9ISCFbYto3mu6R8L3Zw5uRFAIB8uuK5Hkeb1RlCXGKOLfxZVJU68THJw/4QHNRw2Zt4CpX63BXWCgB8EY=
X-Received: by 2002:a17:907:7717:b0:992:764b:90d3 with SMTP id
 kw23-20020a170907771700b00992764b90d3mr1588555ejc.70.1690445107777; Thu, 27
 Jul 2023 01:05:07 -0700 (PDT)
MIME-Version: 1.0
References: <87wmymk0k9.fsf@vostro.rath.org>
In-Reply-To: <87wmymk0k9.fsf@vostro.rath.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 27 Jul 2023 10:04:56 +0200
Message-ID: <CAJfpegs+FfWGCOxX1XERGHfYRZzCzcLZ99mnchfb8o9U0kTS-A@mail.gmail.com>
Subject: Re: Semantics of fuse_notify_delete()
To:     fuse-devel@lists.sourceforge.net,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        miklos <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 26 Jul 2023 at 20:09, Nikolaus Rath <Nikolaus@rath.org> wrote:
>
> Hello,
>
> It seems to me that fuse_notify_delete
> (https://elixir.bootlin.com/linux/v6.1/source/fs/fuse/dev.c#L1512) fails
> with ENOTEMPTY if there is a pending FORGET request for a directory
> entry within. Is that correct?

It's bug if it does that.

The code related to NOTIFY_DELETE in fuse_reverse_inval_entry() seems
historic.  It's supposed to be careful about mountpoints and
referenced dentries, but d_invalidate() should have already gotten all
that out of the way and left an unhashed dentry without any submounts
or children. The checks just seem redundant, but not harmful.

If you are managing to trigger the ENOTEMPTY case, then something
strange is going on, and we need to investigate.

Thanks,
Miklos
