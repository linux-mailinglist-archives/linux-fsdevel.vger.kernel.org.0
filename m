Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735A81BB4C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 05:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgD1Dmn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 23:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgD1Dmm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 23:42:42 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC42C03C1A9
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2020 20:42:42 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id n17so16010537ejh.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2020 20:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q1Hl4EoAQeecS6RJeMB353EzxseO3r7Hp2yIzNObp3I=;
        b=SplrAUntYpA62B1N75YvHPdEO4shjtitO6O7fp81NGqZCL/liBkn4YGhS2ufiW89mA
         6QRtLc38lw6xNb2vgvLJDvqC9mE3aqUJAqwD+PeOfBSBP94LeZ1hMSN6COmTdIaxaQpS
         UpK5WWl4Kpc44DM72q0SRTuLkDG5Cy7pTFjlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q1Hl4EoAQeecS6RJeMB353EzxseO3r7Hp2yIzNObp3I=;
        b=JAu7Qxh2bnGMAlDHkTvfQ1fZ/xhWk1AcnukhVSQfeiY3Z1VAgj0YhI6bUwcliOk+ys
         lBUr8hklCGDW5HwladtOEQZcwy0+nVUK3RzNh6bCfZVo9HlRqH/ug7sve/MPsVPc3t7g
         zARbrqmkh1+X2BnsitpCcG63itpYCXlT9t+mEEiT1sjx8vuovk5+ncNtSmF+ltGHdWiV
         kj5c6xY9vvNcdirT+2GSevw3K4z5yLQeF6T0lt+oHvJ8SSJv7nt8kxRJCVVCfxcUts44
         7WJ5MxnI6dnQvsqZDkQcSUCRfiS1mTzPAzotCp0cA6FqHZxIW9GwbP4ssyt3+q+M/GAY
         JjLQ==
X-Gm-Message-State: AGi0Pub9J+xD30ZlSYUhKzcg3iXucoA6MN09LK8ol7nK2PTMTP03SdBM
        RhRLJ/sAfFBCXi2CKEoF8wOVLVgyo4k=
X-Google-Smtp-Source: APiQypK2ham0Bh3U1L4UbRNqHktYl/5o4Mjkh2HHkCULRVrlM7UhRJQAWEb/T+QIirsZaBtm4H5VzQ==
X-Received: by 2002:a17:906:25cb:: with SMTP id n11mr23277840ejb.37.1588045360730;
        Mon, 27 Apr 2020 20:42:40 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id y23sm360858eju.85.2020.04.27.20.42.40
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 20:42:40 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id s10so15345998edy.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2020 20:42:40 -0700 (PDT)
X-Received: by 2002:a19:9109:: with SMTP id t9mr18095968lfd.10.1588044961861;
 Mon, 27 Apr 2020 20:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200428032745.133556-1-jannh@google.com> <20200428032745.133556-3-jannh@google.com>
In-Reply-To: <20200428032745.133556-3-jannh@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Apr 2020 20:35:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjSYTpTH0X8EcGGJD84tsJS62BN3tC6NfzmjvXdSkFVxg@mail.gmail.com>
Message-ID: <CAHk-=wjSYTpTH0X8EcGGJD84tsJS62BN3tC6NfzmjvXdSkFVxg@mail.gmail.com>
Subject: Re: [PATCH 2/5] coredump: Fix handling of partial writes in dump_emit()
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 27, 2020 at 8:28 PM Jann Horn <jannh@google.com> wrote:
>
> After a partial write, we have to update the input buffer pointer.

Interesting. It seems this partial write case never triggers (except
for actually killing the core-dump).

Or did you find a case where it actually matters?

Your fix is obviously correct, but it also makes me go "that function
clearly never actually worked for partial writes, maybe we shouldn't
even bother?"

             Linus
