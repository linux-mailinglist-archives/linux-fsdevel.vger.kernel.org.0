Return-Path: <linux-fsdevel+bounces-57624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 248D3B23F63
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 06:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 379A85816E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 04:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B562BE045;
	Wed, 13 Aug 2025 04:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ZVkRJfHg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDE91A9F94;
	Wed, 13 Aug 2025 04:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755058516; cv=none; b=O1cUQ4pY9quyKFHqwhu2KqyWl021rRO6xRgEgrE8b8dIdvSVIwI8xnRIlHicGH4xCsPbRhxKwxRabjiafG2neCKC5aCxX2lRugNIlk9hCt7i9UGiywpQbp1XXnJmgGZWAXA5S1Cw7zp5oYUP3xCw5BUvZ8IG9wRMdkpYfQLhnmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755058516; c=relaxed/simple;
	bh=sSbpl5CI0JvCP5aS9c8WvgFkbzdw8n7k3hEHefjuRek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWvpM7sBbYQWK3x5bRNMrrcDselfuOfg6Gfrq3aGR6QW037MOl4SDka6DGY0/oFXfhabYMmUVIHfnQ1Lc1r7F+oDNvQTpyyabibhVPDrbebonWcM5STfUoonBMnmME+Hn5zocSHiOX57AjgwwFgddhIfmNX0lgxI6P0FPQXK/ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ZVkRJfHg; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mGFlvnNAi/Tl7nNsEWG2qsCanGGPDT6DKS+ZvemjV5o=; b=ZVkRJfHgEHCeXHIbXJ1rESudU6
	thRh1RQkyDWCEzipzEmpweoNke5WA2w7PIb8rrshD9j1gudgyh0P+mekEtlO8xV9OdXB4XVVZ+HDx
	fgfWBOHyTHhQ6AxToVRTAifMjbEr7rK16KK4zRdXmnjOoTB2gAgOnHf0C6ryNFFuIEEKr2mB0Z7YJ
	4jy6xB2tleJ5hykFw28TkBDDtoZZrAqkAGRkGw9seWWd8uvdiFdAr0nMJSso+TWnJy/OUVRSmVYsc
	VRnEh6YqdZtpTJi8r8qD0bgUk8cc8uyfTgPsjWiSV1g9qsmSbOKjXj7BuQ4k+P0Pj6aGQ4EWD/aAO
	oqv0joyg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um2tG-00000005RsT-0Enk;
	Wed, 13 Aug 2025 04:15:06 +0000
Date: Wed, 13 Aug 2025 05:15:06 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
	Tyler Hicks <code@tyhicks.com>, Miklos Szeredi <miklos@szeredi.hu>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Steve French <sfrench@samba.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-afs@lists.infradead.org, netfs@lists.linux.dev,
	ceph-devel@vger.kernel.org, ecryptfs@vger.kernel.org,
	linux-um@lists.infradead.org, linux-nfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] VFS: add dentry_lookup_killable()
Message-ID: <20250813041506.GZ222315@ZenIV>
References: <20250812235228.3072318-1-neil@brown.name>
 <20250812235228.3072318-4-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812235228.3072318-4-neil@brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Aug 12, 2025 at 12:25:06PM +1000, NeilBrown wrote:
> btrfs/ioctl.c uses a "killable" lock on the directory when creating an
> destroying subvols.  overlayfs also does this.
> 
> This patch adds dentry_lookup_killable() for these users.
> 
> Possibly all dentry_lookup should be killable as there is no down-side,
> but that can come in a later patch.

Same objections re lookup_flags and it would be better to do that
at the same point where you convert the (btrfs and overlayfs?) callers.

