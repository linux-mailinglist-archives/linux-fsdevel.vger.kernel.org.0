Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE86B2FC873
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 04:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389746AbhATDGA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 22:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730075AbhATDFv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 22:05:51 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B519C061575;
        Tue, 19 Jan 2021 19:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=cW9dntD9nGh8jVvLhLWe1YqLbc1l7R2XancWLaWAZn0=; b=dgyGnH/9OA6cRq6lOqC17NWXBn
        gsp7Y/bP2Mx6Mn6cLhVLZKkA3Ag4+5tx3c8Xj5IvsYuBrpU3H6G+VpTi/+KjbDjF2lYqYRjlbDPVF
        1lD8TU9+2869FaBaX5vemMdnDMY+YQ5lBKSEV7OJgkuN/XtXLeQuoHFBoAM+gtEaCXgwnAE9wQFa8
        hUUi5BWLiS4bzljjOGy0dcFYLwBj2sHdQfuND27PUEUfsMd/yCjjYmvDdcjRn43bQMSNccI23+XRQ
        keHOdcCVx4Y5eiO/QqVj4UMPt9eFHQZxRHyF78k31EThdlA31a8lgXgw60M6KIQnKIXApSSZD4R2r
        suBkbohA==;
Received: from [2601:1c0:6280:3f0::9abc]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l23nm-0004q5-Ox; Wed, 20 Jan 2021 03:04:59 +0000
Subject: [PATCH -mmotm] mm/memory_hotplug: fix for CONFIG_ZONE_DEVICE not
 enabled
To:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Dan Williams <dan.j.williams@intel.com>
References: <20210119213727.pkiuSGW9i%akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5f8e2ede-5836-45e1-d8d7-ae949775e76e@infradead.org>
Date:   Tue, 19 Jan 2021 19:04:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210119213727.pkiuSGW9i%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix memory_hotplug.c when CONFIG_ZONE_DEVICE is not enabled.

Fixes this build error:

../mm/memory_hotplug.c: In function ‘move_pfn_range_to_zone’:
../mm/memory_hotplug.c:772:24: error: ‘ZONE_DEVICE’ undeclared (first use in this function); did you mean ‘ZONE_MOVABLE’?
  if (zone_idx(zone) == ZONE_DEVICE) {

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>
---
 mm/memory_hotplug.c |    2 ++
 1 file changed, 2 insertions(+)

--- mmotm-2021-0119-1336.orig/mm/memory_hotplug.c
+++ mmotm-2021-0119-1336/mm/memory_hotplug.c
@@ -769,12 +769,14 @@ void __ref move_pfn_range_to_zone(struct
 	 * ZONE_DEVICE pages in an otherwise  ZONE_{NORMAL,MOVABLE}
 	 * section.
 	 */
+#ifdef CONFIG_ZONE_DEVICE
 	if (zone_idx(zone) == ZONE_DEVICE) {
 		if (!IS_ALIGNED(start_pfn, PAGES_PER_SECTION))
 			section_taint_zone_device(start_pfn);
 		if (!IS_ALIGNED(start_pfn + nr_pages, PAGES_PER_SECTION))
 			section_taint_zone_device(start_pfn + nr_pages);
 	}
+#endif
 
 	/*
 	 * TODO now we have a visible range of pages which are not associated

