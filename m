Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44919551F97
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jun 2022 17:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiFTPBs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jun 2022 11:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241570AbiFTPBd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:01:33 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC9B20BD0
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jun 2022 07:28:19 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u12so21471100eja.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jun 2022 07:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pil7tKVsdF88YiSTYvAmIS8siU4AYztEaIhmLusf/GY=;
        b=L9pDxGW7dLxdqFS02Dwyg/tLCZlw+KHTBVjrBubXeLpZSMthr4prHV8fFfO+3ZjH5c
         LMoVe2Ida86H5VB0nA25dgSiC479aaTL7ykxNW6OeO9IAap6Aig4zF/GXZLCuz5KayS/
         L2JRfKhdayKg/Qc+XGOGZygg+Z/GIMLghIv3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pil7tKVsdF88YiSTYvAmIS8siU4AYztEaIhmLusf/GY=;
        b=KBq6O3tRtvseT+miyrbxwqycFJf2aw3zHqrmjLEnM03XmJaYATq94oXxqcm8OmFAOs
         6xxLcxvXe1Sn9D2FiAZrE2KSfiYgE2G9QlrYUtkWVP/meks+cYgzhLBvO4p+qod8DdH+
         eCDAzr2vjF/PSowYYQn1iZ7yjBrVsLO9oBRnoFTz6I+RTh4dqgd/ZyI4eW2OW6aetLgM
         LLI0ehXXatC7nO/dDT+cNA9v/4m6U1VL9nk2O0Qsbs2rg8IBK3wvxvBpOblXjwxsjlyP
         o1PetZEopZqIyP98TLnTVyB1brAEz8CVReL95sDqFuDo99PkVb/x7bc6zrjs+AiyOkAe
         OkvA==
X-Gm-Message-State: AJIora9Y88Y2Hu1hPm9UfqIOLca0PR/epSUgzV3imKHVH5ht05cPMb1p
        W5+8osoRtznXZx0NXF++fwUEZ38qGZkU+AYG
X-Google-Smtp-Source: AGRyM1uaNVtS3ZxYZ8ClCFdIrUEPrint9SydKTqDnuaS9zVJ5q39PMZa//q5HVeh7BNgkf4Hph1TWQ==
X-Received: by 2002:a17:907:7f1c:b0:711:f3b4:da5 with SMTP id qf28-20020a1709077f1c00b00711f3b40da5mr20648935ejc.508.1655735298198;
        Mon, 20 Jun 2022 07:28:18 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id eg40-20020a05640228a800b004356d82b129sm6240564edb.80.2022.06.20.07.28.16
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 07:28:17 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id q15so5920804wmj.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jun 2022 07:28:16 -0700 (PDT)
X-Received: by 2002:a1c:5418:0:b0:39c:3552:c85e with SMTP id
 i24-20020a1c5418000000b0039c3552c85emr35780628wmb.68.1655735296313; Mon, 20
 Jun 2022 07:28:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220620134947.2772863-1-brauner@kernel.org> <20220620134947.2772863-2-brauner@kernel.org>
In-Reply-To: <20220620134947.2772863-2-brauner@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Jun 2022 09:28:00 -0500
X-Gmail-Original-Message-ID: <CAHk-=wjapw1A3qmuCPsCVCi4dynbDxb9ocjzs2EF=EDufe8y8Q@mail.gmail.com>
Message-ID: <CAHk-=wjapw1A3qmuCPsCVCi4dynbDxb9ocjzs2EF=EDufe8y8Q@mail.gmail.com>
Subject: Re: [PATCH 1/8] mnt_idmapping: add kmnt{g,u}id_t
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Seth Forshee <sforshee@digitalocean.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>
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

On Mon, Jun 20, 2022 at 8:50 AM Christian Brauner <brauner@kernel.org> wrote:
>
> Introduces new kmnt{g,u}id_t types. Similar to k{g,u}id_t the new types
> are just simple wrapper structs around regular {g,u}id_t types.

Thanks for working on this.,

I haven't actually perused the series yet, but wanted to just
immediately react to "please don't make random-letter type names".

"gid" is something people understand. It's a thing.

"kgid" kind of made sense, in that it's the "kernel view of the gid",
and it was still short and fairly legible.

"kmntgid" is neither short, legible, or makes sense.

For one thing, the "k" part no longer makes any sense. It's not about
the "kernel view of the gid" any more. Sure, it's "kernel" in the
sense that any kernel code is "kernel", but it's no longer some kind
of "unified kernel view of a user-namespace gid".

So the "k" in "kgid" doesn't make sense because it's a kernel thing,
but more as a negative: "it is *not* the user visible gid".

So instead of changing all our old "git_t" definitions to be "ugid_t"
(for "user visible gid") the "kgid_t" thing was done.

As a result: when you translate it to the mount namespace, I do not
believe that the "k" makes sense any more, because now the point to
distinguish it from "user gids" no longer exists. So it's just one
random letter. In a long jumble of letters that isn't really very
legible or pronounceable.

If it didn't have that 'i' in it, I would think it's a IBM mnemonic
(and I use the word "mnemonic" ironically) for some random assembler
instruction. They used up all the vowels they were willing to use for
the "eieio" instructions, and all other instruction names are a jumble
of random consonants.

So please try to make the type names less of a random jumble of
letters picked from a bag.

That "kmnt[gu]id" pattern exists elsewhere too, in the conversion
functions etc, so it's not just the type name, but more of a generic
"please don't use letter-jumble names".

Maybe just "mnt_[gu]id"" instead of "kmnt[gu]id" would be better.

But even that smells wrong to me. Isn't it really "the guid/uid seen
by the filesystem after the mount mapping"? Wouldn't it be nice to
name by the same "seen by users" and "seen by kernel" to be "seen by
filesystrem"? So wouln't a name like "fs_[gu]id_t" make even more
sense?

I dunno. Maybe I'm thinking about this the wrong way, but I wish the
names would be more explanatory. My personal mental image is that the
user namespaces map a traditional uid into the "kernel id space", and
then the mount id mappings map into the "filesystem id space". Which
is why to me that "k" doesn't make sense, and the "mnt" doesn't really
make tons of sense either (the mount is the thing that _maps_ the id
spaces, but it's not the end result of said mapping).

IOW, I get the feeling that you've named the result with the mapping,
not with the end use. That would be like naming "kuid" by the mapping
(usernamespace), not the end result (the kernel namespace).

But maybe it's just me that is confused here. Particularly since I
didn't really more than *very* superficially and quickly scan the
patches.

                Linus
