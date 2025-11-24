Return-Path: <linux-fsdevel+bounces-69717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A58B2C8291B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 22:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 794F04E38D7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 21:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF8D32F747;
	Mon, 24 Nov 2025 21:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="NjQGvZlI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C037A32F745
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 21:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764020707; cv=none; b=gOGvf0PzlfTaSsbM5omexiKhi7X6to7bt/VkZr8V3vwbgz5n+WjLGwRZ/LJcK9nGoJyE/pRZBDcTKI5oZU5zVlrXsHV2BzA/8s4Afk2A9aUedp5LNMEyasIakpPmyvGXKuC9LPW7gOF5s+BM116QsmSD0PWcc4aEOXUJJNntruY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764020707; c=relaxed/simple;
	bh=OaNWkI/dcdAcPXpsXS3qagJygp7RcWHNYazgBaL9VHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSDbaE+XRHIOhyRLiuhsCereTxiXRGSZ8BhQRCi5JAIooMmqLD/7iEWNAlR0mNyAtGUxDiNzPeHuQgsCIQL93Xzy3W2Q0skcZpl7G2vVlTwZ9dsVfwivjUe+e5nQPb+f3f0zsybaO529h62UQprjh4fVaPXuG+YMiTWPsU58e8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=NjQGvZlI; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7a9cdf62d31so5892407b3a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 13:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1764020704; x=1764625504; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NNsv43i2OQvz5OLalVIeDlNVznNw7I+brpQstgAAtI0=;
        b=NjQGvZlI/efA2Krjxf2G2UfgRDA+QKb98VRbff+ryCOfIP9pkbox5xA+m09/IdA2FM
         2BMGaxETaqIY2PTy5YFIO0vu6G+GxcCkG9fwDvG1rkIJrJ3oEol8uR16xk6JdQEIP6qt
         B3w63peg6f/WP96A33NHcqraHoJp2Z2nG1xVKzgFyq05tECv5A1EVrDeP+/KM8Gfovgh
         mVsUD5TaqzvsHABGmnaQjl4AfGvRN4SpoSVC6YHMyRwKi9523NCYXeCybWvSaJjDmVfe
         0QT6wU6Huj022QTRGDJu9DG1qCC8WVt/o+wanlyeOrU/Vop/FOXdVKWRYaqC6r2+5kcX
         qwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764020704; x=1764625504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NNsv43i2OQvz5OLalVIeDlNVznNw7I+brpQstgAAtI0=;
        b=Gwi/29G0tq3H0KqnwS9cRH+gXrdjBxLJdcAyAXoI6w53+fY844Hjrya93i7DvGVTOs
         LCxJzr+KA5uaX2eKaLFbJQuivrZY451lkm2YIYampZr8kbkLd73GmCfv74kgXmhJXubv
         njKAuHpSoxbadZLZ+qgOiYWbfzWmCeo6NedPKBsMyjtvTswFEHg/f/T/p0dhME6PyKPD
         w71BMTBU0Ag/jtz4pL53YinjSTuxq4ZwYL+5CQTB7SH8y7zQVWyN3V5KFgzULOo8HS8K
         W42eU/DCEcGoY2hpNOhT1iIih2GW4O5dP/5+9pq+TpeAzKpxKyfukoXWjeR6zpD+vekw
         AJYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWc40lblBkpSMIYnO6y9Iy9LNkZ/yjzMzBZuMKLatBrTaOtM18lCOlYXuYRB7OU7ufm4fknnGh361gxPV8F@vger.kernel.org
X-Gm-Message-State: AOJu0YzLm9mDfnJAxxNZazX1TY7D18ipLDKFyuOzXwZP6aJeyMVyeklp
	+5l30xDekeXx42hLQ3q20w41oAijsrDrgD0nYAbvnJt3/QulCUQcwR9MlW2K+Gsobms=
X-Gm-Gg: ASbGnctuxUcE3jSafaZS+tL3fVSaqlD68qtzUnievhNWA6EcGyoMalV7B6ROaK2vtfe
	tOHI66Rp7HZtimYhxthQhxqvpry6s12pEb0fxgMRWXEmjEKPDE/c3pEHGhFR+TIYLkO2A1oqp2P
	/BICKDDsc7nfYn6Rf4HSuUoFeUzgy5d8pQBWz0XmBtGVJtLrkynIv1BZDiwOIapbDaMbe650ryM
	UWUIyD+JgcMvvSyudZDbYZcp+L3G1sv3AYDJvzpcyRBLqH57HCFhwlHfroECg1ZhLxaAMFvxfWM
	aTtwRX7FScpf6pxF6ykOTBTpBaYvuQguaLxZ2psxxNbwCUbbbvYMaOpIoU1Ezs/Nw6xBwg2mVYH
	TxPgi8C+I+KaGDA+npAyKzZvjsdKO7zKj1LrCshoFdswXQZRxGfPjQXWK7SP5tT5NGmmXiyx7fw
	WVqwWtXlIb3+fBS/m1d6KWJaX8p9xWAMOYFPzR7M5+WgW2VKD1JmZmLmhJUsk2ztIV5e/WLKIL
X-Google-Smtp-Source: AGHT+IFQ0iEszH1nQ1G+8yhmc9CMltmxx8poRoBcqEr7VQXYIww2OLcCM1ETLiHMegh4RpRMW7/QIw==
X-Received: by 2002:a05:6a20:729f:b0:361:2d0c:fd81 with SMTP id adf61e73a8af0-3614eda84f6mr15126034637.28.1764020703700;
        Mon, 24 Nov 2025 13:45:03 -0800 (PST)
Received: from dread.disaster.area (pa49-181-58-136.pa.nsw.optusnet.com.au. [49.181.58.136])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd75b61c29dsm14087028a12.0.2025.11.24.13.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 13:45:03 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1vNeMm-0000000FGss-0B2V;
	Tue, 25 Nov 2025 08:45:00 +1100
Date: Tue, 25 Nov 2025 08:45:00 +1100
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@lst.de>
Cc: brauner@kernel.org, djwong@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	syzbot+a2b9a4ed0d61b1efb3f5@syzkaller.appspotmail.com
Subject: Re: [PATCH] iomap: allocate s_dio_done_wq for async reads as well
Message-ID: <aSTR3GHyAZKdRCqo@dread.disaster.area>
References: <20251124140013.902853-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124140013.902853-1-hch@lst.de>

On Mon, Nov 24, 2025 at 03:00:13PM +0100, Christoph Hellwig wrote:
> Since commit 222f2c7c6d14 ("iomap: always run error completions in user
> context"), read error completions are deferred to s_dio_done_wq.  This
> means the workqueue also needs to be allocated for async reads.

The change LGTM, so:

Reviewed-by: Dave Chinner <dchinner@redhat.com>

But I can't help but wonder about putting this in the fast path....

i.e. on the first io_uring/AIO DIO read or write, we will need
allocate this work queue. I think that's getting quite common in
applications and utilities these days, so filesystems are
increasingly likely to need this wq.

Maybe we should make this wq init unconditional and move it to fs
superblock initialisation?  That would remove this "only needed once
for init" check that is made on every call through the the IO fast
path....

-Dave.

-- 
Dave Chinner
david@fromorbit.com

