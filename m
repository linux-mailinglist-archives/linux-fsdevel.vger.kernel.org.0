Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3BE43A8336
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 16:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhFOOvY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 10:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbhFOOvX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 10:51:23 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C154C06175F
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jun 2021 07:49:19 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id l4so12901881ljg.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jun 2021 07:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YyEZLduH7/iFgJwKc9vp/hqM3Vrl8HD6DqfsbR4sDVg=;
        b=HprZFfL4N7GTrn8vzzdG12NKJmO6iMJi+xyICKDRcSKmjzKtel9myIFjJw+b/IqOei
         66xHWiWeVwCuAn9OGrcgF1N0Ubrlt+z1LoJA1YKBS1nPPucqAaEIoAv/rXFNEUogqMR6
         xyEDcW2Pf1Ls1yhJOp8n844CnafVRsw4Toy54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YyEZLduH7/iFgJwKc9vp/hqM3Vrl8HD6DqfsbR4sDVg=;
        b=EKlXTVnsHMOKnmXqwvn9+Ac53XMSP9sWSHiSPPHe/FfqM3xrlF+0i997n33gysxv1O
         1pQX+9YuS8r7l52u+ppfODPsMumxu364vVXGdHbOf3fBNEqDxbz4WadR1AxSW2kKg19c
         /pD4Ci9UlC25vTevWX9kdZrTYoyKK7oO1JXoe6nEBEi5CHZu8rPldFSBRbsyI5eiyinD
         PCRcCIw7sXtWs+4KlL0+NQxyOorvgbsUDl0B7vuwWPfJlMZkGJObmWrFAws9Kk8JKn9f
         J8gi/UjwmeauNWOxqkOHqWA+AOHhwLyPvPw8A9Gh79A9xBYIfMlUci8DB0O9FwmaCfFR
         Kemw==
X-Gm-Message-State: AOAM531jzVSW3yaAGTsfuP3ZSSjf+KX4fOHW8Ag9yZNalh0XyW/71Fvp
        ZeOp6JSTeLnU876I3mKT0mpMz/bV057vFaUnkow=
X-Google-Smtp-Source: ABdhPJxT+AWOoGYw52NPQTccIIC6xEN4Zmu0J3dl/3mJ5d8wN0Xcf23rluZxALhqZsl/D+iwfgoXgQ==
X-Received: by 2002:a2e:6c09:: with SMTP id h9mr17930959ljc.434.1623768557152;
        Tue, 15 Jun 2021 07:49:17 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id 27sm1828212lfz.189.2021.06.15.07.49.16
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 07:49:16 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id r198so27470118lff.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jun 2021 07:49:16 -0700 (PDT)
X-Received: by 2002:a05:6512:3d13:: with SMTP id d19mr15953159lfv.41.1623768556044;
 Tue, 15 Jun 2021 07:49:16 -0700 (PDT)
MIME-Version: 1.0
References: <162375813191.653958.11993495571264748407.stgit@warthog.procyon.org.uk>
In-Reply-To: <162375813191.653958.11993495571264748407.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Jun 2021 07:49:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=whARK9gtk0BPo8Y0EQqASNG9SfpF1MRqjxf43OO9F0vag@mail.gmail.com>
Message-ID: <CAHk-=whARK9gtk0BPo8Y0EQqASNG9SfpF1MRqjxf43OO9F0vag@mail.gmail.com>
Subject: Re: [PATCH] afs: fix no return statement in function returning non-void
To:     David Howells <dhowells@redhat.com>
Cc:     Hulk Robot <hulkci@huawei.com>,
        Zheng Zengkai <zhengzengkai@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Tom Rix <trix@redhat.com>, linux-afs@lists.infradead.org,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 15, 2021 at 4:55 AM David Howells <dhowells@redhat.com> wrote:
>
> From: Zheng Zengkai <zhengzengkai@huawei.com>
>
> Add missing return to fix following compilation issue:
>
> fs/afs/dir.c: In function =E2=80=98afs_dir_set_page_dirty=E2=80=99:
> fs/afs/dir.c:51:1: error: no return statement in function
> returning non-void [-Werror=3Dreturn-type]

This warning is actively wrong, and the patch is the wrong thing to do.

What compiler / architecture / config?

Because BUG() should have an "unreachable()", and the compiler should
know that a return statement isn't needed (and adding it shouldn't
make any difference).

And it's not warning for me when I build that code. So I really think
the real bug is entirely somewhere else, and this patch is papering
over the real problem.

               Linus
