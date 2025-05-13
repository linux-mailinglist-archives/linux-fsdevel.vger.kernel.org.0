Return-Path: <linux-fsdevel+bounces-48797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CDFAB4A44
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 05:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27CBD4660E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 03:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA3B1DEFDB;
	Tue, 13 May 2025 03:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="f7gsrH+j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D80C79D0
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 03:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747108588; cv=none; b=r/OgMf0LcNUQ8v3UpCC7uKFIy5VQTUnUXDWmN3DQZdEIe0SEZ2WohNbtyRHA7mOqCBGHUtCeuV9sxRg8/z7NotW6VIrTQqSL62vwBzcf+pvT/FiAjjW8Fw9n8c9fmTZH/qRyK3jNPxS4FjFXzkeWPv7mUgg3bzJ5fsDncaJX2As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747108588; c=relaxed/simple;
	bh=j1y9fxodbCcWrTJ86bdDkulG3FUKMUpD2q1Pd4iwFPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+2ZQZYRTtlds1aTKSzWBO1IkBz4JD/BRVNn6iZv7y0sGA9zZtc7SVftRxE46vOV/oJKOTmu4P+X3s1obo/vnlfFuCORoWGkZW0XA4R51ZLoG0TE2q8PEQVIKxhAtGrK6sCXf0bccTfeNMJTxRpC8UNyqrmvneiqKkh41NjcV1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=f7gsrH+j; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GNSkaUV/BO213hHluyMdfXpixQdMEe/Flvl28qqeBoo=; b=f7gsrH+jW/PpLwk1nK6HBPvUSV
	nj91LDicSK/ZpIsQIxZZSwcjVRAuRRc0xp0Sp7V2gpBYFI7OaqEvsa51b+rg4AvOD7eC7b3blM/CB
	GTmlDsBA2f9nhWPHMr/dRQHwFQPlX1VMa83XlPA5CHv/W9+n7bHlmMAwDeFxfYWSHP64oci8LtJ+Q
	qUFZcNTqPprB4JxkfOxAtiJiybSYzm5NoQC7EpKCyioNhkN3rSqruzPlw4i4fHMcv1rLR9ortJIhZ
	uUnA/PzGzKkrkemVXaWYQUhCyJCoDIL9ivSVctY94pxBJlV/c2Vf7ulrJSATHDYoAo9BB+qgibeN2
	v/wX8C2Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEgkg-00000000xBn-3rtX;
	Tue, 13 May 2025 03:56:22 +0000
Date: Tue, 13 May 2025 04:56:22 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [BUG] propagate_umount() breakage
Message-ID: <20250513035622.GE2023217@ZenIV>
References: <20250511232732.GC2023217@ZenIV>
 <87jz6m300v.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jz6m300v.fsf@email.froward.int.ebiederm.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, May 11, 2025 at 11:50:40PM -0500, Eric W. Biederman wrote:

> This is there be dragons talk.
> 
> With out care it is easy to get the code to go non-linear in
> the number of mounts.
> 
> That said I don't see any immediate problem with a first pass
> without my __propgate_umount.
> 
> As I read the current code the __propagate_umount loop is just
> about propagating the information up from the leaves.
> 
> > After the set is collected, we could go through it, doing the
> > something along the lines of
> > 	how = 0
> > 	for each child in children(m)
> > 		if child in set
> > 			continue
> > 		how = 1
> > 		if child is not mounted on root
> > 			how = 2
> > 			break
> > 	if how == 2
> > 		kick_out_ancestors(m)
> > 		remove m itself from set // needs to cooperate with outer loop
> > 	else if how == 1
> > 		for (p = m; p in set && p is mounted on root; p = p->mnt_parent)
> > 			;
> > 		if p in set
> > 			kick_out_ancestors(p)
> > 	else if children(m) is empty && m is not locked	// to optimize things a bit
> > 		commit to unmounting m (again, needs to cooperate with the outer loop)

Misses some valid candidates, unfortunately.  It's not hard to fix -
handle_overmounts(m)
        remove_it = false;
        non_vanishing = NULL; // something non-vanishing there
        for each child in m->mnt_mounts
                if child not in Candidates
                        non_vanishing = child;
                        if (!overmounts_root(child)) {
                                remove_it = true;
                                break;
                        }
        if (non_vanishing) {
                for (p = m; p in Candidates && !marked(p); p = p->mnt_parent) {
                        if (!overmounts_root(non_vanishing) && p != m)
                                Candidates -= {p}
			else
				mark(p);
                        non_vanishing = p;
                }
        } else if m->mnt_mounts is empty && m is not locked { // optimize a bit
                commit_to_unmounting(m);
                remove_it = true;
        }
        res = next(m) // NULL if at the end of Candidates
        if (remove_it) {
		unmark(m);
                Candidates -= {m}
	}
        return res
will do the right thing and it's linear by the number of mounts we must
look at.

And yes, it's going to be posted along with the proof of correctness -
I've had it with the amount of subtle corner cases in that area ;-/

