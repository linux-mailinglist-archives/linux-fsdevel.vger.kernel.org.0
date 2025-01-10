Return-Path: <linux-fsdevel+bounces-38884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96738A09742
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 17:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 730527A0374
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 16:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED834213233;
	Fri, 10 Jan 2025 16:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="UycWsP7X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F12211293;
	Fri, 10 Jan 2025 16:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736526303; cv=none; b=ZapT+j4c4AF/W2/5kSVGxfnLJEmpHxS8XaBDEs0C0c7e0/7RNMZPqi2fCAihWrxZTgCXRd7X3I0Zyv5Q3k+HMslqQo2O55ZWNxKU/mfggUpVm31Zr6Fxeo1XxfLftGSodUzr2WWv0B/dbKgUEXTX7cGFFoDPqPdA2vEpv7L9Hp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736526303; c=relaxed/simple;
	bh=x2WD5AONv/eNiPs8X3iMErRMhbnhjNePWMgmqYN7BJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUhuhi6UQjuiko7eHFdLCRF52bjNY91UD1jHk3ZgvWVITY0sj7y3n3Lzf5hyOuQg0MhjSUsoMtfdSWcsDJCNAyGqWg+aJH7NhWNPHNSGzmLzdiHE0k6LiRsiiUWklXu9AEvVqr6OODgYQvTnOuPKOJpI24ekl0kmWiGU3KM7tPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=UycWsP7X; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=x2WD5AONv/eNiPs8X3iMErRMhbnhjNePWMgmqYN7BJI=; b=UycWsP7X9ycNqZLbYgOrBFnuln
	nnwRP6KR5KOeICR2voKH946ZhldsZZ4i1yJxVobzZECPic/yYv4+7P46g98ZC7EInqiBcJph8xlGx
	m2NLgjJcLI9YVqRpTOdt81vGt6TTeIY89pbLyo37BaF2gDgPso8TQlxML6zcG61ul3dHQd+4LE07M
	+1no8UscNJrnp4JVUi5L2xwwPIvx3twlhWUT42OuJCru8elLnWTCD8llrsC2n7VJKafq+3nYQN/QO
	VTNZPxa6kOJnaVcyaMXtBXI3yWTJ6KJqxbogtvjp3MkiR3tOt2q19TAEdaQT7QW5Bjwhu5wE5Yaeo
	d27Oj6TA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tWHof-000000002cK-0psH;
	Fri, 10 Jan 2025 16:24:57 +0000
Date: Fri, 10 Jan 2025 16:24:57 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, agruenba@redhat.com, amir73il@gmail.com,
	brauner@kernel.org, ceph-devel@vger.kernel.org, dhowells@redhat.com,
	hubcap@omnibond.com, krisman@kernel.org, linux-nfs@vger.kernel.org,
	miklos@szeredi.hu, torvalds@linux-foundation.org
Subject: Re: [PATCH 02/20] dcache: back inline names with a struct-wrapped
 array of unsigned long
Message-ID: <20250110162457.GV1977892@ZenIV>
References: <20250110023854.GS1977892@ZenIV>
 <20250110024303.4157645-1-viro@zeniv.linux.org.uk>
 <20250110024303.4157645-2-viro@zeniv.linux.org.uk>
 <4mqzkypsznfnkohe5yqz57p5sz5y4x6ftdsgiylbbf6jsu63qm@krbsv3jwdn4w>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4mqzkypsznfnkohe5yqz57p5sz5y4x6ftdsgiylbbf6jsu63qm@krbsv3jwdn4w>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Jan 10, 2025 at 10:35:14AM +0100, Jan Kara wrote:

> I was thinking for a while whether if you now always copy 40 bytes instead
> of only d_name.len bytes cannot have any adverse performance effects
> (additional cacheline fetched / dirtied) but I don't think any path copying
> the name is that performance critical to matter if it would be noticeable
> at all.

FWIW, I'd expect it to be a slight win overall; we'll see if profiling shows
otherwise, but...

