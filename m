Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCBEE54514D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jun 2022 17:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237581AbiFIPyP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jun 2022 11:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344075AbiFIPyM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:54:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D354C31DC4;
        Thu,  9 Jun 2022 08:54:09 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5FDBB1FEA9;
        Thu,  9 Jun 2022 15:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654790048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jZtcZUbZig1UhIcXMJ758dp36LQQ/d16e8zqnLoYBUI=;
        b=WeDq7XZhXURQuDayn95bRWP62X8BWXvBWugF0x6+pE4jsWM4S9ZNndFwfvt1GcJxeIMrCZ
        sg5yXPKNGFmFwwTy5w1f5UsEiyFE3HKe7evhJUnwKy37LUQ9n6BAxBciF4GE87AHj9LJ0Q
        KzeXJveNtrfE/koMZPau6VmuysgUvhM=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 090D02C141;
        Thu,  9 Jun 2022 15:54:07 +0000 (UTC)
Date:   Thu, 9 Jun 2022 17:54:07 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Felix Kuehling <felix.kuehling@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, alexander.deucher@amd.com, daniel@ffwll.ch,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        hughd@google.com, andrey.grodzovsky@amd.com
Subject: Re: [PATCH 03/13] mm: shmem: provide oom badness for shmem files
Message-ID: <YqIXn0V3dEvGPZ1h@dhcp22.suse.cz>
References: <20220531100007.174649-1-christian.koenig@amd.com>
 <20220531100007.174649-4-christian.koenig@amd.com>
 <YqG67sox6L64E6wV@dhcp22.suse.cz>
 <77b99722-fc13-e5c5-c9be-7d4f3830859c@amd.com>
 <YqHuH5brYFQUfW8l@dhcp22.suse.cz>
 <26d3e1c7-d73c-cc95-54ef-58b2c9055f0c@gmail.com>
 <YqIB0bavUeU8Abwl@dhcp22.suse.cz>
 <d841c1ab-c0d1-5130-11fc-c8ea04cc9511@amd.com>
 <41dc3e5a-9e90-70df-74df-ccdf8fa5ae86@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41dc3e5a-9e90-70df-74df-ccdf8fa5ae86@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 09-06-22 17:22:14, Christian König wrote:
[...]
> Those files were never part of any filesystem in the first place, so by
> killing all the process referencing them you can indeed free the memory
> locked by them.

Yes, this would require the oom killer to understand that all processes
referencing that file are killed. Theoretically possible but I am not
sure a feasible solution.
-- 
Michal Hocko
SUSE Labs
