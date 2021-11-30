Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE4C04633BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 13:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbhK3MEA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 07:04:00 -0500
Received: from mout.gmx.net ([212.227.17.20]:48289 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229538AbhK3MD7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 07:03:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638273622;
        bh=86mLRP7RxLciX6WFesgCpFI0qfy9gXogt8D2ha7z4+A=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=AXivPj5XQ42x2j05j7S7RsluKY6J0DKySHx2IYzGEZWs3E1q5T7RSqLrp3G9GLwNk
         0akdRYeC/XPTuKnQAVQCaV/ngA4FM097mYbxzBdeisObq2J6LHWVqy4sejvkBbFZOV
         dPwdwR6mGr4aLnBritwZEcB/Z5qCoxnO/Q/75U80=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.146.50.175]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1OXT-1mTnrh0aQF-012nJz; Tue, 30
 Nov 2021 13:00:22 +0100
Message-ID: <b8f607c771a4f698fcb651379ca30d3bb6a83ccd.camel@gmx.de>
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
Date:   Tue, 30 Nov 2021 13:00:18 +0100
In-Reply-To: <20211130112244.GQ3366@techsingularity.net>
References: <20211125151853.8540-1-mgorman@techsingularity.net>
         <20211127011246.7a8ac7b8@mail.inbox.lv>
         <20211129150117.GO3366@techsingularity.net>
         <a20f17c4b1b5fdfade3f48375d148e97bd162dd6.camel@gmx.de>
         <20211130112244.GQ3366@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q8Rcm+TDsMGclzpLvPpIUOG460Khlbhybxb+OmjHoQ7eWlSZjwe
 iInZPJV5ei36SlSySfzp57ZCs3OM51mS7uS/FRFL1ovBCSwF4GcSRjYfvB7Q+GCdpxR2D4m
 hnr5S95PsvQKQWjyQuTejCqngOfcVJ6Xck3dqr7ySjF+TRZAV6ZlB8yiDsxB0PN9R/O3Lrw
 dYGqpUqgAVY6735G5zwQw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4FgWfCmXmJQ=:QpOMsYUbzenGVGbOqzhwNZ
 6zL4AIN0w6dOK7sxB0IFmJyv9C0MlwGzHcOgoyoBEcsYUXF1QLYv+6l6+HtcVhdTaDlHQi8rG
 FmAVvq4RLvC4cD2ndlS4Or4dvJI+7w1edc5vRgEGoZajS76Kka0UfMBuJEP64QfaIctGFLi1e
 ivjCCcE7w7K5m9l6gtdnfp+6TNkuQCrlJRATdOEscgSTB6qdEep+USC/PgMaEIppktbXifWRP
 Yse6KCWFtOCdsBG+p/ICWTqwbWFu2o0ELpkv0X1qCAevwEQ0WEGchfqfQvKSeM8J7nO9VZzgz
 YOJAO17bwfXFhN3PneNTivUuksJQRTJNPtKrKYdgjN4yiv4VPsY8yGZu+G1Q9keXC8HF2EpD/
 di7q4Jj4gi8FA/kBto8U7SM5seeyqVLLPvgrwOPuHQ0mimAM36V2WUYfvxKN8y8DrWi7oubpw
 KAms+0Ts7QjiyQ1hOs+wrSGPdXL5tlrNdtnyiRZtoYGF5eWG+FoKoYOVbJUrXJe6xKmtqk6fH
 MhCJKhUN1Ti/fy9bBwfSpSFc8mIRLjbjOOXb5dJGX4IPpYnPa9MmjKkYbAJKn95g91tXM4l85
 eOa35a6GtNrAWslosEccnoorhlhXkei+fs1w0BgOnChc4mmHWA0SVKvjMnudHP2E5rCM5qn8N
 s3NZBH8LtLVm6w72tZGtmXxuGEAj8Qa/AqwX809uMeJ8rpdz9JrZHkCsjDAB5OHrs7BLwkHnY
 mE61LUKvf8zdxWvFUssoTY87crGGn1Tb25LrL6YAsDWWy61rhRq6B6EQaQDHm8KHCwcQoon1K
 FodR4TDCsBKGhyZRadedT+SmZ7eojQnOAt62dcOUNWbhK4E35TaeReq5RpSTHfZMFUNLUNQBv
 bAZ7a1yJ95X1OfdF0Rt0EeOefVGLJ5ayfr866ugH1cOzb3bp7UoU980+hrLd+pAt5oj8Z3fOh
 WOEJc2k/qu8aRWSCoDkJfa3yPvqOaotVPfttvBEyIK2Rr1UCy+m4AATm0Yh6XyTuoiYlSDpix
 di9Qm9fHeZcJ/5il7uoFcI6soPBbPS7QYZSC0LXwmszfOB+5k1BE//erw+AU9ZQvn2eJpJ+l/
 qUl/XvzRC87XzU=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2021-11-30 at 11:22 +0000, Mel Gorman wrote:
> On Tue, Nov 30, 2021 at 11:14:32AM +0100, Mike Galbraith wrote:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (2 * write_pending <=
=3D reclaimable)
> >
> > That is always true here...
> >
>
> Always true for you or always true in general?

"Here" as in the boxen located at my GPS coordinates :)

> The intent of the check is "are a majority of reclaimable pages
> marked WRITE_PENDING?". It's similar to the check that existed prior
> to 132b0d21d21f ("mm/page_alloc: remove the throttling logic from the
> page allocator").

I'll put my trace_printk() back and see if I can't bend-adjust it.

	-Mike

