Return-Path: <linux-fsdevel+bounces-11303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 049518528D4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 07:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B8111C225CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 06:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895CE15EA2;
	Tue, 13 Feb 2024 06:22:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8885413AC0;
	Tue, 13 Feb 2024 06:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707805367; cv=none; b=k8bhCNasgGzsNcGIoA1hupcCVo4cCvungSTbB2ZxP8V8S46D85PcWS0weG6HRnKP28ir+clo6lt5NCiUPqu/p4aYtp0oB/fr3JWenTTPFBxTBwrUrV/sH44pLvRVAP1k3NbvoAfJeW9RR6hDTgG2qpw+t76OTdtHRBUFGa7KiL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707805367; c=relaxed/simple;
	bh=zaggeW5PbD8pwbwivlNHn2JjNDx0xg7709DJc9vd3qI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RGppDUtjUnA/GW/Yz8JEZR5BZZ/x/QoRLbV+4MEa1s+3+3ME+kENNvnNUemLLPsODa5B/zGgTPcDJOzau0tNcxw4+Fb2soBvWDYhUbPCbukCZ3IsjDXiEnDOerJStFdOCfioaN75wuwLjE12/zCj8HD+8nv7txH29YHGUzgCWY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8D522227A87; Tue, 13 Feb 2024 07:22:40 +0100 (CET)
Date: Tue, 13 Feb 2024 07:22:40 +0100
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
	Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH v3 01/15] block: Add atomic write operations to
 request_queue limits
Message-ID: <20240213062239.GA23128@lst.de>
References: <20240124113841.31824-1-john.g.garry@oracle.com> <20240124113841.31824-2-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124113841.31824-2-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 24, 2024 at 11:38:27AM +0000, John Garry wrote:
> From: Himanshu Madhani <himanshu.madhani@oracle.com>
> 
> Add the following limits:
> - atomic_write_boundary_bytes
> - atomic_write_max_bytes
> - atomic_write_unit_max_bytes
> - atomic_write_unit_min_bytes
> 
> All atomic writes limits are initialised to 0 to indicate no atomic write
> support. Stacked devices are just not supported either for now.

Can you merge this with the next patch?  Splitting adding limits vs
actually using them seems rather confusing.


