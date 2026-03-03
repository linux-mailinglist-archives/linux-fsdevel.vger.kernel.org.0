Return-Path: <linux-fsdevel+bounces-79140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCJqGfC5pmk7TAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:37:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2721ECC07
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69EFD312F700
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 10:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D16E39D6EE;
	Tue,  3 Mar 2026 10:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lqMqPkPW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iVUDLfIF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lqMqPkPW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iVUDLfIF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6103E39B965
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 10:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772534084; cv=none; b=WxqDA/fp6adgszEtpDHhKi526bXJ2xLiLpWonS6zmDJXLZTjw8HAVNarC/cvjOegKPDLgrBOWc4VpeBQAnR/2IyO/OAfQjC02Rj8PKh/I3K8wNeIbmxqxFjzPakidVtcvY18aPJdkq+vd1bbO94NSzrRRhp4jdFo3y2hzttDmtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772534084; c=relaxed/simple;
	bh=UbBPqAcv2kV/Q4CNByWNsI4Gp7M+jn4qLkYn8cP+R8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B135fngrZkaTjMvYs5L7KxX7dKCetOIiHW64QcOdmODU0BaPOpKyWidk3maXhe4Xpy+fe0cKml8H4fjxvVRuVW5t+JPg3xvgT7v5OSjkbpJxnUHqkRfJ8WQWX8eQjgqpwIzRRJzqGJFLBtEc4Pon7z6cf3do43nxlMYOYwv5yK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lqMqPkPW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iVUDLfIF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lqMqPkPW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iVUDLfIF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B9D935BDEA;
	Tue,  3 Mar 2026 10:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772534080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=9UrJPHNyhUknVE32ZDrA7g1au2Fhe6ZCvxRhGCGzA8o=;
	b=lqMqPkPWqfJeKYyNTobGfmlypOq9O0pVliQhFsr5dDXofPyv/b/GgGcU6Xi0yoTa2eyxwg
	7MaLvhJ8Yz3kVLaz9QCxDzLS8AbI2txjhAjrVxIobHxkHpd82eTaYE4F9+fGGgb03IFa5R
	JMNRKG4T5wTyKO+JbaEoKD/vks2FLzU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772534080;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=9UrJPHNyhUknVE32ZDrA7g1au2Fhe6ZCvxRhGCGzA8o=;
	b=iVUDLfIF4U9dmHoWczbJvEmbfpoB2vpfnCz4s1BvYSrIsMQE5vGrpPfqhAW9yxewyjAsDQ
	3SWPKaww46bSbjDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772534080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=9UrJPHNyhUknVE32ZDrA7g1au2Fhe6ZCvxRhGCGzA8o=;
	b=lqMqPkPWqfJeKYyNTobGfmlypOq9O0pVliQhFsr5dDXofPyv/b/GgGcU6Xi0yoTa2eyxwg
	7MaLvhJ8Yz3kVLaz9QCxDzLS8AbI2txjhAjrVxIobHxkHpd82eTaYE4F9+fGGgb03IFa5R
	JMNRKG4T5wTyKO+JbaEoKD/vks2FLzU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772534080;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=9UrJPHNyhUknVE32ZDrA7g1au2Fhe6ZCvxRhGCGzA8o=;
	b=iVUDLfIF4U9dmHoWczbJvEmbfpoB2vpfnCz4s1BvYSrIsMQE5vGrpPfqhAW9yxewyjAsDQ
	3SWPKaww46bSbjDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A51763EA6D;
	Tue,  3 Mar 2026 10:34:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iL1IKEC5pmnJFAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Mar 2026 10:34:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4D160A0A1B; Tue,  3 Mar 2026 11:34:40 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@ZenIV.linux.org.uk>,
	<linux-ext4@vger.kernel.org>,
	Ted Tso <tytso@mit.edu>,
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
	David Sterba <dsterba@suse.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	linux-mm@kvack.org,
	linux-aio@kvack.org,
	Benjamin LaHaise <bcrl@kvack.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 0/32] fs: Move metadata bh tracking from address_space
Date: Tue,  3 Mar 2026 11:33:49 +0100
Message-ID: <20260303101717.27224-1-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3005; i=jack@suse.cz; h=from:subject:message-id; bh=UbBPqAcv2kV/Q4CNByWNsI4Gp7M+jn4qLkYn8cP+R8A=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpprkMYYq5ex/qPGCddgeRA95TW6T29xG3oZcwa 9/pZCmZiICJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaaa5DAAKCRCcnaoHP2RA 2d1UB/9/qfK53DX5rvT8+evw97coaewuS0fQW9uwuwRy19Te5htSwgwrDlxVdnAjxdPTDY832Zf OpsNY30Z32u9RG0pWG51BpraVwhf+/2MszT//06tOH7Hwn8BbdDiizKz5vq/Q2XSNU2mG95VmNt CQtLCDqJ8Af26NQdlIs1lhYbyPmKAG65aNny4KIwgSAfTQ8Kwi6k8WWtkgj2nkGnsQ6jh78QNXw a4cbhTbKSK3lEX8jT4bxbop6rZsmvNhPrUdUwKzjVmEzkHMLi+ddsFc8vlQpsBECnSaj5DoiXe+ 0AEhtReRU7oy3u6KT/zgv73jh80SHUOG0h4nkP1HWJsmjlSz
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -1.30
X-Spam-Level: 
X-Rspamd-Queue-Id: CC2721ECC07
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-79140-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,ZenIV.linux.org.uk,vger.kernel.org,mit.edu,gmail.com,suse.com,mail.parknet.co.jp,linux.dev,suse.de,kvack.org,suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Hello,

this patch series cleans up the mess that has accumulated over the years in
metadata buffer_head tracking for inodes, moves the tracking into dedicated
structure in filesystem-private part of the inode (so that we don't use
private_list, private_data, and private_lock in struct address_space), and also
moves couple other users of private_data and private_list so these are removed
from struct address_space saving 3 longs in struct inode for 99% of inodes.  I
would like to get rid of private_lock in struct address_space as well however
the locking changes for buffer_heads are non-trivial there and the patch series
is long enough as is. So let's leave that for another time.

The patches have survived some testing with fstests and ltp however I didn't
test AFFS, HUGETLBFS, and KVM guest_memfd changes so a help with testing
those would be very welcome. Thanks.

 block/bdev.c                |    1 
 fs/affs/affs.h              |    2 
 fs/affs/dir.c               |    1 
 fs/affs/file.c              |    1 
 fs/affs/inode.c             |    2 
 fs/affs/super.c             |    6 
 fs/affs/symlink.c           |    1 
 fs/aio.c                    |   78 +++++++-
 fs/bfs/bfs.h                |    2 
 fs/bfs/dir.c                |    1 
 fs/bfs/file.c               |    4 
 fs/bfs/inode.c              |    9 +
 fs/buffer.c                 |  387 +++++++++++++++++---------------------------
 fs/ext2/ext2.h              |    2 
 fs/ext2/file.c              |    1 
 fs/ext2/inode.c             |    3 
 fs/ext2/namei.c             |    2 
 fs/ext2/super.c             |    6 
 fs/ext2/symlink.c           |    2 
 fs/ext4/ext4.h              |    4 
 fs/ext4/file.c              |    1 
 fs/ext4/inode.c             |    9 -
 fs/ext4/namei.c             |    2 
 fs/ext4/super.c             |    9 -
 fs/ext4/symlink.c           |    3 
 fs/fat/fat.h                |    2 
 fs/fat/file.c               |    1 
 fs/fat/inode.c              |   16 +
 fs/fat/namei_msdos.c        |    1 
 fs/fat/namei_vfat.c         |    1 
 fs/gfs2/glock.c             |    1 
 fs/hugetlbfs/inode.c        |   10 -
 fs/inode.c                  |   24 +-
 fs/minix/file.c             |    1 
 fs/minix/inode.c            |   10 +
 fs/minix/minix.h            |    2 
 fs/minix/namei.c            |    1 
 fs/ntfs3/file.c             |    3 
 fs/ocfs2/dlmglue.c          |    1 
 fs/ocfs2/namei.c            |    3 
 fs/udf/file.c               |    1 
 fs/udf/inode.c              |    2 
 fs/udf/namei.c              |    1 
 fs/udf/super.c              |    6 
 fs/udf/symlink.c            |    1 
 fs/udf/udf_i.h              |    1 
 fs/udf/udfdecl.h            |    1 
 include/linux/buffer_head.h |    6 
 include/linux/fs.h          |   11 -
 include/linux/hugetlb.h     |    1 
 mm/hugetlb.c                |   10 -
 virt/kvm/guest_memfd.c      |   12 -
 52 files changed, 360 insertions(+), 309 deletions(-)

								Honza

