Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C762401ED8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Sep 2021 18:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242559AbhIFRAt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Sep 2021 13:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbhIFRAt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Sep 2021 13:00:49 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1AAC061757
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Sep 2021 09:59:44 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id l7-20020a0568302b0700b0051c0181deebso9423388otv.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Sep 2021 09:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qrLm5oiqWxtTolUGRrcV++cwGJOtI1kBWO0Y+h4a8lQ=;
        b=bFjpeuCAK/idr93IKqOzbMhnC0tD4Ww48HBjomkc4V0BwLGor9/aI2NwbQGaGadJz/
         FX/h7wWUUrm2gK6h0utkr6cvoinC3mEOk8MFxawJU7CwcLkAJeAvGc+IDed6pR/GA40y
         5MoP6fVCNQFcOnXsxzrkexrFfLYr/3/H1zQcIHAYodGjwOTo0qFxZ7t3QcnRgDxLiykQ
         CAonMw8KoGC0Dne/TeIBJ3msrrLguaTJGBuggaYU8T/ypbkTfA6BTRzN8JKorQNUG4vQ
         xXP+lVsC2LfY5PQOBf+31IGzXXmFWpf0J8Bn5yAtvBfsVw12vLtxNPnZidgTKB93TzRP
         IMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qrLm5oiqWxtTolUGRrcV++cwGJOtI1kBWO0Y+h4a8lQ=;
        b=RVeuL2tFCkOw58csRSWAjdNs8SWr9GKfmCLAFEqKuQP44NPwjZfxSoPWlJa+DaEsfv
         qt43L54989SAT+n0u2yGUxGQkDC48eZwaWKis0WlaD7AaFLh5jH4WQNja/oDeyA4Lcqf
         w6L8ydlHq4xW0sJ6gePG/dGrkKSqxNNGO+VPXo2w3aAqVVMv3QJBK66dnauo+un0/SgN
         CGaiBTzKbNZUnbrsowTBLuflY/v1e2Ks2u/VeeX5gmaDhrwPuB9KutYAEdDFyuLhWJCt
         PtLy9/TXBMVG2oVSqQHHUgVu0MolIvpBjRYFx0AoZ+GlN3gKHY0R5ZMTk1Dx9kl7qsZn
         OtWg==
X-Gm-Message-State: AOAM5328IArDJyll9dmnRqYSHw7zwKS2Y8BAE8i7yOT2js4V0UmSPZZk
        12kIBOzev+qL2CeuOk7fF3932Fyg4/YFLDzl8oetbe+a2XzsAg==
X-Google-Smtp-Source: ABdhPJxMvAmEjY2nhcR5beo/FeOh/yMmQMyUSuywR7WxGcYSbdKqdRxrQRHaeNsJo0DsPvxas+voZPXERwIlWR5cLq4=
X-Received: by 2002:a05:6830:444:: with SMTP id d4mr11753774otc.108.1630947583309;
 Mon, 06 Sep 2021 09:59:43 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000bc92ac05cb4ead3e@google.com> <CAJfpeguqH3ukKeC9Rg66pUp_jWArn3rSBxkZozTVPmTnCf+d6g@mail.gmail.com>
In-Reply-To: <CAJfpeguqH3ukKeC9Rg66pUp_jWArn3rSBxkZozTVPmTnCf+d6g@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 6 Sep 2021 18:59:32 +0200
Message-ID: <CANpmjNM4pxRk0=B+RZzpbtvViV8zSJiamQeN_7mPn-NMxnYX=g@mail.gmail.com>
Subject: Re: [syzbot] linux-next test error: KASAN: null-ptr-deref Read in fuse_conn_put
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     syzbot <syzbot+b304e8cb713be5f9d4e1@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 6 Sept 2021 at 13:56, Miklos Szeredi <miklos@szeredi.hu> wrote:
> Thanks,
>
> Force pushed fixed commit 660585b56e63 ("fuse: wait for writepages in
> syncfs") to fuse.git#for-next.
>
> This is fixed as far as I'm concerned, not sure how to tell that to syzbot.

Thanks -- we can let syzbot know:

#syz fix: fuse: wait for writepages in syncfs

(The syntax is just "#syz fix: <commit title>".)
