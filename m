Return-Path: <linux-fsdevel+bounces-33993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 867049C147E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 04:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6954284EEB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 03:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B37C7E76D;
	Fri,  8 Nov 2024 03:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxE13bSS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C3617BA0;
	Fri,  8 Nov 2024 03:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731035995; cv=none; b=d3u50NeNoPvTbrHm5Y570LB3E1lgO2gRrRYVNhczQEMXcN4xllBNci2vNhHGMbkafX+QwqnRZ7S+sPjWWvL0dC4rmXUMNl+YNgqxzSiA43bB7Hm3JAOLUvkM1ZQGxf1vUnr/0+j6nNRtPOG7rnFfi6FqsH8TVJV1T2INl2fQmDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731035995; c=relaxed/simple;
	bh=SUjoOFCyuT4GLnFM+2bjsubmYWyhU7BtXnVpW2vcPcI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=axsT7X7u10PPENisNyuaRvNDjt2tMLhMvCH1wIXkZimahcicYYh0emMjojIpKKmUW+bPJ/34ZRAMauKNBZiA1bIlknYgNt+ud06PCHYIUyO7v+LrZ4PBuT2NkozLgpVj3YkpqdQVEkVUPbkHpzguvZrVbpjxxyHqmAukRylSua0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxE13bSS; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-2e2e6a1042dso1343929a91.2;
        Thu, 07 Nov 2024 19:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731035993; x=1731640793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSFWQaJAAY4ILwfVQzc5M0r+FjAN96iZg9Zg5lN4R+w=;
        b=JxE13bSS62f18VGZWYSbF95n244O+41hQqnyHrxxPBP0dE3TZnwQx/RTp2X9PxqcbY
         QpfeYTqeTTns04pv3elUmABY7E7+zCcS5n4f3MFb1YKGIaUvjx282QLviGz38jhkLkGQ
         gqQZP5mPwzh3NYyFCkNyy6otWa4rSV57VCGXojvUvqBp5drsaqs4Em+9zTknNDE8TUid
         znXCdWI/rRUftSJobbzVvm2Tk71uQSTD7dD5buR66rRBha6XxnCAHXQcDo68BM6QUw0w
         0bUXWt45uEBZSyNMVbKh0x7y8xskhGJ8XUnHoSUM9g72Wzy+5ROdRE5WHEH5qbMd39Tr
         MZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731035993; x=1731640793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dSFWQaJAAY4ILwfVQzc5M0r+FjAN96iZg9Zg5lN4R+w=;
        b=gls21kxBFWYCgV2ADG904rI0QEorjtF7dIDnJhh+zCoicvsaXejWGLNQo3ptof5ok6
         h6ec2SljJmmXHjigPewhcubWDsliJfSw/+yejDDF0r2MNsbKDeEkeBhpLwGwlgyJqcom
         8D2en2Na2mX+YaN6lK2TSDauXVTveQOtrEN1HoPeBi7LBEamY+pn3nP2brNJyFSh4YkJ
         E6rZJDwZvAPnZIDExiPawiQWLhCh5KjAp903PPaSgUOv0vDUopzFsF1asgeiT8m0Ud2k
         kedSutjAOUMjoNzi2O+Zyey+/hvzroPW6dT77uv+we54Zkndde/GbrLeZOrTyhOVHEOq
         TwNA==
X-Forwarded-Encrypted: i=1; AJvYcCUiJuHnC3LQ4IjtCONetIjFEpmBfT4dGMqMffkp1QFbsHBVimY6guqgz4Uz79iSN8xYzk+1ZSqm7EOB7ptG@vger.kernel.org, AJvYcCXyX5N1uz5F5RiHMePcO2fyb2EhbvZfrtsb8tqIBio+/qSjH4Af1OUCCC2WeEnItTCCulCb7E4CcsAlLW8l@vger.kernel.org
X-Gm-Message-State: AOJu0YzPT3Iyfbou26rvifL8aRsArZJC0txcx+cDOO4bv4eMet+JkQbp
	+eG8KyvOSIUIF4uelAs8Md/2BHHkIICjIfItk2ufz17OuxDqyVht
X-Google-Smtp-Source: AGHT+IEyi1BroO3MM6ueF/NWg8C1s7OrC7oq4zerpDSbQA9ujJLqH7YMKCRXhwmAIKfACGxTa43FDw==
X-Received: by 2002:a17:90b:2b4d:b0:2e2:bd7a:71ec with SMTP id 98e67ed59e1d1-2e9b16e57bamr2033500a91.2.1731035993401;
        Thu, 07 Nov 2024 19:19:53 -0800 (PST)
Received: from localhost.localdomain ([43.154.34.99])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5f90cf1sm2350097a91.30.2024.11.07.19.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 19:19:53 -0800 (PST)
From: Jim Zhao <jimzhao.ai@gmail.com>
To: jack@suse.cz
Cc: akpm@linux-foundation.org,
	jimzhao.ai@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	willy@infradead.org
Subject: Re: [PATCH] mm/page-writeback: Raise wb_thresh to prevent write blocking with strictlimit
Date: Fri,  8 Nov 2024 11:19:49 +0800
Message-Id: <20241108031949.2984319-1-jimzhao.ai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241107153217.j6kwfgihzhj33dia@quack3>
References: <20241107153217.j6kwfgihzhj33dia@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> On Wed 23-10-24 18:00:32, Jim Zhao wrote:
> > With the strictlimit flag, wb_thresh acts as a hard limit in
> > balance_dirty_pages() and wb_position_ratio(). When device write
> > operations are inactive, wb_thresh can drop to 0, causing writes to
> > be blocked. The issue occasionally occurs in fuse fs, particularly
> > with network backends, the write thread is blocked frequently during
> > a period. To address it, this patch raises the minimum wb_thresh to a
> > controllable level, similar to the non-strictlimit case.
> > 
> > Signed-off-by: Jim Zhao <jimzhao.ai@gmail.com>
> 
> ...
> 
> > +	/*
> > +	 * With strictlimit flag, the wb_thresh is treated as
> > +	 * a hard limit in balance_dirty_pages() and wb_position_ratio().
> > +	 * It's possible that wb_thresh is close to zero, not because
> > +	 * the device is slow, but because it has been inactive.
> > +	 * To prevent occasional writes from being blocked, we raise wb_thresh.
> > +	 */
> > +	if (unlikely(wb->bdi->capabilities & BDI_CAP_STRICTLIMIT)) {
> > +		unsigned long limit = hard_dirty_limit(dom, dtc->thresh);
> > +		u64 wb_scale_thresh = 0;
> > +
> > +		if (limit > dtc->dirty)
> > +			wb_scale_thresh = (limit - dtc->dirty) / 100;
> > +		wb_thresh = max(wb_thresh, min(wb_scale_thresh, wb_max_thresh / 4));
> > +	}
> 
> What you propose makes sense in principle although I'd say this is mostly a
> userspace setup issue - with strictlimit enabled, you're kind of expected
> to set min_ratio exactly if you want to avoid these startup issues. But I
> tend to agree that we can provide a bit of a slack for a bdi without
> min_ratio configured to ramp up.
> 
> But I'd rather pick the logic like:
> 
> 	/*
> 	 * If bdi does not have min_ratio configured and it was inactive,
> 	 * bump its min_ratio to 0.1% to provide it some room to ramp up.
> 	 */
> 	if (!wb_min_ratio && !numerator)
> 		wb_min_ratio = min(BDI_RATIO_SCALE / 10, wb_max_ratio / 2);
> 
> That would seem like a bit more systematic way than the formula you propose
> above...

Thanks for the advice.
Here's the explanation of the formula:
1. when writes are small and intermittent，wb_thresh can approach 0, not just 0, making the numerator value difficult to verify.
2. The ramp-up margin, whether 0.1% or another value, needs consideration.
I based this on the logic of wb_position_ratio in the non-strictlimit scenario:
wb_thresh = max(wb_thresh, (limit - dtc->dirty) / 8);
It seems provides more room and ensures ramping up within a controllable range.

---
Jim Zhao
Thanks

