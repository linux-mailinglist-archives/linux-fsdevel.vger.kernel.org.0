Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57267B3BE6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 23:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbjI2VXJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 17:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjI2VXI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 17:23:08 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF76C1AA;
        Fri, 29 Sep 2023 14:23:05 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-57bb6b1f764so5950110eaf.2;
        Fri, 29 Sep 2023 14:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696022585; x=1696627385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=giQVxRnSKY3QwiXLgUPf/Ch70Hbxs7OwhgAJkcsQUjA=;
        b=FjzxfIxQT8pZDpS0Ej5dJSBpenrlTmqXe1dL3aXaZN8lze/8RkRfy1GSx/0ev271dj
         pFlfS+TmzNWEuclt+ZGldSCYneVgNKzA/aXM0gNp20Frd7pSMQhbC9we3O3Bm3hFSsTq
         fu0fTo9Ovy93JJxGg/CpPo2XyMcD5fjpUpMNDkGdQ5E5sfuc+WYZGA3GEPOkzXXascxz
         vRWNCiug965iODUGryaonvcRaMLVfh/TL+1tS+LWseFI/u9HH5i2dP9ElIu3L4159CsO
         jZflXcLKnbsRapOqO3kq+9/zELdJGU3+IcxnJe0HehEMj7MlKQrbf1qGumhGxC1EfDbB
         5l+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696022585; x=1696627385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=giQVxRnSKY3QwiXLgUPf/Ch70Hbxs7OwhgAJkcsQUjA=;
        b=S48+UFbAyaqeuGJ/UxbSfpdH9oo/X46eH+GBUtFttRgQR7TP1jG56vFNlOa74XBtdJ
         CVlLNpmkPdktvuIk5oOsziGkjOPR43FIiLvONjZkuJek66nzGkIqW+uNbV+d8v6zsGzE
         hre+0eKRStfXcDokSCmq4Al8OOG2NrtAADEALFidWVV5A/Qn/v1OeVh/EgaBP0HjBt7N
         c34+mxDtnnQQ6rdIHt9s267gQJVDgEfybVB0cSWoEIW6vyKdeL3HwLJyoK2Ujmu0LpuH
         HWhyiF6tn3PmHHSh60Ms7fR3HoEnh2qi8jSUfVBIbdo6afan8VPRhVEX2SJv3cfVvqTr
         B5Jw==
X-Gm-Message-State: AOJu0YwX0ybyIPamcK3dN0MzwrAsMtG9gb6c3KLIQo2RTO06oDbE5J9C
        Sr9O26WOXzU4E6URVjITb1JT7UU2diFMoeVqdXo=
X-Google-Smtp-Source: AGHT+IH5Et/yp4t4kN0h2nPyvLqfLtWEqtEjH/QKZuOxDswWLgWzHhcJafHLL+Q1AqHfVc0Q6f5IkcVF+nLz9+QWlb0=
X-Received: by 2002:a4a:3948:0:b0:57b:a92a:ece9 with SMTP id
 x8-20020a4a3948000000b0057ba92aece9mr5263570oog.6.1696022585053; Fri, 29 Sep
 2023 14:23:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:108:0:b0:4f0:1250:dd51 with HTTP; Fri, 29 Sep 2023
 14:23:04 -0700 (PDT)
In-Reply-To: <20230929-test-lauf-693fda7ae36b@brauner>
References: <CAGudoHH2mvfjfKt+nOCEOfvOrQ+o1pqX63tN2r_1+bLZ4OqHNA@mail.gmail.com>
 <CAHk-=wjmgord99A-Gwy3dsiG1YNeXTCbt+z6=3RH_je5PP41Zw@mail.gmail.com>
 <ZRR1Kc/dvhya7ME4@f> <CAHk-=wibs_xBP2BGG4UHKhiP2B=7KJnx_LL18O0bGK8QkULLHg@mail.gmail.com>
 <20230928-kulleraugen-restaurant-dd14e2a9c0b0@brauner> <20230928-themen-dilettanten-16bf329ab370@brauner>
 <CAG48ez2d5CW=CDi+fBOU1YqtwHfubN3q6w=1LfD+ss+Q1PWHgQ@mail.gmail.com>
 <CAHk-=wj-5ahmODDWDBVL81wSG-12qPYEw=o-iEo8uzY0HBGGRQ@mail.gmail.com>
 <20230929-kerzen-fachjargon-ca17177e9eeb@brauner> <CAG48ez2cExy+QFHpT01d9yh8jbOLR0V8VsR8_==O_AB2fQ+h4Q@mail.gmail.com>
 <20230929-test-lauf-693fda7ae36b@brauner>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Fri, 29 Sep 2023 23:23:04 +0200
Message-ID: <CAGudoHHwvOMFqYoBQAoFwD9mMmtq12=EvEGQWeToYT0AMg9V0A@mail.gmail.com>
Subject: Re: [PATCH v2] vfs: shave work on failed file open
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/29/23, Christian Brauner <brauner@kernel.org> wrote:
> On Fri, Sep 29, 2023 at 03:31:29PM +0200, Jann Horn wrote:
>> On Fri, Sep 29, 2023 at 11:20=E2=80=AFAM Christian Brauner <brauner@kern=
el.org>
>> wrote:
>> > > But yes, that protection would be broken by SLAB_TYPESAFE_BY_RCU,
>> > > since then the "f_count is zero" is no longer a final thing.
>> >
>> > I've tried coming up with a patch that is simple enough so the pattern
>> > is easy to follow and then converting all places to rely on a pattern
>> > that combine lookup_fd_rcu() or similar with get_file_rcu(). The
>> > obvious
>> > thing is that we'll force a few places to now always acquire a
>> > reference
>> > when they don't really need one right now and that already may cause
>> > performance issues.
>>
>> (Those places are probably used way less often than the hot
>> open/fget/close paths though.)
>>
>> > We also can't fully get rid of plain get_file_rcu() uses itself becaus=
e
>> > of users such as mm->exe_file. They don't go from one of the rcu
>> > fdtable
>> > lookup helpers to the struct file obviously. They rcu replace the file
>> > pointer in their struct ofc so we could change get_file_rcu() to take =
a
>> > struct file __rcu **f and then comparing that the passed in pointer
>> > hasn't changed before we managed to do atomic_long_inc_not_zero().
>> > Which
>> > afaict should work for such cases.
>> >
>> > But overall we would introduce a fairly big and at the same time subtl=
e
>> > semantic change. The idea is pretty neat and it was fun to do but I'm
>> > just not convinced we should do it given how ubiquitous struct file is
>> > used and now to make the semanics even more special by allowing
>> > refcounts.
>> >
>> > I've kept your original release_empty_file() proposal in vfs.misc whic=
h
>> > I think is a really nice change.
>> >
>> > Let me know if you all passionately disagree. ;)
>
> So I'm appending the patch I had played with and a fix from Jann on top.
> @Linus, if you have an opinion, let me know what you think.
>
> Also available here:
> https://gitlab.com/brauner/linux/-/commits/vfs.file.rcu
>
> Might be interesting if this could be perfed to see if there is any real
> gain for workloads with massive numbers of fds.
>

I would feel safer with a guaranteed way to tell that the file was realloca=
ted.

I think this could track allocs/frees with a sequence counter embedded
into the object, say odd means deallocated and even means allocated.

Then you would know for a fact whether you raced with the file getting
whacked and would never have to wonder if you double-checked
everything you needed (like that f_mode) thing.

This would also mean that consumers which get away with poking around
the file without getting a ref could still do it, this is at least
true for tid_fd_mode. All of them would need patching though.

Extending struct file is not ideal by any means, but the good news is that:
1. there is a 4 byte hole in there, if one is fine with an int-sized counte=
r
2. if one insists on 8 bytes, the struct is 232 bytes on my kernel
(debian). still some room up to 256, so it may be tolerable?

--=20
Mateusz Guzik <mjguzik gmail.com>
