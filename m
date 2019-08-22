Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 395C79A331
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2019 00:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394110AbfHVWn6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Aug 2019 18:43:58 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35927 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394082AbfHVWn6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Aug 2019 18:43:58 -0400
Received: by mail-pf1-f193.google.com with SMTP id w2so4960854pfi.3;
        Thu, 22 Aug 2019 15:43:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YQxy7LG7DNBTUMkrggpj64fW1gmhMtjURQTq0iGs9uE=;
        b=hkVcYBdNtASV/n7ywYECSZj7gQmRXBZ+0SMzZK88ilkr84vNP4UDw7FqnU3gtpEZ4E
         3bA22+3URwKP40saxjPQLq2J2L8SQKKjzo/aRRm+sR/fFdJVAmf4d5Yxgk/ePg1rguzv
         tRPFEPOOSjEs8urUcvcUI8vimr9A/zom297hY3f9nL4wEVQLi9/4hjLjQ2cZiiC6pvu3
         1rEim3NPSS1liI5A9nqfCgclkAnoVOFGJGbsMxEek6CrebbH1ShuF9SAW92oaNvVKBEu
         1c3gzK37+cAzhTtXTAk4hDShvPDW9VtsVOG3gfc5wNEy0YgClUoIiAiQdsVACWrRsCqq
         Opnw==
X-Gm-Message-State: APjAAAUVmGt/bUdxBhrUWp4yoeEcCaQBe0vU9j6jOgQZ4/OwKmHx094Z
        f7dG+N8+aiSq/F0eNQM0rjYV7rEj
X-Google-Smtp-Source: APXvYqzq5MAdFE8W+s3h6x+elqgSyD7DLrYGhZaQ+mvzJpjFxObTVVGVt+YPpEiF2OQPYZXg8CFg/Q==
X-Received: by 2002:a17:90a:3a8d:: with SMTP id b13mr2051805pjc.75.1566513837445;
        Thu, 22 Aug 2019 15:43:57 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id y8sm405397pfr.140.2019.08.22.15.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 15:43:56 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 97286403DC; Thu, 22 Aug 2019 22:43:55 +0000 (UTC)
Date:   Thu, 22 Aug 2019 22:43:55 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Matias Bjorling <matias.bjorling@wdc.com>
Subject: Re: [PATCH V2] fs: New zonefs file system
Message-ID: <20190822224355.GX30113@42.do-not-panic.com>
References: <20190820081249.27353-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820081249.27353-1-damien.lemoal@wdc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 20, 2019 at 05:12:49PM +0900, Damien Le Moal wrote:
> The aggregated conventional zone file can be used as a regular file.
> Operations such as the following work.
> 
> mkfs.ext4 /mnt/cnv/0
> mount -o loop /mnt/cnv/0 /data

Should BLK_DEV_LOOP_MIN_COUNT be increased if this is enabled to
a mich higher sensible default? Right now the default is 8. Also,
can we infer this later dynamically so so this can grow at proper
scale without having to have user interaction?

For now, I mean something like:

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 1bb8ec575352..22ba4803b075 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -217,7 +217,8 @@ config BLK_DEV_LOOP
 config BLK_DEV_LOOP_MIN_COUNT
 	int "Number of loop devices to pre-create at init time"
 	depends on BLK_DEV_LOOP
-	default 8
+	default 8 if !ZONEFS FILESYSTEM
+	default 32 if ZONEFS FILESYSTEM
 	help
 	  Static number of loop devices to be unconditionally pre-created
 	  at init time.

  Luis
