Return-Path: <linux-fsdevel+bounces-31541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FAF9984A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 13:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1ED11C21378
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 11:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858761C244A;
	Thu, 10 Oct 2024 11:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SHes/O2b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676791BBBE5
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Oct 2024 11:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728559021; cv=none; b=YiMfGbDo2b5CpT4gEEnNvS4mK9BSuBwgtBXuPdPpZ09DCuITooLsaUAUaZAjAvUUlEe9+eWvPiGAk/ISnhjY/q+It2EIaRl/pT1ZSYFcieH7f4GYmVX92iu5ZNBbbGQh5XSXV7v6x5CVWdzT+YPEtn3BF7LXuw58u/YWK/sxamw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728559021; c=relaxed/simple;
	bh=5NQRMk+e+srTIrFvRoWCp1jv+sUYAoVk2R8Xc1utZeY=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=gcLAjHv8fEbG+Dqd6EqORFZ1j1qxtTsDZNqNsONdZfhGAD54hejXVYY3Sv6jY56PpOQX4otvJYOkW5TKmy3fcX4/wpIHbApF9wpOtEFzIaqEVZAGB9b0+gXoHKlQM1XoeXe27Kcbo1UWkSISrXCjMzWOZ+h+pKDIW+oxDb9y14A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SHes/O2b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728559018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+5tSqNiLfQZoZqE5JUG8Byob3AcTf76CH9na62lK+mk=;
	b=SHes/O2b/o7uWe5Hzy95famiUdqVxrQiNfCLj2NximBceuSCZIPts/usYUA7pqntT6AXyf
	R74F34EYhKBIziagQRiSM2PlsNnkqBW4QSHyZ4kh3JNdghNpCDZR6nQ+MbT93qZtvFvwsS
	4ASOYZ+qaUoWoOynmZ04SSisZaXvX5E=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-N_qhrj8XOVeNEqrYwZJs2A-1; Thu,
 10 Oct 2024 07:16:52 -0400
X-MC-Unique: N_qhrj8XOVeNEqrYwZJs2A-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1221D1955EE6;
	Thu, 10 Oct 2024 11:16:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 37228300018D;
	Thu, 10 Oct 2024 11:16:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240821024301.1058918-5-wozizhi@huawei.com>
References: <20240821024301.1058918-5-wozizhi@huawei.com> <20240821024301.1058918-1-wozizhi@huawei.com>
To: Zizhi Wo <wozizhi@huawei.com>
Cc: dhowells@redhat.com, netfs@lists.linux.dev, jlayton@kernel.org,
    hsiangkao@linux.alibaba.com, jefflexu@linux.alibaba.com,
    zhujia.zj@bytedance.com, linux-erofs@lists.ozlabs.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    libaokun1@huawei.com, yangerkun@huawei.com, houtao1@huawei.com,
    yukuai3@huawei.com
Subject: Re: [PATCH 4/8] cachefiles: Clear invalid cache data in advance
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <303669.1728559002.1@warthog.procyon.org.uk>
Date: Thu, 10 Oct 2024 12:16:42 +0100
Message-ID: <303670.1728559002@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Zizhi Wo <wozizhi@huawei.com> wrote:

> In the current on-demand loading scenario, when umount is called, the
> cachefiles_commit_tmpfile() is invoked. When checking the inode
> corresponding to object->file is inconsistent with the dentry,
> cachefiles_unlink() is called to perform cleanup to prevent invalid data
> from occupying space.
> 
> The above operation does not apply to the first mount, because the cache
> dentry generated by the first mount must be negative. Moreover, there is no
> need to clear it during the first umount because this part of the data may
> be reusable in the future. But the problem is that, the clean operation can
> currently only be called through cachefiles_withdraw_cookie(), in other
> words the redundant data does not cleaned until the second umount. This
> means that during the second mount, the old cache data generated from the
> first mount still occupies space. So if the user does not manually clean up
> the previous cache before the next mount, it may return insufficient space
> during the second mount phase.
> 
> This patch adds an additional cleanup process in the cachefiles_open_file()
> function. When the auxdata check fails, the remaining old cache data is no
> longer needed, the file and dentry corresponding to the object are also
> put. As there is no need to clear it until umount, we can directly clear it
> during the mount process.
> 
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>

Okay, I think this is reasonable as it's done from a worker thread.  I wonder
if instead, though, cachefiles_create_file() should be called and then linked
over the top:

	https://lore.kernel.org/all/cover.1580251857.git.osandov@fb.com/

though AT_LINK_REPLACE seemed to get stuck.

Note that we can't just truncate the file to nothing instead because I/O might
be in progress on it.

David


