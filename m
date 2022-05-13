Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE77B525F3C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 May 2022 12:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379220AbiEMJwE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 May 2022 05:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357204AbiEMJwD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 May 2022 05:52:03 -0400
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3825E5838F;
        Fri, 13 May 2022 02:51:58 -0700 (PDT)
Received: from spock.localnet (unknown [83.148.33.151])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 3FFFDEDD9FA;
        Fri, 13 May 2022 11:51:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1652435515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dkS9jvsDAiR8QpYW2hSmRXL0ArdVBFFpuCQ+UOIi0zo=;
        b=JNG1vX/JZGDat+hBg4RxgIOTkjMrrdHKEGECZLNdlYv93vX/MpIK3+mMLWPspBhy6Un/l0
        DDUuOUceOlCdvUPYDbD9pF8OXMN9HudeeGnLGvY+k0nJIcRSbRD5YPRC0fUV+kEp6/CpA3
        sp5NEs+lJTJh9CysOsWP3IrNXHcBGMg=
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
Date:   Fri, 13 May 2022 11:51:53 +0200
Message-ID: <1835064.A2aMcgg3dW@natalenko.name>
In-Reply-To: <20220512153753.6f999fa8f5519753d43b8fd5@linux-foundation.org>
References: <20220510122242.1380536-1-xu.xin16@zte.com.cn> <5820954.lOV4Wx5bFT@natalenko.name> <20220512153753.6f999fa8f5519753d43b8fd5@linux-foundation.org>
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

On p=C3=A1tek 13. kv=C4=9Btna 2022 0:37:53 CEST Andrew Morton wrote:
> On Tue, 10 May 2022 15:30:36 +0200 Oleksandr Natalenko <oleksandr@natalen=
ko.name> wrote:
>=20
> > > If ksm_force is set to 1, force all anonymous and 'qualified' VMAs
> > > of this mm to be involved in KSM scanning without explicitly calling
> > > madvise to mark VMA as MADV_MERGEABLE. But It is effective only when
> > > the klob of /sys/kernel/mm/ksm/run is set as 1.
> > >=20
> > > If ksm_force is set to 0, cancel the feature of ksm_force of this
> > > process (fallback to the default state) and unmerge those merged pages
> > > belonging to VMAs which is not madvised as MADV_MERGEABLE of this pro=
cess,
> > > but still leave MADV_MERGEABLE areas merged.
> >=20
> > To my best knowledge, last time a forcible KSM was discussed (see threa=
ds [1], [2], [3] and probably others) it was concluded that a) procfs was a=
 horrible interface for things like this one; and b) process_madvise() sysc=
all was among the best suggested places to implement this (which would requ=
ire a more tricky handling from userspace, but still).
> >=20
> > So, what changed since that discussion?
> >=20
> > P.S. For now I do it via dedicated syscall, but I'm not trying to upstr=
eam this approach.
>=20
> Why are you patching the kernel with a new syscall rather than using
> process_madvise()?

Because I'm not sure how to use `process_madvise()` to achieve $subj proper=
ly.

The objective is to mark all the eligible VMAs of the target task for KSM t=
o consider them for merging.

=46or that, all the eligible VMAs have to be traversed.

Given `process_madvise()` has got an iovec API, this means the process that=
 will call `process_madvise()` has to know the list of VMAs of the target p=
rocess. In order to traverse them in a race-free manner the target task has=
 to be SIGSTOP'ped or frozen, then the list of VMAs has to be obtained, the=
n `process_madvise()` has to be called, and the the target task can continu=
e. This is:

a) superfluous (the kernel already knows the list of VMAs of the target tas=
ks, why proxy it through the userspace then?); and
b) may induce more latency than needed because the target task has to be st=
opped to avoid races.

OTOH, IIUC, even if `MADV_MERGEABLE` is allowed for `process_madvise()`, I =
cannot just call it like this:

```
iovec.iov_base =3D 0;
iovec.iov_len =3D ~0ULL;
process_madvise(pidfd, &iovec, 1, MADV_MERGEABLE, 0);
```

to cover the whole address space because iovec expects total size to be und=
er ssize_t.

Or maybe there's no need to cover the whole address space, only the lower h=
alf of it?

Or maybe there's another way of doing things, and I just look stupid and do=
 not understand how this is supposed to work?..

I'm more than happy to read your comments on this.

Thanks.

=2D-=20
Oleksandr Natalenko (post-factum)


