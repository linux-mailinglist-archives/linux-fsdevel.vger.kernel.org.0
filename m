Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7F6258506
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 03:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgIABKT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 21:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbgIABKS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 21:10:18 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B37C061757;
        Mon, 31 Aug 2020 18:10:18 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id h126so2998594ybg.4;
        Mon, 31 Aug 2020 18:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SLItMwpds8PvPU4P2sv7HLwrxBWiBP0Um7y+hmraGk4=;
        b=Hs1BdaBWzOjEbPg2cphBXMN4RraVXJKEmo1h3dT7eY9IU1SX6amhN0wtHTFz+YD+WA
         FsItNSY2k3iRFTBmYJb1KjzYDHnIbmNM8Cxrr7dc0Nw95Tl8+S44dxcXFX6lj2zHZCtS
         eTdLiV6p/Os8AHbr+bDGP4j18paY0f3bAn/mDR8f+ajo3Wf4lzA/pN2QFkyICdFfdA6Z
         uO4libdvdiNOuLBBBP/TZqF2dWQlOk5qwrdxEQsvymhnKGwp9UTEQWNt2feRrjpUQgb9
         OoQYG2cGd+Y+BROyWk1OQC4wVSXVm631n1k3s8PWB28A/ePX03NYRP5oZxthuq8KdKyz
         g9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SLItMwpds8PvPU4P2sv7HLwrxBWiBP0Um7y+hmraGk4=;
        b=rGIKKDEWej2p8WlL49BkOIrlTSYVOy8VmC1GL4tebeSRAj9KJcNes83Apil2xeJCJO
         GQ7googO1KP5JL78uF6y9UUompqQNMMVZu3YI89Rl8n8k1TIaNePTDTJmylfr+nM8/5j
         pLhHkYWpYNOHyC+r+fAYPwpDbUdSTSZk7mPfHDxVzmxI+lEGDBGkmMkKNfs7Mw7PyDT5
         aT8pUbAvEN7Wut1fexRiXBt+HEek+aRPkhr/EVlFK15SorrfkEFVUpZ6FOproGU25kN8
         OctU3zRDfjiubcCHrmDcTbpZPBjBdg/KjCMw7TWS6L2F8G/bRE6nrhmbkUQ79s+MT7eD
         dtZg==
X-Gm-Message-State: AOAM532Og2ylLCexd2d4Fd/c/BGpr/BHvmIdDFCKIlYVV/8iQjv89Sv1
        +xe2JBNJYhVHq3ldNslgw9pUL6Nszlkgw2VvLSVU+XudDCmJig==
X-Google-Smtp-Source: ABdhPJwsRT//0rU9e9wznipNTD/56Rj9A9Cdlc1ilEiMr34cB2GPA2wPAMU9aB1Av3+JTO4XaIu4exvj3bwwXLd/cOc=
X-Received: by 2002:a5b:38a:: with SMTP id k10mr6694048ybp.428.1598922616582;
 Mon, 31 Aug 2020 18:10:16 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000084b59f05abe928ee@google.com> <29de15ff-15e9-5c52-cf87-e0ebdfa1a001@I-love.SAKURA.ne.jp>
 <20200807122727.GR1236603@ZenIV.linux.org.uk> <d96b0b3f-51f3-be3d-0a94-16471d6bf892@i-love.sakura.ne.jp>
 <20200901005131.GA3300@lca.pw>
In-Reply-To: <20200901005131.GA3300@lca.pw>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Tue, 1 Sep 2020 09:10:05 +0800
Message-ID: <CACVXFVNy+qKeSytvDduCuH3HV02mB7i88P27Ou+h=PC22hqwHw@mail.gmail.com>
Subject: Re: splice: infinite busy loop lockup bug
To:     Qian Cai <cai@lca.pw>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Al Viro <viro@zeniv.linux.org.uk>,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+61acc40a49a3e46e25ea@syzkaller.appspotmail.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@canonical.com>, paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 1, 2020 at 8:53 AM Qian Cai <cai@lca.pw> wrote:
>
> On Fri, Aug 07, 2020 at 09:34:08PM +0900, Tetsuo Handa wrote:
> > On 2020/08/07 21:27, Al Viro wrote:
> > > On Fri, Aug 07, 2020 at 07:35:08PM +0900, Tetsuo Handa wrote:
> > >> syzbot is reporting hung task at pipe_release() [1], for for_each_bvec() from
> > >> iterate_bvec() from iterate_all_kinds() from iov_iter_alignment() from
> > >> ext4_unaligned_io() from ext4_dio_write_iter() from ext4_file_write_iter() from
> > >> call_write_iter() from do_iter_readv_writev() from do_iter_write() from
> > >> vfs_iter_write() from iter_file_splice_write() falls into infinite busy loop
> > >> with pipe->mutex held.
> > >>
> > >> The reason of falling into infinite busy loop is that iter_file_splice_write()
> > >> for some reason generates "struct bio_vec" entry with .bv_len=0 and .bv_offset=0
> > >> while for_each_bvec() cannot handle .bv_len == 0.
> > >
> > > broken in 1bdc76aea115 "iov_iter: use bvec iterator to implement iterate_bvec()",
> > > unless I'm misreading it...
>
> I have been chasing something similar for a while as in,
>
> https://lore.kernel.org/linux-fsdevel/89F418A9-EB20-48CB-9AE0-52C700E6BB74@lca.pw/
>
> In my case, it seems the endless loop happens in iterate_iovec() instead where
> I put a debug patch here,
>
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -33,6 +33,7 @@
>                 if (unlikely(!__v.iov_len))             \
>                         continue;                       \
>                 __v.iov_base = __p->iov_base;           \
> +               printk_ratelimited("ITER_IOVEC left = %zu, n = %zu\n", left, n); \
>                 left = (STEP);                          \
>                 __v.iov_len -= left;                    \
>                 skip = __v.iov_len;                     \
>
> and end up seeing overflows ("n" supposes to be less than PAGE_SIZE) before the
> soft-lockups and a dead system,
>
> [ 4300.249180][T470195] ITER_IOVEC left = 0, n = 48566423
>
> Thoughts?

Does the following patch make a difference for you?

https://lore.kernel.org/linux-block/20200817100055.2495905-1-ming.lei@redhat.com/

thanks,
Ming Lei
