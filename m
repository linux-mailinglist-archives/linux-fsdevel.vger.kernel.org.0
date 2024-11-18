Return-Path: <linux-fsdevel+bounces-35118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 634099D189C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 19:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BF45B215CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 18:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA561E2821;
	Mon, 18 Nov 2024 18:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igeMlSqZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040513BBF2;
	Mon, 18 Nov 2024 18:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731956340; cv=none; b=OqLoqK/IAn1950rCY4EpeiWZQ298PONqMulNaS965kVKV8taC+Q7WqHU5vXTducWjevwP2wtvYSBUUYZoirs/CgzgvjsAd8qcOaqAOvjW1DXFXYbPqeos+NeXk4PqpDYiMdvjhPb9KjLz4Z/D6ZeBXNHW0fgoaeLQmOPko5/r78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731956340; c=relaxed/simple;
	bh=S76Rfh639+VfBtQ21xgiTdDC7GZpkSdG9sRufGpmVM0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=REGJjvcDyKwYbybm+wYM62y7SqcaT1JrtEmiDylxGjCTn6XLx6hD1F43yDA6Y01opMicmu9FceuYxnnuQ1gTRDuNDdCu9z37/fHi9Rcn1Jgv2Ep0d8GEjPntayjANU7tFbUxbjdsKMuR1SXIkIv/l7T8WoBfbLlgYxedl+ym7pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igeMlSqZ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20cdbe608b3so45090085ad.1;
        Mon, 18 Nov 2024 10:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731956338; x=1732561138; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p/8svAxxqkAxdJBVg3Tlaph+be2+jLA/SHffe+1gqvc=;
        b=igeMlSqZee8PgqYWTOrswgwBiKe6wQ8C3/RuvTUVY3oTPhgQDSk28fTYM1kBR/a9Nt
         VCJXkq9Yv8Zaj0nlvQGo5ElNvAM7KS00B1nWA/MRNQhHwu3A/I1JEqkgLeE5yVG/y+8F
         yhQl3KswtdC12I5lobp0tSrJGiwC7LUguDiPPYPpNNoL17XlHkfjhryjmtZerHvFnrQB
         n3FDzgQQpQggLdLh5ZFoUBpsNiMCaRWfijHKYqzohVgPCgT1UuTuXwEih/ALMXkbG3r/
         M7+m3bJwQNW59h4/YXxwhfe3UOUSu7JsE9/jWVzOO/wbRcEMXvRpvA/RwuYAkHk9crIu
         NJug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731956338; x=1732561138;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/8svAxxqkAxdJBVg3Tlaph+be2+jLA/SHffe+1gqvc=;
        b=L5JFImYZzfb9JDSNRzteXATxoQEHG97/IyndXcbG9J8n/bwFcMdgk51ocNbNG9+guA
         8VmILAy5bdBRmePzSBn6Mq8EN4nliBlmmVNJUZD/iAdLtvVi3Y3rWPDdvZvQbElBeYT7
         BIDFeuFvKvAmUXe4KGCN+e9sJ6ljUx60zgqADeO2saVfOJqWWdqc/eiGPCyOCKTf8f7G
         j7SHsPMCfjza/4okGXYodPD1TbO2GRxTl/zCGBxFFYj63hRhyC31PwVuyWpxukpDy5G8
         /ITHzvYtPrJIJHhxCJEVbtWghrwRusdL5Fqxk9FmMqIVNyPFEQYf9+0R+vOVlo1g/uqR
         odSA==
X-Forwarded-Encrypted: i=1; AJvYcCUMDFig8qDQXajxuMVUM8aMFCZdyaTR2bNDyZXDusQA2gxEDg8BmKgiNeOzMxvzQ33xJ7BLqB9vxmghboIx@vger.kernel.org, AJvYcCXmknE7QdOAG4UkHe2DWBEBY5CQ7Ry0JM7SXyPRNMB/hkAJyLYLydS9oQMRpk0m1c4rrwh6b4Whh/Ep5sak@vger.kernel.org
X-Gm-Message-State: AOJu0YwiLtMpwjcLpQWLVgm3KTsTXl7ZSA9Fon5TRD9N0rl/CNhPzjKr
	O2Tvwlurmtk1+2uGeAb+mMKHlJpQlDpg0g8K6emO2FQVgAy+H8CqgKGTlw==
X-Google-Smtp-Source: AGHT+IH5VI1YSwqg21Tf2pRrRbtZjEUIg4GT2sb0c9M6MvwXvcKWabpVmA/ImFdhwy8xc2cgMciTzA==
X-Received: by 2002:a17:903:2283:b0:20c:5533:36da with SMTP id d9443c01a7336-211d0ebe463mr195398745ad.42.1731956338168;
        Mon, 18 Nov 2024 10:58:58 -0800 (PST)
Received: from DESKTOP-DUKSS9G. (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-212099db514sm31211165ad.51.2024.11.18.10.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 10:58:51 -0800 (PST)
Message-ID: <673b8e6b.170a0220.1104a1.d903@mx.google.com>
X-Google-Original-Message-ID: <ZzuOaboiM4-2H4LA@DESKTOP-DUKSS9G.>
Date: Mon, 18 Nov 2024 10:58:49 -0800
From: Vishal Moola <vishal.moola@gmail.com>
To: linux@treblig.org
Cc: willy@infradead.org, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] filemap: Remove unused folio_add_wait_queue
References: <20241116151446.95555-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241116151446.95555-1-linux@treblig.org>

On Sat, Nov 16, 2024 at 03:14:46PM +0000, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> folio_add_wait_queue() has been unused since 2021's
> commit 850cba069c26 ("cachefiles: Delete the cachefiles driver pending
> rewrite")
> 
> Remove it.

Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

