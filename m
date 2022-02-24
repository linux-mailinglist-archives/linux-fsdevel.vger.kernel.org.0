Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087444C2219
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 04:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiBXDOl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 22:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiBXDOk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 22:14:40 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25A21A2718;
        Wed, 23 Feb 2022 19:13:49 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-2d641c31776so10566327b3.12;
        Wed, 23 Feb 2022 19:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R2XTHubm34qtzXwVA3ruMMT7BpLGJcOTk/y/ohBRsCk=;
        b=BOcBjgdqlKkUNhQRx8iJ34wekjnTqi8fvUyoFE8px7UF4sma8TzYuiZrRq8b7grAKY
         9FLxRw4T0ukCJbVYH8ophek+sg8NVngm8KpkIRxWXWVEw5xQlM4gC7eQgb3dLFkm2XJm
         YzcN4EfzMuHJGPOvs6eTITer0PjfP1c1G8p3Bk1tJum43FrOOyZrelIAAhRGlrXECvS9
         oXJTJ9W6xr4oqSUSAyjx4SNjNfi9yS+rL1I8ImbA0ZpFp7o03EASSYvCnP0NqJ9f35jG
         3Tkspz2B4xLq4MJiASXAduu8RNSYoRPax6Ia3Vm08KChZS5QI8BIzvpqYoWoLBB2fjYw
         hgRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R2XTHubm34qtzXwVA3ruMMT7BpLGJcOTk/y/ohBRsCk=;
        b=PiCGQo/ai0WnN6ZbESErU0VC6IaFvudM96eRoHq/u566nIxOQqgLJTXDhull/wmxbp
         KLxaviWlAzp4gxYp9dL43wbWVd4TKE1v/l04VMqpauhwrkRkzBcaj9j2q2ZssLLolTaK
         7jmYba4pBgWzadJM1KxPyqpgESs7QwE5JuE2XhKpa/1Lnf6RPzVNiR1USXnvs6/cRNDs
         82WjA1PAscmx7GWh83Cj6qNLa0Lym1480R9cMoKBpjwa3CwMg/NnSZJUU8fW0fllN27E
         4b0106qSMcNV65VCSSDv4U169b5yOgqsMG9O66/WW0YopEmyrWCQOpjUczFp42hWVW9q
         SRrg==
X-Gm-Message-State: AOAM530cqqMOgPw58C86lih7rVoHwBMnS3KPurIDoNA+OwcKZ1fHkXcp
        qTwuz+j3juVV6moBHasypCSyKxN/f1poYtUEV0B7fuC01uPV9Q==
X-Google-Smtp-Source: ABdhPJxA6BArqjMw2Z9YlyTkVe8BIRh8fXZDDu3tfkvoJyDTRU7VhIvlYQ6QsHBnjYRDeWcaHuQwkuorY2SYO3AX154=
X-Received: by 2002:a0d:ed01:0:b0:2d4:6dfd:bec with SMTP id
 w1-20020a0ded01000000b002d46dfd0becmr597678ywe.191.1645672428586; Wed, 23 Feb
 2022 19:13:48 -0800 (PST)
MIME-Version: 1.0
References: <20220223231752.52241-1-ppbuk5246@gmail.com> <YhbCGDzlTWp2OJzI@zeniv-ca.linux.org.uk>
 <CAM7-yPTM6FNuT4vs2EuKAKitTWMTHw_XzKVggxQJzn5hqbBHpw@mail.gmail.com> <Yhb0vB/G2a92zJJP@zeniv-ca.linux.org.uk>
In-Reply-To: <Yhb0vB/G2a92zJJP@zeniv-ca.linux.org.uk>
From:   Yun Levi <ppbuk5246@gmail.com>
Date:   Thu, 24 Feb 2022 12:13:37 +0900
Message-ID: <CAM7-yPSorBJzb7NH_Od5mTgDLtgaD-azVNaP0h6-z=aAV_4URQ@mail.gmail.com>
Subject: Re: [PATCH] fs/exec.c: Avoid a race in formats
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 24, 2022 at 12:00 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Thu, Feb 24, 2022 at 08:59:59AM +0900, Yun Levi wrote:
>
> > I think if someone wants to control their own binfmt via "ioctl" not
> > on time on LOAD.
> > For example, someone wants to control exec (notification,
> > allow/disallow and etc..)
> > and want to enable and disable own's control exec via binfmt reg / unreg
> > In that situation, While the module is loaded, binfmt is still live
> > and can be reused by
> > reg/unreg to enable/disable his exec' control.
>
> Er...  So have your ->load_binary() start with
>         if (I_want_it_disabled)
>                 return -ENOEXEC;
> and be done with that.
> The only caller of that thing is
>         list_for_each_entry(fmt, &formats, lh) {
>                 if (!try_module_get(fmt->module))
>                         continue;
>                 read_unlock(&binfmt_lock);
>
>                 retval = fmt->load_binary(bprm);
>
>                 read_lock(&binfmt_lock);
>                 put_binfmt(fmt);
>                 if (bprm->point_of_no_return || (retval != -ENOEXEC)) {
>                         read_unlock(&binfmt_lock);
>                         return retval;
>                 }
>         }
> so returning -ENOEXEC is equivalent to not having it in the list.
> IDGI...  Why bother unregistering/re-registering/etc.?

For example, someone wants to control exec via policy (allow or deny exec)
In that case, it just wants to confirm the policy NOT LOAD binary but
want to pass
the LOAD to the next binfmt (That's the reason __register_binfmt with insert).
So, To do this, register linux_binfmt with its own with load_binary
function like

    if (this binary allow to run)
                return -ENOEXEC; // pass to next binfmt to load that binary
    else if (deny)
               return -1;

And enable / disable is determined by registered or unregistered status.
That mean

// ioctl hook for enable
         // enable by register binfmt
         __register_binfmt(binfmt, 1);

// ioctl hook for disable
         // disable by unreigster binfmt
        __unregister_binfmt(binfmt);

Because, __unregister_binfmt isn't called int module __exit, but call
while the module is live,
it makes a problem.

It looks so strange, But in the case of the kernel without FTRACE,
BPF, KPROBE, etc
I think there's no other way to  control exec running.
So I just do stupid test :)

But When I read Eric's answer,
I think __unregister_binfmt should be only called in the module __exit
function...
right?
