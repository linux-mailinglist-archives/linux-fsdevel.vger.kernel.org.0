Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5ED526BEF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 May 2022 22:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384566AbiEMUx2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 May 2022 16:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384551AbiEMUx0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 May 2022 16:53:26 -0400
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2186140FF;
        Fri, 13 May 2022 13:53:23 -0700 (PDT)
Received: from spock.localnet (unknown [83.148.33.151])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 794FDEDEB30;
        Fri, 13 May 2022 22:53:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1652475198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=or0NKeUsbE01vgrU5fNAJITH1vwKDIErppkCvQpSrPA=;
        b=LbulMFpXvocMvhpK93KvRsv+Q2NABXhQtu/RLQ284R+Mg5gUH5urrWVmpOXOV18v+LsEhG
        HX60DMFprIuin+muTeoCrCXkip2NpUA7jWQUjTUURTCD8dx4doEh/ef4nQRh0+YNYBqoQZ
        7NYEnNneDB9MURIT/lbaQOCvBMbFzPk=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     cgel.zte@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, corbet@lwn.net,
        xu xin <xu.xin16@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        wangyong <wang.yong12@zte.com.cn>,
        Yunkai Zhang <zhang.yunkai@zte.com.cn>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v6] mm/ksm: introduce ksm_force for each process
Date:   Fri, 13 May 2022 22:53:16 +0200
Message-ID: <1817008.tdWV9SEqCh@natalenko.name>
In-Reply-To: <20220513133210.9dd0a4216bd8baaa1047562c@linux-foundation.org>
References: <20220510122242.1380536-1-xu.xin16@zte.com.cn> <1835064.A2aMcgg3dW@natalenko.name> <20220513133210.9dd0a4216bd8baaa1047562c@linux-foundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello.

On p=C3=A1tek 13. kv=C4=9Btna 2022 22:32:10 CEST Andrew Morton wrote:
> On Fri, 13 May 2022 11:51:53 +0200 Oleksandr Natalenko <oleksandr@natalen=
ko.name> wrote:
> > On p=C3=A1tek 13. kv=C4=9Btna 2022 0:37:53 CEST Andrew Morton wrote:
> > > On Tue, 10 May 2022 15:30:36 +0200 Oleksandr Natalenko <oleksandr@nat=
alenko.name> wrote:
> > >=20
> > > > > If ksm_force is set to 1, force all anonymous and 'qualified' VMAs
> > > > > of this mm to be involved in KSM scanning without explicitly call=
ing
> > > > > madvise to mark VMA as MADV_MERGEABLE. But It is effective only w=
hen
> > > > > the klob of /sys/kernel/mm/ksm/run is set as 1.
> > > > >=20
> > > > > If ksm_force is set to 0, cancel the feature of ksm_force of this
> > > > > process (fallback to the default state) and unmerge those merged =
pages
> > > > > belonging to VMAs which is not madvised as MADV_MERGEABLE of this=
 process,
> > > > > but still leave MADV_MERGEABLE areas merged.
> > > >=20
> > > > To my best knowledge, last time a forcible KSM was discussed (see t=
hreads [1], [2], [3] and probably others) it was concluded that a) procfs w=
as a horrible interface for things like this one; and b) process_madvise() =
syscall was among the best suggested places to implement this (which would =
require a more tricky handling from userspace, but still).
> > > >=20
> > > > So, what changed since that discussion?
> > > >=20
> > > > P.S. For now I do it via dedicated syscall, but I'm not trying to u=
pstream this approach.
> > >=20
> > > Why are you patching the kernel with a new syscall rather than using
> > > process_madvise()?
> >=20
> > Because I'm not sure how to use `process_madvise()` to achieve $subj pr=
operly.
> >=20
> > The objective is to mark all the eligible VMAs of the target task for K=
SM to consider them for merging.
> >=20
> > For that, all the eligible VMAs have to be traversed.
> >=20
> > Given `process_madvise()` has got an iovec API, this means the process =
that will call `process_madvise()` has to know the list of VMAs of the targ=
et process. In order to traverse them in a race-free manner the target task=
 has to be SIGSTOP'ped or frozen, then the list of VMAs has to be obtained,=
 then `process_madvise()` has to be called, and the the target task can con=
tinue. This is:
> >=20
> > a) superfluous (the kernel already knows the list of VMAs of the target=
 tasks, why proxy it through the userspace then?); and
> > b) may induce more latency than needed because the target task has to b=
e stopped to avoid races.
>=20
> OK.  And what happens to new vmas that the target process creates after
> the process_madvise()?

Call `process_madvise()` on them again. And do that again. Regularly, with =
some intervals. Use some daemon for that (like [1]).

[1] https://gitlab.com/post-factum/uksmd

> > OTOH, IIUC, even if `MADV_MERGEABLE` is allowed for `process_madvise()`,
>=20
> Is it not?

It is not:

```
1158 static bool
1159 process_madvise_behavior_valid(int behavior)
1160 {
1161     switch (behavior) {
1162     case MADV_COLD:
1163     case MADV_PAGEOUT:
1164     case MADV_WILLNEED:
1165         return true;
1166     default:
1167         return false;
1168     }
1169 }
```

Initially, when `process_madvise()` stuff was being prepared for merging, I=
 tried to enabled it but failed [2], and it was decided [3] to move forward=
 without it.

[2] https://lore.kernel.org/linux-api/34f812b8-df54-eaad-5cf0-335f07da55c6@=
suse.cz/
[3] https://lore.kernel.org/lkml/20200623085944.cvob63vrv54fo7cs@butterfly.=
localdomain/

> > I cannot just call it like this:
> >=20
> > ```
> > iovec.iov_base =3D 0;
> > iovec.iov_len =3D ~0ULL;
> > process_madvise(pidfd, &iovec, 1, MADV_MERGEABLE, 0);
> > ```
> >=20
> > to cover the whole address space because iovec expects total size to be=
 under ssize_t.
> >=20
> > Or maybe there's no need to cover the whole address space, only the low=
er half of it?
>=20
> Call process_madvise() twice, once for each half?

And still get `-ENOMEM`?

```
1191     /*
1192      * If the interval [start,end) covers some unmapped address
1193      * ranges, just ignore them, but return -ENOMEM at the end.
1194      * - different from the way of handling in mlock etc.
1195      */
```

I mean, it probably will work, and probably having the error returned is fi=
ne, but generally speaking an error value should hint that something is not=
 being done right.

> > Or maybe there's another way of doing things, and I just look stupid an=
d do not understand how this is supposed to work?..
> >=20
> > I'm more than happy to read your comments on this.
> >=20
>=20
> I see the problem.  I do like the simplicity of the ksm_force concept.=20
> Are there alternative ideas?

I do like it too. I wonder what to do with older concerns [4] [5] regarding=
 presenting such an API.

[4] https://lore.kernel.org/lkml/20190516172452.GA2106@avx2/
[5] https://lore.kernel.org/lkml/20190515145151.GG16651@dhcp22.suse.cz/

=2D-=20
Oleksandr Natalenko (post-factum)


