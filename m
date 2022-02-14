Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652994B5C93
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Feb 2022 22:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbiBNVVu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Feb 2022 16:21:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiBNVVq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:21:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66421179BA;
        Mon, 14 Feb 2022 13:21:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48FD8B8164B;
        Mon, 14 Feb 2022 19:05:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D599C340E9;
        Mon, 14 Feb 2022 19:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644865550;
        bh=0qXjvfXrQAWSIg6NzaQiBgbrubEQO78+++XPIl1Kl8c=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=rZoYLgMoANJJQhw6AF430YieYpe50cyfmskQ8MsdJR2TZcu266KSWTuNs7Y2aYx1+
         CHhdGj1EQKrOcSDoQWpOkCvYMZp7eX5l+P2kFOb4WqgNTAe2qyvKvYN+oJYUavpSoA
         67WDlT3swFWpW9jcvLjwBdy9iRGWgWC/KpHRRidnIU57H+7a2Wcaq752/j/c3mPXyE
         CResbLhsqjSIU3HRY6Qa3/4tRlp7x+43k9hls/xPM1p0NcwNSuWvBIi3es9uoVohyg
         eZXKWqPy3LREqlQXWp55dVvInVSOnf+l1er9wnatIzNgYZ0LgzEvGA9DE+y5iTY8YI
         9hgeJcTGnxV6Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 918F35C0388; Mon, 14 Feb 2022 11:05:49 -0800 (PST)
Date:   Mon, 14 Feb 2022 11:05:49 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     clm@fb.com
Cc:     riel@surriel.com, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH RFC fs/namespace] Make kern_unmount() use
 synchronize_rcu_expedited()
Message-ID: <20220214190549.GA2815154@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Experimental.  Not for inclusion.  Yet, anyway.

Freeing large numbers of namespaces in quick succession can result in
a bottleneck on the synchronize_rcu() invoked from kern_unmount().
This patch applies the synchronize_rcu_expedited() hammer to allow
further testing and fault isolation.

Hey, at least there was no need to change the comment!  ;-)

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: <linux-fsdevel@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Not-yet-signed-off-by: Paul E. McKenney <paulmck@kernel.org>

---

 namespace.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 40b994a29e90d..79c50ad0ade5b 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4389,7 +4389,7 @@ void kern_unmount(struct vfsmount *mnt)
 	/* release long term mount so mount point can be released */
 	if (!IS_ERR_OR_NULL(mnt)) {
 		real_mount(mnt)->mnt_ns = NULL;
-		synchronize_rcu();	/* yecchhh... */
+		synchronize_rcu_expedited();	/* yecchhh... */
 		mntput(mnt);
 	}
 }
