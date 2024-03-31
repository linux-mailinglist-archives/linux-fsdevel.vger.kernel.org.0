Return-Path: <linux-fsdevel+bounces-15793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0479A893083
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Mar 2024 10:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1944F1C20B7B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Mar 2024 08:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D599C143899;
	Sun, 31 Mar 2024 08:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aG0O5Vyu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8986143874
	for <linux-fsdevel@vger.kernel.org>; Sun, 31 Mar 2024 08:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711874749; cv=none; b=fMACbf4qcRjUqZazDT7xOkrkKrOklCJwSXdvibkAFbkdaxSq6g+AOVFXQT0kk/66E87LmwAoAaaoP8lTPuGnbCuHBO7xs5ziBkPCOPvYs2f6CgkqU01cAdPlq8v8jllRY/F5AcuE8jvHA3NrmxA2o4LgAjp9PGUb6iXRI41GuqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711874749; c=relaxed/simple;
	bh=PP3MFzXOn0y5/ZwEiMfjnPaChdOWdaVsrRcHCUE4yLI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DxAWAYa1zwXnOVcoGC313wW1/iOMDElFjrLSDzvfW7pB3kwOMWTf2JKeUtNz9XoXdwthiRCrD1Vlr4aHUg9/3WMt+wcn7ApIh/6w0DKtdZ984GzT3qebviajX9If4+rQ+ESHbi/J/fie4DNS22SVw1GzVehMWEi4M7VXDwUtzPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aG0O5Vyu; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3417a3151c5so2155234f8f.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 31 Mar 2024 01:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711874746; x=1712479546; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xcNHdYD3uD4iwF1+LVPcIdLIGHnCmbVJHNncy5BFB3I=;
        b=aG0O5VyujCC81koLD95TDTDEG4uCpHUaAYiSGNt+boCc9zPZ/fXpH2PXP9kOkV91tB
         x63Pn6QEDck2OqgvWgGdXtP4VZ4aJ/arUwwh5GXW5G4gGY80g7K7N0kzoo8J225oCwfn
         L0LJgc4Kbz/THKIX95sCC4PNL0obTTE+wCKMWixEywVBE8bVsrGD9ws2OvVSQKaZV3H0
         a2tzj6fFGkfYuY5ZmT3zq560Bp2deH8ec2RrvwjpzMakeeYczWxPusQWj+i4lz+uO3mG
         Cnc9Y0fGq/1yQKTXs/HLE+trGki09rH5wVXKVDU5wxmvRc6x5Qy5AhbrTphWCGODVtUw
         sisA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711874746; x=1712479546;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xcNHdYD3uD4iwF1+LVPcIdLIGHnCmbVJHNncy5BFB3I=;
        b=DpWJZACEt4FhSd9vhRafTlwcVJCB0WhsWwN71CzberWddVx5TYsAgySbXbkZs07oXQ
         n6BqDZJ6RS0ar9sNlskY5I0cNPvXTW1sF8HRtJWWgv5lPhlwn8wdJ2OOvyG+nFd5J2r/
         tYOpJ7vbaMIcJWzz+qDQvXABt9SVZy+oX5rDimsrlyz4ZxwNjDj9mKQITuxLUJUBI5Pa
         Rth+X3Ryr1RN6QNb4j5XLYiTbN+HU+dSfSHYXI2JNQl0p3ppLXKgSm1/FY4qGcfPhW9X
         19q9c+0mPfDFSzW70YwUoAiv1ir2PmNTK6yFIPN0OTBffJ9SyIUMv9xUxDFScOlGmQ+/
         7eIw==
X-Forwarded-Encrypted: i=1; AJvYcCWmUaCEnD9x7F3bGHsJIvvpnXt9bEOMjmJpkinmmRdNphYIp+wjZBL44INtit82Opmjq3iJAt/MPdp2rfqDHPfcHA/fF9Ory2nPIMCweA==
X-Gm-Message-State: AOJu0YxQAQdUWsR4L45Vv06QNBwLmn42os8/5Sm2lZ7y5e6W0/Lka1tB
	qIpuHjOb1MHaYGhb2GLL7bU7ei+tKfeiyleFPMsbgPY8TZOndhYuoBeRVAXnRnc=
X-Google-Smtp-Source: AGHT+IF/DueA2PBRDGmO2TtuT13FgHrtD/WPr3XSdbfSoaU6s/njcw/s8MH4eYl/SKdnKp3BHlPy/g==
X-Received: by 2002:a5d:5cd2:0:b0:33e:b7f8:7c66 with SMTP id cg18-20020a5d5cd2000000b0033eb7f87c66mr4407740wrb.41.1711874746454;
        Sun, 31 Mar 2024 01:45:46 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id k17-20020adff5d1000000b00341b7388dafsm8436003wrp.77.2024.03.31.01.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 01:45:45 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 31 Mar 2024 10:44:04 +0200
Subject: [PATCH v2 17/25] net: virtio: drop owner assignment
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240331-module-owner-virtio-v2-17-98f04bfaf46a@linaro.org>
References: <20240331-module-owner-virtio-v2-0-98f04bfaf46a@linaro.org>
In-Reply-To: <20240331-module-owner-virtio-v2-0-98f04bfaf46a@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jonathan Corbet <corbet@lwn.net>, 
 David Hildenbrand <david@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Jens Axboe <axboe@kernel.dk>, Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Olivia Mackall <olivia@selenic.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, Amit Shah <amit@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Gonglei <arei.gonglei@huawei.com>, "David S. Miller" <davem@davemloft.net>, 
 Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, David Airlie <airlied@redhat.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Daniel Vetter <daniel@ffwll.ch>, 
 Jean-Philippe Brucker <jean-philippe@linaro.org>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Alexander Graf <graf@amazon.com>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Kalle Valo <kvalo@kernel.org>, 
 Dan Williams <dan.j.williams@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
 Ira Weiny <ira.weiny@intel.com>, 
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 "James E.J. Bottomley" <jejb@linux.ibm.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Vivek Goyal <vgoyal@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Anton Yakovlev <anton.yakovlev@opensynergy.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: virtualization@lists.linux.dev, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, 
 linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 iommu@lists.linux.dev, netdev@vger.kernel.org, v9fs@lists.linux.dev, 
 kvm@vger.kernel.org, linux-wireless@vger.kernel.org, nvdimm@lists.linux.dev, 
 linux-remoteproc@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, alsa-devel@alsa-project.org, 
 linux-sound@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=762;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=PP3MFzXOn0y5/ZwEiMfjnPaChdOWdaVsrRcHCUE4yLI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmCSJffxI4Z5TfMYMSpOyODj20o+iKchhBt8eG2
 RcFp39ITi6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgkiXwAKCRDBN2bmhouD
 18c7EACVSj2LxuY1kDJ/a/5yYvVwRoXJ0BWK8qxjw2Gwc6iH+PJIF6JCQgfBSLRVpYvYMQK64uF
 iZwkwJ65d/TvVkabpkwfL2OmiRPAE+dFo3V4lSpPOCSOlansAs6zh3VKH3PYM0TfidHcD+MCu10
 4vJhU6fa7BhDh2kdu5Ozk8d287IgpHzB8eYA9IAINi7/N5MzYFWZYN0pgAAhWRyO4nlX8evTq/d
 8dhdUo7vMLKdbkMpy8vKM6O9PjvxJL4JBgXkjRjZrAPp4eM0wgy0x2dXV3DqFemJonOxszLocyA
 wtuS4XBUU5fC3R3VP/KyfCOyDCPrP5lGyjQ/sPuIAmO6z5MhQNKYmR8xpKWlY/XHDdxqUsfUgEf
 2t1ISEjXV051K1EKBmHegNm0025Ta/aO0EEYBV/AFvxLOd0YgjNIMKKD7sbJLQfaJuw25xA8+dz
 22GkSbPi5I8U8mC0xeGbjfa1JggSku6qvshxj+gJqo9uq+sP753PlE6uI/zFCXdQaZLw6Rl1B2f
 yOSSZxZxa1RX9I7zqcb/NsqeKJxLyKqhCz67IBEgjGZd1Jmv5pmDjdyTIblw5UQnDd3lT14wGKg
 VCOa58hRH95qkKaYhyXyK5gEH9pww+UPPk59LSTOybxso0+FjG9BIZT2AeNUH+7AgDpPx0kNkYx
 9uIlz+7tgwlhrbQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

virtio core already sets the .owner, so driver does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Depends on the first patch.
---
 drivers/net/virtio_net.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c22d1118a133..61f680699648 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5021,7 +5021,6 @@ static struct virtio_driver virtio_net_driver = {
 	.feature_table_legacy = features_legacy,
 	.feature_table_size_legacy = ARRAY_SIZE(features_legacy),
 	.driver.name =	KBUILD_MODNAME,
-	.driver.owner =	THIS_MODULE,
 	.id_table =	id_table,
 	.validate =	virtnet_validate,
 	.probe =	virtnet_probe,

-- 
2.34.1


