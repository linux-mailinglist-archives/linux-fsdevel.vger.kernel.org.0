Return-Path: <linux-fsdevel+bounces-77549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNCUImGKlWnqSAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 10:46:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A05154D6C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 10:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B9DF3037C17
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 09:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9C933D6F8;
	Wed, 18 Feb 2026 09:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJC7wVz1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2D726B777;
	Wed, 18 Feb 2026 09:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771407929; cv=none; b=P2ZmFHjp2wcSkY+yMTFuLx4tKjsOa3JOv97eoA1F9SYObF0YhZiQrXF9Qy1McMGMECqpfLwPAuRvDW2RdsJrEcWHCTcZWD6WjXd4O/RexRYCim2gWfOXSGO2VlUEJQto6ZjxeL5yS1o4AtzrgXgmvyzz+yIrjdvdyUAcJoN1DcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771407929; c=relaxed/simple;
	bh=0rMIGcKCo1/SG381bSDcLjwoJRtfCuEaKetv2VJJ8H0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/BxouhxNAcRocTxxeWNy9jHs9OEsMTklcdv+vzg1jsT+DTLeGjb2zvtCYS0wzBaewnosa9ZL6OJg2aD3aRow6bd1JGgB0soMGRDNVbljdr7ugZDb7OHhZL2U7PKFEBEYF3iVFCZx4KhfElP+hUWPy18xTjXvLboQd1IceOlw7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJC7wVz1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47734C19425;
	Wed, 18 Feb 2026 09:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771407928;
	bh=0rMIGcKCo1/SG381bSDcLjwoJRtfCuEaKetv2VJJ8H0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IJC7wVz10gkzrAvViJaEhHvG0WQAEb54EW/wHnccnbIlBOXUY1TC9BU+4mOwzwExe
	 DpjukWZRCvE5pf+qknxiqs90Xr3UD+k+NfT4/KPwRH7x+hjxcnLxtguuOhFHIb19yT
	 z16m1WlOsgRGxIq2wlktjCqtFrP0Ry1gQc+yVT4YXfvxWZzp+fcUITaidTS6x3tCtP
	 WhrWABbdLZNa1cJjNachkj5xrjxZjdJ3hwwZyRzmfl+wrrVG+YpMJhzbUUGBy34PP5
	 w1eZnO+ZzOB+NGQFPj1qh/Q7pauCT5ex95awrAbJdloBg94pYXknbt30llIoAA04Jl
	 8/vdb05/ky+bQ==
Date: Wed, 18 Feb 2026 10:45:23 +0100
From: Christian Brauner <brauner@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: hch@lst.de, jack@suse.cz, djwong@kernel.org, axboe@kernel.dk, 
	kbusch@kernel.org, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-block@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [PATCH 1/4] fs: add write-stream management file_operations
Message-ID: <20260218-nordost-anstecken-eca372cb5d58@brauner>
References: <20260216052540.217920-1-joshi.k@samsung.com>
 <CGME20260216053017epcas5p2d6492dd8c33c6d2453b15d79819d97eb@epcas5p2.samsung.com>
 <20260216052540.217920-2-joshi.k@samsung.com>
 <20260217-idealerweise-geheuer-ee86894f4792@brauner>
 <4ac9befb-e99b-4e7a-9b04-aec6da3b837a@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4ac9befb-e99b-4e7a-9b04-aec6da3b837a@samsung.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77549-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 42A05154D6C
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 12:48:55PM +0530, Kanchan Joshi wrote:
> On 2/17/2026 2:02 PM, Christian Brauner wrote:
> >> diff --git a/include/linux/fs.h b/include/linux/fs.h
> >> index 2e4d1e8b0e71..ff9aa391eda7 100644
> >> --- a/include/linux/fs.h
> >> +++ b/include/linux/fs.h
> >> @@ -1967,6 +1967,12 @@ struct file_operations {
> >>   	int (*uring_cmd_iopoll)(struct io_uring_cmd *, struct io_comp_batch *,
> >>   				unsigned int poll_flags);
> >>   	int (*mmap_prepare)(struct vm_area_desc *);
> >> +	/* To fetch number of streams that are available for a file */
> >> +	int (*get_max_write_streams)(struct file *);
> >> +	/* To set write stream on a file */
> >> +	int (*set_write_stream)(struct file *, unsigned long);
> >> +	/* To query the write stream on a file */
> >> +	int (*get_write_stream)(struct file *);
> > Let's not waste three new file operations for this thing. Either make it
> > VFS level ioctl() commands or add support for it into file_getattr() and
> > file_setattr().
> 
> In hindsight, I should have added a single 'multiplexed' file operation.
> But can move to vfs level ioctl instead. Will this [1] be reasonable?
> 
> [1]
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -337,6 +337,20 @@ struct file_attr {
>   /* Get logical block metadata capability details */
>   #define FS_IOC_GETLBMD_CAP             _IOWR(0x15, 2, struct 
> logical_block_metadata_cap)
> 
> +/* Structure for FS_IOC_WRITE_STREAM */
> +struct fs_write_stream {
> +       __u32 op_flags; /* IN: operation flags; GET_MAX|GET|SET */
> +       __u32 stream_id; /* IN/OUT: stream value to assign/query; for 
> SET/GET */
> +       __u32 max_streams; /* OUT: max streams supported by file; for 
> GET_MAX */
> +       __u32 reserved;
> +};
> +/* Operation flags */
> +#define FS_WRITE_STREAM_OP_GET_MAX     (1 << 0)
> +#define FS_WRITE_STREAM_OP_GET         (1 << 1)
> +#define FS_WRITE_STREAM_OP_SET         (1 << 2)
> +
> +#define FS_IOC_WRITE_STREAM            _IOWR('f', 21, struct 
> fs_write_stream)
> +

Fine by me.

