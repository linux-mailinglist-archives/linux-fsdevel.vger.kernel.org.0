Return-Path: <linux-fsdevel+bounces-62684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 390D8B9CEAE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 02:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6197425209
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 00:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19B92D7DD9;
	Thu, 25 Sep 2025 00:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="W2zE/TUO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0065D611E;
	Thu, 25 Sep 2025 00:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758761251; cv=none; b=u5yRmZmE6AKP2/tR96ImLuSoICAuPbHhexn5N48JmuO4a1H+nKoTzzAzgrILEAXheA6bysAUl/+zmTr0RBlYErmBmrIz1MFGZUZ4j1sB2sB6v7PPyU2dpqmgI+sV2n31LkO8PNlbDLsgWz740eBf6t7xEjUUuOM4pcr/jxg/nPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758761251; c=relaxed/simple;
	bh=yEwV09NDtaE93KUCFXI6xpyqPWF0GuL/8bZIz/Fln3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUCHZ55Is5DQza4tGrivFFfLy2zGcLUOmoNwrbxcApqDyJ0+UjGhRyJE498KLKqZX9HJPG1ooy9GfnHdFHMhHPV/KYG9UA5gFO3vXy8IMMGZB+fhclpM+xRCN6/4hRp1nzl7uGycds+k06nOvlO5ZGy/OZU1WDfoXF3lo6X4CWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=W2zE/TUO; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AC6XlsnZJVOt1mCgqHq8pxy2hpx1UvE8p0/ZlamtBJI=; b=W2zE/TUOcNBI6+2Y21Cvbra1In
	daGcXih7b/P0E0/MpxNazS6Nl3BdI1PMj916fSVGmT44PzE4s75pxQAbYlWVDHlTQ5xMIlPozrbVD
	zmiSuRce927hoV1bVjp7txBYPcWLeiGgFZ80LN01tlDN9YM2+lhgu017rLus10gD7z2KSS1xbFPnf
	ZM/VXOMIVPe1+qW+HsXbUvo6JiJE8VLdJqyeigeVJvujWH1b1eLdhLvgSXzs+5AUWxiYxmPgkZ5Ao
	B03uDNVfU95byeEarqvneOLlxrTCqUZDmJwM+AdKkssUoRXj/86P64RDKYNf/BonW8TCgYH+dMTUl
	O/P4X6Fw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1a8r-0000000EMQk-0jhQ;
	Thu, 25 Sep 2025 00:47:25 +0000
Date: Thu, 25 Sep 2025 01:47:25 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: David Windsor <dwindsor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	kpsingh@kernel.org, john.fastabend@gmail.com, brauner@kernel.org,
	jack@suse.cz, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: Add dentry kfuncs for BPF LSM programs
Message-ID: <20250925004725.GY39973@ZenIV>
References: <20250924232434.74761-1-dwindsor@gmail.com>
 <20250924232434.74761-2-dwindsor@gmail.com>
 <20250924235518.GW39973@ZenIV>
 <CAEXv5_jveHxe9sT3BcQAuXEVjrXqiRpMvi6qyRv32oHXOq4M7g@mail.gmail.com>
 <20250925002901.GX39973@ZenIV>
 <CAEXv5_hEXggxe5EwSHV8SK21e6HNmfYFSE9kx=ojwEobtTTGLA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXv5_hEXggxe5EwSHV8SK21e6HNmfYFSE9kx=ojwEobtTTGLA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Sep 24, 2025 at 08:44:24PM -0400, David Windsor wrote:

> > You can safely clone and retain file references.  You can't do that
> > to dentries unless you are guaranteed an active reference to superblock
> > to stay around for as long as you are retaining those.  Note that
> > LSM hooks might be called with ->s_umount held by caller, so the locking
> > environment for superblocks depends upon the hook in question.
> 
> Yeah good point about ->s_umount, why don't we just create a new "safe
> dentry hooks" BTF ID set and restrict this to those and filter in
> bpf_fs_kfuncs_filter, where there's existing filtering going on
> anyway?

Again, you can't just call dget(), stash the reference into a map and move
on.  That's asking for UAF.

