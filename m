Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9CC7401E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 19:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjF0RJo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 13:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjF0RJl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 13:09:41 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAD91726
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 10:09:39 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-c15a5ed884dso3416954276.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 10:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687885779; x=1690477779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEfOOj7zZRsR4093w5Xezdtfqq/JXEJS/CeyQ2VX6y0=;
        b=qAGBVo+6BR+jme9c+D+CU2a/HdzfRO4Smyw+4vv/W4I1jKgLWzo2vd5hMJUHdw3fkX
         IJNH8qRtKo+5gPnluLFgDX0SPxosg2Tr1jNfFqqoiSu11uqRJYvDMtanGXBT1x0IkF6Y
         ba6+9LwZiwkO7sWkoB43e404iG9OBoNL5QBSX0MGxliMIjCNPke9m99etfmYL8jhdCUV
         tX883ywh8R4BwLNDanA/fkNoFWFXCJC5yWiuCCLPQoJxcVJR+gMgtIVUupMj4ruxQvGL
         ebhN165884+Diht68TH0anDDe0ObeWm+6pLlX+boJpCHjSxzQPWEWJVmPkxSSa+JouHz
         JL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687885779; x=1690477779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AEfOOj7zZRsR4093w5Xezdtfqq/JXEJS/CeyQ2VX6y0=;
        b=E1tWHkj52RRKyX34DJSPqu8hOYttswTS2pL14t3++VddyPI1GBzKomuoHco6BZzlLn
         N1fZhhuiUyqKigIaYz+YM5fCkxWRRDYgTmGn+//niCkn7UxsgFMZsy6BkZgzlsZaAk6p
         rvoqPgyOy1qxY5hatMVrP0BXxFgsaGc0EzUDGvvT09FM75gtWVxY0nkUV/z5qISdAaQB
         o6LuG95I0BjKoom2PN5mRqmmAJOLW8NW3d/gzzJnMFPLvZtkc+aAq/kW4k6B5u26OgsH
         g/dcgAa7x7zw8PP+k3up71StPp2Aypjq3TqKsCYs+LyYi68776tmI5thSkEpSYWBqlP5
         ieoQ==
X-Gm-Message-State: AC+VfDynPYoy4Il22WW+nQtE45WubfzH6w3J+Vua28i3pxgvkJz0DZ4j
        79v+bW8W4iCR2M38BIdeiDdFX4yb5VCOE9nNQVtRQw==
X-Google-Smtp-Source: ACHHUZ7BtHxgVW1W1XrKrjwW5U8vVpsEPZv6JStuwihqH7MgrzQKZ6h1CfZqEbifWrFKNPuWb1XHCmKI5k0ybOr7NLI=
X-Received: by 2002:a25:2903:0:b0:bff:d530:f06 with SMTP id
 p3-20020a252903000000b00bffd5300f06mr16876866ybp.41.1687885778638; Tue, 27
 Jun 2023 10:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230626201713.1204982-1-surenb@google.com> <ZJn1tQDgfmcE7mNG@slm.duckdns.org>
 <20230627-kanon-hievt-bfdb583ddaa6@brauner>
In-Reply-To: <20230627-kanon-hievt-bfdb583ddaa6@brauner>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 27 Jun 2023 10:09:27 -0700
Message-ID: <CAJuCfpECKqYiekDK6Zw58w10n1T4Q3R+2nymfHX2ZGfQVDC3VQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] kernfs: add kernfs_ops.free operation to free
 resources tied to the file
To:     Christian Brauner <brauner@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, gregkh@linuxfoundation.org,
        peterz@infradead.org, lujialin4@huawei.com,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, mingo@redhat.com,
        ebiggers@kernel.org, oleg@redhat.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 27, 2023 at 1:24=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Mon, Jun 26, 2023 at 10:31:49AM -1000, Tejun Heo wrote:
> > On Mon, Jun 26, 2023 at 01:17:12PM -0700, Suren Baghdasaryan wrote:
> > > diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
> > > index 73f5c120def8..a7e404ff31bb 100644
> > > --- a/include/linux/kernfs.h
> > > +++ b/include/linux/kernfs.h
> > > @@ -273,6 +273,11 @@ struct kernfs_ops {
> > >      */
> > >     int (*open)(struct kernfs_open_file *of);
> > >     void (*release)(struct kernfs_open_file *of);
> > > +   /*
> > > +    * Free resources tied to the lifecycle of the file, like a
> > > +    * waitqueue used for polling.
> > > +    */
> > > +   void (*free)(struct kernfs_open_file *of);
> >
> > I think this can use a bit more commenting - ie. explain that release m=
ay be
> > called earlier than the actual freeing of the file and how that can lea=
d to
> > problems. Othre than that, looks fine to me.
>
> It seems the more natural thing to do would be to introduce a ->drain()
> operation and order it before ->release(), no?

I assume you mean we should add a ->drain() operation and call it when
kernfs_drain_open_files()  causes kernfs_release_file()? That would
work but if any existing release() handler counts on the current
behavior (release() being called while draining) then we should find
and fix these. Hopefully they don't really depend on the current
behavior but I dunno.
