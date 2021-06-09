Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538603A1C7E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jun 2021 20:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbhFISIc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Jun 2021 14:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhFISIc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Jun 2021 14:08:32 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F70C061574;
        Wed,  9 Jun 2021 11:06:37 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lr2au-006Jht-FM; Wed, 09 Jun 2021 18:06:24 +0000
Date:   Wed, 9 Jun 2021 18:06:24 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [RFC PATCH 16/37] iov_iter_gap_alignment(): get rid of
 iterate_all_kinds()
Message-ID: <YMEDIBUnZhhLUEXg@zeniv-ca.linux.org.uk>
References: <YL0dCEVEiVL+NwG6@zeniv-ca.linux.org.uk>
 <20210606191051.1216821-1-viro@zeniv.linux.org.uk>
 <20210606191051.1216821-16-viro@zeniv.linux.org.uk>
 <fc95d524-3e61-208d-52af-8ad0048fd76e@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc95d524-3e61-208d-52af-8ad0048fd76e@quicinc.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 09, 2021 at 09:01:36AM -0400, Qian Cai wrote:

> On 6/6/2021 3:10 PM, Al Viro wrote:
> > For one thing, it's only used for iovec (and makes sense only for those).
                        ^^^^^^^^^^^^^^^^^^^

[snip]

> > -	if (unlikely(iov_iter_is_pipe(i) || iov_iter_is_discard(i))) {
> > +	if (unlikely(iter_is_iovec(i))) {
                     ^^^^^^^^^^^^^^^^
This.  A nice demonstration of braino repeatedly overlooked on read-through,
especially when the change described in commit message is obvious and
looks similar to the change done in the patch.

Happens without any deliberate attacks involved - as the matter of fact,
it's easier to spot that kind of crap in somebody else's patch...

Anyway, the obvious fix (
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 3a68f578695f..6569e3f5d01d 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1402,10 +1402,8 @@ unsigned long iov_iter_gap_alignment(const struct iov_iter *i)
 	size_t size = i->count;
 	unsigned k;
 
-	if (unlikely(iter_is_iovec(i))) {
-		WARN_ON(1);
+	if (WARN_ON(!iter_is_iovec(i)))
 		return ~0U;
-	}
 
 	for (k = 0; k < i->nr_segs; k++) {
 		if (i->iov[k].iov_len) {
) folded in and pushed...
