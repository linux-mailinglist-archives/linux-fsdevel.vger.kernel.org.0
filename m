Return-Path: <linux-fsdevel+bounces-22977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0887924B76
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 00:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86AAB29185F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 22:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382E51C2DE0;
	Tue,  2 Jul 2024 22:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OtWv69sG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261221C2DD8
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jul 2024 22:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719958344; cv=none; b=PE9rCFjnpagwddFNwvdVedr7jelNlUrhfk+XlN/MNzvi51KBmLj4pNra02x2LiLzQzgCnSzZOTwq6roGjNqXCgOviwD6qq2TZ2ddiELT1+tv3TGs4Wk/04jsm4kGs6eE53835PQRz2hY2VziLVsFFVBj8xNT3RIyLJmDoOmz67s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719958344; c=relaxed/simple;
	bh=+TZd3udnMiWa9USHMCPPUUAfFQGOOTYzWRJNCFiucLU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Q8zX6e22/VPNuGFYSjb61fCPGAy9nAiNVhWha+noMfxhLMhfvM2295SoQ3CCupv3Nc7Y/Agua8+KxmFUKTLQDkfE47/EC8mOvkt9l62kaZbUjeYL6rVpsouyyx00UvUYtTParvaPQ3zj8JHCn6Bllt2ZgONQn0PNwToXyWxMY1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OtWv69sG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719958341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=O9AgJYGYeAwFaEoWp+ZiajfSNQTynld1o/7FK8N53c4=;
	b=OtWv69sGzJL2+Rl+9/Hk88lmJErun6rAUTmr+3s8I7xExd9ZOd0u72ChuX6YoLTYieNDwI
	4AQf2Fal8zt2DJobykcRaJ0K6na754IXK4oMzRnLRihR62funHiRV5q1G+HyyKL6aU1CJa
	PLGVBKa3nRHgP3d1d9Xw56Wco+q3zNQ=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-CfTDSS6kNVaP1_E-JxNXKQ-1; Tue, 02 Jul 2024 18:12:20 -0400
X-MC-Unique: CfTDSS6kNVaP1_E-JxNXKQ-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7f6530b381bso128410939f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jul 2024 15:12:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719958340; x=1720563140;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O9AgJYGYeAwFaEoWp+ZiajfSNQTynld1o/7FK8N53c4=;
        b=jQKhrdximfJqGS2nqd6qBv00IJr4ApqAFJH00VDDo3cJtdllzgQ/fUOmHg2MmYkRe+
         JOKqHkGJNeLpF0av+nFgs/b2IRQdWtAhhTHz97yCHrD/K5vHgWJOrd9ebRflmUAVa/jc
         8SRzDHg3xEBcVGalQCmOR2Gpm+AxiB/I2WXaEtNPnMI/dhQbTn1HNy0rz/oaDBsKeZH/
         M1Ifekg3P1tmiS05TVNJyI1S27z4IUtZtJwGpt6ESNjaqnxH0PL7dXkHunJsZJYDBdLa
         DKDeVxZj7dpnO1YyOoW7T0u0sf240/LJ7VNBA+8vnUykSdkGxdRE7n1THrxpNswm1Qvi
         6qCw==
X-Gm-Message-State: AOJu0Yz8C5f7ytt/ZfOPc6279UpqXl5nKRODH2JwBlTNdCUGHNVOt7Eh
	cnx/ASK/gMENfGGWH8wLYiwrsUGeEnZ/WTow3Pn2cgACTn0o8kasDkPVYvTUHAue4b86Mz8pVd3
	rPTbfZfwjnN2LseZcWX5/sdZELZxEbYQSxp2BQmq4KhQCJJL7UHx3Pg93xG4ciPOIzBfwITtp7c
	BsIZChvv63BB3nMGu3AfMNDaO8mvX+MflTrcM52uUrJ0x44w==
X-Received: by 2002:a05:6602:15cb:b0:7f3:cd56:2573 with SMTP id ca18e2360f4ac-7f62ee01d77mr1570858939f.4.1719958339654;
        Tue, 02 Jul 2024 15:12:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF74o0l4vvAsVHhENK7S31oQYbssOHEGDlBVW5rNmdKSXnyPNhmvF5fry3rbzkdEIACZtPtGg==
X-Received: by 2002:a05:6602:15cb:b0:7f3:cd56:2573 with SMTP id ca18e2360f4ac-7f62ee01d77mr1570856439f.4.1719958339272;
        Tue, 02 Jul 2024 15:12:19 -0700 (PDT)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb73bb37f3sm3053753173.25.2024.07.02.15.12.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 15:12:19 -0700 (PDT)
Message-ID: <89e18d62-3b2d-45db-94f3-41edc4232955@redhat.com>
Date: Tue, 2 Jul 2024 17:12:18 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
From: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH 0/2] fuse: fix up uid/gid mount option handling
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This short series fixes up fuse uid/gid mount option handling.

First, as was done for tmpfs in 
0200679fc795 ("tmpfs: verify {g,u}id mount options correctly")
it validates that the requested uid and/or gid is representable in
the filesystem's idmapping. I've shamelessly copied commit description
and code from that commit.

Second, it is switched to use the uid/gid mount helpers proposed at
https://lore.kernel.org/linux-fsdevel/8dca3c11-99f4-446d-a291-35c50ed2dc14@redhat.com/T/#t

Both of these are compile-tested only.

Thanks,
-Eric


