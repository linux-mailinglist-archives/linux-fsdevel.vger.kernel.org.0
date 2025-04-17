Return-Path: <linux-fsdevel+bounces-46646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD038A92D75
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 00:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E94651733EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 22:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EBC218EBA;
	Thu, 17 Apr 2025 22:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="kRvvReQp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5332F184E;
	Thu, 17 Apr 2025 22:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744930758; cv=none; b=bGZqlJUNGnkgyJFgb7YnKHcqkVVg/2yhMqL38TKSAnpgtl2t99jqdw8g9gKeZ6wvyERX2R0UDfQsitcj8OIy1XR9wvIwt6h0+bQeB4JBLAt3P7708Ie6opAbc+BwRW1VPOKyxicekYzTQ/8F50vLFcoGrjYa5wzXXkNaofzMk1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744930758; c=relaxed/simple;
	bh=8562OFkhRJQ+XF9ypIQCeBUMuMNU1FvypVrf2Ssre7E=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=drXGDOKsxGqQEMZq2Xa8p1yZ+XUQedjzyUVKxv2bnx+WHI3OxlxkQlKyU+6gLtOMlyW+ZExrjoBEGUbobHB090Scf6mbrOftNbuIA4ZG1ijBBNb4zn7k3eisi7yBSDU03+VMcXRIqGKsXXOu+66P8eXuAeT5fXNugd/50XtwV+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=kRvvReQp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE94C4CEE4;
	Thu, 17 Apr 2025 22:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1744930757;
	bh=8562OFkhRJQ+XF9ypIQCeBUMuMNU1FvypVrf2Ssre7E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kRvvReQp2vUitiaXrX18FJyRLSfQOaPPczw4J8iZb2dwIdyr7p3gMil7u9gQ7GAVe
	 GtDKCqguOHNRhxNW9jyS38fXO5ErSLJC/isL/tUIv9PYaYAtGm/ILYT9Iw5bvjJBsI
	 gW3Mltl3CzHKrmYl8ki5SON5KAbc1RbZqZtq6JcI=
Date: Thu, 17 Apr 2025 15:59:16 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: ", Darrick J. Wong" <djwong@kernel.org>, Alison Schofield
 <alison.schofield@intel.com>, David Hildenbrand <david@redhat.com>,
 <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-fsdevel@vger.kernel.org>, <nvdimm@lists.linux.dev>, Alexander Viro
 <viro@zeniv.linux.org.uk>, "Christian Brauner" <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
 "Alistair Popple" <apopple@nvidia.com>, Christoph Hellwig
 <hch@infradead.org>
Subject: Re: [PATCH v1] fs/dax: fix folio splitting issue by resetting old
 folio order + _nr_pages
Message-Id: <20250417155916.92e62e45dc1d82010f47519e@linux-foundation.org>
In-Reply-To: <680142129141c_130fd294f7@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20250410091020.119116-1-david@redhat.com>
	<Z_gYIU7Nq-YDYnc7@aschofie-mobl2.lan>
	<20250417034406.GF25659@frogsfrogsfrogs>
	<680142129141c_130fd294f7@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Apr 2025 11:01:54 -0700 Dan Williams <dan.j.williams@intel.com> wrote:

> Darrick J. Wong wrote:
> > On Thu, Apr 10, 2025 at 12:12:33PM -0700, Alison Schofield wrote:
> > > On Thu, Apr 10, 2025 at 11:10:20AM +0200, David Hildenbrand wrote:
> > > > Alison reports an issue with fsdax when large extends end up using
> > > > large ZONE_DEVICE folios:
> > > >
> > > 
> > > Passes the ndctl/dax unit tests.
> > > 
> > > Tested-by: Alison Schofield <alison.schofield@intel.com>
> > 
> > This fixes the crash I complained about here:
> > https://lore.kernel.org/linux-fsdevel/20250417030143.GO25675@frogsfrogsfrogs/T/
> > 
> > Can we get a fix queued up for -rc3 if it hasn't been already, please?
> > 
> > Tested-by: "Darrick J. Wong" <djwong@kernel.org>
> 
> Andrew, please pick this up, I have nothing else pending in the dax
> area.

Yep, I have it in mm-hotfixes.

I wasn't particularly planning on sending another batch to Linus this
week, but let's do that.  From: Easter Bunny.

