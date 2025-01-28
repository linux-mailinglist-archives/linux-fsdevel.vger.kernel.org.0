Return-Path: <linux-fsdevel+bounces-40184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D99ACA2028E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 01:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 257F31886031
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 00:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4DF539A;
	Tue, 28 Jan 2025 00:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="uqseCArS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD0B2905;
	Tue, 28 Jan 2025 00:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738024024; cv=none; b=HiQQ2ytWAi9sKUmMApogux8kTEmL2Kjq5Syp/UkOp3XyslTVqkMKSjz1Sr3ByYMDcN4ulM0OUNqCTYKV9NIC0pnTo5kKK8g96amvC/N0gfC90hO+1d+x0YmxK/EMOkzn8bGo86oCUhVEgMD4EkubmDcO81KQO0mYD7HXGOT1P5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738024024; c=relaxed/simple;
	bh=4KQbRAKNUICC83G0SvEJQqqG7V4yclHnUlJWa40n5eU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jc8+i46HhcL4IEEI3Y7Ivsz/MMO2ohHJjJMe6Pd7sr1Uy68BUyqN995M1f7ggtBQ40wzPPhMydiHQHgA/nGYqfF0Q1DjYy6l98Mk6Bo0/6Aftv5PwbO7b943e8l7zhd4n7reDEIuOnZ3Hx+aqeATXwqjzCy3zZmI0Q/kg7gEfCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=uqseCArS; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5nqyX0KZK158GJm3lGVBHE9gvpDdMPMLQJyr54hQyZE=; b=uqseCArSmKWm1/OcWMqF6RPgIS
	eIdDxgO+lpilmId/rHmxlqhMlNRkClQud7xChzQGZBNjpCjq4zrT5ekPotP9A6y5a+KQ0P2I6e5gJ
	i7IeRU6+i98M3AHrRv4duyjtxd5oR5EhVxtTZi6HhPwvQDgSLTvf0uZZ/6VOiYhGGHVGwWSKG7/PC
	+R/sHg596eW5e6UJmqNQko8MSbxqcuI3vSV/BHf6XYedjLvo5ItX6aHxjkqnU/1r+uhFtjYJX8acH
	i2mOXIpSSzcPdA23v1Wfd1mwiQioEgEHBdjmVWjvsrMAydqiuNJ7BpOt0YIvbmScKsZvqxHNgT2xD
	n9DGi0SQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tcZRT-0000000DoUo-2GUr;
	Tue, 28 Jan 2025 00:26:59 +0000
Date: Tue, 28 Jan 2025 00:26:59 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Sasha Levin <sashal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [git pull] d_revalidate pile
Message-ID: <20250128002659.GJ1977892@ZenIV>
References: <20250127044721.GD1977892@ZenIV>
 <Z5fAOpnFoXMgpCWb@lappy>
 <20250127173634.GF1977892@ZenIV>
 <Z5fyAPnvtNPPF5L3@lappy>
 <20250127213456.GH1977892@ZenIV>
 <20250127224059.GI1977892@ZenIV>
 <Z5gWQnUDMyE5sniC@lappy>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5gWQnUDMyE5sniC@lappy>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jan 27, 2025 at 06:26:58PM -0500, Sasha Levin wrote:
> On Mon, Jan 27, 2025 at 10:40:59PM +0000, Al Viro wrote:
> > On Mon, Jan 27, 2025 at 09:34:56PM +0000, Al Viro wrote:
> > 
> > > If so, then
> > > 	a) it's a false positive (and IIRC, it's not the first time
> > > kfence gets confused by that)
> > > 	b) your bisection will probably converge to bdd9951f60f9
> > > "dissolve external_name.u into separate members" which is where we'd
> > > ended up with offsetof(struct external_name, name) being 4 modulo 8.
> > > 
> > > As a quick test, try to flip the order of head and count in
> > > struct external_name and see if that makes the warning go away.
> > > If it does, I'm pretty certain that theory above is correct.
> > 
> > Not quite...   dentry_string_cmp() assumes that ->d_name.name is
> > word-aligned, so load_unaligned_zeropad() is done only to the
> > second string (the one we compare against).
> 
> Sorry for the silence on my end: this issue doesn't reproduce
> consistently, so I need to do more runs for these tests.

Updated version force-pushed; delta is

diff --git a/fs/dcache.c b/fs/dcache.c
index 695406e48937..903142b324e9 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -295,10 +295,16 @@ static inline int dentry_cmp(const struct dentry *dentry, const unsigned char *c
 	return dentry_string_cmp(cs, ct, tcount);
 }
 
+/*
+ * long names are allocated separately from dentry and never modified.
+ * Refcounted, freeing is RCU-delayed.  See take_dentry_name_snapshot()
+ * for the reason why ->count and ->head can't be combined into a union.
+ * dentry_string_cmp() relies upon ->name[] being word-aligned.
+ */
 struct external_name {
-	struct rcu_head head;	// ->head and ->count can't be combined
-	atomic_t count;		// see take_dentry_name_snapshot()
-	unsigned char name[];
+	atomic_t count;
+	struct rcu_head head;
+	unsigned char name[] __aligned(sizeof(unsigned long));
 };
 
 static inline struct external_name *external_name(struct dentry *dentry)


Could you recheck that one (23e8b451dea4)?  I'll send an update pull request
if nothing wrong shows up.

