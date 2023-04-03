Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354796D3CE0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 07:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjDCF2Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 01:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbjDCF16 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 01:27:58 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB55440F7;
        Sun,  2 Apr 2023 22:27:43 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id v6-20020a05600c470600b003f034269c96so7062142wmo.4;
        Sun, 02 Apr 2023 22:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680499662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5fQdRTEI1i8/F4l3pJ8SBHj1sLBRQlwnHuZ8xOhP44I=;
        b=TIglhxIpebXZKT6rL4LQTq5HsDv03JONAyMgWy9XZNkV1VUf9Qh5B+n9utRT3wQ+kw
         0sP5zV7R4AKhNuOKsnr+U23AvAIeZLgyf/LnyR9/I7wyMT3MCvg4ycIw48NxPuJmb5yZ
         YAEIHH8LR7wNBRPtgFnCKIzVh8WAWE11FL7dUr+MsgzUqYlUo5tMIz2eI3F7P1l9JJ8p
         V0odtRkHiB6/qUb/FA6JyKAsVUUnbO2PT5wXECY8i9eGUBHJsQeSdSnwwWU5mSQT1F4w
         cg3XFZLnqr/Oa4HLJclyHncuYX28NSjGhhMCyI2CN9CPD7D4GM32tHoy/KXplcYevlqg
         oy1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680499662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5fQdRTEI1i8/F4l3pJ8SBHj1sLBRQlwnHuZ8xOhP44I=;
        b=LCEiVtvlYaNeWwX68UD8ZGr4MwgZb7bn+TkvAmP2ejDdvQlHmL9RtbGRBvjEZYrD4b
         GkIk3i0H+ygRTz4mX3seF4c10jM2NeLd2rNQjpXguE/DEgI6PpIO/8ChDRHo4iqA3xDh
         CGmPoFYeUt5nZxSONvrbID4iK5K7mz1pAyER/N2YJ6+qQU3cKUK3I+6u1XzCk9x/d14G
         HkyLDKJH5E0AfD6JdqdmTJFIkwgTyK06/kbK0BgIkaOXg5Txv97+L1N9iI68yhHBVpBn
         me9VRZbusdZMapzFvjEWPW+V3ctXuIa2/AsSvwY3GjyxjtHyAaFxjqFqwFlMwiS2DVNa
         3bUQ==
X-Gm-Message-State: AO0yUKXYXME/sXZErD1K3bVj11ylSiqSPUQG194YK8Yu4jg/ViMt3rQp
        t29D2FGuBegyMaU1XzFRhgvHhflrkGI=
X-Google-Smtp-Source: AK7set8wruzbw7XZm5BzWXX0HKa/kqpWbZicQqXA7UuELODsirJ2CN85ygt8t+pdeS9ydO2HttcS5Q==
X-Received: by 2002:a7b:c448:0:b0:3ed:2e02:1c02 with SMTP id l8-20020a7bc448000000b003ed2e021c02mr25804276wmi.23.1680499662120;
        Sun, 02 Apr 2023 22:27:42 -0700 (PDT)
Received: from suse.localnet (a-pi8-84.tin.it. [212.216.222.51])
        by smtp.gmail.com with ESMTPSA id g25-20020a7bc4d9000000b003eae73f0fc1sm10817348wmk.18.2023.04.02.22.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 22:27:41 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Evgeniy Dushistov <dushistov@mail.ru>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 0/4] fs/ufs: Replace kmap() with kmap_local_page
Date:   Mon, 03 Apr 2023 07:27:40 +0200
Message-ID: <10129918.0AQdONaE2F@suse>
In-Reply-To: <ZCGY3c5avRefahms@casper.infradead.org>
References: <20221229225100.22141-1-fmdefrancesco@gmail.com> <11383508.F0gNSz5aLb@suse>
 <ZCGY3c5avRefahms@casper.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On luned=C3=AC 27 marzo 2023 15:23:41 CEST Matthew Wilcox wrote:
> On Mon, Mar 27, 2023 at 12:13:08PM +0200, Fabio M. De Francesco wrote:
> > On gioved=C3=AC 29 dicembre 2022 23:50:56 CEST Fabio M. De Francesco wr=
ote:
> > > kmap() is being deprecated in favor of kmap_local_page().
> > >=20
> > > There are two main problems with kmap(): (1) It comes with an overhea=
d=20
as
> > > the mapping space is restricted and protected by a global lock for
> > > synchronization and (2) it also requires global TLB invalidation when=
=20
the
> > > kmap=E2=80=99s pool wraps and it might block when the mapping space i=
s fully
> > > utilized until a slot becomes available.
> > >=20
> > > With kmap_local_page() the mappings are per thread, CPU local, can ta=
ke
> > > page faults, and can be called from any context (including interrupts=
).
> > > It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
> > > the tasks can be preempted and, when they are scheduled to run again,=
=20
the
> > > kernel virtual addresses are restored and still valid.
> > >=20
> > > Since its use in fs/ufs is safe everywhere, it should be preferred.
> > >=20
> > > Therefore, replace kmap() with kmap_local_page() in fs/ufs.=20
kunmap_local()
> > > requires the mapping address, so return that address from ufs_get_pag=
e()
> > > to be used in ufs_put_page().
> >=20
> > Hi Al,
> >=20
> > I see that this series is here since Dec 29, 2022.
> > Is there anything that prevents its merging?
> > Can you please its four patches in your tree?
>=20
> I'm pretty sure UFS directories should simply be allocated from lowmem.
> There's really no reason to put them in highmem these days.

Matthew,

It's been a few days since you wrote but I still haven't done anything or=20
replied. For now, I just want you to know that it's not my intention to ign=
ore=20
your comment.

The only reasons I hesitate to follow your directions are that I built this=
=20
series based on specific suggestions from Al.=20

While I understand and, for sure, heed what you said, I also think I should=
=20
wait for Al to chime in with what he thinks about all this before taking a=
=20
different route for removing kmap() from fs/ufs.

Thanks for looking at this series.

=46abio=20



