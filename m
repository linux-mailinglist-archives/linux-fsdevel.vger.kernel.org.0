Return-Path: <linux-fsdevel+bounces-64925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 810E9BF6AC6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 15:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5613C18847A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 13:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4301C334C2A;
	Tue, 21 Oct 2025 13:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0BNN4bv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7860925B2E7;
	Tue, 21 Oct 2025 13:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761052191; cv=none; b=RCmdzJ9i0vWlIWheTFAqC8TvG2DZ6ZJLZJ62UfKYBbis61ViaXT8zSdU7V+34NRNC1gJq0x3qh3UpjH9LS2xSzbXb4vtI6+cHhXFci/k13Aq9JKhVm9V3mo7c0zZNtIY0BSlcT/ZMhzLUtZkj4+L9Mzhz06lERRYGHHrblykufM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761052191; c=relaxed/simple;
	bh=H7UgwUYXbmCQ0jWM81jD1014fDBSOlu/wN7/eync+l8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=igAfYIQ9yEETzzpKO6usXA+AVF5RL1BhYJNmJFDwN6bHt48pJvnJatpBmxXTBkV2Ok9qxDyvrN8vwILPl0rTk7c5sZPNJ8+TnYZHXV17ST6CZPYLyX/lzUhpIdPujPtOoPyR8DbzXmenbwnpjUuzGgj4xJpLn4UwX9GC1Hr67Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0BNN4bv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D69DC4CEF1;
	Tue, 21 Oct 2025 13:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761052191;
	bh=H7UgwUYXbmCQ0jWM81jD1014fDBSOlu/wN7/eync+l8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D0BNN4bv0f2bxHTh/+Nw5MNWVpFs/tQMMePND99gLOmnI0NT3sCkhUKwGW+t4YPJH
	 hZxzQX/M2vfwhm82SiZp/NNrc9v/0+zip5dAUoBT+IFspML+LLlpWy4SAzOAV3KQrV
	 lH3bhwZyVYkVak5I/n29kivKEpVz9lmKMS/YEw2pv7kB004pduoQd9/OpTz4Q6s4rt
	 RYTmObHjwfYDi9vtkBhiuZmHyQF5GHxpqhG/E9pu5FLL4iKBk4ozH8VpRO9HaiGHWb
	 UxeJTM2Iu+UcAxf7miIVbDtU8CAnNRG21EVRX6ejjt2wb8iUy7aVLNFlCMgg4tvHQ9
	 FuMhBhxywkORg==
Date: Tue, 21 Oct 2025 15:09:39 +0200
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
Subject: Re: [PATCH v2 00/11] vfs: recall-only directory delegations for knfsd
Message-ID: <20251021-meditation-bahnverbindung-7c1d2aa25415@brauner>
References: <20251017-dir-deleg-ro-v2-0-8c8f6dd23c8b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251017-dir-deleg-ro-v2-0-8c8f6dd23c8b@kernel.org>

On Fri, Oct 17, 2025 at 07:31:52AM -0400, Jeff Layton wrote:
> A smaller variation of the v1 patchset that I posted earlier this week.
> Neil's review inspired me to get rid of the lm_may_setlease operation
> and to do the conflict resolution internally inside of nfsd. That means
> a smaller VFS-layer change, and an overall reduction in code.
> 
> This patchset adds support for directory delegations to nfsd. This
> version only supports recallable delegations. There is no CB_NOTIFY
> support yet. I have patches for those, but we've decided to add that
> support in a later kernel once we get some experience with this part.
> Anna is working on the client-side pieces.
> 
> It would be great if we could get into linux-next soon so that it can be
> merged for v6.19. Christian, could you pick up the vfs/filelock patches,
> and Chuck pick up the nfsd patches?

Happy to! Sorry, for the late reply. I was out for a few days.

