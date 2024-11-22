Return-Path: <linux-fsdevel+bounces-35588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF129D60C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 15:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0187F281B09
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 14:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8D7148FF3;
	Fri, 22 Nov 2024 14:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="KYg/3o49"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8854D7083F
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 14:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732286968; cv=none; b=PkZvfL0CAHhF96Ppn2nDI41xgpfEtB3sttPXjyHFevgfs5rLhhX2c0xXiVhh0M1W0Yjxy2A5wYS1roqjYiBXKVwr1IWAL1kI0USfOxyxDyfuS9dxyxndFunKWDSJMk3h5K14JJ98NR+4I3lwBRQomobB4R5cAnzZLLuQvQrqwsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732286968; c=relaxed/simple;
	bh=tpcx0m6szXz2R94/JURM7FN7tDzUgnFc/G23bt2hF94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8rO9gcZ1uLX6X5+cmJ/J+hDXhRxbC4vYfGot6VircSUY2eLVt5HK7HaLhfH1pMRbLQzSzIYGGxIHNm0T99P1eCeUVHP52uduHd/P9ngLeBguo+5KfaKP5ZE8HlJ6vC2lw7EVLHW7/66w4BZ7ADj0Fy4XAmqvwVu0yqqaFVGqaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=KYg/3o49; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b175e059bdso127306785a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 06:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1732286965; x=1732891765; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2nF06Hawlob/2WmPu9jY0HdteY91148X223Gwod3AYk=;
        b=KYg/3o49u2HxAr0qwGEMQaEmnKX/Ku3S4ebXLdKz8YcOaw8CEzzDr/fkJDfDTtLoDx
         qsZM6DOT79heaHtu0ZXxHDbBGxdjMZYGTsxxuJPs7dC+5DJb/pwSCN5r6dE85fwrsWSM
         Bs7clS6Ua3cTUBgmUBzXIPLrBtubk2+OgJd9sJQ1rRQu0lcRRqgTAl55ZNQoF//lL5Re
         78DteFmvtMzAtrds+jiJuHzjMrIbZtjII8+ixleZYNBoVUAEZtwRWxBw9pXIcWbT8EIp
         iQVS8T+9gr8Q6l3mDklI6BzTjKSYUmCPx6/LeViLPAm/m/MFQakG97LR4c4Q3PgOI50h
         BDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732286965; x=1732891765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nF06Hawlob/2WmPu9jY0HdteY91148X223Gwod3AYk=;
        b=QDnM6ll1YEvI+93OaSquJrU8XrJKKmKPOumcF2UrEY8beUtGZ2WBqZzdblLYPaO+Sz
         GhO1AxQReIJ+ru3pC/lqRl0/RrOC5Ib+B3XO54QLccrCSb51IGCCUOltlqOFiYyoa4Fa
         eYKEMrVCAW9KQaWoiGuIBY743/H5U4mvuTIvy/33Zj5W6mcTfPSHQ3kqAZZiApICE1sK
         XUSCD2a387hbhP+oTl7faPyzWymtx0alkfZqi0ttjqU65QcH4HNHsFg2UNvH+UzlG4t6
         hR/zkoxLA4j7mu8ynw2snsAVQWVx10seYSvtIEkAl864BL2TyLKFnXEEQzP3uQ2J7PFS
         +h3g==
X-Forwarded-Encrypted: i=1; AJvYcCW27PYunNiYbQIX9407IGqXAdu1YlXupqxuQTHlsAHc/s7trD4VG0KbWeOwdplOM5o66G9TNhw9n/Q8ECw4@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5oGJot4xLTkatVX/hoiRAVk5pw1X4GBCTizuUZCJjWOiSMIKv
	ivciYkSIuLzmcjvMUmeoqVCA5XTRX3b4VRhyv/F1kRdCXtNP/4c3qTQJyYVCROU=
X-Gm-Gg: ASbGncsaMjWGYk+Uergs3TD3RRWS4HWdPCayfb6H1NviYqfxFP2WUw0s+gJCK3Du2by
	sPFLZn3MrxRNovoryvNomXg1e4qqeJveFTAk0v+0061R25VGS97PtD63kiLYCk4ukWelNtWJWkW
	nMS7uKYxqnF438TcR9B2XR7a9siSGda4eGN/foytsR5HIXdvpvofuloW0hN4Oxfh/LcVGS+ZB/A
	poh5n3yqy+Pn69OmawplUOEcol8uur2WtQW05ttv/xvrzmDngv+0ls1BRHNDWWxoNYvro5xOc6A
	D2oSPXOwNZs=
X-Google-Smtp-Source: AGHT+IFxcSP5e3EVwyTsqJOr+19roRpJNR5HTIEVdNlJ+9CExXMYYs6fOq/6/imyoPF0ZKSCFQsamA==
X-Received: by 2002:a05:620a:4624:b0:7b1:4869:38db with SMTP id af79cd13be357-7b514547c84mr415381985a.32.1732286965361;
        Fri, 22 Nov 2024 06:49:25 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b513fa6706sm93135785a.39.2024.11.22.06.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 06:49:24 -0800 (PST)
Date: Fri, 22 Nov 2024 09:49:23 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com,
	willy@infradead.org, shakeel.butt@linux.dev, kernel-team@meta.com
Subject: Re: [PATCH 10/12] fuse: support large folios for direct io
Message-ID: <20241122144923.GF2001301@perftesting>
References: <20241109001258.2216604-1-joannelkoong@gmail.com>
 <20241109001258.2216604-11-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241109001258.2216604-11-joannelkoong@gmail.com>

On Fri, Nov 08, 2024 at 04:12:56PM -0800, Joanne Koong wrote:
> Add support for folios larger than one page size for direct io.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

