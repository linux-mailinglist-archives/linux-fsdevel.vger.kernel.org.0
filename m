Return-Path: <linux-fsdevel+bounces-13316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A6E86E6BE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 18:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39CC2B27878
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 17:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AF8883B;
	Fri,  1 Mar 2024 17:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aEYEwxxz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oWi0rFN8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aEYEwxxz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oWi0rFN8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9789546B3;
	Fri,  1 Mar 2024 17:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709312834; cv=none; b=qD3mBof/dN0pxdrPMgoxfTRH/VZ1nJ+gu2d1lFdKoc+V7xxtIjA1lsczOA8HFHFqH0kT1QiAnrnYNs2Cz5MKIOGfiMLjZld102/pKr0GY9Mvt7ou+civ/9XA9Br03Lek2lqGE0F0WIQ8+v8Md0GSN0KpbhrAAE/WmBewedHLEM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709312834; c=relaxed/simple;
	bh=EPPw3Z+THJ8g+UKlbE+3geV2OTp28OCAl/HgN9Xu6M4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fPRkW2+kHgL3kBaDVOWOlI3VnpI3lM1Vt6JaM9Wb4d9AOHF2rg9xgGXiaQckS4hsjX8oxID4FXz/Y5E5feKAzCKcvjcYDnNYu/5aBO6gBFDaOR453GTvM4sIeSnyMjt1HfaNy5jbep1ySCWHg/8hNC2LEYTAJ3BqGLlzHQX2g9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aEYEwxxz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oWi0rFN8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aEYEwxxz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oWi0rFN8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8B827207B5;
	Fri,  1 Mar 2024 17:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709312830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JWL3xLKHsHdlJnILzpkn8H/KWzQeCNwfHWgrgk6UfkI=;
	b=aEYEwxxzeymsxCReiwtKQ71aPmw2twMkOHoZrO7gi/hwptOpSO8Gkymp1z04EpTRCFQVWM
	bTmkCC3Un7JpF+O/+wsvlSByBPoVv48C5l5FsVL4vfXEYggd2iUfQC/CaHBIdhhl+fY3Us
	VD9IVbnwRmiMXvFLVDfu2vfaXsRrLmU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709312830;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JWL3xLKHsHdlJnILzpkn8H/KWzQeCNwfHWgrgk6UfkI=;
	b=oWi0rFN8PpclO76dABxGHJgaC0Wy6gmCoQYOhTD7BgCRWRS/Rvx3vzNP2POQckCk36pNAT
	L7usYQuHj7ceFPCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709312830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JWL3xLKHsHdlJnILzpkn8H/KWzQeCNwfHWgrgk6UfkI=;
	b=aEYEwxxzeymsxCReiwtKQ71aPmw2twMkOHoZrO7gi/hwptOpSO8Gkymp1z04EpTRCFQVWM
	bTmkCC3Un7JpF+O/+wsvlSByBPoVv48C5l5FsVL4vfXEYggd2iUfQC/CaHBIdhhl+fY3Us
	VD9IVbnwRmiMXvFLVDfu2vfaXsRrLmU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709312830;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JWL3xLKHsHdlJnILzpkn8H/KWzQeCNwfHWgrgk6UfkI=;
	b=oWi0rFN8PpclO76dABxGHJgaC0Wy6gmCoQYOhTD7BgCRWRS/Rvx3vzNP2POQckCk36pNAT
	L7usYQuHj7ceFPCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5928D13A59;
	Fri,  1 Mar 2024 17:07:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id al52FT4L4mUcGQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 01 Mar 2024 17:07:10 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH RFC 0/4] memcg_kmem hooks refactoring and
 kmem_cache_charge()
Date: Fri, 01 Mar 2024 18:07:07 +0100
Message-Id: <20240301-slab-memcg-v1-0-359328a46596@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADwL4mUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDIyNL3eKcxCTd3NTc5HTdxFSzJGNzC8tkSyMTJaCGgqLUtMwKsGHRSkF
 uzkqxtbUAW4jPNmEAAAA=
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Josh Poimboeuf <jpoimboe@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, Kees Cook <kees@kernel.org>, 
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeelb@google.com>, 
 Muchun Song <muchun.song@linux.dev>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.13.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 BAYES_HAM(-3.00)[100.00%];
	 R_RATELIMIT(0.00)[to_ip_from(RL8ogcagzi1y561i1mcnzpnkwh)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[24];
	 FREEMAIL_TO(0.00)[linux-foundation.org,kernel.org,oracle.com,linux.com,google.com,lge.com,linux.dev,gmail.com,cmpxchg.org,zeniv.linux.org.uk,suse.cz];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

Hi,

I have tried to look into Linus's suggestions to reduce slab memcg
accounting overhead [1] [2].

The reorganized hooks are in Patch 1 and it definitely seems like nice
cleanup on its own.

In Patch 2 I have tried to move them to mm/memcontrol.c to reduce calls
to memcg code. I hoped to see better performance, but probably didn't.

Patch 3 introduces the suggested kmem_cache_charge() API and Patch 4
tries to use it for the testcase in [1] but it's unfinished due to my
lack of VFS knowledge.

I haven't done much benchmarking yet, just in a guest VM on my desktop
for the test case from [1]. Applying patches 1+2 might have improved it
slightly, but could be noise. With 3+4 the memcg overhead is gone as
expected (the charging never happens) but due to the unfinished state I
don't know yet if the separation might hurt cases where the open()
actually succeeds.

Anyway thought I would share already so others can play with it and see
if it's a good direction to pursue (with patches 3+4). I think Patch 1
should be good to apply in any case (after more testing, and review),
not yet sure about Patch 2.

[1] https://lore.kernel.org/all/CAHk-=whYOOdM7jWy5jdrAm8LxcgCMFyk2bt8fYYvZzM4U-zAQA@mail.gmail.com/
[2] https://lore.kernel.org/all/CAHk-=whw936qzDLBQdUz-He5WK_0fRSWwKAjtbVsMGfX70Nf_Q@mail.gmail.com/

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
Vlastimil Babka (4):
      mm, slab: move memcg charging to post-alloc hook
      mm, slab: move slab_memcg hooks to mm/memcontrol.c
      mm, slab: introduce kmem_cache_charge()
      UNFINISHED mm, fs: use kmem_cache_charge() in path_openat()

 fs/file_table.c      |   9 +-
 fs/internal.h        |   1 +
 fs/namei.c           |   4 +-
 include/linux/slab.h |  10 +++
 mm/memcontrol.c      |  90 ++++++++++++++++++++
 mm/slab.h            |  10 +++
 mm/slub.c            | 231 +++++++++++++++------------------------------------
 7 files changed, 188 insertions(+), 167 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240229-slab-memcg-ae6b3789c924

Best regards,
-- 
Vlastimil Babka <vbabka@suse.cz>


