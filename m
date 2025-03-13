Return-Path: <linux-fsdevel+bounces-43917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39560A5FBE4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 17:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CD9B3B37BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 16:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FC9269812;
	Thu, 13 Mar 2025 16:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qig2UyyW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21F42E3371
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 16:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741883637; cv=none; b=pzdX5kt75SuD0nPULPwBgOErM5nzfLh8Yk9d+AeHEodR/IpiOeegh2HOOvPqc9Wuog4F+VG98CQULxSPF34dIvNzVrsMxOoRMHqpOiXTg7dkDnE0BELMXhev3O/vle8cw3PnACpIDAwc4kaOaTwFtJxbLJHXbTjOFssDG6G+E/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741883637; c=relaxed/simple;
	bh=X1Fn4Z22YxriXZ+XLXS3yric0pSIsewyNYqzNx7CY8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NiYQkJF9YjDlUVyYp3WwZ5x1WdUgcN5W4iHYCtIyeA9HSkN+HZzjzaSXFOsiOl1IHtl4yvFPQJrxZcB8wwap7KyOiuym1Z3YBE9rME8+LpUnrTqTHUQQtGWuzG59Vertn6e0GV1KL63miB9by20D0N78MyGukVvY8YA787xDUis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qig2UyyW; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 13 Mar 2025 12:33:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741883622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yYYxIVXRSwxyFIJhJvKACu1v5ak9j3w7POVOI2j0xpY=;
	b=qig2UyyWUSClfgJPkbnnSn4kxaK2MJtXBEFr4dLLqzCiRtpZG7z7bcYIWcYVqT1YekSUv4
	e+F6Ws8XfN5kclu+e4qoFmEeHvytisZOKChnh/wIHhxc4gaKs+ysqZlKEYOG4uD17Ilwd1
	b6DqBzVhKYEWnG33AykirVZJv2COweY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	Jooyung Han <jooyung@google.com>, Alasdair Kergon <agk@redhat.com>, 
	Mike Snitzer <snitzer@kernel.org>, Heinz Mauelshagen <heinzm@redhat.com>, zkabelac@redhat.com, 
	dm-devel@lists.linux.dev, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] the dm-loop target
Message-ID: <ahddmkk35cmhrh4c5i5474bgqxhwy4kbc6sfo6zem77o25riqe@ptksvxbczl3r>
References: <7d6ae2c9-df8e-50d0-7ad6-b787cb3cfab4@redhat.com>
 <Z8W1q6OYKIgnfauA@infradead.org>
 <b3caee06-c798-420e-f39f-f500b3ea68ca@redhat.com>
 <Z8XlvU0o3C5hAAaM@infradead.org>
 <8adb8df2-0c75-592d-bc3e-5609bb8de8d8@redhat.com>
 <Z8cE_4KSKHe5-J3e@infradead.org>
 <2pwjcvwkfasiwq5cum63ytgurs6wqzhlh6r25amofjz74ykybi@ru2qpz7ug6eb>
 <Z9GYGyjJcXLvtDfv@infradead.org>
 <e92833a3-c262-d7f5-9034-2a803e27dae7@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e92833a3-c262-d7f5-9034-2a803e27dae7@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Mar 13, 2025 at 05:21:36PM +0100, Mikulas Patocka wrote:
> > IS_SWAPFILE isn't going way, as can't allow other writers to it.
> > Also asides from the that the layouts are fairly complex.
> > 
> > The right way ahead for swap is to literally just treat it as a slightly
> > special case of direct I/o that is allowed to IS_SWAPFILE files.  We
> > can safely do writeback to file backed folios under memory pressure,
> > so we can also go through the normal file system path.
> 
> But that is prone to low-memory-deadlock because the filesystems allocate 
> buffer memory when they are mapping logical blocks to physical blocks. You 
> would need to have a mempool in the filesystems, so that they can make 
> forward progress even if there is no memory free - and that would 
> complicate them.

I can't speak for everone else, but bcachefs has those mempools.

