Return-Path: <linux-fsdevel+bounces-67314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F21BC3B835
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 14:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22AC3564A2F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 13:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165122E7199;
	Thu,  6 Nov 2025 13:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XSE13+aG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FC9236A70
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Nov 2025 13:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762436913; cv=none; b=TcBuPKjaTFK97pF6UTts8XaNxJAXdnfs8KecUe4/NjBQuwCUQ/qrbFN2yvQnMZuKHWka81oJsOzJIOWEdW7e0OLDrNDjV0Jmswy7rogdVaBLnvLqtZQJUQNavPEVUl1lIR9owuFOVegtz2IcjcMcKv4/SUw04u7WojJ3fUGRRso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762436913; c=relaxed/simple;
	bh=TuikOT6xWXwFxsuJJ7R+NfK1+n0kSJjfuECC87r7N6E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T/evLPpd7bSwZ+d3OZNrXnznBzo1GTWZM+TPaAa9f/F5bFgFAW8iorbT2Wv3LDz596mVkC7iiVftYA8FqPnNqiGXl7LKhi8VF+qwDh0h97pEz8H+r98nOiVWdGMF5vMw2vYALuGAPQ3Vrz+las2D7YLWLgfzQxThUwgtxeasnjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XSE13+aG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762436910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QoL72t07+fb2NdHff0tfowphC2zMaMnXwcnl9cRu2ps=;
	b=XSE13+aGql/HHkUA3jt1e6TaY76RrJJckHeAnFZeBbfffmJ8B1kle19a2kY7QUXmVaTW+l
	dkdeo5QIvQI6hKiG99wTp/N6kkwhU53u+ACFgfvOcE1MY5scsBNoOuOfhC8p+ySUH1cbUa
	L+pleB2lbE9o/3NyjiHH/tYf84icuqE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-eP0SrYTyN2uUEYoqZvSIQg-1; Thu,
 06 Nov 2025 08:48:25 -0500
X-MC-Unique: eP0SrYTyN2uUEYoqZvSIQg-1
X-Mimecast-MFC-AGG-ID: eP0SrYTyN2uUEYoqZvSIQg_1762436904
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9534A180034F;
	Thu,  6 Nov 2025 13:48:23 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.45.224.98])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BEB491800451;
	Thu,  6 Nov 2025 13:48:20 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Hans Holmberg <hans.holmberg@wdc.com>
Cc: linux-xfs@vger.kernel.org,  Carlos Maiolino <cem@kernel.org>,  Dave
 Chinner <david@fromorbit.com>,  "Darrick J . Wong" <djwong@kernel.org>,
  Christoph Hellwig <hch@lst.de>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  libc-alpha@sourceware.org
Subject: Re: [RFC] xfs: fake fallocate success for always CoW inodes
In-Reply-To: <20251106133530.12927-1-hans.holmberg@wdc.com> (Hans Holmberg's
	message of "Thu, 6 Nov 2025 14:35:30 +0100")
References: <20251106133530.12927-1-hans.holmberg@wdc.com>
Date: Thu, 06 Nov 2025 14:48:12 +0100
Message-ID: <lhuikfngtlv.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

* Hans Holmberg:

> We don't support preallocations for CoW inodes and we currently fail
> with -EOPNOTSUPP, but this causes an issue for users of glibc's
> posix_fallocate[1]. If fallocate fails, posix_fallocate falls back on
> writing actual data into the range to try to allocate blocks that way.
> That does not actually gurantee anything for CoW inodes however as we
> write out of place.

Why doesn't fallocate trigger the copy instead?  Isn't this what the
user is requesting?

Thanks,
Florian


