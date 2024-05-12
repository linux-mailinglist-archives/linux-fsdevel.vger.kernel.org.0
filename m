Return-Path: <linux-fsdevel+bounces-19350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E44898C3726
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 May 2024 17:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D62561C208E9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 May 2024 15:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4684120B;
	Sun, 12 May 2024 15:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="mdzge4DR";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="mdzge4DR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538FB26AF5
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 May 2024 15:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715528750; cv=none; b=H+TMTI5fYAq7q3aA/jkC6J/+8x4PtLLG4l0NyzbcTGrKR69nFaYWAJT7tgg2uuIyuL/ZyCv4Ycv40D4gGShT/BNrmSWKGZlGfIA6v9W/RrCDUo8pzgz6Nh9V6GPUreXbdtrzt4jpLperHPDWHroygMz6s07yF2K5hYYMOviAA1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715528750; c=relaxed/simple;
	bh=LpJBs4r0o8CDOQLOIWirpbCl/N8xfuQxPp5O4LbqbPQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QlQFp12WfS+a7uLvvygjH9e585hDeK2+4+ZLzQ1O6dOHtUbmDCb/h/jQvyyiLTuftbbnwSQW7QYxsong2aTSUjE6oh3XxfeVLKcHaJ3xL0EZ0bxD0jYHFiAcdlZ7xm68YX+7qcYR4aqmRHZZ6nAJ1YMgyIQtJ3sGj0gfWvUtz+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=mdzge4DR; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=mdzge4DR; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1715528747;
	bh=LpJBs4r0o8CDOQLOIWirpbCl/N8xfuQxPp5O4LbqbPQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=mdzge4DRowlYxIaqgqT4p3wM28zFshCsyJh9ko8lzoVdaBf/CAvWgxulOK///9njY
	 PsioDfsJI/3EfhgFga3TAoL51V0j1zAqGO0fJ28Ra5xTVAdhL19sbyD1UYkoF2dxwY
	 Mh4XpCBXF7E8gqEWgqubUEvEQcyS1tT4OzXpFMDw=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 4907F1280EBD;
	Sun, 12 May 2024 11:45:47 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id o5BlQa29LmoL; Sun, 12 May 2024 11:45:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1715528747;
	bh=LpJBs4r0o8CDOQLOIWirpbCl/N8xfuQxPp5O4LbqbPQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=mdzge4DRowlYxIaqgqT4p3wM28zFshCsyJh9ko8lzoVdaBf/CAvWgxulOK///9njY
	 PsioDfsJI/3EfhgFga3TAoL51V0j1zAqGO0fJ28Ra5xTVAdhL19sbyD1UYkoF2dxwY
	 Mh4XpCBXF7E8gqEWgqubUEvEQcyS1tT4OzXpFMDw=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 3A81A1280DA8;
	Sun, 12 May 2024 11:45:46 -0400 (EDT)
Message-ID: <a4320c051be326ddeaeba44c4d209ccf7c2a3502.camel@HansenPartnership.com>
Subject: Re: [PATCH] vfs: move dentry shrinking outside the inode lock in
 'rmdir()'
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds
	 <torvalds@linux-foundation.org>
Cc: brauner@kernel.org, jack@suse.cz, laoar.shao@gmail.com, 
	linux-fsdevel@vger.kernel.org, longman@redhat.com, walters@verbum.org, 
	wangkai86@huawei.com, willy@infradead.org
Date: Sun, 12 May 2024 11:45:44 -0400
In-Reply-To: <20240511192824.GC2118490@ZenIV>
References: 
	<CAHk-=whvo+r-VZH7Myr9fid=zspMo2-0BUJw5S=VTm72iEXXvQ@mail.gmail.com>
	 <20240511182625.6717-2-torvalds@linux-foundation.org>
	 <CAHk-=wijTRY-72qm02kZAT_Ttua0Qwvfms5m5NbR4EWbS02NqA@mail.gmail.com>
	 <20240511192824.GC2118490@ZenIV>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Sat, 2024-05-11 at 20:28 +0100, Al Viro wrote:
> On Sat, May 11, 2024 at 11:42:34AM -0700, Linus Torvalds wrote:
> 
> > so we have another level of locking going on, and my patch only
> > moved
> > the dcache pruning outside the lock of the directory we're removing
> > (not outside the lock of the directory that contains the removed
> > directory).
> > 
> > And that outside lock is the much more important one, I bet.
> 
> ... and _that_ is where taking d_delete outside of the lock might
> take an unpleasant analysis of a lot of code.

Couldn't you obviate this by doing it from a workqueue?  Even if the
directory is recreated, the chances are most of the negative dentries
that were under it will still exist and be removable by the time the
workqueue runs.

James


