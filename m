Return-Path: <linux-fsdevel+bounces-75-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1757C57AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 17:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2F1D1C20F8B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 15:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B09220306;
	Wed, 11 Oct 2023 15:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T9TgFNI9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="C9D/lfHk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289A21F17E
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 15:02:57 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA388B8
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 08:02:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3CDEF21846;
	Wed, 11 Oct 2023 15:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1697036573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=awXeHnzKVNgiS0Fzf1SiO3ohSbJ6lvsHSccL6Y9Lfiw=;
	b=T9TgFNI9IvH0yoBj/RX6cgvAyEiLl7rJM0FHVLjWXEKyLYj6q8K6vrV9zzBm9z/n2TihIx
	uQmYaEfLZ2mPfnxbl9lcRy8HOsmutEV/LbFg1O/MVcDq4bZrpt1e2dXYzbXuz1wDyEpZfM
	c9/c9rHm9MJGSzMDWFMP+SjynFfzXsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1697036573;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=awXeHnzKVNgiS0Fzf1SiO3ohSbJ6lvsHSccL6Y9Lfiw=;
	b=C9D/lfHkE5ik/SXYaKWQvUKuq2+tx+9VIONB7S2vVhrgInJqA4agmQVnWHQnZfqmBX84PS
	ZoXRX81McZClrtDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2BEBE13A7A;
	Wed, 11 Oct 2023 15:02:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 7OCzCh25JmVUfwAAMHmgww
	(envelope-from <jack@suse.cz>); Wed, 11 Oct 2023 15:02:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8CA1AA05BC; Wed, 11 Oct 2023 17:02:52 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Yury Norov <yury.norov@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Matthew Wilcox <willy@infradead.org>,
	<linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 0/2] lib/find: Fix KCSAN warnings in find_*_bit() functions
Date: Wed, 11 Oct 2023 17:02:30 +0200
Message-Id: <20231011144320.29201-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=506; i=jack@suse.cz; h=from:subject:message-id; bh=1TMdpQ6RN5svq7kefEVUUKEJS/qQcpAhqNC3wezb0+A=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlJrj/zZWF7VQtk/I4WScNts1+yKOPtp3PKyM8ahsv rpGDqguJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZSa4/wAKCRCcnaoHP2RA2U7BCA CoTyRn1ja1GE0IAz9Fle4g7iO5elazQbrBa+YUx+gmb4MoyOyzFg7Mw/7/gu3N02GQXiLwrLILFFNq DK8yXoPSSqaYhWo5IvMBINe5sk5RJRXU1gY8Eo+ZL03cB/oLi7VEISbadShvbnZN+7riBCEKuatpdF 87qxmCshQTZyruH6slaqBTm6E5yL5/kmtYPUkpDyIh9ro9ZXAWnFl45LhBklyK8iTOuj+D98r3Xur4 29r6QI+WdEVD44OZnWZsUKC/Mnl6BhLvni/oAb7ZRK+2DKLvYuP4Za17Shw8cb/Nx9RKbuJ3B81VsC 4e2BL9Y7sz4UptKKdHi5GX3yoc3hbq
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 6.40
X-Spamd-Result: default: False [6.40 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_SPAM(0.00)[22.07%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

KCSAN issues a lot of warnings for various find_*_bit() functions. This is
because some users (such as xarray) use these functions without protection from
concurrent modifications (e.g. xarray tag searching is protected only by RCU)
and find_*_bit() implementations are indeed prone to refetching values from
memory with undefined results. This series fixes these problems. See patch 1
for more details.

Mirsad, can you give these patches testing on your setup? Thanks!

								Honza

