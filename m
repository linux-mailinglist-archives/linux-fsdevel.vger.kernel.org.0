Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C8263FD2F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Dec 2022 01:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbiLBAjh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Dec 2022 19:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbiLBAjf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Dec 2022 19:39:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514602FA7B;
        Thu,  1 Dec 2022 16:39:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A478B82042;
        Fri,  2 Dec 2022 00:39:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7AFC433D6;
        Fri,  2 Dec 2022 00:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1669941570;
        bh=rRla3WD1t6c5uPu2w5Yjfhg4lc18eD2qbBTVmaDIASE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=d11f2HoAOPHkMupwCxvr8N4gFdCqA2nDVBUuNVJNKsPpcwu/qRpcAC3kgId3jJ+Ux
         +XYLKR4qSoFJNi5/3n9O5u6v9QkDGivEKRTlNpnQdKJQrSAJt+qkr03Hqaq9LjsH99
         qBMLCpiOIBQ/91h886TAbxuT0h3BFCCyjhshN0Zo=
Date:   Thu, 1 Dec 2022 16:39:29 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, dan.j.williams@intel.com
Subject: Re: [PATCH v2 3/8] fsdax: zero the edges if source is HOLE or
 UNWRITTEN
Message-Id: <20221201163929.ddd992063d9872ab33459bbf@linux-foundation.org>
In-Reply-To: <Y4k/kxuPOirdlctI@magnolia>
References: <1669908538-55-1-git-send-email-ruansy.fnst@fujitsu.com>
        <1669908538-55-4-git-send-email-ruansy.fnst@fujitsu.com>
        <Y4k/kxuPOirdlctI@magnolia>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 1 Dec 2022 15:58:11 -0800 "Darrick J. Wong" <djwong@kernel.org> wrote:

> > --- a/fs/dax.c
> > +++ b/fs/dax.c
> > @@ -1092,7 +1092,7 @@ static int dax_iomap_direct_access(const struct iomap *iomap, loff_t pos,
> >  }
> >  
> >  /**
> > - * dax_iomap_cow_copy - Copy the data from source to destination before write
> > + * dax_iomap_copy_around - Copy the data from source to destination before write
> 
>  * dax_iomap_copy_around - Prepare for an unaligned write to a
>  * shared/cow page by copying the data before and after the range to be
>  * written.

Thanks, I added this:

--- a/fs/dax.c~fsdax-zero-the-edges-if-source-is-hole-or-unwritten-fix
+++ a/fs/dax.c
@@ -1092,7 +1092,8 @@ out:
 }
 
 /**
- * dax_iomap_copy_around - Copy the data from source to destination before write
+ * dax_iomap_copy_around - Prepare for an unaligned write to a shared/cow page
+ * by copying the data before and after the range to be written.
  * @pos:	address to do copy from.
  * @length:	size of copy operation.
  * @align_size:	aligned w.r.t align_size (either PMD_SIZE or PAGE_SIZE)
_

