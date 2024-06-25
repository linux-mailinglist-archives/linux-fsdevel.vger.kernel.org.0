Return-Path: <linux-fsdevel+bounces-22308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 157E491651D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 12:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 942F91F21E7F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 10:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5757514A61A;
	Tue, 25 Jun 2024 10:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="07ctzSr9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RXwN9Dc4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="07ctzSr9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RXwN9Dc4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDDA14A0B8
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 10:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719310753; cv=none; b=oOe23uEeWoya8DZKklzDOQyd7e57Ohih89nCDouNczOUkI0oep0qgffY/g+RDvT5z/11dOpAjjwG6QU8EqtdLp8aE2NT9wZh6bwJ8G+kSmz/gyn7nNxCKcfEm06e95eXG0T1W9lwkS2Fk351Y61p7BBbYINcfQjqQy0VTHE9Iug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719310753; c=relaxed/simple;
	bh=XYChyILC+NNnBjJAGjyftxLiSQgE6IXWy3cYnE2wwts=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M7vq3SJi4fBDPH3adnVUoZi4Snma6+G+3lymH1Q+tfsMgiYX2/ijLNIxF1SVyxbv3DMkwCTk/jhreeDZMpy+qHHsvqf3NMab1WKFXvFODKwEv3UBAh4KpEiMV/jIKgMA+zgmCJ07HNJ/VhHt76v/jkHgw5Sd4of7hq1LBfIg2UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=07ctzSr9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RXwN9Dc4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=07ctzSr9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RXwN9Dc4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3A5691F84A;
	Tue, 25 Jun 2024 10:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719310750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2GmFykgSglTbFtSPq+UBfA39HdENaaTIpIBIy80cduQ=;
	b=07ctzSr9hK+cfIkIePnUq+aMkeUURdgZVsE5m0Y1kMK10oHQDVBnkIHGIAow6EQaNHvSVs
	41EG+Cosm4Nd8BLHMoCmWANzs+QZRKrBqXTCsheNBYI+S01RCNKSYB0zKdDgTrgqSVzGmH
	iA4wI/LiDva/YOn3r8CIGs+t6VN9yEg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719310750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2GmFykgSglTbFtSPq+UBfA39HdENaaTIpIBIy80cduQ=;
	b=RXwN9Dc4bn5FW8FlLnqQiqzOT0yC9Gfcm5gN5NDb1juulC9Z69WFItYWcAb/LsGOERF4SS
	lACJyCIbDVvkMLAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=07ctzSr9;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=RXwN9Dc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719310750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2GmFykgSglTbFtSPq+UBfA39HdENaaTIpIBIy80cduQ=;
	b=07ctzSr9hK+cfIkIePnUq+aMkeUURdgZVsE5m0Y1kMK10oHQDVBnkIHGIAow6EQaNHvSVs
	41EG+Cosm4Nd8BLHMoCmWANzs+QZRKrBqXTCsheNBYI+S01RCNKSYB0zKdDgTrgqSVzGmH
	iA4wI/LiDva/YOn3r8CIGs+t6VN9yEg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719310750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2GmFykgSglTbFtSPq+UBfA39HdENaaTIpIBIy80cduQ=;
	b=RXwN9Dc4bn5FW8FlLnqQiqzOT0yC9Gfcm5gN5NDb1juulC9Z69WFItYWcAb/LsGOERF4SS
	lACJyCIbDVvkMLAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2ED9113AC1;
	Tue, 25 Jun 2024 10:19:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5XBHC56ZemZrWQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 25 Jun 2024 10:19:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C17DCA090B; Tue, 25 Jun 2024 12:19:09 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-mm@kvack.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	<linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 0/10] mm: Fix various readahead quirks
Date: Tue, 25 Jun 2024 12:18:50 +0200
Message-Id: <20240625100859.15507-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=762; i=jack@suse.cz; h=from:subject:message-id; bh=XYChyILC+NNnBjJAGjyftxLiSQgE6IXWy3cYnE2wwts=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBmepmGibRbZQ36hUn3IdiOgehL9CXgwUz8UI9BX+ME cCNMtSSJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZnqZhgAKCRCcnaoHP2RA2fyaB/ 4mH3pD5t6p3KoivIJdND9vpf5+u3yKKci5UT1IWZCKe1+KDdGZMjWmMZJKRbF3HEYmeiX9c4QYKdc2 nsoWuIfIwCv1b4DN7qzmoOXryQ6y8QPuQyuG5JmUhLLT8Zm0kLGGbGp7+J326ZidUW3uug/tGgerAS o1V+2i6eHFseLO7zOTNZeiVFHotunUOTvHNy1tOW+/smZcgySWnkHkaAA5LewesFr3TnWTVkGvbPzi sspFIXOiA/7+brysZiXvowUqWCSxBAhbH/ArYf8EtIbZtdG1nTMz0jQIqMneMJ5zxdeoPMwmTV5f7k XQ2wQFzGOIXG+i2OVH6jBs4GSYZCm4
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3A5691F84A
X-Spam-Score: -2.47
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.47 / 50.00];
	BAYES_HAM(-2.46)[97.53%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Hello!

When we were internally testing performance of recent kernels, we have noticed
quite variable performance of readahead arising from various quirks in
readahead code. So I went on a cleaning spree there. This is a batch of patches
resulting out of that. A quick testing in my test VM with the following fio
job file:

[global]
direct=0
ioengine=sync
invalidate=1
blocksize=4k
size=10g
readwrite=read

[reader]
numjobs=1

shows that this patch series improves the throughput from variable one in
310-340 MB/s range to rather stable one at 350 MB/s. As a side effect these
cleanups also address the issue noticed by Bruz Zhang [1].

								Honza

[1] https://lore.kernel.org/all/20240618114941.5935-1-zhangpengpeng0808@gmail.com/

