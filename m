Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44684460597
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Nov 2021 11:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237547AbhK1KGl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Nov 2021 05:06:41 -0500
Received: from mout.gmx.net ([212.227.15.15]:58949 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232449AbhK1KEl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Nov 2021 05:04:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638093661;
        bh=W4OA5B8RsL5jolbKnXkXQOQbT/WRhFUAJHyD/Mmh6+Y=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=gRWs3SKCQYQSythd0Bxfs+HTWsC/yRadm+0U954++NJ/FIClT1/h+03L4OzyuTk6R
         492cEd77vNcmzEA9tNF/gdF635CC8DyFEpP7SuzDxHZh4pFgsJPl0oPvDBpjaTbCiW
         IOXAc0j88NcQXU9rCsD0UXzI1FNe9azjo8OL0obo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.150.210]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMGN2-1n9M4Z2cuk-00JJ5X; Sun, 28
 Nov 2021 11:01:01 +0100
Message-ID: <252cd5acd9bf6588ec87ce02884925c737b6a8b7.camel@gmx.de>
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
Date:   Sun, 28 Nov 2021 11:00:59 +0100
In-Reply-To: <20211128042635.543a2d04@mail.inbox.lv>
References: <20211125151853.8540-1-mgorman@techsingularity.net>
         <20211127011246.7a8ac7b8@mail.inbox.lv>
         <20211126165211.GL3366@techsingularity.net>
         <20211128042635.543a2d04@mail.inbox.lv>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:79XMNOX2dcJkpKsjLkjp8P5yZeNxbCGiV8Yeqj4OBuyjhuFwfli
 4pFpswaoJ8X9Twe7Y3bLBbDf0LozDMfPjWF0oqNGiO0BDQ7pvtE5aann4tUiZ6xilrLe7BX
 4fmpsCrNtoX4c5PbuFxzItIkvEhP7Dz1B3jMqi1l3XmzMBbdLinh/x62HcobNMweegJSRJG
 AShfLkDfOUL1hdxpKv3xw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0qdtCiJknZA=:C0TWX5EyVht6rFRoUlC0pV
 4Y4n2ArxTop4Tq8C0GhzY+LPFH4kSAyQhH6Ol4ZEaDuHxg/UmWNDTu3zUh2EYwVoguitfPZIr
 vtdj01ESYckMYmvs8S9L/39zj7qxam48egIJfHPLsdN2+i+/iK0h9cjpdLHfMLMaS49F7Ckts
 jR4TcYGIci+QebhbXEFVLbdwDwQavD4R34DaUtTQToDp3IzwISLI6rmUUkHSOfZOFTcuavZaW
 prfSh5agChhA9eBwXKLGWKxmJP4x2jigkdlBTk8SE5gslDlwa54xlj6AMheR2m/ZLp6PeZTix
 NjaQKR0MFZzu513We2u4qg0iup2asTRxGdxRVWVkj5R0X8wHeb/7gDtcWr9qPOy2j5WUkSIXu
 6GIIdt7hHVc+igBTS8gZT/7JK+mpy0zLmmbtObldTnYdnD9N3xjyMttKA+MRuuuwgBgdUtvGQ
 OW6B4jN9llsIIEiyT69IRp8aK02FaYuk1sPHfCKKgfUExVICv5wYp9kDZmMii0XLrFdi/dW+B
 vUaE2DAwVrIB1Iyx3jZDBxz1uF5wCVrqGb6egaYcvGk3BwTHac3RaRszgCoq0tml/Isq8Ko/5
 hb5pd6+X65+tbV88plCwL/IT9U133cCymwEzBkpYe71fqa5lvy8CmUOFuFK3P0Qnq85MFAN8Q
 /4vIzXJZCrK5klZdLX1iDXV7HzL9EhuG2i40XDvG4EkeP7fcCkjZV22RR4p2gMjlFoqr8P/EQ
 CgGh4DD2P9WN4FOfgP95L2wHivu9ekwDCmLxAh2VZcs1wI+Hy1VKa3zgwjgpnshdwX4R7wpzm
 Hi97YpkcRON9ed2JXGkVc01kL93KiW4vy+qlogcivz6eTZf0DSPWi+OSaWnfd4SVFZyZI3Sl4
 Ezd2hP9IPHK9THlJB2ZDo+rBKthlHRWGbCZAgdD6Monrz/Hg5nM0zxBRyEsMgNC4PYkApnqkz
 CxCNQP5TNABhNMhtOYqWCM/wYH2HYFSCZW+L6oKzT6SgP5U0zBnFf8Fx5SgQTlGiB5qQ1Z3O7
 PBX12jnFMfL6cX0GGwTVEAbqXjenhSUFyqwAZvc8F9l97Eq1kZGhFJqS6+h5bAbvIpbXe3+5A
 Uwjq0+2ClTX/gU=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 2021-11-28 at 04:26 +0900, Alexey Avramov wrote:
> I will present the results of the new tests here.
>
> TLDR;
> =3D=3D=3D=3D=3D
> No one Mel's patch doesn't prevent stalls in my tests.

Seems there may be a problem with the THROTTLE_WRITEBACK bits..

> $ for i in {1..10}; do tail /dev/zero; done
> -- 1. with noswap

..because the bandaid below (made of 8cd7c588 shards) on top of Mel's
last pulled that one-liner's very pointy fangs.

=2D--
 mm/backing-dev.c |    5 +++++
 mm/vmscan.c      |    8 +++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

=2D-- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -1055,3 +1055,8 @@ long congestion_wait(int sync, long time
 	return ret;
 }
 EXPORT_SYMBOL(congestion_wait);
+
+int async_bdi_congested(void)
+{
+	return atomic_read(&nr_wb_congested[BLK_RW_ASYNC]) !=3D 0;
+}
=2D-- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1021,6 +1021,8 @@ static void handle_write_error(struct ad
 	unlock_page(page);
 }

+extern int async_bdi_congested(void);
+
 void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason=
)
 {
 	wait_queue_head_t *wqh =3D &pgdat->reclaim_wait[reason];
@@ -1048,6 +1050,10 @@ void reclaim_throttle(pg_data_t *pgdat,
 	 */
 	switch(reason) {
 	case VMSCAN_THROTTLE_WRITEBACK:
+		if (!async_bdi_congested()) {
+			cond_resched();
+			return;
+		}
 		timeout =3D HZ/10;

 		if (atomic_inc_return(&pgdat->nr_writeback_throttled) =3D=3D 1) {
@@ -1079,7 +1085,7 @@ void reclaim_throttle(pg_data_t *pgdat,
 	}

 	prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
-	ret =3D schedule_timeout(timeout);
+	ret =3D io_schedule_timeout(timeout);
 	finish_wait(wqh, &wait);

 	if (reason =3D=3D VMSCAN_THROTTLE_WRITEBACK)

