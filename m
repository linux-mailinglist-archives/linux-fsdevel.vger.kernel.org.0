Return-Path: <linux-fsdevel+bounces-17756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8378B21CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 14:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EA601F23A50
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 12:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38FA1494C4;
	Thu, 25 Apr 2024 12:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Goi7k+N2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248EC15AF6;
	Thu, 25 Apr 2024 12:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714049080; cv=none; b=qiNFpb7GHsI6o8WPJGwlx4FsE04xyR9YMPnZ3m6NXiQsKXPmZrjHAECc7XQrh4ghGvlV2d7qUpk0xXkw4uy7MEqMt3MSP/2hJOs4iiUbxYbtfRcWDT0PYhXWxiX9PzBf2UQ6u4M3wrJ5/LP3+kWaCLPZAj3HTC/VSVb7ROUYIXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714049080; c=relaxed/simple;
	bh=3Mtr5kTSQBg1wTC6h/1pwgOIhyvArbTAFtiw3KvQpgs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CV5Bm7timBUE1WPNVIPznWb8RjHB39uWOEeEsG32XSeRF64FqoFhpFFgdFrFVP63NT2yopPViaXQsMMK7MLmipc69/7LFr4Bc0GDTJ6siEnHC2I1f1yFjKureWFKJWV/Ww+IhRjAW5m2EDhpYIp6gz34/e2cdFHGes71Kd1D/Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Goi7k+N2; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e8b03fa5e5so7936455ad.1;
        Thu, 25 Apr 2024 05:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714049078; x=1714653878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MalHbcVbUfmTUH0arqKUh9jYIczTB1JUg4En9dYKyBY=;
        b=Goi7k+N2AVTbwopYGDmEJPvnNXorV8/7LwqBps6zHfLUzNk2aYWGcD3TS1GzaIlEgu
         sQz+UyJitv748IcN85q9xT32tB5KB3ZEI7AAlnFJK2DbwDyNOlV2VDp5yEhZ5m0ujy2/
         evltaisOvMoZLHVJzEXiTKnZCY2gKcA/uDwLqFvK+xWhN8OxbhuLiUWFh0gka37VdOoq
         NHuOMNvRetGhjfmBHzKUVtCsdrnQe6hpeegkXgUMjE2kHaiJWzQ8VfC0K8rqCY9Ra7qb
         h5LS+iu9lcOu/NrtkXLnk8ruTgdj+LmnzIZGLLlJOrJMqha9+KP+YRp7strbEL4fCdDA
         843g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714049078; x=1714653878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MalHbcVbUfmTUH0arqKUh9jYIczTB1JUg4En9dYKyBY=;
        b=spC4c6ZznZjGSQB6pd9rNfZySxDmJYQ2HJoIdRpHK23Vb2B6e64k15qPyv7xU9V3Xy
         LK5exoUOv0t/gWWZyHDeOrD3FjrvxbjfL//RbEHTfTttoyDOjo4aZLPEOAe6cth4Ck+d
         Os7naHKda9sh9tR+5x86BcBF4jpjatO3RovM+zihzRQIRhh36cQjlq+B8QbTwMrs71Ya
         LjvUR0bE1eCsLYL9bDAxpsf7R3+M/C3ZDLIW0Whhl/EFMaS+XT77w1WGZEdJWrFy1bLw
         n0Zha18gtelD6mw2cbp6fFCWviLjGMBGx6TZg9gkdi7D4nPebvqv/uCOFUm4iyjR6Skn
         Pwcw==
X-Forwarded-Encrypted: i=1; AJvYcCVUtyWAdTfb3B7QHmG2uY0nNjQamI2oiPmORvipNnAs49EfQejpe7g00zx3vS8NdLlPNi1sIipNCdErhqAncjMfUxjd6M0B6uufO3zTWMRRgB2I54xUR5ipSGpHpjApoM73x8iAF98Mzrg0iA==
X-Gm-Message-State: AOJu0YwzUigU8D8N5wabKiSHSLyNZKAupDi3JZhgSipTd0CQwEM2d/Sf
	M7fn17ZOsKkJResrB6ou+dHYCY/ZOXeUvLus6HyeJzP8s49VSi0u
X-Google-Smtp-Source: AGHT+IEV89JFrGdCIKZuaZ+h7prUWBOrjo8scUe7kVO+/QAJGWHP/yrfhyn39CzjnH5C30AVI/6hmA==
X-Received: by 2002:a17:903:284:b0:1e0:dc6e:45d6 with SMTP id j4-20020a170903028400b001e0dc6e45d6mr7878661plr.60.1714049078305;
        Thu, 25 Apr 2024 05:44:38 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902650300b001ea2838fa5dsm4920064plk.76.2024.04.25.05.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 05:44:38 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: willy@infradead.org
Cc: brauner@kernel.org,
	eadavis@qq.com,
	jfs-discussion@lists.sourceforge.net,
	jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shaggy@kernel.org,
	syzbot+241c815bda521982cb49@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] jfs: Fix array-index-out-of-bounds in diFree
Date: Thu, 25 Apr 2024 21:44:33 +0900
Message-Id: <20240425124433.28645-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZilEXC3qLiqMTs29@casper.infradead.org>
References: <ZilEXC3qLiqMTs29@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Through direct testing and debugging, I've determined that this 
vulnerability occurs when mounting an incorrect image, leading to 
the potential passing of an excessively large value to 
'sbi->bmap->db_agl2size'. Importantly, there have been no instances 
of memory corruption observed within 'sbi->bmap->db_agl2size'. 

Therefore, I think implementing a patch that terminates the 
function in cases where an invalid value is detected.

Thanks.

