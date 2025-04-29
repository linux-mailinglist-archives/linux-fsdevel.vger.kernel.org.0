Return-Path: <linux-fsdevel+bounces-47562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB82AA04F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 09:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CACE3B13DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 07:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE0F2820DD;
	Tue, 29 Apr 2025 07:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVo4tSoZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0549217734;
	Tue, 29 Apr 2025 07:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745912796; cv=none; b=I9bklPdcOTK1PxvHwPbd3s45BVrF8nzVr8KZB4a/+zqi+d8bmgCMx+wmT7/9OKOYFdLmrbSzU4lnvgSxUqoaMz2fL/85lby5KC0fNKOeh9jy97bcw/J9WNp1LC2i1fDMCUSNbT81uxIL4BRKURK+XMJCVkRR3zf+viIJv338dMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745912796; c=relaxed/simple;
	bh=LvSBAtEGajwM2UpS5jhTRUdaBvvpCwForTJ5HaNWMj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEBOX0DUoUev746dgSJucw0OpCcLBJeJTNlAvuU1I2REN7cy39ciZnRmoBU1IhIIo6Lzlny4u6DPExx60qLphtXlRdOBrWhwx/QIZnr2yTVNQWXBndn7e2LAuZWTPff8zjHwMuja3ldRRF26SidRU2u5YAD2eVcrD/gR+FeuFYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVo4tSoZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A6DBC4CEED;
	Tue, 29 Apr 2025 07:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745912796;
	bh=LvSBAtEGajwM2UpS5jhTRUdaBvvpCwForTJ5HaNWMj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YVo4tSoZ4Qpn/8/Y8XCPaQaDHPGabY7oRLJBInddKmOaVsGoerktGASGMGwzu7Nqw
	 j4/WTAFhteA/wSZGtuOFzBMYRYLCf//Wa2E2X9Crg8xpbWe0Xq+7krqhsbVIAhp+ay
	 cfc59KgUz59lZhIBeDxiXWn6AImz2415jtgUYkTPEpOSZFCtuhMpndCmwN1HHRDYDm
	 uPzQDXtNymzIXSH8USZA5UBjY7TkpvcswYE52MO3Kpv99Y+3IzMJ3apK6/PHwySfEO
	 9YUnPONJDSpS/8V3BPEulg5rp6pZH91+xCuVSq5Ndm0/oTWCncJYu3SrU/Xu1YXwGP
	 Gq8ALD+1aDPTQ==
Date: Tue, 29 Apr 2025 09:46:28 +0200
From: Christian Brauner <brauner@kernel.org>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: paul@paul-moore.com, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v2] security,fs,nfs,net: update
 security_inode_listsecurity() interface
Message-ID: <20250429-lenkrad-wandschmuck-c0dad83f9d1c@brauner>
References: <20250428195022.24587-2-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250428195022.24587-2-stephen.smalley.work@gmail.com>

On Mon, Apr 28, 2025 at 03:50:19PM -0400, Stephen Smalley wrote:
> Update the security_inode_listsecurity() interface to allow
> use of the xattr_list_one() helper and update the hook
> implementations.
> 
> Link: https://lore.kernel.org/selinux/20250424152822.2719-1-stephen.smalley.work@gmail.com/
> 
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> This patch is relative to the one linked above, which in theory is on
> vfs.fixes but doesn't appear to have been pushed when I looked.

It should be now.
Thanks for doing this.

