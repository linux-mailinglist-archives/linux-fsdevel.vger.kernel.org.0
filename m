Return-Path: <linux-fsdevel+bounces-39900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD76A19C4D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 02:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFC793A97C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 01:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097C43596E;
	Thu, 23 Jan 2025 01:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="XRdTzyck"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109FA1B960;
	Thu, 23 Jan 2025 01:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737596716; cv=none; b=Qf0uvPZ6bkqSkgs5cNPzhm5XTN235TYp4u32IwG32lM3evsT0zxxtQ9F2+0ryiH63IHXKIqX+fYvPoHgW/94NmB39Y3Pi6FWkDCrqJZ17o2Guo0eaQNAG4Ddg3/9uhFzCtpoPB6Ck64KE94j2CwcRj9p/pcNBYDEsrFBLUcY9zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737596716; c=relaxed/simple;
	bh=4srw81pYMk/h4MOkVkinIWk+NCo21VKMzJPIcNqB7Io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0N60HhJEHhRorDfNqazzakGO6td3jzHh9hRMYsbQQIM3v3LG8USf2fjfouj36sxEAfS3mwEY40HA/ri6L8heeimZTi5e3V0wztrJfuA6Xpz1xPy5fySrRmOZtAKlvxISO33o88M6tUbY4o4//JXkMnbU1HlRci2kT36sR7cS5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=XRdTzyck; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3R7pZzbCFS8zECv0EDabSzEKzuwGtukbTrcTspaUZ8g=; b=XRdTzyck/We5beVSRfV0MM/CZV
	GQaL+1D1oOhmjPe5S04bSnwmOCcDqAXdQpnh8OUsfj+OSy9oZPwLwz4BnQ9gVvIe8jHK6cRBL23Tu
	I/0ZqFJE904yd7+X+s1kIBCjo0So3wNVtPSDoivT2+LlGTRQPrbdptn2CbT8sE3dEUX+AYGMjGi4F
	H3cB7CmyOTSH89Mp9BlAtvhEyQdC0hXIaKMWb2MopHCasbXUgbi5WW8C+D5OJJDdUZoOXOFZkEuta
	SYSw1CSSZvsNInyma4prKxaWqM/x77QJyfaTAPzTQLxfL1DhCPstuVjer7BBmx1mIRR/H+MxYCSlo
	yM32iTGQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tamHP-00000008Eu1-0KIL;
	Thu, 23 Jan 2025 01:45:11 +0000
Date: Thu, 23 Jan 2025 01:45:11 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Gabriel Krisman Bertazi <krisman@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>, ceph-devel@vger.kernel.org,
	linux-nfs@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Mike Marshall <hubcap@omnibond.com>
Subject: [PATCHES v3][RFC][CFT] ->d_revalidate() calling conventions changes
 (->d_parent/->d_name stability problems)
Message-ID: <20250123014511.GA1962481@ZenIV>
References: <20250110023854.GS1977892@ZenIV>
 <20250116052103.GF1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116052103.GF1977892@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

 	Series updated and force-pushed to the same place:
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.d_revalidate
itself on top of #work.dcache.
 
 	Individual patches in followups; please, review.
 
	Changes since v2:
* document that stable name passed to ->d_revalidate() may be followed by '/'
rather than NUL - in normal case it's given a pathname component in the
pathname being resolved and it doesn't have to be the last one.  Basically,
it's the situation as for ->d_hash() and ->d_compare() - ->len should not
be ignored.  AFS, FUSE and orangefs patches in the series ran afoul of that;
spotted (in AFS case) by dhowells.  Fixed; in case of afs it used to end up
with incorrect debugging printk, in case of fuse and orangefs - stray invalidations,
unfortunately not caught by testing.

 	Changes since v1:
* reordered external_name members to get rid of hole on 64bit, as suggested by
dhowells.
* split the added method in two in the last commit ("9p: fix ->rename_sem exclusion")

