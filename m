Return-Path: <linux-fsdevel+bounces-11311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B88585293C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 07:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0150284463
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 06:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D144317557;
	Tue, 13 Feb 2024 06:42:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0171426A;
	Tue, 13 Feb 2024 06:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707806534; cv=none; b=t5XsYdAZYsfTRz0h3RxM3x8dRfSdhNsEb6sQKcPEKw7W6uVxu9gLb9J5AVc9HB13H1rg9FanfoDYSfxu9ZzJ83MONUvA4XWeBHVjW3mIKvvj7ScBm9r2sTQnWvlilOsZVerU4W5acscuXyb012oxEbZyklj/UNxDxU4o7CE/ibw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707806534; c=relaxed/simple;
	bh=TsZNgcncZuLlqEzd98D/OCvEddIKhbLcfcoW5HD9JPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZxuZCYbiqctlRSYO+HhqVwc/V/P3Gh85CEvaIvZZyQT+XuByvusLmgweNqwZW+c91FehCHs+vO98aczOkRvjJeJbmvrigMqEoEp43fgGI55hnvQM1/DLbusuvkCnuqPeHTavJEU2+p0eSQ3+OJCR5oWkBRwmC8d+H2esWCvpZLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BB9E1227A87; Tue, 13 Feb 2024 07:42:05 +0100 (CET)
Date: Tue, 13 Feb 2024 07:42:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
	ming.lei@redhat.com, ojaswin@linux.ibm.com, bvanassche@acm.org,
	Alan Adamson <alan.adamson@oracle.com>
Subject: Re: [PATCH v3 14/15] nvme: Support atomic writes
Message-ID: <20240213064204.GB23305@lst.de>
References: <20240124113841.31824-1-john.g.garry@oracle.com> <20240124113841.31824-15-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124113841.31824-15-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 24, 2024 at 11:38:40AM +0000, John Garry wrote:
> From: Alan Adamson <alan.adamson@oracle.com>
> 
> Support reading atomic write registers to fill in request_queue
> properties.
> 
> Use following method to calculate limits:
> atomic_write_max_bytes = flp2(NAWUPF ?: AWUPF)
> atomic_write_unit_min = logical_block_size
> atomic_write_unit_max = flp2(NAWUPF ?: AWUPF)
> atomic_write_boundary = NABSPF

Can you expand this to actually be a real commit log with full
sentences, expanding the NVME field name acronyms and reference
the relevant Sections and Figures in a specific version of the
NVMe specification?

Also some implementation comments:

NVMe has a particularly nasty NABO field in Identify Namespace, which
offsets the boundary. We probably need to reject atomic writes or
severly limit them if this field is set.

Please also read through TP4098(a) and look at the MAM field.  As far
as I can tell the patch as-is assumes it always is set to 1.

> +static void nvme_update_atomic_write_disk_info(struct gendisk *disk,
> +		struct nvme_ctrl *ctrl, struct nvme_id_ns *id, u32 bs, u32 atomic_bs)

Please avoid the overly long line here.

> +		nvme_update_atomic_write_disk_info(disk, ctrl, id, bs, atomic_bs);

.. and here.


