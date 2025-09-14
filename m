Return-Path: <linux-fsdevel+bounces-61254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D9EB568B1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 14:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEF7E3A4F01
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 12:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982912561D4;
	Sun, 14 Sep 2025 12:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQuRA5o2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C3E57C9F
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Sep 2025 12:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757853610; cv=none; b=iBXqtivMHGJfu0/fWB6SBcHnu8Dc2TlKO05NCkBwQSZ6lc2vkHIoL856kTnIWsjLiV7oTfGStF6m+Pi+XAc287E7fpd5evOMj7VcWQ+bmQXgy/s3k6JC0qu7kPT6rlwtvVzrjAFQht+A0YcOPByuMspyH+WtgmbzQvp6LNZJJs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757853610; c=relaxed/simple;
	bh=Dh+wk2yoqrWCD8TB+uPwRbLtPIr4/5QsJ+QbZo4yO/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cHGUkVsSBqfrHGDb7tKlTZmRHUUbLitJHOQZlq6djrvi5l26YRVxbNB3qr2M1nvzhx/XRb8XiG+rzRqFeyo1/JbR5mhHd20AAvWgugDhq/QnL/Gj9WfYlVSWfrKQtr91lKMSYDUUVBH4Q/tCCayrD+g6KEyZ0Jwgj2bOcWUByJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQuRA5o2; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b54a2ab01ffso2273026a12.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Sep 2025 05:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757853608; x=1758458408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQf2AGsnl6vclYwp9c3+fOFIkP4apfGdDfRnsEWxb3w=;
        b=cQuRA5o2MTkN4YKbYLM3zCEfwS4QWMKylpaAOPTH1jHZXCQsyFSE7fIE/rGGaRdTX+
         BYGXZBQNRZo2qOY9g1Sz2RKD4QniFAuXUC0nJoU8OUfGwjhPdFLp0eM17IT5wJ6pnBJt
         56dY+s98IWWfFybwKywcKLcx5AqYBQzxRp2mRZnz0Y5iXgav8wuMeiMjY1qSz/M5kxyy
         0eMPi3lxWPPM0Kchfl7XEYUViR0fe34WTIZaqnYxQcgGuQufC2N0MPSCQJCViOW4UeVN
         u/P3YEHyr48v72K+ihyj9gTSJlEQeRvVnWwq9Tnq+nQIXZVB4nJk8WOqa3gKQx/NIV+D
         3cuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757853608; x=1758458408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FQf2AGsnl6vclYwp9c3+fOFIkP4apfGdDfRnsEWxb3w=;
        b=BzpRwQ77U6k8xOpFNLYpGvTLBdbAOi7b/yWkYX9TWpSM5cD/GZ4saRd9nZCa3F6ug6
         HUrisw0xYEFwBunG7C8jhWlbWGbkZZnjZ2jSWddiXo2S9nDC8Dug9Xz0ABtUwSNiFPM9
         DJfFP+94bP/kKJFwLUM3Z/Be77vboMfA+66XgcSES7WoW3v2gLCWv1L+CorMV99Io90B
         zNn7wxXLl8Q0WM5hOb3uY4q8olF7fTTxCi9TbYMVTXc9CWEDv1TVJ5adDurK32r0MVmf
         ekYmCT//cma4xUd5QBqmRgRZp7chDyHEwSGVdg0LJqrbb017tEzmRTA+YKxWP6yNsKta
         D9fw==
X-Forwarded-Encrypted: i=1; AJvYcCWafChW9aoiuN7JN7NZA33OLEDelr/ktt3yC2hAwdMtSCIJJyZZxp2B1sN/oLTXix4bUtbQjBCe/NQfmFEF@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr1woPGRptmU68g5+1r4C0qC3X7L/mX75ldk8SbSYYtdBVq1bd
	d2/q5Jz97YAGbYCVRlP7nX9iC/MVMAO6krv23X1jJWlD3fnDBK9upLS4
X-Gm-Gg: ASbGnct165m6Jf6f3Ecjs+Lni//0ppQgO3+AZlIz0MLtGgfaXoVvcXXs2/+ILPKz/Ul
	8KfMyom4Wc1ElyVrOK5meJFjPAmHYwoB/yV/LPfFUpth4HXboeNT58i9HIsQkQJdkTz5LL15HR/
	WNC9Q6yosgr4rIsIJAfQJGUGUElaR/9eEuFdTo8JFXFFozaHdBe+IObuFypKxnf42SNYcnPH8Yd
	vEF4Xlgq3HiaYpl/7p7IZDYZXf/iCBe8LeIeMgkjWvMBYbzzxOt72YYhojpnhb3/bSv1Eoq8XLL
	u2P98NRrRE3obDSou00mPh6wJ0P1vDtLyb3jlXx7orJg4atmWrwl4y6toTYM1378XQq4eUA8QZT
	DF0QXn8meDt+nNfIQvOdZobxZeticK9wFxQB85XN5D0pDzCvSXbMxX/w=
X-Google-Smtp-Source: AGHT+IEqALl6Dr8zeTny4Ila1tLRwXJarsJ+CPNRvQ0gp8DtgtwVdOv93ajULAIsNdfEu/GQETTTtg==
X-Received: by 2002:a17:902:ced2:b0:23f:fa79:15d0 with SMTP id d9443c01a7336-25d27142f24mr114645185ad.46.1757853607940;
        Sun, 14 Sep 2025 05:40:07 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25fc8285639sm49876965ad.134.2025.09.14.05.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 05:40:07 -0700 (PDT)
From: Jinliang Zheng <alexjlzheng@gmail.com>
X-Google-Original-From: Jinliang Zheng <alexjlzheng@tencent.com>
To: kernel@pankajraghav.com
Cc: alexjlzheng@gmail.com,
	alexjlzheng@tencent.com,
	brauner@kernel.org,
	djwong@kernel.org,
	hch@infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	yi.zhang@huawei.com
Subject: Re: [PATCH 1/4] iomap: make sure iomap_adjust_read_range() are aligned with block_size
Date: Sun, 14 Sep 2025 20:40:06 +0800
Message-ID: <20250914124006.3597588-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <vath6pctmyay5ruk43zwj3jd274sx2kqbjkfgvhg3bnmn75oar@373wvrue5pal>
References: <vath6pctmyay5ruk43zwj3jd274sx2kqbjkfgvhg3bnmn75oar@373wvrue5pal>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 14 Sep 2025 13:45:16 +0200, kernel@pankajraghav.com wrote:
> On Sat, Sep 14, 2025 at 11:37:15AM +0800, alexjlzheng@gmail.com wrote:
> > From: Jinliang Zheng <alexjlzheng@tencent.com>
> > 
> > iomap_folio_state marks the uptodate state in units of block_size, so
> > it is better to check that pos and length are aligned with block_size.
> > 
> > Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
> > ---
> >  fs/iomap/buffered-io.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index fd827398afd2..0c38333933c6 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -234,6 +234,9 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
> >  	unsigned first = poff >> block_bits;
> >  	unsigned last = (poff + plen - 1) >> block_bits;
> >  
> > +	WARN_ON(*pos & (block_size - 1));
> > +	WARN_ON(length & (block_size - 1));
> Any reason you chose WARN_ON instead of WARN_ON_ONCE?

I just think it's a fatal error that deserves attention every time
it's triggered.

> 
> I don't see WARN_ON being used in iomap/buffered-io.c.

I'm not sure if there are any community guidelines for using these
two macros. If there are, please let me know and I'll be happy to
follow them as a guide.

thanks,
Jinliang Zheng. :)

> --
> Pankaj

