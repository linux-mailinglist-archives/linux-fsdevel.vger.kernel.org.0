Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA737572F99
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 09:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbiGMHty (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 03:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbiGMHtd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:49:33 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9CADFC25AF
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jul 2022 00:49:20 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 4C70A10E7EE5;
        Wed, 13 Jul 2022 17:49:17 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oBX7T-000JlF-Vm; Wed, 13 Jul 2022 17:49:16 +1000
Date:   Wed, 13 Jul 2022 17:49:15 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        ansgar.loesser@kom.tu-darmstadt.de, Christoph Hellwig <hch@lst.de>,
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
Subject: [PATCH] fs/remap: constrain dedupe of EOF blocks
Message-ID: <20220713074915.GD3600936@dread.disaster.area>
References: <a7c93559-4ba1-df2f-7a85-55a143696405@tu-darmstadt.de>
 <CAHk-=wjrOgiWfN2uWf8Ajgr4SjeWMkEJ1Sd=H6pnS_JLjJwTcQ@mail.gmail.com>
 <CAEzrpqdweuZ2ufMKDJwSzP5W021F7mgS+7toSo6VDgvDzd0ZqA@mail.gmail.com>
 <CAHk-=wgEgAjX5gRntm0NutaNtjkzN+OaJVMaJAqved4dxPtAqw@mail.gmail.com>
 <Ys3TrAf95FpRgr+P@localhost.localdomain>
 <CAHk-=wi1-o-3iF09+PnNHq6_HLQhRn+32ow_f44to7_JuNCUoA@mail.gmail.com>
 <Ys4WdKSUTcvktuEl@magnolia>
 <CAHk-=wjUw11O60KuPBpsq1-hut9-Y76puzGqvgFJr5RwUPLS_A@mail.gmail.com>
 <20220713064631.GC3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220713064631.GC3600936@dread.disaster.area>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=OJNEYQWB c=1 sm=1 tr=0 ts=62ce78ff
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=8nJEP1OIZ-IA:10 a=RgO8CyIxsXoA:10 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8
        a=jcsaIUBvv7G4UYzQmW8A:9 a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

If dedupe of an EOF block is not constrainted to match against only
other EOF blocks with the same EOF offset into the block, it can
match against any other block that has the same matching initial
bytes in it, even if the bytes beyond EOF in the source file do
not match.

Fix this by constraining the EOF block matching to only match
against other EOF blocks that have identical EOF offsets and data.
This allows "whole file dedupe" to continue to work without allowing
eof blocks to randomly match against partial full blocks with the
same data.

Reported-by: Ansgar Lößer <ansgar.loesser@tu-darmstadt.de>
Fixes: 1383a7ed6749 ("vfs: check file ranges before cloning files")
Link: https://lore.kernel.org/linux-fsdevel/a7c93559-4ba1-df2f-7a85-55a143696405@tu-darmstadt.de/
Signed-off-by: Dave Chinner <dchinner@redhat.com>
---

This is tested against the case provided in the initial report. Old
kernel:

$ ./dedupe.sh |less
secret
$

Patched kernel:

$ ./dedupe.sh
dedupe-bug: t.c:90: main: Assertion `status != FILE_DEDUPE_RANGE_DIFFERS' failed.
./dedupe.sh: line 11:  4831 Aborted /home/dave/dedupe-bug $MNT/writeonly.txt $MNT/test.tmp
$

So now it fails with FILE_DEDUPE_RANGE_DIFFERS because it can't use
short files to discover the dedupe character match one byte at a
time.

It also passes fstests ismoke tests via running the './check -g
dedupe' test group, so the fix doesn't obviously break anything.

 fs/remap_range.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/remap_range.c b/fs/remap_range.c
index e112b5424cdb..881a306ee247 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -71,7 +71,8 @@ static int generic_remap_checks(struct file *file_in, loff_t pos_in,
 	 * Otherwise, make sure the count is also block-aligned, having
 	 * already confirmed the starting offsets' block alignment.
 	 */
-	if (pos_in + count == size_in) {
+	if (pos_in + count == size_in &&
+	    (!(remap_flags & REMAP_FILE_DEDUP) || pos_out + count == size_out)) {
 		bcount = ALIGN(size_in, bs) - pos_in;
 	} else {
 		if (!IS_ALIGNED(count, bs))
