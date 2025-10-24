Return-Path: <linux-fsdevel+bounces-65521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAD4C06A87
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 16:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D11CE19A6647
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 14:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4263218B2;
	Fri, 24 Oct 2025 14:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnUnte83"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB896320CAC
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 14:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761315125; cv=none; b=cePuvv4FFpoklQRgaYmCDYbAfj6E3ntPrLlXFUa3MhaH7Eqh/iq5TwfmDwJUWQ0EsC/YNDZZG/CUDiCj+J5MYKCu5v0/rk8y4ORI6PqJpFM3rFKJa37nEaRUYLUqZZLLe5/hFmqB68Zwdc89t3/MTw0E4PLCFEFB93V7l5CC0Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761315125; c=relaxed/simple;
	bh=HN4SG8Tc9Lo4RABBZetdrW5lu5OU2pYnC/8jcLCSPDo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=K1RJXxX0Z758MmMOaXNcvWxNQ5lHkvbXOaIhqRVGNW7iwhjLDbOf3FylN8opHNNhxUSTAo2nQU+sBh1X2mKj1/cKUSZ3I+lAM+oMXc9ddxL4WDx4sG0BWQbnaPS5FRyuLj0FPoJO5QFqxSXjfS8TeRcdVTs2I4YoJuTzGdHX+Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gnUnte83; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b5a631b9c82so1418421a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 07:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761315123; x=1761919923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SxjAAwvJxcKyZkTF4DfQc6OYD277RCMtejBYyIJXDsE=;
        b=gnUnte83eRgANIufkHhT4H6ixg/SOQ/MPYY37MLmWcIlUN9L+zwkyqJcOpl1dc0EVE
         jkn/DxSk24ONiyIprFWe8/VXt1ynoKYPSvRHhlDNCZDyHIopkjXwANvVK3nqsyGTuiuT
         hj2azbQLCMm0pkwVXp+auukoHA/8ll0tM81CDHdI+cf/TP5sJx/AYRckxRZe6bJiGStA
         qQWVw4wO8+F+pKIXUyKBW2ENgwqBMuBX9U5FUA1OfnrIbXth35v4XexF/NVyvxUE+dcJ
         8Mmm2QiiwN5O5AKxcn/prT5L/DSYNzAQENCwMD0R/ft/6ckNR5KBC5uL9d91pmzAiJN6
         OS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761315123; x=1761919923;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SxjAAwvJxcKyZkTF4DfQc6OYD277RCMtejBYyIJXDsE=;
        b=H3ISx7Tj5JJwCqOlQqsGwjTYlP28xd/ykkE5+izPjPRbB9sjrsQOgEMUfJhfQDKYCR
         vwktSqbgG4rKwaa7SBT+GeTybJciE5noDvoqFQcC5WhlmISMYcSy/jHQeMry2TE0CX1D
         x+ri2sq02qZvZMbNHaXtLbBNtRKx+yi/szNGZEQLUFfAUdTsyFdQ1s6KFFPgPgx5HI1Z
         q4DHQqDafm3Rk/6USarncEp6RePFwOIJWLK1fL9l1KklgYtQrBSeRw9FjBYN8oeorhma
         0imDbuKBuIJAELqswtK2Vn9Y3Mc/vD3cfgwsyDr6i/csJZzw8CzDi6MC2Upde2DqckuH
         rmzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIh2dc2lqUpQ0ho9zrHJC+XC0fOyRAHaDJEmCI3ZEjwonPd5aVatF+aTdRSY+6t+ekQEXrrmTKywMCL2v6@vger.kernel.org
X-Gm-Message-State: AOJu0YwE0aed12WSwBwuBv4oh0YUcyGGJ7Bt/ZXb77pCDlsognrO3Vjg
	4ESrF4REOMLo7tUlUDMLEo8KXZmvhcPzWfT3+P81ZF9obEv0cEzdwW4+
X-Gm-Gg: ASbGncuRirbE4viK4u8fKoZl3Pn3VoIypmniq0KziBPg8+EfF/mRpkc86FEFuT0J7Ct
	JHJwo/Ty0KKYTVFqIoEWAZY7TQvC+PxBovzeas9xMJwZcLDLhzyBxEI6UC0/m24OOynYLMQEt1j
	cyOIUUgtswJwMCW9DpzUCkGjq2umeFMKHZFDJBG/j4nP2LS+9Ivu5jD5A4Qmy3q2DqWlAdKZXOj
	gkCrksM7CVjSc4EBeOtmqqNE3720guzm7Xw0BFQTxG4z3gXKrgF/AonaydgACMDYHicB+YVhqRq
	injTXMPK+qLQFJBzHCVwbvcUyQa39lPtowESxcOpLi/jPL3MO8+0uPPhBlfxtKsCO5jjTIFaxdK
	CwRo7KeudiIdjW/5ODRXUhI0bYQTtCSODT+JvtIX89FfischiZsXq1Ty4gr+QsC1978bqhtNadN
	hCRkRokcLkUhQck+25/9ui/PgOst/+tWHE186ryETB4Q4g0I22EkdUgCirNmf715E=
X-Google-Smtp-Source: AGHT+IHvWUViWUbcO4jFDmrP4XCETisDqYKqzRJMqbtZ69yGInyTHi+Yd9XnBN1TIdB68GJvKa9mEg==
X-Received: by 2002:a17:902:e543:b0:282:ee0e:5991 with SMTP id d9443c01a7336-2946e0eb3cemr82154295ad.30.1761315123024;
        Fri, 24 Oct 2025 07:12:03 -0700 (PDT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com ([49.207.202.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dfd05dbsm57178835ad.54.2025.10.24.07.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 07:12:02 -0700 (PDT)
Message-ID: <c45c71ce0c3dcd321807debfe580c86cc185623a.camel@gmail.com>
Subject: Re: [PATCH 1/3] writeback: cleanup writeback_chunk_size
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>, 
	Jan Kara <jack@suse.cz>, Carlos Maiolino <cem@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org, 
	dlemoal@kernel.org, hans.holmberg@wdc.com, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, "Darrick J. Wong"
	 <djwong@kernel.org>
Date: Fri, 24 Oct 2025 19:41:56 +0530
In-Reply-To: <20251017034611.651385-2-hch@lst.de>
References: <20251017034611.651385-1-hch@lst.de>
	 <20251017034611.651385-2-hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

On Fri, 2025-10-17 at 05:45 +0200, Christoph Hellwig wrote:
> Return the pages directly when calculated instead of first assigning
> them back to a variable, and directly return for the data integrity /
> tagged case instead of going through an else clause.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/fs-writeback.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 2b35e80037fe..11fd08a0efb8 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1893,16 +1893,12 @@ static long writeback_chunk_size(struct bdi_writeback *wb,
>  	 *                   (maybe slowly) sync all tagged pages
>  	 */
>  	if (work->sync_mode == WB_SYNC_ALL || work->tagged_writepages)
> -		pages = LONG_MAX;
> -	else {
> -		pages = min(wb->avg_write_bandwidth / 2,
> -			    global_wb_domain.dirty_limit / DIRTY_SCOPE);
> -		pages = min(pages, work->nr_pages);
> -		pages = round_down(pages + MIN_WRITEBACK_PAGES,
> -				   MIN_WRITEBACK_PAGES);
> -	}
> +		return LONG_MAX;
>  
> -	return pages;
> +	pages = min(wb->avg_write_bandwidth / 2,
> +		    global_wb_domain.dirty_limit / DIRTY_SCOPE);
> +	pages = min(pages, work->nr_pages);
> +	return round_down(pages + MIN_WRITEBACK_PAGES, MIN_WRITEBACK_PAGES);
This looks fine to me since this simplies the overall structure of the code. I don't think this
introduces any functional change.

Reviewed-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>  }
>  
>  /*


