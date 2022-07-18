Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5DF57821C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jul 2022 14:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbiGRMVd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jul 2022 08:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235025AbiGRMVb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:21:31 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1F224F3F
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jul 2022 05:21:29 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id bp15so20882530ejb.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jul 2022 05:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ie8y8xom7gdgORK3/wgC6v2nBY/N6LA9J5NWgTDl2HM=;
        b=dZ9jScMt4MO13dtuzooZqTSxO2bjJkLycwSI6B0TBmg9pnUReCQ76CmaV4WQ6A5J1F
         BXd0HR3D0YzUSUo21ICIN4NsTAl3SmzYXTrgawKRuq35PsRaR1GgaemH76YDIv0NQeDv
         D1EK/PliBPHo5GdlCRd296v+4mVWyx5UzS/OI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ie8y8xom7gdgORK3/wgC6v2nBY/N6LA9J5NWgTDl2HM=;
        b=GOfjD1abANEtFAr/SUikcbnJNWROKgUoIFl2d6DksgZUo4O5esZg14Ph/uwK07iTwo
         SmjX0LfQxvCAjvC5zRi7+cW3K7dGTqpFzBik3WXGd+yeA+7KBY0P4erjFgqdnVJV5v7p
         kiStaRkVbc4MfP1THI9VAFlUtQ/Qk3HxtZ2CPn2jLtG6d1JoUXTTlaUQkKFkTLN0C+vv
         h1gE5ry3XjEg4uNHZus/oEaZc21vrcQpdnJ3J4PjBGCg8dxMqCjnqddyt4l33iTmzJp4
         dhfhOiiPsWYdp5kdoYl/VWtXlzrPRdfszcoDdYFBABdVzVsKpSSg1IeivYW03lWvC+98
         7j6g==
X-Gm-Message-State: AJIora+H54pqQkdPhM7D3Nwk7BNY/wUVkssHNL45tawm7Up+uskcvxLJ
        KA9dqq5aFw6V3pVAIlcmrFc6OMi/p/hKcL9/42QsHg==
X-Google-Smtp-Source: AGRyM1vI/im93ImHCgZ05iECidEYFcWtEzzcaF2dJOWQB1/Yq5IMa3L6gYgLFbipMZiZCi+5b2lvg6oArb2FqBJ9MTI=
X-Received: by 2002:a17:906:93ef:b0:72b:44e2:bdd8 with SMTP id
 yl15-20020a17090693ef00b0072b44e2bdd8mr25545654ejb.192.1658146887863; Mon, 18
 Jul 2022 05:21:27 -0700 (PDT)
MIME-Version: 1.0
References: <4B9D76D5-C794-4A49-A76F-3D4C10385EE0@kohlschutter.com>
 <CAJfpegs1Kta-HcikDGFt4=fa_LDttCeRmffKhUjWLr=DxzXg-A@mail.gmail.com>
 <83A29F9C-1A91-4753-953A-0C98E8A9832C@kohlschutter.com> <CAJfpegv5W0CycWCc2-kcn4=UVqk1hP7KrvBpzXHwW-Nmkjx8zA@mail.gmail.com>
 <FFA26FD1-60EF-457E-B914-E1978CCC7B57@kohlschutter.com>
In-Reply-To: <FFA26FD1-60EF-457E-B914-E1978CCC7B57@kohlschutter.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 18 Jul 2022 14:21:16 +0200
Message-ID: <CAJfpeguDAJpLMABsomBFQ=w6Li0=sBW0bFyALv4EJrAmR2BkpQ@mail.gmail.com>
Subject: Re: [PATCH] ovl: Handle ENOSYS when fileattr support is missing in
 lower/upper fs
To:     =?UTF-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 18 Jul 2022 at 12:56, Christian Kohlsch=C3=BCtter
<christian@kohlschutter.com> wrote:

> However, users of fuse that have no business with overlayfs suddenly see =
their ioctl return ENOTTY instead of ENOSYS.

And returning ENOTTY is the correct behavior.  See this comment in
<asm-generic/errrno.h>:

/*
 * This error code is special: arch syscall entry code will return
 * -ENOSYS if users try to call a syscall that doesn't exist.  To keep
 * failures of syscalls that really do exist distinguishable from
 * failures due to attempts to use a nonexistent syscall, syscall
 * implementations should refrain from returning -ENOSYS.
 */
#define ENOSYS 38 /* Invalid system call number */

Thanks,
Miklos
