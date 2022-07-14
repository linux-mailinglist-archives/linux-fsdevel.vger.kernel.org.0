Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC96E57406F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jul 2022 02:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiGNAWW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 20:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiGNAWW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 20:22:22 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4673B14080
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jul 2022 17:22:21 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 166E010E8436;
        Thu, 14 Jul 2022 10:22:20 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oBmcV-000adY-A2; Thu, 14 Jul 2022 10:22:19 +1000
Date:   Thu, 14 Jul 2022 10:22:19 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     ansgar.loesser@kom.tu-darmstadt.de
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>,
        Amir Goldstein <amir73il@gmail.com>,
        Mark Fasheh <mark@fasheh.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Security Officers <security@kernel.org>,
        Max Schlecht <max.schlecht@informatik.hu-berlin.de>,
        =?iso-8859-1?Q?Bj=F6rn?= Scheuermann 
        <scheuermann@kom.tu-darmstadt.de>
Subject: Re: [PATCH] vf/remap: return the amount of bytes actually
 deduplicated
Message-ID: <20220714002219.GG3600936@dread.disaster.area>
References: <CAHk-=wgEgAjX5gRntm0NutaNtjkzN+OaJVMaJAqved4dxPtAqw@mail.gmail.com>
 <Ys3TrAf95FpRgr+P@localhost.localdomain>
 <CAHk-=wi1-o-3iF09+PnNHq6_HLQhRn+32ow_f44to7_JuNCUoA@mail.gmail.com>
 <Ys4WdKSUTcvktuEl@magnolia>
 <CAHk-=wjUw11O60KuPBpsq1-hut9-Y76puzGqvgFJr5RwUPLS_A@mail.gmail.com>
 <20220713064631.GC3600936@dread.disaster.area>
 <20220713074915.GD3600936@dread.disaster.area>
 <5548ef63-62f9-4f46-5793-03165ceccacc@tu-darmstadt.de>
 <CAHk-=wgw3mWybD3E4236sGjNdnFsR60XHKhQNe0rJW5mbhqUAA@mail.gmail.com>
 <b5805118-7e56-3d43-28e9-9e0198ee43f3@tu-darmstadt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b5805118-7e56-3d43-28e9-9e0198ee43f3@tu-darmstadt.de>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=62cf61bc
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=8nJEP1OIZ-IA:10 a=RgO8CyIxsXoA:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
        a=QFwzt2L8fJlsY8wJ2tIA:9 a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 13, 2022 at 08:51:44PM +0200, Ansgar Lößer wrote:
> When using the FIDEDUPRANGE ioctl, in case of success the requested size
> is returned. In some cases this might not be the actual amount of bytes
> deduplicated.
> 
> This change modifies vfs_dedupe_file_range() to report the actual amount
> of bytes deduplicated, instead of the requested amount.
> 
> Link: https://lore.kernel.org/linux-fsdevel/5548ef63-62f9-4f46-5793-03165ceccacc@tu-darmstadt.de/
> 
> Reported-by: Ansgar Lößer (ansgar.loesser@kom.tu-darmstadt.de)
> Reported-by: Max Schlecht (max.schlecht@informatik.hu-berlin.de)
> Reported-by: Björn Scheuermann (scheuermann@kom.tu-darmstadt.de)
> Signed-off-by: Ansgar Lößer <ansgar.loesser@kom.tu-darmstadt.de>
> ---
> 
> > Mind sending it with a sign-off and a short commit message?
> > 
> >               Linus
> Sure, thank you!
> 
> This is my first commit, so I hope it is ok like this.
> 
> 
>  fs/remap_range.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/remap_range.c b/fs/remap_range.c
> index e112b5424cdb..072c2c48aeed 100644
> --- a/fs/remap_range.c
> +++ b/fs/remap_range.c
> @@ -546,7 +546,7 @@ int vfs_dedupe_file_range(struct file *file, struct
> file_dedupe_range *same)
>                 else if (deduped < 0)
>                         info->status = deduped;
>                 else
> -                       info->bytes_deduped = len;
> +                       info->bytes_deduped = deduped;
> 
>  next_fdput:
>                 fdput(dst_fd);

That's a potential change of API behaviour that userspace may barf
on as this now can return "success/0 bytes" instead of
"success/len".

e.g. If userspace is looping over a file based on the returned
info->bytes_deduped value, can this change cause them to behave
differently? e.g. get stuck in an endless loop on the EOF block
always returning SAME/0 instead of DIFFER?

Also, doesn't this just paper over the bug in
vfs_dedupe_file_range_compare() where it returns is_same = true when
the length to compare is zero as will happen when comparing
differing EOF blocks now when it should be returning -EBADE?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
