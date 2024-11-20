Return-Path: <linux-fsdevel+bounces-35267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 074859D3523
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 09:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1080282FC1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 08:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FA8189B8C;
	Wed, 20 Nov 2024 08:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AxTXJX7s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2391C1482F2
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2024 08:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732090505; cv=none; b=eRIdnvWvLRhgOo2+tJxvaRfuP8MT7VttEna28DhBRtOpwwS+WjEhhxOf6By2kqaf7u+h19KikPi2zI8L2HSzyvHa1uNMigMabsQ0GXevru+LRU/2mSnvtZjlIgd/S3aevJniE6qsx4IKsb50rshQ4/nM2dMRRbGdEHJ2+zUtRnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732090505; c=relaxed/simple;
	bh=+fkx++0GLLxsDzLbfCega13ttZUztcy2M1kwpi034Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZfvWSffRvRYMV9/uZ5t9bMs/H8s/kVOrkW28iHdvU8Baonm2PRgbduts7CVcaai5jKQCWgSxLADEo3SbbmN0EqpcNQ5XMGcb9gqdwdGVkPfw6WhRSKxLSvUfZcx+5Lc1hg38CoG+0CFaNNjrIN7Jkx49Og1GVflE44stKXNGag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AxTXJX7s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732090503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gh6m/YaiQcWez3DW3gpI7yQKGyz075BISLGCEYs6JIY=;
	b=AxTXJX7sFRjPxKptNgJpKUiZdPvNvaZnBXdt78lybn9GvMFz5+/ltTl0jFL21tYRNdqtyo
	um60Jp1nNKrnILjUJwba6QUUOkJ0qH2QW1yvyHipO27F3D8qEn+mXKquVSO+9XItCElpeZ
	FLIDC4lhCSF0onQG8T2UOdmGZ25Ps2Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-pqFBDy8RM8a5-PwqnLhryw-1; Wed,
 20 Nov 2024 03:14:59 -0500
X-MC-Unique: pqFBDy8RM8a5-PwqnLhryw-1
X-Mimecast-MFC-AGG-ID: pqFBDy8RM8a5-PwqnLhryw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1D3F9195608B;
	Wed, 20 Nov 2024 08:14:57 +0000 (UTC)
Received: from localhost (unknown [10.72.113.10])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C9E9B19560A3;
	Wed, 20 Nov 2024 08:14:54 +0000 (UTC)
Date: Wed, 20 Nov 2024 16:14:50 +0800
From: Baoquan He <bhe@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kexec@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 02/11] fs/proc/vmcore: replace vmcoredd_mutex by
 vmcore_mutex
Message-ID: <Zz2aekArHaIT4JU5@MiWiFi-R3L-srv>
References: <20241025151134.1275575-1-david@redhat.com>
 <20241025151134.1275575-3-david@redhat.com>
 <ZzcVGrUcgNMXPkqw@MiWiFi-R3L-srv>
 <9160c6b4-f8a0-431d-8a21-ead510a887a1@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9160c6b4-f8a0-431d-8a21-ead510a887a1@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 11/15/24 at 11:04am, David Hildenbrand wrote:
> On 15.11.24 10:32, Baoquan He wrote:
> > On 10/25/24 at 05:11pm, David Hildenbrand wrote:
> > > Let's use our new mutex instead.
> > 
> > Is there reason vmcoredd_mutex need be replaced and integrated with the
> > vmcore_mutex? Is it the reason the concurrent opening of vmcore could
> > happen with the old vmcoredd_mutex?
> 
> Yes, see the next patch in this series. But I consider this valuable on its
> own: there is no need to have two mutexes.
> 
> I can make that clearer in the patch description.

That would be great and more helpful. Because I didn't find the reason
about the lock integration and avoid concurrent opening of vmcore in
cover-letter and logs of the first few patches, I thought there have
been potential problems and the first few patches are used to fix them.


