Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833C3515271
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344462AbiD2RoM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379805AbiD2RoF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:44:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F21BC29
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 10:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pk0Qy8fd9eEtcmT3jiI4Z1QGWEupJft65qWtvAfYt7E=; b=P7QUNxw4eQFb4RzJ+oTq/5FMUD
        RVcS+4Pi0BFvhkO/pY2dbIpIq7RWaYo7lljcaQJr2GV5GqvnQpNuzT9pRiCcWA2LE1BT4sFPabRhn
        rBzreFjQa47pkWckgQF4+vSsG5Kqmee9Z5WwHDhKFlwWXCFM8AxfZWBXx/DalIPNf7QlS7nXNa/gd
        bU5+E/+/7lRe9rmYQRBOjZtzXMKeqRMfXCj8m7+MZBQCGqFfFzJ2Mkc8on9/W4LYHBYOBD1c99RXd
        tV/4vzrUZFt8cJaLJbmNfMwq+JP4gAaqzwfsul50yYSCgQ5ZkvpfdNGJ3KnWKSEo+iAC13VwutZ0T
        58pd0SDA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkUbl-00CeT9-4V; Fri, 29 Apr 2022 17:40:45 +0000
Date:   Fri, 29 Apr 2022 18:40:45 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org,
        syzbot+1631f09646bc214d2e76@syzkaller.appspotmail.com,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kari Argillander <kari.argillander@stargateuniverse.net>,
        Namjae Jeon <linkinjeon@kernel.org>
Subject: Re: [PATCH] fs/ntfs3: validate BOOT sectors_per_clusters
Message-ID: <YmwjHVngLrZq4vpD@casper.infradead.org>
References: <20220429172711.31894-1-rdunlap@infradead.org>
 <YmwixlgHg8n4NsOd@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmwixlgHg8n4NsOd@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 29, 2022 at 06:39:18PM +0100, Matthew Wilcox wrote:
> This hurts my brain.  Can we do instead:
> 
> 	if (boot->sectors_per_clusters <= 0x80)
> 		return boot->sectors_per_clusters;
> 	if (boot->sectors_per_clusters < 0xA0)
> 		return 1U << (boot->sectors_per_clusters - 0x80);
> 	return -1;

Changed my mind; 0xffffffff is clearer than returning -1 from a
function which is typed to return an unsigned value.

> >  /*
> > @@ -713,7 +714,7 @@ static int ntfs_init_from_boot(struct su
> >  
> >  	/* cluster size: 512, 1K, 2K, 4K, ... 2M */
> >  	sct_per_clst = true_sectors_per_clst(boot);
> > -	if (!is_power_of_2(sct_per_clst))
> > +	if ((int)sct_per_clst < 0 || !is_power_of_2(sct_per_clst))
> >  		goto out;
> 
> Do we need this change?  Presumably -1 is not a power of 2 ...

And this question then answers itself.  0xffffffff is definitely
not a POT.
