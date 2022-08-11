Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7DE5907B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Aug 2022 23:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235746AbiHKVFd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Aug 2022 17:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiHKVFc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Aug 2022 17:05:32 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1CB4B0DE
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Aug 2022 14:05:30 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id k26so35611509ejx.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Aug 2022 14:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=+QZ+KaGgt7MnctN6vT+uXm6XR4X4HtUsaEf6HoCJd9A=;
        b=c8TefhIeCgWFOsoYhh5bAwGDJykerAO4U9P5UhybrBNKfFcReVDHRg/622gw67QqQv
         t44pbz3Mx4qUetLdGOw8l3M54nlQ4Mv1hPyCVDjihClM7YQsZE9ykRPP3TumUWivGppN
         MmyNPWAivDtuWgbwDg36LcW0XW2IDZmk/v8nzJaXvEiMjDTDaUlEjbbdqB38Uxf/ZBYI
         uS5+4PLJnPFHaFcMoEoUWdTsAvQWuOph3uIw6sRwSwxOZK8d/imqWADFnMfgKmxJmdCT
         /ODpoxGZ9XLNGtlzxpWqFa1SBNG2u1nOAJMOG2R7XKfL5ZqnoQZnJg7ZqinL1xsJN6Dz
         xWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=+QZ+KaGgt7MnctN6vT+uXm6XR4X4HtUsaEf6HoCJd9A=;
        b=gKdGCc6LgDwvjK2LbssxL4HN9XVXLxf3pDsKbzCE9E/fAccrMts46vDF0bNQRaHRyr
         uUF0+f3UxXTi2bOTzykuJFgh/vDegG2gknpAWkg21+QoDfxDdbOTUm8d27rfkU0D3zFS
         24yG0dhvvavXxDk60FrgrAGYzmTsANg3Exfuzl6/FBFPy4/QsfUqwsq4RMEw7np66CNC
         3FFTnXuz0Ig41HaLEXfLtkjtzfsSP8JCiJ6ogeZv5VP6QMBuNS6k0Te17hVka1g02gMk
         NmqNSSdf8wqUXOGX+9BESHnD/DtT0salAnVvq7TJuuVf1lSNREzSZchYTWTUjzEWC0UW
         BWBA==
X-Gm-Message-State: ACgBeo0nUDKg1ZlkWQrOcncHB8FqkER4hTmJ4rtweMM13WNsw1zdvnLV
        ZAkfvuhQHbL9eDR2BpsZJ6tgO2iT+9Kfun6dXPm5WV+6Jq+ICw==
X-Google-Smtp-Source: AA6agR5vYoRgLQd3JyRIc+xRdFQLup1YJNpNCvPLTWy/2TtKymvaCjbm/vEGBIFKhNvmuYa7n5uxMugeALqvgHqSzXM=
X-Received: by 2002:a17:906:84ef:b0:730:ba33:512b with SMTP id
 zp15-20020a17090684ef00b00730ba33512bmr610217ejb.346.1660251928742; Thu, 11
 Aug 2022 14:05:28 -0700 (PDT)
MIME-Version: 1.0
From:   Frank Dinoff <fdinoff@google.com>
Date:   Thu, 11 Aug 2022 17:05:12 -0400
Message-ID: <CAAmZXruoj6vYi3AA2X3mnzOACniG_5ZrTmEFKYp7=fbr6aRHGQ@mail.gmail.com>
Subject: fuse: incorrect attribute caching with writeback cache disabled
To:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I have a binary running on a fuse filesystem which is generating a zip file. I
don't know what syscalls are involved since the binary segfaults when run with
strace.

After doing a binary search,
https://github.com/torvalds/linux/commit/fa5eee57e33e79b71b40e6950c29cc46f5cc5cb7
is the commit that seems to have introduced the error. It still seems to
failing with a much newer kernel.

Reverting the fuse_invalidate_attr_mask in fuse_perform_write to
fuse_invalidate_attr makes every other run of the binary produce the correct
output.

I found that enabling the writeback cache makes the binary always produce the
right output. Running the fuse daemon in single threaded mode also works.

Is there anything that sticks out to you that is wrong with the above commit?

Thanks,
Frank Dinoff
