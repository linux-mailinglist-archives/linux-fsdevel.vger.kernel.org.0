Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897EB7B0DD4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 23:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjI0VHA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 17:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjI0VG7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 17:06:59 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5078FD6;
        Wed, 27 Sep 2023 14:06:55 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-57bab4e9e1aso4581927eaf.3;
        Wed, 27 Sep 2023 14:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695848814; x=1696453614; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p/N9J8xP2hV+7YKX8oU/ArvVYv9CGsvu0WM88Yr0OGM=;
        b=TQglbpGf7yhciphrpm7NZkQL5uH6TO/S4TmwlbnflsHbiABuVpBm0/H5B8PGj+Qs6c
         Gfui2O7uPgMc6MT2InHp9FnO7kzJ63wyITLQx2SWBbvXQ45eRf2mgef9eJp+nH9dfBrs
         oGHEB9UNFS2HAVjI8I6BC1U/EH0YL45+JLnpTU7dLD8hFEBjY0TAur4GRPmzscs7l0AV
         efT/qKSFB4dmSgScp+L5ELPcKiu7jKDKMcyY+6QRz5wB8jG4tSy1ujChqE+Fgh1YYxpR
         e/nxSoV0HRaxarYA+CVm43T/ujS3RGCY88FCNRp+KXpEHy3oRPqxIxUY/0AZQO+O3eA9
         cPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695848814; x=1696453614;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p/N9J8xP2hV+7YKX8oU/ArvVYv9CGsvu0WM88Yr0OGM=;
        b=S1lR3l0uFIzYJzcMCSNSlAz0iY/6FWFsaXklhFNhiJBrBKaqNDMAem2IyMqr/sB7QZ
         sR58AjKEO6/VqckA+f/9fA0cD8C1RAydfd5L5ev4A5TofKcJifXq0lqDEiLcpJGMGMpT
         mW4Eei1qkDUMLDPBhlwcCfQjF1spOroAALICcas5az9cmsGoDRN79BtFzN2qSu088Q22
         GE2MYbrW+u6vW83/wDurLw7bmAdlXgVIVDZUDaCE5cIuEz4mVaOhNb3MgWSqp/ZCRqTz
         CafSeiXAWdy7zEEHX3N0E8tyn2NYjQdclmwBREzQcsb20f0Thuo4w598hIBZArwTtUmQ
         a2eg==
X-Gm-Message-State: AOJu0Yxl3wO3l8Rn6BOWKJmwEfjNtf9G7bb7Cq7+24fJgk5z5nkKfARw
        QLfkypvUhbvdcZskg1Z288DEfTp14ovlLDslkhEZMQvD
X-Google-Smtp-Source: AGHT+IHTNM4IyqIj174GbeMFvUR6Qu+DMzpIVDVOZFc19sZCwi0t/k7GorGdZXAsMq9fVhohkeStbjnZCH0qKyNmUgQ=
X-Received: by 2002:a4a:7319:0:b0:57b:eee7:4a40 with SMTP id
 s25-20020a4a7319000000b0057beee74a40mr3350538ooc.7.1695848814536; Wed, 27 Sep
 2023 14:06:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6802:1b45:b0:4f0:1250:dd51 with HTTP; Wed, 27 Sep 2023
 14:06:53 -0700 (PDT)
In-Reply-To: <CAHk-=wibs_xBP2BGG4UHKhiP2B=7KJnx_LL18O0bGK8QkULLHg@mail.gmail.com>
References: <20230926162228.68666-1-mjguzik@gmail.com> <CAHk-=wjUCLfuKks-VGTG9hrFAORb5cuzqyC0gRXptYGGgL=YYg@mail.gmail.com>
 <CAGudoHGej+gmmv0OOoep2ENkf7hMBib-KL44Fu=Ym46j=r6VEA@mail.gmail.com>
 <20230927-kosmetik-babypuppen-75bee530b9f0@brauner> <CAHk-=whLadznjNKZPYUjxVzAyCH-rRhb24_KaGegKT9E6A86Kg@mail.gmail.com>
 <CAGudoHH2mvfjfKt+nOCEOfvOrQ+o1pqX63tN2r_1+bLZ4OqHNA@mail.gmail.com>
 <CAHk-=wjmgord99A-Gwy3dsiG1YNeXTCbt+z6=3RH_je5PP41Zw@mail.gmail.com>
 <ZRR1Kc/dvhya7ME4@f> <CAHk-=wibs_xBP2BGG4UHKhiP2B=7KJnx_LL18O0bGK8QkULLHg@mail.gmail.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Wed, 27 Sep 2023 23:06:53 +0200
Message-ID: <CAGudoHH20JVecjRQEPa3q=k8ax3hqt-LGA3P1S-xFFZYxisL6Q@mail.gmail.com>
Subject: Re: [PATCH v2] vfs: shave work on failed file open
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/27/23, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> Btw, I think we could get rid of the RCU freeing of 'struct file *'
> entirely.
>
> The way to fix it is
>
>  (a) make sure all f_count accesses are atomic ops (the one special
> case is the "0 -> X" initialization, which is ok)
>
>  (b) make filp_cachep be SLAB_TYPESAFE_BY_RCU
>
> because then get_file_rcu() can do the atomic_long_inc_not_zero()
> knowing it's still a 'struct file *' while holding the RCU read lock
> even if it was just free'd.
>
> And __fget_files_rcu() will then re-check that it's the *right*
> 'struct file *' and do a fput() on it and re-try if it isn't. End
> result: no need for any RCU freeing.
>
> But the difference is that a *new* 'struct file *' might see a
> temporary atomic increment / decrement of the file pointer because
> another CPU is going through that __fget_files_rcu() dance.
>

I think you attached the wrong file, it has next to no changes and in
particular nothing for fd lookup.

You may find it interesting that both NetBSD and FreeBSD have been
doing something to that extent for years now in order to provide
lockless fd lookup despite not having an equivalent to RCU (what they
did have at the time is "type stable" -- objs can get reused but the
memory can *never* get freed. utterly gross, but that's old Unix for
you).

It does work, but I always found it dodgy because it backpedals in a
way which is not free of side effects.

Note that validating you got the right file bare minimum requires
reloading the fd table pointer because you might have been racing
against close *and* resize.

-- 
Mateusz Guzik <mjguzik gmail.com>
