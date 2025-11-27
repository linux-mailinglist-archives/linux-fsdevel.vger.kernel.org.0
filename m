Return-Path: <linux-fsdevel+bounces-69954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED01DC8C98D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 02:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52D203B47C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 01:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C4620A5E5;
	Thu, 27 Nov 2025 01:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Mk1PbkLC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C957579DA
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 01:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764208257; cv=none; b=Y/0yGfTtvAUKilGe0k/03XsY2HMGf7KWyaX1otsatGSjet9tE6oNocdsPBIcvsbJWgf/wGnQ+Xzc+Kv4STfbnG4Bmm27WFSSo+QMCaYYckrsUN7uMiVsG3vImuFpk6FOshdW3havfQ4v79XLtSw0KCoJjOjjhNi4Euq46mbwR9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764208257; c=relaxed/simple;
	bh=ZdmqS9hhrfqhIWJ7RxVbgZ4nHksmwGAq7i7nhI9kZwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pG91BKU6JuELb8CmjPg32yWKQGijJGVycrUXNmBVGzoOWofTPn59WltwfVFpJelMzyLvKUkJDC2qf2Q9U+tnMstDYLwL8wfT5dBJarTxQc+RNQ2BoJOE7wzcpCc8vXdSmCVC2/ze9YZRqSJUJyuTdQdMrwuRIDjU8ZR3iX3nvTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Mk1PbkLC; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477b5e0323bso8227675e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 17:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764208254; x=1764813054; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7f/NGt9PhiKtLJCrxLaPZKHO0hccYH7c0Hd/TG5qT70=;
        b=Mk1PbkLCGrPW6tqMo7GeBFvRzX5bhvDWyQMz0bJekF1/iMORaCgPHlSbrVg40jbTIG
         fmvBCwCg+ooVBlZx8MsDVrGUm2jE9wGmBm7FOF/u/8IIBKI3OfpKcyjkcOFwXqmM0a8b
         fRxQX6IqGuvU0000YZrV42ht93t/5/CdcRHBJuDi8my8ySdBLs3mafOhnWwKGr0ePukp
         pIt8vwjZMpBgLo9GjFT+JSIDYnH9wEOsSD0Am45U3cCIOntH64ImUWAKLibqNk/cqie7
         5um7Dg6dr4QuwCsfMHBMX+dh+qjYjTtIJVaFlYujCOKMdQMaKEFmsx3rxkR3zPevNLeE
         6irA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764208254; x=1764813054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7f/NGt9PhiKtLJCrxLaPZKHO0hccYH7c0Hd/TG5qT70=;
        b=YnmYxBpxujjY9X351QiOsJ+MmHlhL3x7MCNmdp4cHaHvtxh7pjhtjtQBeULpzzN1VA
         YXrLlGhwnKJzCwXsVYjAHjIc3sUN95hjKYZhx5lpeUnQ0EPDxkjw9qNdVIt1a4kMlOnW
         /9jGLAWBRlo1+a3Bqptax3kJOkPudLvX0crum2cuFLdWOC41teuVPIcaqKII0iUngRnB
         bKCuWvjxXVjdVBNW9doYU7uC7Qz1QNfGqoMRx1YR//mk41Ma+PFV15sdJen04CvMalxy
         KMZHTJ48h9lcFnm8CadMuI1UrOL7rSO+5ch6NdbkO0fjIy5deUWs8wctPmzHgeJYi5NC
         x4vg==
X-Forwarded-Encrypted: i=1; AJvYcCUeLQ3dKNnvoTPIe/QMeCMPvaxPrhOD1eQ8axPSufcsR9lh6y6mSn3RYef3vP23GqU7ic28s+/thFaU2ZgF@vger.kernel.org
X-Gm-Message-State: AOJu0YwY19pc79GZKUUSe3pl1u/9as61QKqndWZvsuFE2/KXWSNrGDfl
	e4w8U1AFT9QJOWMBbnLeplugJ7Og7fIVLlx9TiVunJDkVOEfJmDF/YqCuo812i+G7g==
X-Gm-Gg: ASbGncsX/F3BsPgv0nnlaAzkslKPDW6M5VtC5xLC0YRPgNXy72espWwOVJbNEUDcIts
	6+8kUDBwHAb3SVjJrttzxynXz/bCy8F/rlfN1bHcyMUNuqkbHdxjnBgnnVSfhqDIQHeG66AUodr
	8+Tgf8kwOw2E1YFCzDklns0Jy60o+kv5kEUvvCJKHRhaxLmmyzzQRLcVmnSS1aSQ9d3xYpcCYPM
	SjTxRJbjEf2UDl70TMKWO/FFEGcCA8MCoLShdOTHozk+aVTt9G/wLwn2W516r4ePYyAnlRIRUuk
	Kpfw+/zID0EPUKIwykRVoPzEUekgZpQT2xBpNaOae3AGzvAYMUYj/+FaFnQMukvXNarXILdYkPL
	rKiyC9zdagPxzewtpAyNlElMA04ViE7wz8Gnz0YOuJf/h59OZurZ+wG96S+w5Fgg4Welv0m/Kx9
	0RpMM2tt0j/b5P+Vw+ChxvPKBWZ5tq
X-Google-Smtp-Source: AGHT+IGqCP3dOwbVcqjH02MwzgXNn1K1WcY5QlK3LzfxtqgvJWUDJ6ePKE/B0PPmZH/5i943qt1wYA==
X-Received: by 2002:a05:600c:3ba7:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-477c05139c2mr280548915e9.11.1764208254168;
        Wed, 26 Nov 2025 17:50:54 -0800 (PST)
Received: from autotest-wegao.qe.prg2.suse.org ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479111565a1sm5285835e9.5.2025.11.26.17.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 17:50:53 -0800 (PST)
Date: Thu, 27 Nov 2025 01:50:51 +0000
From: Wei Gao <wegao@suse.com>
To: kernel test robot <oliver.sang@intel.com>
Cc: Andrei Vagin <avagin@google.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, oe-lkp@lists.linux.dev,
	ltp@lists.linux.it
Subject: Re: [LTP] [linus:master] [fs/namespace] 78f0e33cd6:
 ltp.listmount04.fail
Message-ID: <aSeue5UPBm3QGH8-@autotest-wegao.qe.prg2.suse.org>
References: <202511251629.ccc5680d-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202511251629.ccc5680d-lkp@intel.com>

On Tue, Nov 25, 2025 at 04:33:35PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "ltp.listmount04.fail" on:
> 
> commit: 78f0e33cd6c939a555aa80dbed2fec6b333a7660 ("fs/namespace: correctly handle errors returned by grab_requested_mnt_ns")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [test failed on      linus/master fd95357fd8c6778ac7dea6c57a19b8b182b6e91f]
> [test failed on linux-next/master d724c6f85e80a23ed46b7ebc6e38b527c09d64f5]
> 
> in testcase: ltp
> version: 
> with following parameters:
> 
> 	disk: 1SSD
> 	fs: btrfs
> 	test: syscalls-06/listmount04
> 
> 
> 
LTP patch:
https://patchwork.ozlabs.org/project/ltp/patch/20251127143959.9416-1-wegao@suse.com/

