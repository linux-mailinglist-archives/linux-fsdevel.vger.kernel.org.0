Return-Path: <linux-fsdevel+bounces-13393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C07986F58F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Mar 2024 15:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E59FB1F22B45
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Mar 2024 14:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AD18473;
	Sun,  3 Mar 2024 14:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7pv2FWh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFF567A0C
	for <linux-fsdevel@vger.kernel.org>; Sun,  3 Mar 2024 14:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709476845; cv=none; b=FlCPzlne+FKEiisPhlphoaeXK6QS++M7+GK08XX2CMQs1KuSSLIe8STAtEroWvQHv53gDoQDE3BspHdbFkePvJdEnyVfnecx49AUugN2oDQsl+TmDPUfKuTb87Q7CSAeT8OjR11Pw3f1MWcIIf2E2Wp2QQxlgaGhnXAzgWaByYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709476845; c=relaxed/simple;
	bh=LKXtvi2GbUg24k5GH13WXIduLeQOXvN8DwdbcPiIFe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbcJcueoriKqWvfTh/C58AEh7XR4C7fxD+bqSvhgm/cG4z67ArynDdvv2l3j8+BLr5anHIHiMBZYTS+sqTQkd8lLxsWSiRtD0GDru3kZK+KOEv8ZQGmrT/0X8oPnils8qGhE1/L0mWpkQF61+mc3ZfqdfvlRuFh2Z9GQET9tgc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7pv2FWh; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dc96f64c10so33513605ad.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 Mar 2024 06:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709476843; x=1710081643; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tTSvD1+bysWnBBVVUOpiyXASEgIOf7/EpxqRyWfY6DQ=;
        b=h7pv2FWh3fJq5DBHG//RBH2gHvWo90lSLZYnqD1M9X4nKyd4sxRualusXp4PfdMprR
         59R8CEeGinyNYJQGkDA8rSiFa7fQZ2bwwLIIxKkJ4ujrdwddkHp+Hd8z0ESXdjNkkks7
         a+qejBLNldxWr4Q6mu6U6TQuwzi6QnednTP/6DKaWMCGWBM+aBJxxYDoU0wALLcMkqSw
         aV1e2sQwXzS5vUwrqmnsVGAVy5K8Z1xOoeZz8ilwTs7xP3c/2lGtopJ/tIDQtbBQTlLU
         iRcdYn8MNnfRhS4NJyVIyL6hge8gUOr3OuiI1ra/giw2MvwxM5Lih9F4C2WX32N7ARtU
         hl2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709476843; x=1710081643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTSvD1+bysWnBBVVUOpiyXASEgIOf7/EpxqRyWfY6DQ=;
        b=ZvgamUUmOPKLqOaLKVQv1pUs0CojY8uGA7KtybOcyjrK5IRAq/k2IMv3lSrB3wfo1Y
         lD/ToobYu4Lua5go5EDzgKApj3a+hrQXfEjSu81w2VW2bqvB4V05v5gfLQIORnTPPUB4
         92tmtHHZAoFbrD3w3zreUlyuBJ/sSWLFQgt99hopPJX+6CYzEr7/soBXMsvhU+znyzx2
         jsLuiqc4lWx+ILpUbqcNOp4nmKFTbscaIna+sZcwZnhmWGAbMwo50baCsq38+65iqQzT
         RoVTVbJzJwn0BAothFRW/fY6uLb4akB1+d+AD9o627sJoKvX3xyOUacm/H5ubcX58utt
         OA9g==
X-Forwarded-Encrypted: i=1; AJvYcCWffvoMSDfVm6Ko0wjqgobnYT12fpazmOItif1Wr3FZEqDBqfRlx8WhSV5Sv9gM/+UekGroAZRgCzZIw7UsLUdPrTSeJKy2hJZMz6bFOQ==
X-Gm-Message-State: AOJu0YyPQ/KVeBHaWQrXCEMzGHl1680X1rjGFTKtTllD4is3gWuHN/L3
	3butaqoamxFkSmzmiOXgJ4kqtGLHOFs9lx9GBhhLcvlJzGhf988beJe4eKgVT2Q=
X-Google-Smtp-Source: AGHT+IFGXmte6TUh6I01+ykyb/kiBMn/QZnevyic/Y1oQbL+1s9cSIoiuzxZZ3J28VHZsLhdY6OZbQ==
X-Received: by 2002:a17:902:e841:b0:1dc:c93e:f5f5 with SMTP id t1-20020a170902e84100b001dcc93ef5f5mr9337953plg.12.1709476843443;
        Sun, 03 Mar 2024 06:40:43 -0800 (PST)
Received: from desktop-cluster-2.tailce565.ts.net ([137.132.216.132])
        by smtp.gmail.com with ESMTPSA id u12-20020a170902b28c00b001dc94fde843sm6699059plr.177.2024.03.03.06.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 06:40:43 -0800 (PST)
Date: Sun, 3 Mar 2024 22:40:39 +0800
From: Han Xing Yi <hxingyi104@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Xarray: Fix race in xa_get_order()
Message-ID: <ZeSL553Gwajt7dPE@desktop-cluster-2.tailce565.ts.net>
References: <ZeM0CBHF3mfz847s@desktop-cluster-2.tailce565.ts.net>
 <ZeRo2Y_RKEZ2op4i@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeRo2Y_RKEZ2op4i@casper.infradead.org>

On Sun, Mar 03, 2024 at 12:11:05PM +0000, Matthew Wilcox wrote:
> On Sat, Mar 02, 2024 at 10:13:28PM +0800, Han Xing Yi wrote:
> > Hello! This is my first patch ever, so please bear with me if I make some rookie
> > mistakes. I've tried my best to follow the documentation :) 
> 
> Thanks!  This is indeed a mistake.  Probably a harmless one, but worth
> fixing to silence the warning.

Yeah, it is probably harmless since the RCU write means that either the
old or new value will be read, but not a temporary value. Thanks for
pointing this out!

> Annoyingly, building with C=1 (sparse) finds the problem:
> 
>   CHECK   ../lib/xarray.c
> ../lib/xarray.c:1779:54: warning: incorrect type in argument 1 (different address spaces)
> ../lib/xarray.c:1779:54:    expected void const *entry
> ../lib/xarray.c:1779:54:    got void [noderef] __rcu *
> 
> so that means I got out of the habit of running sparse, and for some
> reason none of the build bots notified me of the new warning (or I
> missed that email).

I'm so sorry for this mistake, I did not build the kernel with sparse
when testing the patch. I'll be sure to do that next time around. 

> This is such a common thing to do that I have a helper for it.
> So what I'll actually commit is:
> 
> -               if (!xa_is_sibling(xas.xa_node->slots[slot]))
> +               if (!xa_is_sibling(xa_entry(xas.xa, xas.xa_node, slot)))
> 
> but I'll leave your name on it since you did the actual work.

Thank you so much for fixing my mistakes and your quick response on
this, I really appreciate it :)

