Return-Path: <linux-fsdevel+bounces-42600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A52A4491A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 18:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1EEB166E70
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 17:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0342F19A28D;
	Tue, 25 Feb 2025 17:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="gZ9sOuvH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C89F18A93F
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Feb 2025 17:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506201; cv=none; b=mFnOOYPrAirFLOA4X41P+Dd4YAt3gnpH9YFD4OSsm9C/M+F/xFgqFfEuCOobN3vnY1ugrs+lQDXgSVOAO4QRF2xBfe55iAjXu4LUc/RRWbvV01TV2bZqi5yuwM6sVrmHmQ/5G5BmICbgrb6WJB1Pq2Rm1NRsAK0nKyKbsu2/CKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506201; c=relaxed/simple;
	bh=c81SHtS+g00JRyiDe+TwjxMsc3dqNDm/WCkPaFTm1Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEeAMk8wH1okjVWbtKP4wOERoxH0IDVN1mc3OUf+5rjMuz9zJtUiw4qHLsk6N9ejUJYSpr0BzRFWwD5mvacGfobHng0dRQRoLNuFJwRtpbOTKSkFtQH3QVTRF4IeL3QenKm2Z8se+sJ1ly+Oq6hmNySu3bunp7O0KP+DHBcXWs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=gZ9sOuvH; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5GowpL1ya4IvTmuSqUIeUhiWanw7lufAm44zGGWGrQo=; b=gZ9sOuvHRUOkb3L5Ue+4CHxZgp
	6jmrv1ZFITE9PRurxVy+871nJPV7G4WH9eQX8WPPkd6M9c2wNr11BY+PBOet311AoTAJyeAmN006x
	9tlwbr2CxrQChiSFMH0+KBWvrFdCFj69JzVwPEc0BLhPbxBNBtx93JxApDpKeUNWcBB4vLPXqPjoe
	Ehpr5RIG8pVNFA/z18U7hqKo3C0+SHRz9e142p49NbqmySf5Hm5G5DYyP+TYjwCg2fuBkOgbXWB0/
	6vYL+lNnR15gHp9RijcHSF4/ICdiaRfUHsxADIs4ldAzJep8yMdGyAv59bNiuymZAlQsCynvUblEk
	7te78M4Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tmzAY-00000008NcV-3wph;
	Tue, 25 Feb 2025 17:56:34 +0000
Date: Tue, 25 Feb 2025 17:56:34 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Neil Brown <neilb@suse.de>, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: Re: [RFC] dentry->d_flags locking
Message-ID: <20250225175634.GY1977892@ZenIV>
References: <20250224010624.GT1977892@ZenIV>
 <CAJfpegtOWWQRgraMjQ_zGkN7MOtoATpVaoGjTYT7NntTsHPYxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtOWWQRgraMjQ_zGkN7MOtoATpVaoGjTYT7NntTsHPYxA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Feb 24, 2025 at 03:07:03PM +0100, Miklos Szeredi wrote:
> On Mon, 24 Feb 2025 at 02:06, Al Viro <viro@zeniv.linux.org.uk> wrote:
> 
> > PS: turns out that set_default_d_op() is slightly more interesting
> > than I expected - fuse has separate dentry_operations for its
> > root dentry.  I don't see the point, TBH - the only difference is
> > that root one lacks
> >         * ->d_delete() (never even called for root dentry; it's
> > only called if d_unhashed() is false)
> >         * ->d_revalidate() (never called for root)
> >         * ->d_automount() (not even looked at unless you have
> > S_AUTOMOUNT set on the inode).
> > What's wrong with using fuse_dentry_operations for root dentry?
> > Am I missing something subtle here?  Miklos?
> 
> Looks like a historical accident:
> 
>  - initial version only had .d_revalidate and only set d_op in .loookup.
>  - then it grew .d_init/.d_release
>  - then, as a bugfix, the separate fuse_root_dentry_operations was added

Speaking of historical accidents - "seqlock: Add a new locking reader type"
(introduction of read_seqlock_excl()) happened a week after your
"vfs: check unlinked ancestors before mount" (Sep 12 and Sep 5 2013, resp.)

I'm switching d_set_mounted() from write_seqlock(&rename_lock); to
read_seqlock_excl(&rename_lock) - we need exclusion with movers,
but there's no need for anyone to retry ancestry chains or hash lookups
just because we have marked something as a mountpoint.

IOW, it's a reader, not writer; we can't replace it with need_seqretry
loop without more audit of d_mountpoint() callers I want to mess with
at the moment[*], but exclusive reader is fine.


[*] the ones under ->d_lock are not a problem and so are all that
are followed by "check if something's mounted in our namespace,
ignore if there isn't" as well as the ones that have an exclusion with
the caller of d_set_mounted(), but for now let's not go there.

