Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5A94605EB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Nov 2021 12:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245389AbhK1Lpf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Nov 2021 06:45:35 -0500
Received: from mout.gmx.net ([212.227.15.18]:41949 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232090AbhK1Lnc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Nov 2021 06:43:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638099593;
        bh=U5vBJPo7borxDUYLvOOfeoJJZMpeXlH9wqwpUhA12Sg=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=HLyTw5WxYbk+fkhC8eui+sYzC9JSQ//YRgOVhCdiLQTG9H1hVtaEuLoDEQXuH+KJ1
         zqgXOf1+KXD/DgT0jvic5OBPkLRZhWnEj0Nmdq1RXuYCpZyha2v7pg/5fAYPfXWAOt
         b0/daOiIJX5C7oKttG75wsIuIZjtuqbukb5Y3zMU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.150.210]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVN6j-1n0Gys2EHX-00SNIL; Sun, 28
 Nov 2021 12:39:53 +0100
Message-ID: <941f378e1ea2b32cac0adee1e81637ab6d001f1e.camel@gmx.de>
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
Date:   Sun, 28 Nov 2021 12:39:51 +0100
In-Reply-To: <252cd5acd9bf6588ec87ce02884925c737b6a8b7.camel@gmx.de>
References: <20211125151853.8540-1-mgorman@techsingularity.net>
         <20211127011246.7a8ac7b8@mail.inbox.lv>
         <20211126165211.GL3366@techsingularity.net>
         <20211128042635.543a2d04@mail.inbox.lv>
         <252cd5acd9bf6588ec87ce02884925c737b6a8b7.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gkJ6likBbom3JbAxnrzHJYF3PmTbT8ovSN1QHsR8IdkC+Eep2Sp
 f34hU1l06wx3zlgxBefHCOMZHgZjBMdQFscuTcLF+bFls2DmcskTnECyYIUE3ZtrumTi6wJ
 p/7upRKJjPhywLYQmsBZViGJei3fplcha8zCt27xHabG+NGs5LJHsHXPRYRFeILoYpRZq6p
 OcsiMoIetx4dkzra0hBMQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:glpZMHVX8vs=:YCYA40Ri/MIKsfJCRM512B
 uTmAyYlSt46EvWJyLYgYRb7IjIw3+FejpNDOacc4zrwHTwAYeBprK+rqSquy8krS88o7ZJqsE
 xQdJyB+L/4tGhejK9c7ApiCxmxk8k/WO/suNOLKrPhfZDOWKjffrTlRodbmpGYjBbichhAx1f
 dqfLVNYSAypRp/JXsRMQUv2ciU7TLaI2+POXXoGXHqfs5jGsFS3MtOvQX9D9fhwRqHAHOtvEo
 FgX0H+ZqGt07IK5nYlPr+yp257SJqhQbhYVjhoDVsNQNMyN3plu9OZJaotLN0obzAgI8ceb/K
 dla3XPR+Tyl2G+CDubJejYoBF0gWB/K9d8ikFQBAr9nRa/zPFyQouwAHpmESY4CkTk+KzBoeR
 NEJCBv1jknXv8EbKjgxLQTOX3PpPMLRm2tyKT7RPdxwHpj71DkzcC1dQF2KuAqlItkvr6JQ6T
 YJuNg0PC7pKmK+QptlB5vGnRjoMkGcaUA5lhKNLNrJH/5D5ZcJJMi0R1p7ATVzCmcr7rtS7BO
 228f4puhmk+pdvwT2/yeLS9wnRHRTV7ReSE/Peu9Fk9zqQDltQax2hpbI6Nde7LKW0WaCpYKQ
 GYyBviUPj0+mgswd4/XHn3LUjFpGyjl5iPbfl0WH9MeVjNOWsaT/ajQhrzxTL24THZ2f4L9p1
 G7QUuxAZDs8Jn16+l4ipnHgkypsyBb2/JIHutZsZ0D4T69pCYGx6hFDRqs5glX5cog7oq1YFH
 6FtF7FzfOXZSapKPNENnHWdf161+JHhbsNi24q3w/I0FS8aLGwSFTXTfHvL6az8iak7grvm/3
 RrYQxuCt2yV402IGqVDahEhZNlChhi8QQmij9J9Xyi0Sq3aqHbTqXSE63PhKx+hYn+fN7C6ZL
 /L8JVAgrLmV4OiVMlIWgoQc/soQvwrhDmDJpK9m5r31/V4IXclKg1shDgblJ2I9B8JslgCqB/
 znfLGjCjdltQ7rxHQL6kzdi3vhoUuEZa+UdoxT4DRLeLiQt6TGM8EnwkzmAm9bIbChHaLpLXD
 /b/xPt89be+E2iBGEJG+inmZmU2brz2jlW5V/0AZtcH8nEyHRRdByU5pU8X3BMcPgjeLaAK0h
 74bmdPonySht7A=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 2021-11-28 at 11:00 +0100, Mike Galbraith wrote:
> On Sun, 2021-11-28 at 04:26 +0900, Alexey Avramov wrote:
> > I will present the results of the new tests here.
> >
> > TLDR;
> > =3D=3D=3D=3D=3D
> > No one Mel's patch doesn't prevent stalls in my tests.
>
> Seems there may be a problem with the THROTTLE_WRITEBACK bits..

Disregard.  I backed hacklet out again, and one-liner that had ground
my box to fine powder was harmless.  Hmm.

	-Mike
>
