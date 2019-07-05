Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC8860076
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2019 07:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbfGEFJe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jul 2019 01:09:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbfGEFJd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jul 2019 01:09:33 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6E60216FD;
        Fri,  5 Jul 2019 05:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562303372;
        bh=wR0nIi/UwUMSGPluFPib5tDAspOm5XZsVqmm1CXmVbI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=P4OKl98fb+ZjukTs3Ul4LHLQpf19ItTNbpCiXVHaBroJKo7juozWa9+rwg+QRVQ5r
         KHDL6G4XIRLw/7Hcr62hm8VB026oIHTxuCDJEdVV9wXflap1la8mnA35HpNM/jD+sM
         eVmCLoL5d4v2SVi4yQcZ9e0avu4YcRam0u8fWNb0=
Date:   Thu, 4 Jul 2019 22:09:31 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mark Brown <broonie@kernel.org>, linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        mhocko@suse.cz, mm-commits@vger.kernel.org,
        Michal Wajdeczko <michal.wajdeczko@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: mmotm 2019-07-04-15-01 uploaded (gpu/drm/i915/oa/)
Message-Id: <20190704220931.f1bd2462907901f9e7aca686@linux-foundation.org>
In-Reply-To: <20190705131435.58c2be19@canb.auug.org.au>
References: <20190704220152.1bF4q6uyw%akpm@linux-foundation.org>
        <80bf2204-558a-6d3f-c493-bf17b891fc8a@infradead.org>
        <CAK7LNAQc1xYoet1o8HJVGKuonUV40MZGpK7eHLyUmqet50djLw@mail.gmail.com>
        <20190705131435.58c2be19@canb.auug.org.au>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 5 Jul 2019 13:14:35 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> > I checked next-20190704 tag.
> > 
> > I see the empty file
> > drivers/gpu/drm/i915/oa/Makefile
> > 
> > Did someone delete it?
> 
> Commit
> 
>   5ed7a0cf3394 ("drm/i915: Move OA files to separate folder")
> 
> from the drm-intel tree seems to have created it as an empty file.

hrm.

diff(1) doesn't seem to know how to handle a zero-length file.

y:/home/akpm> mkdir foo
y:/home/akpm> cd foo
y:/home/akpm/foo> touch x
y:/home/akpm/foo> diff -uN x y
y:/home/akpm/foo> date > x
y:/home/akpm/foo> diff -uN x y
--- x   2019-07-04 21:58:37.815028211 -0700
+++ y   1969-12-31 16:00:00.000000000 -0800
@@ -1 +0,0 @@
-Thu Jul  4 21:58:37 PDT 2019

So when comparing a zero-length file with a non-existent file, diff
produces no output.


This'll make things happy.  And I guess it should be done to protect
all the valuable intellectual property in that file.

--- /dev/null
+++ a/drivers/gpu/drm/i915/oa/Makefile
@@ -0,0 +1 @@
+# SPDX-License-Identifier: GPL-2.0
_

