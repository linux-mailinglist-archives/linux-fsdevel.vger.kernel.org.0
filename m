Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529836CAE52
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 21:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjC0TOk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 15:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbjC0TO0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 15:14:26 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9302B44A3
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 12:13:59 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id ek18so40470579edb.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 12:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679944437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wgnd7HUdth77U+uNc5T7CyR03l9kmEjOlU8LqFnHwFU=;
        b=Yv0RGoRlL11i0IVwDct+gx5tNjrapnVEDcP56pcM9zE52498/iRnLGrMG3HryB/mav
         0PFvA6wcdve2fpp9YwoVhHgP/1hZNTISt8QNSseVPRAM8D7h1+qusvZVAN6E3MY7HZop
         MWg+VdZZr6Dj7vvDs02rp6ELSF2fGgHGH+zFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679944437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wgnd7HUdth77U+uNc5T7CyR03l9kmEjOlU8LqFnHwFU=;
        b=wPEvOtfRWcrqEDvSm7DjdT5jzy4wL80bKvJCDZLEqyc+DoUqZXoObNohrJ3Xy/7Vqb
         2a74FkJzhZBUnVdIUYprrE8Iz7qdVnBGYg/zHsvlehZJp9LDPdaMIgaVRH+sxIBngfPU
         15PzwwfkY0LNvoxNKPlrmoij2UrFavWm83XCEvdrQXJtvP567X7n0gc4bf7JSOZqAf1u
         9gSXiHSupR0ih3UbrxtBIPMat3Jqhp+cK6If6EYB7SCxAKF9ZVcvDACdgk5jAZ0FbMeJ
         2ZDDNhLpVnNRh6V5iZWq0W/rMK4f3tGhqiY5DKNqQbfdjLHkmdsjmaR/ZlwQh0MpNoa7
         hrXw==
X-Gm-Message-State: AAQBX9cPS8/c2ZivlBpxR9usiHL+nwJMKXdfvrzrZHBe7md8bhCJHkT9
        B5XwVw691ZAnmqVoq7AKYWQAMzTmblekSwK9Yw+sfg==
X-Google-Smtp-Source: AKy350YZKfgketNlHmowCgm7nZWOBy+9r42Bm57OU9Og0GKRAlt6Ux8LZZ3YzH46Bljvs5tNNBQSvQ==
X-Received: by 2002:a05:6402:1149:b0:4fc:5888:473a with SMTP id g9-20020a056402114900b004fc5888473amr14302046edw.9.1679944436703;
        Mon, 27 Mar 2023 12:13:56 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id q30-20020a50aa9e000000b004fadc041e13sm15050386edc.42.2023.03.27.12.13.55
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 12:13:56 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id b20so40545358edd.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 12:13:55 -0700 (PDT)
X-Received: by 2002:a17:906:6b84:b0:931:2bcd:ee00 with SMTP id
 l4-20020a1709066b8400b009312bcdee00mr6306754ejr.15.1679944435639; Mon, 27 Mar
 2023 12:13:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230327180449.87382-1-axboe@kernel.dk> <20230327180449.87382-2-axboe@kernel.dk>
 <CAHk-=wh4SOZ=kfxOe+pFvWFM4HHTAhXMwwcm3D_R6qR_m148Yw@mail.gmail.com>
 <2d33d8dc-ed1f-ed74-5cc5-040e321ac34f@kernel.dk> <CAHk-=whAJtbP0Y96rUhhLcKM4EqL7mMsVMnD4e4BbYK=GXpdCQ@mail.gmail.com>
In-Reply-To: <CAHk-=whAJtbP0Y96rUhhLcKM4EqL7mMsVMnD4e4BbYK=GXpdCQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Mar 2023 12:13:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiCVTXpE=NO1rnOX_KPMora9W9T11KB2vwgR8VXovAR1A@mail.gmail.com>
Message-ID: <CAHk-=wiCVTXpE=NO1rnOX_KPMora9W9T11KB2vwgR8VXovAR1A@mail.gmail.com>
Subject: Re: [PATCH 1/4] fs: make do_loop_readv_writev() deal with ITER_UBUF
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 27, 2023 at 12:11=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Ok, this is all the legacy "no iter_read/write" case, so that looks
> fine to me too.

.. and I guess that makes PATCH 2/4 go away too, which is a good sign.

            Linus
