Return-Path: <linux-fsdevel+bounces-37121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4048E9EDE0E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 04:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA158167A98
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 03:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5762515C14B;
	Thu, 12 Dec 2024 03:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GIHOvg4U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6073214389F
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 03:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733975913; cv=none; b=pj3TATvbqvKP17rJP+hw76DKkjyfUBqFDkGB6BUSGcaiKSdXK6QjpaCjJ/0b6smVU4OWlf4lWkQnxvTIY8pbsVoZpxdMocvjuZyzBF8kfdtKUt4wro+qvK3e+UQ9VmqFaC1tDhoLkGyFx2ZJxlrmIbFC8c4wEw7k2695NcbBhsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733975913; c=relaxed/simple;
	bh=F36O0Dgg1mhlcRno/fBPjRyjEsASJc7EpOfe35xMwec=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ygw+NXnx9nNvyl7IoJsexdM4aXEPE3Ws6sFMh2ki2MFywBlqmOqLv4HLQe15hx+e9AAW801quK2LZoaop/aOcNInO8RFhy1xawXWBeOsKuL0UlpEhgXcqVQzWkZIp1nDvmbS1TUHShgnMiYJp29KVRPIgwF3t5cb0d05k3JZ0cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GIHOvg4U; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7fc88476a02so162583a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 19:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733975911; x=1734580711; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WgpWYN8QlsUV56/RVatR17L4XIXA6XIYGaqKFNGgJR8=;
        b=GIHOvg4UbiVaM9uJK6lQZFuZiHZSvykDeyOlu3rgwhXtP6D+dr37wy+QXu/W5zv+vB
         o4+ODtk4V/0FJZFwHC2d9UtjHmDpDyoXn4mCwJkMYXw9dw0A4MDCzhFdnEtE7qhoeCcd
         FkrAjSio9mns5VLH1IHWv8giyxJN5OIfO3NXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733975911; x=1734580711;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WgpWYN8QlsUV56/RVatR17L4XIXA6XIYGaqKFNGgJR8=;
        b=Zbk+m4v6gOM1DJakz4grG9t12TAssDI9Q6S87Zm0aHpftYKiNCCrOB4/e88Fn+WcLs
         DXQs/9M/t61aRBfgXD1MrXVUWhZ1mfudniWfP/Z3uzynD6LIMzvx8+obC4AJKhnUrUVH
         Nvy5i1i8dZCcXJ/GFrIrwzAwxPLqJgMOE8RY+CCxKdlolZjsxvAdIEvjLZhV57k2su3S
         +yjkrK7oQTq6vs+enbwOPTuNEvff9PExSbVduNQRWKVebohCEA5mHXIH94shK2y1y4I9
         PB/vAw7RFZjjY4ZkgqGvKlSNnWD+1ifdAFSgitspY13Ew0w9XjBm36MFqI0B+v59UxP6
         763Q==
X-Forwarded-Encrypted: i=1; AJvYcCWFsSyyoH8t6zMKLPaqvnUnrUwKCLlHJkegf0WM9o7M80a3YfO1D5Ki0vYs9rEMRccFN1/p7C5FpbR97PjU@vger.kernel.org
X-Gm-Message-State: AOJu0Yycs6ulK0M9mUVH0Lhhke+eWnDksC71+TfkXbUDdrEUvIwMqX9t
	OJMriSbky/KFmJTBy/oEy8H1p2L8FAH7ZfRWgp2s/FPPSBzNUpz/s2mjfgJwYA==
X-Gm-Gg: ASbGncsQQ6b+HNIsi1Nct2wYvMilnE+dFfmYpbJMxnWjR6SKQHeMPRxwKdWPfVO8u9K
	hQOSVjnZTfa7J6abJVzgQEOYWAnOuuLFoX7kKFJoU8IamjmKRgiad2TU5Qcp8iEC4uXzgfplINq
	9tqI7mHhgk9so2aGKTeKDGWpIwsBsOkIroiewwhwq281U3oefCu26LoXScdj0rD/gHBHOCGL/ZS
	eu51ifcMX/y1PD6z2t1oTmhSc6OIqtUujtuY/p5jPNgl1h5XdPTsOwpRZdP
X-Google-Smtp-Source: AGHT+IHKkfFoUJmuviCWJxeHOxw/i7OyuK3tNEwkKuGLCgFdomsJz63utqGvLX0dQV2QgpKkzX7kug==
X-Received: by 2002:a17:90b:3ec6:b0:2ee:8031:cdbc with SMTP id 98e67ed59e1d1-2f13930b92amr3181455a91.23.1733975911667;
        Wed, 11 Dec 2024 19:58:31 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:d087:4c7f:6de6:41eb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142d90d3asm218413a91.7.2024.12.11.19.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 19:58:31 -0800 (PST)
Date: Thu, 12 Dec 2024 12:58:26 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	caiqingfu <baicaiaichibaicai@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [bugzilla:219548] the kernel crashes when storing an EXT4 file
 system in a ZRAM device
Message-ID: <20241212035826.GH2091455@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

We've got two reports [1] [2] (could be the same person) which
suggest that ext4 may change page content while the page is under
write().  The particular problem here the case when ext4 is on
the zram device.  zram compresses every page written to it, so if
the page content can be modified concurrently with zram's compression
then we can't really use zram with ext4.

Can you take a look please?

[1] https://bugzilla.kernel.org/show_bug.cgi?id=219548
[2] https://lore.kernel.org/linux-kernel/20241129115735.136033-1-baicaiaichibaicai@gmail.com

