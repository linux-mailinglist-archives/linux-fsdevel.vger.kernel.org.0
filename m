Return-Path: <linux-fsdevel+bounces-43184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3E0A4F0AA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 23:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A07353A5904
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 22:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC5E21B9DA;
	Tue,  4 Mar 2025 22:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BTOlxPKb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38B81FF1D2
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 22:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741128297; cv=none; b=D1roY5SjlphJAnllgZ3x4nvPEylvAb1bRv4g4e4yCDnizbDn2EmRhphrPvKXF7B/mN+3JfPNzlye7R/w9jbZunoq5opurduCSckoPqwf1ZExKAK9U1VrOA1zXVN0yOPi3gE2yRnoHAOG+uAa2Ry1slq6HWn/kCCK13Oo6FOl6Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741128297; c=relaxed/simple;
	bh=UBN6ZvYsVS901SwmQeUwdsdE7S2kZno/zFHFuppr3uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVqfjT853vnNN4mfpdceWgLbXcXbR1DIakGD6+BvmY8FEOATArCjQwck5/J4lmWlgcZ3Vm4ZOXgX4y/zdGWhhAa8oTEbvJpGfXUMaW2kNHIO8BTRFZMC2iTykZUtx0dEHvBvBLC3mHSmaGapzYxR/4dG1nVg/8txA6A3Pirqt4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BTOlxPKb; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LBKyTATOOE1005ofeVgIBI9vLPBkrKA/dJ7YpUsPmVw=; b=BTOlxPKbJHY8W0MQwT5/cKjqD9
	Z+uB8ZxxbiGx8EmOWh1krsWoTX0zMZ4EGqtciulC1cATB1ldnuziBHrUG8wT9N/wEav8+kmaDKE/M
	nu1AN/3CVT6YkZpwB04ut5qZDW24s9YEPTEMJSvbEpZeW75Cohefkc+Xnz+n5OSRrJcBpe1QbH889
	d5z7WFaOM9olp2ehkSafk9PXz3CN1jo/ZQenHTjEsPqkouJD+1Oc34uju9cO+lutNMZhnqpLkUSNd
	OZSFcPkATk+5dmV/h7CwuCPt0+NpyfKOJv28Qx9LR3+GrIhv6tHJa42MwmttLvjO8y7f8T7eNEXkM
	l/ExbrSA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tpb0O-00000004Ex8-3nLr;
	Tue, 04 Mar 2025 22:44:52 +0000
Date: Tue, 4 Mar 2025 22:44:52 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Changing reference counting rules for inodes
Message-ID: <Z8eCZAbwPyBILnu3@casper.infradead.org>
References: <20250303170029.GA3964340@perftesting>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303170029.GA3964340@perftesting>

On Mon, Mar 03, 2025 at 12:00:29PM -0500, Josef Bacik wrote:
> I've recently gotten annoyed with the current reference counting rules that
> exist in the file system arena, specifically this pattern of having 0 referenced
> objects that indicate that they're ready to be reclaimed.
> 
> We do this everywhere, with inodes, dentries, and folios, but I specifically

Folios?  I don't think so.  The only exceptions I know to the rule of
"when a folio refcount reaches 0 it is reclaimed" are:

 - Frozen folios.  Filesystems should never see a frozen folio.
 - Devmem folios.  They were freed when their refcount reached 1.
   Alistair has that fixed in -next

If there's something you don't like about the folio refcount, please let
me know.  I have Some Thoughts:

 - It's silly that the pagecache takes 2^order references on the folio.
   It should be just 1
 - We play with the refcount in too many places.  In conjunction with
   the first point, what I'd like is if filemap_add_folio() consumed the
   refcount on the folio passed to it.  That is, today we allocate the
   folio (refcount 1), pass it to filemap_add_folio() which increments
   the refcount by 2^n and then put the refcount in readahead_folio().
   We should do noe of that; just have the pagecacahe assume the
   refcount that was passed in.  There are a few filesystems this would
   break today ... need to finish some more conversions.

Anyway, what's your problem with the folio refcount?  Filesystems
shouldn't need to care about folio refcounts (other than fuse which
decided to get all up in the mm's business).

