Return-Path: <linux-fsdevel+bounces-16045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEADB89749D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 17:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0BD21F2148E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 15:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E31314AD12;
	Wed,  3 Apr 2024 15:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PlU7SVui"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6405014A60B
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Apr 2024 15:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712159740; cv=none; b=R5pl+mIFQ5S47a/HL5in292AdZUdrLZ9b/R39lKQKtYL1w0P1KsZQuZ4BSGbQv9ghglQ8S0EbCtR4S857/dev8umobij+yRnrZVWoc6PuelmXuc9z1129pnBTpb80bI9fZdnHriEdMJ0oMkmELEvtHjCmXRxcHB6CxNuzoT74oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712159740; c=relaxed/simple;
	bh=IwYLSmw6cSGNLuV0Ni0hrtcuYuIHxuLFn/0L5iZ3uzY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=IlrlFnjFteQ+9nGB58d/uLWkyhV5Cqxj0k2LdUDfBkavzTx16rC/e+qitp3t1Ei/RUUpOnqDFnf7b1BtHtgGGsphLXJM13iuyeaYhhiK59snPm66ER0t4/4PsTPdGPuf4xlpu1+mw/fFIzDF8UC9yk1n01kNDD88pp2RYFOg2LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PlU7SVui; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712159737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7RJPDwaAOgtbZoy/29/fhYCHYRqX2V7Vbp496XGZuLc=;
	b=PlU7SVuiybn2O/SC+UaMq9iLzsCstoaXpm+BwHJG8urt1GkVNPJJ1ZD6qIs+jm2MSY3P5A
	B4zpfRmoHc9P2fGXetvfN7stpBguCXl1VdCRqTTQFOKjUKJSdjj9zkkBLYwsO4hhoc2z1P
	67qDHFd4k+SoXeCPqMRJn8YlQPjRFtE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-WqU_50ExN_OZkrmpEa4Azg-1; Wed, 03 Apr 2024 11:55:35 -0400
X-MC-Unique: WqU_50ExN_OZkrmpEa4Azg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a4ea036a646so2405066b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Apr 2024 08:55:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712159734; x=1712764534;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7RJPDwaAOgtbZoy/29/fhYCHYRqX2V7Vbp496XGZuLc=;
        b=fCZKJ/vw2TyJzVlNHofTqjpGgwLZLAt3/L0vWEIhogUJ80p2FgLyW7MFOANB3dwOe8
         OfUPIapEEbYxPQdbpDPk7/HN6sTG5SaKGslZmurxfi8JD96sii/DOE7yZTQN0dUYYBtV
         XOEumb9R8Ue8aQqFhjtB6Fk749cQfLVRXCAZk/f5ydI5i8wc6jzygPVGrJP0iCy9BjtL
         WvkEC+OFfInoiZVq+vaSJkEk++vXcCCnl99xHgIarWzHizZBdDVqTiK1oKwk6Cfk6ZyK
         uiRWiaOdsCjXZvut/i0FspToyjx6CjleSkVPYEBRUgI96Pxy+MQZYtOLmZj0m5yb7kud
         Enmg==
X-Gm-Message-State: AOJu0YzqID4aKy//9kQIj0KR7xV082BWpCGS2hIYT+t8gSuLV4NWGLTU
	e9xYrIhsM4jBFUdwjsPvK3x528dmoPMn1lveBsQwwuCEMt+2oQ7APnTMDBAhVZcJQl6HA9IW5g5
	IW0jY+1sk+bwLej9oZndasHdgb2f03GX+4xartWLi/XYMxXBKt3xzIn/7Fp28CFU=
X-Received: by 2002:a17:907:2088:b0:a4e:4e8c:bedc with SMTP id pv8-20020a170907208800b00a4e4e8cbedcmr7916552ejb.53.1712159734703;
        Wed, 03 Apr 2024 08:55:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLNqrunE1FiBRVtmLkrQRwQXKNs/L7K0nBHa9W3hVmvgbWBcmFn0s9kHAY8Q4Qk2Mzij3JMQ==
X-Received: by 2002:a17:907:2088:b0:a4e:4e8c:bedc with SMTP id pv8-20020a170907208800b00a4e4e8cbedcmr7916540ejb.53.1712159734395;
        Wed, 03 Apr 2024 08:55:34 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id bn1-20020a170907268100b00a4e6750a358sm4036971ejc.187.2024.04.03.08.55.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 08:55:33 -0700 (PDT)
Message-ID: <88f45a04-4218-4d40-8338-86cbc4e3e61b@redhat.com>
Date: Wed, 3 Apr 2024 17:55:33 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] vboxsf fixes for 6.9-1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Colin Ian King <colin.i.king@gmail.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Jeff Layton <jlayton@kernel.org>
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Here is a pull-req with a set of vboxsf fixes for 6.9
(I am the vboxsf maintainer):

- Warning fixes
- Explicitly deny setlease attempts

Regards,

Hans


The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/hansg/linux.git tags/vboxsf-v6.9-1

for you to fetch changes up to 1ece2c43b88660ddbdf8ecb772e9c41ed9cda3dd:

  vboxsf: explicitly deny setlease attempts (2024-04-03 16:06:39 +0200)

----------------------------------------------------------------
vboxsf fixes for v6.9-1

Highlights:
- Compiler warning fixes
- Explicitly deny setlease attempts

----------------------------------------------------------------
Christophe JAILLET (2):
      vboxsf: Avoid an spurious warning if load_nls_xxx() fails
      vboxsf: Remove usage of the deprecated ida_simple_xx() API

Colin Ian King (1):
      vboxsf: remove redundant variable out_len

Jeff Layton (1):
      vboxsf: explicitly deny setlease attempts

 fs/vboxsf/file.c  | 1 +
 fs/vboxsf/super.c | 9 +++++----
 fs/vboxsf/utils.c | 3 ---
 3 files changed, 6 insertions(+), 7 deletions(-)


