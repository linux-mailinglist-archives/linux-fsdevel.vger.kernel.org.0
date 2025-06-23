Return-Path: <linux-fsdevel+bounces-52609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97032AE481A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 17:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D754D1883955
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 15:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07570279DA1;
	Mon, 23 Jun 2025 15:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="jbbETsmy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598D7275B14
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 15:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750691406; cv=none; b=c6HdhIlD61XgIDTrPJGnRD0DWcIC72p72niKc1YZdeWEbD9WCzUPQap0My1qFdBvc6WuorlM6LjQeaFDsppZyEeHPo4Sr4Xyr24S0erpMItGpVEx7um7IK1QpFdpvDo1+gEwJeIWg+KhuiIZmtLHc2gBUMxwNdDkJhKqMMBZPfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750691406; c=relaxed/simple;
	bh=IcG+IpMJllgXMJjl/ntTuR4ykQn4z3PLpduYBm6PHsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=frNycceANYBo4AwotHH0Rc6M4TnxoGxt44F03oUwwVU0mx5Kk13mTvFhkk3s7EHRFa7BEF+l6BCBtcM0XJzyyem/2+XxbSEMI3rX90zYNbuWG3PfT2MC2sEinPzvZE/2A8ZfOUwInEM5jH5N5UeJT3pz6RiELZYhJ4GWMYLHS/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=jbbETsmy; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GCJSNYdWXHU0qHSklrZcKyfSiu+BoCRn/gSoevjgfFw=; b=jbbETsmyL/PNaJZvLooAMYx3Yj
	uNnTIsdfX9FjsrAiJ6JXFooDFRIAUjEUqQGgQYWk/Jn3Nd7SG90cJ4zbUKwF+jlZixzTmkMnUJIuP
	Eu/7KvMdrzKsaZj3msGKvGj1+HGCXO/x677b7HU31P6HjIsBardjiAZQIEtLX5W0av+fOlLxIr7o2
	4QKkQca+AzGN/j9jMjeOqq7bsyAv5xmwh75eEvNcIRGN8bOQWlKvmgPCjDlkAIBEj4ZUaiNO2cfg5
	3L9qlz20xx/j5Ob+hVOQL0zE1Y0L1UXA6xBYq9usYwoBUBYj3yIdpo1TNypI9a2FPZwxVNR0ihNKq
	Tz5sK93g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTio6-0000000DEnZ-0Ys7;
	Mon, 23 Jun 2025 15:10:02 +0000
Date: Mon, 23 Jun 2025 16:10:02 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org, ebiederm@xmission.com, jack@suse.cz,
	torvalds@linux-foundation.org
Subject: Re: [PATCH v2 01/35] replace
 collect_mounts()/drop_collected_mounts() with a safer variant
Message-ID: <20250623151002.GD1880847@ZenIV>
References: <20250623044912.GA1248894@ZenIV>
 <20250623045428.1271612-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623045428.1271612-1-viro@zeniv.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jun 23, 2025 at 05:53:54AM +0100, Al Viro wrote:
> @@ -828,16 +832,16 @@ int audit_add_tree_rule(struct audit_krule *rule)
>  	err = kern_path(tree->pathname, 0, &path);
>  	if (err)
>  		goto Err;
> -	mnt = collect_mounts(&path);
> +	paths = collect_paths(paths, array, 16);

that would be
	paths = collect_paths(&path, array, 16);
of course.  Kudos to venkat88@linux.ibm.com for spotting the breakage.

Al, off to find out what's wrong with his local audit-related tests...

