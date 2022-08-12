Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE26590E27
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Aug 2022 11:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238008AbiHLJdR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Aug 2022 05:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbiHLJdQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Aug 2022 05:33:16 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098D011825
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Aug 2022 02:33:15 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id fy5so1079640ejc.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Aug 2022 02:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=EZd93Ya9T6I5An9uBAyyxeIIY3d4C/FkCrQN1On9TFs=;
        b=Q048Jpf5DtGYBIwbHSs4cbiot9m7OdXEgBG5gg47cv1qrYciPV9R2z+Yt2sbgZGUWf
         C7fCB8/1y7bK47GTL6QmwWgdiL1oe+cObdbGRjjQTsMMZ5JASQsShw3c92fDr0sfs3uY
         2Et1hkPRbJVi88K2orWbD3Zn2kUZv+IpqZe08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=EZd93Ya9T6I5An9uBAyyxeIIY3d4C/FkCrQN1On9TFs=;
        b=dpWJWsgogU6nyJ6erBjd7dhEvC9mmIneSFX029o8BEzQzykHFtN7OLEAJt9YVnlRZ9
         FQziiwwc5woEUVrGlYfUEU1GpLz0uEzNXIvQWEMnxJN4kMHnrQ08oSd6hsWbj2Ye036S
         XHp69PhTr6WxAa2Ekb5vIxKJhXgThBtxL0wEKWj9crpXVNAEl1ajKMRtn+WV/w+/jvJ6
         blk1FVaP+WHggrBY2qaZTpGj1nTB8ykksWzn/ISnXXeRkXr75pGU1ovxcUbYHz9i5CKE
         Wu8QyZ+Xh1VQj1cDhPIrrWOxsCf7tjz0YyZsCgTe+pX7FW/MZqSVXUdkwo8L0s393sNu
         D+fw==
X-Gm-Message-State: ACgBeo2aJDLf8mjKNcGScCSiyAbiUfFq0wQcYmnXDgUPHWUSJNmwmr8p
        OXSNA3KiIA8aqtqh/rMKKI+VSKm+l00UvD4d8WdFpw==
X-Google-Smtp-Source: AA6agR5fEHh/7hi+3AWaeWQWfk/pq2vDcO8Tnc9IlATporBQaSD+nuAATafHI6pobqPrXQi7TRn7c7/lJNcUzyoEl8s=
X-Received: by 2002:a17:907:75f1:b0:72b:9e40:c1a9 with SMTP id
 jz17-20020a17090775f100b0072b9e40c1a9mr2090997ejc.523.1660296793587; Fri, 12
 Aug 2022 02:33:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAAmZXruoj6vYi3AA2X3mnzOACniG_5ZrTmEFKYp7=fbr6aRHGQ@mail.gmail.com>
In-Reply-To: <CAAmZXruoj6vYi3AA2X3mnzOACniG_5ZrTmEFKYp7=fbr6aRHGQ@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 12 Aug 2022 11:33:02 +0200
Message-ID: <CAJfpegtf7QR1=-sV59jUsJKX4f1T3Mcov=HjoTZUdLf+XyA-3A@mail.gmail.com>
Subject: Re: fuse: incorrect attribute caching with writeback cache disabled
To:     Frank Dinoff <fdinoff@google.com>
Cc:     linux-fsdevel@vger.kernel.org
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

On Thu, 11 Aug 2022 at 23:05, Frank Dinoff <fdinoff@google.com> wrote:
>
> I have a binary running on a fuse filesystem which is generating a zip file. I
> don't know what syscalls are involved since the binary segfaults when run with
> strace.

You could strace the fuse filesystem.

> After doing a binary search,
> https://github.com/torvalds/linux/commit/fa5eee57e33e79b71b40e6950c29cc46f5cc5cb7
> is the commit that seems to have introduced the error. It still seems to
> failing with a much newer kernel.

How is it failing?

> Reverting the fuse_invalidate_attr_mask in fuse_perform_write to
> fuse_invalidate_attr makes every other run of the binary produce the correct
> output.

What do you mean?  Is it succeeding half the time?

>
> I found that enabling the writeback cache makes the binary always produce the
> right output. Running the fuse daemon in single threaded mode also works.
>
> Is there anything that sticks out to you that is wrong with the above commit?

Could you try adding STATX_MODE to the invalidated mask?   Can't
imagine any other attribute being relevant.

Thanks,
Miklos
