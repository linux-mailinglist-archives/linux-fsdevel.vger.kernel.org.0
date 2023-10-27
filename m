Return-Path: <linux-fsdevel+bounces-1383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C257D9DE9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 18:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 808A21C21090
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 16:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119DB38F90;
	Fri, 27 Oct 2023 16:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qMfNeXBS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ewr59R7h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37A538BCE
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 16:23:46 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FDF10A
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 09:23:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C92D721B2A;
	Fri, 27 Oct 2023 16:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1698423823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3SY9NES8rkMFBEGIshYajST+LdpDBSPmtf6Ugk2YOTE=;
	b=qMfNeXBSIhQn7EOzStgxDAquTTxa/o/8MmWcjdXOQNJ+e3T4SlAjUoMU0zDl63H84KIjmv
	zexUSbO5FvGBcEsdmofzyZURZJ0g6wd9wfE1oMIslvGRq4h4OvObuYmT7YW3Z7xS5RggKv
	3y++Lk6bBoIxacWu7v5bgqail4ZiTIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1698423823;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3SY9NES8rkMFBEGIshYajST+LdpDBSPmtf6Ugk2YOTE=;
	b=ewr59R7hnaexc/ZdJn6Pk8jcQAkJWNFBKPgN3KSh4UTgfS/AdWSPVy0RUycEzsnGtn56Di
	HMxxxyXTD60mE2Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B2E7E13524;
	Fri, 27 Oct 2023 16:23:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id M8cfKw/kO2X4NgAAMHmgww
	(envelope-from <jack@suse.cz>); Fri, 27 Oct 2023 16:23:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 33B5CA05BC; Fri, 27 Oct 2023 18:23:43 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Jan Kara <jack@suse.cz>
Subject: [PATCH 0/3] quota: Remove BUG_ONs from quota code
Date: Fri, 27 Oct 2023 18:23:36 +0200
Message-Id: <20231027161930.27648-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=312; i=jack@suse.cz; h=from:subject:message-id; bh=o2ZvDBFtGmH3LCbCoLB9nFLnqRY133xDqVMOf8OQzY4=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlO+QAaX52b1F3Lwukr3mwmMyVp5wk3HjrrYsmETye E/5kwH2JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZTvkAAAKCRCcnaoHP2RA2S6/CA DwKcMkomJTmxdTPeMo3yHmp+tNgcy5JqBn+Im4MGiZPqwCPuGTXcfwWDXtMwW+dqx1wsYCucKEpxFr v4V6p9Im2iimJJ/N7l7hq1dAIno2VaYWRQVxD873ixf/D3ZEoN5z0eQ86ydyKQHZPUuFrqFEz3CN0O Rtl2D7xzRWMRJDGmBFqD+mUIOXwsbq4aP+aWQH4mKHB4oyJFCnijBuGw30giK/g7Xe65oPWOg6yA1b LT0RzKcSLs3rTEk1Oc938jnESD+iloneDft7Fvlt/zfdG8A5VoOdBrjQaPgzbyR6lCwDm8acYAcP3r RubdDUiYnov6Cj0tDI85AwWrcHhchY
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.44
X-Spamd-Result: default: False [0.44 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.46)[79.13%]

Hello,

as has Linus notice there are several BUG_ONs in quota code that have the
potential of taking the whole machine down and they are mostly unnecessary.
This patch series changes them to WARN_ON_ONCE() and adds error handling
where appropriate. I plan to queue the series to my tree.

								Honza

