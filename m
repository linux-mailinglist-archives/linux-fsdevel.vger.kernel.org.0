Return-Path: <linux-fsdevel+bounces-15168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D02AE887BA6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Mar 2024 05:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8DE81C20B51
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Mar 2024 04:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EAB134A0;
	Sun, 24 Mar 2024 04:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="kgwq3caj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7777A33DD
	for <linux-fsdevel@vger.kernel.org>; Sun, 24 Mar 2024 04:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711254773; cv=none; b=rZ1BbbdUIDx/E+3F+m2v3x8n8UmKfgyXhdKcxfuE9ui1wa1WsjZC5TJOOvfU6ILv9qZnYC43h5gqWgSvvLOcExoOlnP1gaJJaB26ZvyKpJe1LbU8N9+wAyOpPVPxgxDMq7fx+pssae+68hwEKZtade7sUdAdFJaD4ge4W4qyeoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711254773; c=relaxed/simple;
	bh=JSL1gXzPFx60NmU5kGL9JA4boLvSmdhivrecnDrVEx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9k+FT8ZXkEqEBdQJdMAwFTXJVdNbKEGi0uBW2oU8KwX+5/ZeIehFuNQtrEWKlTPBEvMeTK+xoZzbgam56xqxDo4weeLjvALBm/2jDw3QOqA9Jg9aJyK2C12JH/SnfFZ5yqbyZr3f5H06UUyNSXra7Zm3aOG2PK7lDEJi6Q1Bpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=kgwq3caj; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cb0REWQPm0ZustxhTz3aYcr2yXgWzD8C9/PGjafqICw=; b=kgwq3cajnTKS/9cG2Ia5Vq673G
	9bzzu3eipq2AY3HASdhGthfowAxdZKpOuOB6rv8bfBfLtDMkwt962kA621QyAqQN+cl4K8t3bC/iO
	efGhmdKbwzsrLR4FM4TlML3aLhscgpS8WgB2l0w+wOlADQjlcUtFtANutb3JgiZmInwdDWhholksK
	0hFdhDsiPjx/SYi3pMvUaHxxbV6QM+LMUGbh6/BwGtuMPHoZpgRo6fsHVE5+EfIFvX9IenkvDuryd
	WXCYFqpgXpKs0A0L95UzOmDE5k3sQVIZaPCVLryfTWx+ODbyrjJE3U+uVouq/VMm/ccSbTrILTHh/
	OjI0MPNQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1roFXH-00Fb3h-2i;
	Sun, 24 Mar 2024 04:32:43 +0000
Date: Sun, 24 Mar 2024 04:32:43 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Keiichi Watanabe <keiichiw@chromium.org>
Cc: bschubert@ddn.com, linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm, miklos@szeredi.hu, dsingh@ddn.com,
	hbirthelmer@ddn.com, brauner@kernel.org, yuanyaogoog@chromium.org
Subject: Re: [PATCH] fuse: Do NULL check instead of IS_ERR in atomic_open
Message-ID: <20240324043243.GS538574@ZenIV>
References: <20231023183035.11035-3-bschubert@ddn.com>
 <20240314103404.2457718-1-keiichiw@chromium.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314103404.2457718-1-keiichiw@chromium.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Mar 14, 2024 at 07:34:04PM +0900, Keiichi Watanabe wrote:
> Since d_splice_alias returns NULL on error, we need to do NUL check
> instead of IS_ERR.

d_splice_alias() does *NOT* return NULL on error.  Never did.  Moreover,
passing it a pointer to non-directory inode will definitely return NULL.
So will passing it a pointer to directory inode that currently has
no aliases.

NAK.

