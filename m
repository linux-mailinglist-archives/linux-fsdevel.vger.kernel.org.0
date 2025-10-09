Return-Path: <linux-fsdevel+bounces-63675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CD1BCA5D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 09 Oct 2025 19:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3F653C5D86
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 17:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95223242D84;
	Thu,  9 Oct 2025 17:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="uv3GpQf7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5887023E346
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Oct 2025 17:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760030519; cv=none; b=GzPJbfeW0XG0jSID/dH2BL4CrmszDzacCNQtK/2ddu4ZYDFHSgiC0rvbN2VVQ/YFxAz978eOW2U+HoGlZnDGNfzI0O+Ne0b/nU7Av032Xe1QE2tPjk70KXfwLccRxd5nZqOuEGuwV1v1bC6Q/lpujOvDt9jhdtob32rNzlF1LAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760030519; c=relaxed/simple;
	bh=VQJJ0kkdsoKilAETyLjjnmPlpywwYhmhfiCz5TnYPTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9kmYHgPFbC1H3m3z+IVvFHvwHKZQ4MHJT4XnnZZKiD7FCS/80YdNFXCHlyK7tywXOF0AYFcmAv1y/QyFXAta0N+GdXyli5FBnBp2uQTDwUaXl4XwI40Ak9bHbmp3Js+7zoERcZiGOqPOFMP7HKHSR0j5ugENV+BKtk65DEHgUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=uv3GpQf7; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4257aafab98so1099840f8f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Oct 2025 10:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1760030516; x=1760635316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f+KLFKFTWpPvFnQc5/YBzjsvsC5/CidNVj2ClsuS6MQ=;
        b=uv3GpQf7E/vDeTz9FLxH1pauaLYsJemYzB6731uJSXpbjVHeTvKvX4tygAOWkI7wJG
         BdgeaDZDjeK4Zewz6oHUZerIvkZ0++bfYSpekkS1EVORWyMUwvBhYIvBaeDkLqq5/EaK
         qZPyNKt3gpPYn3wnco2eUZ2SN5KFZ6/T2bJKQWXNVdTejTjxTSPxTjGROgPZTlcbpkEm
         0Ydsp4ScEgLTgFUkIwGuylAPD1BP2XiJRM2UEGt25jfqwM8/MaQ2YO3fpQOLqt0xdc6o
         Pgtq0a3VKLmPmj71IlYHkfMd+4CxNsw6iQi63q9JlRODbNiUvz4LeQY216GLI9NIudYD
         eccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760030516; x=1760635316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+KLFKFTWpPvFnQc5/YBzjsvsC5/CidNVj2ClsuS6MQ=;
        b=hYyt0OohhaI0fmKHM5ft+h+n05BTh3gicgbpCfTAR75NAnnhCwbxQ45Wlkucl5fgJT
         4PVn5ihni9Q7nBO/2eEDy/vqeYt8Z3TNNLxyJsMpnXsVzpFliTvKyW4zdX8wRtqgYKEP
         3Q0cpnELfGAwoLHb4akEz+31Lq/DQmBLyf46a99CyF4jJhE8PN87J0S/d8GXB6dt+3G5
         AGQskb856nFaiF9RjhXTwgSqiDaaMllJKBqx41dw/JBxnBlyPkU9U+sHO2h/mPYgvLZP
         ZORwpSOxUChi3NRDAUPRljwoaUGztTuugNc/UmbhYuvMTwwNFHh23riCmBIhEd0D3swq
         AqZg==
X-Forwarded-Encrypted: i=1; AJvYcCWFvsJ22nxX2qwTLAd9gaMti8LcXfmbtx5zihk8vdtQC3SaJ7Kov03/88fCQt6RV2qOKzp2PEtBikgRZu1V@vger.kernel.org
X-Gm-Message-State: AOJu0YwzW+jpq39ogeveWRRJMkZrdiTZufhgTfn1thETZwk8Jp9Y+WHs
	xfVaOftvmUtYHNAGGRBgpxPZqsn+yRgpxTZofL+05Qq1YE4AIJnl5nG3wCmjjw2zRuM=
X-Gm-Gg: ASbGnctCYWLE1qVFu9qxLW2kjyANt0Brw0lckMgHyh/QqOUHW7K9e5nS60162Fw8FiL
	dck3n/4tRpJa9MCOwilMfM7umac0gGkFldH7sPs+DaHhMyl7Ln0R44qZTehR7l8yJn1auv17Qg+
	rLN9RUsg2bT7h+0+D+Lp5X/mfVq7uWRGmvbX5fbxpbLjYguvLWntviEuBmPs+lYqIOojnL4vAP9
	vcJblURxi41k7ER4oTjM/zlqWv4mct3/QttFac2lHjme9NAQ0kZarIPnheVttlIyKUVu63TW6YC
	13o60HSwvlIUQ1OcPlMQhvL1Jyi9hlD8xpTFDtAVAUXLt/PDubJu0t+AqxUIoOxp3kvmd9yl73I
	LeDlfO17TbPcymO0vqPiSen6iVeFPE181AWrp+iOFhQ==
X-Google-Smtp-Source: AGHT+IFvtBt4VPloj/uWDHxR+fLdN49T1BIdUNfkKzHmKlSqCdUXz5aRdqggP7xZyjd/f8BtBox2sQ==
X-Received: by 2002:a05:6000:1863:b0:3e6:116a:8fdf with SMTP id ffacd0b85a97d-42666ab969fmr5606797f8f.13.1760030515562;
        Thu, 09 Oct 2025 10:21:55 -0700 (PDT)
Received: from localhost ([2a09:bac1:2880:f0::3d8:48])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce50d70esm87352f8f.0.2025.10.09.10.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 10:21:54 -0700 (PDT)
Date: Thu, 9 Oct 2025 18:21:53 +0100
From: Matt Fleming <matt@readmodwrite.com>
To: Jan Kara <jack@suse.cz>
Cc: adilger.kernel@dilger.ca, kernel-team@cloudflare.com,
	libaokun1@huawei.com, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	tytso@mit.edu, willy@infradead.org
Subject: Re: ext4 writeback performance issue in 6.12
Message-ID: <20251009172153.kx72mao26tc7v2yu@matt-Precision-5490>
References: <20251006115615.2289526-1-matt@readmodwrite.com>
 <20251008150705.4090434-1-matt@readmodwrite.com>
 <2nuegl4wtmu3lkprcomfeluii77ofrmkn4ukvbx2gesnqlsflk@yx466sbd7bni>
 <20251009101748.529277-1-matt@readmodwrite.com>
 <ytvfwystemt45b32upwcwdtpl4l32ym6qtclll55kyyllayqsh@g4kakuary2qw>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ytvfwystemt45b32upwcwdtpl4l32ym6qtclll55kyyllayqsh@g4kakuary2qw>

On Thu, Oct 09, 2025 at 02:29:07PM +0200, Jan Kara wrote:
> 
> OK, so even if we reduce the somewhat pointless CPU load in the allocator
> you aren't going to see substantial increase in your writeback throughput.
> Reducing the CPU load is obviously a worthy goal but I'm not sure if that's
> your motivation or something else that I'm missing :).
 
I'm not following. If you reduce the time it takes to allocate blocks
during writeback, why will that not improve writeback throughput?

Thanks,
Matt

