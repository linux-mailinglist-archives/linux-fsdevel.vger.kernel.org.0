Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E80F463D52
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 19:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245102AbhK3SDq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 13:03:46 -0500
Received: from mout.gmx.net ([212.227.17.21]:33073 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238677AbhK3SDq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 13:03:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638295203;
        bh=p0H2cqMkifqjvSF0fOMCU23FVPx2ReNpJKrlUcqatUI=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=K5wHVjQFW3Vizg/YlVvPHdM5z3L30o5/AVVQuaWC23PIDvrRx/bfCyJhBzNI4WX24
         mVXqxuljiZRLJhfdzMQP+Fki6NRDpmRp0+yOOy3hAQSkhBz0C1tfpKOlUS0iA2eOjl
         E/j2MFt9ZFlY+PB7s4ls6ujzAXIVodSZHDidqEH0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.146.50.175]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MsYux-1mcWLY0Q5j-00u1ej; Tue, 30
 Nov 2021 19:00:03 +0100
Message-ID: <c2aee7e6b9096556aab9b47156e91082c9345a90.camel@gmx.de>
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
Date:   Tue, 30 Nov 2021 18:59:58 +0100
In-Reply-To: <20211130172754.GS3366@techsingularity.net>
References: <20211125151853.8540-1-mgorman@techsingularity.net>
         <20211127011246.7a8ac7b8@mail.inbox.lv>
         <20211129150117.GO3366@techsingularity.net>
         <20211201010348.31e99637@mail.inbox.lv>
         <20211130172754.GS3366@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RpBUBEAGZmeNkXxqfTXCYJ3JGdKKlx/k6qsoxqkn+eNZyGA17fS
 6A0ECgR6AmCvDIINwTQw9d1a9fWix5WcL+PFG6LwZuoc+MPZtHvKjTta2iYTLM3ApLzUbrp
 VMi4+tOapr0qwJuHz7v+a9vPW7AOJcr6+GJ0ZIKack7d13WWCT2pF6ORBJH36TMO22VgnY3
 1aFU7c4j4KNX9Vz0ycPGw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:aGQmldvLPl0=:NQTJciD5A+GpoR/z/5yBt+
 QOsVJt5cfxoNYpfuMxn+P4TZmJYIfkJMSLRBobj46VN6YKawDdCdOGm9dfcieUtAZbOjExRKP
 TGZ7J6hrhzXOBINZ47sKO2tFl5PrcxsW7rJPR9vnpVdl9on4/8sXZdoM9+ecAHap+S/r6Im69
 K0SLpbd+nQJp79dHkj3iLTEWhYa2U+hfy/j7DOJpBTVsyw6GcOkrhtwRlteT0kwXgzCfztArW
 ByPG4L6vbjSGQYzXjLJJXpXglcbNN71MAsvq10ZmhsaY8tzwB49+lyijjEfQL3fxUFCaJ3lfl
 l7ICZ0CzVXnfGSyt59aChCyZ5wH/BFSskNz2ajXNtaBReSsZYxKUJgJtImPREF8hXOUWPNQYz
 cs2iIC0I2DtzSCQD2Q1o8/M17Kunu8HLRPWJPGkJ2NXcFEj0FENSInthzRh2t7PQm0CUTmXAO
 UVOfd6V0acPtxJsZN0QfTtLZ8omSMAAWH430IEISln8kt+yV+VCksZyzd2WS2g0UvSDWAw0gO
 QeZVgt0yz1VIDlZd2dqEk3zEQ5EZqlXfpWg/kP2j9eLRgEV5IiVZ07lpcMeWTyo7g8sICcgKR
 NGQfPqrMlY5X007xvvJCUssyNk8CWfzmU+wZRrqIbvWKFyQ8hgKKxTVVHVJPyjJGIRMnHhX5L
 yR6BoWVaWNXSCIV5LY+eeedzTJYaVNt75+qvfa1yzUxsPCXkqqYBSItt5di8SkTJHtrd3y/7h
 0s5GKo4YiCcNWTKTgobiIavBdfHcnox9rTQKCf8tNfXKLvRy4ER3CsKe5bwAfjk+E0dy1Zhbf
 leJ9Z2kOHmwquwZc+/gBEsOgoDpnRh5Vn6tP1KkeqUH5ke+ZuLW+Ane1W/6ymURfvVfNcXDDp
 TyS8iV0uN0Oz0zFsi0v1P8Cxrfl6dMM8DjznjISkhgD0SxIjhVakefBiitS+TE3+8QKQm4UES
 cU4xPIhOVmemF3TlUXXQZ6Epawlw++CjyRnxBewZwuSaTxOTYpeSDjxGAzikpv9Uw4CMWCg9V
 IeIhEuO4nNBlUmxLXB5tt1jn3iCDx3oR+cTY91W/h+XiD0G7xUVi0pNy0lQ/XCe+rBrY5w1Jp
 dMwp7Xc2nv4mfY=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2021-11-30 at 17:27 +0000, Mel Gorman wrote:
>
> Obviously a fairly different experience and most likely due to the
> underlying storage.

I bet a virtual nickle this is the sore spot.

=2D--
 mm/vmscan.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

=2D-- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3360,7 +3360,17 @@ static void shrink_node(pg_data_t *pgdat
 	if (!current_is_kswapd() && current_may_throttle() &&
 	    !sc->hibernation_mode &&
 	    test_bit(LRUVEC_CONGESTED, &target_lruvec->flags))
+#if 0
 		reclaim_throttle(pgdat, VMSCAN_THROTTLE_WRITEBACK);
+#else
+		/*
+		 * wait_iff_congested() used to live here and was
+		 * _apparently_ a misspelled cond_resched()?????
+		 * In any case, we are most definitely NOT starting
+		 * any IO in reclaim_throttle(), so why bother?
+		 */
+		cond_resched();
+#endif

 	if (should_continue_reclaim(pgdat, sc->nr_reclaimed -
nr_reclaimed,
 				    sc))

