Return-Path: <linux-fsdevel+bounces-59007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6ABB33E3A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 13:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2007A189D1EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 11:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C982EBBB8;
	Mon, 25 Aug 2025 11:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZtwz8/m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A693D2EAB88;
	Mon, 25 Aug 2025 11:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756121966; cv=none; b=h/IzxLZwHESdAz3NCI1OoxC7nTuDLI7Syea92kBYiYoPTX9CTyeOcClmXo6+GsbOmjdTYyIaPcYXV1GvaGXtWUUw5WrtyndPWEdj01xrTqH63o6vrviMPlK4cRsBhyKpKQ3m+xVSQKpGE3635yxjDWfe8MgLn5+A6gyviJ7DCyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756121966; c=relaxed/simple;
	bh=K/kQgRpgKBpeblGCmioA9JFLsth+5XACElYdWEdqDXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BuI//H/oHjNhbXcJkmTnQXvkz5czc1m6rzrqA9k9WuyHoEzo6sGn4nG/zLYv0mMo0MbSDxFeNQYBy+lLlLv+8m0fRLzvMVPPGgK+n/6cxh92o1V+CeOgnGTkUvPiH7Pw8qNs/AZ8QXJY/J4i02woJEEgW6C3Wen+rGu4ggNheJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZtwz8/m; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77057c4d88bso783896b3a.2;
        Mon, 25 Aug 2025 04:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756121964; x=1756726764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aa/TXY2Um582KR4JGo9xX6kjB6nMiLz03lhm+4RC4ho=;
        b=MZtwz8/mJw7bfKDJ6MFISu6bjPQvk4vQbGgsF8AWwzBZbh+KKwdsz3H16OgSDBzjZF
         T/ewVcul144cK6YxuPFdSr00jO3zOUw8IVtv2zcTFE8LMvQplVHpypNacOb8ebzti/4h
         54BwDCmR8RNqBluia+26HVCN/8SzlMQ6WADFERgWbayUlU4fvJOU1CaVP4Qlg6nixU+d
         x3Dx/HfJSdzrmcuk24PuINB3JQYozqEtJN2KNSSFWLHOkBZgipRoV8TIjYhlhPV3rJRR
         tv9Fv+Cd8ph4RAfw+TuZlEXUxwosTN0eBSkUUJ5TYCr3ZExysuEU02XE8bHFJhx/dh+4
         CigQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756121964; x=1756726764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aa/TXY2Um582KR4JGo9xX6kjB6nMiLz03lhm+4RC4ho=;
        b=BrRPBqhMW2KqZ5xN6+6TVp8VSo6zVG6yqPP37jLqOADqHNfxPgT6V3kkp3NNK8lemW
         mZqYscn11jMrS1gd48cy42g3o9K9W8YQ3riQ/ltEOtmvEHW5dNwcjbgpgCK8+1FXhe0c
         u+FUay/6GSIH3VE9xWkHBwO8lQOKabqohGn+YZWZ4jiuA6Wj82sVT0D9fvRyd40G7hKC
         lSxoYdrxG4oUjW5sjU0ZbOqqaArllyBQSRvkMOM/hy1gSFl1P/aTnhTyZuUC7Xc9+jXC
         +YkwBzp9c2u5xHFv+vsvO84kBY8eRrs1LTM8aCaf1OCHQgJ0ESSyZlwW2TbZXpETVHU5
         xo6w==
X-Forwarded-Encrypted: i=1; AJvYcCWeh6JXtliU/sKNFCGRABvcAF0R0zM3V/APj6J+iv3+xkUnXaycVUqFZ5MFqeHU3bzP6utGRl9HDD18d4A1@vger.kernel.org, AJvYcCWqqF+9PJ33Nv+64Y42pjZvXOotayyknW8wk6veSpL7QNmwL3WD+3+3PrHBWtPL2ae7LcNtYzMrRZ64@vger.kernel.org, AJvYcCXiuAg11it9dCpABDcghce4Toi6Zo1KX2CnH2KrFRZQtQC9AScf3G0E40l6os0MlzzoVUYY6/Oe37CVYQoX@vger.kernel.org
X-Gm-Message-State: AOJu0YxmIkHZPWS9MsWzMAmGhDI0iRKxwpEz6LhTcv+c+cvUMTI06W2B
	c5f1yvDc575ysR9Yum9JRee5AZbgXo1N3bGKJ5H8ACTHPcg+t9eDii/T
X-Gm-Gg: ASbGncvxDhGgCs0FQmqj2T9paqR6b57TYVxj1YQAHxuTgCcxEmLcjoK50Wt3jzzl8Q2
	QZZz9ZpW9oHKPDakl8797q/lTRUt33GO8CdBM399kvcKcV/n8NE07CGCogFLGoKM1nSXgBWgfkr
	quG0gof4Of/ejwxJiQki60fPlHpaCJMoHwc162zAvsXszn5QKvWQfsDchAW7FOVidqcMebJvsat
	6KvERe9p+dUrDragDv/M9L7uZQHxO408XKA6Y2IbZOWSxQ+kWHjPmKrHfu/FWEIEUOq28Mu3Usk
	YW6wk1v7gZeF7up2ns1QYYO7JrvsJIGOsGUz/9PSjyEAlRkDA3Rc6nqpcXRdqKhv0H6gF7Fi5Gc
	1/Mg6hurYD5D2SumRv/OReQEU/5qCWJzQT3aEQ1upF7zf5g==
X-Google-Smtp-Source: AGHT+IHCuCjkmgp3p+p6iAGzISrTsCb/4rjCyc4Apur5alh5Oexeff9wgo/3iDzWpADlrmQy1iRhEQ==
X-Received: by 2002:a05:6a20:3d85:b0:240:e327:d7a1 with SMTP id adf61e73a8af0-24340b8db0fmr15619900637.1.1756121963643;
        Mon, 25 Aug 2025 04:39:23 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49d858ae34sm4534931a12.47.2025.08.25.04.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 04:39:23 -0700 (PDT)
From: Jinliang Zheng <alexjlzheng@gmail.com>
X-Google-Original-From: Jinliang Zheng <alexjlzheng@tencent.com>
To: hch@infradead.org
Cc: alexjlzheng@gmail.com,
	alexjlzheng@tencent.com,
	brauner@kernel.org,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	yi.zhang@huawei.com
Subject: Re: [PATCH v3 0/4] allow partial folio write with iomap_folio_state
Date: Mon, 25 Aug 2025 19:39:21 +0800
Message-ID: <20250825113921.2933350-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <aKwuJptHVsx-Ed82@infradead.org>
References: <aKwuJptHVsx-Ed82@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 25 Aug 2025 02:34:30 -0700, Christoph Hellwig wrote:
> On Tue, Aug 13, 2025 at 05:15:34PM +0800, alexjlzheng@gmail.com wrote:
> > From: Jinliang Zheng <alexjlzheng@tencent.com>
> > 
> > With iomap_folio_state, we can identify uptodate states at the block
> > level, and a read_folio reading can correctly handle partially
> > uptodate folios.
> > 
> > Therefore, when a partial write occurs, accept the block-aligned
> > partial write instead of rejecting the entire write.
> > 
> > For example, suppose a folio is 2MB, blocksize is 4kB, and the copied
> > bytes are 2MB-3kB.
> 
> I'd still love to see some explanation of why you are doing this.
> Do you have a workload that actually hits this regularly, and where
> it makes a difference.  Can you provide numbers to quantify them?

Thank you for your reply. :)

Actually, I discovered this while reading (and studying) the code for large
folios.

Given that short-writes are inherently unusual, I don't think this patchset
will significantly improve performance in hot paths. It might help in scenarios
with frequent memory hardware errors, but unfortunately, I haven't built a
test scenario like that.

I'm posting this patchset just because I think we can do better in exception
handling: if we can reduce unnecessary copying, why not?

Hahaha, just my personal opinion. :)

thanks,
Jinliang Zheng

