Return-Path: <linux-fsdevel+bounces-10856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C792984EB66
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 23:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 832DE28F4FE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 22:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEE04F8A9;
	Thu,  8 Feb 2024 22:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="R1wYTsHn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410794F219;
	Thu,  8 Feb 2024 22:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707430331; cv=none; b=n6/9Fvsr6UsWth95eECdrhoN0oo+iBWhKjT6f8r9/nyfzCCalFikpCtXcirvflZd3Mf8k098e1RQy8ySziwubnqQlnz5CHeafNh+l9UvRGjy7rXY1PQyagcNkHsVP/DeI5o9H4JvO3nebz11N+PunrZ4PvjPkyamzKROuRRGWjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707430331; c=relaxed/simple;
	bh=Fyeg55YvWWKTvSypIQeno+CRzpBsW/T+sUqfpxDTOKY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=K4qBsSezGh941TPQdkTDNye9tyLmwuJjsL4kng9ki25tExZ1s2c1q/F8bAQkmTSyFbrYhuEkRyjj4/LnS+/uuzyZjSZ+ffraCDRirWiATaXNuGGSxrRNKbMcMw2IOG4gS2OceWh2c0BZWAbaREE9tZkydQh1B9EPvcylIESJDII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=R1wYTsHn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A1EDC433C7;
	Thu,  8 Feb 2024 22:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1707430330;
	bh=Fyeg55YvWWKTvSypIQeno+CRzpBsW/T+sUqfpxDTOKY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R1wYTsHnJ7RwWXrnxfaVjjAZ3dexKuAEngkW/Ur8FsjgjOv5LrCVxgG63mCt5S1bW
	 xOR1+Rk9+QWXFTmjstP5rxW0/Q24vkNWH3xlEPrzniqmidjCYVebtwTR99k/1VS4BP
	 4Jgrk1wSFLa1obPh5VAEEXPyNFSRObXoKwidxpvg=
Date: Thu, 8 Feb 2024 14:12:09 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org, Linus
 Torvalds <torvalds@linux-foundation.org>, Vishal Verma
 <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, Matthew
 Wilcox <willy@infradead.org>, Russell King <linux@armlinux.org.uk>,
 linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-xfs@vger.kernel.org, dm-devel@lists.linux.dev,
 nvdimm@lists.linux.dev, linux-s390@vger.kernel.org, Alasdair Kergon
 <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka
 <mpatocka@redhat.com>
Subject: Re: [PATCH v4 01/12] nvdimm/pmem: Fix leak on dax_add_host()
 failure
Message-Id: <20240208141209.a73f4d3221f9573468729b8f@linux-foundation.org>
In-Reply-To: <acb2ca39-412a-4115-95c5-f15e979a43bb@efficios.com>
References: <20240208184913.484340-1-mathieu.desnoyers@efficios.com>
	<20240208184913.484340-2-mathieu.desnoyers@efficios.com>
	<20240208132112.b5e82e1720e80da195ef0927@linux-foundation.org>
	<acb2ca39-412a-4115-95c5-f15e979a43bb@efficios.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Feb 2024 17:04:52 -0500 Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> > The series seems useful but is at v4 without much sign of review
> > activity.  I think I'll take silence as assent and shall slam it all
> > into -next and see who shouts at me.
> > 
> 
> Thanks Andrew for picking it up! Dan just reacted with feedback that
> will help reducing the patch series size by removing intermediate
> commits. I'll implement the requested changes and post a v5 in a few
> days.

Yup.  I'll leave v4 out there for testers to bet on.

> So far there are not behavior changes requested in Dan's feedback.
> 
> Should I keep this patch 01/12 within the series for v5 or should I
> send it separately ?

Doesn't matter much, but perfectionism does say "standalone patch please".

