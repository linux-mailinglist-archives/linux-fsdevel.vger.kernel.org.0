Return-Path: <linux-fsdevel+bounces-47554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F6CAA01D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 07:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ED9417E219
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 05:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213B726F47F;
	Tue, 29 Apr 2025 05:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Wuryxoli"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EE01A5BBB
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 05:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745904463; cv=none; b=UiuXU/WdpIgTMvs9ZqTMo3r5KXrq8SuwtOzDLpnnj0hn5Y3BBAp6Mq6Y0HfWXsEb/mCofX6EQ5oHyq/x64ik6urtDMorUxuoTFAFAwKYc6ENitHZc1/NfJtoitGii4kbuc7GojBW24nfTgGsFOrO6JxgScc4YV9L4xqVSwS20ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745904463; c=relaxed/simple;
	bh=sDH7GPjsWMAktlFFpFNIRzm+n1K/fqw+Tr+lRTCO1Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5qgjYlfmMzNXZCfnJk/toxkdGjTtKCKYxUKAhFLDfWwvYgmrwU7NJom4frIJnJ1axNsDjvI963lP4FRSyoyo3mZkiZQV5xIUYdEvBV614Xzpuh5nrOX2scdNKw1c1lQYbsSrN6DE4F0kI7RNHsT6yzhdH064ULlMsyC2KTkWD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Wuryxoli; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BvEYeQC7IRo6lX+SOXux6dnMO5F9DHHG2+rxGygL0+M=; b=WuryxoliPH3UPOqY2f3v0z2ZmF
	fRjnR9Mtozm0du3BrArsAg+fCByledBI6nBs3I7ka8V5mkIKWKWFAZ3YMSSe6kSbiI33OPV6ucCBC
	vnUN5GRNtQTO9abH7fb07Wj1pPCmvVpAYH8qJ96dVE/gMwzBCd77RTq/5MsLa9LjlV2vzp4Evbgms
	8e4CmdbHEinBA8oVcdKWxnfgFl8MtSh/NKczkUvIO4wXUpsV9s4pENFQWY1WNtZPyqgGR6CNu1A0H
	Nt0KBjJReml9N3NVNN0BTzpx5Pc4RzS2vA861crB2IjHG1YeRSNRauH4Vu5mKWVkhq0PA5ztwfNPU
	Kt1J8/bw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9dVL-0000000DA96-1k8g;
	Tue, 29 Apr 2025 05:27:39 +0000
Date: Tue, 29 Apr 2025 06:27:39 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] move_mount(2): still breakage around new mount detection
Message-ID: <20250429052739.GQ2023217@ZenIV>
References: <20250428063056.GL2023217@ZenIV>
 <20250428070353.GM2023217@ZenIV>
 <20250428-wortkarg-krabben-8692c5782475@brauner>
 <20250428185318.GN2023217@ZenIV>
 <20250429040358.GO2023217@ZenIV>
 <20250429051054.GP2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429051054.GP2023217@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Apr 29, 2025 at 06:10:54AM +0100, Al Viro wrote:
> On Tue, Apr 29, 2025 at 05:03:58AM +0100, Al Viro wrote:
> > On Mon, Apr 28, 2025 at 07:53:18PM +0100, Al Viro wrote:
> > 
> > > FWIW, I've a series of cleanups falling out of audit of struct mount
> > > handling; it's still growing, but I'll post the stable parts for review
> > > tonight or tomorrow...
> > 
> > _Another_ fun one, this time around do_umount().
> 
> ... and more, from 620c266f3949 "fhandle: relax open_by_handle_at()
> permission checks" - just what is protecting has_locked_children()
> use there?  We are, after all, iterating through ->mnt_mounts -
> with no locks whatsoever.  Not to mention the fun question regarding
> the result (including the bits sensitive to is_mounted()) remaining
> valid by the time you get through exportfs_decode_fh_raw() (and no,
> you can't hold any namespace_sem over it - no IO allowed under
> that, so we'll need to recheck after that point)...

Anyway, I've pushed the obvious fixes to viro/vfs.git#fixes for now;
there's more coming (mnt_flags misuses, basically), but that'll have
to wait until I get some sleep...

