Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A235757AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jul 2022 00:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240211AbiGNWcq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Jul 2022 18:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiGNWcq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Jul 2022 18:32:46 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F0D615B06F
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Jul 2022 15:32:44 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 63E5810E7EE0;
        Fri, 15 Jul 2022 08:32:40 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oC7Nu-000xYe-E3; Fri, 15 Jul 2022 08:32:38 +1000
Date:   Fri, 15 Jul 2022 08:32:38 +1000
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
Message-ID: <20220714223238.GH3600936@dread.disaster.area>
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
X-Optus-CM-Analysis: v=2.4 cv=OJNEYQWB c=1 sm=1 tr=0 ts=62d0998c
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=8nJEP1OIZ-IA:10 a=RgO8CyIxsXoA:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
        a=H_OoexI7QSTdBcIIjToA:9 a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
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
> --
> 2.35.1

As I suspected would occur, this change causes test failures. e.g
generic/517 in fstests fails with:

generic/517 1s ... - output mismatch (see /home/dave/src/xfstests-dev/results//xfs_quota/generic/517.out.bad)
--- tests/generic/517.out   2019-10-29 11:47:07.464539451 +1100
+++ /home/dave/src/xfstests-dev/results//xfs_quota/generic/517.out.bad      2022-07-14 18:00:04.833536434 +1000
@@ -13,7 +13,7 @@
*
0786528 ae ae ae ae
0786532
-deduped 131172/131172 bytes at offset 65536
+deduped 131072/131172 bytes at offset 65536
XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
File content after first deduplication and before unmounting:
...
(Run 'diff -u /home/dave/src/xfstests-dev/tests/generic/517.out /home/dave/src/xfstests-dev/results//xfs_quota/generic/517.out.bad'  to see the entire diff)

The whole diff is:

-- /home/dave/src/xfstests-dev/tests/generic/517.out   2019-10-29 11:47:07.464539451 +1100
+++ /home/dave/src/xfstests-dev/results//xfs_quota/generic/517.out.bad  2022-07-14 18:00:04.833536434 +1000
@@ -13,7 +13,7 @@
 *
 0786528 ae ae ae ae
 0786532
-deduped 131172/131172 bytes at offset 65536
+deduped 131072/131172 bytes at offset 65536
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 File content after first deduplication and before unmounting:
 0000000 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
@@ -33,8 +33,6 @@
 0786532
 wrote 100/100 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-deduped 100/100 bytes at offset 655360
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 File content after second deduplication:
 0000000 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
 *

This shows user visible API behaviours (i.e. "short dedupe"
behaviour) that may be unexpected by userspace.  So while the change
might be technically correct, it definitely changes the behaviour at
least one test expects to occur.

This is why I asked if this had been tested - it tells us if
userspace is likely to see issues with the API change. "Correct but
breaks tests" is basically a warning that we should expect
users/applications to notice the API change and that there's a good
likelyhood of downstream problems arising from it...

Linus, can you please revert this commit for the 5.19 series (before
the stable autosel bot sends it back to stable kernels, please!) to
give us more time to investigate and consider the impact of the the
API change on userspace applications before we commit to changing
the API.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
