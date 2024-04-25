Return-Path: <linux-fsdevel+bounces-17796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F168B2406
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 16:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6134B1F240A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 14:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D2614D2A0;
	Thu, 25 Apr 2024 14:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLT9BXxN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED6F14AD3F;
	Thu, 25 Apr 2024 14:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714055081; cv=none; b=jNGQmYBlVQRHoLTR73hHZKO2yzLLd2kwFCOcAWIEE3/Yhktgwr99VovzIhUFHDG4nVncX6ENg/et+DumoRxMB5DPFhG3I8hpI0xfE4LVn7NppFaEBjGpOL3w4KfgL2Pv5CjaGiAO59QnqeGEKiivhzeJCLkdWz0CL26KWRTlRRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714055081; c=relaxed/simple;
	bh=nd315ddHeQ3jbOI/VIRawaTMLsLAqYblnzZBuErYCdY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qH15tnADRsl2n8tm6FkYo0E1k0Zr4uCgGlh6t4B6zbOktNEWLvNrbDFll3yRTfjQFU/XSex1Gbl9QSxnoFuaq762vMSBdazK0jH1VkKGDoxLO9U+PScp2UsBLrZqlVp7uKtYvJeRU1O3HWa05eD3E91jYEUccFbmcdYGmyW/ux4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lLT9BXxN; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6eddff25e4eso932484b3a.3;
        Thu, 25 Apr 2024 07:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714055079; x=1714659879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ov5bxwmvvI6FmzNC+CS5oRE+ne73F6PO42lI8VcTp+Y=;
        b=lLT9BXxNYuNuO8Mf4wVLf+W7I1StybtbEBaiXt4OqoGPnh6JkAZRowEGgT+KVwHYdu
         SjSqmjAo/M9+GxHuYWjG1eKNGJI25/gDaRxQQ60u41vACdhe8/ybqwvOH3zuTc5SaSDS
         BxFk4xiizw3u89+IpPsPhVn4AAk6jWq0Q22Xc9CI91RgIPqBq+36S759gnJM+7JZpNzL
         ZBQXGze5v/kLWWXOkJEhnCbk7UpdlJ3bPlS/Rt469K2l+00a4BGz3GBwUnZ2IgSkC40s
         hgXorM0qodaDfmP64izCheAoi2VctCfW6UeDBbd4+rPxhqX0ycmPZF/6Nxz3zGKSGxtN
         tY6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714055079; x=1714659879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ov5bxwmvvI6FmzNC+CS5oRE+ne73F6PO42lI8VcTp+Y=;
        b=eD00FG8apJiT0Id7rvufwbo84FHkjra2/il8MFKSUVYA4mFm7tbFr9pkt0GGmyCy1I
         fEk9HIyyclGO6T74kn7S1N+qieiXJw1zvlR9d19T9G0OAoBV/WnQOW1Mbr8/AOXIuoyR
         3QsmBM91/r/H3nJ3TC35kd/wctyelzsvvq/EqlfBD9qXZGCv9QFNmMMebbS94kwXtQ2T
         VTXfJfV0yAykUd1+Pp/xqlc64gQUJoYdDIULvIanLMOOG8N4+nDSkqFx+TbDm/gl2Ggl
         ZHIlRoaQ8lxavtlqLIH88PDrDduWgUxuMigEjy7jrxkx3r7BVlZVBNAfmNwPIhlnrWXx
         gU5A==
X-Forwarded-Encrypted: i=1; AJvYcCUKQ0WHCGe0hgKjd0J7e37aQmTZDjg05CodwznOWHSLrVS/bWFRCve3H5YlxHPCYfDbIv/TyCM1CFC4l9GH41oJMl5tHGZi8UKFQPUSzipSdEldR3XMS5zlDzf7t0tmIjvTEFWR+KbXSwhl0A==
X-Gm-Message-State: AOJu0Yw6oWHd0/a8BtMMWgpaLrHppkH2VdzxrtGQ0OZK6j5TIUta+kmq
	FZ6gfsC7wLJLM5sICk6BaQcHc6H5pkyE5QBmud/w77jXy86dQBwe
X-Google-Smtp-Source: AGHT+IEWCA4gurmdVJk2gwjTze9EF8EfmZXQB8iAnLbJ8WfHDopZJXOL+qdyhmh86ykJJU1aT3nMNA==
X-Received: by 2002:a05:6a00:3a21:b0:6ed:caf6:6e4b with SMTP id fj33-20020a056a003a2100b006edcaf66e4bmr7175094pfb.18.1714055078988;
        Thu, 25 Apr 2024 07:24:38 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id i6-20020aa787c6000000b006e6b52eb59asm13178634pfo.126.2024.04.25.07.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 07:24:38 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: willy@infradead.org
Cc: brauner@kernel.org,
	jfs-discussion@lists.sourceforge.net,
	jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shaggy@kernel.org,
	syzbot+241c815bda521982cb49@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] jfs: Fix array-index-out-of-bounds in diFree
Date: Thu, 25 Apr 2024 23:24:34 +0900
Message-Id: <20240425142434.47481-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Zipl4PQ9Q7sBlMCt@casper.infradead.org>
References: <Zipl4PQ9Q7sBlMCt@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Matthew Wilcox wrote:
> It should be checked earlier than this.  There's this code in
> dbMount().  Why isn't this catching it?

This vulnerability occurs because a very large value can be passed 
to iagp->agstart. So that code doesn't prevent the vulnerability.

