Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858B8578B8F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jul 2022 22:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbiGRUNK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jul 2022 16:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234810AbiGRUNF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jul 2022 16:13:05 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC612A437
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jul 2022 13:13:05 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-10bec750eedso26799572fac.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jul 2022 13:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b12VQvmMnRuczR7vsiOnnqJ9IYxQ2j6Uskl9KHtzH74=;
        b=ED5cPuZ5ZpUK4tIyvYn/KsjabfMdhC+COgAFRv1mZ0FJmr3Q/Qgmo9ZTWJsnP9e64x
         7BF/LnVuT8/ejVu2S4VUR5xIwDQTdubjq8suLiSGCSj/ZaguEk1VO5rkUzkHipGnqMXb
         nZcvvXrjh9eSXZh4Jn38YXKmpUKVdrstPJhGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b12VQvmMnRuczR7vsiOnnqJ9IYxQ2j6Uskl9KHtzH74=;
        b=coya6Sx19t9j2Q8OmBGpx4pJx5aipQAyRMV3zTxaTZJ8sQGxX8Xro1zbPCpnvszsLY
         bceGGSU2nsCuP4r1qgw0O8K+/CEpfnslpG9JfqShHOfxfqzU9HjkhzDGhLQE38WNx4Dr
         V9V/xGs/+IlTaQjJ8msxhm+sztcGMEN9BjYFObOYBZLkL6x477V7MZud/M6y0gLzI2yX
         1qmIzZG2LitaKTIYbSvVJVtMb73K4STdRBUOq5Af5rNzaoPHSSdb3a/CVUT2hXX7COj0
         RM5vsJmOsKHWB1kuSPNMWkn5c73LHYGoUMeSkiPPccbLYRHQwhjLYv+OfYhZTHXfsO3u
         AhFQ==
X-Gm-Message-State: AJIora/7+a088Mj78r3CGzL5tfQePk/jP8ordSF3yP9ewWt+AiLBHB1b
        MPj9C6dpxg0ihERKE6zIKv/L4Mkiyfo3OAjfs4iRrQ==
X-Google-Smtp-Source: AGRyM1sxuORdZ99poTmX7f+Xesk7RFdsSFOLiWlpaScD1wqvO+gcQ59G3yrSf9fqiIxBP+6VoaKznw==
X-Received: by 2002:a05:6808:bcb:b0:337:abf8:b8e0 with SMTP id o11-20020a0568080bcb00b00337abf8b8e0mr13516884oik.164.1658175184311;
        Mon, 18 Jul 2022 13:13:04 -0700 (PDT)
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com. [209.85.160.45])
        by smtp.gmail.com with ESMTPSA id v5-20020a0568301bc500b0061cae62aafcsm584483ota.20.2022.07.18.13.13.03
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 13:13:03 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-10c8e8d973eso26823713fac.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jul 2022 13:13:03 -0700 (PDT)
X-Received: by 2002:a05:6870:c1c1:b0:ee:5c83:7be7 with SMTP id
 i1-20020a056870c1c100b000ee5c837be7mr15568709oad.53.1658175183146; Mon, 18
 Jul 2022 13:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <4B9D76D5-C794-4A49-A76F-3D4C10385EE0@kohlschutter.com>
 <CAJfpegs1Kta-HcikDGFt4=fa_LDttCeRmffKhUjWLr=DxzXg-A@mail.gmail.com>
 <83A29F9C-1A91-4753-953A-0C98E8A9832C@kohlschutter.com> <CAJfpegv5W0CycWCc2-kcn4=UVqk1hP7KrvBpzXHwW-Nmkjx8zA@mail.gmail.com>
 <FFA26FD1-60EF-457E-B914-E1978CCC7B57@kohlschutter.com> <CAJfpeguDAJpLMABsomBFQ=w6Li0=sBW0bFyALv4EJrAmR2BkpQ@mail.gmail.com>
 <A31096BA-C128-4D0B-B27D-C34560844ED0@kohlschutter.com> <CAJfpegvBSCQwkCv=5LJDx1LRCN_ztTh9VMvrTbCyt0zf7W2trw@mail.gmail.com>
 <CAHk-=wjg+xyBwMpQwLx_QWPY7Qf8gUOVek8rXdQccukDyVmE+w@mail.gmail.com>
 <EE5E5841-3561-4530-8813-95C16A36D94A@kohlschutter.com> <CAHk-=wh5V8tQScw9Bgc8OiD0r5XmfVSCPp2OHPEf0p5T3obuZg@mail.gmail.com>
 <CAJfpeguXB9mAk=jwWQmk3rivYnaWoLrju_hq-LwtYyNXG4JOeg@mail.gmail.com>
In-Reply-To: <CAJfpeguXB9mAk=jwWQmk3rivYnaWoLrju_hq-LwtYyNXG4JOeg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Jul 2022 13:12:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg+bpP5cvcaBhnmJKzTmAtgx12UhR4qzFXXb52atn9gDw@mail.gmail.com>
Message-ID: <CAHk-=wg+bpP5cvcaBhnmJKzTmAtgx12UhR4qzFXXb52atn9gDw@mail.gmail.com>
Subject: Re: [PATCH] [REGRESSION] ovl: Handle ENOSYS when fileattr support is
 missing in lower/upper fs
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     =?UTF-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 18, 2022 at 12:28 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> So this is a bug in the kernel part of fuse, that doesn't catch and
> convert ENOSYS in case of the ioctl request.

Ahh, even better. No need to worry about external issues.

            Linus
