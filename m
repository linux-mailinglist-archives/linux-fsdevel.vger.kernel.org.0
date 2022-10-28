Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3A3610814
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 04:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbiJ1CeV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Oct 2022 22:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235884AbiJ1CeP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Oct 2022 22:34:15 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEE2BCBAE;
        Thu, 27 Oct 2022 19:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=2hrSO3obB1hPkB2I0g2avezDzM2fxuFWF0A6F6V6oiI=; b=Njb6lBV8/KytFxKCtx4nRVXc9F
        kg32OMF1Dar/iY6MkQvzhWxWZtBBEFetkJQxWiAiI/owJl+iRKMz5cOL5TqFy2mRFA1DzuzA2r/S6
        LP5e5IEPI+ERoRpojDceUxwo8DfhigLXuHI4eio7JFbAM5SUuG23YpV/Ss0TTIM5MpAvJM7n6ARpg
        6JtR8E6iGH4bZNs1mZpch6H3+d4gSj7PMw8UH3NDV/1vbHj6CN2uwV9yB21pC4o8JtEPVCqQLg5Vf
        Qg0u3NufIClP+vM5uoUQsaK8LEJYGdcCnv0j04wGYT/QOpm1vEAMIbO8DE1HH+FEsJvhjaV3nNwJb
        1244xkZQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ooFBw-00EorB-1H;
        Fri, 28 Oct 2022 02:33:52 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>, willy@infradead.org,
        dchinner@redhat.com, Steve French <smfrench@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>, torvalds@linux-foundation.org,
        linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/12] csum_and_copy_to_iter(): handle ITER_DISCARD
Date:   Fri, 28 Oct 2022 03:33:42 +0100
Message-Id: <20221028023352.3532080-2-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221028023352.3532080-1-viro@zeniv.linux.org.uk>
References: <Y1btOP0tyPtcYajo@ZenIV>
 <20221028023352.3532080-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Not hard to implement - we are not copying anything here, so
csum_and_memcpy() is not usable, but calculating a checksum
of source directly is trivial...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index e9a8fc9ee8ee..020e009d71c5 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1549,8 +1549,12 @@ size_t csum_and_copy_to_iter(const void *addr, size_t bytes, void *_csstate,
 	__wsum sum, next;
 
 	if (unlikely(iov_iter_is_discard(i))) {
-		WARN_ON(1);	/* for now */
-		return 0;
+		// can't use csum_memcpy() for that one - data is not copied
+		csstate->csum = csum_block_add(csstate->csum,
+					       csum_partial(addr, bytes, 0),
+					       csstate->off);
+		csstate->off += bytes;
+		return bytes;
 	}
 
 	sum = csum_shift(csstate->csum, csstate->off);
-- 
2.30.2

