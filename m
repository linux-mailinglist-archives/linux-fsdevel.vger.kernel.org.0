Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DBC660856
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jan 2023 21:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235842AbjAFUek (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Jan 2023 15:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235692AbjAFUeW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Jan 2023 15:34:22 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F28C6CFF6;
        Fri,  6 Jan 2023 12:34:20 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id f34so3576602lfv.10;
        Fri, 06 Jan 2023 12:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XaDPfwoL+u15r2egWWYGKKyUhV9uIWkWkMZ5qdh5ZFM=;
        b=k5txLsZIED9lM3Jb2r0MHLESXqPke1bd6U9IcmJpKvb23bLiRIKeqFj9wGUf2Dgls+
         ZTFCesl2VsGFUIAnp7lq2vWUTT6s6yj8AnEQcFwxx3KoSwAgmStWBlasg9sqOySQR7Wl
         BwN+Qm1yHSTTnbQ7nhYtWPjSm2o7z7fbD+cdwVvtR2p/2+aV42to0WakK/8NzTuUMH3y
         rxWMOppyosFEERITJbodzqQSJl6SuAI2mn1KHARSATyyp5kgwr6E6YhzflS23dNsNsXD
         je02DMVYAO7TsLCcciqffYqRflN+oDvnvcvhU/2yEsl9O3XQLHJr9apomcIh3fCqDzqR
         TUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XaDPfwoL+u15r2egWWYGKKyUhV9uIWkWkMZ5qdh5ZFM=;
        b=qlTAHBqkSzI1xPjph/dMO4vL0HuENvPg0aH8nNgBp8reroBaoK3Og3k4FO1EdaxMSb
         cEgVwrUqO3fS9CiVeOun6nnbDKV/ReECBdSKimQ78kwh//prgCMlSf8i3Vipzp2KZvuH
         TL9c/rzVIAiJ02JaXpEJJ3brwj9B8lMMQnaNcJjrqIFsoNY4P2rswUaRIjsn4y1TlY6r
         0tKZDQXyr/wBowjPjH+rcRFSNOBCPxtCwG+goGKK1kx1ihAGm2cBw4LdM/NDN3Ofctzs
         5xTJjQ1kFWicdjX3AlxUsV0VYMpbXeO6nAKJ31EBdiO/7sKsFITJj9KX5DBR8NvLty3e
         MLnw==
X-Gm-Message-State: AFqh2kq07owlapoVO+rfmTDc4/WXegW4RA/OiyrsfJj6zBT2AK6mIapk
        2HCM9LcVNTU1ZKGx3OnNX4DzBItDNhVYgbvGQn7ccTcH3G4=
X-Google-Smtp-Source: AMrXdXsr1MLYtopcnh+tmLgUHTFBMtoAcRNcihp/WJ9wQEGNmo3ZRBDdlafs9UXuVKYMg7uokWiYoSomzRcluiTgcTI=
X-Received: by 2002:a05:6512:3e12:b0:4ca:6c11:d3e5 with SMTP id
 i18-20020a0565123e1200b004ca6c11d3e5mr2597435lfv.224.1673037258430; Fri, 06
 Jan 2023 12:34:18 -0800 (PST)
MIME-Version: 1.0
References: <20230106094844.26241-1-zhanghongchen@loongson.cn> <Y7hyw+fTdgAF6uYP@bombadil.infradead.org>
In-Reply-To: <Y7hyw+fTdgAF6uYP@bombadil.infradead.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 6 Jan 2023 21:33:41 +0100
Message-ID: <CA+icZUUdGCdzYvdi3_vdpHqNvE12wsAw3CKCmeut1-R78kjHHg@mail.gmail.com>
Subject: Re: [PATCH v3] pipe: use __pipe_{lock,unlock} instead of spinlock
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Hongchen Zhang <zhanghongchen@loongson.cn>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
        David Howells <dhowells@redhat.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Eric Dumazet <edumazet@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 6, 2023 at 8:40 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Fri, Jan 06, 2023 at 05:48:44PM +0800, Hongchen Zhang wrote:
> > Use spinlock in pipe_read/write cost too much time,IMO
> > pipe->{head,tail} can be protected by __pipe_{lock,unlock}.
> > On the other hand, we can use __pipe_{lock,unlock} to protect
> > the pipe->{head,tail} in pipe_resize_ring and
> > post_one_notification.
> >
> > I tested this patch using UnixBench's pipe test case on a x86_64
> > machine,and get the following data:
> > 1) before this patch
> > System Benchmarks Partial Index  BASELINE       RESULT    INDEX
> > Pipe Throughput                   12440.0     493023.3    396.3
> >                                                         ========
> > System Benchmarks Index Score (Partial Only)              396.3
> >
> > 2) after this patch
> > System Benchmarks Partial Index  BASELINE       RESULT    INDEX
> > Pipe Throughput                   12440.0     507551.4    408.0
> >                                                         ========
> > System Benchmarks Index Score (Partial Only)              408.0
> >
> > so we get ~3% speedup.
> >
> > Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
> > ---
>
> After the above "---" line you should have the changlog descrption.
> For instance:
>
> v3:
>   - fixes bleh blah blah
> v2:
>   - fixes 0-day report by ... etc..
>   - fixes spelling or whatever
>
> I cannot decipher what you did here differently, not do I want to go
> looking and diff'ing. So you are making the life of reviewer harder.
>

Happy new 2023.

Positive wording... You can make reviewers' life easy when...
(encourage people).
Life is easy, people live hard.

+1 Adding ChangeLog of patch history

Cannot say...
Might be good to add the link to Linus test-case + your results in the
commit message as well?

...
Link: https://git.kernel.org/linus/0ddad21d3e99 (test-case of Linus
suggested-by Andrew)
...
Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
...

Thanks.

Best regards,
-Sedat-
