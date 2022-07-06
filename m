Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0C45681C6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jul 2022 10:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbiGFIgO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jul 2022 04:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbiGFIgL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jul 2022 04:36:11 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF27248CB
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Jul 2022 01:36:09 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id lg18so5993485ejb.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Jul 2022 01:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=epeso7+4ukNkDel//xMfh+OpOEIxO+hKGW419TZ34dc=;
        b=Jg1nZ4sfOe4dpnsATdHuAuivM6OMsKC8aMdNXSiPYLimtB/xK9c8TRl9QMxtULSHg8
         /3uz3035nk8Ci5v+DlRJeBQaUkCbJpS84Kkc7yMz3kw8RBP8f52e0nMf5vE0EFH8GOiF
         D0xtaD3nPSos3WIXQ505aW1asQF+kH0yn7JOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=epeso7+4ukNkDel//xMfh+OpOEIxO+hKGW419TZ34dc=;
        b=XubGe/GKfMgN/8gp/HKFXwmUF5IrM05czWggGyo9piV5hiAfaKlAqYJ/PZIK7fiQhf
         f36TjQCwnv2xE/WBvR4gPNow5Btgnjm9+skSE4qSWknM3USRX107iZ1YwB94puUS1Oyk
         gvSP/1igtCNYrPUl0D1ckxosHDoAgrDXZaVa8YlC/zpVnt7MSKN2fm/ErHxp2nwxV2EK
         ZC+QGfJN/q0dECDm23a/xtZllFjpD3IrmpicWbywNoSyWXxc9Tkmf2W4PQteQnMJuI7j
         d68pyOiQXElY5jl8ZjlW+As3rUq0hpEx7VSltBLWgc2DbBGrj43wnEW/q9TlSvuPyRPr
         c2mg==
X-Gm-Message-State: AJIora/b76XtxF8kVOE5MRViLZBTeJLQYDRaHMp4+hd3MQwnIJNGhLAH
        ImCJCMbd/B80ML396IGSKLaiS8ALb9fJXuOFzPTc4I43ylg=
X-Google-Smtp-Source: AGRyM1vgOpglV5DZ8J8r15lTSxPAf4V0aihBg51c35ExQPL4Ey+TZKf87R6/0g6uSGeR3yOZV/ZDHNG1/OKAsTls1Ns=
X-Received: by 2002:a17:907:7213:b0:726:9f27:8fc8 with SMTP id
 dr19-20020a170907721300b007269f278fc8mr37348001ejc.523.1657096567811; Wed, 06
 Jul 2022 01:36:07 -0700 (PDT)
MIME-Version: 1.0
References: <87tu7yjm9x.fsf@vostro.rath.org>
In-Reply-To: <87tu7yjm9x.fsf@vostro.rath.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 6 Jul 2022 10:35:56 +0200
Message-ID: <CAJfpegvgWZcwP=M7hE44=jaKfmB2PXyzyodii63JZhGwVhaJHQ@mail.gmail.com>
Subject: Re: potential race in FUSE's readdir() + releasedir()?
To:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        miklos <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 3 Jul 2022 at 16:37, Nikolaus Rath <Nikolaus@rath.org> wrote:
>
> Hello,
>
> I am seeing something that to me looks like a race between FUSE's
> readdir() and releasedir() handlers. On kernel 5.18, the FUSE daemon
> seems to (ocasionally) receive a releasedir() request while a readdir()
> request with the same `struct fuse_file_info *fi->fh` is still active
> (i.e., the FUSE daemon hasn't sent a reply to the kernel for this yet).
>
> Could this be a bug in the kernel? Or is there something else that could
> explain this?

Is there a log where this can be observed?

Thanks,
Miklos
\
