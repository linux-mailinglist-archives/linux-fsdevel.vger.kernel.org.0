Return-Path: <linux-fsdevel+bounces-15791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDE8893072
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Mar 2024 10:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F06251C2127B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Mar 2024 08:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19216142635;
	Sun, 31 Mar 2024 08:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RIt+s0B0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8B8141999
	for <linux-fsdevel@vger.kernel.org>; Sun, 31 Mar 2024 08:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711874742; cv=none; b=pB6Ox7/Dj6/mqItSVom5MqQDqWjdO2R8KSCVUhNNTJ0rTPOKlb+xKdxvkYiDjnWuruGHzeDxKpjwF+6OMWtP4quKrGSip3lHiTbBwQEMwSWkVNAJxBsR+pw95ys4BriV9FsoQznn/+Dpx3xVEyysSolLY8bVm+Ja+pOpMee78XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711874742; c=relaxed/simple;
	bh=rkTpT83OyeYcLFTcFWPlfq1EO9ueUCyja/WSxZqw7hc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dIQWuPzpKXYkmKCyiwje2IXWQNmCZ4QhsM3gYIsRDCrjKAxUCLsqI/nxDh/2aQbiqmCqg4QkQIDPbkibl9zTRhf7yOmqtMzNTPsQTRMLF0Afc/hgTcZKb7CtPtiSkL/apIFVpA18VSizrJ5tlKg90xVVcN8+aLmyp0Hq+G7SlBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RIt+s0B0; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-341730bfc46so2349002f8f.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 31 Mar 2024 01:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711874737; x=1712479537; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JpODOh8SpqDydjsGmjw6Via7WFpVB11YsZ1xvZ5Vpsw=;
        b=RIt+s0B0bQdPzNC57VDcHGSbp6AnPzRdjONrkxoHUdM4TDWGS9ydcwycBPNzld2g3Q
         +5BcKKxzZrVAWdv7Ja/IuZk9WyiZ36NfJc09kihlm05kuDTkr2qDk+5QKb6CDZR90ibE
         fZ3/ztQ+A8jApJ5f5mDZXbLhcpnziBkvcg4KkVdSPu94HO114WCq5bSB3Ka/kiceEOX0
         JUImR8Zkz3AYn2no3MoBFPGA8NKd0Jn+eqW4DAZhwdoH7z/j/dLpn505Tm+svv+70H/1
         slng6LT28P6zY0sbcelOtOd4toSSBf+bvQu7Md12Egdu5Tusz71mwIl+uaOvm+txJXqP
         gYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711874737; x=1712479537;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JpODOh8SpqDydjsGmjw6Via7WFpVB11YsZ1xvZ5Vpsw=;
        b=BAJB1dtyQO3EypCzLCcLhhTTI6IDdLowUCTn5+2K3B4WfbjPLqzQspVOY4/r/CN5Lz
         OQilHL1t2QV8/X4pwvSoygjpf7ZoeFY8F3t6c3IJWmE3ofDMMacnD4grYNKeysxLJcOU
         fB2D8mWzmpo6JSIFKJzjVUPDmnXh/XVemefvWBuTzcUXXLuS0+xOsMadKBOlOo31TLHV
         52/X3JVHUuRF24i6aiCQw6GbLd57GuuGXmcnIWXDhE++rmJbE3haAOQ18h7GYdWNcNuQ
         ZNesYdyBhfDRLclFQ5ljlthDKpfucbniL4pu0OpnNZiCL9noDx2n1MgRSiC4WvLH+jMT
         8TAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxMFOBNu4xBLAGPDSie6ZtKmewl1VPEFthdwCVhvQB1cxRYHpXfRvkDyj37xQ+IvNzXJ/E4qtHx/qprXM2bkrWi2SumZftkyvSzNQRsQ==
X-Gm-Message-State: AOJu0YxQLVJnyAa+NjMqaubXjlDoPtEcHvUa7u76ClOcEd+/mW2pOKzc
	c18JzFumVR0qGvFDDGq7InGm29uaeHdfFeJ/uP1Ej3vUq+Q5Za/FSRFA8LKKlvU=
X-Google-Smtp-Source: AGHT+IFhMJyghUycTdACT9icbSfKwd5VYS5+lHR7GEHa8HFyFfxUN9leod9pf+Cfrh2o34+h8a1zxA==
X-Received: by 2002:a05:6000:120a:b0:33d:4966:fa8f with SMTP id e10-20020a056000120a00b0033d4966fa8fmr3764747wrx.46.1711874737155;
        Sun, 31 Mar 2024 01:45:37 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id k17-20020adff5d1000000b00341b7388dafsm8436003wrp.77.2024.03.31.01.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 01:45:36 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 31 Mar 2024 10:44:02 +0200
Subject: [PATCH v2 15/25] misc: nsm: drop owner assignment
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240331-module-owner-virtio-v2-15-98f04bfaf46a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=780;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=rkTpT83OyeYcLFTcFWPlfq1EO9ueUCyja/WSxZqw7hc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmCSJdqEGjps1UnoPgvmyvw1qk/es9sAOvFP6i7
 rDkSj/3F6mJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgkiXQAKCRDBN2bmhouD
 1zh1D/9K9JiZ97FbRH997WXYeCIcOLie8y2bqS/tD2tujwmKzpHYmuBcAuNOI+xUFCEA8dY9ZXw
 Xxv/alBFKHlBE+G5EjNOODjB6vPUte/sSc53V4DB1/khRKZXwLX2GCksWhBKxe2Bo8hWQ1uWPrx
 zZqhsapmUGDnwRrG4U2DvNOQFc2WP9MoXnHRI9Vn4WXcJ8NjXlmBLoh2SmH/y7Xnn83iAsY4Bd9
 FJtqV6C94yGjdfn3mNcEd1nkXz6GM4cB59sJjLC5LMrCICh6donIiz5rbH2jmwPPMzFCx89FCBo
 QFtEU7uXE190p/t1P+2MImFzqbzp9AXhclMuU+9H6MHRDTBZ6F5AKb2xCpjNUJ9FYvCT+Oc0/l1
 yR7kmKwZOYE/Z6N8tohI7QT0GuBxqh9+yh+qsD9MpuHsNSwE2xLFJ29VpEUUcUMXBNYKADSdJbL
 CF9FasVoxOWKghUj0Si8FZ55UJ92wVI8P4ZTNOUWZ7Rzgyz2txMbsfAslxSkDxEyv+cKDMAYb/X
 lkeTdl48V+76z4vY3NM3ADVZGkCRhNpnE1/Dylblp2mvOMZGCGh5Qbn6aKYIPbaP8ovLWpLt2ey
 zWfa1CVWWaXBOT46qGPDtdbm9Wc+IsLSUv46B0GgwCXox+drd7wsQkIOppqY7gTC0Chte/FjF7J
 4fZvDPp1PJKyCmw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

virtio core already sets the .owner, so driver does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Depends on the first patch.
---
 drivers/misc/nsm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/misc/nsm.c b/drivers/misc/nsm.c
index 0eaa3b4484bd..ef7b32742340 100644
--- a/drivers/misc/nsm.c
+++ b/drivers/misc/nsm.c
@@ -494,7 +494,6 @@ static struct virtio_driver virtio_nsm_driver = {
 	.feature_table_legacy      = 0,
 	.feature_table_size_legacy = 0,
 	.driver.name               = KBUILD_MODNAME,
-	.driver.owner              = THIS_MODULE,
 	.id_table                  = id_table,
 	.probe                     = nsm_device_probe,
 	.remove                    = nsm_device_remove,

-- 
2.34.1


