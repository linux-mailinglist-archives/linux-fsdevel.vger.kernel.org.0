Return-Path: <linux-fsdevel+bounces-49829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77450AC3716
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 May 2025 23:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 270E1171344
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 May 2025 21:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591B71A0BDB;
	Sun, 25 May 2025 21:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="CweJBUnJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08D7DDC5
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 May 2025 21:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748209784; cv=none; b=KMvf/ccFdp1VvFArMJlDay0DkdafeUP9rmLGsbk9dy+90vuY8KCm0cAJJKYcQcnM8ffdheW8kWQAnE/sDXg3hjSjTMBrF35QHUb7vG05KrDb0j5LWgcCREwscC9ccfbQEolnwXd/XUhqODGNcgoGM+c8mpT73MVs6Jv6InhatU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748209784; c=relaxed/simple;
	bh=iJ06lDaedXoTQjz1CpncPxML1TQoeEIHRzAC5z3qLYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTXzXLQecZ5ELZN99uoE0rVOMUW6r38DR2b0mWVCEJ/m8EfNNK3knEOBBiuNhDsJpQLkA6MG/d6YmYkZw4r3gLOxCedQHTHwygsJq3JYe5vCQKU1p6cj4WqTpQAwm9TpuNzsZ8Q2GMEMMy5YFyKRFrO0PG2aetSc/4Pz+MndzZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=CweJBUnJ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=68Pl8Ewqg3BWCdOGCdraWkRfyAqRX8CEHEsjtvbRKHE=; b=CweJBUnJaEEJ72f4cV7oLjzrgO
	5g1tvwQHTYDCu3g9kTYCRencXdsg3XUZqrwUGHUPsk0uaxOrzQHC/diOLQzDiTi/jN+c01u8IkDxX
	KlvO0o2Uhf8wZ2Ax/shhZbggiYHIIszNjSfTJB2oYBvEY+xwrdtn6MMeuHLrDaMylJYqHoQ9LtT2J
	rZCoTT3m6oJHI3lZsGC0ZYtXZhWOxiDkHDyhlTvYnesDN5ck1eLPvOP93JcziShqwr7o6wO+Mi7l9
	ZcNyKRZ1P6hurUqOwLseNupm5s7R6x0Tzge31Dy0j5JXa0sPB9J4qnAt0l+X4yE9oHmBk/D8SicGE
	3ErDhqOQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uJJDv-00000000T1s-2HeY;
	Sun, 25 May 2025 21:49:39 +0000
Date: Sun, 25 May 2025 22:49:39 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Matthew Wilcox <willy@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [BUG] regression from 974c5e6139db "xfs: flag as supporting
 FOP_DONTCACHE" (double free on page?)
Message-ID: <20250525214939.GW2023217@ZenIV>
References: <20250525083209.GS2023217@ZenIV>
 <20250525180632.GU2023217@ZenIV>
 <40eeba97-a298-4ae1-9691-b5911ad00095@suse.cz>
 <CAHk-=wjh0XVmJWEF-F8tjyz6ebdy=9COnp6sDBCXtQNAaJ0TQA@mail.gmail.com>
 <aDOCLQTaYqYIvtxb@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDOCLQTaYqYIvtxb@casper.infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, May 25, 2025 at 09:48:45PM +0100, Matthew Wilcox wrote:
> On Sun, May 25, 2025 at 01:32:33PM -0700, Linus Torvalds wrote:
> > But yeah, maybe the drop-behind case never triggers in practice, and I
> > should just revert commit 974c5e6139db ("xfs: flag as supporting
> > FOP_DONTCACHE") for now.
> > 
> > That's kind of sad too, but at least that's new to 6.15 and we
> > wouldn't have a kernel release that triggers this issue.
> > 
> > I realize that Vlastimil had a suggested possible fix, but doing
> > _that_ kind of surgery at this point in the release isn't an option,
> > I'm afraid. And delaying 6.15 for this also seems a bit excessive - if
> > it turns out to be easy to fix, we can always just backport the fix
> > and undo the revert.
> > 
> > Sounds like a plan?
> > 
> > I'm somewhat surprised that this was only noticed now if it triggers
> > so easily for Al with xfstests on xfs. But better late than never, I
> > guess..
> 
> I wonder if we shouldn't do ...
> 
> +++ b/include/linux/fs.h
> @@ -3725,6 +3725,8 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags,
>                         return -EOPNOTSUPP;
>         }
>         if (flags & RWF_DONTCACHE) {
> +               /* Houston, we have a problem */
> +               return -EOPNOTSUPP;
>                 /* file system must support it */
>                 if (!(ki->ki_filp->f_op->fop_flags & FOP_DONTCACHE))
>                         return -EOPNOTSUPP;
> 

Perhaps

-#define FOP_DONTCACHE           ((__force fop_flags_t)(1 << 7)) when shit gets fixed
+#define FOP_DONTCACHE           0 // ((__force fop_flags_t)(1 << 7)) when shit gets fixed

instead?

