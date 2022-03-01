Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5388C4C94FF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 20:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbiCATuP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 14:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236472AbiCATty (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 14:49:54 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6744B5AED5
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Mar 2022 11:48:30 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id bn33so23324226ljb.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Mar 2022 11:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PzY8tILS7/J5BzJfiKLdBDXy8/s4RAHqODI+UdY57jc=;
        b=MSgmT6lRet0jPev3NhT8poLSNE2IuVKHhTmnMdindDPsxNrbDdzPrkBSaT4BauMeD+
         LWq3ALR2NImH9IAbyg/9Mpz0DLX1H3V94a1gLKACC1HvSqM9EwtH2Km4ZUYlkqLoZgsQ
         ZV7jqWBOB7cCGsim0JopuTtvt6tgng/ReKRwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PzY8tILS7/J5BzJfiKLdBDXy8/s4RAHqODI+UdY57jc=;
        b=dXZ9kfSRIZoG9ciFDZ4ZSyoWawmLFIQrxD+v51T6nlycNMQZY4w94umYM/I6SBu1qD
         5w6jUSk0i4wN2ORNV5qpB4CQR3gtWY5Zoo+KLVNuINhbWdBi70AD+o+rMg13OsgFvPn+
         DQ8owz6hcI+dEu1HTFSrGDhDU0NKvjDhI7Ztxuvu6MkGG0NGZmECo+A81xM78iaPkMoU
         r7coF346N/m5xxj7UP+JIAs72wlawmQ0eXmKS04LCdKoVd0rV7ZxBQu8qr8i49DbmYtk
         JWmRmrAt2TKKA3+nz/fM35rPXsq7Sj3s3DErz74DZBioyL/IcbUI/jElv6W2gYy8UIno
         QmGg==
X-Gm-Message-State: AOAM532S8soGY5ewmMHYzMizzGiehL+HMjT2Qrq3VmYDyWGsgeHuyO4e
        HYu6RmZrrfOSralp8qX2uScU0Zc5X9047mBDQaw=
X-Google-Smtp-Source: ABdhPJyZ19mDEFTttSbit9o9EOsFCw+qlWBNIDECtM8xL6jcG7gDRzz57c8SOvqNL4LnXYXL76oBXw==
X-Received: by 2002:a2e:5c88:0:b0:246:3ec2:2f6a with SMTP id q130-20020a2e5c88000000b002463ec22f6amr18613943ljb.419.1646164097842;
        Tue, 01 Mar 2022 11:48:17 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id k1-20020a2ea281000000b00244bc2ecfe9sm2071038lja.66.2022.03.01.11.48.17
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 11:48:17 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id l12so11428885ljh.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Mar 2022 11:48:17 -0800 (PST)
X-Received: by 2002:a2e:3013:0:b0:246:2ca9:365e with SMTP id
 w19-20020a2e3013000000b002462ca9365emr17983151ljw.291.1646163763108; Tue, 01
 Mar 2022 11:42:43 -0800 (PST)
MIME-Version: 1.0
References: <20220228110822.491923-1-jakobkoschel@gmail.com>
 <20220228110822.491923-3-jakobkoschel@gmail.com> <2e4e95d6-f6c9-a188-e1cd-b1eae465562a@amd.com>
 <CAHk-=wgQps58DPEOe4y5cTh5oE9EdNTWRLXzgMiETc+mFX7jzw@mail.gmail.com>
 <282f0f8d-f491-26fc-6ae0-604b367a5a1a@amd.com> <b2d20961dbb7533f380827a7fcc313ff849875c1.camel@HansenPartnership.com>
 <7D0C2A5D-500E-4F38-AD0C-A76E132A390E@kernel.org> <73fa82a20910c06784be2352a655acc59e9942ea.camel@HansenPartnership.com>
 <CAHk-=wiT5HX6Kp0Qv4ZYK_rkq9t5fZ5zZ7vzvi6pub9kgp=72g@mail.gmail.com>
In-Reply-To: <CAHk-=wiT5HX6Kp0Qv4ZYK_rkq9t5fZ5zZ7vzvi6pub9kgp=72g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 1 Mar 2022 11:42:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=wghQygmASNUWj=LZn5FR5wsce2osyR6EXcfEB_FaX_6Og@mail.gmail.com>
Message-ID: <CAHk-=wghQygmASNUWj=LZn5FR5wsce2osyR6EXcfEB_FaX_6Og@mail.gmail.com>
Subject: Re: [PATCH 2/6] treewide: remove using list iterator after loop body
 as a ptr
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        alsa-devel@alsa-project.org, linux-aspeed@lists.ozlabs.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-iio@vger.kernel.org, nouveau@lists.freedesktop.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        samba-technical@lists.samba.org,
        linux1394-devel@lists.sourceforge.net, drbd-dev@lists.linbit.com,
        linux-arch <linux-arch@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-staging@lists.linux.dev, "Bos, H.J." <h.j.bos@vu.nl>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        intel-wired-lan@lists.osuosl.org,
        kgdb-bugreport@lists.sourceforge.net,
        bcm-kernel-feedback-list@broadcom.com,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergman <arnd@arndb.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        v9fs-developer@lists.sourceforge.net,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-sgx@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, linux-usb@vger.kernel.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>,
        tipc-discussion@lists.sourceforge.net,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        dma <dmaengine@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 1, 2022 at 11:06 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So instead of that simple "if (!entry)", we'd effectively have to
> continue to use something that still works with the old world order
> (ie that "if (list_entry_is_head())" model).

Just to prove my point about how this is painful, that doesn't work at all.

If the loop iterator at the end is NULL (good, in theory), we can't
use "list_entry_is_head()" to check whether we ended. We'd have to use
a new thing entirely, to handle the "list_for_each_entry() has the
old/new semantics" cases.

That's largely why I was pushing for the "let's make it impossible to
use the loop iterator at all outside the loop". It avoids the
confusing case, and the patches to move to that stricter semantic can
be merged independently (and before) doing the actual semantic change.

I'm not saying my suggested approach is wonderful either. Honestly,
it's painful that we have so nasty semantics for the end-of-loop case
for list_for_each_entry().

The minimal patch would clearly be to keep those broken semantics, and
just force everybody to use the list_entry_is_head() case. That's the
"we know we messed up, we are too lazy to fix it, we'll just work
around it and people need to be careful" approach.

And laziness is a virtue. But bad semantics are bad semantics. So it's
a question of balancing those two issues.

               Linus
