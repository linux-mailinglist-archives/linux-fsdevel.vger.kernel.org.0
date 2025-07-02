Return-Path: <linux-fsdevel+bounces-53742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F236FAF6625
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 01:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48C701C42E0A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 23:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA442BE62F;
	Wed,  2 Jul 2025 23:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Gmjuk/Jo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E861325F994
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 23:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751498357; cv=none; b=QnUXTi8xp28w6d0vcKHi6VDmwv79dtF5cnHTpk5tHn1ffPfqjnIbkqTYfBe3LKZ6uYnOYsZ2cXGlZ8r2Hoc62Hz3t/1+GTudTkKGhiEUQF3xh8bK9sLinPParYRRnDy6sj1TsmyX05wDD4nnYQCaXPPTkddyluP3ypNcMXfjsGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751498357; c=relaxed/simple;
	bh=2XuKrjuTzfADbmarj0Xs2JyIvENzZiudcJsrwvv0B0E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gWAfI75kIBqH4MxyJ/3XrBdWEL1eNk8N9GspfT0DASpItm2YgvnxVc+BXgp3CWcBME1AyCBQe0FaKEzOrDbm3oMjjahHLvNwwSyWmX1+a3BwizfvNxAtV+SgnpdIsdvz7OvNMmssR8x44QXOsu0NeOgS4Bj1npkKf8NJTjQ3tDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Gmjuk/Jo; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3e057f2c8d8so8980955ab.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Jul 2025 16:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751498354; x=1752103154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0l/N30YfYOnzNVPk9e9LC8H0KdFEXlOJ5r3jt1u/SPs=;
        b=Gmjuk/Jo8TL8QKzIbszNqUXpeKqZ4p+m/ro4pZMWu39GcXG42Lz1T/5cKI12rrIjkz
         UhuCq5sBDOecea9kXZ0LemT6j69SRpFjMylDAA0TAvJzvqfmeoahI2xzqIEDeoK6op59
         qEkr8yAENGK2PAx+BHNxkahUGaChel2DwKcoK3WXfUF21gv7sS7IoVraejb5+Jbbb98v
         wOchNd2xIewdNb0NCpFRTBarR69gB/5Ore2fTV1kSiaoQ2SSlYjMgKN1mI5lbtFQ67QF
         lVS+BbEPKsfOo8i/7nDJFQ26qoeULgAfnTB4KSBoHaid8i3VxFDsJGjP62pHKvIqlQyx
         000w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751498354; x=1752103154;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0l/N30YfYOnzNVPk9e9LC8H0KdFEXlOJ5r3jt1u/SPs=;
        b=LmgckqslQmkAViiDWXB/dAfkZRdX49jqhGr5HAgwjcC3Li/KOEtlHe4Wca4t2pSdfq
         PzQ04O/zGSgUaSI/dhnvAPLRiDGeNTUAmxqADNrjYDh4zumnHT37zGjeBfQJWFtLPwxA
         aoyu9aKjdd8LwCXBhiQWNycmmJwZRB1VnomBDcVpszcIcgLc6d9FQd9uwfzBjzXptNKF
         TJ7DHBq7d1Z8B5x39HrzJ6dX2jUgihB7+YHNsiDkbpiL3qqsm4QUYye+jRY/y1EBN471
         FvyNMqcI6VDv4fgcbFlySp2IoKWAHsqmZPCKLaFJvZ3uMRJHArq1p0Nbe2uZHmgHO8px
         p4Zg==
X-Gm-Message-State: AOJu0Yzsh8rDV8GTXUcgp3by65xlw1hI5A+M6BnKWE4sSSh7fXzzJPMJ
	9bms1Sy2nsZswMGlaKsPR8BNNAcJzhzRiXepqytEexQm1D7KJ3g8VXNPjC3kchKFPuWH16mMX+U
	r100p
X-Gm-Gg: ASbGncsFwQLw+V+YpxlQTiuJi3laDqOadRSO8InWvmq0scM7uAxTUbAxnHh/SP9lXSL
	GAWaH1Bj6brzHUWNle4sBCzrAsIoJBLwd9rbYyQu0NJp5iMANLfxd2g5dPyFAHjCZjYF9gXpgx7
	7pNrPmYTOHoOgAyCohyvFtL95sblpN5KaQmvtOkoeAWMqEGZcVlHvtWq8VLx846VYKlfbM0+2qx
	0Vh8AuKSwzMZpntmpmdyutxHzjifC4CHqjzMhksMuP7Nxax7sTsmj8ib6c+J6hJRC6rdv8ngh7x
	BmJ7arf9DaH5G9pZgc4RMfgprAIImX2lTzHDx4FbTL1c759r5Tv8Yg==
X-Google-Smtp-Source: AGHT+IHMH7E5jXmc85tpF2ZmfhX9o8LwIpGAXUuM2IRAjJ7JFybYjfZFdD948UlZ9MRk58ULXnrHNQ==
X-Received: by 2002:a05:6e02:380a:b0:3dd:f813:64c5 with SMTP id e9e14a558f8ab-3e05c9d5573mr12171415ab.22.1751498353991;
        Wed, 02 Jul 2025 16:19:13 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3df4a09165dsm38313005ab.43.2025.07.02.16.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 16:19:12 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20250702211408.GA3406663@ZenIV>
References: <20250702211305.GE1880847@ZenIV>
 <20250702211408.GA3406663@ZenIV>
Subject: Re: (subset) [PATCH 01/11] zynqmp: don't bother with
 debugfs_file_{get,put}() in proxied fops
Message-Id: <175149835231.467027.7368105747282893229.b4-ty@kernel.dk>
Date: Wed, 02 Jul 2025 17:19:12 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-d7477


On Wed, 02 Jul 2025 22:14:08 +0100, Al Viro wrote:
> When debugfs file has been created by debugfs_create_file_unsafe(),
> we do need the file_operations methods to use debugfs_file_{get,put}()
> to prevent concurrent removal; for files created by debugfs_create_file()
> that is done in the wrappers that call underlying methods, so there's
> no point whatsoever duplicating that in the underlying methods themselves.
> 
> 
> [...]

Applied, thanks!

[10/11] blk-mq-debugfs: use debugfs_get_aux()
        commit: c25885fc939f29200cccb58ffdb920a91ec62647

Best regards,
-- 
Jens Axboe




