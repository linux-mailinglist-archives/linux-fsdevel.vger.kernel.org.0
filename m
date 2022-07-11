Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A3856FFDB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jul 2022 13:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbiGKLNz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jul 2022 07:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiGKLN3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:13:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3136A13CE7
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Jul 2022 03:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657535280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sxcej8iLaxk6KCtDFxQeEdx04v8nRpskZBg7onOm+l0=;
        b=BqCWdsSiO7m6yMR7pcF4r/mfu2NclrghAXxffydWAcuXgPVvYAGSeRf0FgI3bCM9JKBVEl
        l4jUVXeQjrmmi4LRvS9mXMVMDVwiI+Iur56t/yIBa+CDSVnCxEgTRk5EhIiVLUV5tIZ9uH
        m2hDyT7h2v63JwSrlP6XjoqX8G2X6zQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-356-EsQE4lh0OoW25cc4NkcRtA-1; Mon, 11 Jul 2022 06:27:50 -0400
X-MC-Unique: EsQE4lh0OoW25cc4NkcRtA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AFCDB811E7A;
        Mon, 11 Jul 2022 10:27:49 +0000 (UTC)
Received: from nux.com (unknown [10.40.192.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0B6EA2026D64;
        Mon, 11 Jul 2022 10:27:47 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/4] gfs2: stop using generic_writepages in gfs2_ail1_start_one
Date:   Mon, 11 Jul 2022 12:27:47 +0200
Message-Id: <20220711102747.359525-1-agruenba@redhat.com>
In-Reply-To: <20220711041459.1062583-2-hch@lst.de>
References: <20220711041459.1062583-2-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Mon, Jul 11, 2022 at 7:27 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Use filemap_fdatawrite_wbc instead of generic_writepages in
> gfs2_ail1_start_one so that the functin can also cope with address_space
> operations that only implement ->writepages and to properly account
> for cgroup writeback.

Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>

I assume you want to push this through the xfs tree.

Can you add the below follow-up cleanup?

Thanks,
Andreas

---
 fs/gfs2/log.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index 624dffc96136..7fc6cb95dec8 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -222,8 +222,7 @@ void gfs2_ail1_flush(struct gfs2_sbd *sdp, struct writeback_control *wbc)
 	spin_unlock(&sdp->sd_ail_lock);
 	blk_finish_plug(&plug);
 	if (ret) {
-		gfs2_lm(sdp, "gfs2_ail1_start_one (generic_writepages) "
-			"returned: %d\n", ret);
+		gfs2_lm(sdp, "gfs2_ail1_start_one returned %d\n", ret);
 		gfs2_withdraw(sdp);
 	}
 	trace_gfs2_ail_flush(sdp, wbc, 0);
-- 
2.36.1

