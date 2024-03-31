Return-Path: <linux-fsdevel+bounces-15778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EDE892F9F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Mar 2024 10:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2A7D282210
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Mar 2024 08:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DB785289;
	Sun, 31 Mar 2024 08:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mTQ1oKjl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB8683CD6
	for <linux-fsdevel@vger.kernel.org>; Sun, 31 Mar 2024 08:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711874687; cv=none; b=D5OGM5JlsG0mpN8x/DApK7mUCmqL6VB+H0YMv4WSua9FEulnFGqvfMkDD37z25nD6nhxRRqatJpcl+5o7ZyqVeF825xQ+1H4RtVnUFEm6WZ55QTZWe+6iKfEdpduAYKmWkTcVjxtWHuZobk1Mwh+Jt8PZVFZjlIMEhHm6BlImdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711874687; c=relaxed/simple;
	bh=RysO/qt1rQfxuR/fMKbrAV6erIUzwhDFXhmI2uQKPqA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pv+oCi7VyOytlV6yRVHTiNH/KQ+Ll30woyjZaRjaO8bFpVub/fwrPDSu2hTVPcyXDd9rPPqWRq0/IGDp1Isj7EbKBojFWvxunHsn3AzHthmQC/MXtgh+WdmjkOlqkgk5oc8t3SK3C8BUMtQjm7JD+UxlZrK7Y+Br+BGmxt3aGdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mTQ1oKjl; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-341cf77b86bso2243737f8f.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 31 Mar 2024 01:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711874682; x=1712479482; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gWUySN3U6KV6HG1AUlxWfC+1UKjwHATPcWhBhn7s2o4=;
        b=mTQ1oKjl/gjYTBnisPO9w1chH5zp+LRvqWHwIuzxKsT8HCKITQSOSqu0GHHyab81cf
         39Uts1Rj6cqusObQLN7dZgBcOQZaYSPP38SkcVys99O/7dTATt017XosKj2T207xhzVI
         BZlz03/ub84U1MG5wFw1/Wt43+pPk2eU57R4DPKohIoj8cY95rCdSqRUlDV/r/YnKMMt
         y2dfdWfd4UrafKw9nc4i8KBEnbe31wlpLA8b92wJ9Se6F32u7lR6L457npLeztxbJTtg
         RN78+uJB0KSah3JrSop1GB3WAPcxUqjdSkizay/Z8GRNkgqyAAbKf1e26YiHXv9cCMDH
         jvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711874682; x=1712479482;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gWUySN3U6KV6HG1AUlxWfC+1UKjwHATPcWhBhn7s2o4=;
        b=XZjM8q41GcdEzVDDaaY4BYrOeGIzyRFkaliI1AMuu5ZCwnVTeoRSj3u7uvgDm6Rdtz
         kUu9Aq7rh/7+ADBTgjaKSINY0RbNriBIVguJZQ1YgWvmXXEqowFr2eRW30ptkVKwiIlC
         itbUsUe6SeJBIyfskPVQtxZvcgujyu/bU6Rk8rXb3ZRmphu0gqwZxUfn6yXd/VUooKP7
         G2+ty+ye7Rhr2x/yIdG9LuVx6WFcXEkr+wbI0lxXOyQ0NhJGvINW68Ltl+iyu03r354P
         c10R+mX9zbrZVSjw+gGtSCSwtNpIwXBl3YiUiIOEY9Nkb2DH32gR2vJPAadDLiHg9fFv
         +WPw==
X-Forwarded-Encrypted: i=1; AJvYcCXQRHohzp7ioVgeB53qpLFg0I1Rg7I6xVFvaKOEXZivSmXklQPluS+h4XthtFMBeK1y/7uqB38xl2FOq3BxG74vbeyC4lLIJuQ182XEpw==
X-Gm-Message-State: AOJu0Ywyqlx6ySFAY+7zgtQOPrDZApK+TfkrxSEsxwfuCIT/jLju24zN
	rRKP4dFilRq0x8fbkEttSRuD7n7SlM/d1tOHwIEclk/uZiDW3eNmqSjeQTc2e5g=
X-Google-Smtp-Source: AGHT+IGwM/SvId/G3V2B6t5IDifqRc3KhYfuRSVslQ03TsbdQz5nCqaJFLrylKfcEITta5oPni6eyg==
X-Received: by 2002:a05:6000:250:b0:33e:67c7:e2c0 with SMTP id m16-20020a056000025000b0033e67c7e2c0mr3669536wrz.38.1711874681709;
        Sun, 31 Mar 2024 01:44:41 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id k17-20020adff5d1000000b00341b7388dafsm8436003wrp.77.2024.03.31.01.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 01:44:41 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 31 Mar 2024 10:43:50 +0200
Subject: [PATCH v2 03/25] virtio: input: drop owner assignment
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240331-module-owner-virtio-v2-3-98f04bfaf46a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=790;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=RysO/qt1rQfxuR/fMKbrAV6erIUzwhDFXhmI2uQKPqA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmCSJTp2CbcGT+/4n3zXVUs6qIH1zZer+gCjdQu
 N4C4UZAAO6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgkiUwAKCRDBN2bmhouD
 1/P4D/44zp6pv9dIygTq00R6mXdd1NexGAKS3IHJlvbsjKRPwrbQyzYzcdYHnn4RwhMDm3low5m
 MKBlxv/lMju6uYGv4in+/4b3x7XZ/nrItMSrW5sjiWQiuVEpspcvROXGsfOT3Kw+Y55qTRXJkBI
 4VA4QCk80o/3eLdwGzqabq8GlG62wAC1nB/p6y53M2E5NQmvJv6D5tj+WbNm0D8W3jZPHrItjl7
 Z+F18KsWvRxy1PByYCcOdmpl2XVUArlxXkK7cnemb+4j/usmebXBUj+tqSnniIblu2gg2ia3nfd
 pFtfLeM/PD3jIi4cdz6K8pE36CBJF+VOKpJOzeDIUmhMhvA9nvvd/FeFvszMj70QoVR++A3ROyp
 Z1/R+Z4NvFOsYEu7gg2ZB7gKl+0o3Aj0IfWHaMhzieRjxqLcTi6L3DIz3M5Hl3du5hur37H2cv3
 C3SQtpM0EK010En+GxHVM2xw8NtS/ndn9zqx99vEFZFXFwsN4eJEnxRfqOEopE1ulNEUsvP04dZ
 8ilHrMFbayTYG94ljAxuch9VX/ipvXFsssyVn/Rl7GcJuIngcDmWIE3VQ4HN3/BL9WOK86lBJcg
 6ljJRvqaB/5tBqTmTIrNCJShCI8GZSg9iDBB13scIeg0GHLXxMMq+ixkk25JnoqEtweFYy56jKK
 5s+EVPX1o1gUybA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

virtio core already sets the .owner, so driver does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. New patch
---
 drivers/virtio/virtio_input.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
index 3aa46703872d..1a730d6c0b55 100644
--- a/drivers/virtio/virtio_input.c
+++ b/drivers/virtio/virtio_input.c
@@ -394,7 +394,6 @@ static const struct virtio_device_id id_table[] = {
 
 static struct virtio_driver virtio_input_driver = {
 	.driver.name         = KBUILD_MODNAME,
-	.driver.owner        = THIS_MODULE,
 	.feature_table       = features,
 	.feature_table_size  = ARRAY_SIZE(features),
 	.id_table            = id_table,

-- 
2.34.1


