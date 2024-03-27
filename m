Return-Path: <linux-fsdevel+bounces-15399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A681E88E50D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 15:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C94A71C226B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 14:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84D413664E;
	Wed, 27 Mar 2024 12:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gO+9aubU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9FD14885B
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Mar 2024 12:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711543411; cv=none; b=PhBwawRAZKnAXs1eXwWAXBxVPOLvSHwMAK+6hMkMBQsHhP/LuihAFOUtvv4dbr6lsuMcGPrkP93NKw42Anu1esHE6Cop4ZPh1PhqYBgjsDVknuOM3i49DXPDz2rExScTRmvFQUaCy1VnjoRIaTpu852u/eUpOZIwZNEhxYhnRJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711543411; c=relaxed/simple;
	bh=rFl/6jLaFbtBJ+88FvM913PJ4x0vjfjJ4PxyPcL+Huc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rv4E/9ATINcxKrUG2zRR7g4NINtNjGVG9PUsb/YLfG/WuaSE8XV4fe1lxqAsH75WXfkt2vTqyPZgK7oodbSmqq/T5XcnKzXQLHllpwAgRpPUI9ZHWk3UzWaprA5zJeTcTsBtV64fJLZXhrkTeoWFWjOFJVajASG0KeL3dp1NoPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gO+9aubU; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a46ba938de0so890488866b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Mar 2024 05:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711543408; x=1712148208; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IvtYxn/jBnHDfTZoo9tjjvjwD5frxuJyBUKvJwnL+3s=;
        b=gO+9aubU1AwfXwFW176VMzyXAQFsORqXQ3tGI/HudUfNx66z3ywOPWtGjkFq5ahKs2
         CuuS4cfecW1N9xshP4QGEFadTyj/kYrtqcA4TvmZyOsQ4ePT2oceSvnT3nEkGiYwo50V
         K6qe2yis4T6sFliei/1nrHtHaLjxSA3oDhHjiRVBW2khdQbJ114KG3xsWP6hju3l6ooS
         TxMagR3pW5ebvWJgVd0BCfFpZuYkHhHojx+sKoIYFsFlQ3rm/ivJRD3HERwfS1tRjZv6
         kmoQdpxwu+y254J7blPJmI4847FxVJIFalO44Ll5sL4V2sZS+EOw1DmeFk+YA4Y/XG8j
         jsAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711543408; x=1712148208;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IvtYxn/jBnHDfTZoo9tjjvjwD5frxuJyBUKvJwnL+3s=;
        b=C4hswhk1uGJaVcHW1wij5bjX2zuTahMchNGaaa5b/ZEYqy8MB5kLIyEjnnEj1WhzQ2
         0V7eLzjo0oQT+CGqJ3ZviefbjKV4xaCNn347V4zDX2ZxzKpEuACvGKGE3nqfBdhy9OtJ
         c3BZdXcMegJBeJwtM9OiRTRmQAE2wzCaORS9Hhk9M0XMFSJOvv/8Dq4W3SbfWafzqyzy
         54s1uxG0RIslW9/+aVpwPIe5iB90UZYmZjoVUiUX00pDrOFN/yCWxZAklM5ggRXnooCN
         dj8TJnqUoUbmRhWJbVbXfmWVQE84qf/pZAMQ0TdUf8duO2HUK3E7lL8OpbSsMNN2Qsn1
         yaww==
X-Forwarded-Encrypted: i=1; AJvYcCWAn4uS9Wf0l1L64I6Slkdl0gnHfTehkA4ouM4fzq1x2/Q4LDwDGnwlGPIzEYLGUxLMXlBFrunfQiK++5GBBA00aAuJ34HIwkLxxlXiHg==
X-Gm-Message-State: AOJu0YwJnqSPdqyvi6v0jpRZc7XTdH/j9zUDIcoyH3mWQkPyYMbSvN9d
	UYjOGDyXfIw4Zoxbri7aiIs3cwJTdXNNb916IUKSarz1EDGeV1aiya9zh7nfGSk=
X-Google-Smtp-Source: AGHT+IFQzE941/frKvlveayAo5OwX27t9ISC9Ui//MJIb/s8SSfev7LRMOseQU2wGRtbmTboQ2qixg==
X-Received: by 2002:a17:906:af97:b0:a47:2d4f:6fad with SMTP id mj23-20020a170906af9700b00a472d4f6fadmr3640240ejb.39.1711543407742;
        Wed, 27 Mar 2024 05:43:27 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.205])
        by smtp.gmail.com with ESMTPSA id gx16-20020a170906f1d000b00a4707ec7c34sm5379175ejb.166.2024.03.27.05.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 05:43:27 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 13:40:58 +0100
Subject: [PATCH 05/22] hwrng: virtio: drop owner assignment
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-module-owner-virtio-v1-5-0feffab77d99@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=763;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=rFl/6jLaFbtBJ+88FvM913PJ4x0vjfjJ4PxyPcL+Huc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBBPeh3H1wemzDqhAibGWW67UcAFh1HQXSznqt
 bEbHHO+hSuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgQT3gAKCRDBN2bmhouD
 1ypVD/9oHD41Qj1Sqk48VDcTdVES1YvXuuDoKvE3VyWtnVGYiNb60QFQKU80jN6oLcjshjDFPK4
 E9ATN58meESWX5UMMQUPAUThgndBeYYVkY6/3jhOvGFwreHYYn4O2qTukURJ1fI7ASP2fyP/3nW
 zr2qKyF4JGyI2ZhgGugQ9cVcNM8jB7rnMrOLR759/ggj4hB10TDUDnS/PYNpCk5h+ilyPgVaiZO
 lIM7Rl/97VdAbNVvm67vKkma6hKMUwEPWrsQLNcssIjRs4uK15fsCuM6ZDHjQn3u6K/mSnvitSE
 EyW7+cwNG6sSW5FoX1RnBwUYIC3+ayD8aiBjm3Qi9QmwHNo7xf/VXT7UowyM7ax8vMNyNSXkWi+
 hZhp1/+lVuMFTQzw8S4FzsvcPx5VCKOtoQizvNZKcMN0MhhXh8GSusi2u8XPahVqki02HVqEd8i
 p73OVWfBh6OSn+I/RaMqDWLtZAUQbLU69/ujHReW2gJzgZLukbsW9E4kEq3bWO/LuLvm6yFdril
 sg92y2CGcR4zgijh+/THpA9SRF8QURenYZM4NUWlLj3Ef+o54LpKRfdBDST0ZPeeiaaVneb8UWE
 LRajuEBICJqBAAAyaa4VGBaB7T+nodd9jR3MEMAWXS0ZnBrP1efJCygFMbepcVlv5jiKT282G0W
 t4D4aOVlYAW4RKQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

virtio core already sets the .owner, so driver does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Depends on the first patch.
---
 drivers/char/hw_random/virtio-rng.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index 7a4b45393acb..dd998f4fe4f2 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -245,7 +245,6 @@ static const struct virtio_device_id id_table[] = {
 
 static struct virtio_driver virtio_rng_driver = {
 	.driver.name =	KBUILD_MODNAME,
-	.driver.owner =	THIS_MODULE,
 	.id_table =	id_table,
 	.probe =	virtrng_probe,
 	.remove =	virtrng_remove,

-- 
2.34.1


