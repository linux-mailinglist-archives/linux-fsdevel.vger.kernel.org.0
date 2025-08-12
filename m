Return-Path: <linux-fsdevel+bounces-57547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2B1B22F32
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 19:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69468189F200
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 17:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4F72FDC2B;
	Tue, 12 Aug 2025 17:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxCWVEz6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BCB2ECD27;
	Tue, 12 Aug 2025 17:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755020147; cv=none; b=fplVrPEQmrhGp3MSJLqtqrG3fqm91qnkFyU1ibnw5o1k2I6fg/QDPZpevDiHcU37nefffXnCvJvtWc30sDQc6nBeGjqDbx0p0x9K8TceedUsERufgjM8VKC37LVfUOQ2pqKNpAnVPOiHANwCYxman52idDmA8Bbh6Y/80UIA0iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755020147; c=relaxed/simple;
	bh=/fk0SInUI+7YMulFy98YQ3QInCIqTEu3ouODgJVlNh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XiXB1bUd+92r75N+PBR9vwRIrYUc6HjKo7C+0rn4Fwtko2W2e560C0Ih46Wjkk77TlV1oONH7e8j7tNqsl0IeFw1cY2TSkXed+36L2gGB0aE0chtoeQcvFdJ03aOKLIx1M4XSmcLrZF5xmidUKJy4PeD0EFg1T/PXlw3l8SRKTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxCWVEz6; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-73c17c770a7so7215048b3a.2;
        Tue, 12 Aug 2025 10:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755020146; x=1755624946; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3QqRiRc8S5UuRZr109N2LH3VeQOZ0mfRe2blg1ehQPc=;
        b=bxCWVEz60prW43TgzLsddNqdEAheCJ4Op9LskSWIIMe5WpsRsbvD9QVAEQKEIz+Udd
         vqf1DgBStxW+viadZKflUOSDChRq5faexFE9oHRsD4B2VIIBu1EQQpNgdyd/hPXOYais
         OwrY/Km+DCFZb0SBW4AtLPnJkqeKmuv+82G/3tm2Ow+qEuI3Tmd44Cfx337QbSGXddDD
         /QEzt97s9hIcUyi30gPUyWsDR0SSVbNk1TIJ1nNYjN/7p0cYasWYxNqAAtUG+RPg7U4x
         6gA5+w0qO5lcfz24701uiGMGBHXq/Xq1jS8qTP3ocqiFgXO+jMl7Ysvvorezh4KmjzHW
         OLTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755020146; x=1755624946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QqRiRc8S5UuRZr109N2LH3VeQOZ0mfRe2blg1ehQPc=;
        b=Jt5MKXbs7l7nJYDhjle/C8llkaEU8TgcoKxtQpiNrYoRVELEbLj9EBvcsffXjdrb+C
         a/Zw6hqajQ82D+mwHpN3kNbfd3fxwFDGtdu1PqvcnrvGzlqsaUeQahIzdsWqzJeYWxvZ
         /HWi/PTj1pxCVD22b2WGhQ1zK/JNq7GMJoHb98C2duP7Sl0M/9GoycpTa9NPv+GAkl86
         y4EziMRBuWaz8cRRAaBrKXgc9vVP/eOI/KGXvM1+MM8zGUC/SiwESfBbZ8aLPhjYJ/tn
         rNSSwgbDfn+5KE9K0pWG4DjyR4yofBVUWKS2pNTfATiltedAc7qGdeFqtjsMKw1OOBNO
         47eQ==
X-Forwarded-Encrypted: i=1; AJvYcCUI8IJQSrh+B8uenj1JanJcS1g7n4emA0sxFl1PYdJyHMHQ5LXcQdRADlzeO554KCp4mMQHin3MdX+slicQaw==@vger.kernel.org, AJvYcCUhU7OKkRQEG8cRfCDCebynQCWpIE4dBsDQ9SyN/5370OTOzQ2en+rXfHWuTWlSDVX7u5V95ueMDAIv@vger.kernel.org, AJvYcCWNhEjO9ZdT4XmZrd9ZCxk6tHljADeKMuNjMhzjGf+KFRnR/zLe5lI7k/VPQOpT3X35L009X11MPPGNeHw2@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7RFdT0kkohInSqomn94CSHsi/tShc+Tv8rud0t5dIsEOkk5cf
	I0LAn8x7FV3Q50BbDuMy1wrsKB+JvnDOfcrBsy9xxD+6/vfymrqo8Nx3r+RkuxNi
X-Gm-Gg: ASbGnct1V21laYNVUfxQOmnSM84RP4x4i/zCi5LaB8RDSVYmds0pDjd4krCqH7PLu2c
	byQJ/DbrZSUMU01YuckEfMQPWedejEZMmwXX4TpDaigJRlNfnCb4kCpVzHSd8phTxvwP7GSHxRE
	nwud6Zgl9VsRgRVorqt3w/YAP0qgrwK6kKl8qXbXSNfj+HVq63zDr0A3zk4X2tVdJuRUDttTgoz
	CALhWzsMxBgjPjOO+P4Agd+cj2nEdPm16owpFYx8W7/2GnjjuypeDX2dBYui/xkQCfrKKP06oIf
	rZgRjcADrb3rHN5cojbzJv/h14elak3B/7XwRmpEWCgDF76Y0U5YKp1C26WHXGaV9MSEfJSpx+/
	DE4/lEkanG1aUF1N5DgeWqSqZBqc151WLsblG0j4NZT7pqZT6AQv9LA==
X-Google-Smtp-Source: AGHT+IEOQGwikHmdxCwnSLSNmqiAKdWaAmIlOvX98dKTEa3j/V/1mLnNx7izZ8MziWVIRtrOO5jPPA==
X-Received: by 2002:a05:6a00:a17:b0:740:b5f9:287b with SMTP id d2e1a72fcca58-76e20c9a0f3mr83634b3a.1.1755020145514;
        Tue, 12 Aug 2025 10:35:45 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bd9795200sm28297220b3a.114.2025.08.12.10.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 10:35:45 -0700 (PDT)
Date: Tue, 12 Aug 2025 10:35:41 -0700
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Rik van Riel <riel@surriel.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>,
	Uladzislau Rezki <urezki@gmail.com>, damon@lists.linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2] mm: remove redundant __GFP_NOWARN
Message-ID: <aJt7bYkhuRBrIO_S@fedora>
References: <20250812135225.274316-1-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812135225.274316-1-rongqianfeng@vivo.com>

On Tue, Aug 12, 2025 at 09:52:25PM +0800, Qianfeng Rong wrote:
> Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT") made
> GFP_NOWAIT implicitly include __GFP_NOWARN.
> 
> Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT (e.g.,
> `GFP_NOWAIT | __GFP_NOWARN`) is now redundant.  Let's clean up these
> redundant flags across subsystems.
> 
> No functional changes.
> 
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>

Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

