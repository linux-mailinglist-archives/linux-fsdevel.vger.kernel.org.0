Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4893D464F2F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Dec 2021 14:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243968AbhLAN51 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Dec 2021 08:57:27 -0500
Received: from mout.gmx.net ([212.227.15.18]:34855 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350023AbhLANzw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Dec 2021 08:55:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638366725;
        bh=qf6P0QAuZPvx6yTk8+Ud1iC0O0jfGhuYokc3UBE3HQc=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=ArV3pd1H44NRk4g8Pb1zabfUWPaZOCuzDmwzMa/O14Z2kxQ95R0NS3T4cGmVnq6nU
         SUaDtfZrXfXqLi281EjaJi3ctYJkOJyLzHm16U97rLcLC/BHiy4a+zHw/dtcY6cAfH
         W/09G0MJBZiKHlbhTi1ejE47UDdAUOlS6KLRkI9g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.151.67]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mulm5-1ma3zq1ZoZ-00rmZh; Wed, 01
 Dec 2021 14:52:05 +0100
Message-ID: <2899c7841c8afc23b329230bd940692ffd586f63.camel@gmx.de>
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
Date:   Wed, 01 Dec 2021 14:52:01 +0100
In-Reply-To: <20211201130155.GT3366@techsingularity.net>
References: <20211125151853.8540-1-mgorman@techsingularity.net>
         <20211127011246.7a8ac7b8@mail.inbox.lv>
         <20211129150117.GO3366@techsingularity.net>
         <20211201010348.31e99637@mail.inbox.lv>
         <20211130172754.GS3366@techsingularity.net>
         <c2aee7e6b9096556aab9b47156e91082c9345a90.camel@gmx.de>
         <20211201130155.GT3366@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eMC1zdcUK0UwphoxCoZSHWaUtPiN1B385tabFIKeMBZ8Ax3fovX
 EFb2OALfBQDeGBkaYq2AhTUp6zB9Cpiw98M6aaqjpfCC5zdhHreXqCiYxmpjo7M+5lms4ri
 0d/tWrjkTm/vqc2U0J64umuGxWyKus9l4icv/wXxtrON735nq73+rUlyLFuAuDOWpWhU/mW
 5Yft0M5KTfh14v8pSA4fw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/Gkh8qv4C3w=:Ga7LOAzvn7U3hdKLJlhDC+
 ILGuJC8tEPUCWGBYKiU2SmwhmMdWdtpxF9molhleSjrfeVXiFPXEZz43y/EaroAxTWDaMM/qY
 vLopOYRXAKJF2EoDDPUGNGNyni9buwMLkhbQ9KE1oubzhePtHBZy1DOnn3tS9pKNRzJ3NqmZj
 sGuYA2h7tYAs4Z11ZlyiHBJY3oM88RGoCmUFYzDGYpXAkzcAq0mAuQ5K4UNzIjmZ6qz7E0Qzk
 JFEC7zvRhx8IW4TG3tqvSeqk8XY3rwOItsMV60sdmDZNw21aS9olb2B6NTzJSaRwPJI3crvI5
 tHzJG40pym2FM00CIE56yRLqAbw/AU++bj+Yf8s4U3sgRFUZXiUNTFZmHgBS7IeA5GxpBuW9d
 Y5l6Sag4w/dwvSAaTqegD7i5F5UzHTzdgx1xUt3I8yO2x9+0Vck5kSbAZVu1Hzrci1hqI1I51
 YMOMHFRi7gDzooQ4m6/m9QRlP8dAmaT6RQfZf2z/iDFg+dQC/PlbgOKAhwuWKSs0FT9JiMWFV
 FWKkP7daNzMNJ2+fCMSfODwDXTotUlALdqMt33id0tWEAAuYZ1PkO5mqgQXgnhmcyYRMtGJse
 ICbHVJ/GQMM09oIovu7Cr5GzsFebGi0nPNqfWP39w6U0Z8hbmf2l2vWGYTcXh3lnNV01TlDSn
 WFcvB86KYU14EJysnj8EtmsxDYEuQKkw1ovNiVES9iC9wAWRiSyCvMVWkVPIYk8/tVdH7KoTo
 V7J7zDNvj9Jz4fYAqVuiC5ykOMo80TGNC/GKWheH9vK4/CbxvihIyg46fSz31SHeLWIud6n38
 GoS3r+7p99zSfOaSnPlL3Nq3PwjbFhcIVKcVEnr2tBAxNICqW2d+/Cwu4luMBYEhiQ/rNxfI9
 5Cshg+VPRMUafv1TYKKaRdYS1kJBiv9yC/NDNq159Hhh7JHf+26gElHq6YPHx6BlY7vn6kvss
 MWhHM+AIt6nKhbU0go8QZ7UUxVZ5r3ZI0m8D5sRx/bYemUEKpID8ccBmHuG3nqkAfboBLppSx
 P9pMcdXCkBXNWY3Malya5LJwPhrGN+Vo50GbYjqtI34FAAr8ZnGVsbO0dJcOGkUPHWW/tjqYB
 hZQGExpiUv2pLg=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2021-12-01 at 13:01 +0000, Mel Gorman wrote:
> On Tue, Nov 30, 2021 at 06:59:58PM +0100, Mike Galbraith wrote:
> > On Tue, 2021-11-30 at 17:27 +0000, Mel Gorman wrote:
> > >
> > > Obviously a fairly different experience and most likely due to
> > > the
> > > underlying storage.
> >
> > I bet a virtual nickle this is the sore spot.
> >
>
> You win a virtual nickle!

I'm rich I'm rich... oh dang, virtual.

I went back to 5.15, and confirmed that wait_iff_congested() did not
ever sleep with the try to eat /dev/zero load.  Nor did it with insane
overcommit swap storm from hell with as much IO going on as my little
box is capable of generating, making the surrounding congestion bits
look.. down right expendable.

	-Mike
