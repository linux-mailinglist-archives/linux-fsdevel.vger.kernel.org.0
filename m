Return-Path: <linux-fsdevel+bounces-20379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F308D2873
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 00:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 738061C26A0B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 22:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5A213E8BF;
	Tue, 28 May 2024 22:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OvZynLnc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C91913E883;
	Tue, 28 May 2024 22:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716937114; cv=none; b=QTxKFvtqoYa9x8n+Uf87NoUqUOwLEZ7ed0UvC0cmfQN3mabPEFhh7PkBpwVXo6jDsBYu+BwDAG3w3+VvXmeNSvcdfPH/NJuALYlLhvrXqN4vtrANftpLaq2xxY6axwYUuv71CuJxeRV5Cz7MNI5g2eVwlHVmt7+dO7Ig7CjFiVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716937114; c=relaxed/simple;
	bh=/mRakvpmO/pRhLpTx6MV8+Lfo6YDYZ2R1zmXM5ZX7AM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qk+72avzkCzpH1zxY60ltG2NCo+j1NKVQi23UXpzbqxJrN6kFGrh/nJgn0/12L1xXKdTXQf0+BdctjPsWP5c1/bfOGeu/b1N3wy9AAzy/Ggxy/F82Z2H+tNkU0aOL2xvAFd52BbkNlZb80br9xsl+daPZVo6zd3bSX4qzKKtJns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OvZynLnc; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bW2TjyT/Ytf/0wT7lSjDyMyqeXrZTTm63r54kD0Yl8c=; b=OvZynLnchxaco6BaSURLwCQf9I
	qE2RxRCGxeiVbd6af0v7HT6vOSaXjebaeqiA3Dwokmgk2HlFsxZqHDHkzS8xbXpEqPaVBIRVNoEEZ
	PE8O75ixoWeTDB52eAN7yTvWQsiIeCDbsW5Va92wtGCsj8fqAogh0DyzSJgdGKfNtsQYWwPOvuDIf
	FQd04lFTa+56lBHfxq0EWRGKNvwtrY2tufnBO6l/JhWn7o8Pf3UjiuRLmyTxteU+nh1CLDCca4IOK
	c9CIcsztY9HVB3oRdj7wJCgfMRZ9HoiG29B4uMs6UU0zlA/JtVqpa/3414na07egeQoKrhjXlIPr6
	xrNMXgxA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sC5m1-00000002Gul-2mFx;
	Tue, 28 May 2024 22:58:29 +0000
Date: Tue, 28 May 2024 15:58:29 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, kdevops@lists.linux.dev,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, willy@infradead.org,
	david@redhat.com, linmiaohe@huawei.com, muchun.song@linux.dev,
	osalvador@suse.de
Subject: Re: [PATCH] fstests: add fsstress + compaction test
Message-ID: <ZlZhlQ1ES-mPqaif@bombadil.infradead.org>
References: <20240418001356.95857-1-mcgrof@kernel.org>
 <20240420140241.wez2x3zoirzlmat6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240420140241.wez2x3zoirzlmat6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Sat, Apr 20, 2024 at 10:02:41PM +0800, Zorro Lang wrote:
> On Wed, Apr 17, 2024 at 05:13:56PM -0700, Luis Chamberlain wrote:
> > +_require_compaction()
> 
> I'm not sure if we should name it as "_require_vm_compaction", does linux
> have other "compaction" or only memory compaction?

I'll color bike shed with "memory compaction" although I am not aware of
other compaction types. However making it clear helps.

> > +++ b/tests/generic/744
> > @@ -0,0 +1,56 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2024 Luis Chamberlain.  All Rights Reserved.
> > +#
> > +# FS QA Test 744
> > +#
> > +# fsstress + compaction test
> 
> fsstress + memory compaction ?

Sure.

> Looks like this case is copied from g/476, just add memory_compaction
> test. That makes sense to me from the test side.

It's a generic fsstress + compaction, right.

> you just found. Looks like you're reporting a bug, and provide a test
> case to fstests@ by the way.

This case is hard to reproduce, and so instead of waiting for compaction
to trigger we force it now.

> Anyway, I think there's not objection on
> this test itself, right? And is this test for someone known bug or not?

This reproduces a known kernel bug for which we have a fix now merged,
at the time this test was written it was not even merged on v6.9-rc4.
The fix was merged on v6.9-rc6.

I can now add this to the test:

_fixed_by_git_commit kernel d99e3140a4d3 \                                       
        "mm: turn folio_test_hugetlb into a PageType"

However I also ran into some *other* issues even after that patch was
applied. Now that v6.10-rc1 is out I will retest to clarify the
situation and see if new issues are still lingering with this test.

  Luis

