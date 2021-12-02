Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3378E465C8B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Dec 2021 04:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351367AbhLBDPY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Dec 2021 22:15:24 -0500
Received: from mout.gmx.net ([212.227.15.18]:41109 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344682AbhLBDPY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Dec 2021 22:15:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638414703;
        bh=DVqu7uvF6pnD7OhaDz7OP59dbYk4wRpIUL2hfNMFbJ4=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=JKSocHQYmlzpGHX5cYa3pmkarZpiiadQAuvxlLiexZ/IUJStIkNAfDLJcZIJj0Knl
         TG0RoWFdElQoC22Z44vx5R2buNQBZi6IN+4thCnDhyC9ThftQGOOObUc1I/0eOxp+9
         l4BCgkQ6H5Rsazy+fFUk1Iymqdc0bDJQrHEo2Eys=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.149.39]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPGRz-1nDq7f40pZ-00PaIQ; Thu, 02
 Dec 2021 04:11:43 +0100
Message-ID: <74248b525d5ee03bfd00aaa66cd08a4582998cd6.camel@gmx.de>
Subject: Re: [PATCH 1/1] mm: vmscan: Reduce throttling due to a failure to
 make progress
From:   Mike Galbraith <efault@gmx.de>
To:     Mel Gorman <mgorman@techsingularity.net>,
        Alexey Avramov <hakavlad@inbox.lv>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Darrick Wong <djwong@kernel.org>, regressions@lists.linux.dev,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 02 Dec 2021 04:11:38 +0100
In-Reply-To: <20211201140005.GU3366@techsingularity.net>
References: <20211125151853.8540-1-mgorman@techsingularity.net>
         <20211127011246.7a8ac7b8@mail.inbox.lv>
         <20211129150117.GO3366@techsingularity.net>
         <20211201010348.31e99637@mail.inbox.lv>
         <20211130172754.GS3366@techsingularity.net>
         <20211201033836.4382a474@mail.inbox.lv>
         <20211201140005.GU3366@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HO9NY5VYEjQHVfACzrMvWO3O/JI53j0Q8WbvUccG0MAx2Ucw+71
 zhJpKvCHaVgfJdDGNnaiMRlu2ORSvYqrqQGSZGL8SqYgIrR+o4iX1WFhsGcQIKDyMAkec/D
 JIwIgNtCItRBIFlTYFUf+n4UfzKtVIKW7UY9BFajmO5CfkQr0w1qupU0LWF6224I7t9O2aQ
 3JDbRYzF969uqPSmO2Krg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:aTN8X1KSxJc=:8jGWgxKTfL9dmjXiL6oRGC
 OoUVTIKsjeAJzbHFHUVrZj55EdKHr5tgyvUKzZQSeVRz71uvdr1dBYv1LNlSa8fdL55g5M6oV
 8ipLep07stHz2V2mHM/bAoJu/w/ifiYsbpZpgMaipGuw+skk7EOi+GSKMWJPbB0NMbTwT6O+f
 O4xzlqeNd8EvJh7zQXU6gQPJs/baobv07/ikpsx0OvqqrdI3KsFt8HHDsmlxRSaNOITvxUqDh
 zvMeMrWR+XhiRPh6Ier8wEoSID6Ogtb7hjNeTzfClfr8uO/VCvfrPrH4AKgnp7c/KubxosMyA
 Eri7kuTtDG3JgUTuBmsqj6tS/hxjbxPdh3elUbeeciv05nI3XOzMlZQTZv5ZTQ1NhKaQdme+X
 YrGUDUnUVpNitMZzNppdH40lQbpE0iqJmumNPcr0XfK3BJceyHGo+NHCK5hHE7N0+IyrFQ0Qi
 PLbLiIm1br6TFlHMwvSxYn7PV29wyu9a1otVsin+86Tj+Ir11E84xBF6sT3Q4ssi8plt8oHZJ
 NR2d3SPvcQfQKvelL74EvCgPxUv9BItecF84eAawtc6i5BKTRGz0I02/z1U7G94D31QZPkOra
 PdqKHH0DBHS3J9dLFdHWnf8t21tv/zHHrhU0/0g41574if6Tj9clB2qNOwCn3eli1k7ifVn5s
 RPUtUI6Zoi/fjDTT1fkq2GCD4iuuVE6susqKqhIWeeMHZRVfZmMpa9fY4HYDduFJqgfoxxypS
 1LONQXL/VACOiOzSY/LmDY4W6XdPFBDMGT14LyLlygpONX89tiLSvMrIRqD5Z2wo88ezrggGV
 Ak7JIykcP3IiN1jreBdK5D64swEKQ6AqKnnOOuMoipMWsV4f8lifhcLit5CPyy2/B5hbNyPj3
 LztV0pYz6e9F0WWAZddECgvB8MlLVk6apYhIqilwDgi+HU5H/iScKqTrJ5pdeTPEaaTydfkvt
 Z+m3n9hRWa+pMPIdeVgId8OaiheV9l8uV3lRgkIC3I4E7AHMykwT0O26Sjg2THAEmgLSocIkl
 g4rLH5MGJtKeEEt1iLGqswMJZkxeXhMi1KFqYqrIwQLXJXQLuyehl4QaHCEFBxOOhr8YvcqC4
 66O+yI3d/0HWCw=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2021-12-01 at 14:00 +0000, Mel Gorman wrote:
>
> I've included another patch below against 5.16-rc1 but it'll apply to
> 5.16-rc3. Using the same test I get

LTP testcases that stalled my box no longer do, nor can I manually
trigger any unexpected behavior.

	-Mike
