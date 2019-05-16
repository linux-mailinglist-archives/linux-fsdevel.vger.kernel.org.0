Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94E322035A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 12:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfEPK04 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 06:26:56 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39048 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbfEPK04 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 06:26:56 -0400
Received: by mail-wm1-f67.google.com with SMTP id n25so2525532wmk.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 May 2019 03:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6OuFsnHiV6x010Ff4QUoBuXDtH16aIZ/7pT/eI266KQ=;
        b=BGsCJWmN1XkPwTN0Cu7Av0zoNp0CZhAgevGKgpGpdOM9qBZXWRicnAEQvUgGwi2Qjo
         A2pvzoNWStXccMqYio95ABa3VHIzb5KtUbyNfqeAY5K/O1YO9FyKLrHfHW5lpZWkCD/E
         R4cP02gPPaIhe7+CAp7D0ckarYaMY1Gg0x52MnaPljOem6J8gE2xItGRg46IM7mwBdxe
         vz4WPUfJfKRU0rnlqLlbX2yQlPAJ1xSR1wQGiI/gZCi/mbc/fIrLheo/JkB5E0qu4qgO
         dGf9mZO7gTP1XTQO3l3GLkGWaozpn9YqDlvRlT546TbNNwCw39Ai7j1lPVk4Xh9dnII4
         686A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6OuFsnHiV6x010Ff4QUoBuXDtH16aIZ/7pT/eI266KQ=;
        b=YnHEqnWevkRm3fhvMUXyzQueZdj1OIQMf4+oCQMDP1Pgj8cLn8+QEBqI9mj5Hmwy9Z
         RFVKATVIiK8WTZgpzbzZWQXm651NG3R8Poj+6ScKRuXcXjtxUC89ZWt2PGexQHIM2d3G
         Pdt1YTJ55DuCYDBbAzgEBZGCYhPMYS8kTm3SwZuibtR/jL8IbnPY4P6wyc9cuL8keb78
         jKfhoJsbBWipEXoNXxk/QVRzquyjT654H77EKTlmsWllEIpfgWvnPGRBskC4VvRROtwg
         oYDuvwtvC7QugHFEfWdtiiHkJxB8IorG+mx0cUyiXVgIKWFoRORzBXkOnaahTDJl6uYN
         Y5Lw==
X-Gm-Message-State: APjAAAW8OnyMi4j9Kbno3RRR2/zWcGcYU3hLTD1qcMfkqHm68LYf8YtB
        81Y13YeH85a1W6ONLFSbPOU=
X-Google-Smtp-Source: APXvYqzJIvUoBbyxAV+kJ9o7pD0WJv8KYMZxxhCYLZcavXm+TmJ3VgBQaEMv43sGmwo0rgJ0OBZphg==
X-Received: by 2002:a1c:b782:: with SMTP id h124mr28071419wmf.5.1558002414789;
        Thu, 16 May 2019 03:26:54 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id d72sm4506299wmd.12.2019.05.16.03.26.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 03:26:54 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 01/14] ASoC: rename functions that pollute the simple_xxx namespace
Date:   Thu, 16 May 2019 13:26:28 +0300
Message-Id: <20190516102641.6574-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190516102641.6574-1-amir73il@gmail.com>
References: <20190516102641.6574-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

include/linux/fs.h defines a bunch of simple fs helpers, (e.g.
simple_rename) and we intend to add an fs helper named simple_remove.

Rename the ASoC driver static functions, so they will not collide with
the upcoming fs helper function name.

Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 sound/soc/generic/simple-card.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 9b568f578bcd..d16e894fce2b 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -607,7 +607,7 @@ static int simple_soc_probe(struct snd_soc_card *card)
 	return 0;
 }
 
-static int simple_probe(struct platform_device *pdev)
+static int asoc_simple_probe(struct platform_device *pdev)
 {
 	struct asoc_simple_priv *priv;
 	struct device *dev = &pdev->dev;
@@ -705,7 +705,7 @@ static int simple_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int simple_remove(struct platform_device *pdev)
+static int asoc_simple_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
@@ -726,8 +726,8 @@ static struct platform_driver asoc_simple_card = {
 		.pm = &snd_soc_pm_ops,
 		.of_match_table = simple_of_match,
 	},
-	.probe = simple_probe,
-	.remove = simple_remove,
+	.probe = asoc_simple_probe,
+	.remove = asoc_simple_remove,
 };
 
 module_platform_driver(asoc_simple_card);
-- 
2.17.1

