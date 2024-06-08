Return-Path: <linux-fsdevel+bounces-21282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5951890120C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jun 2024 16:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0625B2828C8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jun 2024 14:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7B517A93C;
	Sat,  8 Jun 2024 14:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="H/3bKZTJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from msa.smtpout.orange.fr (smtp-70.smtpout.orange.fr [80.12.242.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C67149DED;
	Sat,  8 Jun 2024 14:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717857305; cv=none; b=ZWZZBBDMYELYT1AKTCCwEirIz6bg8qTWxEqGuCX5vP1c+rXExc1Z9vt1n9VJkl3iN0WYIiQciqo/91YO11xCSduoLFT8bGUxRFvQrOU0xrGb8oyi9kXC4xbmQjDQhpjh4vq91+u6WH8AJiM6l4sLystY9cNbzeHLoASh2KP/tcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717857305; c=relaxed/simple;
	bh=Avzt8iuW+icupfQzd34mdUP1exisuMqsbmUkbTgWcBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E3vK9IB1F6SoCECVWOhI/b43ZpfmVfB7Wiuv59qOECtcjrvC2iXuy4322cdUorN1bl5PxbF99Xi07T4V/AtFG0YyHlRWM34ZSj+1+EsYjDXlDabLroYRkSstobh2aQf9aOtpOMdGdEczsPg1fWDRIJ/EjhQJlqiF4W/pBZk6TVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=H/3bKZTJ; arc=none smtp.client-ip=80.12.242.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.222.230])
	by smtp.orange.fr with ESMTPA
	id Fx9Rs04TztVxQFx9gsAXpq; Sat, 08 Jun 2024 16:34:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1717857293;
	bh=5Rt9DtR3wFrK6NMeCAc9r8PlkozK/OUjFMR/opTt2bA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=H/3bKZTJzfjZgxWQ8Rs0pWnmgAXTGeglbXFR4n4P469sILXGIkny3rjPA3/Bu8+Vv
	 sGSH8L+E+1yaCyhC8y9hV76w0dguIvAtpgioV7E2/RfdU2ssj6/v63KNKTFpwBjoo8
	 YJ5dbTWax5EV0LrH3UVGHaJhxcdYF8CAxS+wV0+e/yZPIzlQBXz+CWVexB/3q0xkZL
	 Ic/cn4zhFBj8t6e/tFR9NdMDKD7enSUxCPAiUp/cyIJom+iUJ1RyqPqB9bab2RvcNB
	 0Z9raMR654UkVwRhj+rrAEbIRsIwiiDCwy4sC47c6KP5z0ayRfyB9p0KjGjnjW7eOX
	 jXQfBpKEtiMvA==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 08 Jun 2024 16:34:53 +0200
X-ME-IP: 86.243.222.230
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: jk@ozlabs.org,
	joel@jms.id.au,
	alistair@popple.id.au,
	eajames@linux.ibm.com,
	parthiban.veerasooran@microchip.com,
	christian.gromm@microchip.com,
	willy@infradead.org,
	akpm@linux-foundation.org
Cc: linux-fsi@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH RESEND 2/3] most: Remove usage of the deprecated ida_simple_xx() API
Date: Sat,  8 Jun 2024 16:34:19 +0200
Message-ID: <ddbb2e3f249ba90417dc7ab01713faa1091fb44c.1717855701.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1717855701.git.christophe.jaillet@wanadoo.fr>
References: <cover.1717855701.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ida_alloc() and ida_free() should be preferred to the deprecated
ida_simple_get() and ida_simple_remove().

This is less verbose.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
---
This patch has been sent about 6 months ago [1].
A gentle reminder has been sent 2 months later and an A-by has been given
[2].

Another gentle reminder has been sent another 2 months later [3].

However, it has still not reached -next since then in the last 2 months.

So, I've added the A-b tag and I'm adding Andrew Morton in To:, in order to
help in the merge process.

Thanks
CJ

[1]: https://lore.kernel.org/all/988c218ef3d91bffaf4c3db9b6fba0d369cbb2b2.1702326601.git.christophe.jaillet@wanadoo.fr/
[2]: https://lore.kernel.org/all/cd56d073-04ad-40ad-968b-7e137d10f456@microchip.com/
[3]: https://lore.kernel.org/all/c5e519ea-2602-417c-84e9-199b610d427e@wanadoo.fr/
---
 drivers/most/core.c      | 10 +++++-----
 drivers/most/most_cdev.c |  6 +++---
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/most/core.c b/drivers/most/core.c
index f13d0e14a48b..10342e8801bf 100644
--- a/drivers/most/core.c
+++ b/drivers/most/core.c
@@ -1286,7 +1286,7 @@ int most_register_interface(struct most_interface *iface)
 	    !iface->poison_channel || (iface->num_channels > MAX_CHANNELS))
 		return -EINVAL;
 
-	id = ida_simple_get(&mdev_id, 0, 0, GFP_KERNEL);
+	id = ida_alloc(&mdev_id, GFP_KERNEL);
 	if (id < 0) {
 		dev_err(iface->dev, "Failed to allocate device ID\n");
 		return id;
@@ -1294,7 +1294,7 @@ int most_register_interface(struct most_interface *iface)
 
 	iface->p = kzalloc(sizeof(*iface->p), GFP_KERNEL);
 	if (!iface->p) {
-		ida_simple_remove(&mdev_id, id);
+		ida_free(&mdev_id, id);
 		return -ENOMEM;
 	}
 
@@ -1308,7 +1308,7 @@ int most_register_interface(struct most_interface *iface)
 		dev_err(iface->dev, "Failed to register interface device\n");
 		kfree(iface->p);
 		put_device(iface->dev);
-		ida_simple_remove(&mdev_id, id);
+		ida_free(&mdev_id, id);
 		return -ENOMEM;
 	}
 
@@ -1366,7 +1366,7 @@ int most_register_interface(struct most_interface *iface)
 	}
 	kfree(iface->p);
 	device_unregister(iface->dev);
-	ida_simple_remove(&mdev_id, id);
+	ida_free(&mdev_id, id);
 	return -ENOMEM;
 }
 EXPORT_SYMBOL_GPL(most_register_interface);
@@ -1397,7 +1397,7 @@ void most_deregister_interface(struct most_interface *iface)
 		device_unregister(&c->dev);
 	}
 
-	ida_simple_remove(&mdev_id, iface->p->dev_id);
+	ida_free(&mdev_id, iface->p->dev_id);
 	kfree(iface->p);
 	device_unregister(iface->dev);
 }
diff --git a/drivers/most/most_cdev.c b/drivers/most/most_cdev.c
index 3ed8f461e01e..b9423f82373d 100644
--- a/drivers/most/most_cdev.c
+++ b/drivers/most/most_cdev.c
@@ -100,7 +100,7 @@ static void destroy_cdev(struct comp_channel *c)
 
 static void destroy_channel(struct comp_channel *c)
 {
-	ida_simple_remove(&comp.minor_id, MINOR(c->devno));
+	ida_free(&comp.minor_id, MINOR(c->devno));
 	kfifo_free(&c->fifo);
 	kfree(c);
 }
@@ -425,7 +425,7 @@ static int comp_probe(struct most_interface *iface, int channel_id,
 	if (c)
 		return -EEXIST;
 
-	current_minor = ida_simple_get(&comp.minor_id, 0, 0, GFP_KERNEL);
+	current_minor = ida_alloc(&comp.minor_id, GFP_KERNEL);
 	if (current_minor < 0)
 		return current_minor;
 
@@ -472,7 +472,7 @@ static int comp_probe(struct most_interface *iface, int channel_id,
 err_free_c:
 	kfree(c);
 err_remove_ida:
-	ida_simple_remove(&comp.minor_id, current_minor);
+	ida_free(&comp.minor_id, current_minor);
 	return retval;
 }
 
-- 
2.45.2


