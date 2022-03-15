Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355F94DA448
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Mar 2022 21:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238045AbiCOU5o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 16:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349289AbiCOU5l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 16:57:41 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C4A51E61
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Mar 2022 13:56:24 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1647377781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7S6xJjXpiKD48Qg792whW6q88GbM/EWnQhXrL+EDIYs=;
        b=FAjTG51nvVk1Qk0v3vdIRkXiAVe9ulHnKMjXVIBKDkXb8Sqba/X7azy4SYjopZlG0Yexmg
        OJ+grNKHgGDRWlwGS9k8N9YZo9hCNNxKZ8yBCXbRFxcrR3MyJ4tywr+hBcHElVw/kkLwCt
        jx9CXcwpOciUzyJOO1wLzsDXaDLgyak=
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [LSF/MM TOPIC] Better handling of negative dentries
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
In-Reply-To: <YjDvRPuxPN0GsxLB@casper.infradead.org>
Date:   Tue, 15 Mar 2022 13:56:18 -0700
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org,
        Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>,
        khlebnikov@yandex-team.ru
Message-Id: <A35C545C-1926-4AA9-BFC7-0CF11669EA9E@linux.dev>
References: <YjDvRPuxPN0GsxLB@casper.infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> On Mar 15, 2022, at 12:56 PM, Matthew Wilcox <willy@infradead.org> wrote:
>=20
> =EF=BB=BFThe number of negative dentries is effectively constrained only b=
y memory
> size.  Systems which do not experience significant memory pressure for
> an extended period can build up millions of negative dentries which
> clog the dcache.  That can have different symptoms, such as inotify
> taking a long time [1], high memory usage [2] and even just poor lookup
> performance [3].  We've also seen problems with cgroups being pinned
> by negative dentries, though I think we now reparent those dentries to
> their parent cgroup instead.

Yes, it should be fixed already.

>=20
> We don't have a really good solution yet, and maybe some focused
> brainstorming on the problem would lead to something that actually works.

I=E2=80=99d be happy to join this discussion. And in my opinion it=E2=80=99s=
 going beyond negative dentries: there are other types of objects which tend=
 to grow beyond any reasonable limits if there is no memory pressure.
A perfect example when it happens is when a machine is almost idle for some p=
eriod of time. Periodically running processes creating various kernel object=
s (mostly vfs cache) which over time are filling significant portions of the=
 total memory. And when the need for memory arises, we realize that the memo=
ry is heavily fragmented and it=E2=80=99s costly to reclaim it back.

Thanks!=
