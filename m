Return-Path: <linux-fsdevel+bounces-54174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C13ACAFBC8F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 22:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20CB61697AF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 20:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7E621ABA4;
	Mon,  7 Jul 2025 20:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="b/jq0y3R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53CD140E5F;
	Mon,  7 Jul 2025 20:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751920268; cv=none; b=Vjjp7VtGUJyBSbaiVh6jhy0Qpf+pV2IYJIoIt4A9HH+CmP8hGrWnEKbd8EuIZZRW/Iu07sbrWcfmuLztD9pcj3Oq5YE7ZoLl+x3PZgrhObvctIIUFNtzDSuG1iHBQ1qUIaP+krbcwlVjVQ6Ez/emCvVyUFRONNDsItkpYQo5UP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751920268; c=relaxed/simple;
	bh=rcLGs81dEuE2WrY2i4IJDgzSU2LysNj8u+zcb0ZjCRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDqoaqHELjGX8TJULhmyzZjJEzICpMIprSGueIJzlhiknECnUonO/8ZJBDi0O/tL2hc8sIlJntlz4m+uoz6084ihekiQkHj9623RzmQBFQTntjjhNeojO1tpHnF62l6RLDDsTpWDK98NrljEtQayQ7wcPVwVVaBDBEcb7eDzyQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=b/jq0y3R; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TWA6hnzzmpQYsP3KcpmzS787HeWtSRU6ku7pCLKy0Ko=; b=b/jq0y3RqBLieMltlRZZec29Zq
	60xRVxkfzoq6x4+ygQj26eL8V7nrVWVDAjuPZ1pf3EmHAB2jvyUsmvFwHe9E6yP7jxN0sKP3DRrjz
	Yh2I8297EiYhSpV8QkEJyuYEIy1UK35gF8IEZccm2TEULzHgy5ihH2KSqqJ36RhRfULF36XqT11Gb
	pHAXRCGi6wUxIP6Pm5uYD5GI+BFsus+wE5GojyJnOxISrHrgUspgCKNX6nDG3206ZIRyfO5xlOQGU
	AYz7NSrLg1VE6+bSMTyrFJ+ndLgZ9MPi1PVof3M76mI3qRLdvkEL/lXOXc2x/IpZpZ5barQwe1GIt
	sB+oTLcw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYsUS-00000003boR-0BbP;
	Mon, 07 Jul 2025 20:31:04 +0000
Date: Mon, 7 Jul 2025 21:31:04 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 20/21] __dentry_kill(): new locking scheme
Message-ID: <20250707203104.GJ1880847@ZenIV>
References: <20231124060200.GR38156@ZenIV>
 <20231124060422.576198-1-viro@zeniv.linux.org.uk>
 <20231124060422.576198-20-viro@zeniv.linux.org.uk>
 <CAKPOu+_Ktbp5OMZv77UfLRyRaqmK1kUpNHNd1C=J9ihvjWLDZg@mail.gmail.com>
 <20250707172956.GF1880847@ZenIV>
 <CAKPOu+87UytVk_7S4L-y9We710j4Gh8HcacffwG99xUA5eGh7A@mail.gmail.com>
 <20250707180026.GG1880847@ZenIV>
 <CAKPOu+-QzSzUw4q18FsZFR74OJp90rs9X08gDxWnsphfwfwxoQ@mail.gmail.com>
 <20250707193115.GH1880847@ZenIV>
 <CAKPOu+_q7--Yfoko2F2B1WD=rnq94AduevZD1MeFW+ib94-Pxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKPOu+_q7--Yfoko2F2B1WD=rnq94AduevZD1MeFW+ib94-Pxg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jul 07, 2025 at 10:00:38PM +0200, Max Kellermann wrote:

> Sorry Al, I don't get it.
> I understand that objects that are still referenced must not be freed,
> and of course a dentry that has started the process of dying by
> __dentry_kill() needs to remain in the tree, and that its parent must
> not be freed either. Of course!
> 
> But none of this explains why you added this "d_lockref.count<0"
> check, which I doubt is correct because it causes a busy loop, burning
> CPU cycles without doing anything.

Busy loop here means that everything in the tree is either busy or already
in process of being torn down *by* *another* *thread*.  And that's already
in process - not just selected for it (see collect2 in the same loop).

What *can* we do in that case?  On the level of shrink_dcache_parent(), that
is.  Ignore that these suckers are there?  Fine, but that means we are failing
to evict the stuff that has no busy descendents.

The interesting question is what the other thread is doing...

