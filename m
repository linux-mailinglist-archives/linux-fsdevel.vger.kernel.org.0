Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94756460908
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Nov 2021 19:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345761AbhK1SoU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Nov 2021 13:44:20 -0500
Received: from mout.gmx.net ([212.227.15.18]:41975 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232558AbhK1SmT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Nov 2021 13:42:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638124723;
        bh=rKAHtJtT/7cat6vBkBPLTPsYhFpRT2TD5/4AQ8wISI4=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=ScBuLgU2/5CvMymm+qb72tgAOi5S/qa7EB/4A7DOmDTtr2zFMnGe59WNdMHrOhQtx
         Sao8vXvfWZ6FSyzJZj9tG/r6shsGGoHIhd6Ux+VLnOlkxZtPgw+toFUzreDsuP31wL
         gRmCvpYm2LY0oErDIePNbEsuW5FIS6GxuITKZqjs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.150.210]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MwfWa-1mfesS457q-00y8UY; Sun, 28
 Nov 2021 19:38:43 +0100
Message-ID: <1c1835271e0ea093dd169d19038b477cf8563c32.camel@gmx.de>
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
Date:   Sun, 28 Nov 2021 19:38:37 +0100
In-Reply-To: <dd39029d93bb4de5ed485b5d4181fc19d4c0c4f0.camel@gmx.de>
References: <20211125151853.8540-1-mgorman@techsingularity.net>
         <20211127011246.7a8ac7b8@mail.inbox.lv>
         <20211126165211.GL3366@techsingularity.net>
         <20211128042635.543a2d04@mail.inbox.lv>
         <252cd5acd9bf6588ec87ce02884925c737b6a8b7.camel@gmx.de>
         <941f378e1ea2b32cac0adee1e81637ab6d001f1e.camel@gmx.de>
         <dd39029d93bb4de5ed485b5d4181fc19d4c0c4f0.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PIpqMRP8LvoWi9ghl2L5TJcmjnh4OeK7+d9fYHakEFhoqsjKICx
 DGGEPb/LoF8lS2/v+mfJTarrfldby9gS/SC+oigwLdPDStD2y9Ol7l5Mj0gWa822s3mtlZ8
 qE0U9WuBsMBUtufJ9GVSdcUKM3impPGS6ItlhVMxHWFAq8PXFA3L9gt+Xb+VwBxL0pzeqh6
 6LAGfOvZv+qB7sY3bgNnA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Auhalq6g+To=:ldnXkgH9wZk2YuKSYFqh7K
 0IG4xJB7GWR2z5B8eoUPLASRRnCgD0HQj9ZjASTYKofRnZ19PRktYXGacA19ITgVn1blTvxel
 lOszevT7F57i3yE8nYBc2ohW96SMhieKgq04X+9saTKLffPD0aWJd9JCiSPD0DI5JAzJv0n9W
 pyFVRoH8d+L0hcivPnsYvNqddAwQXZG0OSloqClSkYk/Rd4B22w/uO+y5FnwjleFudOSnvDju
 iCS0edvp9mj/NmYGV2hsPDyF9HstXkM29NyJQTICnpsSV8o8OPXgsG379/QYPanpnaYcZxpYq
 HhOLMLVXWe8S7SvFB8SI+G4fGb9//iJg1FW1rBIQghYxa/qI4fSer5qoyBp+Xp1wZh8oU1IjM
 JrnEbjGdInMG1b//Yy+DAc6BIrJtKSFPx4CkE89AXH27G/Wsp48M9ASMbf4DBTTyMKB+6+n6z
 O70ArBMgejRy7YjJClzYdbUVVmKCMvV1oMKSXrMkGiI0DNw0AXn3HjKJs/1UcxBrSrbQgN9Cu
 KbmzM/C5lUK6gygY+7F30JPmch3BSjHa512/TZwRXGV41XnPGZQKguFgyQFpmKUjqEAxIFBHL
 8rBw5xvtjlRp/IFXVzDLSLg+s5RkYdDQVc2ve48nz8zpu7cWDO0eLoCNgYFnIaORXNM6EbJio
 PzxR5Yai02KpeonCbVcybKbyH8aIbLwiLmf83mWUBWcVLbOj/oltcVa9+StxUjxMs9ZHTlN6I
 cIRUFFLf8cmo8CQB2dgOm20q3/H7yRDc0ARjYfSy36+/MlrzhvLYAiTW9OC2ubqHGguNUxrCM
 Ko5NDsNt7ZXjH8DcT5g1AWDtG3PB9NSpMe+cUgCu9ZQwcOEu4m+3BmphVabcuHOQgYdZf4yas
 liVyrAnP8w1xbHVJuJvCc3f7mK0iRjte7d0Zmbd28NmOR8Ico0KMP4ospoW4pbbdOG7a4eKRY
 MVCM9mn4Lo4VsnggWI04BJ6uB+tjQosXBnJFHIec9IT1+q2x69AwJpqVPiuF3sggxxnBkwhnd
 GG6c6IO4H9yTHlVvHYVj+kwWMWIUw+ZSMqsGhKFtJ8dOkSkOocr5X+ZKqFUK2/Y+o2X5fmY+N
 YE+UuiHSAcyDuk=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 2021-11-28 at 13:35 +0100, Mike Galbraith wrote:
>
> Bandaid likely just break the writeback bits all to pieces, but that's
> ok, if breakage makes things work better, they need more breaking :)

@@ -1048,6 +1050,10 @@ void reclaim_throttle(pg_data_t *pgdat,
 	 */
 	switch(reason) {
 	case VMSCAN_THROTTLE_WRITEBACK:
+		if (!async_bdi_congested()) {
+			cond_resched();
+			return;
+		}

And indeed, that's the only THROTTLE_WRITEBACK path I've seen taken.
Not pulling the plug made no difference to the tail /dev/zero test,
leaving only the bits I swiped from defunct wait_iff_congested() as
behavior delta cause.  Actually sleeping there apparently stings.

	-Mike
