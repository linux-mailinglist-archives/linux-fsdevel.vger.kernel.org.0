Return-Path: <linux-fsdevel+bounces-60120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3B4B4141E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 07:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 005DF1B2730C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 05:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376582D481B;
	Wed,  3 Sep 2025 05:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="S2e8n3Kh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5007017A2F6
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 05:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756876133; cv=none; b=A3hK6Obds2+xoHDJCRev9eCySOo51TUXbpqCjp0i4ciFyO89nazAvYe8M7dhPLDRZ11zBDYwWK4DJE0E8caUj0so/IXItbceb+eoZ2SZuKobBkJ/ftPVHZvZoc0yvmgUs26jVirCdtO8FEvsOPcx+IoryJjJmZNsPtee751pMzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756876133; c=relaxed/simple;
	bh=1qp0bOezAKjNtPWINkNe4ZyV69sSzz6K8WxZziNDoek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/s3r33XGJ94VCmwGotDZ3PPd2ERnCY1QR8FpHlfoxle9hggdy1aZXKCcW6S2wF4NF/j3BhI/FgT1AMvK9Wf9RMTGTfNymRl8oKyb1SIbgKU0X0LWeHeaUJWRiCYtu5k2gbo/PjLpaF3zCwS8hUHmGO7F0nXq9g1hryEb5UzxWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=S2e8n3Kh; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Tkxn4p+DPhUheMjz+EEdn3I5rv/lQOuT88ClNbQ+QfM=; b=S2e8n3KhdU++iZXisiesQL+WsS
	0aGmROrOMia45q24RjiKKLSmrvyjxn6puwYuIth5XYHhweQgv6neWj1Ocak0mr/u+qxL85z1FotXO
	wsF/Uk39VyM38ARMXj8WTxX518iEP1RQikdTeokIG1pSS8veqP9V8erSiEMJm4Ko/Od7iULG3oos3
	RvuQp2I19AuyV3bcqdUwUZSU3KJ/zPkOdET548QIoKNexZtQ4uURHJT9KR9JWdTWRFi/DZ8HgKw2e
	JZjjiuw/IJxaDnDu5rj2jUkN+QWfDa0CE/nUeJxNCnROGzazNpyMUbiOoDYgL6kJAUheBCj8Djcjx
	QFhKGjHg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfjm-0000000B2Jk-0haq;
	Wed, 03 Sep 2025 05:08:50 +0000
Date: Wed, 3 Sep 2025 06:08:50 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCHES v3][RFC][CFT] mount-related stuff
Message-ID: <20250903050850.GI39973@ZenIV>
References: <20250825044046.GI39973@ZenIV>
 <20250828230706.GA3340273@ZenIV>
 <20250903045432.GH39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903045432.GH39973@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Sep 03, 2025 at 05:54:32AM +0100, Al Viro wrote:
> Branch force-pushed into
> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.mount
> (also visible as #v3.mount, #v[12].mount being the previous versions)
> Individual patches in followups.
> 
> If nobody objects, this goes into #for-next.

PS: survives LTP, xfstests and mount-related selftests.

FWIW, I've spent the weekend trying to figure out what's going on with
generic/475.  Turns out that it was not a regression - it goes back at
least to 6.12 and it's triggered by PREEMPT vs. PREEMPT_VOLUNTARY in
config.

The former gives several kinds of failures, with total frequency about 8%;
the latter apparently works - if any similar failures happen, the frequency
is at least an order of magnitude lower.

One useful thing I've got out of that is a bunch of helpers for doing
bisect for configs - semi-manual decomposing the difference between two
configs into a series of small changes, allowing to do bisection on that.

Unfortunately, the change it has converged to (and repeating it alone on
the original config reproduces the effect) is not particulary useful -
some race gets triggered by a config change that affects timings all over
the place ;-/

