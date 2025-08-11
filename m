Return-Path: <linux-fsdevel+bounces-57336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F16B20897
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 14:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 307E5426586
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 12:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D08E2D322F;
	Mon, 11 Aug 2025 12:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Na5vuT96"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406F5F9C1;
	Mon, 11 Aug 2025 12:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754914687; cv=none; b=NPnzuFsHgryQgZbxThhCXlX6b2i/mHD/TG9CDbuLPLx3E9WjrSo9ytrbxWnYpvAB2nMDSgvnwLLwv4GOqg5JAn986ndC9R6m3tYdruL11bVh78ill8sEVY7lfcVCApklRyP048wfSjKZ3ki/aIgscx1qkwkh9IJhChKuuVb8kkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754914687; c=relaxed/simple;
	bh=MVA3cmSNN27LkxyEA8lesQ3/osK84jmCIGC0z7Qenn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AqB/2FeuoHUYLLZ6JBe8JJwNpGt5mLZwp5iuSmvxDFKvHrV/KXJDH3USzNpf5Dz1gVZAPr1VtpfGiSXG+qNVVINM6uanrbeqPjFlpTq0YeQQkkYqlgeW9taEfdaXaXTSHIx4Eo0lF6o6T/twwXiV6SAvM6S7FIBU5ynV+koC9gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Na5vuT96; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-321265ae417so4746889a91.2;
        Mon, 11 Aug 2025 05:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754914685; x=1755519485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLwF+BlEG3mYZAdz+ZKehsPdpmM/5PMg6nKb3VsuZq0=;
        b=Na5vuT96gPZkD32oIiOwF3cWJbJK0DX0pC5sRRUWWbAhXTADBPxuheCgyxW6DF5I9K
         FlJZA6c6zprCfMQWOchugULVUEcp/g0r7IO89hoPhgIGr3dfslur0RUHTdnAJG8WPlsm
         6vvaqUa6ESYe3ep1+jAwKMCrB1cd+5pDyrm4TfycO2OieXWjya/UTy0X/O5c4qHv79LR
         nrLsh4CZCPHWn8x6FL0xKnjxAFKdPGjWDvOMah9V4HYN2DfsrjqaUWSp7MkTZPsVgpEg
         M+IHidHVSfTqaBXXy/tVH0XTsiXrLHdTKnzJaMb5GjmvQsZGsrIJN1ifc2tKIC46BD//
         MVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754914685; x=1755519485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sLwF+BlEG3mYZAdz+ZKehsPdpmM/5PMg6nKb3VsuZq0=;
        b=GObjZ0T+tMAtvCb1xT074gJuK/AdNDD2YRJ8lhoBWAVBVFqlTi5HRnRI7EGLNT+AU2
         gTiQmtVM22ieTUFtWVvZMRws7w7/w6MhmN0lwNlT61sHxrPG8XWkFyEJ1HgnOgx5Ng2L
         lrHWpd9TshrBtzM5ych+6bEfVZi58VW6yuc2reTdvt29skcLiWxUv3dQehbLm0W511X6
         21dON//sPpo9ROJzeJPphEUl8ZVDMfJSbmaHvisG9pQ5CU3bNtJFsX0420p+d8DqQLgE
         kibNro8xyD9Af7WtdqoQb7N9atmHD1EZuIw5lQ2IyBruNGn/9l/qW33iIihNqt8pZvQB
         TKXg==
X-Forwarded-Encrypted: i=1; AJvYcCUEG6m4RhgqQ92bctMkgMcC8edrgN3v8Ci+F3EuJ7NYiY7cvHWCQmN+by1foQq9bQD2reUpjwKgyvU9@vger.kernel.org, AJvYcCVju5C+gQzSAWNj9oWhZkwCZVtlscTY0v5JP3Ooo24aqgsLQF1YdhYHXEmht1W9pKSMcul63w2PTH2sJCBV@vger.kernel.org, AJvYcCX6JDB5EEVWfvQI6SUaTFrIEJ7FCNotoxXSnmyUK4n5DDs+7k7N3jtUznUJcXaliLXWtsOoHRXpwuwlnrMl@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsiuycxf9zs6xq3wIleBtxvM2DyRfBAZHZ0n2WEvZGI/NQ9Nu4
	QbOrelXRF8Sw913o07i37awdWuBJj1rXM8n71aWJVyVstFE200rV+lQB
X-Gm-Gg: ASbGncsP84ZY7r3FAXZcY9B+ZYKsZK40RQKEvbOwgB7e66QZvb5k34ghwltWKxzCq9l
	moEYFrN2MGbqVv6njcbX2csaMKgTRdWHR+7G2AB/DWgyxfKxSIR1aotSQEMRbBS1M2zPTdvkptG
	Yp7b5YeLYDwrA0PxGxv7zq9pm17KFQDqYH6PXgA9vp4PhRGhkEiDCGkr1j6rdMuzHJdOPyFJrVA
	1uS9ctYvDld4sakuy9VLtdfNRRJn2eNs1SwocErH/aAKrlrbYyCgjPcdZHQ9LpqAh9k2PGx4bz7
	FyqexgSeJkInQunNv6EdgXf6cWnZ+sejiLh944RpmLRKxjsv59j/bcmvNWisv9xw+wu8KtztFDW
	sXLwRha7XmC1+hy1+ZlDrEsGE1Wzf1uVTNQ8=
X-Google-Smtp-Source: AGHT+IGpVpf0c/X4abESKaQnFxymPaeu0aEa91MmwZs35UQ6NdtLjVlAtbrYTHHTFScmU0eyMDgi3w==
X-Received: by 2002:a17:90b:4b41:b0:31f:6ddd:ef3 with SMTP id 98e67ed59e1d1-32183e74d4dmr18558679a91.35.1754914685407;
        Mon, 11 Aug 2025 05:18:05 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4384baf139sm5021009a12.36.2025.08.11.05.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 05:18:05 -0700 (PDT)
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
Subject: Re: [PATCH v2 4/4] iomap: don't abandon the whole thing with iomap_folio_state
Date: Mon, 11 Aug 2025 20:18:03 +0800
Message-ID: <20250811121803.1026731-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <aJnI49GCSfILx8eE@infradead.org>
References: <aJnI49GCSfILx8eE@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 11 Aug 2025 03:41:39 -0700, Christoph Hellwig wrote:
> Where "the whole thing" is the current iteration in the write loop.
> Can you spell this out a bit better?

Hahaha, I was also confused about "the whole thing". I guess it refers to a
partial write in a folio. It appears in the comments of __iomap_write_end().

static bool __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
		size_t copied, struct folio *folio)
{
	flush_dcache_folio(folio);

	/*
	 * The blocks that were entirely written will now be uptodate, so we
	 * don't have to worry about a read_folio reading them and overwriting a
	 * partial write.  However, if we've encountered a short write and only
	 * partially written into a block, it will not be marked uptodate, so a
	 * read_folio might come in and destroy our partial write.
	 *
	 * Do the simplest thing and just treat any short write to a
	 * non-uptodate page as a zero-length write, and force the caller to
	 * redo the whole thing.
                ^^^^^^^^^^^^^^^ <------------------ look look look, it's here :)
	 */
	if (unlikely(copied < len && !folio_test_uptodate(folio)))
		return false;
	iomap_set_range_uptodate(folio, offset_in_folio(folio, pos), len);
	iomap_set_range_dirty(folio, offset_in_folio(folio, pos), copied);
	filemap_dirty_folio(inode->i_mapping, folio);
	return true;
}

> 
> Also please include the rationale why you are changing the logic
> here in the commit log.

Hahaha, what I want to express is that we no longer need to define partial write
based on folio granularity, it is more appropriate to use block granularity.

Please forgive my poor English. :-<

thanks,
Jinliang Zheng :)


