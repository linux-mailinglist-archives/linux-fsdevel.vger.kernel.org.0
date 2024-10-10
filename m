Return-Path: <linux-fsdevel+bounces-31542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DB59984DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 13:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35F431C20CF8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 11:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD681C2DA3;
	Thu, 10 Oct 2024 11:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SQnSp1is"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01951C2435
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Oct 2024 11:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728559397; cv=none; b=sS28m2iQsRxH7GB6ONEv4BOH/8apQIsBrd01NkNGW1iafX54Y6cFPqZO+lM7PEIYTFtE3dRtqXl+/ICD+gwOyFXfTjDzm+oKo8mjGk8Q87fGC0813wQtJCNMB1xyQuAjaH1jUFBsvvPVr9yeKUTFeR3fPduueJYOWLgZ7ru2Mws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728559397; c=relaxed/simple;
	bh=x9iaGYlku1I61w3bKz/b2Pv+BfrZU92jU/nEmEgj4Fo=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=g5F8aEUQqT9HtXVdrZQrl+thR+9eQBcsGqU2TkMHZz6KeHbqS1tMjPWXTOzItjzZLl3Lx9i11Tc3x3ZtQ1tMN0Z6gzg3GXXh36uP9rD/U3dnrhRnilwwQCcHLP6rfwD9wZi113DGFvsazRUqO7s7jKl3a78SWp1Jt/oAGtCNSOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SQnSp1is; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728559394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0NXJ/YlAi2284RdYmfvHVqovUyQSlsXPT+gI0a/FAik=;
	b=SQnSp1is7Xedado3PdV5wjqhxiDGoUWAOxhr83g9Ron1NQTR/+Gz0kliCzoLKGwE5Pv6VE
	GdMSmnG8//Ke4TI2J+ChgPO2WAmHExP8hgGi+/booYr/ZDd/FkpwIb14vk4ACngsI/6o1P
	rUqvdREatQpgyvZYQWv8xhDwqh14qNg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-i8qS1cvJP6ysisq-7AS9jg-1; Thu,
 10 Oct 2024 07:23:10 -0400
X-MC-Unique: i8qS1cvJP6ysisq-7AS9jg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D9F8C1956096;
	Thu, 10 Oct 2024 11:23:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 984581956086;
	Thu, 10 Oct 2024 11:23:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240821024301.1058918-6-wozizhi@huawei.com>
References: <20240821024301.1058918-6-wozizhi@huawei.com> <20240821024301.1058918-1-wozizhi@huawei.com>
To: Zizhi Wo <wozizhi@huawei.com>
Cc: dhowells@redhat.com, netfs@lists.linux.dev, jlayton@kernel.org,
    hsiangkao@linux.alibaba.com, jefflexu@linux.alibaba.com,
    zhujia.zj@bytedance.com, linux-erofs@lists.ozlabs.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    libaokun1@huawei.com, yangerkun@huawei.com, houtao1@huawei.com,
    yukuai3@huawei.com
Subject: Re: [PATCH 5/8] cachefiles: Clean up in cachefiles_commit_tmpfile()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <303857.1728559382.1@warthog.procyon.org.uk>
Date: Thu, 10 Oct 2024 12:23:02 +0100
Message-ID: <303858.1728559382@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Zizhi Wo <wozizhi@huawei.com> wrote:

> Currently, cachefiles_commit_tmpfile() will only be called if object->flags
> is set to CACHEFILES_OBJECT_USING_TMPFILE. Only cachefiles_create_file()
> and cachefiles_invalidate_cookie() set this flag. Both of these functions
> replace object->file with the new tmpfile, and both are called by
> fscache_cookie_state_machine(), so there are no concurrency issues.
> 
> So the equation "d_backing_inode(dentry) == file_inode(object->file)" in
> cachefiles_commit_tmpfile() will never hold true according to the above
> conditions. This patch removes this part of the redundant code and does not
> involve any other logical changes.
> 
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>

Yeah, that's reasonable - and if it did hold true, all we do is unlink and
relink it.

Acked-by: David Howells <dhowells@redhat.com>


