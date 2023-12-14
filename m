Return-Path: <linux-fsdevel+bounces-6072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3BA813204
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 14:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0C70B218D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 13:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F3B56B6E;
	Thu, 14 Dec 2023 13:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N8ubPiEJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D333132
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Dec 2023 05:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702561584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QMlqSzMLtoLhUA6/pSOLSiY6ne++uxerHVPAdydtEYo=;
	b=N8ubPiEJzQV/ckmuxCSbDN+JYdEXaAne69we0MGQVJN1aV8RmF2JFnyApELDayvulJwcmr
	TbQUbAor3ZilgNht4OlFYZXTFzx0PY0ZejCH7+2w+RTaVqKiKRQyDb4acpmAFOpu5s4pU+
	+Bj2Pqr0yd4y57LzMDdAZIV2i2graV8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-Yr6iln9QPreJK0NkIMKRvw-1; Thu,
 14 Dec 2023 08:46:21 -0500
X-MC-Unique: Yr6iln9QPreJK0NkIMKRvw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 514D328040B2;
	Thu, 14 Dec 2023 13:46:19 +0000 (UTC)
Received: from fedora (unknown [10.72.116.126])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 006DAC15968;
	Thu, 14 Dec 2023 13:46:08 +0000 (UTC)
Date: Thu, 14 Dec 2023 21:46:04 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
	djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	dchinner@redhat.com, jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
	jaswin@linux.ibm.com, bvanassche@acm.org,
	Himanshu Madhani <himanshu.madhani@oracle.com>, ming.lei@redhat.com
Subject: Re: [PATCH v2 01/16] block: Add atomic write operations to
 request_queue limits
Message-ID: <ZXsHHA/GeO8PUeaA@fedora>
References: <20231212110844.19698-1-john.g.garry@oracle.com>
 <20231212110844.19698-2-john.g.garry@oracle.com>
 <ZXkIEnQld577uHqu@fedora>
 <36ee54b4-b8d5-4b3c-81a0-cc824b6ef68e@oracle.com>
 <ZXmjdnIqGHILTfQN@fedora>
 <yq1cyv9flkw.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yq1cyv9flkw.fsf@ca-mkp.ca.oracle.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Hi Martin,

On Wed, Dec 13, 2023 at 11:38:10PM -0500, Martin K. Petersen wrote:
> 
> Ming,

On Thu, Dec 14, 2023 at 12:35 PM Martin K. Petersen <martin.petersen@oracle.com> wrote:
>
>
> Hi Ming!
>
> >> +    lim->atomic_write_unit_min_sectors = 0;
> >> +    lim->atomic_write_unit_max_sectors = 0;
> >> +    lim->atomic_write_max_sectors = 0;
> >> +    lim->atomic_write_boundary_sectors = 0;
> >
> > Can we move the four into single structure and setup them in single
> > API? Then cross-validation can be done in this API.
>
> Why would we put them in a separate struct? We don't do that for any of
> the other queue_limits.

All the four limits are for same purpose of supporting atomic-write, and
there can many benefits to define single API to setup atomic parameters:

1) common logic can be put into single place, such as running
cross-validation among them and setting up default value, and it is impossible
to do that by the way in this patch

2) all limits are supposed to setup once by driver in same place, so
doing them in single API actually simplifies driver and block layer, and
API itself becomes less fragile

3) it is easier for trace or troubleshoot

> 
> > Relying on driver to provide sound value is absolutely bad design from
> > API viewpoint.
> 
> All the other queue_limits are validated by the LLDs. It's challenging
> to lift that validation to the block layer since the values reported are
> heavily protocol-dependent and

After atomic limits are put into block layer, it becomes not driver
specific any more, scsi and nvme are going to support it first, sooner
or later, other drivers(dm & md, loop or ublk, ...) may try to support it.

Also in theory, they are not protocol-dependent, usually physical block size is
the minimized atomic-write unit, now John's patches are trying to support
bigger atomic-write unit as scsi/nvme's protocol supports it, and the concept
is actually common in disk. Similar in implementation level too, such as,
for NAND flash based storage, I guess atomic-write should be supported by atomic
update of FTL's LBA/PBA mapping.

> thus information is lost if we do it somewhere else.

Block layer is only focusing on common logic, such as the four limits
added in request queue, which are consumed by block layer and related with
other generic limits(physical block size, max IO size), and it won't be
same with driver's internal validation.


Thanks,
Ming


