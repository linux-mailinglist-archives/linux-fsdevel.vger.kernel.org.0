Return-Path: <linux-fsdevel+bounces-15304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C572888BFBB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 11:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F529B28F3B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 10:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8C6DF60;
	Tue, 26 Mar 2024 10:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZAEQgCf0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7zJNoC+L";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ud1TRv2p";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0CTqKxX/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35C328F5;
	Tue, 26 Mar 2024 10:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711449475; cv=none; b=XThkQFLzJdcyST5Wj406BP8UFUZbupAcrd9Wi5SWdyGQ5SY+3m2F3YxOElWWsZu0vSn4INkcWWlPyhC3xAz9QYhqxUwdYEceN10qJ30AGWeSLkLJCzOuanw6zjQEFUSrR+21S2SHicitVPYnQQR3rYf9x5ifuH1szRXZQJr/br4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711449475; c=relaxed/simple;
	bh=i5VkI5Vkq06KmHIpTmrcQaLqlJGWrDYJC+xTe+WvYeE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kh8z2Zeb9K+jcin7OQfwvFmt9e0pv/6WmDBcKikonGe4jqsmLL9mMt6CyylU3cPlmbztLcG1IHBISSsGu72RrxHt4C2RazyBApsXz0aOXIas+P9Eqito3cwseBvAcq0Vp+H9uWTfB4dKDW8KczaGBSBhM9UaFKbQgDnVwTVvN+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZAEQgCf0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7zJNoC+L; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ud1TRv2p; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0CTqKxX/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1135B5D476;
	Tue, 26 Mar 2024 10:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711449472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xFKJNhpnzp0AKoq96kFDbv4mXXq4QGMcRz3k1/t1nbw=;
	b=ZAEQgCf0xP+1WTbhGzvCx0N5HCXsqm4W3xkptWV4AiDzN+g1kWr/rjpDFHRsOmG97PrYFz
	A6cgcb46b2nxybGTl+WniCsRMtCRQTo/2I+ljqGAWbIWAZ67jnXXKzl9oAC+AZGQTM1eCd
	JpfYd7RxFE08rJULyG7NPD+pgJQYcI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711449472;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xFKJNhpnzp0AKoq96kFDbv4mXXq4QGMcRz3k1/t1nbw=;
	b=7zJNoC+LX4Nst+r5sC7ffo3ajZfVJG/kVBN4J/M5ajNhhSfqoBmRPFh8snzx7yaHpIfFeN
	SUgplNt+ut5CRLBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711449471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xFKJNhpnzp0AKoq96kFDbv4mXXq4QGMcRz3k1/t1nbw=;
	b=ud1TRv2pS/pjHnuGLM8Hbwvi16oFEgdTJpXG+jcRZwGQxyCQ3nYBbQyjMreGXGGWfRqeVA
	cWfGyuO+rhuxe3RbZUTqX8e55oVF/vFrX3/L8NYc83+IWq2TQv1IJjTowUrhV50jQ0jOPx
	h2030kqolbYNHfQIZLgmJ6eGsrpU6tg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711449471;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xFKJNhpnzp0AKoq96kFDbv4mXXq4QGMcRz3k1/t1nbw=;
	b=0CTqKxX/0WLBhNqjioNHawUygsWsnbieaYseiXXnyGkW/JKszW8gGhronrTTqWYIEsvyA8
	EabVzAUkaZmy7qBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF5FD13306;
	Tue, 26 Mar 2024 10:37:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XVI4Nn6lAmb/AwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 26 Mar 2024 10:37:50 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH mm-unstable v3 0/2] memcg_kmem hooks refactoring
Date: Tue, 26 Mar 2024 11:37:37 +0100
Message-Id: <20240326-slab-memcg-v3-0-d85d2563287a@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHGlAmYC/1WNQQ7CIBREr9KwFkM/UIsr72FcUPy2JNIafkvUp
 neXsKrLycx7szLC6JHYuVpZxOTJT2MO8lAxN9ixR+7vOTMQoASA4fS0HQ8YXM8tNp08tcYZUCw
 Dr4gP/y6yKwuBLyPNtnsiu+Vy8DRP8VOOUl0mxSlFvXemmgsutZHQWtVo01xoITy6b5Ek2IGg/
 0DIoBHCKt2ClHYHbtv2A6YkSkjoAAAA
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Josh Poimboeuf <jpoimboe@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, Kees Cook <kees@kernel.org>, 
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Shakeel Butt <shakeel.butt@linux.dev>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Vlastimil Babka <vbabka@suse.cz>, Chengming Zhou <chengming.zhou@linux.dev>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1398; i=vbabka@suse.cz;
 h=from:subject:message-id; bh=i5VkI5Vkq06KmHIpTmrcQaLqlJGWrDYJC+xTe+WvYeE=;
 b=owEBbQGS/pANAwAIAbvgsHXSRYiaAcsmYgBmAqV1GxKBUCDhBSTpe5W0QwzKmgevtIOe4qqLw
 hflE8BHJUCJATMEAAEIAB0WIQR7u8hBFZkjSJZITfG74LB10kWImgUCZgKldQAKCRC74LB10kWI
 mjeMB/9YU5KuZdznvPyrc9tY1MuE8LIvaMpCLWN3ffSBWnKA0qbyynTW6+i+82LyZttXnLEFKqj
 5KgdycAmUx2SS1EwP8HtGGTg5IVJ9CBmjkeFx6aWK0vWgmMiQhrhZW5eTCfQ+rpibcng48hn+2p
 zlcioAfQcWoTdqs62+blXDnm1NESt2Ffc0BE8TktLGsKa/NUdHoTh1tuehwli5Fpe4UHAwLr0t9
 IKDt2JbG6TaNj8kAvy96bDikh3WxjaQBwB9xBBkiY8W/kQiVYEu+XepbQNDeDvnufBI8j/KMoEK
 L2HSYsSiI0KOu20+ddYGocWlHqluTuoyJ7VehN0gZhiWpZ71
X-Developer-Key: i=vbabka@suse.cz; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ud1TRv2p;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="0CTqKxX/"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.07 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLduzbn1medsdpg3i8igc4rk67)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[linux-foundation.org,kernel.org,oracle.com,linux.com,google.com,lge.com,linux.dev,gmail.com,cmpxchg.org,zeniv.linux.org.uk,suse.cz];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-0.06)[61.11%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[25];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -0.07
X-Rspamd-Queue-Id: 1135B5D476
X-Spam-Flag: NO

Hi,

sorry for a v3 that soon after v2. I initially planned to just merge the
v2 to the slab tree later this week, but then I checked and the
conflicts with mm tree would be too tedious (mainly due to memory
allocation profiling series). Also large part of this is in memcontrol.c
and further work in there might be based on this, so it's easier to just
go via mm tree.

So this is just a rebase on top of mm-unstable so it can be included
there. Thanks.

Vlastimil

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
Changes in v3:
- rebased on v2
- Link to v2: https://lore.kernel.org/r/20240325-slab-memcg-v2-0-900a458233a6@suse.cz

Changes in v2:
- rebase to v6.9-rc1
- add reviewed-by's to patches 1+2
- drop patches 3+4 (kmem_cache_charge() and usage in vfs)
- Link to v1: https://lore.kernel.org/r/20240301-slab-memcg-v1-0-359328a46596@suse.cz

---
Vlastimil Babka (2):
      mm, slab: move memcg charging to post-alloc hook
      mm, slab: move slab_memcg hooks to mm/memcontrol.c

 mm/memcontrol.c |  90 +++++++++++++++++++++++++
 mm/slab.h       |  13 ++++
 mm/slub.c       | 205 +++++++++++---------------------------------------------
 3 files changed, 143 insertions(+), 165 deletions(-)
---
base-commit: 4aaccadb5c04dd4d4519c8762a38010a32d904a3
change-id: 20240229-slab-memcg-ae6b3789c924

Best regards,
-- 
Vlastimil Babka <vbabka@suse.cz>


