Return-Path: <linux-fsdevel+bounces-34631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E11489C6DDC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 12:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6F6E28557E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 11:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2767A1FF7B6;
	Wed, 13 Nov 2024 11:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T2i36Av9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E6A1FF61C
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 11:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731497284; cv=none; b=Yt9mG9TUxKLalGip7UjiYyOn74Lx9u4Pdl3IZE2QXvejKDFzyaHkfFeQwT8EjDG2KZ7LPD1d8A5RKyzyHPjFT0YcDlhVnTJ3pRcJ6am4J+Ib7WyakWuyMPt9h4BN+Vcm9IrHuEsm+3MJjOtLm2kh7P7BfISaK0oHAmKI8DIkd18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731497284; c=relaxed/simple;
	bh=NT71yENrzEuRfmxcpvg4Og4HMFPJiRxXgC/X+n7Xig0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZTljGVzKddlExtV1g/XU+zDVUYicLKKMWfHXsVohp8OOxWQBJKPmHhpXPPMH4AlxkCGuCAudBQuXudsv27ZzrXJYcspB4U7OI/gkzwmmojPKPmzzDqEbq2w+BZjjqJWomb1SY2hrdIMmay9Xuc9Emv20yCMpguIivSobyqnA10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T2i36Av9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731497282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XDom7M3/nHbCqwKwcg/dd3iQWQaO7P/1qdywo6XrazQ=;
	b=T2i36Av9wWWOgZH1Ci0MX/QRYgnX7TpkuEwNZXTWwKXcpX9W9AZNfatfPB7BNhVigTWrB/
	IQ+9elUjBEkfM2nW/9f51Tw6pL5wNOqkJBJE+r+Ckk7jv/oPxzX2SoWsnJqmKcttJFq85e
	c/AL6El6P8dzV4vwEvbY3GkUFp48ag0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-CB2ChinnOcSHhkFGYQ1Qgw-1; Wed,
 13 Nov 2024 06:27:58 -0500
X-MC-Unique: CB2ChinnOcSHhkFGYQ1Qgw-1
X-Mimecast-MFC-AGG-ID: CB2ChinnOcSHhkFGYQ1Qgw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E7C2419560B0;
	Wed, 13 Nov 2024 11:27:56 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.223])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BE3C41956086;
	Wed, 13 Nov 2024 11:27:53 +0000 (UTC)
Date: Wed, 13 Nov 2024 12:27:50 +0100
From: Karel Zak <kzak@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Ian Kent <raven@themaw.net>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v4 0/3] fs: allow statmount to fetch the fs_subtype and
 sb_source
Message-ID: <hss5w5in3wj3af3o2x3v3zfaj47gx6w7faeeuvnxwx2uieu3xu@zqqllubl6m4i>
References: <20241111-statmount-v4-0-2eaf35d07a80@kernel.org>
 <20241112-antiseptisch-kinowelt-6634948a413e@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112-antiseptisch-kinowelt-6634948a413e@brauner>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Tue, Nov 12, 2024 at 02:39:21PM GMT, Christian Brauner wrote:
> On Mon, 11 Nov 2024 10:09:54 -0500, Jeff Layton wrote:
> > Meta has some internal logging that scrapes /proc/self/mountinfo today.
> > I'd like to convert it to use listmount()/statmount(), so we can do a
> > better job of monitoring with containers. We're missing some fields
> > though. This patchset adds them.
> > 
> > 
> 
> Applied to the vfs.misc branch of the vfs/vfs.git tree.
> Patches in the vfs.misc branch should appear in linux-next soon.

Jeff, thank you for this!

I have already implemented support for statmount() and listmount() in
libmount (PR: https://github.com/util-linux/util-linux/pull/3092). The
only remaining issue was the mount source and incomplete file system
type.

Currently, the library does not use these syscalls when mounting (it
still uses /proc/#/mountinfo). However, there is already a library API
to fetch mount information from the kernel using listmount+statmount,
and it can be accessed from the command line using:

   findmnt --kernel=listmount

Next on the wish list is a notification (a file descriptor that can be
used in epoll) that returns a 64-bit ID when there is a change in the
mount node. This will enable us to enhance systemd so that it does not
have to read the entire mount table after every change.


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


