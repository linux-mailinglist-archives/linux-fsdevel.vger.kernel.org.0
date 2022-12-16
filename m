Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6329C64EDDA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Dec 2022 16:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbiLPP1N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Dec 2022 10:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbiLPP1E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:27:04 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637DD62EB4
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Dec 2022 07:27:01 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 25C1C343E0;
        Fri, 16 Dec 2022 15:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671204420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RtZDqPTIPcN8aJoC0gDbJlIekS5WoY9vlT+wGotDhzg=;
        b=qZH4NGo0CUIyOPPdjE7J/RolhuRk2miVqovejvLBnHAC7+a0FoJGfo0snkrriIAvrOTj9K
        ixVgp6tI65zFSPDeNsh33yZha8+7NsSPDTPySfVmgDLPi3ehsCnBYyxfa/DxmNMBVMXxaO
        jRNjLUNvr9MdlEITHQZoJwL6bqImh4U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671204420;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RtZDqPTIPcN8aJoC0gDbJlIekS5WoY9vlT+wGotDhzg=;
        b=4H7UNancJNaadX/JX/8V+Zdw38VXTK/ttRYmem7fGSsmtlD6iti0Or+exTAmo8gLhFKAL+
        KB4fkd68SpjJAECw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E104513904;
        Fri, 16 Dec 2022 15:26:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id otwxNkOOnGO5CAAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 16 Dec 2022 15:26:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 72117A0729; Fri, 16 Dec 2022 16:26:56 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 01/20] udf: Define EFSCORRUPTED error code
Date:   Fri, 16 Dec 2022 16:24:05 +0100
Message-Id: <20221216152656.6236-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221216121344.14025-1-jack@suse.cz>
References: <20221216121344.14025-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=568; i=jack@suse.cz; h=from:subject; bh=KhyP9/HzSm5gxIulNZBTH8WPpjVVn+OWgFAu5E9Jq3E=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjnI2W2sF4yQa3HI4gpN9Amz1vCZkyGXY9jzJkysXs KFSp/PuJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY5yNlgAKCRCcnaoHP2RA2XzpCA Dn9dUS3BwHrpxwwg0winFzkdjHuZHaxpxMYqPA4T2sjzDJSeZYkLS9DnJiOnaXPqujOmYYJhxqi9pM Uit0maPgDEjDcoOkk2A0bkx6/QJSs+9GtvWUXLJQaylWMoGLHy0irDFc+zjsFr/kZ2C/pPCY2+qabg c/4qBkzp70G4nBemzarKlOTuxes9w06Euw1PJoKQa6RrxPGSjlnafOUyR6Sq0Mebo7CBy7MFMvT2Px a8m5ZBc/SfxgpFPxYSCKGXPJ13JGIN1nqJaCeFhVff+gcp+vZrY3VMtoZkjz7q/l5cB0BFSt2QUBDA rMlwa9KNXNXdH/PPbmbMsLPkT3zocu
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

Similarly to other filesystems define EFSCORRUPTED error code for
reporting internal filesystem corruption.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/udf_sb.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/udf/udf_sb.h b/fs/udf/udf_sb.h
index 291b56dd011e..6bccff3c70f5 100644
--- a/fs/udf/udf_sb.h
+++ b/fs/udf/udf_sb.h
@@ -55,6 +55,8 @@
 #define MF_DUPLICATE_MD		0x01
 #define MF_MIRROR_FE_LOADED	0x02
 
+#define EFSCORRUPTED EUCLEAN
+
 struct udf_meta_data {
 	__u32	s_meta_file_loc;
 	__u32	s_mirror_file_loc;
-- 
2.35.3

