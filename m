Return-Path: <linux-fsdevel+bounces-26256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0924956A24
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 14:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77D271F233A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 12:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1626C16728E;
	Mon, 19 Aug 2024 11:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fcIdoSFc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71E915B972
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Aug 2024 11:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724068792; cv=none; b=il9RKuem99/Y/+OOsYsrflIf5jnel9nCGmIQDmqMxsomEyA6JIy6mt1P3KosYah1KofDHAvz4OkLdo9WxL1Qnwd+EKHr8PjnxBhaqbMXiejGx/mZplba3DscZ5s7gFVB7LCC+4ornmZ1rSSuUB5jFU5+z9+Z7Dsbx+eq2IL8R8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724068792; c=relaxed/simple;
	bh=QoDrXZXFlLjJRrcfSVsie6OGUkt4QrKIKGi1LCthZaA=;
	h=From:In-Reply-To:References:Cc:Subject:MIME-Version:Content-Type:
	 Date:Message-ID; b=G6fHAFyJXU/heHU43lRSZViBserTMwO6dpBqaMBZlfBifdOy4m9f08Tn51AW51B9QmSp67z57kxt+y91lhiJ8K3kYbY43CTt87NPQgnDqhseIesOp/J4aQ6H75opycG/ykYF60hhNQAytdunkcMI0vyLFp+kKQN4kFnsn2VBiF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fcIdoSFc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724068790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nSDk9RrUaqqTiS3gE8YAv0OqBuyGmh41yRuUpfpoLP4=;
	b=fcIdoSFcs5Je/WCbx4Cd0nSI4raS0XCY8LIrHF31HvNoRE7APrAq9Wd/LHbzB9A+l/AbSs
	0vmVXYmyK077RxdFPg9GP/HXJihasEquVAnESo2K1gfrAkaT4nwMR1TFb+r54z2UPRwH0h
	ig0zBdZGA6sT6Mi03OrCcRZdkZCtJdc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-y-oQF2GQOyaLK-9XZ_4nzw-1; Mon,
 19 Aug 2024 07:59:43 -0400
X-MC-Unique: y-oQF2GQOyaLK-9XZ_4nzw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8403F1954B1D;
	Mon, 19 Aug 2024 11:59:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.30])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AEB1619773E0;
	Mon, 19 Aug 2024 11:59:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <3402933.1724068015@warthog.procyon.org.uk>
References: <3402933.1724068015@warthog.procyon.org.uk> <20240818165124.7jrop5sgtv5pjd3g@quentin> <20240815090849.972355-1-kernel@pankajraghav.com> <2924797.1723836663@warthog.procyon.org.uk>
Cc: dhowells@redhat.com,
    "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
    brauner@kernel.org, akpm@linux-foundation.org,
    chandan.babu@oracle.com, linux-fsdevel@vger.kernel.org,
    djwong@kernel.org, hare@suse.de, gost.dev@samsung.com,
    linux-xfs@vger.kernel.org, hch@lst.de, david@fromorbit.com,
    Zi Yan <ziy@nvidia.com>, yang@os.amperecomputing.com,
    linux-kernel@vger.kernel.org, linux-mm@kvack.org,
    willy@infradead.org, john.g.garry@oracle.com,
    cl@os.amperecomputing.com, p.raghav@samsung.com, mcgrof@kernel.org,
    ryan.roberts@arm.com
Subject: Re: [PATCH v12 00/10] enable bs > ps in XFS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3405742.1724068772.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Aug 2024 12:59:32 +0100
Message-ID: <3405743.1724068772@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

David Howells <dhowells@redhat.com> wrote:

> You can see the invalidate_folio call, with the offset at 0x4 an the len=
gth as
> 0x1ffc.  The data at the beginning of the page is 0x78787878.  This look=
s
> correct.
> =

> Then second ftruncate() is called to increase the file size to 4096
> (ie. 0x1000):
> =

>  pankaj-5833: netfs_truncate: ni=3D9e isz=3D4 rsz=3D4 zp=3D4 to=3D1000
>  pankaj-5833: netfs_inval_folio: pfn=3D116fec i=3D0009e ix=3D00000-00001=
 o=3D1000 l=3D1000 d=3D78787878
>  pankaj-5833: netfs_folio: pfn=3D116fec i=3D0009e ix=3D00000-00001 inval=
-part
>  pankaj-5833: netfs_set_size: ni=3D9e resize-file isz=3D1000 rsz=3D1000 =
zp=3D4
> =

> And here's the problem: in the invalidate_folio() call, the offset is 0x=
1000
> and the length is 0x1000 (o=3D and l=3D).  But that's the wrong half of =
the folio!
> I'm guessing that the caller thereafter clears the other half of the fol=
io -
> the bit that should be kept.

Actually, I think I'm wrong in my evaluation - I think that's the region t=
o be
invalidated, not the region to be kept.

David


