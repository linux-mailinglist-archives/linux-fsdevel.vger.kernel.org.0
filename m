Return-Path: <linux-fsdevel+bounces-20565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6788D522C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 21:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 180D41C239DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 19:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6490D7EF09;
	Thu, 30 May 2024 19:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="wO80Z9JT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577D37C6D5;
	Thu, 30 May 2024 19:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717096626; cv=none; b=IwzJW+fd+uhE5kNfsL2paDgAV/7X69UteQWjw/9huyaYPaMfHAfttfZrkakJSg6Mb3xbpQjLkY5XSThqK7Bnzyib4DJZ+GknaVN3SOLgeJUhwGk5GLIi3z/s9JHwGOYtyeG3nMc7RQTjEhqwOHBUk3PgaSfqGjvsZp3yAbwNntI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717096626; c=relaxed/simple;
	bh=x633Xo1sPJ/fWXz66nCdmoq39u/bEbd6iBe4RlJ3CZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=owfkQFvRXgAEOmLVYRE1aaUMn4/cvMbo17bH1tvEJF0Ym3QjwHTShYJMh3VcIDmWR/CpTOeGDNFOxMMvVfgYe7TpgZ2gwB+cDaf8l+RL76KaadS+98OwlZMHTWNK2i0e3s9oxiF2Oz5pXgV0Cc+lqQhOQMuJpnMajGPEPkN4l5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=wO80Z9JT; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lfx+tTR93fLZk+8tmXgXmXPxooSXIgmr48RKZPv6Tx8=; b=wO80Z9JTrWaFPPaW5/fAiO+04F
	BToKUsjARfJGAANPPESgc4Urtp+BdaJ42vrqQk/a15MbHLGOqiC+fVpq/V1PstuRp5EF6QKr+lT2Q
	R/91OnQ3slwCNyIO6YITdTReRNyjQlwPCHs/hdUUjY99jrEq9AZJyHjonKPYT5nk918UdT+AZNPSx
	LlENIvWRW1+gT6t0cTJC1OrcuivS7Up9UuLgJvolGY6ZX0uOpmX1KiXOOBXSEIeFZKJNAUgJFehaR
	jPl1uBsGeYn4+Ug7PskSxbcbB93JbCbveUiECqN9PgcNjtSHljt2oj4JP/A0VFrNSjvcf3Rm2aheD
	CWa0ybhQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <ema@debian.org>)
	id 1sClGN-003Mdp-CQ; Thu, 30 May 2024 19:16:36 +0000
Date: Thu, 30 May 2024 21:16:32 +0200
From: Emanuele Rocca <ema@debian.org>
To: David Howells <dhowells@redhat.com>
Cc: Andrea Righi <andrea.righi@canonical.com>,
	Jeff Layton <jlayton@kernel.org>, Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Christian Brauner <christian@brauner.io>,
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
	v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Luca Boccassi <bluca@debian.org>
Subject: Re: [PATCH v5 40/40] 9p: Use netfslib read/write_iter
Message-ID: <ZljQkJqTMhD8c_0l@ariel.home>
References: <Zj0ErxVBE3DYT2Ea@gpd>
 <20231221132400.1601991-1-dhowells@redhat.com>
 <20231221132400.1601991-41-dhowells@redhat.com>
 <531994.1716450257@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <531994.1716450257@warthog.procyon.org.uk>
X-Debian-User: ema

Hi David,

On 2024-05-23 08:44, David Howells wrote:
> In https://bugs.launchpad.net/ubuntu/+source/autopkgtest/+bug/2056461 you say:
> 
> | It seems that kernel 6.8 introduced a regression in the 9pfs related to
> | caching and netfslib, that can cause some user-space apps to read content
> | from files that is not up-to-date (when they are used in a producer/consumer
> | fashion).
> 
> Can you clarify how these files are being used?

I don't know the details of the 9pfs operations involved, but still I
wanted to mention that to reliably reproduce the issue on a Debian
system one can run:

 autopkgtest-build-qemu unstable /tmp/sid.img
 autopkgtest -ddd -B dpdk -- autopkgtest-virt-qemu --debug --show-boot /tmp/sid.img

If the kernel installed in the guest VM is affected by this problem,
after a while the test hangs with something like:

 autopkgtest-virt-qemu: DBG: executing copydown /tmp/alog/tests-tree/ /tmp/autopkgtest.uG6tsJ/build.6QA/src/
 [...]
 autopkgtest-virt-qemu: DBG:  +>?

Full logs at https://people.debian.org/~ema/1072004-6.10-rc1.log

Part of the code mounting the 9pfs in case it helps is at:
https://salsa.debian.org/ci-team/autopkgtest/-/blob/master/virt/autopkgtest-virt-qemu#L290

I could reproduce the issue with both 6.9.2 and 6.10-rc1.

