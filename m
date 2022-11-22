Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726816337BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Nov 2022 09:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbiKVI7y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Nov 2022 03:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbiKVI7V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:59:21 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA86C47303
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Nov 2022 00:58:34 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-3a7081e3b95so33763927b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Nov 2022 00:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rjqv25rWWEtR1zBiyBsGJy5jmsV/uC/d3iK5e8meezM=;
        b=Debqw6K//5JO0uRGLJgyvzVf+d//XS5xvwBVJOczASNpX3roBvWuTMMgL2e0JreOIV
         x79ORcuLBBHpeltwgRO2Dw9p/gEmQw9HuxuoWl1KUqF45wRc6sY1TqoCo2TYyFLC9vjV
         kyF199DuHalUtiD+xFpIjlwH8mxz/UifToukRr/VF5l57TmMBscERwwp4oWixvaAK11a
         QMhAQAyKIN6ZWGTMn0+BpZRutwJcRpKRijSD8KJwKdAWRE8TnMq9puR1KtTCUSNblthE
         f7vfFmNfiu12LTiXuJJXWFOm/wcXvUywprHB60X+/D+ppLnaw+JphD3h7yTYuOqXhQHn
         Qvjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rjqv25rWWEtR1zBiyBsGJy5jmsV/uC/d3iK5e8meezM=;
        b=lwVQ/FhJZXxDC86gJ0y2o8sBBPnFqyLZAbNJC4EI3pLr0oAkVf0gpg4tZqq/QXelx+
         qsisjebj0O+DyudKqD7BYr1xngFBtF9yNL7chfCMZJvh6ud/eNFuX+T3x8RfGGRUg1Jr
         C+3HyIsx448FaYYyjLpLGjQiBZWnkq7qjYUvORYQpAsxHoQmdxz+eT071vkhDkNaicAm
         7xO69qIY/O0FYmIbhV14ZNjPYjIT5aPCZXMleahO4TdqVbKVdbhHfoSlsCb+82hEBliv
         wUCvKA8h5nBhuGbWQAobLbx2ndJJ5+75KcSZClO6gc311iDLnwmPd0s4NRXbvzN0jVxr
         XhvQ==
X-Gm-Message-State: ANoB5pmhE9bfwIQdO9qd7PjuOUAXzTSd97NVK9ILJA7COait/lGZ7Git
        LeeVnK2DxPuDqECw5K4ovSPk9eb5fezhweaGg7jTyA==
X-Google-Smtp-Source: AA0mqf4wDwK/XWUxdraM37iTax/qOyyWnB+16Ye1sv/PKOtKjjqKpBpldGte1NW/BYAV+FAvU13uBdvUK1Pp3cuqfXc=
X-Received: by 2002:a81:dd05:0:b0:36e:8228:a127 with SMTP id
 e5-20020a81dd05000000b0036e8228a127mr2737632ywn.299.1669107513776; Tue, 22
 Nov 2022 00:58:33 -0800 (PST)
MIME-Version: 1.0
References: <20221121112134.407362-1-glider@google.com> <20221121112134.407362-2-glider@google.com>
 <Y3vVp/2A9nao8HZ2@gmail.com>
In-Reply-To: <Y3vVp/2A9nao8HZ2@gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 22 Nov 2022 09:57:57 +0100
Message-ID: <CAG_fn=VA=ZDX4mLruDAMsMa1o11s7c9B9n3k7vohwFu2dpUmAA@mail.gmail.com>
Subject: Re: [PATCH 2/5] fs: affs: initialize fsdata in affs_truncate()
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        chao@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 21, 2022 at 8:46 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Mon, Nov 21, 2022 at 12:21:31PM +0100, Alexander Potapenko wrote:
> > When aops->write_begin() does not initialize fsdata, KMSAN may report
> > an error passing the latter to aops->write_end().
> >
> > Fix this by unconditionally initializing fsdata.
> >
> > Suggested-by: Eric Biggers <ebiggers@kernel.org>
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>
> Are you sure that is the correct Fixes commit?  What about commit f2b6a16=
eb8f5
> ("fs: affs convert to new aops")?

Hmm, indeed, you are right.

> - Eric



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
