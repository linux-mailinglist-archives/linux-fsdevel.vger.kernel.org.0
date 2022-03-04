Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84A94CDE5C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Mar 2022 21:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiCDUBc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Mar 2022 15:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiCDUA5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:00:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5577F2013C7;
        Fri,  4 Mar 2022 11:52:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8CB4DB82B66;
        Fri,  4 Mar 2022 19:34:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98BADC340E9;
        Fri,  4 Mar 2022 19:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646422482;
        bh=nd2/3a4bfzST5ALw5Y8hQGVZfc4S2TZKpWT8b71rPp4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z7wp/FCwTTd2m1BAAR7vCpAG9vwx9PGz9UzbFd1PkImVy9MPDHh0sMCEGrwv46nTz
         mztVdpOSAa6BXG9ah+AlbZuh0dHCBhY8DEDZQSAae2M2VzQ+4UB7Pp7StXvoByovKW
         xV7g07LsQnKbSOFPNvsrgT2RsBKJG96tAFLBsNhQFo4RJbapEWKu86tK4ByyOGdRdO
         nvZDuu095RRK2ZawuGULjdUqdViPzucfbXLgCGQ7SRMmWSdbB4uIhbWvJvQG8UcGTn
         khiCmAr5lAFPj0BgHXNo283X0Er9oDdiSJPJmJEZ9NW6GE2qFW3YYNWWqQ2+f7utlY
         gdLXojztzHI6A==
Date:   Fri, 4 Mar 2022 11:34:39 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, sagi@grimberg.me, song@kernel.org,
        linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] nvme: remove support or stream based temperature hint
Message-ID: <20220304193439.GA3256926@dhcp-10-100-145-180.wdc.com>
References: <20220304175556.407719-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304175556.407719-1-hch@lst.de>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 04, 2022 at 06:55:55PM +0100, Christoph Hellwig wrote:
> -	ctrl->nssa = le16_to_cpu(s.nssa);
> -	if (ctrl->nssa < BLK_MAX_WRITE_HINTS - 1) {
> -		dev_info(ctrl->device, "too few streams (%u) available\n",
> -					ctrl->nssa);
> -		goto out_disable_stream;
> -	}

Just fyi, looks like the patch was built against an older version of the
driver, so it doesn't apply cleanly to nvme-5.18 at the above part.

Also please consider folding the following in this patch since it removes all
nr_streams use:

---
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 587d92df118b..1bed663322ee 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -280,7 +280,6 @@ struct nvme_ctrl {
 	u16 crdt[3];
 	u16 oncs;
 	u16 oacs;
-	u16 nr_streams;
 	u16 sqsize;
 	u32 max_namespaces;
 	atomic_t abort_limit;
--
