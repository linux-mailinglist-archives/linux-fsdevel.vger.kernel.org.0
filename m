Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3EC4262B3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Oct 2021 05:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbhJHDEV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 23:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhJHDEU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 23:04:20 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CEDC061570;
        Thu,  7 Oct 2021 20:02:25 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id a73so1800559pge.0;
        Thu, 07 Oct 2021 20:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6Q3V7EH8l2IpZO4Ot7Mt4f30fT3Ph8j8fckQ39xjaXY=;
        b=mSWMMcLC5jgE+PhXrVd2rC8EkaVaENg3bR+KriFfud7ZTRMZqvXtJOC56n50KpGt6w
         oRjHaSUzwv3zubHBroFY5nrbJ+8ziFCv9BteANN5fMjF5n26gokkuiImQ8GledBS9fKD
         049WSa1jnOxgiEHtQSuvuUg3yXZ4DtChjoM0j6Vfr0sASjbtE1KNeXyJ3Hb+n2vQ3TzQ
         QqVFmBnk7dsJd37AwexdpajwP80UyqOqH9JBsJp4HG7IICUVghEt3OuSsvgJI53EKN53
         BGUVDV8HbW7gdNmyTyhEl1H5n3FGwJzuQHLeMqtTU3G5Y5APelCQH9C0ouNWTn3L8cqq
         dITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6Q3V7EH8l2IpZO4Ot7Mt4f30fT3Ph8j8fckQ39xjaXY=;
        b=OHc1a92JpgyT4sm/bFBfC8UvYbm9GgMTr+wEFcSpmcx4mDHPm1MA3z9x9WlEI55n0e
         TFSDGNIiet5YHjh8gctMBgcx2VKm6jbRRb3euk1aqarFMUvUmYL6+HHujIdwZ/Kojdt+
         kVy7KAZtrNwFzSn7wI4ga8uASFl75JSE8qKYU8h5LpDFLZ1IztTSt9qQTtmARzypHkiS
         +srSKhyoLdPDbK8yXV+7dCI9ofp8CVBmnNjXq0i/02Ty8erMumljff78OijcMJnotjqv
         21KafAnF8pvIaLDVR0iz++AGnT/jbBmFG21MnF43yTdjFjIqpqHcEUvMTqhRtN3Mh73e
         CQSg==
X-Gm-Message-State: AOAM532ErUCYpQOogYLGGi0d+rDMnzDURRS/p7FTRPVMnVLZ4oleid2z
        0Jp1SrTHd1mGMfiPKrEQesGSbnn8LxNZcLChGQ==
X-Google-Smtp-Source: ABdhPJyeZNOAn4GzIquroW5XcC4zBgwRbLpCZmkeCyRxRPzKEf6sjn8CTqryyTC1m+RbqWms3v02/9Fm/oo+/N/B1QY=
X-Received: by 2002:a63:2c02:: with SMTP id s2mr2585381pgs.205.1633662145285;
 Thu, 07 Oct 2021 20:02:25 -0700 (PDT)
MIME-Version: 1.0
References: <CACkBjsZh7DCs+N+R=0+mnNqFZW8ck5cSgV4MpGM6ySbfenUJ+g@mail.gmail.com>
 <CACkBjsb0Hxam_e5+vOOanF_BfGAcf5UY+=Cc-pyphQftETTe8Q@mail.gmail.com> <YV8B+VGQ7TZoeJ8W@casper.infradead.org>
In-Reply-To: <YV8B+VGQ7TZoeJ8W@casper.infradead.org>
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Fri, 8 Oct 2021 11:02:14 +0800
Message-ID: <CACkBjsZ8vxzSAnhVqnkJwQi1a5oCddGRZrK5bmvUQYzDKBDsjw@mail.gmail.com>
Subject: Re: kernel BUG in block_invalidatepage
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> =E4=BA=8E2021=E5=B9=B410=E6=9C=887=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=8810:20=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Oct 07, 2021 at 02:40:29PM +0800, Hao Sun wrote:
> > Hello,
> >
> > This crash can still be triggered repeatedly on the latest kernel.
>
> I asked you three days ago to try a patch and report the results:
>
> https://lore.kernel.org/linux-mm/YVtWhVNFhLbA9+Tl@casper.infradead.org/

Sorry, I missed that.

Here are the results.
Used reproducer: https://paste.ubuntu.com/p/yrYsn4zpcn/
Kernel log *before* applying the patch: https://paste.ubuntu.com/p/WtkFKB6V=
y9/
Kernel log *after* applying the patch: https://paste.ubuntu.com/p/S2VrtDdgg=
p/
Symbolized log: https://paste.ubuntu.com/p/RwXjCXDxB8/

In summary, the reproducer can crash the kernel with the same
backtrace before applying the patch.
After applying the patch, the reproducer program took about 3 minutes
to crash the kernel and the backtrace seems different (RIP points to
create_empty_buffers now).
All the above tests were done on commit 60a9483534ed (Merge tag
'warning-fixes-20211005').

Regards
Hao
