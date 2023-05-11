Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0B86FFB65
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 May 2023 22:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239309AbjEKUk4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 May 2023 16:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239015AbjEKUkz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 May 2023 16:40:55 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EC6AD
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 May 2023 13:40:52 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-61b5da092dfso41459446d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 May 2023 13:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683837652; x=1686429652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZx8FpQdLVzyY5XjqVFGkizAxjSRSvIZJciSNIfEcDI=;
        b=V31+M9mgzwDUisMy4JDnJDouRAbsaL7pgoffAx/ibC37kMSfO1+m5Ckl4dF2YIbx6Y
         14tG8z8oHdHnyT3BhNZ68dUmkvkIX2RZyNT0iuqaCU1bWJxlzw/2G9Mg7PsOOTQkrRR2
         LENQ/q6YuRjcAfhfIG49GvYyegOaAw2YvXMXEQiutviQvY/XL/nNv5MunRO5PZsrKaOV
         dANDmtfkJwVa5ProdP2UWjpHESzcPCcdR7g8TcsTgg0tUQAl4pL0xHxUk+dJvq3qefrz
         7e9Dvt4yx0mTF/0nJcU/783igvVhbYIB/PafPCntuI7bQ3E5LaWhoML03Sr9QXQNRgTO
         xS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683837652; x=1686429652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZx8FpQdLVzyY5XjqVFGkizAxjSRSvIZJciSNIfEcDI=;
        b=HEiaJdbqUKMLBZnOmS6pV+KXM/7+NUqn2aSlofNXG8w2Sv1eRN237vUJ90iqx1me/k
         0iUzIaNFxaKYrvFqFNsOCDr8eLuBqcqfrh5XLrk1NgxxrANGwDciZfq51/qxBzkeKWWp
         +rzT7bx04kwWYaYnRAPJGDVJ3w0HrciS+CzSY5Nl8y453jHoguR+gQwHj+yLRlR24tob
         b1Vrib+jq1tZ0qjWSAecBD6J00Vc9HYaiZepa4RWkz64geCfX3VVTX8DDepZGqj4Cbkx
         FAzj8BpxOTU3KQKpj3F+AAucvt7nouexCR4dj9k/mMX0mye2IZ4QHHSZ4QbT4JFImyi8
         tTew==
X-Gm-Message-State: AC+VfDyl7brO2OlCKa+C95UyXFhxyKOV1Rb7EgdLKPByJNVphmbBnTJ1
        R4qaQJqgXT8e53/O1LiqD2UtrO0qXn41UUlm5H8ipg==
X-Google-Smtp-Source: ACHHUZ5U6vqjOUU6SjFBcnB4SMX76q/SJW3pj9XYjfIWuMWuVVkfkZOy0EWLaWX1PvF4jheB/PcL22YAF72NkqzLBrg=
X-Received: by 2002:ad4:594d:0:b0:621:65de:f5f9 with SMTP id
 eo13-20020ad4594d000000b0062165def5f9mr5248392qvb.5.1683837651964; Thu, 11
 May 2023 13:40:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230511182426.1898675-1-axelrasmussen@google.com> <20230511202243.GA5466@monkey>
In-Reply-To: <20230511202243.GA5466@monkey>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Thu, 11 May 2023 13:40:16 -0700
Message-ID: <CAJHvVcg+Sm-=F=Xhi-WVLRxDcDcYzD8AwLpHHoP8zLubOoX6TQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: userfaultfd: add new UFFDIO_SIGBUS ioctl
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        Huang Ying <ying.huang@intel.com>,
        James Houghton <jthoughton@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        ZhangPeng <zhangpeng362@huawei.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 11, 2023 at 1:29=E2=80=AFPM Mike Kravetz <mike.kravetz@oracle.c=
om> wrote:
>
> On 05/11/23 11:24, Axel Rasmussen wrote:
> > The basic idea here is to "simulate" memory poisoning for VMs. A VM
> > running on some host might encounter a memory error, after which some
> > page(s) are poisoned (i.e., future accesses SIGBUS). They expect that
> > once poisoned, pages can never become "un-poisoned". So, when we live
> > migrate the VM, we need to preserve the poisoned status of these pages.
> >
> > When live migrating, we try to get the guest running on its new host as
> > quickly as possible. So, we start it running before all memory has been
> > copied, and before we're certain which pages should be poisoned or not.
> >
> > So the basic way to use this new feature is:
> >
> > - On the new host, the guest's memory is registered with userfaultfd, i=
n
> >   either MISSING or MINOR mode (doesn't really matter for this purpose)=
.
> > - On any first access, we get a userfaultfd event. At this point we can
> >   communicate with the old host to find out if the page was poisoned.
>
> Just curious, what is this communication channel with the old host?

James can probably describe it in more detail / more correctly than I
can. My (possibly wrong :) ) understanding is:

On the source machine we maintain a bitmap indicating which pages are
clean or dirty (meaning, modified after the initial "precopy" of
memory to the target machine) or poisoned. Eventually the entire
bitmap is sent to the target machine, but this takes some time (maybe
seconds on large machines). After this point though we have all the
information we need, we no longer need to communicate with the source
to find out the status of pages (although there may still be some
memory contents to finish copying over).

In the meantime, I think the target machine can also ask the source
machine about the status of individual pages (for quick on-demand
paging).

As for the underlying mechanism, it's an internal protocol but the
publicly-available thing it's most similar to is probably gRPC [1]. At
a really basic level, we send binary serialized protocol buffers [2]
over the network in a request / response fashion.

[1] https://grpc.io/
[2] https://protobuf.dev/

> --
> Mike Kravetz
>
> > - If so, we can respond with a UFFDIO_SIGBUS - this places a swap marke=
r
> >   so any future accesses will SIGBUS. Because the pte is now "present",
> >   future accesses won't generate more userfaultfd events, they'll just
> >   SIGBUS directly.
> >
> > UFFDIO_SIGBUS does not handle unmapping previously-present PTEs. This
> > isn't needed, because during live migration we want to intercept
> > all accesses with userfaultfd (not just writes, so WP mode isn't useful
> > for this). So whether minor or missing mode is being used (or both), th=
e
> > PTE won't be present in any case, so handling that case isn't needed.
> >
