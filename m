Return-Path: <linux-fsdevel+bounces-79809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sD4JIU75rmnZKgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 17:46:06 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 074EB23CF72
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 17:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 457A8306706A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 16:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09B03A7F4F;
	Mon,  9 Mar 2026 16:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMW6vxKm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C89C238C23;
	Mon,  9 Mar 2026 16:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773074090; cv=none; b=MWKsBXIErLYOdzV1rAi8fnYt2WeIBItsB7Q4PBoZp3yCkpIr6tQBoTJ1guaFeOTTMhXDbc7iLQyseiMd9yZ8EX++zldVcLNkdoIxJNZ5kAmh6Ka4/nYak41x/Co2us6iibN0NTB2CVc0eHWVwYuQknv7cPTage8OmMgB4wGBAT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773074090; c=relaxed/simple;
	bh=H2j4+gkiNfMb8WlOpGA2EOv2lRQiRzHSZ57+uNmC+PM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYPuKtpn+uoKQ/VeLzvRzJAcU7PIZ0Cnbt0+ppO0JqFQ4FZqiDlcCv+eMTx73DUnz/8MKzuumI3aH/AWrBG202cRLaZk9kLPL/Jh1dFbLToB7jF7j/u+6GJ2538mci4yMek0bNmqEegnQEEU36j3OnUcfGK0h3xrGfzWZhSJMS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMW6vxKm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11093C2BC86;
	Mon,  9 Mar 2026 16:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773074090;
	bh=H2j4+gkiNfMb8WlOpGA2EOv2lRQiRzHSZ57+uNmC+PM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uMW6vxKmJxHxLitAohuVtFbImFqRS9KfKirVTf9RhHrabE4k2nLNN7Iufh8fqTxu4
	 ggK+li00QW5g/lvccCFOR7ek+Pqa2AO6CglKt4HbBpC5C7BeKx6L99qJJrsVWGH7nE
	 dF8YwiDBDNPQInnSr+TkGNkSsvGxw3D8fj2oyzsW8/0lFJg+9kMrTVHUiVxmCy9Ff7
	 PSI85tGmI6OZPv9Yzbqltr99SunOlGeyV6kHHoXocGGCoVJqckLxFFOJJ/UnFAcHBV
	 tgBa2peFtIi4+MDZ5+JmfdVUUiJPsNjkGHts0ICP8muyy+3cd3jQreRMfcwGyk1lWL
	 7s10xzsY4hsuA==
Date: Mon, 9 Mar 2026 09:34:49 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: brauner@kernel.org, hch@lst.de, jack@suse.cz, cem@kernel.org,
	kbusch@kernel.org, axboe@kernel.dk, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [PATCH v2 2/5] iomap: introduce and propagate write_stream
Message-ID: <20260309163449.GF6033@frogsfrogsfrogs>
References: <20260309052944.156054-1-joshi.k@samsung.com>
 <CGME20260309053430epcas5p3db87d346a4a816f385becac0212cd3ab@epcas5p3.samsung.com>
 <20260309052944.156054-3-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309052944.156054-3-joshi.k@samsung.com>
X-Rspamd-Queue-Id: 074EB23CF72
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79809-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.932];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,samsung.com:email]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 10:59:41AM +0530, Kanchan Joshi wrote:
> Add a new write_stream field to struct iomap. Existing hole is used to
> place the new field.
> Propagate write_stream from iomap to bio in both direct I/O and buffered
> writeback paths.
> 
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> ---
>  fs/iomap/direct-io.c  | 1 +
>  fs/iomap/ioend.c      | 3 +++
>  include/linux/iomap.h | 2 ++
>  3 files changed, 6 insertions(+)
> 

<snip>

> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 99b7209dabd7..e087818d11d4 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -113,6 +113,8 @@ struct iomap {
>  	u64			length;	/* length of mapping, bytes */
>  	u16			type;	/* type of mapping */
>  	u16			flags;	/* flags for mapping */
> +	/* 4-byte padding hole here */

It's 3 bytes now, right? ;)

> +	u8			write_stream; /* write stream for I/O */
>  	struct block_device	*bdev;	/* block device for I/O */
>  	struct dax_device	*dax_dev; /* dax_dev for dax operations */
>  	void			*inline_data;
> -- 
> 2.25.1
> 
> 

