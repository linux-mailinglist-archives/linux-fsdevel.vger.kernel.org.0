Return-Path: <linux-fsdevel+bounces-15602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6891890925
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 20:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A7F21F29FD4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 19:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3461384B3;
	Thu, 28 Mar 2024 19:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FMMm7I/L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552E013248F;
	Thu, 28 Mar 2024 19:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711653833; cv=none; b=mC03snFC0KjGLWi4YVEG4UCNuUk3POkHncw6BwXT4PgbRfqU9nmAeaRmSIc3xElkI7JGw8nnSynI3uisIVMJr1SVhFbyJJ+7PjzgA8nY6Tln4IcEJwDC5oYOq2YIMPCuiIBPLbJMVZLWtIxBOhI4+7JevQ7oupoya/8ZPbAeMVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711653833; c=relaxed/simple;
	bh=tcx4rokV5inKUefW+ngsLLPSFNOMgp1ujfya8z+v1X8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qkjZS4QTh4mfYrJSfGr2nUekfLGtziNevKIkf/6DN5YGxSp9FvpB4ERB1SUpwx4TekElmCZrwAVq45IZkX1cghv3FZsVSA3zTxzouJL2MXmOS5ds+CH1m/dbxh8PJjrjbkrsNJRpG1lH8cduTuMzlDVMT+dGL8WgK7R6VbH2pfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FMMm7I/L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA7B6C433F1;
	Thu, 28 Mar 2024 19:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1711653833;
	bh=tcx4rokV5inKUefW+ngsLLPSFNOMgp1ujfya8z+v1X8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FMMm7I/LQg14E2kZhWOtK7FkrhQk+qoShv1oMXBR+paFWvhtwpW3zLjaZpIzuUIls
	 QfYEDIGkonhzH9jI8vLznzLfSLepKnYGheW6f0U+k3Ni0dvIk8xoCe7WJE5s/GA/vc
	 S8Yf+QpIbH6vM0GdO5Qz6qH/vF/Kq/3ei4Bmwd2E=
Date: Thu, 28 Mar 2024 12:23:52 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>, willy@infradead.org,
 jack@suse.cz, bfoster@redhat.com, tj@kernel.org, dsterba@suse.com,
 mjguzik@gmail.com, dhowells@redhat.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Improve visibility of writeback
Message-Id: <20240328122352.a001a56aed97b01ac5931998@linux-foundation.org>
In-Reply-To: <kind5tn6ythzjca3r5wrshjyveawm7il7ng4n6zyfwctafmqwo@eldoiinbwtbn>
References: <20240327155751.3536-1-shikemeng@huaweicloud.com>
	<20240327104010.73d1180fbabe586f9e3f7bd2@linux-foundation.org>
	<kind5tn6ythzjca3r5wrshjyveawm7il7ng4n6zyfwctafmqwo@eldoiinbwtbn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Mar 2024 15:15:03 -0400 Kent Overstreet <kent.overstreet@linux.dev> wrote:

> On Wed, Mar 27, 2024 at 10:40:10AM -0700, Andrew Morton wrote:
> > On Wed, 27 Mar 2024 23:57:45 +0800 Kemeng Shi <shikemeng@huaweicloud.com> wrote:
> > 
> > > This series tries to improve visilibity of writeback.
> > 
> > Well...  why?  Is anyone usefully using the existing instrumentation? 
> > What is to be gained by expanding it further?  What is the case for
> > adding this code?
> > 
> > I don't recall hearing of anyone using the existing debug
> > instrumentation so perhaps we should remove it!
> 
> Remove debug instrumentation!? Surely you just?

Absolutely not.  Any code in the kernel should have ongoing
justification for remaining there.  If no such justification exists,
out it goes.


