Return-Path: <linux-fsdevel+bounces-1080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE027D5391
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 16:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2F9DB211CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 14:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476142C840;
	Tue, 24 Oct 2023 14:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LL5fOVCo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA03F2943C
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 14:01:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B9AFE
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 07:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698156075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xWzuQlELGbL+gCIg4u/+SkfNkN3ZnZ0/znjFII22yfs=;
	b=LL5fOVCoYrjq+Gk3MfRLYJm1cVzVYOc36pDI/TT+BxVGNznPM6WJA3OsloR3K0ubX6QRuy
	i2gW9LdHZly5YCzaRQc/XQKkWSwktUPVyJil1vdP4Vfed3nAXAehO0UEKWGJMLDqer8uu9
	ohamM1T/kQT5yiCMgxtbdWE+Uv4XDyo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-ce_wB_DZMKCIlrTetlG3ow-1; Tue, 24 Oct 2023 10:01:11 -0400
X-MC-Unique: ce_wB_DZMKCIlrTetlG3ow-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BBD5D918571;
	Tue, 24 Oct 2023 14:01:10 +0000 (UTC)
Received: from [100.85.132.103] (unknown [10.22.48.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 176F92026D4C;
	Tue, 24 Oct 2023 14:01:08 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
 Anna Schumaker <anna@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfs: derive f_fsid from server's fsid
Date: Tue, 24 Oct 2023 10:01:07 -0400
Message-ID: <1CFE0178-CE91-4C99-B43E-33EF78D0BEBF@redhat.com>
In-Reply-To: <20231024110109.3007794-1-amir73il@gmail.com>
References: <20231024110109.3007794-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On 24 Oct 2023, at 7:01, Amir Goldstein wrote:

> Fold the server's 128bit fsid to report f_fsid in statfs(2).
> This is similar to how uuid is folded for f_fsid of ext2/ext4/zonefs.
>
> This allows nfs client to be monitored by fanotify filesystem watch
> for local client access if nfs supports re-export.
>
> For example, with inotify-tools 4.23.8.0, the following command can be
> used to watch local client access over entire nfs filesystem:
>
>   fsnotifywatch --filesystem /mnt/nfs
>
> Note that fanotify filesystem watch does not report remote changes on
> server.  It provides the same notifications as inotify, but it watches
> over the entire filesystem and reports file handle of objects and fsid
> with events.

I think this will run into trouble where an NFSv4 will report both
fsid.major and fsid.minor as zero for the special root filesystem.   We can
expect an NFSv4 client to have one of these per server.

Could use s_dev from nfs_server for a unique major/minor for each mount on
the client, but these values won't be stable against a particular server
export.

Ben


