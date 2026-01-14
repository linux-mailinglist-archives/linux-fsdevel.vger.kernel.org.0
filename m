Return-Path: <linux-fsdevel+bounces-73766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECFCD1FC93
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 16:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF39A300CAF1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 15:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCF239E164;
	Wed, 14 Jan 2026 15:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apNLZz+C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7509730EF6F;
	Wed, 14 Jan 2026 15:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768404891; cv=none; b=ud/A826NJ84c2q43ja9leA4GVWcvpGx/yS55hviqnDGzgAxSLEqiI7oDUCP4F9JvaA8cxQaOWWNzOZEEJq0pCp37WwahoDoS6Q7Y0rm1WCBdtfCd8ry7PGOvNsudnPYJkA1uR+9laxF66Xk7jkoespzuPGWfw8TGHxx1wn96PJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768404891; c=relaxed/simple;
	bh=GzVNkZ88Usl4TdMcpitFJ5xD9XIT23/DCN8JtVv7QNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TETA76U09TgugsmwQXbEjnYQY7g65efMaA+8Qc/tCTUqsIf9ui9dlYK0hOZl/l6JVywa3tpa/Xn5Xpdvu+vfNSHgcOGqm0MxuYWxaqnVm5MTcjtG7SaCdFIbX9SS+HyczVxwlPvK/HFYwabggX/QG+Nlnc621GiajY/+Mn1oWqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apNLZz+C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ACA8C4CEF7;
	Wed, 14 Jan 2026 15:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768404891;
	bh=GzVNkZ88Usl4TdMcpitFJ5xD9XIT23/DCN8JtVv7QNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=apNLZz+Ce+A0ADkFZI7PQtbs3I3O1p3Aon0TqQjQxW1790iTVIAYhTVnFv6n7MA+5
	 g10k7xBk/7AWgRiVNV41oDU+X06wB5uSjqF272u1e5nyfgv2Ovq2OG/JhMrSZJ37gq
	 FQAxaRY4JvRAx8gfGJ9VvVnnVA6yc9KQnIsLStCrEsscZq5kNxnoz6fFkBeaBELDx+
	 unzGJqjEMHBm3ytUHAwrXSc5jUsIDAjfq5c8Dm1W8siLaY5HogBD6qXPgHalXlWAY7
	 F2WBRz7HNb8XaUTN0Lr9qBvPijkLqskR5aO9OSeBZBA3ITYMf+dxyo/tbKqtISm4X/
	 zkdGN3mhurLNw==
Date: Wed, 14 Jan 2026 16:34:46 +0100
From: Christian Brauner <brauner@kernel.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: chao@kernel.org, djwong@kernel.org, amir73il@gmail.com, hch@lst.de, 
	linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	Hongbo Li <lihongbo22@huawei.com>
Subject: Re: [PATCH v14 00/10] erofs: Introduce page cache sharing feature
Message-ID: <20260114-komma-begeistern-20adeb35fdb8@brauner>
References: <20260109102856.598531-1-lihongbo22@huawei.com>
 <20260112-begreifbar-hasten-da396ac2759b@brauner>
 <d6ea54ae-39cf-4842-a808-4741d9c28ddd@linux.alibaba.com>
 <0f33bd17-7a03-4c06-a492-e514935faed6@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0f33bd17-7a03-4c06-a492-e514935faed6@linux.alibaba.com>

On Wed, Jan 14, 2026 at 06:28:34PM +0800, Gao Xiang wrote:
> Hi Christian,
> 
> On 2026/1/12 22:40, Gao Xiang wrote:
> > Hi Christian,
> > 
> > On 2026/1/12 17:14, Christian Brauner wrote:
> > > On Fri, Jan 09, 2026 at 10:28:46AM +0000, Hongbo Li wrote:
> > > > Enabling page cahe sharing in container scenarios has become increasingly
> > > > crucial, as it can significantly reduce memory usage. In previous efforts,
> > > > Hongzhen has done substantial work to push this feature into the EROFS
> > > > mainline. Due to other commitments, he hasn't been able to continue his
> > > > work recently, and I'm very pleased to build upon his work and continue
> > > > to refine this implementation.
> > > 
> > > I can't vouch for implementation details but I like the idea so +1 from me.
> > 
> > Thanks, I think it should be fine.
> > Let me finalize the review this week.
> 
> I wonder if it's possible that you could merge v14
> PATCH 1 and 2 now to the vfs-iomap branch (both
> patches are reviewed or acked):
> https://lore.kernel.org/linux-fsdevel/20260109102856.598531-2-lihongbo22@huawei.com
> https://lore.kernel.org/linux-fsdevel/20260109102856.598531-3-lihongbo22@huawei.com
> 
> since these two patches are almost independent to the
> main feature and can be merged independently as I said
> in the previous cycle.
> 
> Merging those patches into a vfs branch also avoids
> other iomap conflicts.

Done.

> 
> For the other patches (since PATCH 3), how about going
> through erofs tree (I will merge your iomap branch),

Fine.

> since it seems at least it will cause several conflicts
> with my other ongoing work, does it sound good to you?

All good.

