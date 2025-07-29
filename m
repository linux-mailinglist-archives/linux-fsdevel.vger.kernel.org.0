Return-Path: <linux-fsdevel+bounces-56246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7340B14DA2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 14:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 333D53BBC32
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 12:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FCC291166;
	Tue, 29 Jul 2025 12:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="AVejXhSd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADB92A1CF
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jul 2025 12:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753792035; cv=none; b=I3NiTekYftPom5rvzq8nBvUCMDdSDo5/6pfcHhWAWDrbLqT1AY/IxxQr9pfxbqCPMK441GmbXuddiN0lGbj/H9kLJajIfaOGO9gKp0RhAC+uoIcpQRQ5pujkPuR3Zs1VawGq8TvUbKcDysgZze2y2yIRekjf00KMUCGVdiFK1I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753792035; c=relaxed/simple;
	bh=z+AlFEiThIB3yzlOzlvIwJ8WODjQwhJr1nUP8j+2ZN8=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XHJS45DrnRj78aRt5dMQhTzNzxPdVeywQpKK5ZhL1N7M/1FLOv+oTKSZ1p1gPvjdbU2coLdlmLmPOb7YDjNtLskCwPY5JxbKHsb/zAg3rvXIiOJnTxlf0lf6HKJYycdWVdflL9eoiGaTToRMCgp08U6nmYSGtOT2DVL4qq+a3zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=AVejXhSd; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3e3e73e9177so9809635ab.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jul 2025 05:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1753792032; x=1754396832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GRhxuQmdyUvmXy3hxnDOaur3wUT/fSUjggB7ZdRmyh8=;
        b=AVejXhSdJJoPXXplf0RwQxvDqqhmfrtYVz0tb/38IR32wBBwfrrcgPNb1HUfREhqfn
         JWfRd6u33GsJnKq+wL6/oMxGq3dy2Br6QXqE/T5PvTHcAAVxuje9tium9Mygn8A8pRyg
         u64Q5t5jAVjmTKxAHJzE4VmO7gV9pQqgFcqxMjjH80UYUn0woYgY+9Jo5nMXcLOkX5kE
         y6jj10R2fj9oq2TNEPTMtplShMRBxRe7krCH9WZ+uZ+D5KNvwBbLxO4WX3GOxcYoDQs9
         yonAVodxdeqBZSTXgUah5fRk+sPhIq0uO1XMPJ1AxlC1L8rr02cChxADM4vUsp68Aut2
         ykOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753792032; x=1754396832;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GRhxuQmdyUvmXy3hxnDOaur3wUT/fSUjggB7ZdRmyh8=;
        b=Le9s3nx6YFjCBEUnYesIasXqlMEZCgfDFcbU4aHX3B+N3+FIAJBZk124KbVa5KmhMN
         qtol1vxUHOoY3JzK/IDQAmmUiqNldX2uQYYUQgqGneMzVooqM0N0gSbn600QPpGnkkEJ
         6hv7O1QRO4bgjBr462Myf/ZzyyypB9gPRdxokeg0tjaMTXR61aHKechSOu/db3NzuiQD
         rkH7do06edwCC142hlb0vevOIZNG2LigM08QbDN8D8YMYtQGd078Qef+BhwgKg0t3BlP
         1x4+CH0sFtBwBvD+MHA9oJV30od8oWLscwKRbY1GqwiVDZXl93JB799F8YTsmV0c3rfC
         bP2g==
X-Forwarded-Encrypted: i=1; AJvYcCVVazzVgXvQoLZiprk+N7VQeWQ8D+y9I8gHDfIKO9PuL9zBi4g6gE/p4XtsjUMVx0jfMRiSfJbrroB35kIt@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1RyTLRSxrlXF6hKGEH8otK8z0gdRqYdq1RD6Hgt8WvkR7u0tF
	giOGS5+7TyU4wDIZIiPVOs/G/vc4cctR9FnrfuilS/qZVidr81qU8D79p1n7coHLC8g=
X-Gm-Gg: ASbGncuF1JyA1Xjah2CaJANhJow7Sdn2QXLZtBsebOb6kUgbpEmezZyAvBKk9vmsvcv
	4c/r2xDAWrp4x5Y2ByDiT1bwJnjBZYGo2FFlmg1w7pzMX11u9uMuCOTq1Woew5442Tuoowi2oy5
	/vcZNK25GHAbunP2G59W4WtDslLqTNJyTfHBbnU+8wchvoT9sUcP+g8sVk3JKqaHwduFgX+vkEz
	IBw3sLk2K0v10RJBQr1Sjd0h9CW3l6yDecRQhq3DOcZ88VJ811uEOdDawbSXYTHmc23xhZyq6nO
	lehwOpDaIrd+aoh8siBQ1rZ2AS9eIyjd8OcCuXeRNhd19cw57NHRyyDfdMFABOuQO70eEhBOnr2
	oYbvTyfBqapS8Hw==
X-Google-Smtp-Source: AGHT+IHxU/6W/4OkM14YAhuR+Ib1gzBY/3UCbYLfMBK/teGnjkyghGETjjmUgh5mL0YjAPo1uHs72A==
X-Received: by 2002:a05:6e02:3e90:b0:3e2:c69f:106d with SMTP id e9e14a558f8ab-3e3c529e1b9mr241142605ab.2.1753792031868;
        Tue, 29 Jul 2025 05:27:11 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-509002ae794sm258067173.45.2025.07.29.05.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 05:27:11 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20250616062856.1629897-1-dlemoal@kernel.org>
References: <20250616062856.1629897-1-dlemoal@kernel.org>
Subject: Re: [PATCH] block: Improve read ahead size for rotational devices
Message-Id: <175379203106.176672.14503199411239963437.b4-ty@kernel.dk>
Date: Tue, 29 Jul 2025 06:27:11 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Mon, 16 Jun 2025 15:28:56 +0900, Damien Le Moal wrote:
> For a device that does not advertize an optimal I/O size, the function
> blk_apply_bdi_limits() defaults to an initial setting of the ra_pages
> field of struct backing_dev_info to VM_READAHEAD_PAGES, that is, 128 KB.
> 
> This low I/O size value is far from being optimal for hard-disk devices:
> when reading files from multiple contexts using buffered I/Os, the seek
> overhead between the small read commands generated to read-ahead
> multiple files will significantly limit the performance that can be
> achieved.
> 
> [...]

Applied, thanks!

[1/1] block: Improve read ahead size for rotational devices
      (no commit info)

Best regards,
-- 
Jens Axboe




