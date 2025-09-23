Return-Path: <linux-fsdevel+bounces-62488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7ECBB94EF6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 10:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DCE3190387E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 08:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5205D3195F4;
	Tue, 23 Sep 2025 08:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oPlBAEyN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E261DD877;
	Tue, 23 Sep 2025 08:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758615059; cv=none; b=DnStgT6OCAD8tvGazHRdQzF/vXATs3ywwFjZB3XiAWSQxbChqxsRdypbwtiyvZoLEGjmokuLGnD96WCHuBA02bj8FXCowkxLeg9xzTRZJIJA0uB97J+Z9D7lYVxoql430FS2OgX1aVcOuIx2CI2IsRkhb0QFKe8VBI8ycCb6oXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758615059; c=relaxed/simple;
	bh=G0FiE47jVMNmpHliwL+OFzsubcfkWiZQF2cHX5bGqrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVL3MwtNCXShvPd0aWEgnh6BNw3E64pxbPI3FF25Ki2PWDp7fC5wJEYojJ4yqQAJp4Y/bh1xiSrBc8CMtSvGuQhqD+0FWU3qu35BM/DkJNsE2BR64g4Ns7YXTKB1epHHEJetT2v0xFuiMJneCSRnYZdtjetvis+VPQsn9NVV0bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oPlBAEyN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2BC2C4CEF5;
	Tue, 23 Sep 2025 08:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758615059;
	bh=G0FiE47jVMNmpHliwL+OFzsubcfkWiZQF2cHX5bGqrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oPlBAEyNSLE1mtMEit6tAgK95hSg/hQTQW8/itpwYbFtcgCyVxu4reyy4ldr1c/IK
	 ZQusSk+EIFC0Q9C0waJXT6N/Edur7zGGkpqtktnCK/BVRYXqGUZC9z7F1hnhPo9c1P
	 jIKc+xsaDiUXbddhTssHmndVtd4oud76X/HX5OfI=
Date: Tue, 23 Sep 2025 10:10:54 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
	brauner@kernel.org, jack@suse.cz, raven@themaw.net,
	miklos@szeredi.hu, a.hindborg@kernel.org, linux-mm@kvack.org,
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev,
	kees@kernel.org, rostedt@goodmis.org, linux-usb@vger.kernel.org,
	paul@paul-moore.com, casey@schaufler-ca.com,
	linuxppc-dev@lists.ozlabs.org, borntraeger@linux.ibm.com
Subject: Re: [PATCH 18/39] convert debugfs
Message-ID: <2025092344-bloated-twister-682d@gregkh>
References: <20250920074156.GK39973@ZenIV>
 <20250920074759.3564072-1-viro@zeniv.linux.org.uk>
 <20250920074759.3564072-18-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250920074759.3564072-18-viro@zeniv.linux.org.uk>

On Sat, Sep 20, 2025 at 08:47:37AM +0100, Al Viro wrote:
> similar to tracefs - simulation of normal codepath for creation,
> simple_recursive_removal() for removal.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/debugfs/inode.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

