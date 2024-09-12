Return-Path: <linux-fsdevel+bounces-29159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A2D976857
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 13:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D45D1F22487
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 11:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED56A1A3050;
	Thu, 12 Sep 2024 11:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="k2PeLr5o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A427919F430;
	Thu, 12 Sep 2024 11:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726141952; cv=none; b=ZtySKq2eNtM3RwAJr+FCC0DG9WeW4m0pki6Yx6IlS3cnJxZbH2pqQMxiLzjXYzwogc/N+tH5X6b1yasdi4BuQV3U0y6OTbsI+V7t9gw2OQqefzzauF4wFV9Dp17ATwhA7zJ+xX3va8oT/nqoNjoklGpzb4QjeHi9QChaePd7Srk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726141952; c=relaxed/simple;
	bh=UxGGqGI6lmlwBTsPjmRmmN0QPm0qGEImDfB/sQVQ8bE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=In8lOIXlcBbQY1Ir5/0qahGE56L6nyQysCx2ESgFJZ47IuJnaiTIakQdBXIMgKkCD80o32rJNX6NAe0T3LjQklxB2zZQYw9X2LZz1VlYN7C/TyHajlTxQupJUzFcifLIyTfz2tyekbDHU4Q1GP3RV6wlrofM9f27dBfKo93vnUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=k2PeLr5o; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4X4G5J6BGvz9sqq;
	Thu, 12 Sep 2024 13:52:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1726141940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2efnxzDfw9QXH50hbL3FzD+55QgECys/ru4yn8zfnU8=;
	b=k2PeLr5oWvWf7IS9oipKD9+QOfKjHdHpgSJYEFz+iqb6wTTVmreXdXUbugtgqUkZUIuvov
	nKBOD0sHqVg5c+hzNQ3LRrOqIJ8YUScQJvzfxoOKvs1hPFba6ATJE/MbVxUUgmNqLfaSMp
	sIBYj+JbENONVdT3dbHzgflJT4O0Dx51bsI5veNB0ditUZYoHYZx2Lyd/+Q3roZ7TPoTIh
	AbSWizv7VoM9EEpaiEEcxY9wNnYKTR/A2gmcJ9mr2lglVpSuqZfRU4XecEvLgcQGe1j/9Y
	wtLtmDgWFHPGOM8V6dxRTn1Az2Vb0dvlcNjzd5QrHu2Z0qe30NEZBDnak7IUTg==
Date: Thu, 12 Sep 2024 11:52:14 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Jonathan Corbet <corbet@lwn.net>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-xfs@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH] Documentation: iomap: fix a typo
Message-ID: <20240912115214.omoenw2bdz5zi4rt@quentin>
References: <20240820161329.1293718-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820161329.1293718-1-kernel@pankajraghav.com>

ping @Christian.

On Tue, Aug 20, 2024 at 06:13:29PM +0200, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> Change voidw -> void.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  Documentation/filesystems/iomap/design.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/iomap/design.rst b/Documentation/filesystems/iomap/design.rst
> index 37594e1c5914..7261b1b2c379 100644
> --- a/Documentation/filesystems/iomap/design.rst
> +++ b/Documentation/filesystems/iomap/design.rst
> @@ -165,7 +165,7 @@ structure below:
>       u16                 flags;
>       struct block_device *bdev;
>       struct dax_device   *dax_dev;
> -     voidw               *inline_data;
> +     void                *inline_data;
>       void                *private;
>       const struct iomap_folio_ops *folio_ops;
>       u64                 validity_cookie;
> -- 
> 2.44.1
> 

-- 
Pankaj Raghav

