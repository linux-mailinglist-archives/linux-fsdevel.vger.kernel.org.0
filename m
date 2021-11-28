Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4784F46061C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Nov 2021 13:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244112AbhK1Mkt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Nov 2021 07:40:49 -0500
Received: from mout.gmx.net ([212.227.17.20]:51029 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244320AbhK1Mit (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Nov 2021 07:38:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638102910;
        bh=qS3i/rmMbmZIqxEQOq+Uhf3eD8d6x4qLjMlJQdVTjok=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=jobuBjlyDUTeWTSOQTms5tBnVlDNssV/y86VNdJqAyF9hrOUo7Bb47e6LbHG6SwSW
         UFc7ypX2V/VXVUwJDOkUR+gBD+U0T1QyHE9cM/kX2pzmMtdK5K037yI8IbonZVo10W
         /0hgTDHn4EBreYDoV7hA0nawXOpHqQjVaTUJ3g9k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.150.210]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYeMt-1n3YuT2bzf-00VgKd; Sun, 28
 Nov 2021 13:35:10 +0100
Message-ID: <dd39029d93bb4de5ed485b5d4181fc19d4c0c4f0.camel@gmx.de>
Subject: Re: [PATCH 1/1] mm: vmscan: Reduce throttling due to a failure to
 make progress
From:   Mike Galbraith <efault@gmx.de>
To:     Alexey Avramov <hakavlad@inbox.lv>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Darrick Wong <djwong@kernel.org>, regressions@lists.linux.dev,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Sun, 28 Nov 2021 13:35:06 +0100
In-Reply-To: <941f378e1ea2b32cac0adee1e81637ab6d001f1e.camel@gmx.de>
References: <20211125151853.8540-1-mgorman@techsingularity.net>
         <20211127011246.7a8ac7b8@mail.inbox.lv>
         <20211126165211.GL3366@techsingularity.net>
         <20211128042635.543a2d04@mail.inbox.lv>
         <252cd5acd9bf6588ec87ce02884925c737b6a8b7.camel@gmx.de>
         <941f378e1ea2b32cac0adee1e81637ab6d001f1e.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ftyD1dPtgkdxN1oeTVaM72JrpXXYonEd9lMbhlz0n+y0/x/h2da
 FKTIoC63vPtKSGTaPHrLsEsjJ74XtUe1bM4xmFarlvq2//VuQ5bKT1gk8xzveuGQVUo5jCx
 xX9AHqN9p01JH2TOqlkjVDVHasnPYJvfYUjuWBdS1CBcCxJ1zvld1FpaVzGjyEv3uHWxF5n
 4fjoWvGbddPdmSgCNXWCA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:NX2Dj5WoFAs=:fMBZqLc0mvQFd6vvJEvazb
 4eat/6myHtPsrifWT5pkGTnJoeWKkYxrDCUeOhmh5SBGNJoQFqrmokrHiybEOgOER0XQ/gL92
 WBLfP+5bvp/0N8RgZNoJjfD0Yvy7ExHbZ8SRKcRn/YUuxq0VJtuXTT4NiVL3mw7M3tfMloZuJ
 LZNBdYTz3M3wRtl+/lPVD2Aql1a0GXf9er81DYUbJm56Gp8HYdplfsTU42s6kMrJ1BoKCsAS2
 ZcPjyyQ2p9ttteTl48Yd7To3A+PSHKoTiTZcvMLxQzUMlFJz2bLkDYrA8kuFSW6QCEfzfGhw+
 N6hBoKCaW2lwZYE59Sq5ZTUE4mSV6l6PLTFaB7lCilaS37104me4CcNDtkfJhZa2VUhD3sBcV
 bMtXSCXgNZ1OTS1K9gqx3qsw9E2+5dUCA+CQDELgzJw7TfStVh248ahboZjNQMG6SoNEMm+p5
 b2OqVTKSSW4vi103pfCn6vLQ/hmIVuy4DpcdtJuPmmvBCEUfSrY8bQdTY8dfrL89DbBzfhXkq
 6itzzDml5dm7hprMmdDMt5kJyDaanOcA894hSLeZHY5NXXDr6Mb5UsEGyvAUUnVKIdaRNiUBx
 zGHGy1QsYJHnv28NjGFhWs/Aik3T8YpoRlDMbd0WKv0tU0sx0cNQUCC5sAIG1ccJNFTcuK/JZ
 FaGSHceOKf0UFospyQrm1NKp7pefyRRWryP/XSykCnJhA1tn4EE6/02I7lzBSJrXcgW6gBcsJ
 SvNhd5ZnUSoVA0OubR1AuaRWr9xrfBsMktxDo1Vp1un4IRpAcZDhkCsaQ3yXh6Uogu4Kipv9H
 64rtALk6PgiJM3uImpPr6pWpb6G/xuGNn5A9n/uy+OrHqDQeL8usfLyGyURpaaPd/AXO2Uunf
 LxBPnOHxKtCXqebItUrVllDi9c95DbuyDpSEBQdKKTDURucZB9QkVVhAw+UTL5j90bf1zqr5z
 KWYQ6dmOlG+KXIshDL2Y9nNniqgaRTM85DS7pZh4jHGyQt5G8HUGUy/yd5fuoJY1KzO74C0Ws
 Gmc45sPwGrka5G9TYzDzCNmUtdN46t8ENCDvK4uTvzTseKt7DdFFS8pitKMEhCfEpANSG4kce
 KZ1A58I965pCI0=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 2021-11-28 at 12:39 +0100, Mike Galbraith wrote:
> On Sun, 2021-11-28 at 11:00 +0100, Mike Galbraith wrote:
> > On Sun, 2021-11-28 at 04:26 +0900, Alexey Avramov wrote:
> > > I will present the results of the new tests here.
> > >
> > > TLDR;
> > > =3D=3D=3D=3D=3D
> > > No one Mel's patch doesn't prevent stalls in my tests.
> >
> > Seems there may be a problem with the THROTTLE_WRITEBACK bits..
>
> Disregard.=C2=A0 I backed hacklet out again, and one-liner that had grou=
nd
> my box to fine powder was harmless.=C2=A0 Hmm.

Grr, no, disregard the disregard, it's just annoyingly variable, may
perform akin to 5.15 but most likely won't.  With bandaid, it _seems_
to be consistently on par with 5.15.

Bandaid likely just break the writeback bits all to pieces, but that's
ok, if breakage makes things work better, they need more breaking :)

	-Mike
