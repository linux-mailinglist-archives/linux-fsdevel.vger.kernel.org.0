Return-Path: <linux-fsdevel+bounces-54157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F32AFBA4E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 20:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE3D44238B5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 18:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D35265CB2;
	Mon,  7 Jul 2025 18:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="BdajhZKA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A9C264FB2;
	Mon,  7 Jul 2025 18:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751911230; cv=none; b=X03i6FgNTo/T9mEkEiqfEw1gG6uiKd1WX5czginakndZeWamnpdjpBMdunO5t/4WbuHLs0l263FMNbIA+PjgISBqrT8qGNW0vbBzHTJ8YUdhA5sO4fZ+qgnX060m9sLBZz/aY/o+HoOdwS7Ux4/zLFczCnFbh8qx/VFIUi5T1Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751911230; c=relaxed/simple;
	bh=IJlej6bFxqmOWhIrUSN+OTYs3M8M3bHX9lCLeJ3SakQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uj0usnmwbWYSFvMKAPs3OHK87kPntCL2gaRigoJ4w/DTDiM2Mqb9CTs2MRqBf+xDG7mD/qiSf/5PaFpVTuEV1PltLSK9kG5ejY8yZSoPxC4uBXD4WyDZa8L1/5vHIbl/qVL536ANEx/0fao2E5WAo679YsQjHmeE+6FfCpM6wdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=BdajhZKA; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=BJMAnP/OJ20cQm1N37HmoRe7VUH3vwYgANcHp/tZA6I=; b=BdajhZKARWG0LYaF6VcdeArSTl
	v8o5YQRpMDkTe9WkBAbATmJbmnpf8Q7X09zNk2Dd9/goFqDFD/mPu90jNCQDdXUg0y+btJzGDiQUx
	1lXeo7lqFVw6X4S44HzYZkUB4PSFpS52tQdm0r/7ROb01dy4d6/QKqRjeHsGAe9y/HMYEmp5w3Ll8
	y8PKMyLMDjDEgbYwWVdpMxPghefWlQiN094SakcoExDb3Lt6ts6CBeXw4kmzqrwZ7tPGgsspjzxeF
	6AZmJRnbfciq16LLS+36xmNVXDRNe52pnoY40eJ1+Sf9m7XGM/qST7IaZl4FF7dS03N7/cKQC1onT
	K8zEZ0Kg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYq8g-00000002dXz-1k6X;
	Mon, 07 Jul 2025 18:00:26 +0000
Date: Mon, 7 Jul 2025 19:00:26 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 20/21] __dentry_kill(): new locking scheme
Message-ID: <20250707180026.GG1880847@ZenIV>
References: <20231124060200.GR38156@ZenIV>
 <20231124060422.576198-1-viro@zeniv.linux.org.uk>
 <20231124060422.576198-20-viro@zeniv.linux.org.uk>
 <CAKPOu+_Ktbp5OMZv77UfLRyRaqmK1kUpNHNd1C=J9ihvjWLDZg@mail.gmail.com>
 <20250707172956.GF1880847@ZenIV>
 <CAKPOu+87UytVk_7S4L-y9We710j4Gh8HcacffwG99xUA5eGh7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKPOu+87UytVk_7S4L-y9We710j4Gh8HcacffwG99xUA5eGh7A@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jul 07, 2025 at 07:43:49PM +0200, Max Kellermann wrote:
> On Mon, Jul 7, 2025 at 7:29 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > > (It checks for "dead" or "killed" entries, but why aren't you using
> > > __lockref_is_dead() here?)
> >
> > What's the difference?  It checks for dentries currently still going through
> > ->d_prune()/->d_iput()/->d_release().
> 
> Just clarity. There exists a function and using it would make clearer
> what you're really checking for.
> 
> > What are you using shrink_dcache_parent() for?
> 
> I don't. It's called by Ceph code, i.e. send_mds_reconnect(). A broken
> Ceph-MDS connection apparently triggered this busy loop.
> 
> (I'm not a Ceph developer. I just care for the monthly Ceph regression
> that breaks all of our web servers on each and every Linux kernel
> update. Sad story. However, the Ceph bug I'm really hunting is
> unrelated to this dcache busy loop.)

Well, it tries to evict all non-busy dentries, along with the ones that
are only busy due to (non-busy) children, etc.  It's the latter part
that gets you into the fun with iput() on children...  You'll need to
ask ceph folks about what they really want there - I'm not familiar
enough with ceph guts to tell it with any confidence.

