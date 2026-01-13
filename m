Return-Path: <linux-fsdevel+bounces-73503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D615D1B00A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 20:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06CE630BCA9D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 19:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B6F35F8AC;
	Tue, 13 Jan 2026 19:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xd68OoUq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A22735CB9C
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 19:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768331658; cv=none; b=a4OdCqA8PHn86LcnOAAH7ouNMxPUPg3WmMrtZVkHJKVXW7VIjTYLE4sPpp2z+MmwgjS3Esvw8lhRRdsAQ7UCr2Ts1I3MfWWHdMfOL9ODl+mG+8t30gqbNy0aQyZvZziww/Y5W7XhvjyElfcM8ZwXXTEvi1VmPITny5dGYAK0m8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768331658; c=relaxed/simple;
	bh=PDYWEqVlS68qk1ctv5leSfRaEKuPTdHsjTccbxj28WM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gW1C+E5o00ROsD7C/5oknztzU2FdWnQ32i3AlErb4aP7LxdhNOmh3uFaSB/GjQ2wdwTaGvYecoD8NwjPveUW2M1ZAP+C0YgQT+8F54ndlGONnqlNvWKtnW/lYNODwKR3cxo0PsWeNsOt5Et/wb1muYPKxjzW/hQzhxWiChzldZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xd68OoUq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768331656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GCwiC2oNe/r9hy+vXPGATdP3aSCzjcB6rkHaAigTRbY=;
	b=Xd68OoUqQmHYAY5U1m/wk4okxuF9xsMB/3bJLWMnOwsyTxWzInRCRdpRCXGBgEXaholM06
	3SkCi4fwqxK+XZsL5lR41dHsrdF1YwKmvtNtiU8ncLXwkWnPrXWuBH8uJzpRODOyea2Vc+
	egV6xoQ0rpw5fnqHqQOdt+jhdH6vLqc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-Oyu8mjjlPeitB7Uci5QvWQ-1; Tue,
 13 Jan 2026 14:14:11 -0500
X-MC-Unique: Oyu8mjjlPeitB7Uci5QvWQ-1
X-Mimecast-MFC-AGG-ID: Oyu8mjjlPeitB7Uci5QvWQ_1768331650
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1081518005B2;
	Tue, 13 Jan 2026 19:14:10 +0000 (UTC)
Received: from ws (unknown [10.44.34.128])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4BBE218004D8;
	Tue, 13 Jan 2026 19:14:06 +0000 (UTC)
Date: Tue, 13 Jan 2026 20:14:04 +0100
From: Karel Zak <kzak@redhat.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: util-linux@vger.kernel.org, ceph-devel@vger.kernel.org, 
	idryomov@gmail.com, linux-fsdevel@vger.kernel.org, pdonnell@redhat.com, 
	amarkuze@redhat.com, Slava.Dubeyko@ibm.com, vdubeyko@redhat.com, 
	Pavan.Rallabhandi@ibm.com
Subject: Re: [PATCH] mount: (manpage) add CephFS kernel client mount options
Message-ID: <binwryzqlbprj2t3ybxb5kychdeenhtmadbe23hov44urszvn5@kpbbv3qks47c>
References: <20260112205837.975869-2-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112205837.975869-2-slava@dubeyko.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Mon, Jan 12, 2026 at 12:58:38PM -0800, Viacheslav Dubeyko wrote:
> From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> 
> Currently, manpage for generic mount tool doesn't contain
> explanation of CephFS kernel client mount options. This patch
> adds the description of CephFS mount options into
> file system specific mount options section.
> 
> Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> ---
>  sys-utils/mount.8.adoc | 86 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
> 
> diff --git a/sys-utils/mount.8.adoc b/sys-utils/mount.8.adoc
> index 4571bd2bfd16..191a3fabf501 100644
> --- a/sys-utils/mount.8.adoc
> +++ b/sys-utils/mount.8.adoc
> @@ -853,6 +853,7 @@ This section lists options that are specific to particular filesystems. Where po
>  |===
>  |*Filesystem(s)* |*Manual page*
>  |btrfs |*btrfs*(5)
> +|cephfs |*mount.ceph*(8)

It seems that all we need is this change.

>  |cifs |*mount.cifs*(8)
>  |ext2, ext3, ext4 |*ext4*(5)
>  |fuse |*fuse*(8)
> @@ -913,6 +914,91 @@ Give blocksize. Allowed values are 512, 1024, 2048, 4096.
>  **grpquota**|**noquota**|**quota**|*usrquota*::
>  These options are accepted but ignored. (However, quota utilities may react to such strings in _/etc/fstab_.)
>  
> +=== Mount options for ceph

If mount.ceph(8) exists, we do not need to repeat the mount option in
mount(8). The ideal solution is to keep filesystem-specific mount
options in the filesystem-specific man page maintained by the
filesystem developer :-)  See btrfs, extN, XFS, etc.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


