Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9F64634D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 13:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbhK3MzP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 07:55:15 -0500
Received: from mout.gmx.net ([212.227.15.15]:43635 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232871AbhK3My6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 07:54:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638276675;
        bh=c9z8o/iWr3NTfj+uUiO32jPRashfLcZ877UxpLrEltA=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=YU7up95ZwBXzYuR8k8mB8ZU5cS4Mhh7bYzhx4ccIkEknE6hS2PnasdsOgZKG5aVkY
         5Z+k0dEqvOlYcHWwyjJ3X7Kjz+nErO7i9nUmZdm/cn2wgDCvhCdgTtF63IJA0ab/hl
         20QkWptII5d3lWkfL9JjpKcv06/hWHoy33Dt/cR8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.146.50.175]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2wL0-1mt8071500-003OtP; Tue, 30
 Nov 2021 13:51:15 +0100
Message-ID: <b966ccc578ac60d3684cff0c88c1b9046b408ea3.camel@gmx.de>
Subject: Re: [PATCH 1/1] mm: vmscan: Reduce throttling due to a failure to
 make progress
From:   Mike Galbraith <efault@gmx.de>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Alexey Avramov <hakavlad@inbox.lv>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Darrick Wong <djwong@kernel.org>, regressions@lists.linux.dev,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 30 Nov 2021 13:51:10 +0100
In-Reply-To: <b8f607c771a4f698fcb651379ca30d3bb6a83ccd.camel@gmx.de>
References: <20211125151853.8540-1-mgorman@techsingularity.net>
         <20211127011246.7a8ac7b8@mail.inbox.lv>
         <20211129150117.GO3366@techsingularity.net>
         <a20f17c4b1b5fdfade3f48375d148e97bd162dd6.camel@gmx.de>
         <20211130112244.GQ3366@techsingularity.net>
         <b8f607c771a4f698fcb651379ca30d3bb6a83ccd.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HGsRl3HDz3scVmthJ3IF67/Ifz7L1wEt0wBJNxdAE66j4O51TJj
 CV/qBcer3kOWf/oLFhFopDmDwk2da2kkHHsOak13Tzxd37MpvBsG1+TjjMS396/Ba0FeQpk
 rdYboQvmOBzs585YMviW9F6z/jM3bbBWeaauok14z9VLWIN/9mqbO5Fomj1n+m0xwHnqVMq
 48nMw0GY7KRlgi/11aAfA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5qzsiGktCB4=:0UIvHvh15dzuz76ASShWyz
 U+XO5AyMH4hJnuX5sjDsRAHlVit+8S1etVLADZ8Dw2sZPERBNDtZoH/a4HX9IttVDgRM4SheD
 sYerLEROsnHKFlRB9gPc4IhetRk1Ep9ujrTGAlysqwLVtfwXFxCxMAO3N2Ze8TrRKTV+0r3Fp
 a18OtQ1Vpm+21qZpfS/U0Gsco1sPDQeNPFposDeQeEsbs+5m5f4rJBaOY3p+uH2NI8bWEQV42
 aVTYF9o6aIhw7mVzuMbuV9wFM2YSCeXReZnybFy0vZxhMwS1SJ4Wa12L9TAT0xTu7On+/s3IX
 VXHI8vof63+k5vHTRltKTOUHWeMZ5wT5HLbXDw4tIQhcxMMJ50StMFHXeTFdbVUIDgIzoh0xd
 /z/nQhDKKFkMDZUP5ti7wt1dy2PT+sUKDW9pbO/Ovuj02HAnI6/EE+yGtRE03gCk65yACwNsa
 fx6iuMlL5/wbw9hylcR1xfCsi4yh/D5HPFH73WdIyOePVcyyWgBQD93bV75ksipEHWxqmn+2t
 y452xX1xY4ag41vLvpvbK/qNg5BeHpVs4jFXmrFRQzrk6OvHTo7eIxliKlg+FMtpmFDh7xOPk
 XJRTthZ6rH/uZXgPSxhGlcsAowt6ZyuYoODJt2Zm5I1npCe+NoqS8XeTVFrFTiC7NnQ5dt5zR
 emOadZQksoIVxG2ZZOuNdWBrWO+MhWJtzYQstQxnW+W9bDdPuo/E3W7/uLMGyVrojBC45N6rw
 0fPTjMSej6VFGdmSxFB4OU2hXNvVzGCHlwrtIveJXf3nIP0i4s3IbZJlN56uPPEGE2hgT9stW
 VFSz6TxOk8WCmKtPBYNpt1Gv+xNKKO1cGOGglHdGB6WFnb9vJkMwMBZdqdQQOo/QA2UghYM/9
 HB9/8PlHZGqXw2faArBxPEy2/DFhw/M3tbKmzGJsKAQ0uL+wtBQGGHFhXQ2RcCuw5a049qzx4
 2rOv2DpYYR/O2UEr8gjX1WnYqDP2T2GZ4bPS3XaQ+3Fo1Fj4dz+LqSEjyOPwjVSVXjtxyEXze
 r+6Kr+jeQ0npAYROVZ0/lWbb/81arMpZnxk8UiJJl8q3XukPatpPwVLaeIi14Psdt9UIsOMcs
 shUtYLeNCJLJy8=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2021-11-30 at 13:00 +0100, Mike Galbraith wrote:
> On Tue, 2021-11-30 at 11:22 +0000, Mel Gorman wrote:
> > On Tue, Nov 30, 2021 at 11:14:32AM +0100, Mike Galbraith wrote:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (2 * write_pending <=
=3D reclaimable)
> > >
> > > That is always true here...
> > >
> >
> > Always true for you or always true in general?
>
> "Here" as in the boxen located at my GPS coordinates :)
>
> > The intent of the check is "are a majority of reclaimable pages
> > marked WRITE_PENDING?". It's similar to the check that existed prior
> > to 132b0d21d21f ("mm/page_alloc: remove the throttling logic from the
> > page allocator").
>
> I'll put my trace_printk() back and see if I can't bend-adjust it.

As it sits, write_pending is always 0 with tail /dev/zero.

	-Mike
