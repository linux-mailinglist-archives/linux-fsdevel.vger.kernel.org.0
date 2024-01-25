Return-Path: <linux-fsdevel+bounces-8831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A141B83B63F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 01:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D10531C22D3F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 00:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648AA2F53;
	Thu, 25 Jan 2024 00:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjVf039j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17EF193;
	Thu, 25 Jan 2024 00:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706143939; cv=none; b=uoPgycZ6+RW/3scGPqz9qpL9X6hyiXcfmLJ+a7ebI9ncSPxmbMW8ykSZi7YfLM2BV86YIg61ZLSP4AE1jJJchCQixQOm8HGfGqNpNfTSDqrmLpYzFgrsk3oMMvKTswYzCMBaI2BHkzdEJt9BweYUbqBepyn4QDlmqBU4LpjAXec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706143939; c=relaxed/simple;
	bh=OC+XjcopZnLmb3krF+LmINeVCFSSzz1GKe4Bd/HF3is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EfsSGH1+EOKHhba5bWNYBRYtKq5By0yfteYIkJy7eQ6Su0YLKeaF7/4MWnTo+QWOHmEJKfAGSuqgZ126UaJ1juAhhBRIglyv1BaxFQYKKoARFrUrSTljJkerej50QcJB3Sh+c1fMaMOXenUyA6B5RZlZuePf4yhwohXMcOVYaCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjVf039j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC799C433F1;
	Thu, 25 Jan 2024 00:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706143939;
	bh=OC+XjcopZnLmb3krF+LmINeVCFSSzz1GKe4Bd/HF3is=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kjVf039jecmwPe9R72x3rAlCy7CKTs7nEXwzknpB92pT0W5/sT6udGTVQ1r1ooKkL
	 QzygMx99xtOFMc3xgRjzEjiK+KWse1MhzwiXhemYGRiX8tYKNg8QrmAsy3j4c2v0R2
	 MG3n1VtEdNMKgyUKQ5qZhb0lvf0cQfJWPcLs5RWaZNvT0nJLMz7b+1jI1i+oY8oMEw
	 DX3Aoi7n6PZuvySPFQic7XTReDwm7uxPykDUoTEr8ORokUt+x2GyV19gA+bKhDYRAb
	 f404L0eJjoURXfAbvQ/nUgC8vpiaVgoUFMq+GyeYm+RXAJCQcF3iwweOPAEx4Z07fw
	 bROl+5bpH/8lA==
Date: Wed, 24 Jan 2024 17:52:15 -0700
From: Keith Busch <kbusch@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
	martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
	ming.lei@redhat.com, ojaswin@linux.ibm.com, bvanassche@acm.org,
	Alan Adamson <alan.adamson@oracle.com>
Subject: Re: [PATCH v3 15/15] nvme: Ensure atomic writes will be executed
 atomically
Message-ID: <ZbGwv4uFdJyfKtk5@kbusch-mbp.dhcp.thefacebook.com>
References: <20240124113841.31824-1-john.g.garry@oracle.com>
 <20240124113841.31824-16-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124113841.31824-16-john.g.garry@oracle.com>

On Wed, Jan 24, 2024 at 11:38:41AM +0000, John Garry wrote:
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 5045c84f2516..6a34a5d92088 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -911,6 +911,32 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
>  	if (req->cmd_flags & REQ_RAHEAD)
>  		dsmgmt |= NVME_RW_DSM_FREQ_PREFETCH;
>  
> +	/*
> +	 * Ensure that nothing has been sent which cannot be executed
> +	 * atomically.
> +	 */
> +	if (req->cmd_flags & REQ_ATOMIC) {
> +		struct nvme_ns_head *head = ns->head;
> +		u32 boundary_bytes = head->atomic_boundary;
> +
> +		if (blk_rq_bytes(req) > ns->head->atomic_max)
> +			return BLK_STS_IOERR;
> +
> +		if (boundary_bytes) {
> +			u32 mask = boundary_bytes - 1, imask = ~mask;
> +			u32 start = blk_rq_pos(req) << SECTOR_SHIFT;
> +			u32 end = start + blk_rq_bytes(req);
> +
> +			if (blk_rq_bytes(req) > boundary_bytes)
> +				return BLK_STS_IOERR;
> +
> +			if (((start & imask) != (end & imask)) &&
> +			    (end & mask)) {
> +				return BLK_STS_IOERR;
> +			}
> +		}
> +	}

Aren't these new fields, atomic_max and atomic_boundary, duplicates of
the equivalent queue limits? Let's just use the queue limits instead.

And couldn't we generically validate the constraints are not violated in
submit_bio_noacct() instead of doing that in the low level driver? The
driver assumes all other requests are already sanity checked, so I don't
think we should change the responsibility for that just for this flag.

