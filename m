Return-Path: <linux-fsdevel+bounces-29467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC8697A2B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 15:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90EF61F239CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 13:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE09F156C71;
	Mon, 16 Sep 2024 13:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QSkdPpNb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB63E15575D
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Sep 2024 13:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726491927; cv=none; b=CfYgoGXZxsoFUE+Y9n6lPR9P6BEDIL756t54URuPfD1TMTKJ4uVBW84H7u3RoD+KX4YQG4j9lbOhJlvH3s387ttWetOtk66M41ZD1CMdiFXWD2x2vs3UBDnsBLLOdsc30g8vwqvrmMiunutm2p2FYra3Hmyf0N+bVsVAcSn683I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726491927; c=relaxed/simple;
	bh=ONx8YG4EZm4Q6G1dXYvromV/PbnD7ffLh1Yg/eiRXoU=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=OivPsBU0NQNskjLs78tmIQL8kAfh0JQUv7UdmXNo/0YiwgoYDKHVjyeC46mjeGfvEtBaRQfHtkqVb7cSEtJYSd0sK70aAMg8E90IgWRetHbazb1Pe/Up1iMROQiAmZPtgLTbpZc8yPgLvDTV6K2rv245P1d25MhihKRJY8NvGAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QSkdPpNb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726491924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Fz2Otqr1x0kPcbKDKf2bmB2iDmlHXr2EPIDX2kJglM=;
	b=QSkdPpNbAhT9389jrHFBrBtQ9LCs58nMKkYasltPhZuPpj5vgx0KyUAG/PfcQjqNEUxJb0
	YXfFUBdbUluYPz1JFczpP98uE/D/gEeP3ThIogHFNEgpL2aSYbDl6MWn+r5qZEy9XgJIOV
	IuT+M57HpCwijdEdtfaLyi5rkXGzWAM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-670-U_07DsiXMa2szt0yLJCLvg-1; Mon,
 16 Sep 2024 09:05:19 -0400
X-MC-Unique: U_07DsiXMa2szt0yLJCLvg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 748921955DC8;
	Mon, 16 Sep 2024 13:05:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.14])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9AC4D1956088;
	Mon, 16 Sep 2024 13:05:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240829083409.3788142-1-libaokun@huaweicloud.com>
References: <20240829083409.3788142-1-libaokun@huaweicloud.com>
To: libaokun@huaweicloud.com
Cc: dhowells@redhat.com, netfs@lists.linux.dev, jlayton@kernel.org,
    brauner@kernel.org, linux-fsdevel@vger.kernel.org,
    hsiangkao@linux.alibaba.com, jefflexu@linux.alibaba.com,
    linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
    yangerkun@huawei.com, houtao1@huawei.com, yukuai3@huawei.com,
    wozizhi@huawei.com, Baokun Li <libaokun1@huawei.com>,
    stable@kernel.org
Subject: Re: [PATCH v2] cachefiles: fix dentry leak in cachefiles_open_file()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1899864.1726491909.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Sep 2024 14:05:09 +0100
Message-ID: <1899865.1726491909@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

libaokun@huaweicloud.com wrote:

> From: Baokun Li <libaokun1@huawei.com>
> =

> A dentry leak may be caused when a lookup cookie and a cull are concurre=
nt:
> =

>             P1             |             P2
> -----------------------------------------------------------
> cachefiles_lookup_cookie
>   cachefiles_look_up_object
>     lookup_one_positive_unlocked
>      // get dentry
>                             cachefiles_cull
>                               inode->i_flags |=3D S_KERNEL_FILE;
>     cachefiles_open_file
>       cachefiles_mark_inode_in_use
>         __cachefiles_mark_inode_in_use
>           can_use =3D false
>           if (!(inode->i_flags & S_KERNEL_FILE))
>             can_use =3D true
> 	  return false
>         return false
>         // Returns an error but doesn't put dentry
> =

> After that the following WARNING will be triggered when the backend fold=
er
> is umounted:
> =

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: Dentry 000000008ad87947{i=3D7a,n=3DDx_1_1.img}  still in use (1) [u=
nmount of ext4 sda]
> WARNING: CPU: 4 PID: 359261 at fs/dcache.c:1767 umount_check+0x5d/0x70
> CPU: 4 PID: 359261 Comm: umount Not tainted 6.6.0-dirty #25
> RIP: 0010:umount_check+0x5d/0x70
> Call Trace:
>  <TASK>
>  d_walk+0xda/0x2b0
>  do_one_tree+0x20/0x40
>  shrink_dcache_for_umount+0x2c/0x90
>  generic_shutdown_super+0x20/0x160
>  kill_block_super+0x1a/0x40
>  ext4_kill_sb+0x22/0x40
>  deactivate_locked_super+0x35/0x80
>  cleanup_mnt+0x104/0x160
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =

> Whether cachefiles_open_file() returns true or false, the reference coun=
t
> obtained by lookup_positive_unlocked() in cachefiles_look_up_object()
> should be released.
> =

> Therefore release that reference count in cachefiles_look_up_object() to
> fix the above issue and simplify the code.
> =

> Fixes: 1f08c925e7a3 ("cachefiles: Implement backing file wrangling")
> Cc: stable@kernel.org
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Acked-by: David Howells <dhowells@redhat.com>


