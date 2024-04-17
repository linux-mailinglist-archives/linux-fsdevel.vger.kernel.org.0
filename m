Return-Path: <linux-fsdevel+bounces-17146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6B68A861F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 16:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A22C1B21FD2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 14:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B8513C664;
	Wed, 17 Apr 2024 14:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZO3UTO2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F641419B3
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 14:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713364704; cv=none; b=CrAHJuaey+TESuAE9CX5csqPkoZVI+iIFWVSbjwqexvUN5lEOwlGv47n1+PYgJngqSObuPP01kr24VBbwCcxC/6rd7DTSMvnW2QFgZpdo8JTByLQs3/8OeEtVlNHLl7kd4Mkbc21exFju0bKOtKilJMDF53823mY1ibaEJ31Ibo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713364704; c=relaxed/simple;
	bh=KoYtxC55Ohj6Lf9NvLZyrFVpFV90+1Yse/ygPWxNqOY=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=r8GpJXJk9CNXCAV0LYXaMqj24NaOaBUgxorgWVRInfKvNmI65Nk7jnrAZFt8bYYPyi0U6uLNaDith+M1EdReL5YOqXg3y/tX3Tsoq9h0GrLAd4aCDyuCQTCqs/2AIwON9NXQIzEk6GteU3SpUB0mUeqr/+2Np1y1IJhKr/MabOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IZO3UTO2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713364701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zDU7e9X4ZusOLu7T2w8qLW/ur2IZiAOdvpcSe/vwEi0=;
	b=IZO3UTO2m0JTjROzd7a6giA6Qs41bYa0UFiwsyDY4ksTWS/z6oENXEoMydmA42Nrz1e2d3
	RLVE/lvsR/4RaBgp4DhcCbFlGQkKKkaeiqWlkET70RwfrHkY7BePR5Nps3UxbuOy9b+1NU
	JGLtA26zBTSBpv+eDBWmh73BoBNyxu0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-UL2Iqt2XMpycvVM7LVyaIA-1; Wed,
 17 Apr 2024 10:38:19 -0400
X-MC-Unique: UL2Iqt2XMpycvVM7LVyaIA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E2EC3C025A1;
	Wed, 17 Apr 2024 14:38:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.200])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5EC07492BD4;
	Wed, 17 Apr 2024 14:38:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1a94a15e6863d3844f0bcb58b7b1e17a@manguebit.com>
References: <1a94a15e6863d3844f0bcb58b7b1e17a@manguebit.com> <14e66691a65e3d05d3d8d50e74dfb366@manguebit.com> <3756406.1712244064@warthog.procyon.org.uk> <2713340.1713286722@warthog.procyon.org.uk>
To: Paulo Alcantara <pc@manguebit.com>
Cc: dhowells@redhat.com, Steve French <sfrench@samba.org>,
    Shyam Prasad N <sprasad@microsoft.com>, linux-cifs@vger.kernel.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cifs: Fix reacquisition of volume cookie on still-live connection
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <277919.1713364693.1@warthog.procyon.org.uk>
Date: Wed, 17 Apr 2024 15:38:13 +0100
Message-ID: <277920.1713364693@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Paulo Alcantara <pc@manguebit.com> wrote:

> Consider the following example where a tcon is reused from different
> CIFS superblocks:
> 
>   mount.cifs //srv/share /mnt/1 -o ${opts} # new super, new tcon
>   mount.cifs //srv/share/dir /mnt/2 -o ${opts} # new super, reused tcon
> 
> So, /mnt/1/dir/foo and /mnt/2/foo will lead to different inodes.
> 
> The two mounts are accessing the same tcon (\\srv\share) but the new
> superblock was created because the prefix path "\dir" didn't match in
> cifs_match_super().  Trust me, that's a very common scenario.

Why does it need to lead to a different superblock, assuming ${opts} is the
same in both cases?  Can we not do as NFS does and share the superblock,
walking during the mount process through the directory prefix to the root
object?

In other words, why does:

    mount.cifs //srv/share /mnt/1 -o ${opts}
    mount.cifs //srv/share/dir /mnt/2 -o ${opts}

give you a different result to:

    mount.cifs //srv/share /mnt/1 -o ${opts}
    mount --bind /mnt/1/dir /mnt/2

David


