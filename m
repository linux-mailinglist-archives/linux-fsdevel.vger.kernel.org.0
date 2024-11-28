Return-Path: <linux-fsdevel+bounces-36094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8CB9DBA00
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 15:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EEB9B214C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 14:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08B41B415C;
	Thu, 28 Nov 2024 14:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PO1Oh7Xr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307391B2198;
	Thu, 28 Nov 2024 14:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732805892; cv=none; b=r6TppaTv/NY375j+UcnnW0TzgWaIcXD/oS5uK0d5TsRox9zTxUerjpSWplluUMIvgPIZnB3493AgZdOA7xBhLHOF3UU2ex26LdqUopv5CdxqSjiwiUNUA9mWxe37xJAsxvDcKtTU2/zhBfY813TCXJqsNHuoPRdbQDHXAQhD97g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732805892; c=relaxed/simple;
	bh=TfIbYdXyqkUjOGwkNSD1271kjM+5nLdnipT1I5MK1tc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Wn54kKWFfT5hYL/zSGwnOg2HGoeoVc4QpSSjdqXp57YsIc1NIAmDtM/KyjTHOa2Dzd/Ky2QeHB6Xglnb1LvzaDPjBVm3mfnR8uf25jqQqUFgY8FccOO2D03d9CpGIkZtoBmm8MIRbdYajSkaSjV22yoxmn7U4hbSrqXzxlT2W2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PO1Oh7Xr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D9FC4CECE;
	Thu, 28 Nov 2024 14:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732805891;
	bh=TfIbYdXyqkUjOGwkNSD1271kjM+5nLdnipT1I5MK1tc=;
	h=Date:From:To:Cc:Subject:From;
	b=PO1Oh7XrkWAQj5fpJYhUyDy2YTFBPHDlsEitDYyhVH6uOATCu0qOqg9YbvMsiwqdn
	 sTFZeS8mDB4kGlOZwOgNXGG6IpsqWC0I/pFW9Et9/EVP5hRsH3ajVdlRANGxwusaXL
	 MFr/P70T8ct2JOIloKKHDykLEmQgykXZ4iBTSkyuMHiL7GcVP0oyPMLAlcEjkCkHYX
	 +cnI6hwwEYGE8FFot+AXuAFHoEdlYx6YZskiFDtcRzEZzo8zjGS7L8MVZikziwKN/E
	 jcEsgTngjMI7NkJRGIN0s9ONoM/3xkDu/uowPWPvSyeDakMi7NEm8E29DHb6ZqhQxC
	 8epCXcDzqnFWQ==
Date: Thu, 28 Nov 2024 15:58:06 +0100
From: Christian Brauner <brauner@kernel.org>
To: Scott Branden <scott.branden@broadcom.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hdegoede@redhat.com>, 
	Larry Finger <Larry.Finger@lwfinger.net>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"Bcc:"@web.codeaurora.org
Subject: Unsafe find_vpid() calls
Message-ID: <ueprb5sfjisjucekft3ls7it3pacq44ryfyqtumb3be3itmzy4@mnp4e2lcbzus>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hey,

You have various calls to find_vpid() in your drivers that aren't
protected by either tasklist_lock or rcu_read_lock(). Afair, this is
unsafe as the struct pid might be freed beneath you. You should please
fix those places to be protected by rcu_read_lock(). Something like the
below or similar should work.

Thanks!
Christian

diff --git a/drivers/misc/bcm-vk/bcm_vk_dev.c b/drivers/misc/bcm-vk/bcm_vk_dev.c
index d4a96137728d..84cab909db71 100644
--- a/drivers/misc/bcm-vk/bcm_vk_dev.c
+++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
@@ -522,7 +522,9 @@ void bcm_vk_blk_drv_access(struct bcm_vk *vk)
                                dev_dbg(&vk->pdev->dev,
                                        "Send kill signal to pid %d\n",
                                        ctx->pid);
+                               rcu_read_lock();
                                kill_pid(find_vpid(ctx->pid), SIGKILL, 1);
+                               rcu_read_unlock();
                        }
                }
        }
diff --git a/drivers/misc/bcm-vk/bcm_vk_tty.c b/drivers/misc/bcm-vk/bcm_vk_tty.c
index 59bab76ff0a9..6bd93347938e 100644
--- a/drivers/misc/bcm-vk/bcm_vk_tty.c
+++ b/drivers/misc/bcm-vk/bcm_vk_tty.c
@@ -326,8 +326,11 @@ void bcm_vk_tty_terminate_tty_user(struct bcm_vk *vk)

        for (i = 0; i < BCM_VK_NUM_TTY; ++i) {
                vktty = &vk->tty[i];
-               if (vktty->pid)
+               if (vktty->pid) {
+                       rcu_read_lock();
                        kill_pid(find_vpid(vktty->pid), SIGKILL, 1);
+                       rcu_read_unlock();
+               }
        }
 }

diff --git a/drivers/staging/rtl8712/rtl8712_cmd.c b/drivers/staging/rtl8712/rtl8712_cmd.c
index bb7db96ed821..de13f4eab60f 100644
--- a/drivers/staging/rtl8712/rtl8712_cmd.c
+++ b/drivers/staging/rtl8712/rtl8712_cmd.c
@@ -61,7 +61,9 @@ static void check_hw_pbc(struct _adapter *padapter)
                 */
                if (padapter->pid == 0)
                        return;
+               rcu_read_lock();
                kill_pid(find_vpid(padapter->pid), SIGUSR1, 1);
+               rcu_read_unlock();
        }
 }

