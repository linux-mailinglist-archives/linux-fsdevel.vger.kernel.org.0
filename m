Return-Path: <linux-fsdevel+bounces-66548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 760E6C234AA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 06:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B22941A27FDD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 05:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258961F3B87;
	Fri, 31 Oct 2025 05:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mhtoG/hR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DD45C96
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 05:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761888871; cv=none; b=cdrX+1vLuAk2s8GHX8zuMq2i3Te1DMm91sBpcGH7KRFvAkifWfy27n4NZN7Y82QoQmeUvktdBReWqGHe2o03zgauCYY75+0YeDB+Pq30H2TZE1WHAhUKwVxM63rkR/CZSqW9MhbMkwn553AT+RJp2ru25Th1OJjx7x4Ty3TOX58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761888871; c=relaxed/simple;
	bh=pbVHIF8g09eSBjGpsv4+LA+UoYiBlI25rt4MHjy3G58=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=P9GJEtb6cSEDymoV3AqBEDtk/J9+MTU6MFtYDzl2W19fBsGawjX1PFf3h6SSH7oWYgdwapJYb1BQn5p3ZbNKU6G2M8Aq4WLkfI++8P3HtzrJ9btXfZfuy8n7Hwk3i16+6C0dT+2/iSEzI7XK3SmT6nn92S4Hi+Fs1buWUZwLwks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mhtoG/hR; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4711810948aso13605415e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 22:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761888868; x=1762493668; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cMQhl9FabmGIHnZV2ZPiNA/xuVX+sV4Emo8zsUnt4uI=;
        b=mhtoG/hRGEm4pvAmG4A6DgVmhP9xZajdIibhjxoRCSM20Mig3WoQVcqsH3gG2/IIHJ
         oL3xwK8EdQtpuY1USqgifSKawqv9LJylpmxjeocmOGytTuU7Tdp5Wk4+f0Khslq8O+qA
         kwQ2FQklGMwB3X/rXDFNEvGCq4KGpPH/PPyCz+Mi/g0pZdQrBE2jVUx8kaXbBY/mUani
         qh2V4W8cMMF6XAuZNrSEIuvEihBhw85kafNlKldE92Brz1uwy8+j/53YxjewfXudX2lJ
         zAWUDebm9Ih+fBMTcmGbuFsetFfRsLIV1qGadLLWzBVkWcD9mdHyIMEV/fDu7sAdwq9M
         SKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761888868; x=1762493668;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cMQhl9FabmGIHnZV2ZPiNA/xuVX+sV4Emo8zsUnt4uI=;
        b=glwoTELmja9uEX/9Q1pgWs8v2yq1bul0/hocTZDy+I/SmwzKNbK24dstssQzMffaMl
         EuGu93Ee4yrCEm7ltfbv6UtS+gO7LU2K5KzvYksClLylcXOmHLSlPqgVtvNK2xIYc/X4
         XZnkOKbN1EuJd563tqqrxXu4PDT7KUOJPXOFvWma+JURPsJhqb51TVyadPFackR5LotJ
         mcPYQDVrX6cQCYcHA45J4+5DUCmgBbEE8wiSRoTwpGtdNpOTLPCoSnP/2RHZ/0eEzM6v
         lUFWZtw8ovim/PZc428ezDR5OKv+9MjdBi+WKkw1ye4QHIuYKcDkL4soaFMV48er84x8
         JGxw==
X-Gm-Message-State: AOJu0YwueO29Tq4SrVKYUwI9v6QFvuoJF63JZlHegrDuqmkf3cBEMTpv
	0T8o0bV5wDA9nLljMRKquBu+9MJKDWgjsrOmJmtOw1xReJ715w7B2SIzYLktjZVnWpA=
X-Gm-Gg: ASbGnctoLmX442qDKwipwgvXpxZ1TCWE2WvjWpngvEMjW4OEES2bfh3b0i0OMPC4yvx
	LDEVN2D4CQgM1/BiYngU7mRxR5FYykavHNtq2qo5ahtOyPZJ42Z6LkoGsdn4t63EmJ4Rpd+WmAn
	THbD+Od8fjTgqEMV1lVXOe09gTKGtd1/4vPd7vOCpHfD4pkz5GlrhJ335YcSFM7Vd5DoX29KCAi
	O4848W0GEffKsmh/Dq4bG81paKUDouhdVJnHUKvuUZnzsWS+LZDg0TyklAGoK4cWdx7IB/Ghp+X
	4vNqVdyoomVxZzv/nKRz46jQTQ1ginMPNa8m44IR6svJyXpGn9Kg7YwjPNOFAUrkdyLDlNeP41R
	XCH6UdDajkJHASGzqadsdsiyyhui44DpeldyHEJAOKd4NyWnrmcCbqUBLCnBNLPPcDCAaUm4beN
	o9SCKDp3jjofK5T0X7
X-Google-Smtp-Source: AGHT+IH04o1fFGnLi7WSnIep89aNTcoUNVIz/Pk+locjuzIYM+lU9+S5J/MDuS6M16uXIBzW1n/fyA==
X-Received: by 2002:a05:600c:524f:b0:477:bcb:24cd with SMTP id 5b1f17b1804b1-47730873b47mr17208885e9.22.1761888867461;
        Thu, 30 Oct 2025 22:34:27 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429c110034fsm1476764f8f.8.2025.10.30.22.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 22:34:27 -0700 (PDT)
Date: Fri, 31 Oct 2025 08:34:23 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Subject: [bug report] iomap: track pending read bytes more optimally
Message-ID: <aQRKX5q34Xug_Hly@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Joanne Koong,

Commit 51311f045375 ("iomap: track pending read bytes more
optimally") from Sep 25, 2025 (linux-next), leads to the following
Smatch static checker warning:

	fs/iomap/buffered-io.c:547 iomap_readahead()
	error: uninitialized symbol 'cur_bytes_pending'.

fs/iomap/buffered-io.c
   526  void iomap_readahead(const struct iomap_ops *ops,
   527                  struct iomap_read_folio_ctx *ctx)
   528  {
   529          struct readahead_control *rac = ctx->rac;
   530          struct iomap_iter iter = {
   531                  .inode  = rac->mapping->host,
   532                  .pos    = readahead_pos(rac),
   533                  .len    = readahead_length(rac),
   534          };
   535          size_t cur_bytes_pending;
   536  
   537          trace_iomap_readahead(rac->mapping->host, readahead_count(rac));
   538  
   539          while (iomap_iter(&iter, ops) > 0)
   540                  iter.status = iomap_readahead_iter(&iter, ctx,
   541                                          &cur_bytes_pending);

Smatch worries that either iomap_iter() or iomap_length() might be
false on the first iteration.  I don't know the code so it could be a
false positive.

   542  
   543          if (ctx->ops->submit_read)
   544                  ctx->ops->submit_read(ctx);
   545  
   546          if (ctx->cur_folio)
   547                  iomap_read_end(ctx->cur_folio, cur_bytes_pending);
   548  }


regards,
dan carpenter

