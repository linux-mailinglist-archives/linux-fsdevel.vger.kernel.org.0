Return-Path: <linux-fsdevel+bounces-34103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A005E9C2700
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 22:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F66F1F231BF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 21:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BB91DE88C;
	Fri,  8 Nov 2024 21:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CxZAeh83"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F1B199E89
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 21:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731101277; cv=none; b=KhNiSQfwfffMlNcaGPMb3kl/u60B3h5uYQ5yJDcW3c/lc0ASQnm+jMZKoaRJ3tms8DvChBh6kPxDfrHyX2wM6R67SyYtj9WuhxOHNlBBRF6sCQuz7CcfCKP+Kck7JxkYevMGj7wtv1TxT8OCceptvfV3phwScGnhqdmZYSue+wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731101277; c=relaxed/simple;
	bh=S8L4HvmeNxHKWfMuHTPLXvbU9+r0ff3+0QhbFWiC0Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIeZV1KeFuJDKKNdpWUSabglrKBM93FYWyU63ABUj8Hn6vaNyYbQUVV4sT3dvCs8DLWoPoiBxTgODTRNkVoIdg9sgln/9BLC2CU4EXFWxRfoewqSbNys94Jgz2MxYAVjpHyjV3JiPzTKr63c+m7S/gF4vldKl8BjSJaeMBrKO3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CxZAeh83; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 8 Nov 2024 13:27:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731101273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S9yRLxAX8T1rlHV/+Ct2rZaF9rujytNuCqhAVmD1asE=;
	b=CxZAeh83Acl+YUngZg++EYM/o8r0bEkYDkbKSPAjUUU+vdB1dGHkH4aT+WuK1WOPgrCC2z
	l+Edwz2fIGtRnJZ43lRnzxi/V4vdOTVlVmFheGSO8P4f+yuGgqWkRtv4O5RxWZ9NcxuANi
	9Ebk10QF/hreZ5E+gFEVVML3DzmKSkY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: David Hildenbrand <david@redhat.com>
Cc: SeongJae Park <sj@kernel.org>, Joanne Koong <joannelkoong@gmail.com>, 
	miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com, 
	josef@toxicpanda.com, linux-mm@kvack.org, bernd.schubert@fastmail.fm, 
	kernel-team@meta.com
Subject: Re: [PATCH v4 4/6] mm/memory-hotplug: add finite retries in
 offline_pages() if migration fails
Message-ID: <ubpkgutgkm2te7tu3dyvjxxkcmhelawd24lyaqnxrbvzgj7psl@zli7u63w4qgu>
References: <20241108173309.71619-1-sj@kernel.org>
 <04020bb7-5567-4b91-a424-62c46f136e2a@redhat.com>
 <4d2062bd-3cf3-4488-8dfc-b0aa672ee786@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d2062bd-3cf3-4488-8dfc-b0aa672ee786@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Nov 08, 2024 at 08:00:25PM +0100, David Hildenbrand wrote:
> On 08.11.24 19:56, David Hildenbrand wrote:
> > On 08.11.24 18:33, SeongJae Park wrote:
> > > + David Hildenbrand
> > > 
> > > On Thu, 7 Nov 2024 15:56:12 -0800 Joanne Koong <joannelkoong@gmail.com> wrote:
> > > 
> > > > In offline_pages(), do_migrate_range() may potentially retry forever if
> > > > the migration fails. Add a return value for do_migrate_range(), and
> > > > allow offline_page() to try migrating pages 5 times before erroring
> > > > out, similar to how migration failures in __alloc_contig_migrate_range()
> > > > is handled.
> > > 
> > > I'm curious if this could cause unexpected behavioral differences to memory
> > > hotplugging users, and how '5' is chosen.  Could you please enlighten me?
> > > 
> > 
> > I'm wondering how much more often I'll have to nack such a patch. :)
> 
> A more recent discussion: https://lore.kernel.org/linux-mm/52161997-15aa-4093-a573-3bfd8da14ff1@fujitsu.com/T/#mdda39b2956a11c46f8da8796f9612ac007edbdab
> 
> Long story short: this is expected and documented

Thanks David for the background.

Joanne, simply drop this patch. It is not required for your series.

