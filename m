Return-Path: <linux-fsdevel+bounces-41610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E2EA33082
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 21:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B69123A2627
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 20:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B69201022;
	Wed, 12 Feb 2025 20:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="q45KTiG1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98CB1FF1C2;
	Wed, 12 Feb 2025 20:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739391097; cv=none; b=rwYtpjbs/iexbXsRF05q7/9Q1meBDmmXMMOdLG1y/C9u+mGWkDJ7YhQwQhZsvwrP4LlgR1uLx9WSrljXqjgOJhz45XXdEsqTV23W4pkTG0c9uJX2B5rz+PHwedDWr8lahaHUKvcuJvRJ7om0C5bKuHWoPKts89Gybelne2k6xAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739391097; c=relaxed/simple;
	bh=6qTcwCtpCr7+h/R22UJDEV16dSISZVvuXz2xJ6KAgxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSeobgvjc9j98sQqjtzzSJ1BwhEfClixtQvTgCIE0DbtdmSO+PnYHkoj9pjNStgTgfOpyFTSWjA1OvMRJHPjjiOod8nYybFHM2iYp7Q1iDUDZVCgWJ64iHrkdoH/wAlV+uQKH/xEm/vbvRX9MCtmCqXQ3dGDwYDCiU7v4f9mluQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=q45KTiG1; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7C2y2Gn8TQhW8qH+BWEcWH5Rkp+PROvP198Z5BPLt70=; b=q45KTiG1wXXLQA/HwRqL8+ksRr
	J6kBGGd0ihv9sGWWVfs5VcpJy02cUJKx/3aQ4QPnMNLN9cDF0z5XLN31C6n6zezlq+ufvX5E7ChEK
	mS47Myza5Yk55B1uNusUyf4SOIUXzcAxXj79EiY/cxBci54jbIN/VulfDlEt7rt7iPjFfF345PckK
	R9N/4nJ5lzIswUSCQPE118OXbi0c5s9XaEeB3eg4cZJB6RSq/b5HkctY36v6cM1Weky+eIe1qoPwu
	n/zXlm4VH+jMo6t+t+SLlhyK9O5x2CdTHZi8tKcUDB71W55WnQTe8x/KKpMVnJDqTpmCrNLleMD+e
	AeQO6gYA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tiJ52-0000000C4iO-2gZq;
	Wed, 12 Feb 2025 20:11:32 +0000
Date: Wed, 12 Feb 2025 20:11:32 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/19] VFS: introduce lookup_and_lock() and friends
Message-ID: <20250212201132.GR1977892@ZenIV>
References: <>
 <20250208231819.GR1977892@ZenIV>
 <173933773664.22054.1727909798811618895@noble.neil.brown.name>
 <20250212155132.GQ1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212155132.GQ1977892@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Feb 12, 2025 at 03:51:32PM +0000, Al Viro wrote:

> And _that_ is really useful, provided that it's reliable.  What we
> need to avoid is d_drop()/d_rehash() windows, when that "operated
> upon" dentry ceases to be visible.

... which is easier to do these days - NFS doesn't do it anymore
(AFS still does, though).  There's also a bit of magical mystery shite
in exfat_lookup()...

IIRC, we used to have something similar in VFAT as well, and it
had been bloody bogus...

Actually, this one is worse - this
               /*
                * Unhashed alias is able to exist because of revalidate()
                * called by lookup_fast. You can easily make this status
                * by calling create and lookup concurrently
                * In such case, we reuse an alias instead of new dentry
                */
in there is utter nonsense - exfat_d_revalidate() never tells you to
drop positive dentries, to start with.  Check for disconnected stuff
is also bogus (reasoning in "vfat: simplify checks in vfat_lookup()"
applies), d_drop(dentry) is pointless (->lookup() argument is not
hashed), for directories we don't give a rat's arse whether it's
hashed or not (d_splice_alias() will DTRT) and for non-directories
the next case in there (d_move() and return alias) will work,
hashed or unhashed.

Now, the case of alias dentry being locked is interesting (both for
exfat and vfat)...

