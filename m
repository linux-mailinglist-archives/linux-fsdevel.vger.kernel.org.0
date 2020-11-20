Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 163FD2BA047
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 03:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgKTCWd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Nov 2020 21:22:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33046 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726192AbgKTCWd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Nov 2020 21:22:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605838951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iHQ0gWK07LTNYUo77foAtaIP15zHSFjaroH+HQxSyec=;
        b=VMud9X6fs4daINRI+Kh8x7Dr0onRoIovKTTu8L5tOeV7n9v1J7+YCYvS8CON0nbQ4eScYH
        cof7w+bMsj9pPl22RDGjZyD9W2Dco8YPsUkuq3oFpUBTk0aQrmnaQfhJbPtXqjDaLFLW6Z
        6bhv1VDpl2YG971ZkGqIsf+SWX/gCrA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-EBGgpxt6N2iu0uHQi_8fqg-1; Thu, 19 Nov 2020 21:22:27 -0500
X-MC-Unique: EBGgpxt6N2iu0uHQi_8fqg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0108710059A4;
        Fri, 20 Nov 2020 02:22:26 +0000 (UTC)
Received: from T590 (ovpn-13-9.pek2.redhat.com [10.72.13.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E4DF60853;
        Fri, 20 Nov 2020 02:22:09 +0000 (UTC)
Date:   Fri, 20 Nov 2020 10:22:00 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iov_iter: optimise iov_iter_npages for bvec
Message-ID: <20201120022200.GB333150@T590>
References: <cover.1605827965.git.asml.silence@gmail.com>
 <ab04202d0f8c1424da47251085657c436d762785.1605827965.git.asml.silence@gmail.com>
 <20201120012017.GJ29991@casper.infradead.org>
 <35d5db17-f6f6-ec32-944e-5ecddcbcb0f1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35d5db17-f6f6-ec32-944e-5ecddcbcb0f1@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 20, 2020 at 01:39:05AM +0000, Pavel Begunkov wrote:
> On 20/11/2020 01:20, Matthew Wilcox wrote:
> > On Thu, Nov 19, 2020 at 11:24:38PM +0000, Pavel Begunkov wrote:
> >> The block layer spends quite a while in iov_iter_npages(), but for the
> >> bvec case the number of pages is already known and stored in
> >> iter->nr_segs, so it can be returned immediately as an optimisation
> > 
> > Er ... no, it doesn't.  nr_segs is the number of bvecs.  Each bvec can
> > store up to 4GB of contiguous physical memory.
> 
> Ah, really, missed min() with PAGE_SIZE in bvec_iter_len(), then it's a
> stupid statement. Thanks!
> 

iov_iter_npages(bvec) still can be improved a bit by the following way:

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 1635111c5bd2..d85ed7acce05 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1608,17 +1608,23 @@ int iov_iter_npages(const struct iov_iter *i, int maxpages)
 		npages = pipe_space_for_user(iter_head, pipe->tail, pipe);
 		if (npages >= maxpages)
 			return maxpages;
+	} else if (iov_iter_is_bvec(i)) {
+		unsigned idx, offset = i->iov_offset;
+
+		for (idx = 0; idx < i->nr_segs; idx++) {
+			npages += DIV_ROUND_UP(i->bvec[idx].bv_len - offset,
+					PAGE_SIZE);
+			offset = 0;
+		}
+		if (npages >= maxpages)
+			return maxpages;
 	} else iterate_all_kinds(i, size, v, ({
 		unsigned long p = (unsigned long)v.iov_base;
 		npages += DIV_ROUND_UP(p + v.iov_len, PAGE_SIZE)
 			- p / PAGE_SIZE;
 		if (npages >= maxpages)
 			return maxpages;
-	0;}),({
-		npages++;
-		if (npages >= maxpages)
-			return maxpages;
-	}),({
+	0;}),0,({
 		unsigned long p = (unsigned long)v.iov_base;
 		npages += DIV_ROUND_UP(p + v.iov_len, PAGE_SIZE)
 			- p / PAGE_SIZE;

-- 
Ming

