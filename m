Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFBF4661BE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Dec 2021 11:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356943AbhLBKzl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Dec 2021 05:55:41 -0500
Received: from mout.gmx.net ([212.227.15.18]:58569 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231208AbhLBKzi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Dec 2021 05:55:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638442314;
        bh=ofsSqiOrT4mnNucwypB20efCyEpHBisJHJKtufIYncA=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=Fq5ibyRIv5OPI3M+KPb/iGlmsIp7IbhMVmHYlwODhMxGUtcDzV/BJvvAljct7T8mF
         lYnBPR6YCP231zaZs01Ecs9Mqrw++9hGbTrUgMkrdtk/foMA4QjeibkLQCvOqcHvLe
         SL6xrwVQkPrWOJKQXtvXbZn1nibmEBAipBIyUhn0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from bart.fritz.box ([185.221.149.39]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEm2D-1mmxD03AwV-00GL9F; Thu, 02
 Dec 2021 11:51:53 +0100
Message-ID: <fa80d97f2f73e405db52744edc7979f2dc30526e.camel@gmx.de>
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
Date:   Thu, 02 Dec 2021 11:51:46 +0100
In-Reply-To: <20211202101324.GX3366@techsingularity.net>
References: <20211125151853.8540-1-mgorman@techsingularity.net>
         <20211127011246.7a8ac7b8@mail.inbox.lv>
         <20211129150117.GO3366@techsingularity.net>
         <20211201010348.31e99637@mail.inbox.lv>
         <20211130172754.GS3366@techsingularity.net>
         <20211201033836.4382a474@mail.inbox.lv>
         <20211201140005.GU3366@techsingularity.net>
         <74248b525d5ee03bfd00aaa66cd08a4582998cd6.camel@gmx.de>
         <20211202101324.GX3366@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rBScxEg19LUK2oQ5oTdCk8gedC+1+6vyrKBGYRZHSJanhgfLAOI
 gAt3/BJMq3aRN6oQi3JO4NJblqO+AL3h+45/6Luh0zM02f6Xo1lnd5iPs1iEj37BbidHqAN
 PdD9lD8bctyqKGrQ2BEpTTk/H3gxW7oci4r+fLoKRbFsST5dhrj7o/DbENH8Iu4oieCq0WV
 /NGE+XqhjzyWDsi2z5jFQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:v8M7ACplhN8=:jB8z0rgnKJgclNlDpVncKF
 pEdT5P9DDQATVGi6kMVJ6NR4MKiIqn+ABt/M1bXNIenB99KNROi8GVuI9zGCzFOiqnRqvuAyY
 Hu6rUmiFCYgCxnF9XH27ymjaTyufxFyISyUznvRK40hAQkMd4PirPwg2PbWpOzNCNckQwhDbI
 FIjQIHP8hJ5E8jjHWIrVdmARkR25oAyVOwY/ulizCSFelR3yLAjZyS/OA9WYnXXQDJZSqr5E8
 SYOwMoxS2nJ3gn71oDGl4gDWZRNjxPH6Zrj7wzHymk/ZjWPIMKKvKOyg69LLVFEKSrGBF97EV
 aBXteA32rSGCSXRRTuDweo3y+8KqTL5h4oPHLtf+P2nnAqyyTg8ED+mUI367fj0wg80H2kZ5o
 mzIZiLwy0GhJoOubSWymulZEdyFxmU0hTGDjQrEem1lpXulOZK6YDpZEI81X+fCsTNVYsyDot
 n0GCKJMea4Glp7o2nCjCLFhQIm3Fn2O7wNxKw+80aUvKYE0HYm7GsVVIiMJ6StuxVBzdQsDkV
 avVSWSXJnqZPw46c3y1N1mJVOQm0boXKbmso5ythQ6npTj32k0cWfZMABdSof3lLXTfRPdcH7
 A04MpEwZ7DJ0YGyTxvpH9XKqHgheuR3wYEnyH4A7y+o9D2ZzJu4OsaoN5wiTwtumDge6jjpgL
 f8JTnvmN9b4xjy4YAf62wnVbc+m/M64TBHaNk2In/YMj3ctfRk6Gh1k3IIc1qDYmv6AMAN/6J
 b7pIOjywN5Tlgkp6BYpp4L4iu5khQbJqZIbw5Yb+O2loImtDgWxBTpGTAZ/vJTlYgHuzy+OCR
 aYpd9zzTpVh1p/wOCi+R6r2zs5b2uB9bwgLhd+R1E/I/UkejR8bZ/bOLWAo12AQUoOR2oBLkX
 h6S7LEevWRirOnhbK68n55DE0ahoV4A0Fdcjle2Q2+DQXEsL9Cjd5tGEyrIb8ToPcugGuZgWN
 Vv2/pTbrwKcEEElUe4ylZ/sT44eylSrcOanJPSHMhb+vw5QEKkb0rqqgjnV6dnebaeVMI3hFd
 MKE9CxBunh6zo/q/v7SLnpiDVTlGIFzB1KlX0+fY8pyd0z8mPuxNK5EkkdBtxNQSQLG+rMOBt
 OO02sewe7Nb0Ic=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2021-12-02 at 10:13 +0000, Mel Gorman wrote:
> On Thu, Dec 02, 2021 at 04:11:38AM +0100, Mike Galbraith wrote:
> > On Wed, 2021-12-01 at 14:00 +0000, Mel Gorman wrote:
> > >
> > > I've included another patch below against 5.16-rc1 but it'll
> > > apply to
> > > 5.16-rc3. Using the same test I get
> >
> > LTP testcases that stalled my box no longer do, nor can I manually
> > trigger any unexpected behavior.
> >
>
> Excellent, can I add the following?

Sure.

> Tested-by: Mike Galbraith <efault@gmx.de>
>

