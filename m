Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296D5544ECB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jun 2022 16:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239519AbiFIOV7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jun 2022 10:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343710AbiFIOVO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:21:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC882DF124;
        Thu,  9 Jun 2022 07:21:11 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CBBB01FE8B;
        Thu,  9 Jun 2022 14:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654784469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fY1GGI2PmNa9I/bhZ0fwzUE7IhjxYe1c+FuipaBGfM4=;
        b=WZBqe2Ngc57dpZ7Y9YIpBMWIEGgtumFc7wHEEmS3iMGOErxmCbDE8Y4kutoItwMX8mXOot
        aI38i6FM3xM1D1L9ytfvCrvrCh274JSZGEs2spz0dIdXONggDsS4OArMC9r3EchMRvbyoB
        Fra0izLAWYuEpWfzqf3+ibWKEYv1Htg=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7E6282C141;
        Thu,  9 Jun 2022 14:21:09 +0000 (UTC)
Date:   Thu, 9 Jun 2022 16:21:05 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>
Cc:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        alexander.deucher@amd.com, daniel@ffwll.ch,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        hughd@google.com, andrey.grodzovsky@amd.com
Subject: Re: [PATCH 03/13] mm: shmem: provide oom badness for shmem files
Message-ID: <YqIB0bavUeU8Abwl@dhcp22.suse.cz>
References: <20220531100007.174649-1-christian.koenig@amd.com>
 <20220531100007.174649-4-christian.koenig@amd.com>
 <YqG67sox6L64E6wV@dhcp22.suse.cz>
 <77b99722-fc13-e5c5-c9be-7d4f3830859c@amd.com>
 <YqHuH5brYFQUfW8l@dhcp22.suse.cz>
 <26d3e1c7-d73c-cc95-54ef-58b2c9055f0c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26d3e1c7-d73c-cc95-54ef-58b2c9055f0c@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 09-06-22 16:10:33, Christian König wrote:
> Am 09.06.22 um 14:57 schrieb Michal Hocko:
> > On Thu 09-06-22 14:16:56, Christian König wrote:
> > > Am 09.06.22 um 11:18 schrieb Michal Hocko:
> > > > On Tue 31-05-22 11:59:57, Christian König wrote:
> > > > > This gives the OOM killer an additional hint which processes are
> > > > > referencing shmem files with potentially no other accounting for them.
> > > > > 
> > > > > Signed-off-by: Christian König <christian.koenig@amd.com>
> > > > > ---
> > > > >    mm/shmem.c | 6 ++++++
> > > > >    1 file changed, 6 insertions(+)
> > > > > 
> > > > > diff --git a/mm/shmem.c b/mm/shmem.c
> > > > > index 4b2fea33158e..a4ad92a16968 100644
> > > > > --- a/mm/shmem.c
> > > > > +++ b/mm/shmem.c
> > > > > @@ -2179,6 +2179,11 @@ unsigned long shmem_get_unmapped_area(struct file *file,
> > > > >    	return inflated_addr;
> > > > >    }
> > > > > +static long shmem_oom_badness(struct file *file)
> > > > > +{
> > > > > +	return i_size_read(file_inode(file)) >> PAGE_SHIFT;
> > > > > +}
> > > > This doesn't really represent the in memory size of the file, does it?
> > > Well the file could be partially or fully swapped out as anonymous memory or
> > > the address space only sparse populated, but even then just using the file
> > > size as OOM badness sounded like the most straightforward approach to me.
> > It covers hole as well, right?
> 
> Yes, exactly.

So let's say I have a huge sparse shmem file. I will get killed because
the oom_badness of such a file would be large as well...

> > > What could happen is that the file is also mmaped and we double account.
> > > 
> > > > Also the memcg oom handling could be considerably skewed if the file was
> > > > shared between more memcgs.
> > > Yes, and that's one of the reasons why I didn't touched the memcg by this
> > > and only affected the classic OOM killer.
> > oom_badness is for all oom handlers, including memcg. Maybe I have
> > misread an earlier patch but I do not see anything specific to global
> > oom handling.
> 
> As far as I can see the oom_badness() function is only used in
> oom_kill.c and in procfs to return the oom score. Did I missed
> something?

oom_kill.c implements most of the oom killer functionality. Memcg oom
killing is a part of that. Have a look at select_bad_process.

-- 
Michal Hocko
SUSE Labs
