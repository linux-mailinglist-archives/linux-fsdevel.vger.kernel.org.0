Return-Path: <linux-fsdevel+bounces-43606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE2EA596ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 15:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C00AC7A6535
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 14:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD4622C356;
	Mon, 10 Mar 2025 14:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SMBotOoi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BA022B8AA
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Mar 2025 14:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741615247; cv=none; b=mP9BvvcrNsy3lgj1Lsip6oF2TZ4+F+iqOiujQhj/+qBWG8jti/PAqjkRaVVh80HP/MGn0lS+iWLWxOHAWuJbgevp6zC32lVFXbOA+/Xl5PIgcGFmRNOzLy5mZZKMNPXc52QbKSJFuXWL3ph4MVKsW3kVmkh7MTlwW/QgXowlxac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741615247; c=relaxed/simple;
	bh=7pN5a36PdMZWwRnB1EFOzJ2DjXF1TQyqQPKJFRNyJf0=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=dZst8wDEGMGSpGsBT48COOa1eNI06psHw8Rzu76/2pM6Y8/uCewQS3+6jKr2vTYTPmIrb7poZN8156yj4v5HfAIqJR4mUtxgDRbXXyr03eler7DcNDBXdWaNfW/u6yqhLeLx2ouikkEFUhTv0DKcxbHkRF7sgqsNGkXOuUisoQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SMBotOoi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741615245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/c+igC9XeGnpuXHYAUzk9J+PiUHEadMR4DUZba3bROg=;
	b=SMBotOoiOV+EEOwCPJNfr+Lq3nnlsw0cgihKwoDvOmBXO112KWLJ362DVC9dFQyG5d14n9
	9kZOaJHJstEXqJ2JPmM+3u4QkBR/T3pvMts1BZaMS0HLj4x/JkfAaLPr+IfcsUJsyqJ4Hn
	Fy2J8Pr/hmcqvTmod5lrNBsV4U6HRtk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-456-XDB2LGcpN8202Dm2B8rLBQ-1; Mon,
 10 Mar 2025 10:00:41 -0400
X-MC-Unique: XDB2LGcpN8202Dm2B8rLBQ-1
X-Mimecast-MFC-AGG-ID: XDB2LGcpN8202Dm2B8rLBQ_1741615240
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B93C18001F3;
	Mon, 10 Mar 2025 14:00:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.61])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 05A0119560AB;
	Mon, 10 Mar 2025 14:00:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250305194437.59309-1-slava@dubeyko.com>
References: <20250305194437.59309-1-slava@dubeyko.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: dhowells@redhat.com, ceph-devel@vger.kernel.org, amarkuze@redhat.com,
    idryomov@gmail.com, linux-fsdevel@vger.kernel.org,
    pdonnell@redhat.com, Slava.Dubeyko@ibm.com
Subject: Re: [PATCH v4] ceph: fix slab-use-after-free in have_mon_and_osd_map()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1006062.1741615236.1@warthog.procyon.org.uk>
Date: Mon, 10 Mar 2025 14:00:36 +0000
Message-ID: <1006063.1741615236@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Viacheslav Dubeyko <slava@dubeyko.com> wrote:

> The generic/395 and generic/397 is capable of generating
> the oops is on line net/ceph/ceph_common.c:794 with
> KASAN enabled.
> 
> BUG: KASAN: slab-use-after-free in have_mon_and_osd_map+0x56/0x70
> Read of size 4 at addr ffff88811012d810 by task mount.ceph/13305
> ...
> This patch fixes the issue by means of locking
> client->osdc.lock and client->monc.mutex before
> the checking client->osdc.osdmap and
> client->monc.monmap in have_mon_and_osd_map() function.
> Patch adds locking in the ceph_osdc_stop()
> method during the destructruction of osdc->osdmap and
> assigning of NULL to the pointer. The lock is used
> in the ceph_monc_stop() during the freeing of monc->monmap
> and assigning NULL to the pointer too. The monmap_show()
> and osdmap_show() methods were reworked to prevent
> the potential race condition during the methods call.
> 
> Reported-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

Reviewed-by: David Howells <dhowells@redhat.com>


