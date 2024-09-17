Return-Path: <linux-fsdevel+bounces-29555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3034297AC26
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 09:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE3B7283EA1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 07:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A0A15AAD9;
	Tue, 17 Sep 2024 07:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="uKU/XHaD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC8814E2E3;
	Tue, 17 Sep 2024 07:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726558317; cv=none; b=VRW7oDCbTg5wGZiwPQTh5qsRiB3FkQU54J9vSR1ivSWPpyTenhBqkSD55O9snXXAMV3/vV3P8ZDoCOqPzzK/txs+mzBBCZIxoXG+QUrZRn7D/DI5SlKqIrc8weku0LP5/YMOl09gJ1IfjQ0dFU13XgpooFbZSx/qzCZSog60M4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726558317; c=relaxed/simple;
	bh=7OLaxg5PoSQa/tOzjReCkNS+zeMyP5cmNwI5F3QI2wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VbnCjrAtbwbM9Gsx+6odQEKwClubLQ1rhfDtem98c6HZdtDJBDzV2Ei27YteL6FQAaSNfZinqsenP1Wj9aX25FzN3Z3R1dU7MRUtOoXviAIYDZdgjSc7aJ+pNVtzUq69+UppAcqGn3amaUOVEdpNsatjJv50VRjuDPdQJohboI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=uKU/XHaD; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aIMhUWWq9rqgGhPY2VuiSSHKl/hha3jBQJx8yropvhE=; b=uKU/XHaDlrrCrGvkBP1Hb3jFyw
	lfuTfqWG3i769JpiZuDgrQa3f93FWfUCFsW5W1s8nOF3VylS+mKgIbGex5PX0FOud1T1xH1o5RZK2
	oTKrNRYuEHpT/o6oHutO6d1cTMgvMiH4Yr7HZmsR5iHNGk0YDtAq5WEeGrKt9Ga9e+TjCVODpvyj/
	9o8KYL1edUcA+z9tPkKATd8MOBGaDIxWUsRhyp5ZTpAGk5D9Ozngs2qCp49kSmMYWeTVASJLtNGP0
	xi8khufRgQCA1yyXB55L3zuIjVyLviejrudXqHfK2LUcTSi1KhmWybuOV9ULwkOo16VFCugvbQrRx
	iDQYH1Dg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sqSgg-0000000D88n-00RL;
	Tue, 17 Sep 2024 07:31:50 +0000
Date: Tue, 17 Sep 2024 08:31:49 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Yiyang Wu <toolmanp@tlmp.cc>, linux-erofs@lists.ozlabs.org,
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 19/24] erofs: introduce namei alternative to C
Message-ID: <20240917073149.GD3107530@ZenIV>
References: <20240916135634.98554-1-toolmanp@tlmp.cc>
 <20240916135634.98554-20-toolmanp@tlmp.cc>
 <20240916170801.GO2825852@ZenIV>
 <ocmc6tmkyl6fnlijx4r3ztrmjfv5eep6q6dvbtfja4v43ujtqx@y43boqba3p5f>
 <1edf9fe3-5e39-463b-8825-67b4d1ad01be@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1edf9fe3-5e39-463b-8825-67b4d1ad01be@linux.alibaba.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Sep 17, 2024 at 03:14:58PM +0800, Gao Xiang wrote:

> > Sorry for my ignorance.
> > I mean i just borrowed the code from the fs/erofs/namei.c and i directly
> > translated that into Rust code. That might be a problem that also
> > exists in original working C code.
> 
> As for EROFS (an immutable fs), I think after d_splice_alias(), d_name is
> still stable (since we don't have rename semantics likewise for now).

Even on corrupted images?  If you have two directories with entries that
act as hardlinks to the same subdirectory, and keep hitting them on lookups,
it will have to transplant the subtree between the parents.

> But as the generic filesystem POV, d_name access is actually tricky under
> RCU walk path indeed.

->lookup() is never called in RCU mode.

> > That's kinda interesting, I originally thought that VFS will make sure
> > its d_name / d_parent is stable in the first place.
> > Again, I just don't have a full picture or understanding of VFS and my
> > code is just basic translation of original C code, Maybe we can address
> > this later.
> 
> d_alloc will allocate an unhashed dentry which is almost unrecognized
> by VFS dcache (d_name is stable of course).
> 
> After d_splice_alias() and d_add(), rename() could change d_name.  So
> either we take d_lock or with rcu_read_lock() to take a snapshot of
> d_name in the RCU walk path.  That is my overall understanding.

No, it's more complicated than that, sadly.  ->d_name and ->d_parent are
the trickiest parts of dentry field stability.

> But for EROFS, since we don't have rename, so it doesn't matter.

See above.  IF we could guarantee that all filesystem images are valid
and will remain so, life would be much simpler.

