Return-Path: <linux-fsdevel+bounces-15192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A4688A292
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 14:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21ECA1C38E4B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 13:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0452C14C585;
	Mon, 25 Mar 2024 10:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xzZ18pVo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gZ60F7px";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xzZ18pVo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gZ60F7px"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F6614EC54;
	Mon, 25 Mar 2024 08:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711354870; cv=none; b=chM1ELC1b8iagtou/z4VYUpOQzIqSM6eYowq7zQMm4PkOvfVHDIYFnE6iaTab8y7XKhsYCrAEWazu28WDpZcZVWbC0bMNSpp8ac5Z3Jm7s14zLs/6dCZelP0Mr8Asif4N2oNYaxiB7aMM121vJneaM060xH3vxSj3T+txE466ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711354870; c=relaxed/simple;
	bh=Do5RGFON79BZo5EODGYKbFfems4SE+esrkAYSwRAjn8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aWhL8dPYr1W/8w+6zJXa/10m1m/zFbJiooGicny58eZqnnKrUTXY+c1zix+/oGQoBpz0Sa9ND87Fd04wPReQxkUeo9RK0BioJxZK2WdW7uAtaMQzrQp1APISVn44OLA1poKwZYqE4aZ59OByBvA2p/BX/LtFjZQ9UQDuOYeJJZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xzZ18pVo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gZ60F7px; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xzZ18pVo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gZ60F7px; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6BA7E5C3FD;
	Mon, 25 Mar 2024 08:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711354865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RpfJF9YPIRTCVRvpa1RnbtB6JDDMaGcncw0S5jxMQ5g=;
	b=xzZ18pVoNkcF9rE1+uQav0CXPCZ1fnp5OwpTyQzRJKpYVRcJ5ksdPyTtmXPcnNvCGunX74
	+Ymxs2/P0Q5ICCBS3XzORaiE7Pyrq4EJaVNvHXqH/gE6xfH7KQC3Vg7uodykwLbwLkl5kC
	hgbwFOkKrKavXvlqdQ5YuwMgdH6fizc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711354865;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RpfJF9YPIRTCVRvpa1RnbtB6JDDMaGcncw0S5jxMQ5g=;
	b=gZ60F7pxpMO8PzBei7Wx46WtPwjT9p0rwP2eVPLiBRxRa8C9BJkGM++P6tOOzeJbxBuRNq
	tk7W2E5JqQDAdpCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711354865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RpfJF9YPIRTCVRvpa1RnbtB6JDDMaGcncw0S5jxMQ5g=;
	b=xzZ18pVoNkcF9rE1+uQav0CXPCZ1fnp5OwpTyQzRJKpYVRcJ5ksdPyTtmXPcnNvCGunX74
	+Ymxs2/P0Q5ICCBS3XzORaiE7Pyrq4EJaVNvHXqH/gE6xfH7KQC3Vg7uodykwLbwLkl5kC
	hgbwFOkKrKavXvlqdQ5YuwMgdH6fizc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711354865;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RpfJF9YPIRTCVRvpa1RnbtB6JDDMaGcncw0S5jxMQ5g=;
	b=gZ60F7pxpMO8PzBei7Wx46WtPwjT9p0rwP2eVPLiBRxRa8C9BJkGM++P6tOOzeJbxBuRNq
	tk7W2E5JqQDAdpCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4105413503;
	Mon, 25 Mar 2024 08:21:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tjxMD/EzAWZdHgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 25 Mar 2024 08:21:05 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v2 0/2] memcg_kmem hooks refactoring
Date: Mon, 25 Mar 2024 09:20:31 +0100
Message-Id: <20240325-slab-memcg-v2-0-900a458233a6@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM8zAWYC/03Myw6CMBCF4Vchs7amTKFSV76HYVHqCE3kko42K
 um7W3Hj8j/J+VZgCp4YjsUKgaJnP085cFeAG+zUk/CX3IASK4loBN9sJ0YaXS8s6U4dGuMMVpA
 PS6Crf27Yuc09eL7P4bXZsfyuP0bJ8p+JpZBC1UZhYytdG33iB9PevaFNKX0Aet5RfaIAAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1147; i=vbabka@suse.cz;
 h=from:subject:message-id; bh=Do5RGFON79BZo5EODGYKbFfems4SE+esrkAYSwRAjn8=;
 b=owEBbQGS/pANAwAIAbvgsHXSRYiaAcsmYgBmATPZX3NtjLD+0T3mwtrWkT3/UFdtMA8OxHXmv
 8xLDTlJutGJATMEAAEIAB0WIQR7u8hBFZkjSJZITfG74LB10kWImgUCZgEz2QAKCRC74LB10kWI
 mo/GB/0aRHVq8/FkwfqNxC442Q7bc8rhp0GrFMU27CQMBmm8mkvvB8z14B7XXk8P64wJhQgq477
 5jA+T8c/SiwvK3HSBiLgH5ZLnkzT7pjw0xkH453d5+biJCaGaPOnekC39H+7oRVMTNfYNLppHag
 x5ChJ1NkXKo8XTVutsY9ZYjPLD6vW9B0JOAcm08F6z5AYslOYk92Hc1F6jADx4rPv+m8kGSB6SW
 VfuPvE1fBxDCMcvApyARzetmpzJiZ8NGCrLl8E6a0B6jAzZiWQLndm2vxQ96Ccopp8vV8b6Zgme
 LWKuSW7YvMAvSWiJleKgvpfJQk9aXAduDBtHMqYYVqc2/JcV
X-Developer-Key: i=vbabka@suse.cz; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.19
X-Spamd-Result: default: False [0.19 / 50.00];
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
	 BAYES_HAM(-0.01)[48.92%];
	 R_RATELIMIT(0.00)[to_ip_from(RL8ogcagzi1y561i1mcnzpnkwh)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[25];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FREEMAIL_TO(0.00)[linux-foundation.org,kernel.org,oracle.com,linux.com,google.com,lge.com,linux.dev,gmail.com,cmpxchg.org,zeniv.linux.org.uk,suse.cz];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

Hi,

this is v2 of the memcg_kmem hooks refactoring (RFC/v1 link at the end).
This just rebases the refactoring patches 1 and 2 so they can start to
be exposed to -next and other work on can base on that.  I'm not
including the kmem_cache_charge() patch here until we have a more
finished user than my previous unfinished attempt.

Vlastimil

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
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
 mm/slab.h       |  10 +++
 mm/slub.c       | 202 +++++++++++---------------------------------------------
 3 files changed, 138 insertions(+), 164 deletions(-)
---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240229-slab-memcg-ae6b3789c924

Best regards,
-- 
Vlastimil Babka <vbabka@suse.cz>


