Return-Path: <linux-fsdevel+bounces-53804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50659AF7794
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 16:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FEE1175C28
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 14:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400902ED870;
	Thu,  3 Jul 2025 14:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASEaO95Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D092EBDF9;
	Thu,  3 Jul 2025 14:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751553192; cv=none; b=joGYZTGunu9fuuK4pmtCDnTwZzmkWHPxgsXy0irqwdXYgPWB1Tup4iqDd6X4v+3gqrilr2eukzkMYsPXfS+JgKg4GlVUWlvfuoKycRzX1SXYC+L6uwVxxaUS5pp4qi3kObxES39BgcfwqpAiBwsW6sQGbNN+GsJaClA8BknJbt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751553192; c=relaxed/simple;
	bh=pbnpZTecA/emnfYuNr9pfpPVP71XL99mm/JpD31d6Bo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tW6pUmK21182jVKKjJJb06sUiqMjD80VO+qdAoY3OzA4WrcYBeSO4Y6eiyiqUvOstpaPRuoeJgShkIwi1ipikuKwaAscU70gql0IS1SRwkGBLSPbRfKckdo/uc0LEwe5Tak0mV5B9DyMrahey9RYws6/UCB2fcNxQfS34cwlfcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASEaO95Z; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3139027b825so37568a91.0;
        Thu, 03 Jul 2025 07:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751553190; x=1752157990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6ULj4GSQdITNFr+qLBDFzv5ASstogN2mu1F9t/ePJQ=;
        b=ASEaO95Z+SPOpEHhaEdMvpW4zM+tPmij7fMNC+/2HeErWS9MVS//qKJK6yWSNdg4Mr
         1/29CWYxan8aAwpQrMIAbZczf2Mfq8wJVlQu9fFIkYhUTHtwWk401EXMl+YBePONbgoB
         j1VcRNxz0Dg4oYELzfW+bic8vygVbzO9rqHmwD0nJMy/l2urCoymUFJ6Dc6BcwIAaW8j
         HDRfc07UDpDvfk+fXir/GutVW+pfoO8lB2G2EW6PKVMeOx1Upr+apq6cZA0SLXcBQFbt
         PyC470y/L171Eg/FAjBa+JvtPjZsejuQKAX7SO3wSFkfQLVf9Q+lKYLzmJ/2KUJnQOsP
         GDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751553190; x=1752157990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c6ULj4GSQdITNFr+qLBDFzv5ASstogN2mu1F9t/ePJQ=;
        b=f6sQ9KRl2B1lrjFZbOd6we6CjUAMQ3yy7FmRuG8Pj39ccuV0XOI3AEuaEbqAXMFPPh
         zeOVtQ8CqGBOfqB9aZju7aXMm1jkZ2xPjuuYBsLR9Ih0nCm88RXZ8DNf3AsAPO3dIe4G
         OJiRtdD8XjTF+GtpNGx2ByWHTMdLWZvKMS9v6sRpzesx3xIgHQBjW1CSisI0WoBO2uCp
         dIxN+VSHiST1bxe4UctjNAbK+7IXmbcWU7AVSopXuDTgkag5aXAVH4f+ev+3dEA55Aiu
         jM0L8knZAh0gRuvCXDLTRQLf0xL/8nYfMKyW8s7RW78vBSN2MaVf1tQnGsFVDqlQt5Ky
         lg4w==
X-Forwarded-Encrypted: i=1; AJvYcCV6mZiPKduBuKW+T1f+SMOusDFmGKDUSco7kjUoLnlY7svU9L4464Vh3of0+OUzfnFAfLUxrRUy4HE/@vger.kernel.org, AJvYcCWpoDiOuCOtnPK07puDPNS0EISo4RuroRzf3ZShlZa5P5xf9QPGDi7DVtBTNGP3BGlSEJlqpuxIBe+uwxHh@vger.kernel.org, AJvYcCX8z0dMwS8QLTJYHxnmzqoMNS56drID+Z2Q9/79H7N0MlIXbYPnDJ2PVVRCui4E6ixEUg0l0z5/NALuxLex@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7qPqIV5AGv+CPQUE1YW7qbRecdccHVPnNmMU+BQHlKdMtBWSx
	v8e4NUqUdS5bdAncHjtAgmN2jlNtGAxoitD79ZXc+O/FQJWgtRzC73Jm
X-Gm-Gg: ASbGncs6gy8IFgKLhzmXMZloaS6ryAmMPX4dHPpkbLQoBJE+1JfD3qKjW1sIa/9qLnm
	eCpx13OJnkkVjY5Mby55rQqlfowHFkPA9PHehOxBnZE0DYEq313Kub+bLSJs/PJK+ddHJxK6gSW
	/NPwLxhCgwXTsw0QrBSrIWlj0WxwAUEvX4kbYiz/1v2rH99zSrNNIBOGcih2me84md28njLC5E/
	Zza7uIu3jN3TZdrP2FuvDDdzhKNphoOLb5U7McKykuhBHHhSKRX/nQAn5cjChgn2IMRdTsBVFUH
	Tj7W2SvV9cfQ8p186PFBPL4oaI8kKjAnf6hgBuf6UaN2iis29PuVxBfeDity7aSwPi7S61ifcWA
	=
X-Google-Smtp-Source: AGHT+IFw+K7j7iqmYpcjjjtR+iwrjkgRPl3+q+ppwsYlqqPKEE+ZodtA8iPQzN0yAnBxDlmUm9+6mw==
X-Received: by 2002:a17:90b:3848:b0:315:9ac2:8700 with SMTP id 98e67ed59e1d1-31a9d5c8bcamr4442778a91.24.1751553190359;
        Thu, 03 Jul 2025 07:33:10 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c7c59cbb3sm14972705ad.110.2025.07.03.07.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 07:33:09 -0700 (PDT)
From: Jinliang Zheng <alexjlzheng@gmail.com>
X-Google-Original-From: Jinliang Zheng <alexjlzheng@tencent.com>
To: hch@infradead.org
Cc: alexjlzheng@gmail.com,
	alexjlzheng@tencent.com,
	brauner@kernel.org,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH] iomap: avoid unnecessary ifs_set_range_uptodate() with locks
Date: Thu,  3 Jul 2025 22:33:08 +0800
Message-ID: <20250703143308.661683-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <aGaKoDhuw72wZ9dM@infradead.org>
References: <aGaKoDhuw72wZ9dM@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 3 Jul 2025 06:50:24 -0700, Christoph Hellwig wrote:
> On Wed, Jul 03, 2025 at 08:09:12PM +0800, Jinliang Zheng wrote:
> > ltp and xfstests showed no noticeable errors caused by this patch.
> 
> With what block and page size?  I guess it was block size < PAGE_SIZE
> as otherwise you wouldn't want to optimize this past, but just asking
> in case.

Hahaha, I really want to try -b size=512, but I don't want to turn off
crc, so I can only choose -b size=1024.

By the way, the test was done on xfs.

thanks,
Jinliang Zheng. :)

