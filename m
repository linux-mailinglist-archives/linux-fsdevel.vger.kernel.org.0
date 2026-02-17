Return-Path: <linux-fsdevel+bounces-77345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0N8tMbsnlGkcAQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 09:32:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3602F149F4B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 09:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E9FBE3028117
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 08:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30742E424F;
	Tue, 17 Feb 2026 08:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEEs6nl5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41997275AF0;
	Tue, 17 Feb 2026 08:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771317170; cv=none; b=bse4/CESw9Bw8fvwTObJ6atTlf/sWagh/hkSYzOiTkuhg2GnOQ+VRu1Rk7cz0emATtMMTpqEJVEDamw5yBf9BVghRsS5tFvutjCL+y78d8TVrwGKn1uVahRmN0KyYB0MOf2Cvne1JNHrsNqsjymU/suGH+zTmkAlYc6Noq/yDzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771317170; c=relaxed/simple;
	bh=gxGGcZXN9XagxxSOycI0vC1KukirZ8YXQOvNNscm36o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFBe5ZxcOGTUUONBv+KKeD1a689ByCPY7B2RLEp2Zybexb45hN9D8KkCr+ogcnqQCepG+W3JSVaUYoj8GNp3TEipz9lAZVNiV9V6UuP/21+ZG9wJksEMEMERCTyaj/uIpWHpN/VAmY4HTsm3CmgKjCIRX0o6WqRyVkN2R9C86BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEEs6nl5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B1EC4CEF7;
	Tue, 17 Feb 2026 08:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771317169;
	bh=gxGGcZXN9XagxxSOycI0vC1KukirZ8YXQOvNNscm36o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bEEs6nl5qqphGtyp8xiCn+UO9RJRvy+d9vmzydzqhZa5fE5gVrKLDgZlmKVMn5ZAV
	 SgIty3S5iXNig4uPSKKmu2OwNS//ABPS3XU/TR0m0Isc6Uyvw47opL+3wCJy4r/bcK
	 +HkdbmlalUW4zNmtVGQZsa1lc/sEpDeYjHTVLunCUGLiI6u320ItiR46GuonkK5/jn
	 Vip1w7g3YuGkUvyLY4YOZsiw5EnhFB805yBqJMzn9WCFg/+2oV9AB1LELy8S1mFjWM
	 5VSk9fR+nD5EtIzRde8XxBQ6ftnqRpu7Jw07AERmEauIziqfMKZR+2MokgX0K/9k5Q
	 KmomRX5GDMe7Q==
Date: Tue, 17 Feb 2026 09:32:45 +0100
From: Christian Brauner <brauner@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: hch@lst.de, jack@suse.cz, djwong@kernel.org, axboe@kernel.dk, 
	kbusch@kernel.org, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-block@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [PATCH 1/4] fs: add write-stream management file_operations
Message-ID: <20260217-idealerweise-geheuer-ee86894f4792@brauner>
References: <20260216052540.217920-1-joshi.k@samsung.com>
 <CGME20260216053017epcas5p2d6492dd8c33c6d2453b15d79819d97eb@epcas5p2.samsung.com>
 <20260216052540.217920-2-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260216052540.217920-2-joshi.k@samsung.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77345-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3602F149F4B
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 10:55:37AM +0530, Kanchan Joshi wrote:
> Add three new hooks in struct file_operations to allow fileystems to
> manage write streams at per-file level.
> 
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> ---
>  include/linux/fs.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 2e4d1e8b0e71..ff9aa391eda7 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1967,6 +1967,12 @@ struct file_operations {
>  	int (*uring_cmd_iopoll)(struct io_uring_cmd *, struct io_comp_batch *,
>  				unsigned int poll_flags);
>  	int (*mmap_prepare)(struct vm_area_desc *);
> +	/* To fetch number of streams that are available for a file */
> +	int (*get_max_write_streams)(struct file *);
> +	/* To set write stream on a file */
> +	int (*set_write_stream)(struct file *, unsigned long);
> +	/* To query the write stream on a file */
> +	int (*get_write_stream)(struct file *);

Let's not waste three new file operations for this thing. Either make it
VFS level ioctl() commands or add support for it into file_getattr() and
file_setattr().

