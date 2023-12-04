Return-Path: <linux-fsdevel+bounces-4803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 530C280401E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 21:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DEB9280D94
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 20:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55FC35EF6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 20:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="C5HVjlC/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C10109;
	Mon,  4 Dec 2023 11:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=31lqF3ruwfpYzrnTsgyr1gbsnpp1pkXqOoQWp2IbCQc=; b=C5HVjlC/oY+URNqLU37Fdr+68H
	GtVg2+XUh1MK9mhQX3iSYHXDqW2/uFseTbukD2uMX/QHutJlBhAjfIoxrsPK7JfSNGwBMg7YRBmUN
	9LA21XoQi8RAN0NJB4wwHq8x4EHxHc/xANT+EpxmCT+UuHB9JwIHZ5ADetAmbDtRQrRW4Gm6ZYIzN
	7dX1dcVuUAj53D+eQI4FPTC9O8O60vCZAMvc0T9Q+sMmjL02A8o6rkQlIunqXMFJo7GutdoVLWT1c
	jMEAiTzZz2s7xuvJsXE/FRuSf8Yla4HqQPwWDvWtFtVBUshLkI2PuhsG4KFJIPqrE1G7ltqhpdORQ
	ljwlh7Dg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rAF0L-0072uH-2X;
	Mon, 04 Dec 2023 19:53:21 +0000
Date: Mon, 4 Dec 2023 19:53:21 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, linux-doc@vger.kernel.org,
	ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [viro-vfs:work.dcache2] [__dentry_kill()]  1b738f196e:
 stress-ng.sysinfo.ops_per_sec -27.2% regression
Message-ID: <20231204195321.GA1674809@ZenIV>
References: <202311300906.1f989fa8-oliver.sang@intel.com>
 <20231130075535.GN38156@ZenIV>
 <ZWlBNSblpWghkJyW@xsang-OptiPlex-9020>
 <20231201040951.GO38156@ZenIV>
 <20231201065602.GP38156@ZenIV>
 <20231201200446.GA1431056@ZenIV>
 <ZW3WKV9ut7aFteKS@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW3WKV9ut7aFteKS@xsang-OptiPlex-9020>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Dec 04, 2023 at 09:37:45PM +0800, Oliver Sang wrote:

> > OK, a carved-up series (on top of 1b738f196e^) is in #carved-up-__dentry_kill
> > That's 9 commits, leading to something close to 1b738f196e+patch you've tested
> > yesterday; could you profile them on your reproducers?  That might give some
> > useful information about the nature of the regression...
> >
> 
> we rerun the test and confirmed the regression still exists if comparing
> 20f7d1936e8a2 (viro-vfs/carved-up-__dentry_kill) step 9: fold decrment of parent's refcount into __dentry_kill()
> with
> b4cc0734d2574 d_prune_aliases(): use a shrink list
> 
> the data is similar to our previous report.
> 
> now we feed the results into our auto-bisect tool and hope to get results later

Thank you.
 
> but due to the limitation such like auto-bisect cannot capture multi commits if
> they all contribute to the regression, after we get the results from auto
> bisect, we will check if any further munual efforts needed. Thanks

My apologies for the number of steps in that ;-/

FWIW, what I'm really afraid of is this regression coming from #4; it might mean
that on some loads shrink_dcache_parent() benefits from evicting a parent while
it still has children halfway through ->d_iput().

That should not happen to sillyrenamed children, which is the only case where
the mainline instances of ->d_iput() currently access the parent, but that
depends upon too many subtle details spread over too many places ;-/

Oh, well - let's see what profiles show...  I still hope that it's not where
the trouble comes from - it would've lead the extra cycles in shrink_dcache_parent()
or d_walk() called from it and profiles you've posted do not show that, so...

