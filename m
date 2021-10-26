Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6064743B9F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 20:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236731AbhJZSwv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 14:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236750AbhJZSwu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 14:52:50 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A74C061745
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Oct 2021 11:50:25 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id c28so749928lfv.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Oct 2021 11:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r5Cx2RnmHPH+SxoKka0sJEz3NkssP3YCqbiSsqzadkQ=;
        b=XWmvXqx6E/lnwqgDlacsJYsSx9OK8zrlmcuZe075Kg2Q7afYrlM28LUphtMnNWBBss
         19rtrgtkK+y60H9M3H213OTzx4KlKQs5vTnOVoJ7FFgOi4799TI0MlAwQR64ujeGGpUF
         Ec975XRObLADp1do89z7xhEJGw/WNDenswDZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r5Cx2RnmHPH+SxoKka0sJEz3NkssP3YCqbiSsqzadkQ=;
        b=YAouCwmD5CqGaI3AH1vjOJ2/BvfvDJIz7+8gbJFj5y4VGhOol6rHjcSLiGEfJ+gbbg
         3RXaGCNWUSJsoXXr0vupVtQ6hBHZ+UC5+2w81ZejGmyNJsVUGFFml3vjKCG+4iL5ENS5
         TTMaMYrl4B13y7vkxXR0b73pVNzRxvdMnP+KHeJbNFx2Tx+8J11uZ9mzP6VQepuRjwnJ
         v8/vQjN/Zjb2Nrbq+axlS5Vsh79McCr+8aAOJnR6xT/vwa5By2qPFBK2oKUDw3A8yjOn
         2/OMPvnWxT0IYFuqVLm56HDU/HxwOovdDCJ5KPHIF6Yl7JI8k2S1e458FC+yBURecqX/
         2Luw==
X-Gm-Message-State: AOAM532N6BEPYImm0nP7WT4b2YaSNQoQIikLflhkeRChnVtG+IkVMF9k
        typEnM+uEm8yveFCbMhePshPfM8wwPWTCLil
X-Google-Smtp-Source: ABdhPJxqiI4XKCg0TpaC8FIiNYnE6m25sdrKbAn7lJv29sDbxc/tFFsMQrxfVqW/7NQ5Fxi7JvdmLw==
X-Received: by 2002:a05:6512:3b9:: with SMTP id v25mr13022262lfp.435.1635274223625;
        Tue, 26 Oct 2021 11:50:23 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id 13sm2004455lfq.285.2021.10.26.11.50.21
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 11:50:21 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id o26so506530ljj.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Oct 2021 11:50:21 -0700 (PDT)
X-Received: by 2002:a2e:9e13:: with SMTP id e19mr4519488ljk.494.1635274221013;
 Tue, 26 Oct 2021 11:50:21 -0700 (PDT)
MIME-Version: 1.0
References: <20211019134204.3382645-1-agruenba@redhat.com> <CAHk-=wh0_3y5s7-G74U0Pcjm7Y_yHB608NYrQSvgogVNBxsWSQ@mail.gmail.com>
 <YXBFqD9WVuU8awIv@arm.com> <CAHk-=wgv=KPZBJGnx_O5-7hhST8CL9BN4wJwtVuycjhv_1MmvQ@mail.gmail.com>
 <YXCbv5gdfEEtAYo8@arm.com> <CAHk-=wgP058PNY8eoWW=5uRMox-PuesDMrLsrCWPS+xXhzbQxQ@mail.gmail.com>
 <YXL9tRher7QVmq6N@arm.com> <CAHk-=wg4t2t1AaBDyMfOVhCCOiLLjCB5TFVgZcV4Pr8X2qptJw@mail.gmail.com>
 <CAHc6FU7BEfBJCpm8wC3P+8GTBcXxzDWcp6wAcgzQtuaJLHrqZA@mail.gmail.com> <YXhH0sBSyTyz5Eh2@arm.com>
In-Reply-To: <YXhH0sBSyTyz5Eh2@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 26 Oct 2021 11:50:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjWDsB-dDj+x4yr8h8f_VSkyB7MbgGqBzDRMNz125sZxw@mail.gmail.com>
Message-ID: <CAHk-=wjWDsB-dDj+x4yr8h8f_VSkyB7MbgGqBzDRMNz125sZxw@mail.gmail.com>
Subject: Re: [PATCH v8 00/17] gfs2: Fix mmap + page fault deadlocks
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com, kvm-ppc@vger.kernel.org,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 26, 2021 at 11:24 AM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> While more intrusive, I'd rather change copy_page_from_iter_atomic()
> etc. to take a pointer where to write back an error code.

I absolutely hate this model.

The thing is, going down that rat-hole, you'll find that you'll need
to add it to *all* the "copy_to/from_user()" cases, which isn't
acceptable. So then you start doing some duplicate versions with
different calling conventions, just because of things like this.

So no, I really don't want a "pass down a reference to an extra error
code" kind of horror.

That said, the fact that these sub-page faults are always
non-recoverable might be a hint to a solution to the problem: maybe we
could extend the existing return code with actual negative error
numbers.

Because for _most_ cases of "copy_to/from_user()" and friends by far,
the only thing we look for is "zero for success".

We could extend the "number of bytes _not_ copied" semantics to say
"negative means fatal", and because there are fairly few places that
actually look at non-zero values, we could have a coccinelle script
that actually marks those places.

End result: no change in calling conventions, no change to most users,
and the (relatively few) cases where we look at the "what about
partial results", we just add a

         .. existing code ..
         ret = copy_from_user(..);
+        if (ret < 0)
+                break;  // or whatever "fatal error" situation
         .. existing  code ..

kind of thing that just stops the re-try.

(The coccinelle script couldn't actually do that, but it could add
some comment marker or something so that it's easy to find and then
manually fix up the places it finds).

             Linus
