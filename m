Return-Path: <linux-fsdevel+bounces-15800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 749808930EA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Mar 2024 11:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF651B20F24
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Mar 2024 09:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3634D148842;
	Sun, 31 Mar 2024 08:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qPCbhn5L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C69814883E
	for <linux-fsdevel@vger.kernel.org>; Sun, 31 Mar 2024 08:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711874782; cv=none; b=p/lfek+DpYLVfmOhua3HpW4GyisE4uiZFj2mhWFWcwmoI0WflVZWwBqGhYf4YGtAgWxYYK1K0sskp/x7TGGdR1NIA9Fl4/bA7Y7o/YguNGk7c/JYkiupNyLtrMXC1QCG5YdxJfrYZVyfSehOkYI6+nZlzVjx2YXTFXP/LtSp2RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711874782; c=relaxed/simple;
	bh=hlijIWO+f0zfriC947LO/aEcL8ON1TzqcVm2ZicUaAk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H/2eyKuvF60RuOeGx3OAvY167DskGLhBJtzp+PYLFx0T67Gp23bHbnAqk5RSOO5Zo3Uovu3VJYptSu3Kf6Lb1cLsQO2UDfNkzzE+DckbKqPBE5Z2+gmeFovuQfh14Pog71dGf0a3ylfvp/lQheDBoYSQZEC+z0vYYkwDvVfwfN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org; spf=fail smtp.mailfrom=linaro.org; dkim=fail (0-bit key) header.d=linaro.org header.i=@linaro.org header.b=qPCbhn5L reason="key not found in DNS"; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33edbc5932bso2394840f8f.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 31 Mar 2024 01:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711874778; x=1712479578; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4hXk7oLjUc91eh5OVw4e4b7aL1nWlLHgh1H134S1O7c=;
        b=qPCbhn5LzAIniZ7EtgvtNDtUzLqQjWAjYgYCXrnMwR3eDPaEzcy2W9lvgZUHhMqlI8
         MmcProjC6snvrdfZp9pAEDELWPLUgtgdHeCaB7AvMQxXGEY68rSsQRSzqM5UznllRbAD
         f6qVEkLTL0uEXwFXOeC+BJm8UQ40GMCV5WrmfTnGAF0xlfoAdbCX8ZaFHC+OldnXs//t
         g/4V+SWizMWxtalJa6PulYgowyyc1qylmebtq8GvQjb0yT7ITJxKH+ymEHUrj8Okzrsf
         A7Tz2A+6uevmOZNBltaSVaC9+0Z7E84YCZdXLXh5Bc3OyT1sjuS8LLxuV+MBfvJQiFxV
         sU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711874778; x=1712479578;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4hXk7oLjUc91eh5OVw4e4b7aL1nWlLHgh1H134S1O7c=;
        b=NrtZpxkyO9uVEFKZT+SEBYHbH9H2hI7fIvbUryVozTVwwMXyt4ifaDh1VQFtZv4I0L
         rRkuvBGu2RLlbClTV47t4/XvKcGh6l3PKGfHWVnAQ3D7xgLUdh//7pto4xwtU5XiV4Yi
         qpjOA8AcqLqgdaha10XH/39e0AEk+hL9F4VxXVzzRxcnql6HbPbdK8URXYaBeYezFYN8
         daoeuhzuycYng0O4JGjI0NS5X076EbbFbTpu6oZb2nl69on6nE8uHhXbnvkpH5hoWawy
         a3RKb6UI79aZ+FdzQ10nUhYquV3ZFNXADVcZO0s4kwNE/MMS8boEhcrKkG0l4/uMjrMH
         G8oA==
X-Forwarded-Encrypted: i=1; AJvYcCV8n2yJsF1CqpZFipvtsPJV5piNsOaLYFxGJHBIFKe7XbuC1tRaOO/cEJb6MY3hh9wI7bLUjZwwrzWaHU5KZhQeiqyFkM6j8O9jy+k/Dg==
X-Gm-Message-State: AOJu0Yzlnh8ND7uknOtoc2UG33otjr5Ir+gim05KoBOuTbiIWXfusH/P
	a6fvOC40aMWWWV7PFsfB3ogeN+5/Z+eNwTM9Xkkc6aMHigFGKWVGhBgw3D1XI3o=
X-Google-Smtp-Source: AGHT+IE9V06PTg08uEopkbJ04c8a6uBtTIR9CWlJErFVOFfKXjGGPjxREmzT7kuqo4+GTJVlpjvjsw==
X-Received: by 2002:adf:f047:0:b0:341:6aa6:6985 with SMTP id t7-20020adff047000000b003416aa66985mr3528623wro.65.1711874778033;
        Sun, 31 Mar 2024 01:46:18 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id k17-20020adff5d1000000b00341b7388dafsm8436003wrp.77.2024.03.31.01.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 01:46:17 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 31 Mar 2024 10:44:11 +0200
Subject: [PATCH v2 24/25] fuse: virtio: drop owner assignment
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240331-module-owner-virtio-v2-24-98f04bfaf46a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=715;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=hlijIWO+f0zfriC947LO/aEcL8ON1TzqcVm2ZicUaAk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmCSJlYYK2x+iETQecMy7Rd9QRwtIrxd4eiqNrm
 72pDjbyZaqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgkiZQAKCRDBN2bmhouD
 11rjD/0cadPlIIMhVNJE0VpSZbFTo9cnkSbv8WntJY4r/RXUxciZpq1kgQpJQ9i4QemC4iyt+5+
 UMW1gvijdTi9yJ391NDmdgM+mW5HAt5PojCQF7ajI8NcBQErmPtAxiAKHKSitVjAQ5T+R949fCO
 WW3LvVd/dbOdg1ELAHEvszxPUP6AtzmhLXLqUfEECRlCGEZzjzVFRNRDzoEswt178gIcpJcQrlw
 42dtBFHGC/PZQOkZaFKEoCRwPlq8ibhSdLJXDNYo7DhM1R2df+SY+i6XN48GtoNOCntAdvfpCwJ
 w9Mt+lgJROd7/JfyKPN7Wltw9dZARpYmfLM0XI2qi7LmU/oiTVDxeuLHG4CI7DEaNQUyDfuonqU
 ZW2qYg0Msf8VoHhrpeXxZBJjZ1d+9yHG7oyCFk5GklettqztszcrgSfqyQQKst0Djkmd0bSZ/nl
 Hh/hAfe2N3uSUHqXNIgUjyyrwUKYZROG0rFw+okSrOiPWyIksgGaXryOYbMhS3cNjDCl0etGLak
 gx8Uk/t3EN108nl/DHdHECbMFInLSVSA55M78H1Uf+qgRMorxUy5zpjE8xZb78cwrArF5t5rBXj
 NtkILkEJ7o1bBSg80wag6Qg6g8NuQ1d6UrqUdnXVNfaO1AnxyLRjmuro+C5xJ/feOaQhCdVGXAC
 ltJoH3HUczNLi3g==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

virtio core already sets the .owner, so driver does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Depends on the first patch.
---
 fs/fuse/virtio_fs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 322af827a232..ca7b64f9c3c7 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1023,7 +1023,6 @@ static const unsigned int feature_table[] = {};
 
 static struct virtio_driver virtio_fs_driver = {
 	.driver.name		= KBUILD_MODNAME,
-	.driver.owner		= THIS_MODULE,
 	.id_table		= id_table,
 	.feature_table		= feature_table,
 	.feature_table_size	= ARRAY_SIZE(feature_table),

-- 
2.34.1


