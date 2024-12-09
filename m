Return-Path: <linux-fsdevel+bounces-36870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B009EA283
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 00:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 734AE18886AD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 23:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08BF19F116;
	Mon,  9 Dec 2024 23:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="mOmNQ2fE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B9F19E985
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 23:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733785962; cv=none; b=GKeohKslo75xv9d3NrAZC0miur2hNGMfqR3jZqPU1aYgefZpBkd3+p+SwHTIpIEbPRDbQ/PNO6RrbyoVRDN3evlwpR3amPJjlFvNqTR6vCPQYqRtczIxQPzVFjnSi4wc+2qQamZ0ffIpztHM/BwxHZuUow7eg73wprS/ydoT/Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733785962; c=relaxed/simple;
	bh=AF+aCfqu/XRG4yN3Ugg/EFj2aB9SprPRVLdQj5Kw4pU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUYTBbMgG1VT+IaG7WNU1wdAdzkOdeeXST4u0mLrpamixTeNxlveaFiCcMv0My+E8xJnoUfXpT0/VYASHD+/43w9ANFzlZwVLM8dRBVPAtYC3ip3EvN0jQs/3fIpm0tP1ClSTgIQzGvvz7BRPl8i0RNq1wCV12Pz4MKtW6PjKm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=mOmNQ2fE; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FEmtxJWzi2EX6Y6kDWlBbAijCgoFv//HfBWnyOlqgr0=; b=mOmNQ2fEXk+NKUsa7Px0Wudy/y
	8NJcQbPyDoWAL6Cyu7qQ50nSmVsdycgwSRmK7Q/YeG3TfrSq0eSukWvv6qaijroLEMqhTZXYLVGKC
	imSB3s7uj3zHihg3tqfBEgFietbyc1qGHHRUwBbEP035cQHdMk8+5AUhf+S/f7gdObs8aRcQ3i/EZ
	8Xv6xacYXpUcnJ0V96PlrA5txB7+D4drFu3GkHmoFUeefkZIY9v8+WKKFPNETtSqR020wzEMIc+Ur
	e4JAjCdNUwxCfW4CGvIcckP73jri+zG/06O2ZIdwSyZAktJ+CP+yv76J332wu5GP+YHdBW5h5PVO7
	M5lvubtQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tKmvd-00000006hUO-0pUd;
	Mon, 09 Dec 2024 23:12:37 +0000
Date: Mon, 9 Dec 2024 23:12:37 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH][RFC] make take_dentry_name_snapshot() lockless
Message-ID: <20241209231237.GC3387508@ZenIV>
References: <20241209035251.GV3387508@ZenIV>
 <CAHk-=wh4=95ainkHyi5n3nFCToNWhLcfQtziSp3jSFSQGzQUAw@mail.gmail.com>
 <20241209211708.GA3387508@ZenIV>
 <20241209222854.GB3387508@ZenIV>
 <CAHk-=wjrtchauo9CO1ebkiES0X1VaZinjnHmcXQGBcZNHzyyBA@mail.gmail.com>
 <CAHk-=wj_rCVrTiRMyD8UKkRdUpeGiheyrZcf28H6OADRkLPFkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj_rCVrTiRMyD8UKkRdUpeGiheyrZcf28H6OADRkLPFkw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Dec 09, 2024 at 02:55:45PM -0800, Linus Torvalds wrote:
> On Mon, 9 Dec 2024 at 14:49, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > IOW, I'd *start* with something like the attached, and then build on that..
> 
> Key word being "something like". I just checked, and that suggested
> patch will cause build issues in lib/test_printf.c, because it does
> things like
> 
>     .d_iname = "foo"
> 
> and it turns out that doesn't work when it's a flex-array.
> 
> It doesn't have to be a flex array, of course - it could easily just
> continue to use DNAME_INLINE_LEN (now just defined in terms of "words
> * sizeof*(unsigned long)").
> 
> I did that flex array thing mainly to see if somebody ends up
> depending on the array as such. Clearly that test_printf.c code does
> exactly that, but looks like nothing else is.

Actually, grepping for DNAME_INLINE_LEN brings some interesting hits:
drivers/net/ieee802154/adf7242.c:1165:  char debugfs_dir_name[DNAME_INLINE_LEN + 1];
	cargo-culted, AFAICS; would be better off with a constant of their own.

fs/ext4/fast_commit.c:326:              fc_dentry->fcd_name.len > DNAME_INLINE_LEN)
fs/ext4/fast_commit.c:452:      if (dentry->d_name.len > DNAME_INLINE_LEN) {
fs/ext4/fast_commit.c:1332:                     fc_dentry->fcd_name.len > DNAME_INLINE_LEN)
fs/ext4/fast_commit.h:113:      unsigned char fcd_iname[DNAME_INLINE_LEN];      /* Dirent name string */
	Looks like that might want struct name_snapshot, along with
{take,release}_dentry_name_snapshot().

fs/libfs.c:1792:        char strbuf[DNAME_INLINE_LEN];
fs/libfs.c:1819:        if (len <= DNAME_INLINE_LEN - 1) {
	memcpy() in there might very well be better off a struct
assignment.  And that thing probably ought to migrate to fs/dcache.c -
RCU-related considerations in it are much trickier than it is usual for
->d_compare() instances.

