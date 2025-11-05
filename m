Return-Path: <linux-fsdevel+bounces-67120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BE05DC3597B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 13:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E15674E3810
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 12:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13ACA314B9A;
	Wed,  5 Nov 2025 12:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vPOmdA/Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFC2314A82;
	Wed,  5 Nov 2025 12:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762345195; cv=none; b=YlxjyhRS7JLQIz11d9Rb+3W3m/JRk/RIZt92yRhmF/SC9H0FWpUoUZvJ80B3LmxJcjOE1wODiNpdGSM9xcx/2cVp7zI6EJrS8HDtZcjuxL6UC478tQqS0SiMY9Biolngk7E32l9kvDR/Ya602P2yEd82sYTJtVH5twQT1i+V0N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762345195; c=relaxed/simple;
	bh=+DZc/wBGlBf0hYQMYjvYnYVWjd1kabwKmMshykftops=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLD/N3nBhSdpxI+OxEK1a5XOsSd3E9yZDSEJIe7B44FI0fwZhugRndtK1Q6wAME9gcd5WesTx45mrwipcsZqz1KzAJ1Adz3JqUmqx0M9gaoMQAqGxnKuXz6Fk1m17OLm3CxLJZgATnqk3b5n0nt7qtD/mc20aCyBi4vsFmYHZDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vPOmdA/Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0792DC4CEF8;
	Wed,  5 Nov 2025 12:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762345194;
	bh=+DZc/wBGlBf0hYQMYjvYnYVWjd1kabwKmMshykftops=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vPOmdA/Zerlk792R/gDEy7IXyt+4e7ZXIc0jGyjZ+5oDsWr43x8on7Rqk3eIG9kCz
	 vuPCItsLJgNwzyn2oh2Y1igOYSVI+9isWEs69lFW+FT2qK6xMO59yn54z+NbXSnLMq
	 FaBhDWV+Nfga1VxD9NJsHDdIXKRyjg+V8r3qWMA70d5ei++8TMnZmgL7YOKs990SxF
	 Dg8yqkvYHbsm094MmrYcwtdoqaqhdv8KyeXsK+tE86YZNl9cqNUnFA8WARfliSATkG
	 C+mnsxHXF/xM0RMaQBNsyTPAbkUPpKnL22PtUwmfTR6AYmAnvtC34g/7OQE+VlDyr8
	 I0dzLM3EnR6pg==
Date: Wed, 5 Nov 2025 13:19:43 +0100
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
Subject: Re: [PATCH v4 03/17] filelock: add struct delegated_inode
Message-ID: <20251105-vorwurf-rotwein-c3b6c398b50d@brauner>
References: <20251103-dir-deleg-ro-v4-0-961b67adee89@kernel.org>
 <20251103-dir-deleg-ro-v4-3-961b67adee89@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251103-dir-deleg-ro-v4-3-961b67adee89@kernel.org>

On Mon, Nov 03, 2025 at 07:52:31AM -0500, Jeff Layton wrote:
> The current API requires a pointer to an inode pointer. It's easy for
> callers to get this wrong. Add a new delegated_inode structure and use
> that to pass back any inode that needs to be waited on.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---

Yeah, I like this. I think this is a pretty obvious win.

