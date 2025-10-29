Return-Path: <linux-fsdevel+bounces-66293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2CDC1AAE1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 14:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 251EB62528E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20FD3451B4;
	Wed, 29 Oct 2025 12:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ur6Ekr2s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B79275AFD;
	Wed, 29 Oct 2025 12:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761742535; cv=none; b=F/EERNzyoCEgj24pHswBSjvSc24dBhHzsSRfJwLPgf+7lmPRls37TlK6IKK4MYpIm/cbAG1DyzqTE1iefIzT6Pz8fr21swtDYacpTr/WWkrS6CxCcCADt4FqNnrmwnMasVQouc90ofkCVf6AbSteUY74MEO0gGhNP3MWHTEN6DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761742535; c=relaxed/simple;
	bh=0CzE2vJmUarjE3+QMrd+j0mHeIz5jGi5cgcCV2j7Gto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkZn9sfhZTevY7ZKAozwJ3nCEW28qJ4zDK0KZq7rHfxW5pjH94st+ANQVaXmvpF1TFBECS/RtFRkmin48jMm5NVlz+KNj/3SJXlJFklvUJYr/G6Ok72BBhKrnXsj1I5f5ik6cfSo+yFL0fUDs0Q9AanY7jFxyT+2TkJBVvlNRsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ur6Ekr2s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA4FC4CEF7;
	Wed, 29 Oct 2025 12:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761742535;
	bh=0CzE2vJmUarjE3+QMrd+j0mHeIz5jGi5cgcCV2j7Gto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ur6Ekr2sxpK9kC1PNi5PiLCDzlSRO6FM0+oaVL0Fz8YUh5SxgvQXiBvK9gL9vzX1y
	 FJHfJrBxfhcUwe5dZlRw6ODhiRJl/EJm2rWbu5QrVsPtIdVs3alSnIez2tiAIWH6/h
	 ox/2F95UyuvJYNXfLY2SCq3uBNnh9JIw+5PQXbGVm6nDZmKCjPdaqJF4gD6WZNIxfM
	 +O9W7KhgM63n0OUdWoExlc/9tbhDAscPQvz7uiqUs93Re9GNmMrnQsoYwuL1lG1HkW
	 z3MMcgndaOWm17okctdlh7QveqspiHKAXE5wiW4Qgxh8V7dEAnzHTEFQv2U98huZ28
	 lcdMvlRM8I1iw==
Date: Wed, 29 Oct 2025 13:55:24 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
	Bharath SM <bharathsm@microsoft.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Amir Goldstein <amir73il@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Steve French <smfrench@gmail.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Carlos Maiolino <cem@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, netfs@lists.linux.dev, 
	ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v3 00/13] vfs: recall-only directory delegations for knfsd
Message-ID: <20251029-visuell-gluthitze-e321cef788d0@brauner>
References: <20251021-dir-deleg-ro-v3-0-a08b1cde9f4c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251021-dir-deleg-ro-v3-0-a08b1cde9f4c@kernel.org>

On Tue, Oct 21, 2025 at 11:25:35AM -0400, Jeff Layton wrote:
> Behold, another version of directory delegations. This version contains
> support for recall-only delegations. Support for CB_NOTIFY will be
> forthcoming (once the client-side patches have caught up).
> 
> This main differences in this version are bugfixes, but the last patch
> adds a more formal API for userland to request a delegation. That
> support is optional. We can drop it and the rest of the series should be
> fine.
> 
> My main interest in making delegations available to userland is to allow
> testing this support without nfsd. I have an xfstest ready to submit for
> this if that support looks acceptable. If it is, then I'll also plan to
> submit an update for fcntl(2).
> 
> Christian, Chuck mentioned he was fine with you merging the nfsd bits
> too, if you're willing to take the whole pile.

Absolutely!

