Return-Path: <linux-fsdevel+bounces-15395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C2388E4D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 15:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CC8F1F2F5A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 14:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5071465AB;
	Wed, 27 Mar 2024 12:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lo/sogJB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655FD145B2F
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Mar 2024 12:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711543321; cv=none; b=kFjM2e2aUFBI8Me6sPy3Kkd8p/MwqtuSsv17lr5o8L5ZwUY7ohoJv6p7KboOLu4rtX+rVLcdDvwF6+sZz+8gjgqxSP1lFWgnVqzPaxEYfr+Ahr+SJjU33XmLMu6+oEimQQkwqI/FzoPlee7IhWRGNpPTgmk3PyPvM0gpbSm6Zfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711543321; c=relaxed/simple;
	bh=fwrJWKj8nU797mE0IC4lY3eH4qtf6HIC5ncnQg0kcy4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=umXdTbllXkeMHDw5G3tVHCOlffVEw+eD+//qJKXkI3PSsKKkttdTOD1CthHL/kHo8WgNVenJjH1qpzKOfVFG9kIn/sgC4zseB9ZOMzxrNnD3M/Kgf3FYw+L/indLGVeGVJmt7cIxnJ62I/eO/EyIVgCzDGa7uL7BAW8U/KbYrmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lo/sogJB; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a46a7208eedso909992466b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Mar 2024 05:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711543316; x=1712148116; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o4tr5NG48SIYjCNbZydnC9ylnwvR5SnVT2LtcwsiMwA=;
        b=lo/sogJBDeHaOt5AVEmGxd6xrAIKwo/V10kczmEVBtugerjA9k/i60dccN+YNJ2dKU
         ORV6KN1WqTw9flrYyC9MVWGryhB6M+jcI78Sa1eyhNNg7Mps/6mEAMPbWmlZjQjD3p3w
         RUQzWjTg+52tLfGK7GDbhstwhWsSlHxRD3w55M6LLJfaxJHVPy7hoiWwrBbayQCf4La6
         VHHOlPfY2C9LbvHTAlC+LnjaMb5iKXeCOvi6XqFfFWMqd/9Az6F/KFL631WMDUXJ+clK
         lRxA3KMt0N6jjSbO/Rap/VxBTCDylPMvQ4xoImj8P7HU9syrjloqxCdjfcXfVH5D9ywN
         poGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711543316; x=1712148116;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o4tr5NG48SIYjCNbZydnC9ylnwvR5SnVT2LtcwsiMwA=;
        b=Z55DW5zaQyn/4yx120A/GkdoGLuDmxQf6YdWzVp8blyKO+YwjJMPhZ8wJGVNKZLdk/
         bB0TeAewMAbWiXh7m6dhXwdy67m4V6G70k6FA2Qj0FvKLwyjgvOFyXDz8vzxEdZBi8bs
         XytoFo+pMIMwNk3poXfalCZWPh56mfFZ43oK/RGcgSRf5mo4Nl2LbZ7CJuAZa9QbxvmX
         Kzp+nq5EkNv7cniUC94RSXzCKQ1FtUQhTw8V2pN0xrXZlVY5BogMBCITm96F1cVBVzMC
         4Dq6UXS2Xde0IqJhuUhlfc0xgQGGjMDmqSxqIQ2Tg6J1/vpwNfli9vBV3NgvdztJQem7
         gMvw==
X-Forwarded-Encrypted: i=1; AJvYcCXNikKylttrWMVrX6KlUPrbl+8r2T+hriGU4Vi2ura5Ps1BdR11pvNbkys8Age9zxO4ZmglWDwcmElb4R35oFTK07UuL7y4LqulF04leQ==
X-Gm-Message-State: AOJu0Yx+Y5U0ce5AqGMcIOFfCFZyWeKgkVAcyUE5cxeLIFUNikovyhXS
	atKx6ECcDEjdUWh2GccoSz22rYyVVBKyhty5lSUqi26CJAs5h2D46RG1BrBZtmM=
X-Google-Smtp-Source: AGHT+IHGDex70EGchFACtzsm2nrHrUxeSKSSg9117jWaPs7ddpDO3oid2XR2oF47HXk5SLd38PbHNg==
X-Received: by 2002:a17:907:970a:b0:a4d:f77a:b8d6 with SMTP id jg10-20020a170907970a00b00a4df77ab8d6mr3727212ejc.22.1711543315681;
        Wed, 27 Mar 2024 05:41:55 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.205])
        by smtp.gmail.com with ESMTPSA id gx16-20020a170906f1d000b00a4707ec7c34sm5379175ejb.166.2024.03.27.05.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 05:41:55 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 13:40:54 +0100
Subject: [PATCH 01/22] virtio: store owner from modules with
 register_virtio_driver()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-module-owner-virtio-v1-1-0feffab77d99@linaro.org>
References: <20240327-module-owner-virtio-v1-0-0feffab77d99@linaro.org>
In-Reply-To: <20240327-module-owner-virtio-v1-0-0feffab77d99@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Richard Weinberger <richard@nod.at>, 
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
 Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, David Airlie <airlied@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, 
 Jean-Philippe Brucker <jean-philippe@linaro.org>, 
 Joerg Roedel <joro@8bytes.org>, Alexander Graf <graf@amazon.com>, 
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3444;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=fwrJWKj8nU797mE0IC4lY3eH4qtf6HIC5ncnQg0kcy4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBBPaF1JDzqTfV6cOXqJmyzXYsgEqPQATvYRQk
 WnQRf8t/LyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgQT2gAKCRDBN2bmhouD
 1+oYD/42/c31q0OYiLqEi/06F54yokibXBcPIkZLpMFNOTFEC7z+HyQLH1rUQjhhXMgwJ7AzI8y
 7NznQsKuUd6y2WCWJnFhBDts6kEHJvQU6E+xqGzP2vmAVnMROlQy/LkXQIRLZafz1m+V1KtGAHU
 DUddrXGe58/IULO6HGJXn5W88W87cHRhL+VzuPgLPSZ1r+2UgOJJPsXQHGSCBwzazewyJCPdVBL
 aVAs5/3SwH4JaBj0a2yWWmqghkUrpKThxS1Z9qlZ31JkNUvyUPD1Uw24FMkTdQgdD9gkACGcwn4
 EFpICaVxRC2a10UH4qf9NSqNkAU3FdzajlC/nA75p3AAU7+TsrHZzPNv/qF1IHIoP/W6eB/UKI7
 3U4PWq1LIDq7UYmL9tMxbveghvTTu67p90AA2uJrI2tE9ZZq6zFMijWlDvHb+SS5hXLXuAj/oOg
 claga2VkfoNDU2HP3F4to11EblvFhdSfJJDnLzKLBnrbjnVM7dkqY3GavOlIslOcd2ZW8gHDi+Z
 bsYIHCHPTvSdrW+Rf96zy3s822rN2dtNm9bxU769KmiWXmCytk48eZlxVoITtSNZAoGPTmM7i3N
 Qk0Y5SRvJ/PnycrTHfKDykbvzTENDEK7+rErnq6incSGSqzmmVreGoc0RhcyC/e4specV3/cM1K
 s9oa3DKTSHa4YBA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Modules registering driver with register_virtio_driver() might forget to
set .owner field.  i2c-virtio.c for example has it missing.  The field
is used by some of other kernel parts for reference counting
(try_module_get()), so it is expected that drivers will set it.

Solve the problem by moving this task away from the drivers to the core
amba bus code, just like we did for platform_driver in
commit 9447057eaff8 ("platform_device: use a macro instead of
platform_driver_register").

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/driver-api/virtio/writing_virtio_drivers.rst | 1 -
 drivers/virtio/virtio.c                                    | 6 ++++--
 include/linux/virtio.h                                     | 7 +++++--
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/driver-api/virtio/writing_virtio_drivers.rst b/Documentation/driver-api/virtio/writing_virtio_drivers.rst
index e14c58796d25..e5de6f5d061a 100644
--- a/Documentation/driver-api/virtio/writing_virtio_drivers.rst
+++ b/Documentation/driver-api/virtio/writing_virtio_drivers.rst
@@ -97,7 +97,6 @@ like this::
 
 	static struct virtio_driver virtio_dummy_driver = {
 		.driver.name =  KBUILD_MODNAME,
-		.driver.owner = THIS_MODULE,
 		.id_table =     id_table,
 		.probe =        virtio_dummy_probe,
 		.remove =       virtio_dummy_remove,
diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index f173587893cb..9510c551dce8 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -362,14 +362,16 @@ static const struct bus_type virtio_bus = {
 	.remove = virtio_dev_remove,
 };
 
-int register_virtio_driver(struct virtio_driver *driver)
+int __register_virtio_driver(struct virtio_driver *driver, struct module *owner)
 {
 	/* Catch this early. */
 	BUG_ON(driver->feature_table_size && !driver->feature_table);
 	driver->driver.bus = &virtio_bus;
+	driver->driver.owner = owner;
+
 	return driver_register(&driver->driver);
 }
-EXPORT_SYMBOL_GPL(register_virtio_driver);
+EXPORT_SYMBOL_GPL(__register_virtio_driver);
 
 void unregister_virtio_driver(struct virtio_driver *driver)
 {
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index b0201747a263..26c4325aa373 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -170,7 +170,7 @@ size_t virtio_max_dma_size(const struct virtio_device *vdev);
 
 /**
  * struct virtio_driver - operations for a virtio I/O driver
- * @driver: underlying device driver (populate name and owner).
+ * @driver: underlying device driver (populate name).
  * @id_table: the ids serviced by this driver.
  * @feature_table: an array of feature numbers supported by this driver.
  * @feature_table_size: number of entries in the feature table array.
@@ -208,7 +208,10 @@ static inline struct virtio_driver *drv_to_virtio(struct device_driver *drv)
 	return container_of(drv, struct virtio_driver, driver);
 }
 
-int register_virtio_driver(struct virtio_driver *drv);
+/* use a macro to avoid include chaining to get THIS_MODULE */
+#define register_virtio_driver(drv) \
+	__register_virtio_driver(drv, THIS_MODULE)
+int __register_virtio_driver(struct virtio_driver *drv, struct module *owner);
 void unregister_virtio_driver(struct virtio_driver *drv);
 
 /* module_virtio_driver() - Helper macro for drivers that don't do

-- 
2.34.1


