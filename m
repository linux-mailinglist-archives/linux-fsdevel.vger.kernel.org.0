Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E96C1AF462
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Apr 2020 21:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgDRTrb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Apr 2020 15:47:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:48552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727927AbgDRTrb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Apr 2020 15:47:31 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF8C221BE5;
        Sat, 18 Apr 2020 19:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587239249;
        bh=mL2v7gmlY6YkAHHXMOzrKlSQV8Vf0xQE3kzf/miTo1Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LqL40KrjBv/tMd0dgpCqOmCDnDZBp0rKnLFw63kiV1onm9tEYBBmkse2SLh3zcA/H
         C8l1WiDNa0QFzbRYAR6x4UoMjwnq1rhaWauLPdtFQmT7XvNfszS0WdZ3RwTGJ9XGzz
         wClFtb3qbPzT23JrT4XCmyqOuDg4OLZ/nAP8uqD8=
Date:   Sat, 18 Apr 2020 12:47:28 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Phillip Lougher <phillip@squashfs.org.uk>,
        squashfs-devel@lists.sourceforge.net,
        Philippe Liard <pliard@google.com>
Subject: Re: mmotm 2020-04-17-20-35 uploaded (squashfs)
Message-Id: <20200418124728.51632dbebc8b5dbc864cc34f@linux-foundation.org>
In-Reply-To: <319997c2-5fc8-f889-2ea3-d913308a7c1f@infradead.org>
References: <20200418033629.oozqt8YrL%akpm@linux-foundation.org>
        <319997c2-5fc8-f889-2ea3-d913308a7c1f@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 18 Apr 2020 08:56:31 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:

> On 4/17/20 8:36 PM, akpm@linux-foundation.org wrote:
> > The mm-of-the-moment snapshot 2020-04-17-20-35 has been uploaded to
> > 
> >    http://www.ozlabs.org/~akpm/mmotm/
> > 
> > mmotm-readme.txt says
> > 
> > README for mm-of-the-moment:
> > 
> > http://www.ozlabs.org/~akpm/mmotm/
> > 
> > This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> > more than once a week.
> > 
> > You will need quilt to apply these patches to the latest Linus release (5.x
> > or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> > http://ozlabs.org/~akpm/mmotm/series
> > 
> > The file broken-out.tar.gz contains two datestamp files: .DATE and
> > .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> > followed by the base kernel version against which this patch series is to
> > be applied.
> 
> on x86_64:
> 
>   CC      fs/squashfs/decompressor_multi_percpu.o
> ../fs/squashfs/decompressor_multi_percpu.c:75:5: error: conflicting types for ‘squashfs_decompress’
>  int squashfs_decompress(struct squashfs_sb_info *msblk, struct buffer_head **bh,
>      ^~~~~~~~~~~~~~~~~~~

Thanks.  Seems that file was missed.

Also, this code jumps through horrifying hoops in order to initialize
locals at their definition site.  But the code looks so much better if
we Just Don't Do That!



From: Andrew Morton <akpm@linux-foundation.org>
Subject: squashfs-migrate-from-ll_rw_block-usage-to-bio-fix

fix build error reported by Randy

Link: http://lkml.kernel.org/r/319997c2-5fc8-f889-2ea3-d913308a7c1f@infradead.org
Cc: Adrien Schildknecht <adrien+dev@schischi.me>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Daniel Rosenberg <drosen@google.com>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Philippe Liard <pliard@google.com>
Cc: Phillip Lougher <phillip@squashfs.org.uk>
Cc: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 fs/squashfs/decompressor_multi_percpu.c |   17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

--- a/fs/squashfs/decompressor_multi_percpu.c~squashfs-migrate-from-ll_rw_block-usage-to-bio-fix
+++ a/fs/squashfs/decompressor_multi_percpu.c
@@ -72,14 +72,17 @@ void squashfs_decompressor_destroy(struc
 	}
 }
 
-int squashfs_decompress(struct squashfs_sb_info *msblk, struct buffer_head **bh,
-	int b, int offset, int length, struct squashfs_page_actor *output)
+int squashfs_decompress(struct squashfs_sb_info *msblk, struct bio *bio,
+	int offset, int length, struct squashfs_page_actor *output)
 {
-	struct squashfs_stream __percpu *percpu =
-			(struct squashfs_stream __percpu *) msblk->stream;
-	struct squashfs_stream *stream = get_cpu_ptr(percpu);
-	int res = msblk->decompressor->decompress(msblk, stream->stream, bh, b,
-		offset, length, output);
+	struct squashfs_stream __percpu *percpu;
+	struct squashfs_stream *stream;
+	int res;
+
+	percpu = (struct squashfs_stream __percpu *)msblk->stream;
+	stream = get_cpu_ptr(percpu);
+	res = msblk->decompressor->decompress(msblk, stream->stream, bio,
+					      offset, length, output);
 	put_cpu_ptr(stream);
 
 	if (res < 0)
_

