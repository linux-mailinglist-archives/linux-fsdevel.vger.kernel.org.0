Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7998067AE4C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 10:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbjAYJmH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 04:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235003AbjAYJmD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 04:42:03 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEE22716
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 01:42:02 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2C69A21C75;
        Wed, 25 Jan 2023 09:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674639721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fKZCg56SLXKhpJFJJrYRNWhwGQPw+NL+HfCTPmmGANk=;
        b=c+OtSO9IQIAjwaM7ZiF+Ed6xzjnN9Wlyk9bzTwXqK6cJoOkvB/GuMc+3ilHKsOEkeUhQF5
        LzWea5OnDP9ZRIZd3yjCqyWO/UZVkx8FMIyJhaw5J1MUKwVwnj2R7a1Lpo7lQUl+Nrqo8j
        w65BtowmDuTXsPz4AmQXXgEdHaU0QKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674639721;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fKZCg56SLXKhpJFJJrYRNWhwGQPw+NL+HfCTPmmGANk=;
        b=ZezVwK2EmUFVVsFDS3MJ/sO+hGZJFwzIMtsurWWI9119rpYQBNJUfhOO8ePltcSD5sJIi5
        jqgwJDT/Lrt0mbAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0629D13A06;
        Wed, 25 Jan 2023 09:42:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qGl8AWn50GMjIgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 25 Jan 2023 09:42:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5B35AA06D1; Wed, 25 Jan 2023 10:41:59 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 06/12] udf: Add handling of in-ICB files to udf_bmap()
Date:   Wed, 25 Jan 2023 10:41:48 +0100
Message-Id: <20230125094159.10877-6-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230125093914.24627-1-jack@suse.cz>
References: <20230125093914.24627-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=808; i=jack@suse.cz; h=from:subject; bh=SG93GLCqJUSys5SPhE0AZ913xuFOg4SurHldDmQy7kk=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBj0PlcWCIq7YQTR1W8KTJ12QvKCanYkbMoBf/mYakQ ze23vhGJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY9D5XAAKCRCcnaoHP2RA2duqCA CnS2iKLUMbHEUlZSx2Ud0wEJ3E6NHilOytX7w6I5HAbb4oiD9M7h4sDK75boRbCxKXBCkgQhztAZKj 6Jd8PU0hEAnakfyyxDSLHOic7IRnsgrWlSKjiSp0hMj04kq9HbrONKXn8UfkSYfEWEqLOUTfIXZR8a Y7O3ZSfb7kdzFL63e8HHEeX2Jn6ZmwhEdjvrGJLX82Ci9Q+5C2jOgSXD8lpHmAKfE092mH79SrtB5A XEeuBVYoX3rrRsLju1xrUaqrv9DZnZkb+zU4va2XF3Issy18OdRUxnUQsg+dQOpn3/dLe9UqnDbXTV mGHgQorrtsWtphnWI73GX+WtGuk26t
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add detection of in-ICB files to udf_bmap() and return error in that
case. This will allow us o use single address_space_operations in UDF.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index ac00f2f5dbe3..08788f4dab18 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -296,6 +296,10 @@ ssize_t udf_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 
 static sector_t udf_bmap(struct address_space *mapping, sector_t block)
 {
+	struct udf_inode_info *iinfo = UDF_I(mapping->host);
+
+	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB)
+		return -EINVAL;
 	return generic_block_bmap(mapping, block, udf_get_block);
 }
 
-- 
2.35.3

