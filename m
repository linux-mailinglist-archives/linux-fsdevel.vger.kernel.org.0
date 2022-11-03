Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770AB6188CD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Nov 2022 20:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiKCTdX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 15:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKCTdV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 15:33:21 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376D11F637
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Nov 2022 12:33:19 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id c15-20020a17090a1d0f00b0021365864446so2744970pjd.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Nov 2022 12:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xgoPm2R0CuXdxGNaslW+xJKWGXjLoyPWOa1UTKM+sws=;
        b=W9yQ/Ff5mdNs0R2WWJko8a6svdLviE6byfEsP7bJ1qScSHAPnjD3FQYPSGabReYHUf
         8hWY/DAuxcVeepbuv/604qduGYF5eAp/d12XaaMMowmcLMNHWlro4iDaQFMZnm5x11vV
         vDo6Y3brtEypKl93OUolMAW6yU2sYBtY64xjHfR6DiBjtkOmDmMwu4299hNKRTMsx7LA
         x5XfkX/6K2w0eIVfYXx3pYjKOF1NW5g+o2Bzjhkf5K3deAiBZ8Dv1wFaBXeFUVo7Voro
         XG0Gy5efNXAK67/6rdindLAb8gHcud4AQMMdi0RWNVF04j8YwjWS8UTZ2FQI3Vr1yeJ5
         aL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xgoPm2R0CuXdxGNaslW+xJKWGXjLoyPWOa1UTKM+sws=;
        b=D+6XAuNqPy0vCrOeYGt17rTd6bRTc9pprx7v9b7aNThm9eS9d7wdjhi385+kbU5sEe
         errJZQc7XWO9wOAzdVZDkS0ExN0bweR2KqEi/oeSUQgEtx7SS1o8F98F1o1zUkephjka
         m67bII1oh6LTIgrv7I6T7Y6A8E+v76J3zGo2qxnZXm5TZbdx81UAOonr98+OZebXTZ2L
         1bZ/qf+W2CXg/OUs8+OJuw5nifGmRFz1oQPvYHL5p3+bfw+mwm10PGcSpWZ5vUlM18ab
         z6GkKQqgwCgU8MbzMp/D0W72Cs3Tu5okU510G49ip3+/ipRZv/vwsWaOAsC3Z3GLvYgb
         kMbw==
X-Gm-Message-State: ACrzQf3U8bkdMI6KWLI4vb+vEYCAWWYHVlHCmKyGLh1uku/lLMbxSzeS
        Uaj7bGx5x3Xf/+YFOfQUEmdBfw==
X-Google-Smtp-Source: AMsMyM7v5Y+4B0TIMEAhTzVnNV4xf57CGVYhUAIuNqZ9vp8q+fEO5H07XSP+bTfHq0icsZ9znw/Odg==
X-Received: by 2002:a17:90b:1c0c:b0:213:1455:131f with SMTP id oc12-20020a17090b1c0c00b002131455131fmr50133537pjb.129.1667503998609;
        Thu, 03 Nov 2022 12:33:18 -0700 (PDT)
Received: from google.com (13.65.82.34.bc.googleusercontent.com. [34.82.65.13])
        by smtp.gmail.com with ESMTPSA id a7-20020aa794a7000000b00553d573222fsm1072563pfl.199.2022.11.03.12.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 12:33:17 -0700 (PDT)
Date:   Thu, 3 Nov 2022 12:33:14 -0700
From:   William McVicker <willmcvicker@google.com>
To:     Peter Griffin <peter.griffin@linaro.org>
Cc:     Peter Griffin <peter.griffin@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <mszeredi@redhat.com>, stable@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Griffin <gpeter@google.com>
Subject: Re: [PATCH] vfs: vfs_tmpfile: ensure O_EXCL flag is enforced
Message-ID: <Y2QXerCJN9OsaY93@google.com>
References: <20221103170210.464155-1-peter.griffin@linaro.org>
 <CAJfpeguUEb++huEOdtVMgC2hbqh4f5+7iOomJ=fin-RE=pu8jQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpeguUEb++huEOdtVMgC2hbqh4f5+7iOomJ=fin-RE=pu8jQ@mail.gmail.com>
X-Spam-Status: No, score=-15.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/03/2022, Miklos Szeredi wrote:
> On Thu, 3 Nov 2022 at 18:04, Peter Griffin <peter.griffin@linaro.org> wrote:
> >
> > If O_EXCL is *not* specified, then linkat() can be
> > used to link the temporary file into the filesystem.
> > If O_EXCL is specified then linkat() should fail (-1).
> >
> > After commit 863f144f12ad ("vfs: open inside ->tmpfile()")
> > the O_EXCL flag is no longer honored by the vfs layer for
> > tmpfile, which means the file can be linked even if O_EXCL
> > flag is specified, which is a change in behaviour for
> > userspace!
> >
> > The open flags was previously passed as a parameter, so it
> > was uneffected by the changes to file->f_flags caused by
> > finish_open(). This patch fixes the issue by storing
> > file->f_flags in a local variable so the O_EXCL test
> > logic is restored.
> >
> > This regression was detected by Android CTS Bionic fcntl()
> > tests running on android-mainline [1].
> >
> > [1] https://android.googlesource.com/platform/bionic/+/
> >     refs/heads/master/tests/fcntl_test.cpp#352
> 
> Looks good.
> 
> Acked-by: Miklos Szeredi <mszeredi@redhat.com>
> 
> Thanks,
> Miklos
> >

Thanks Peter for tracking this down! I tested this on the android-mainline
version of 6.1-rc3 on a Pixel 6 device.

Tested-by: Will McVicker <willmcvicker@google.com>

Regards,
Will
