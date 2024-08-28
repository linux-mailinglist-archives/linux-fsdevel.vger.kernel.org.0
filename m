Return-Path: <linux-fsdevel+bounces-27612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA705962D6D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 18:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AEC9B20CD9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 16:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF96A1A3BD2;
	Wed, 28 Aug 2024 16:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fqKmwyhs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36561A38FA
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 16:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724861694; cv=none; b=FDf/Y9V7aSJkA+7ooyl7SnM3EWOFk6301u0YtZLYSI4gGbKk7jzRKSRa/TyhohpwLCPTuvRJfjq0TxLJYazne8spRT5mkP5GbzyYNQZ3iM1S6+pmS9yp0EvMGtzu042AIkA2YRzr90W3yNndn4Xygwonp3sP2VBtyYV9+i+8XoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724861694; c=relaxed/simple;
	bh=7FGxU1+SHbAVv8pRNHhBLmltkerfyg2mQ/Ca/+AJ+l0=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=KnJk7VhfFjK8uujZaxvVSzL8SMsDbeytfOXdGO1orXHNdBmfN5VOsIoIj1t2eqjnkN+tMXyyTuezBW7vsl7jpJFNlF2+sGNKr0/hJz545CgjloPOle2t1B2z5RSc1NFRLnfykl0mJXv7+FGtmau73wWGoGO5ItHpkwzn7/dvaOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fqKmwyhs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724861691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7FGxU1+SHbAVv8pRNHhBLmltkerfyg2mQ/Ca/+AJ+l0=;
	b=fqKmwyhs/4o9sqRot/fEcT6Mft8DP1BE/S1hmLSHTWFAzD27v/3M093/bhidP8ZhMsaod4
	5tyLymKhfwe6/6Z1qfgfjsRruQHiOoWD+nF0EwE+afzUPXXb5IVsDaC8gR1EJHxJhJtqhW
	VwW0CW3k7UfcH2+hvUxzQMAl3k1DHyg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-132-4Po9ynhuPUCy3Q3CwKL4bw-1; Wed,
 28 Aug 2024 12:14:47 -0400
X-MC-Unique: 4Po9ynhuPUCy3Q3CwKL4bw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7DEB11955BF9;
	Wed, 28 Aug 2024 16:14:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.30])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5C37519560A3;
	Wed, 28 Aug 2024 16:14:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <11c591fd-221b-4eeb-a0bd-e9e303d391a6@huaweicloud.com>
References: <11c591fd-221b-4eeb-a0bd-e9e303d391a6@huaweicloud.com> <5b7455f8-4637-4ec0-a016-233827131fb2@huaweicloud.com> <20240826040018.2990763-1-libaokun@huaweicloud.com> <467d9b9b-34b4-4a94-95c1-1d41f0a91e05@web.de> <988772.1724850113@warthog.procyon.org.uk>
To: Baokun Li <libaokun@huaweicloud.com>
Cc: dhowells@redhat.com, Markus Elfring <Markus.Elfring@web.de>,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-erofs@lists.ozlabs.org, Jeff Layton <jlayton@kernel.org>,
    stable@kernel.org, LKML <linux-kernel@vger.kernel.org>,
    Christian Brauner <brauner@kernel.org>,
    Gao Xiang <hsiangkao@linux.alibaba.com>,
    Hou Tao <houtao1@huawei.com>, Jingbo Xu <jefflexu@linux.alibaba.com>,
    Yang Erkun <yangerkun@huawei.com>, Yu Kuai <yukuai3@huawei.com>,
    Zizhi Wo <wozizhi@huawei.com>, Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH] cachefiles: fix dentry leak in cachefiles_open_file()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1043617.1724861676.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Aug 2024 17:14:36 +0100
Message-ID: <1043618.1724861676@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Baokun Li <libaokun@huaweicloud.com> wrote:

> > You couldn't do that anyway, since kernel_file_open() steals the calle=
r's ref
> > if successful.
> Ignoring kernel_file_open(), we now put a reference count of the dentry
> whether cachefiles_open_file() returns true or false.

Actually, I'm wrong kernel_file_open() doesn't steal a ref.

David


