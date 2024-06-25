Return-Path: <linux-fsdevel+bounces-22441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E09AD917255
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 22:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A87B2826CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 20:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C979D17CA05;
	Tue, 25 Jun 2024 20:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UROBW369"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B9D3A8CB
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 20:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719346555; cv=none; b=eJPW1xoavBNOXvrc5VasziTyKyIQDxGcJM7LjJrJoWy+f8zHx9M00X7uK1N4TmrLUVNlXG70x0nQDwiqlZxdrtKrElRrmYOn1+Tdlx7QmfWykTQBLhSDHBiHBTK//55G+HD6DNte6nOD/ud6zrj6qrRfHvMArTFJ1Adch6YALDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719346555; c=relaxed/simple;
	bh=ELcWQhB2VgoA2DVOCh723lXJ0P6Db50p6h/pMgxyPzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ntoxelpduf10ch28+gE/tZE16S4lZzHKpIKW31a53An7qgknDit64E85tLCx3DAwi/w35UspWYvlb3U9ntSRR92NPlZsQkDioClZvB9+QLmGAohGZG2PLAqCiZy6GqKajxqj2gM8KKVUZXez3mLumF2PdO1lwA/PGlQszFmBPpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UROBW369; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719346552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6OkjovobCgktWlNO3uxsBo5l0DXloPj5Z0prLakMgBg=;
	b=UROBW369YH8ssc7y4WaoLth7Euwb3OgnZ6Hh5cFo/HREbHO1o+9a4lu3280wk3d+IWPBRA
	N68JIUIKa44XnV9k9oeIiYAkN5fV670BZFOC1Z+lVkjGDSgsWgFTeB3GbrQWjp107IcwfZ
	I5GjVGgQ+6DLyj921zv9cjEO9E20ZPU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-7XcsioedNaeYRaQ0Vn_8Fw-1; Tue,
 25 Jun 2024 16:15:49 -0400
X-MC-Unique: 7XcsioedNaeYRaQ0Vn_8Fw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D0B241955F16;
	Tue, 25 Jun 2024 20:15:48 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.185])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 719051955D88;
	Tue, 25 Jun 2024 20:15:45 +0000 (UTC)
Date: Tue, 25 Jun 2024 22:15:42 +0200
From: Karel Zak <kzak@redhat.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/8] Support foreign mount namespace with
 statmount/listmount
Message-ID: <npjgmcq4fhwucpr3aysbb4gsbxkufsfaruqnpmzemuearxkfmc@3cqlmwrz5l2w>
References: <cover.1719243756.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719243756.git.josef@toxicpanda.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Mon, Jun 24, 2024 at 11:49:43AM GMT, Josef Bacik wrote:
> Currently the only way to iterate over mount entries in mount namespaces that
> aren't your own is to trawl through /proc in order to find /proc/$PID/mountinfo
> for the mount namespace that you want.  This is hugely inefficient, so extend
> both statmount() and listmount() to allow specifying a mount namespace id in
> order to get to mounts in other mount namespaces.

Thank you for this. It will improve the efficiency of tools such as lsns(8).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


