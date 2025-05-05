Return-Path: <linux-fsdevel+bounces-48076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24261AA9429
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 15:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 267967A5D83
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 13:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A782566D5;
	Mon,  5 May 2025 13:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhvkX1td"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1C0204689;
	Mon,  5 May 2025 13:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746450881; cv=none; b=buA3dg0JtjzFvbCUGXEzUaQUzWT0SnDXOSER5Hth8Oy7mrNmxcDrd5/2R1Z/V0/sBpncx+MnCX0qWPSpCqWDPLjgOWqBumd5G3p8E+5lXlSNSmIQvB7tXVctnfeeBmKrSzYW/UewQErQ50+X42Xjx2SMCPNTndfwigkuUVvmxRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746450881; c=relaxed/simple;
	bh=CMlk2ik9FJdWKIPQKsmVJ9PVaP518uo2AvuY9ufhylc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PotMSGmwsBTgH+MJmzb1yUqAtLQIEkwIJqXCwPgulGNTg2+47Kw4LkiEy7CDNZypYVJRd5p7fMXBMerZMs4dIoet8pbxvVSQno9V6cX2wVWuWU1mYUR5p8xNRCDKsWJmaJkTfLnytS3T85aXRzojq6xZY81PrfHdJq1UDPNQO8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhvkX1td; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8BA5C4CEE4;
	Mon,  5 May 2025 13:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746450880;
	bh=CMlk2ik9FJdWKIPQKsmVJ9PVaP518uo2AvuY9ufhylc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BhvkX1td/NPPT6fT/ZCrsdtrUfDphRsb/O887Nmn2CH7+khaeV3TgApS8JrPlm0s3
	 FN2n6WWrM0ZQv4L97ROub40Z/i1/9+X98cheEz9Vay6kgcU6aLs7a6n+AafTluMH4T
	 jAF0ihDNNYRzIoRkeeZZ+RHViyE9lk3a8clp7WXiVd8XKVRSCAkKUudkk1XTfe66oo
	 KnkTyoJSqjS6JbgY7HBqD02yp0OOsX69on9tzp4kWtq8rUD10ZYaBdW47sqb5YUGaQ
	 gY7WXxf91RrUHk0g+LBYwtRiXTUohy2DpJk4Z2f6Ym0UmJAYyV6hfgg/B1w3kGybRj
	 2pM4Eit4jvMSA==
Date: Mon, 5 May 2025 15:14:35 +0200
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Etienne Champetier <champetier.etienne@gmail.com>, Marc Dionne <marc.dionne@auristor.com>, 
	Jeffrey Altman <jaltman@auristor.com>, Chet Ramey <chet.ramey@case.edu>, 
	Steve French <sfrench@samba.org>, linux-afs@lists.infradead.org, openafs-devel@openafs.org, 
	linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs, bash: Fix open(O_CREAT) on an extant AFS file in a
 sticky dir
Message-ID: <20250505-erproben-zeltlager-4c16f07b96ae@brauner>
References: <433928.1745944651@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <433928.1745944651@warthog.procyon.org.uk>

On Tue, Apr 29, 2025 at 05:37:31PM +0100, David Howells wrote:
>     
> Bash has a work around in redir_open() that causes open(O_CREAT) of a file
> in a sticky directory to be retried without O_CREAT if bash was built with
> AFS workarounds configured:
> 
>         #if defined (AFS)
>               if ((fd < 0) && (errno == EACCES))
>             {
>               fd = open (filename, flags & ~O_CREAT, mode);
>               errno = EACCES;    /* restore errno */
>             }
> 
>         #endif /* AFS */
> 
> This works around the kernel not being able to validly check the
> current_fsuid() against i_uid on the file or the directory because the
> uidspaces of the system and of AFS may well be disjoint.  The problem lies
> with the uid checks in may_create_in_sticky().
> 
> However, the bash work around is going to be removed:

Why is it removed? That's a very strange comment:

#if 0	/* reportedly no longer needed */

So then just don't remove it. I don't see a reason for us to workaround
userspace creating a bug for itself and forcing us to add two new inode
operations to work around it.

