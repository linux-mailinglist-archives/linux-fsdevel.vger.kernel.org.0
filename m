Return-Path: <linux-fsdevel+bounces-17223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCCE8A9212
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 06:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22A021F218BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 04:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9641A54913;
	Thu, 18 Apr 2024 04:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BD34n9rX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C0E4F1F1;
	Thu, 18 Apr 2024 04:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713414470; cv=none; b=PIEkB1ZG28A4rY/DEGaghG993mmDvMtjK3T8cAMsbUoT56OxPNomVI6D//PRUpTxlXjjUt/xV07M3GHs5CCbBPBP2flSxL+4GXrIjhygE9ylMOBXzwzYmh6isSrituOgyVXuNmxGDe2rvuEj0WBOvlgtKf4hAzNayrenMr90RzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713414470; c=relaxed/simple;
	bh=e+2n9zdpzho51DX26dxC0W/s2nVs2mo0YE4fE0B781M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J7A/2FN4rsrjDOi+3wgTzA82BakgheNLS2f1bk1fWbYwu8f1a0kztMbWdh6+M4OYEjQM2Cm3scoH02wsiTQkY2FGzbj6fiXjuEAv2j7Zv0XU9NcnKjAZLuMvZtnOspdABtvawOnpwOWtN955QJ87ujLuGRoJzvy67b8ie+Q/ZHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BD34n9rX; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5cfd95130c6so249381a12.1;
        Wed, 17 Apr 2024 21:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713414468; x=1714019268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+2n9zdpzho51DX26dxC0W/s2nVs2mo0YE4fE0B781M=;
        b=BD34n9rX1w/w3L/hvknEjm1CdBDDHgeB6gO0d3+hrlw/XrMk6xha8mbDm/phgiURqI
         SjVnGUumsbTbD0er7SZj5s34xgTxx8Mq+CmjHMfvX3EJ/Ktc9kWXv9UlyTaN+x8+Pmf8
         fkqPdnNRnIICM6DGo6RdNusQS29QOITNiy9CfnlEKa+Es7cBWPJAdv1GoYltNsAdCNux
         lozLuTjxxNQPmK6kJLhSxeYiugfMOcNElk6zNrMwsRSuV1lJHgeMm+pgb5EGkef3Rwac
         257CRMA/D/0/5MxvHbPMBtYQnsZ0BcBvcHEIfaoB5m7s2hJVdkHISjAycaCrYbMLJN2V
         ks2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713414468; x=1714019268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+2n9zdpzho51DX26dxC0W/s2nVs2mo0YE4fE0B781M=;
        b=V4KivVyUDRNva49nDJy9euLBAWv/p9buhbtvpWEyaSXGHln7KREuBsMK9lvvi1n0hi
         xVJhq07zNcIGHQSZVKT0PYv2kw0XYtMDJSbcIxX+o6q0hZyBp+V0kxJPhJW60765cGTQ
         HtyaywrdSO/Ec8P5WSLuQ5xUb80WhQvqHETvSp48+t6hBtar2HePNtbL10Yh6TltJooU
         tPSNJiOFtiAD4QGpjWuDcVYvxrDE3qU4UTahmsMBAI1Df6I2e083SooR5RnqOjqAaIw0
         KHTSGHZCrmZJIOdJ3I6tMJzSnr8tIJiaOpcSBPTK4x9x6MxzSN4SGyklx4SPK2HPHYWH
         GYoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWccjkDwmcGOIb0vdP1qMULulYJQGAWBaztQjoiQ+11T1aP85Dp9WN22Vm8ukoqXS1bRPm+UTd0/pHLKrdSPdZHEZLAMhT5ZI202MgvHL+gxwAUPonlQOrWbKBOd8bapqUi+qqN0xSdDTkbs3o8BP5Sp/aJBKm58WqEGQKi4jMzJlm9BrU0JA==
X-Gm-Message-State: AOJu0YwR1YIox9YeNwaRe6z1MLb9HITB2U9ZqW/aHK1pl3htONa54hZk
	1Un+DQm73cS4ZC7A0Am2s9Nx6G8dM0yZZHGDwPsZPSJo91eJmWXM
X-Google-Smtp-Source: AGHT+IGRp4EaYkCD6tb6+IH/JVx/AOdoqsGefrvDn+4Yx+ZzTEtN9IIFT8qTptKuHa0koMIDOfGx6Q==
X-Received: by 2002:a05:6a20:4311:b0:1a7:5fe0:1c96 with SMTP id h17-20020a056a20431100b001a75fe01c96mr2453379pzk.23.1713414467801;
        Wed, 17 Apr 2024 21:27:47 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id a18-20020a170902ecd200b001e5c7d05cc2sm477605plh.184.2024.04.17.21.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 21:27:47 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+606f94dfeaaa45124c90@syzkaller.appspotmail.com
Cc: djwong@kernel.org,
	hch@infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-xfs@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] [mm?] KCSAN: data-race in __filemap_remove_folio / folio_mapping (2)
Date: Thu, 18 Apr 2024 13:27:40 +0900
Message-Id: <20240418042740.313103-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <000000000000d0737c05fa0fd499@google.com>
References: <000000000000d0737c05fa0fd499@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test data-race in __filemap_remove_folio / folio_mapping

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

