Return-Path: <linux-fsdevel+bounces-45386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D46A76F90
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 22:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBA963A5424
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 20:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3D121ADC5;
	Mon, 31 Mar 2025 20:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGjJvrV9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F9C21A42B;
	Mon, 31 Mar 2025 20:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743453776; cv=none; b=ugnFkv9mn6UhZWPruZw0mspCinMsW891H1jTSy1a2CF4K4151cbgk+uO9FnS6MvzHXQ9QpHPp8/YRuWoPPWCcKSVVxIcPQJ7vvSGdQbt+g1fZ4IbewOOt67FzbBZcQh1TnzXEfBSKLq2cp/QtjRykQGxTNM7gJ1vSVBGcWBm/3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743453776; c=relaxed/simple;
	bh=jSJC+SD8elUJmWLcQ2xoshtDP2nPAUcKaI9DFXFk+Wg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIfGez/FmkK2aZ8Md8vQUBPYgM1ApavVq+rl1OQ0VkwQT3d0TkXZnPpjfd2yfE2eyzHazorM2fNhqeaXnoEtQrJUWHV07APus2cXfS4IXPvZMR7FUx60NpZeAXW2+C2Fj1GNM2gwThql/4VIaSQEWJ7HqWZjBpcTKnGkkq/etNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGjJvrV9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A5A5C4CEE3;
	Mon, 31 Mar 2025 20:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743453775;
	bh=jSJC+SD8elUJmWLcQ2xoshtDP2nPAUcKaI9DFXFk+Wg=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=hGjJvrV91nnpijsdQ3R94h6G05j2Vm9VRnwRvOJMH8XVUPFQNg0WY1ymNTAPXb9n7
	 KjYEZr1JPrdj/pIGgMANzQCsaOGz7o9NXa/QpGzq16Ycg9zJeF30Z4LbDQCfT6TW63
	 Ez7lxQQtYjaC7SuoJXzmWVHyLilP5Sg82PcSWqlAMWWPM0B/kdnvLnZCTDsNAXoHoU
	 wp/kjpDG2vtbeGKzeXlwjqU2DtTN+WpstWC5oBHy4NiMaKQeknIwBrEg1I3KyetXkc
	 TCluz1vNguft1kxys0ZY9gjKkSIk/abThJclGLoRTESLWMMAcOCC3gLDWlTvVvEYQE
	 DyjB61ZLTKLXw==
Date: Mon, 31 Mar 2025 22:42:53 +0200
From: Daniel Gomez <da.gomez@kernel.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	gost.dev@samsung.com, Daniel Gomez <da.gomez@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	R@macos.smtp.subspace.kernel.org
Subject: Re: [PATCH] radix-tree: add missing cleanup.h
Message-ID: <bprl56l6zhjdjk4vilgqyiekgajgzbanrnstjyh5dpzw2c5xky@exfsrll3hcpw>
References: <20250321-fix-radix-tree-build-v1-1-838a1e6540e2@samsung.com>
 <zukwcnvdw4xldq6fwztzi7jvr6boi7xo3tmuriwf6b32t73qmc@xaeigyxmhypj>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <zukwcnvdw4xldq6fwztzi7jvr6boi7xo3tmuriwf6b32t73qmc@xaeigyxmhypj>

On Mon, Mar 31, 2025 at 02:20:32PM +0100, Liam R. Howlett wrote:
> +Cc Luis, as he added this task to the kdevops build.
> 
> Is this going through fsdevel or linux-mm?  It's not entirely clear to
> me.  I assume fsdevel as akpm isn't in the email header?
> 
> * Daniel Gomez <da.gomez@kernel.org> [250321 16:25]:
> > From: Daniel Gomez <da.gomez@samsung.com>
> > 
> > Add shared cleanup.h header for radix-tree testing tools.
> > 
> > Fixes build error found with kdevops [1]:
> > 
> > cc -I../shared -I. -I../../include -I../../../lib -g -Og -Wall
> > -D_LGPL_SOURCE -fsanitize=address -fsanitize=undefined   -c -o
> > radix-tree.o radix-tree.c
> > In file included from ../shared/linux/idr.h:1,
> >                  from radix-tree.c:18:
> > ../shared/linux/../../../../include/linux/idr.h:18:10: fatal error:
> > linux/cleanup.h: No such file or directory
> >    18 | #include <linux/cleanup.h>
> >       |          ^~~~~~~~~~~~~~~~~
> > compilation terminated.
> > make: *** [<builtin>: radix-tree.o] Error 1
> > 
> > [1] https://github.com/linux-kdevops/kdevops
> > https://github.com/linux-kdevops/linux-mm-kpd/
> > actions/runs/13971648496/job/39114756401
> 
> I am quite pleased that you saw and fixed the issue with the kdevops
> running the testing!  Thanks!

To add more context:

As Luis mentioned in the "maple tree / xarray CI ready" thread [1], we still
need the kpd setup to run kdevops on patches posted to the mailing list. While
we wait for that, we are running maple and xarray tests with kdevops on a daily
basis using the latest linux-next tag. That’s how we spotted the issue.

If there’s a more relevant tree than linux-next for this, we can integrate it
as well.

[1] https://lore.kernel.org/kdevops/Z5u6UH2r-co6jS_u@bombadil.infradead.org/

> 
> The URL seems to have expired, so thanks for including the failure.
> 
> Can you please not break the link across lines so they work with a
> mouse click?  I believe this is an acceptable time to run over 80
> characters.

FYI, this is an updated link pointing to a more recent version (next-20250331):

https://github.com/linux-kdevops/linux-mm-kpd/actions/runs/14173886747/job/39703944372

However, I think it's not fully visible outside the kdevops organization. So, it
may be better to remove the link from the commit message.

> 
> > 
> > Fixes: 6c8b0b835f00 ("perf/core: Simplify perf_pmu_register()")
> > 
> > Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> > ---
> >  tools/testing/shared/linux/cleanup.h | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/tools/testing/shared/linux/cleanup.h b/tools/testing/shared/linux/cleanup.h
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..6e1691f56e300b498c16647bb4b91d8c8be9c3eb
> > --- /dev/null
> > +++ b/tools/testing/shared/linux/cleanup.h
> > @@ -0,0 +1,7 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _TEST_CLEANUP_H
> > +#define _TEST_CLEANUP_H
> 
> The "../../../../include/linux/cleanup.h" itself has these guards, so
> probably not needed?

They are not the same safeguards. The ones in the other file are
"_LINUX_CLEANUP_H". The solution here uses the same approach as in radix-tree.h.

It's probably safe to remove them here anyway.


