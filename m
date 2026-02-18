Return-Path: <linux-fsdevel+bounces-77639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Bt9N+xClml5dAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 23:53:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E9015AB20
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 23:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC0D9303DAF9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 22:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B44338936;
	Wed, 18 Feb 2026 22:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWJIOjMH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FE033890A;
	Wed, 18 Feb 2026 22:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771455184; cv=none; b=ZisOLCFx37MnCDY7+8nrULYYHMTGb1uuJpz8n80NtDyc3E+9v6f73XYw1SviTVeQyuUSncNQTNAfJkj0XM/bd/IivPiufsFUjUy+omSKhMgKKXBp2azbpFQ3QJh8zG3kHYQL2CUt8YmMu5xzkW4fSKakDCijbDvPWQ5MX3GOVRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771455184; c=relaxed/simple;
	bh=BCIFTtYPmDVEkizLoDvYugM/ABUgBixXBXMRKxBTpc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1ACEHJRQ1YOWbzMdwasmTkxV31mQVkknoWOt+3LxGvYZJtzGxD4TCaual7XvslviRFQPTg0TouPkyLn20JiF2P6meOloQSSG5NJ6uhpCZur+J+SOG1uKC/b/e+VNsgZCM00yypUN2tQW84JiTwE2iVdCrPFOH0t1bx34exAWvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWJIOjMH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F5FC116D0;
	Wed, 18 Feb 2026 22:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771455184;
	bh=BCIFTtYPmDVEkizLoDvYugM/ABUgBixXBXMRKxBTpc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VWJIOjMH5Cf6Hc/suRf4PD08QMIK3OvBI8gPpu9c4/qmW7bMzACJ3mZDrtko/t5zL
	 oqmNEf5QVfQASNldIdooROcGd6W8qr5H7Ovk7+93d9+LA1f163+ylaOk5Z9lWPoymw
	 syjXFeSLqos6twHrUVVv1OV+HQMBd9zSxvs4DQt1rUwOUDulJhjns/Nx9c4aOL5Zsn
	 MCdm+msIQEZ9YSOzxeDj6NVqZ+dMn2JywIQ/WhRbzRscHVtbhQR6NybH2n0hUe5W4a
	 /7P0kSxMNo/RhvIT0NlejSgDOWOExzMcvOdgJ8Z5gnoTWcevaAYTru/iGTtZ3QA6Mu
	 AtV3oWUERM+pg==
Date: Wed, 18 Feb 2026 14:53:03 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, ebiggers@kernel.org, hch@lst.de
Subject: Re: [PATCH v3 05/35] fsverity: introduce fsverity_folio_zero_hash()
Message-ID: <20260218225303.GE6467@frogsfrogsfrogs>
References: <20260217231937.1183679-1-aalbersh@kernel.org>
 <20260217231937.1183679-6-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217231937.1183679-6-aalbersh@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77639-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 82E9015AB20
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 12:19:05AM +0100, Andrey Albershteyn wrote:
> Helper to pre-fill folio with hashes of empty blocks. This will be used
> by XFS to synthesize blocks full of zero hashes on the fly.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  fs/verity/pagecache.c    | 22 ++++++++++++++++++++++
>  include/linux/fsverity.h |  9 +++++++++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/fs/verity/pagecache.c b/fs/verity/pagecache.c
> index 73f03b48d42d..7642a7a09dfb 100644
> --- a/fs/verity/pagecache.c
> +++ b/fs/verity/pagecache.c
> @@ -2,6 +2,7 @@
>  /*
>   * Copyright 2019 Google LLC
>   */
> +#include "fsverity_private.h"
>  
>  #include <linux/export.h>
>  #include <linux/fsverity.h>
> @@ -62,3 +63,24 @@ loff_t fsverity_metadata_offset(const struct inode *inode)
>  	return roundup(i_size_read(inode), mapping_max_folio_size_supported());
>  }
>  EXPORT_SYMBOL_GPL(fsverity_metadata_offset);
> +
> +/**
> + * fsverity_folio_zero_hash() - fill folio with hashes of zero data block
> + * @folio:	folio to fill
> + * @poff:	offset in the folio to start
> + * @plen:	length of the range to fill with hashes
> + * @vi:		fsverity info
> + */
> +void fsverity_folio_zero_hash(struct folio *folio, size_t poff, size_t plen,
> +			      struct fsverity_info *vi)
> +{
> +	size_t offset = poff;
> +
> +	WARN_ON_ONCE(!IS_ALIGNED(poff, vi->tree_params.digest_size));
> +	WARN_ON_ONCE(!IS_ALIGNED(plen, vi->tree_params.digest_size));
> +
> +	for (; offset < (poff + plen); offset += vi->tree_params.digest_size)
> +		memcpy_to_folio(folio, offset, vi->tree_params.zero_digest,
> +				vi->tree_params.digest_size);
> +}
> +EXPORT_SYMBOL_GPL(fsverity_folio_zero_hash);
> diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
> index 278c6340849f..addee462dcc2 100644
> --- a/include/linux/fsverity.h
> +++ b/include/linux/fsverity.h
> @@ -215,6 +215,8 @@ bool fsverity_verify_blocks(struct fsverity_info *vi, struct folio *folio,
>  void fsverity_verify_bio(struct fsverity_info *vi, struct bio *bio);
>  void fsverity_enqueue_verify_work(struct work_struct *work);
>  loff_t fsverity_metadata_offset(const struct inode *inode);
> +void fsverity_folio_zero_hash(struct folio *folio, size_t poff, size_t plen,
> +			      struct fsverity_info *vi);
>  
>  #else /* !CONFIG_FS_VERITY */
>  
> @@ -302,6 +304,13 @@ static inline loff_t fsverity_metadata_offset(const struct inode *inode)
>  	return ULLONG_MAX;
>  }
>  
> +static inline void fsverity_folio_zero_hash(struct folio *folio, size_t poff,
> +					    size_t plen,
> +					    struct fsverity_info *vi)
> +{
> +	WARN_ON_ONCE(1);
> +}

/me wonders if something this deep in the IO path really needs a stub
version?  Otherwise this looks ok to me, in the "vaguely familiar from
long ago" sense. :/

--D

> +
>  #endif	/* !CONFIG_FS_VERITY */
>  
>  static inline bool fsverity_verify_folio(struct fsverity_info *vi,
> -- 
> 2.51.2
> 
> 

