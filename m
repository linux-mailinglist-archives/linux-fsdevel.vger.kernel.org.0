Return-Path: <linux-fsdevel+bounces-24874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F1F945F52
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 16:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7CE31F22534
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 14:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1290E200103;
	Fri,  2 Aug 2024 14:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="KVe9EX5+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDA41EA0D4;
	Fri,  2 Aug 2024 14:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722608574; cv=none; b=rcAUWnp5UBpXHJ0S1S8t03kdhqO0y9cHBDC9Kb4iIS2mlsc3NFuaGMco7j31WUGx0aj5BVPSSpR2eh2wwRkJsxGA6KvdfFvNfkDHL6iHBkiMquCSHk0WqLYvCsedji5lpNI7kgOMfoI3HVMEeXeofXl5fIgoKWlEUYNXCpkpqss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722608574; c=relaxed/simple;
	bh=//QlMkTn01GLjDeouHHA3hn+2ap1YGLpk+Nya1PPFLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yt2OxYZgv7ZXf41UalbfMqo2IBwlgYbnVGWrSZGwnrkZtpARsRMgBRV8OgaJ2s8xOscjfmNaxgphJ26mUUn8pxQW5OTc6yqSRWlhfLYaU6FMaNE3I7cTtn47+WVYLjSRnK1fqxTzK2qdL+vjjGmZSMlwU0BVItSErgTL3laV1OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=KVe9EX5+; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZW0g3mWIZpvqniUnRxNDMW6TbHMHfQAYMOpGWjEw3Ew=; b=KVe9EX5+rFET2/hmrbb0aqwGTK
	bixHj5LSTnYC7sTcvKEtyNuXL+V8amIKj29b3XAyZv/Lq59hSAfLPSqeWHNIMhWYk5Z+RwCgYwK9V
	N9R8sIRYRVyA226xOb4H5uufMB1wiCrNFbOqyTzAZ8VZCYceLctW2LDU1U9M3RrQSVMJKkt0MubMc
	BK1gZV9PSSbrBJ9FXXh8eK1aUcdJ0xmL1ydnEVQ9D9HbukNrJocz6SP47fU8Y4Bd1WJ7D4v2TMjs+
	ZK6uvqv9KvBEsEkzoVWZtJBRenTnYyuqnjQwlDZElmnrQOaRG+hEbFRWnY0xzwEFZQodtz6q3nfxh
	ilozdApA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sZtBA-000000017m6-3WUv;
	Fri, 02 Aug 2024 14:22:48 +0000
Date: Fri, 2 Aug 2024 15:22:48 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: jack@suse.cz, mjguzik@gmail.com, edumazet@google.com,
	Yu Ma <yu.ma@intel.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, pan.deng@intel.com,
	tianyou.li@intel.com, tim.c.chen@intel.com,
	tim.c.chen@linux.intel.com
Subject: Re: [PATCH v5 0/3] fs/file.c: optimize the critical section of
 file_lock in
Message-ID: <20240802142248.GV5334@ZenIV>
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240717145018.3972922-1-yu.ma@intel.com>
 <20240722-geliebt-feiern-9b2ab7126d85@brauner>
 <20240801191304.GR5334@ZenIV>
 <20240802-bewachsen-einpacken-343b843869f9@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802-bewachsen-einpacken-343b843869f9@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Aug 02, 2024 at 01:04:44PM +0200, Christian Brauner wrote:
> > Hmm...   Something fishy's going on - those are not reachable by any branches.
> 
> Hm, they probably got dropped when rebasing to v6.11-rc1 and I did have
> to play around with --onto.
> 
> > I'm putting together (in viro/vfs.git) a branch for that area (#work.fdtable)
> > and I'm going to apply those 3 unless anyone objects.
> 
> Fine since they aren't in that branch. Otherwise I generally prefer to
> just merge a common branch.

If it's going to be rebased anyway, I don't see much difference from cherry-pick,
TBH...

