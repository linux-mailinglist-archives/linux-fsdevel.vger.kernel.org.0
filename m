Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D11460131
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Nov 2021 20:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbhK0TcI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Nov 2021 14:32:08 -0500
Received: from shark1.inbox.lv ([194.152.32.81]:54712 "EHLO shark1.inbox.lv"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235769AbhK0TaH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Nov 2021 14:30:07 -0500
Received: from shark1.inbox.lv (localhost [127.0.0.1])
        by shark1-out.inbox.lv (Postfix) with ESMTP id 8646E11180CA;
        Sat, 27 Nov 2021 21:26:50 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.lv; s=30062014;
        t=1638041210; bh=Aq1DfLEo2GD2s+hq/l0K0Ujr2gMIU22859FK5lGTsww=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=JZL4gQPW85w0kTge7K/kaLT/Iv1At7O2WSsUB25n786LcjxOni9RyrJYOVqAs/jPx
         Suqe8ADrwh2GBqDP3g2IuapMIHLa4OqqUmx6Epfd9BVYFQV37xGtcPrL8NHmE/Ec03
         Ul0soPxq9mH4rlVKox/BibQeyru1hKUfg5RxQ5xg=
Received: from localhost (localhost [127.0.0.1])
        by shark1-in.inbox.lv (Postfix) with ESMTP id 7D6FF11180AC;
        Sat, 27 Nov 2021 21:26:50 +0200 (EET)
Received: from shark1.inbox.lv ([127.0.0.1])
        by localhost (shark1.inbox.lv [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id DWnWFzWPJ5xz; Sat, 27 Nov 2021 21:26:49 +0200 (EET)
Received: from mail.inbox.lv (pop1 [127.0.0.1])
        by shark1-in.inbox.lv (Postfix) with ESMTP id 8303F111808B;
        Sat, 27 Nov 2021 21:26:49 +0200 (EET)
Date:   Sun, 28 Nov 2021 04:26:35 +0900
From:   Alexey Avramov <hakavlad@inbox.lv>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Mike Galbraith <efault@gmx.de>,
        Darrick Wong <djwong@kernel.org>, regressions@lists.linux.dev,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] mm: vmscan: Reduce throttling due to a failure to
 make progress
Message-ID: <20211128042635.543a2d04@mail.inbox.lv>
In-Reply-To: <20211126165211.GL3366@techsingularity.net>
References: <20211125151853.8540-1-mgorman@techsingularity.net>
        <20211127011246.7a8ac7b8@mail.inbox.lv>
        <20211126165211.GL3366@techsingularity.net>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: OK
X-ESPOL: EZeEAiZdhQo1taLbN/0M6uTt2NezU0QivCHkzL439RAqu7LAr7wBfW6TGofmHgq/cWbD
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I will present the results of the new tests here.=20

TLDR;
=3D=3D=3D=3D=3D
No one Mel's patch doesn't prevent stalls in my tests.

Test case:
Running firefox with youtube tab (basic desktop workload) and starting
$ for i in {1..10}; do tail /dev/zero; done
-- 1. with noswap and 2. with SwapTotal > MemTotal and swappiness=3D0.

I will log PSI metrics using latest psi2log (it's part of nohang [1]
package, src: [2]) and log some meminfo metrics using mem2log [3].

psi2log cmd:
$ psi2log -m 2 -i 1 -l /tmpfs/psi

mem2log cmd:
$ mem2log -i 1 -l /tmpfs/mem

The OS is Debian 9 x86_64 on HDD with ext4+LUKS, MemTotal: 11.5 GiB.

Repo with logs:
https://github.com/hakavlad/cache-tests/tree/main/516-reclaim-throttle

5.15
=3D=3D=3D=3D

- With noswap, psi2log summary:

2021-11-27 20:51:14,018: Stall times for the last 141.6s:
2021-11-27 20:51:14,018: -----------
2021-11-27 20:51:14,018: some cpu     1.3s, avg 0.9%
2021-11-27 20:51:14,018: -----------
2021-11-27 20:51:14,018: some io      99.1s, avg 70.0%
2021-11-27 20:51:14,018: full io      93.4s, avg 66.0%
2021-11-27 20:51:14,018: -----------
2021-11-27 20:51:14,019: some memory  4.3s, avg 3.1%
2021-11-27 20:51:14,019: full memory  4.2s, avg 3.0%

-- average full memory stall is 0.4s per one `tail /dev/zero`.

full psi2log log:
https://raw.githubusercontent.com/hakavlad/cache-tests/main/516-reclaim-thr=
ottle/515/noswap/psi

full mem2log log:
https://raw.githubusercontent.com/hakavlad/cache-tests/main/516-reclaim-thr=
ottle/515/noswap/mem

- With swappiness=3D0 and SwapTotal > 0:

2021-11-27 20:57:30,217: Stall times for the last 141.6s:
2021-11-27 20:57:30,217: -----------
2021-11-27 20:57:30,217: some cpu     1.2s, avg 0.8%
2021-11-27 20:57:30,217: -----------
2021-11-27 20:57:30,217: some io      100.7s, avg 71.1%
2021-11-27 20:57:30,218: full io      94.8s, avg 67.0%
2021-11-27 20:57:30,218: -----------
2021-11-27 20:57:30,218: some memory  3.9s, avg 2.8%
2021-11-27 20:57:30,218: full memory  3.9s, avg 2.7%

-- 0.4s memory stall per one `tail /dev/zero`.

full psi2log log:
https://raw.githubusercontent.com/hakavlad/cache-tests/main/516-reclaim-thr=
ottle/515/swappiness0/psi

full mem2log log:
https://raw.githubusercontent.com/hakavlad/cache-tests/main/516-reclaim-thr=
ottle/515/swappiness0/mem


5.16-rc2 vanilla
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

- with noswap

psi2log summary:

2021-11-27 21:45:09,307: Stall times for the last 1086.5s:
2021-11-27 21:45:09,307: -----------
2021-11-27 21:45:09,307: some cpu     4.2s, avg 0.4%
2021-11-27 21:45:09,307: -----------
2021-11-27 21:45:09,307: some io      337.6s, avg 31.1%
2021-11-27 21:45:09,307: full io      325.2s, avg 29.9%
2021-11-27 21:45:09,307: -----------
2021-11-27 21:45:09,307: some memory  888.7s, avg 81.8%
2021-11-27 21:45:09,307: full memory  886.2s, avg 81.6%

average full memory stall is 87s per one `tail /dev/zero`.

full psi2log:
https://raw.githubusercontent.com/hakavlad/cache-tests/main/516-reclaim-thr=
ottle/516-rc2/vanilla/noswap/psi

full mem2log:
https://raw.githubusercontent.com/hakavlad/cache-tests/main/516-reclaim-thr=
ottle/516-rc2/vanilla/noswap/mem

- And even worst with swappiness=3D0:

2021-11-27 22:33:19,207: Stall times for the last 2677.7s:
2021-11-27 22:33:19,208: -----------
2021-11-27 22:33:19,208: some cpu     14.0s, avg 0.5%
2021-11-27 22:33:19,208: -----------
2021-11-27 22:33:19,208: some io      306.7s, avg 11.5%
2021-11-27 22:33:19,208: full io      292.4s, avg 10.9%
2021-11-27 22:33:19,208: -----------
2021-11-27 22:33:19,208: some memory  2504.8s, avg 93.5%
2021-11-27 22:33:19,209: full memory  2498.2s, avg 93.3%

What a horror!

In dmesg: a lot of
[] Purging GPU memory, 0 pages freed, 0 pages still pinned, 2112 pages left=
 available.
(and dying journald)

psi2log:
https://raw.githubusercontent.com/hakavlad/cache-tests/main/516-reclaim-thr=
ottle/516-rc2/vanilla/swappiness0/psi

mem2log:
https://raw.githubusercontent.com/hakavlad/cache-tests/main/516-reclaim-thr=
ottle/516-rc2/vanilla/swappiness0/mem

dmesg:
https://raw.githubusercontent.com/hakavlad/cache-tests/main/516-reclaim-thr=
ottle/516-rc2/vanilla/dmesg

5.16-rc2 and 1st Mel's patch [4]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

- with noswap

Summary:

2021-11-27 23:28:23,707: Stall times for the last 1035.1s:
2021-11-27 23:28:23,707: -----------
2021-11-27 23:28:23,707: some cpu     5.6s, avg 0.5%
2021-11-27 23:28:23,708: -----------
2021-11-27 23:28:23,708: some io      336.5s, avg 32.5%
2021-11-27 23:28:23,708: full io      322.9s, avg 31.2%
2021-11-27 23:28:23,708: -----------
2021-11-27 23:28:23,708: some memory  851.1s, avg 82.2%
2021-11-27 23:28:23,708: full memory  848.3s, avg 82.0%

full psi2log:
https://raw.githubusercontent.com/hakavlad/cache-tests/main/516-reclaim-thr=
ottle/516-rc2/patch1/noswap/psi

mem2log log:
https://raw.githubusercontent.com/hakavlad/cache-tests/main/516-reclaim-thr=
ottle/516-rc2/patch1/noswap/mem

- with swappiness=3D0

Summary:

2021-11-27 23:50:25,722: Stall times for the last 1076.9s:
2021-11-27 23:50:25,722: -----------
2021-11-27 23:50:25,722: some cpu     12.2s, avg 1.1%
2021-11-27 23:50:25,722: -----------
2021-11-27 23:50:25,723: some io      232.1s, avg 21.6%
2021-11-27 23:50:25,723: full io      218.5s, avg 20.3%
2021-11-27 23:50:25,723: -----------
2021-11-27 23:50:25,723: some memory  957.5s, avg 88.9%
2021-11-27 23:50:25,723: full memory  951.2s, avg 88.3%

It's better than vanilla.

5.16-rc2 and 2nd Mel's patch [5]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

- with noswap

Summary:

2021-11-28 00:29:38,558: Stall times for the last 598.7s:
2021-11-28 00:29:38,558: -----------
2021-11-28 00:29:38,558: some cpu     5.2s, avg 0.9%
2021-11-28 00:29:38,558: -----------
2021-11-28 00:29:38,559: some io      235.0s, avg 39.3%
2021-11-28 00:29:38,559: full io      220.2s, avg 36.8%
2021-11-28 00:29:38,559: -----------
2021-11-28 00:29:38,559: some memory  439.0s, avg 73.3%
2021-11-28 00:29:38,559: full memory  437.5s, avg 73.1%

It's significant improvement, but far from the expected result.

mem:
https://raw.githubusercontent.com/hakavlad/cache-tests/main/516-reclaim-thr=
ottle/516-rc2/patch2/noswap/mem

psi:
https://raw.githubusercontent.com/hakavlad/cache-tests/main/516-reclaim-thr=
ottle/516-rc2/patch2/noswap/psi

In some cases the stall was quite short.

- with swappiness=3D0

Summary:

2021-11-28 00:53:41,659: Stall times for the last 1239.0s:
2021-11-28 00:53:41,659: -----------
2021-11-28 00:53:41,660: some cpu     9.4s, avg 0.8%
2021-11-28 00:53:41,660: -----------
2021-11-28 00:53:41,660: some io      206.5s, avg 16.7%
2021-11-28 00:53:41,660: full io      195.0s, avg 15.7%
2021-11-28 00:53:41,660: -----------
2021-11-28 00:53:41,660: some memory  1113.0s, avg 89.8%
2021-11-28 00:53:41,661: full memory  1107.1s, avg 89.3%

mem:
https://raw.githubusercontent.com/hakavlad/cache-tests/main/516-reclaim-thr=
ottle/516-rc2/patch2/swappiness0/mem

psi:
https://raw.githubusercontent.com/hakavlad/cache-tests/main/516-reclaim-thr=
ottle/516-rc2/patch2/swappiness0/psi


5.16-rc2 and 3rd Mel's patch [6] on top of 2nd
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

- with noswap

Summary:

2021-11-28 01:35:26,077: Stall times for the last 949.4s:
2021-11-28 01:35:26,077: -----------
2021-11-28 01:35:26,078: some cpu     5.4s, avg 0.6%
2021-11-28 01:35:26,078: -----------
2021-11-28 01:35:26,078: some io      269.0s, avg 28.3%
2021-11-28 01:35:26,078: full io      259.4s, avg 27.3%
2021-11-28 01:35:26,078: -----------
2021-11-28 01:35:26,079: some memory  759.9s, avg 80.0%
2021-11-28 01:35:26,079: full memory  757.5s, avg 79.8%

mem:
https://raw.githubusercontent.com/hakavlad/cache-tests/main/516-reclaim-thr=
ottle/516-rc2/patch3/noswap/mem

psi:
https://raw.githubusercontent.com/hakavlad/cache-tests/main/516-reclaim-thr=
ottle/516-rc2/patch3/noswap/psi

- with swappiness=3D0

Summary:

2021-11-28 01:59:40,253: Stall times for the last 1127.8s:
2021-11-28 01:59:40,253: -----------
2021-11-28 01:59:40,253: some cpu     6.8s, avg 0.6%
2021-11-28 01:59:40,253: -----------
2021-11-28 01:59:40,253: some io      228.3s, avg 20.2%
2021-11-28 01:59:40,253: full io      218.7s, avg 19.4%
2021-11-28 01:59:40,253: -----------
2021-11-28 01:59:40,253: some memory  987.4s, avg 87.6%
2021-11-28 01:59:40,253: full memory  982.3s, avg 87.1%

mem log:
https://raw.githubusercontent.com/hakavlad/cache-tests/main/516-reclaim-thr=
ottle/516-rc2/patch3/swappiness0/mem

psi log:
https://raw.githubusercontent.com/hakavlad/cache-tests/main/516-reclaim-thr=
ottle/516-rc2/patch3/swappiness0/psi

=C2=AF\_(=E3=83=84)_/=C2=AF

Should I test anything else?

[1] https://github.com/hakavlad/nohang
[2] https://raw.githubusercontent.com/hakavlad/nohang/master/src/psi2log
[3] https://github.com/hakavlad/mem2log
[4] https://lore.kernel.org/lkml/20211124115007.GG3366@techsingularity.net/
[5] https://lore.kernel.org/lkml/20211124143303.GH3366@techsingularity.net/
[6] https://lore.kernel.org/lkml/20211126162416.GK3366@techsingularity.net/
