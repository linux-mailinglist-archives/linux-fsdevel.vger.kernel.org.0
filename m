Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F096767AE4B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 10:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbjAYJmG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 04:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234799AbjAYJmC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 04:42:02 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D631A975
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 01:42:01 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3962A21C83;
        Wed, 25 Jan 2023 09:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674639720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=DpvfxwoTNXK4RkF+RpNdx+AaI6FyxoHy7bR2wGjkeZs=;
        b=xCX6Zc0YBF/chN6gzgOmtIFo/FqbwjO2vMPUT963d1LUgcQBTs4qmoHEwn6+EZDgKlSP6X
        LvAYBjVsP+PM2dnvxKHPl4vSRBtxgxyvvAmx8QBlkoOhKOIy+qByj/1YcD7u43ezg+dBnK
        3siB51A/X0wbbDk45cfMuODr/+ToE9E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674639720;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=DpvfxwoTNXK4RkF+RpNdx+AaI6FyxoHy7bR2wGjkeZs=;
        b=r8/JzyxQkQHsdANXX6r57yJzmMeFmGb3LRmUIF/z47Bgac3QjT/xcEPA5IPmlXXB2Irr9k
        qDCUiTnecqsvZyAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2627A1358F;
        Wed, 25 Jan 2023 09:42:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XOamCGj50GMYIgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 25 Jan 2023 09:42:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 39295A06B5; Wed, 25 Jan 2023 10:41:59 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH v2 0/12] udf: Unify aops
Date:   Wed, 25 Jan 2023 10:41:42 +0100
Message-Id: <20230125093914.24627-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=634; i=jack@suse.cz; h=from:subject:message-id; bh=PFVkD8n6RaOP9BagVLbxuIM8T7/0YqdbqJTuJolGzRU=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBj0PlR7CRBlDhi/yY5ATuFFf/X+DTRymWm8RMttNOL 1UTKe5KJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY9D5UQAKCRCcnaoHP2RA2VN1CA CRkoYAnouhtljxasUG5Kbi7BjI1JUCIs2QsjhC2Rw1GngNBfcS8josTHv06g+cZrmFd0JOt/O0ZEq6 Q3cuokmnsS9uiW1T/9mWyCfQ6x/RVN4x7PV0Y0DZEIaGA3NBtX0ptolPEY9/dgrg8IxvvLzXmADYNM x55mvLMdw3M6YsMZZ8fDI2Y37SpNJaHVo6U/ifaI78tXd91nfoeU5IrPGuWgcBBVOBn7907hnzQwri fy0rvckMd3ojeaKumJgtwVNIx9vAnr7g2lZYxecEAKKVrtYZ52cdjtTmfzG/aRCJgnxQy5GSaBtmFh rbl9nykSrrOjBNyyoDMTkUmZP/b7JF
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

Hello,

this patch series makes UDF use the same address_space_operations for both
normal and in-ICB files as switching aops on live files is prone to races as
spotted by syzbot. When already dealing with this code, switch readpage,
writepage, in-ICB expanding functions from using kmap_atomic() to use
kmap_local_page().

I plan to queue these patches to my tree.

Changes since v1:
* Added Reviewed-by tags from Christoph
* Added cleanup patches for udf_adinicb_writepage() and
  udf_expand_file_adinicb()

								Honza

Previous versions:
Link: http://lore.kernel.org/r/20230124120221.31585-1-jack@suse.cz # v1
