Return-Path: <linux-fsdevel+bounces-61091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 820D5B55266
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 16:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31DB9AA21B1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 14:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7074D30F54D;
	Fri, 12 Sep 2025 14:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmPCb6zU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD80A30E0D1
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 14:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757688842; cv=none; b=oO+rMJGzpmmBcFjaRFJgGNSg2E31j8YukC3oeqLQe7YcrNe8IoQds3AIqQdfBQfY5T77PV6XTTwPpaS4wdlCtXXV5Rcg+kuNuZoyPHkaakE7SEj/EOZHTR1fDK9mUXsEdXWXxqeM7o2rORNqyDkkVkmVdeW8xg4spIDBQOBM6oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757688842; c=relaxed/simple;
	bh=tgVvw1fcSkgV7iX6dppFrm1JS+4qRocSQEYTYMd2y8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POGg1W5EGk1ftKPotcg9PV0wzzTl07cNx5WNa7DWzrYanAxMoQHIArbwDPmIqfijJV9hx4D7MNTBYMZQChtpfZKaO5TfB8Soa9lb11Ea/Jy0ifBsZOIVkWiZJFEEHtw1/7boUInA511wPIPdhuP6iVzxFBwxVp050ETAusbsm90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmPCb6zU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56BEAC4CEF1;
	Fri, 12 Sep 2025 14:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757688842;
	bh=tgVvw1fcSkgV7iX6dppFrm1JS+4qRocSQEYTYMd2y8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HmPCb6zUwQIxYoogDNkc0cYKlnMzdVNXim6hMe2LfaknB+yvJoA1LY6Q/icTeyJsv
	 tGtjdjZy6RzeaNJqIBJ/ioBLLaRocMD/bShlZ9S5pi1LEXzpiLJDJaq8V/oeLTI/Hb
	 4SKPD1jNtfUlhw0HhaePn5mu6/aG3X2NThZNVbmKT0cvNAY2xeI0fWt97hkCYVN8dR
	 AqMwsP12uMxSlsNycrk7X6DgdJHk5XILWqCqoEq1be2i8Vq6D3PiNiKznSXvl/+QnH
	 81ZKhqPoWT2oJ3hmEn9ZtzRAs0zHy43ofV94OQxke6vz2GtcYIU0PxG50+dj0ltaAU
	 uJAWGIP7fgrWw==
Date: Fri, 12 Sep 2025 07:54:01 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
	linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Subject: Re: [PATCH 02/23] fuse: implement the basic iomap mechanisms
Message-ID: <20250912145401.GP8117@frogsfrogsfrogs>
References: <175573708972.17510.972367243402147687.stgit@frogsfrogsfrogs>
 <175573709157.17510.2779775194786047472.stgit@frogsfrogsfrogs>
 <CAJfpegsUhKYLeWXML+V9G+QLVq3T+YbcwL-qrNDESnT4JzOmcg@mail.gmail.com>
 <20250904144521.GY1587915@frogsfrogsfrogs>
 <CAJfpeguoMuRH3Q4QEiBLHkWPghFH+XVVUuRWBa3FCkORoFdXGQ@mail.gmail.com>
 <20250905015029.GC1587915@frogsfrogsfrogs>
 <20250911214527.GG1587915@frogsfrogsfrogs>
 <CAJfpegtenngnA2OxBmGTi1f2eFRq0Lvdv2ScM53mvd4vPwu-PA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtenngnA2OxBmGTi1f2eFRq0Lvdv2ScM53mvd4vPwu-PA@mail.gmail.com>

On Fri, Sep 12, 2025 at 03:28:17PM +0200, Miklos Szeredi wrote:
> On Thu, 11 Sept 2025 at 23:45, Darrick J. Wong <djwong@kernel.org> wrote:
> 
> > So I think the third approach is the way to go, but I'd like your input
> > before I commit to a particular approach.
> 
> Okay.
> 
> I'm not going to rant against tracepoints, because I'm sure you have a
> good reason to bear the pain of dealing with them.  I'd just like to
> minimise the pain for myself and other reviewers.  If I can just
> ignore clearly marked tracing patches, that seems good enough.

Ah, ok.  Knowing your motivation helps me a lot, thanks for letting me
know.  I'll keep the tracing code as separate as possible, then.

<begin rant>
FYI: I don't like the way tracepoints are composed either.  Nested C
preprocessor macros are both too clever and require too much cleverness
for my taste, but I'm addicted to tracing data flows, so I'm stuck with
their current pain until someone makes it as easy as:

trace_fuse_iomap_begin(const struct inode *inode, loff_t pos,
		       loff_t count, const struct iomap *iomap) =>
	"{inode->ino} {pos} {count} {iomap->offset}..."

and have it generate the necessary data structures and trace printk
strings from that.  But you can only do such things if macros can
perform AST transformations in the compiler, and /that/ wasn't around in
1969. :(
<end rant>

--D

> Thanks,
> Miklos

