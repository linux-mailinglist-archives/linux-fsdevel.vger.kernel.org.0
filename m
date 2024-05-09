Return-Path: <linux-fsdevel+bounces-19161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E1C8C0CC7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 10:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3257B2148A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 08:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FA714A081;
	Thu,  9 May 2024 08:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImtOGYI8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB4413C8F2
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 May 2024 08:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715244312; cv=none; b=C3zuVQEBvkT796sPTgD0A347OBQ+3FEbq0pjk9eiv7j9OpRJz/AwcMVHLrOgUMKbnEwxD9M9FBTI9ambbinXJ3opD5PvP1NoGYE4eOxZnhZUuVkFiZqqKNwGFbcs5WjjIV2aNkiX8hJ7fTOumiYFz8QGbYlREfUxynUD8SCzZOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715244312; c=relaxed/simple;
	bh=v42/8OApQi22SonBzn63FDJF+a5cpsQd7L+JtxNuIcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fHGjyVJhak3tRA7nWZaJ0/L/REWgimXJnC5pS9r+Lp8JPLBvpdoLQn1vbGLPsR3rxZR9l5VDlutfyHbxlMzuy6pfLFnUIuKuSVsMlSiP57oSoIJDnTdEZL5pPaar2T0j5HOozjc4STDLo0dA0l0W9bAD6oqiQTpQnlwwadP8p6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImtOGYI8; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-792bd82402cso30990985a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 May 2024 01:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715244310; x=1715849110; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v42/8OApQi22SonBzn63FDJF+a5cpsQd7L+JtxNuIcs=;
        b=ImtOGYI8xKzPG+ymg7jJ7kEJCXawcJcGZ6FLYF6zP7BURryVwiVy7UxTXdcUlrHmFw
         YOJsYh7sj5UaB2i6rpl++afNUsVS1utIZn1PziDb8zvMYTq/s0CiDbP+srfgflW++dJ9
         cbEY/p7C3IP8uNApITQgEiQ54DbiodDsG/25QZmLQR7m9utt/XkmimldcdidRtQZ2FNh
         otrbygE6267kpWNAcvYdtryxipToOiEAuWULQAWVxOhLEO2e8KepR46JmMZZCnnJMGcW
         OufFTVfe06LaVIFiVBuBscBdj5Oe7LDJCPemgEfGIcybHkwEllxI6tvuAVo7qRyBirVV
         6S9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715244310; x=1715849110;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v42/8OApQi22SonBzn63FDJF+a5cpsQd7L+JtxNuIcs=;
        b=t7V9M1Ni5E0q06wzZy/RcdAWMqd8Lmy3Exn2EfxW3u6oZnuyQmjZkJ6K6MNFgk4PR7
         TzpsBvMGGwNSlXa+Hd5Byw0xz0kA2gx1K8Y33/8FAPsESq1JvPPvudHpW+B/WI0OUQqD
         TVh3Azl2QAG7WD7pJrwd5mvmLLZy8UktuDX8wdiQ7QYTKVxd2xFrlg+AJ6BkfEmNl0RF
         n5Fd0HgHFZ6keiOviLS8KFATzhXS7RDfi6BIGK59ZyU++YCF1QwuFurUWTEZKQgxahnW
         pu6Kbs13nYRrPxRgeRhckeAb/NTM+OxhdG04iAtmghYBsNBWxUr58hHNBxTN8tC+l16M
         hCoQ==
X-Gm-Message-State: AOJu0YzLIZUNuudxOzbwulOwWZLZ8fxfxRLJEBBYA/nPdROKB+IypVJp
	JRhLYb3E55bKQ7iPTNApwO1/1kVXJPN8oyMT7ov3NW9hdx5qmn8VhI7GHXgjvuxkPaSeV+Zcaq/
	blcMCKrQruLB+vMGV7LNi9HX1lq8/lQ==
X-Google-Smtp-Source: AGHT+IFUwW0vmJT1lcR+bq4+PtowXC3rtaZbVYmJLx047wP+Oy0V3kooIF9AlmYCPYIVRo4xtcydkZS7L6yU0NOWxhY=
X-Received: by 2002:a05:620a:9358:b0:790:9862:ce1e with SMTP id
 af79cd13be357-792bbe19035mr323682085a.20.1715244309823; Thu, 09 May 2024
 01:45:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1715243542-29509-mlmmj-76fd78f9@vger.kernel.org>
In-Reply-To: <1715243542-29509-mlmmj-76fd78f9@vger.kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 9 May 2024 11:44:58 +0300
Message-ID: <CAOQ4uxij0aF1JMkqqVKfG2OS1eufZcbtLQF22GTgMi+rSSaCeg@mail.gmail.com>
Subject: [LSFMM BoF] fanotify HSM update
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: lsf-pc <lsf-pc@lists.linux-foundation.org>, Jan Kara <jack@suse.cz>, 
	Christian Brauner <brauner@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Content-Type: text/plain; charset="UTF-8"

FYI, I plan to do an fanotify HSM [1] BoF at LSFMM.
I haven't put it on the agenda yet.
I'll schedule it closer to or during the summit.

Talking points:
- Progress since last year (untangle vfs permission hooks [2])
- Next round of planned patches (pre-content permission events [3])
- Open API questions: dealing with the death of HSM service [4]
- Use cases for HSM and the FUSE passthrough alternative [5]

Thanks,
Amir.


[1] https://github.com/amir73il/fsnotify-utils/wiki/Hierarchical-Storage-Management-API
[2] https://lore.kernel.org/linux-fsdevel/20240105-vfs-rw-9b5809292b57@brauner/
[3] https://lore.kernel.org/linux-fsdevel/20231207123825.4011620-1-amir73il@gmail.com/
[4] https://lore.kernel.org/linux-fsdevel/CAOQ4uxiW6dxz8w3muHxogbPuNGa0cdubr_YSti1Jp97LLehaYg@mail.gmail.com/
[5] https://lore.kernel.org/linux-fsdevel/e9aac186-7935-485e-b067-e80ff19743dc@dorminy.me/

