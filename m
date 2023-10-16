Return-Path: <linux-fsdevel+bounces-398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 706B97CA808
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 14:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 976E71C20B0D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 12:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D95273FC;
	Mon, 16 Oct 2023 12:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="U5/mdbyK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aZCQJV6U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBD2273D2
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 12:32:47 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF823EB
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 05:32:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 74A571FE53;
	Mon, 16 Oct 2023 12:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1697459563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=RIBjXf78j/jh8+rw0wtKXE5+lD3lQxHQhfKhInHA9ss=;
	b=U5/mdbyKZSNm8yr2ff9CzlMJmZ+/Z0RtwF9z2wSzRgife5Mo1oIeDwHsDyaTF3Tdf3K1Mx
	uSeaQ0eg//h+0nQIcWOgx7tls09IESgSPa5e5VuH9Pjc/39Ibc54+XSkIp1wszzo5Tp9fA
	hy1dhhYWypRBF5KLHqp+7wihWlTAGAs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1697459563;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=RIBjXf78j/jh8+rw0wtKXE5+lD3lQxHQhfKhInHA9ss=;
	b=aZCQJV6Uh/xQNMmfLNmwx/mXCYh8ZtZA/A/G8VhACgkFbdH6IRWv5IHyHKEDsVHPTN+AOB
	NdEsfz1ECDr5rmDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 53764133B7;
	Mon, 16 Oct 2023 12:32:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id iYB+E2stLWVDHwAAMHmgww
	(envelope-from <chrubis@suse.cz>); Mon, 16 Oct 2023 12:32:43 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Cc: Matthew Wilcox <willy@infradead.org>,
	amir73il@gmail.com,
	mszeredi@redhat.com,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 0/4]  Add tst_fd iterator API
Date: Mon, 16 Oct 2023 14:33:16 +0200
Message-ID: <20231016123320.9865-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: 6.91
X-Spamd-Result: default: False [6.91 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_SPAM(0.01)[44.38%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.99)[-0.995];
	 NEURAL_SPAM_LONG(3.00)[1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 FREEMAIL_CC(0.00)[infradead.org,gmail.com,redhat.com,kernel.org,zeniv.linux.org.uk,suse.cz,vger.kernel.org]
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Changes in v2:

 - Changed the API into iterator rather than a funciton callback
 - Added a lot more fd types
 - Added splice test

Cyril Hrubis (4):
  lib: Add tst_fd iterator
  syscalls: readahead01: Make use of tst_fd
  syscalls: accept: Add tst_fd test
  syscalls: splice07: New splice tst_fd iterator test

 include/tst_fd.h                              |  61 ++++
 include/tst_test.h                            |   1 +
 lib/tst_fd.c                                  | 331 ++++++++++++++++++
 runtest/syscalls                              |   2 +
 testcases/kernel/syscalls/accept/.gitignore   |   1 +
 testcases/kernel/syscalls/accept/accept01.c   |   8 -
 testcases/kernel/syscalls/accept/accept03.c   |  47 +++
 .../kernel/syscalls/readahead/readahead01.c   |  54 +--
 testcases/kernel/syscalls/splice/.gitignore   |   1 +
 testcases/kernel/syscalls/splice/splice07.c   |  85 +++++
 10 files changed, 558 insertions(+), 33 deletions(-)
 create mode 100644 include/tst_fd.h
 create mode 100644 lib/tst_fd.c
 create mode 100644 testcases/kernel/syscalls/accept/accept03.c
 create mode 100644 testcases/kernel/syscalls/splice/splice07.c

-- 
2.41.0


