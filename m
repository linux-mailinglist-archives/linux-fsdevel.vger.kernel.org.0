Return-Path: <linux-fsdevel+bounces-27439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8069618B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 22:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF2251F249FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 20:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24E81D1F60;
	Tue, 27 Aug 2024 20:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="cIVEoF9C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898BB79945
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 20:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724791578; cv=none; b=qQ8OdPr2mOHjZW0/aoWf+NGQza/Np5jiRq1SZsVqCbuJuTZsV7Cp/OfYR/F2Djmxf7390hO3CxT81zH+cYxAAwWQWLeN+LbSAD8hzcayIlEw/zCD3voYdR5TgM1D74L9C4PFe2CZ0BJQG/agCfccAO/3f6WKZDPPO8v6yYojLQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724791578; c=relaxed/simple;
	bh=u3K71lPLVRejBknkYCbRRSX8aZB18878RQVBu1rCeU0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=INUoJK49ktZH46KvrzP9NmJ0j0EOAkXITuIlRdYY8q9chk2EHvku3I/Meiy6pXKpLxG35Jq8X5uJ6qWtMVUTE2LtSc34PTjkKnQB09/KM4HfH+2sNF3HvFdzg7I4pyAqqnSfBDTj4bDcsQZ9UxYgBbS92zeHGe/qgdGKSsVkOQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=cIVEoF9C; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a1d984ed52so377011685a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 13:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724791575; x=1725396375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=eDErGv/eblabO5ucbPyjGsB3LzhzPWWWdX1EWciUjAI=;
        b=cIVEoF9CiDWUu/6oiJev5FPMoIfkhyFkKcx1ehXo4aNJUU5tGcOFWuuPTKx0kJ2/zt
         aNeinsDmEObUAPNhc6Ptv/Vy7MB89JQbuVUmvsaPkyan5wqPXLyUjqjc8DDcjLXbQtD2
         sdSXPpP5nkpM+Kqf//x2cmCx1CRcc9YGiRr/BMbN/ZyEhkkJ6nUch7yTH399lmwAbN65
         QoB3YIP6E77d2IIkizelIpNXM/ZIryTRuLlBt+/qMGOnzFxLt8TkhdsbASZNIlLuQv8b
         5HFApzfim1IlC6+TySaRpiLhznJUG6oEwiqSdva8sftF1usKT10Q0zibo1n9wTM87yxe
         sx3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724791575; x=1725396375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eDErGv/eblabO5ucbPyjGsB3LzhzPWWWdX1EWciUjAI=;
        b=l77czu7enETGgx6K3/L31KXt0OOfs+aoyJaxnV4ech2C9j4fN8UY0IjsTMMKF1wkWK
         oCr1tJfVsfEwBCbMhRpibTvBlcB31VL2HkliVOQIg/FSIzq27TddyWcJ4xHQt/4gZIhN
         0UVFJesJxi/PNnZ6R6a2OW54ZKKd16AkxEh8CPoUgEoqI+yBSX89EGtjt4O1Q0dKk4pk
         6hubJHBejjM3PKRdXh1R1tpcddXFXMMpxCoUFhREK+umGIK8lmrqECS4BAvdYBkfs1j0
         94Huiwncp3YQMtN/jUE6N4J3k70jaTZRjXVJaYrvFipObjaMV756574M4DZdtfWv9LNw
         ySOg==
X-Gm-Message-State: AOJu0YwADn7fNT8KmH9KILUicUwGz2cgLR8n9TQljAR3IJ55q7tP9GQr
	JjgY18A3C4AHGzGygb7NyKnDaFpbs2Hi7QaVfGEv9vTfhjJ8dvVr+wA5ip3SvK66HSxYaZCZJSI
	O
X-Google-Smtp-Source: AGHT+IG+OU7vachBlcm/h/X1vIpAjTFgndM7is91J9mBFyvDFheDYc9WhfFUyO0wr5SLsBiRBT2RnQ==
X-Received: by 2002:a05:620a:44cd:b0:79f:16ec:92d with SMTP id af79cd13be357-7a7e4dd17d3mr493055285a.27.1724791574977;
        Tue, 27 Aug 2024 13:46:14 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f3622fasm583206885a.70.2024.08.27.13.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 13:46:14 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	miklos@szeredi.hu,
	joannelkoong@gmail.com,
	bschubert@ddn.com
Subject: [PATCH 00/11] fuse: convert to using folios and iomap
Date: Tue, 27 Aug 2024 16:45:13 -0400
Message-ID: <cover.1724791233.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is a prep series for my work to enable large folios on fuse.  It has two
dependencies, one is Joanne's writeback clean patches

https://lore.kernel.org/linux-fsdevel/20240826211908.75190-1-joannelkoong@gmail.com/

and an iomap patch to allow us to pass the file through the buffered write path

https://lore.kernel.org/linux-fsdevel/7f55c7c32275004ba00cddf862d970e6e633f750.1724755651.git.josef@toxicpanda.com/

I've run these through an fstests run with passthrough_hp --direct-io,
everything looks good.

The last remaining bit that needs to be made to use folios is the splice/pipe
code, which I need to be a lot more careful about.  The next step is to plumb
through the ability to handle large folios.  But this is a decent start and
removes the bulk of FUSE's use of struct page, and is relatively safe and
straightforward.  Thanks,

Josef

Josef Bacik (11):
  fuse: convert readahead to use folios
  fuse: convert fuse_send_write_pages to use folios
  fuse: convert fuse_fill_write_pages to use folios
  fuse: convert fuse_page_mkwrite to use folios
  fuse: use kiocb_modified in buffered write path
  fuse: use iomap for writeback cache buffered writes
  fuse: convert fuse_do_readpage to use folios
  fuse: convert fuse_writepage_need_send to take a folio
  fuse: use the folio based vmstat helpers
  fuse: convert fuse_retrieve to use folios
  fuse: convert fuse_notify_store to use folios

 fs/fuse/dev.c  |  38 ++++---
 fs/fuse/file.c | 296 +++++++++++++++++++++++++------------------------
 2 files changed, 172 insertions(+), 162 deletions(-)

-- 
2.43.0


