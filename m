Return-Path: <linux-fsdevel+bounces-15407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 242CA88E58D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 15:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEE2029B9C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 14:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97C214F121;
	Wed, 27 Mar 2024 12:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EJwLZ88g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E57214EC4B
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Mar 2024 12:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711543556; cv=none; b=sdHJfyHeLk3Db+Z/tjqdD89pb3kz5fb3qOdBczn7oyaDkzOO/ncJZ1WuhpRjYbqSlWEvlrAyD2KVxmTITCWjcijei5lQJTfX/cuBcdScRKwH970Om/ehuFDVJT4nwZAAE1IWh0DMQsBVqK6HafIjgDn5xnqhfAW9oWQ1QhprgHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711543556; c=relaxed/simple;
	bh=se3bAL9NWlxdnI0R5l3waFKazObx3hz9jbN0xln52SE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n7QakqyNf2MKm9lla9wyPCSgRwmtdGp58AFd3e78TYEpP4oEGeYAghgAbvWuTGTrxPsbKfccMA42S0uc4F7cqWvuMXIICuwEa2ZtZKR399FcgVtId2nuUewMJT9AgIVXxHBCj7p293rDmnkFy5kM44XYg2+7MpCvbkiL/St3bI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EJwLZ88g; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a474c4faf5eso438400766b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Mar 2024 05:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711543551; x=1712148351; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BCsDfZXw6LzB3XdNG+WbYeCWTW98m3a94TU3WahPKsY=;
        b=EJwLZ88gaXccDa7nnuQgOUcUbyxhdhCYrFPAmTMykWElnKc6RZo9P2CAkdOlNvnjeg
         lLSuqg+lIgz1pLpNoZImp778r3LjJJrU5c1Zl+n1XWqXMjuR93LfBas7ko9JBmDzBu2Y
         sMsCjrsBvkt0+yILmuu2H18j/vZQj1r+H9GN+qmJJVI9dnmsZZw6egjgWczU7IFdeZdf
         PeVAwtnokdCTspttwr7V4Ovox8pVQoomde820et6Eh0KJqwesT7e1eniGKQwsZXsoqZM
         aZd9DgKams7OHCmtKbKSm1e0Cwc1i9Mp1t5iw2UCqu2LargXlx1lIGnJ7fgdFJqRLdna
         lMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711543551; x=1712148351;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BCsDfZXw6LzB3XdNG+WbYeCWTW98m3a94TU3WahPKsY=;
        b=b1HjZI331B1pedfAJtQ58R2Q4jmFfUd5yokIPVKVQhsJzwy1hLGZ3b/x6WOaaj7F7s
         CPSahBDgXt3Pwfcvk3maYRPRvHWbQdOFTL4WPpyjcFFCLFV9T+PK7O2iF1+DyIzGMny3
         O7gw/QglHCAZ6fOywAjt5UwPe4JXufbvJBlbteh28fXZjlo5fRhNq1SlFC8JQqXCpb07
         BHJN/NPw6dTD+YfBdJGndynIupLqy9jWgQhPPOTdGL20ebOfuQ32bYHeb7qL0RN8rxX3
         2CyLXDMDMghery7dGtYZwjjfFUpmEE1WiPeLNV+4xy2dvOnsO6wOhvCq9O7+LZMJCa9N
         8gjw==
X-Forwarded-Encrypted: i=1; AJvYcCUJEiC787xbQR1H1NFTK+j4MEP3hruhpZ1ACMMPBkVKj1ELQ1L/Prj7aYYupzAMF5BnF7svtQw3PM7sKKqAduLRmy6DpYD23kP7wv+kAA==
X-Gm-Message-State: AOJu0YzLGDRPvv7PkSWYg2cxCAihc806pFOKPwvflaclsm0QG3qu8SfE
	dAmgYYbhlirxpK54JeBZzkTkXfqd1tgEDi+Payn+P+quQLkh6msLRBU1guZuLWw=
X-Google-Smtp-Source: AGHT+IHenEy2Nv09tc3hpD85ZlHlSHaO+RqOy+xZPq/kwcOthzgJhneH4ZMtAD4U4oj+26zW+LtQug==
X-Received: by 2002:a17:906:f289:b0:a47:11a9:9038 with SMTP id gu9-20020a170906f28900b00a4711a99038mr898123ejb.58.1711543550975;
        Wed, 27 Mar 2024 05:45:50 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.205])
        by smtp.gmail.com with ESMTPSA id gx16-20020a170906f1d000b00a4707ec7c34sm5379175ejb.166.2024.03.27.05.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 05:45:50 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 13:41:06 +0100
Subject: [PATCH 13/22] net: caif: virtio: drop owner assignment
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-module-owner-virtio-v1-13-0feffab77d99@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=759;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=se3bAL9NWlxdnI0R5l3waFKazObx3hz9jbN0xln52SE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBBPlFuOYVkS3jCI6zCCRPhdDIeMDfV433oH2/
 VlG3qjMpOSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgQT5QAKCRDBN2bmhouD
 14caD/9pMti1eDVhObtjCsgc7qTxe4R+2U8ygVWuBbWTo4uxbl68SspsNCbn3wDquoXUfUJpH0h
 DAIBtQ8IEKNHp+pM30oT2NKYOfbgpk00p6t4L9oUqzhX8ytHCVAFojpdX1VqdZN//zwPu905ECZ
 8gJVLxWpQfs62Y9P97p5hkwcw6ubEphjm1U1Eo9wBa0mKhDPudQoGcIzO5hnogEoMGlO/lpNamP
 gm1H8DQteD1xtI4J8rPq4nhK/XC/OSaQKx8oodldJ35QExmQ831aVHRqzw2NCeSXMT3iv5+TIGv
 tTz1KRSwLG7fngl+72ebxNZiS1dPiGoheeJlDBxe5MMnwKVgzrxl4jil3eygmp4teE11VbWZLIx
 DytJ03jm7lJVeFeCRnij5joDyaRag2+C1HYxrwExDC2/438IMK8Foz1bZ19dUOpyp+j7UJLI2my
 qF7dydwkF3emHbHhmlBXuONlp2aJJDQZpTyubQWEmmXQX+1u2mnl60qwS4hBxMjiQW9JNTO6RSY
 V0A9gBxyrswSNxjAEs62V1NfsiCn07pEd/W7doeL9qtgSW9SvFccds+BhprZK2kktoUUZfSfnZt
 +5GMrgvAeA+GvuIbO4pQ3SQdqJDNznRq22k8JY32GZNmDmAeWkXXkATTYibLhTr6pwr5sDpaZuh
 1V6X4s4H6cGDkTw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

virtio core already sets the .owner, so driver does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Depends on the first patch.
---
 drivers/net/caif/caif_virtio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/caif/caif_virtio.c b/drivers/net/caif/caif_virtio.c
index 0b0f234b0b50..99d984851fef 100644
--- a/drivers/net/caif/caif_virtio.c
+++ b/drivers/net/caif/caif_virtio.c
@@ -782,7 +782,6 @@ static struct virtio_driver caif_virtio_driver = {
 	.feature_table		= features,
 	.feature_table_size	= ARRAY_SIZE(features),
 	.driver.name		= KBUILD_MODNAME,
-	.driver.owner		= THIS_MODULE,
 	.id_table		= id_table,
 	.probe			= cfv_probe,
 	.remove			= cfv_remove,

-- 
2.34.1


