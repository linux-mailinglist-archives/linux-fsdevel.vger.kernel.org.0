Return-Path: <linux-fsdevel+bounces-36734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6879E8C99
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 08:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B92981881BBF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 07:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8D9215068;
	Mon,  9 Dec 2024 07:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kFdV293R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E800214A64;
	Mon,  9 Dec 2024 07:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733730596; cv=none; b=DAUwyotUOX2b99dFGiIC9M3trF/Gr4qV9qMs/UAQ8ZD1W5Xq+MjuxryS38dCQeNXi9SEAsnXU9EPlIC9zRNz00mM+p2QPzGwi3KNIRGi7V3yC1hR/Cqm36fGE2jGH6BKpTCvMox9tEJWwuNX0+X/RCS6BGi3qaeMbLRsj89Ukhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733730596; c=relaxed/simple;
	bh=5EFS2InPg2t3NJWSEh6nQPiSR6HZgWxCXmJAgXABqHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khurs/AJwDcter3w/t164ocuRJxp15nFof7a/veymZYPg09i714dTrvzIN0gxdR7EAyk5Rt3M2wzxZe+1zBC8FzfwDydXUvJDyuZ+jXiAMI9HHxm/BqRCrAcLCA6QeMeSapmRhvGCpCI1b4rX9gGhK0AmdswWigkOcDfK8Xfw44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kFdV293R; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OmWUSu3bZ9nMiHmrTjQz9XT/WaHo0p18xXNKxBDgGoo=; b=kFdV293Ri3XsiETHw6qp1L/ven
	tu0zlgZxqg2itd3JpxhPBppLYWVfJk0TptPfu3jDrslxYrX7ElP1ehMdRlSkXKDyHu3mG2JWIudTo
	N6s8D81wUhcbMVjHZOq9fIwVGQy5+BiMoD4oGPcV6b5ucHWiq59GqHanTXjkm6+Znbt0/7lW6qcyF
	zgS/fjXH5vc+yJD3N21jr3/LkbDilbaRlKjG3rrYK+Yl5vJJOe4uKHJDb4fkK7ftlJyqnZbgGX+nu
	CCGWmEnwd4M5KOryK5MgMLiX3nAQWd7TSum6MI02vEfT+9hfhlx5qChqPb9PDknw9Ox45r5zTH5e6
	69XYPHxg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tKYWV-00000006mEI-2tYU;
	Mon, 09 Dec 2024 07:49:43 +0000
Date: Sun, 8 Dec 2024 23:49:43 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Erin Shepherd <erin.shepherd@e43.eu>,
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
	stable <stable@kernel.org>
Subject: Re: [PATCH 0/4] exportfs: add flag to allow marking export
 operations as only supporting file handles
Message-ID: <Z1ahFxFtksuThilS@infradead.org>
References: <20241201-work-exportfs-v1-0-b850dda4502a@kernel.org>
 <Z1D2BE2S6FLJ0tTk@infradead.org>
 <CAOQ4uxjPSmrvy44AdahKjzFOcydKN8t=xBnS_bhV-vC+UBdPUg@mail.gmail.com>
 <20241206160358.GC7820@frogsfrogsfrogs>
 <CAOQ4uxgzWZ_X8S6dnWSwU=o5QKR_azq=5fe2Qw8gavLuTOy7Aw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgzWZ_X8S6dnWSwU=o5QKR_azq=5fe2Qw8gavLuTOy7Aw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Dec 07, 2024 at 09:49:02AM +0100, Amir Goldstein wrote:
> > /* file handles can be used by a process on another node */
> > #define EXPORT_OP_ALLOW_REMOTE_NODES    (...)
> 
> This has a sound of security which is incorrect IMO.
> The fact that we block nfsd export of cgroups does not prevent
> any type of userland file server from exporting cgroup file handles.

So what is the purpose of the flag?  Asking for a coherent name and
description was the other bigger ask for me.

> Maybe opt-out of nfsd export is a little less safer than opt-in, but
> 1. opt-out is and will remain the rare exception for export_operations
> 2. at least the flag name EXPORT_OP_LOCAL_FILE_HANDLE
>     is pretty clear IMO

Even after this thread I have absolutely no idea what problem it tries
to solve.  Maybe that's not just the flag names fault, and not of opt-in
vs out, but both certainly don't help.

> Plus, as I wrote in another email, the fact that pidfs is SB_NOUSER,
> so userspace is not allowed to mount it into the namespace and
> userland file servers cannot export the filesystem itself.
> That property itself (SB_NOUSER), is therefore a good enough indication
> to deny nfsd export of this fs.

So check SB_NOUSER in nfsd and be done with it?


