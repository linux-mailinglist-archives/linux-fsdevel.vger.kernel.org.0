Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0D376B4D4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 14:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbjHAMec (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 08:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjHAMec (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 08:34:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65721FC7;
        Tue,  1 Aug 2023 05:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S/u4vYJhKZmYxEtl4s2/42a0qgFgAhFLv7zKyESwQwc=; b=lQ6p7/T9cFvMeIg2EyU85XKRvo
        rlNd+GuoLvcrJtSy1nKprTIR9lNmaBBEgKJ6TC60RIZh93gtupZYwrBvvqGsyXaXqM3kFbfdeo3za
        PZwz5czl29B4EWZEbJOwjCSROXrGISrKQs2yH+3IAA61erVASsi3Opu23+QmTYW+Ko62xB9bZ6O46
        90LRFevYeSULZoPCRz1Y7ba0M2YaD24qBMN1Us13RJH6aQXrfHY/nzH76am3TX7k+zz99f7ioxyzL
        i3FRo70yR9oTL6XcjJ5nti2x7JApZ5OYxJ8mBXcTkmTQQXGqoL4SUpypLkXFWEX425gOQrRgRmhNc
        o+Etj7aw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qQoZx-008m2n-Nt; Tue, 01 Aug 2023 12:34:21 +0000
Date:   Tue, 1 Aug 2023 13:34:21 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Christian Brauner <christian@brauner.io>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Harry Pan <harry.pan@intel.com>, linux-pm@vger.kernel.org
Subject: Re: ksys_sync_helper
Message-ID: <ZMj7zTwPw/qi/bNw@casper.infradead.org>
References: <ZMdgxYPPRYFipu1e@infradead.org>
 <e1aef4d4-b6fb-46ca-f11b-08b3e5eea27d@intel.com>
 <ZMjnZhbKbNMmcUPN@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMjnZhbKbNMmcUPN@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 01, 2023 at 04:07:18AM -0700, Christoph Hellwig wrote:
> On Mon, Jul 31, 2023 at 08:27:17PM +0200, Wysocki, Rafael J wrote:
> > 
> > OK, I'll remember about this.
> > 
> > 
> > > With this
> > > and commit d5ea093eebf022e now we end up with a random driver (amdgpu)
> > > syncing all file systems for absolutely no good reason.
> > 
> > Sorry about that.
> > 
> > The problematic commit should still revert more or less cleanly, so please
> > do that if that's what you need.
> 
> We'd still need to remove abuse in amdgpu first, though.

This would effectively revert d5ea093eebf0


diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index dc0e5227119b..af04fece37d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -75,7 +75,6 @@
 #include "amdgpu_fru_eeprom.h"
 #include "amdgpu_reset.h"
 
-#include <linux/suspend.h>
 #include <drm/task_barrier.h>
 #include <linux/pm_runtime.h>
 
@@ -5225,17 +5224,6 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	 */
 	need_emergency_restart = amdgpu_ras_need_emergency_restart(adev);
 
-	/*
-	 * Flush RAM to disk so that after reboot
-	 * the user can read log and see why the system rebooted.
-	 */
-	if (need_emergency_restart && amdgpu_ras_get_context(adev)->reboot) {
-		DRM_WARN("Emergency reboot.");
-
-		ksys_sync_helper();
-		emergency_restart();
-	}
-
 	dev_info(adev->dev, "GPU %s begin!\n",
 		need_emergency_restart ? "jobs stop":"reset");
 
