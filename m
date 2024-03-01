Return-Path: <linux-fsdevel+bounces-13318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA9586E6C1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 18:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2958A28B5C2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 17:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5663BF500;
	Fri,  1 Mar 2024 17:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hR4RI3M7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="o05E46K6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hR4RI3M7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="o05E46K6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FBA46B7;
	Fri,  1 Mar 2024 17:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709312834; cv=none; b=aSP5QSHl+bulrDBSro5CHLmmUSNwv0xOh2W7PCHX9bzVMw+iLY9BY8gk7cqQ7COLt84qFZlEVgcqME6gXzVsVb8xGCtTodcpd49dfWYZxSSlZ0QBB+354r8UWV09wXnoh3iLrxkdWqHlb10l7N1m0Vb4D6ijFhoqBMDkJvwgPB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709312834; c=relaxed/simple;
	bh=QnfkJAoInt5fUE+416z0sQ20bCXrkSWJKNSLICwxmGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p95dDAU7RfLK74kD+9IggMtkH5zglerivEdHaMv236iJh6+dGhFTqrcAIe6/PqFS0LKbAwSI4cdmhZo0bk2FzmAdWOSnyBoHTPLywNe/xHhx8npCU3++sYE3ZVCDxjp+7rOOwj1Dk06nZWlYPqojnfhENh7p1D4iaNMHfeZ2xbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hR4RI3M7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=o05E46K6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hR4RI3M7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=o05E46K6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 13FDA207B4;
	Fri,  1 Mar 2024 17:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709312831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3OiKnePSvssqSsATKZD6FgDSrsGbw6Gz9LH7uaXGsMo=;
	b=hR4RI3M7QdmI77qwLuZOBimpV0p2ze0qGZw1B4hIMLU2F/D7t3Gu5VbTAR9gTJgDi6vCeY
	CHs1xCbyeczWk9Hb3kbBfU7sfuhKG4jF0YdapV00Mtliv7GsO2UuM0v+bywHfHlN1udd4J
	we+zKQVacDSXAT9F9S8KKuGQXrqXA18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709312831;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3OiKnePSvssqSsATKZD6FgDSrsGbw6Gz9LH7uaXGsMo=;
	b=o05E46K6EN+fy853AkUBuf6HrQD5ZThoOdIKf4tjmcYR9J8tcaU11fvMi6vu+GSL77uZkk
	Y/9da7wAoHpaIGBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709312831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3OiKnePSvssqSsATKZD6FgDSrsGbw6Gz9LH7uaXGsMo=;
	b=hR4RI3M7QdmI77qwLuZOBimpV0p2ze0qGZw1B4hIMLU2F/D7t3Gu5VbTAR9gTJgDi6vCeY
	CHs1xCbyeczWk9Hb3kbBfU7sfuhKG4jF0YdapV00Mtliv7GsO2UuM0v+bywHfHlN1udd4J
	we+zKQVacDSXAT9F9S8KKuGQXrqXA18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709312831;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3OiKnePSvssqSsATKZD6FgDSrsGbw6Gz9LH7uaXGsMo=;
	b=o05E46K6EN+fy853AkUBuf6HrQD5ZThoOdIKf4tjmcYR9J8tcaU11fvMi6vu+GSL77uZkk
	Y/9da7wAoHpaIGBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E618113AA3;
	Fri,  1 Mar 2024 17:07:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MKjgNz4L4mUcGQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 01 Mar 2024 17:07:10 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 01 Mar 2024 18:07:11 +0100
Subject: [PATCH RFC 4/4] UNFINISHED mm, fs: use kmem_cache_charge() in
 path_openat()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240301-slab-memcg-v1-4-359328a46596@suse.cz>
References: <20240301-slab-memcg-v1-0-359328a46596@suse.cz>
In-Reply-To: <20240301-slab-memcg-v1-0-359328a46596@suse.cz>
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
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
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

This is just an example of using the kmem_cache_charge() API.  I think
it's placed in a place that's applicable for Linus's example [1]
although he mentions do_dentry_open() - I have followed from strace()
showing openat(2) to path_openat() doing the alloc_empty_file().

The idea is that filp_cachep stops being SLAB_ACCOUNT. Allocations that
want to be accounted immediately can use GFP_KERNEL_ACCOUNT. I did that
in alloc_empty_file_noaccount() (despite the contradictory name but the
noaccount refers to something else, right?) as IIUC it's about
kernel-internal opens.

alloc_empty_file() is now not doing the accounting, so I added
kmem_account_file() that calls the new kmem_cache_charge() API.

Why is this unfinished:

- there are other callers of alloc_empty_file() which I didn't adjust so
  they simply became memcg-unaccounted. I haven't investigated for which
  ones it would make also sense to separate the allocation and accounting.
  Maybe alloc_empty_file() would need to get a parameter to control
  this.

- I don't know how to properly unwind the accounting failure case. It
  seems like a new case because when we succeed the open, there's no
  further error path at least in path_openat().

Basically it boils down I'm unfamiliar with VFS so this depends if this
approach is deemed useful enough to finish it.

[1] https://lore.kernel.org/all/CAHk-=whYOOdM7jWy5jdrAm8LxcgCMFyk2bt8fYYvZzM4U-zAQA@mail.gmail.com/

Not-signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 fs/file_table.c | 9 +++++++--
 fs/internal.h   | 1 +
 fs/namei.c      | 4 +++-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index b991f90571b4..6401b6f175ae 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -223,6 +223,11 @@ struct file *alloc_empty_file(int flags, const struct cred *cred)
 	return ERR_PTR(-ENFILE);
 }
 
+int kmem_account_file(struct file *f)
+{
+	return kmem_cache_charge(filp_cachep, GFP_KERNEL_ACCOUNT, f);
+}
+
 /*
  * Variant of alloc_empty_file() that doesn't check and modify nr_files.
  *
@@ -234,7 +239,7 @@ struct file *alloc_empty_file_noaccount(int flags, const struct cred *cred)
 	struct file *f;
 	int error;
 
-	f = kmem_cache_zalloc(filp_cachep, GFP_KERNEL);
+	f = kmem_cache_zalloc(filp_cachep, GFP_KERNEL_ACCOUNT);
 	if (unlikely(!f))
 		return ERR_PTR(-ENOMEM);
 
@@ -468,7 +473,7 @@ void __init files_init(void)
 {
 	filp_cachep = kmem_cache_create("filp", sizeof(struct file), 0,
 				SLAB_TYPESAFE_BY_RCU | SLAB_HWCACHE_ALIGN |
-				SLAB_PANIC | SLAB_ACCOUNT, NULL);
+				SLAB_PANIC, NULL);
 	percpu_counter_init(&nr_files, 0, GFP_KERNEL);
 }
 
diff --git a/fs/internal.h b/fs/internal.h
index b67406435fc0..06ada11b71d0 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -96,6 +96,7 @@ extern void chroot_fs_refs(const struct path *, const struct path *);
 struct file *alloc_empty_file(int flags, const struct cred *cred);
 struct file *alloc_empty_file_noaccount(int flags, const struct cred *cred);
 struct file *alloc_empty_backing_file(int flags, const struct cred *cred);
+int kmem_account_file(struct file *file);
 
 static inline void file_put_write_access(struct file *file)
 {
diff --git a/fs/namei.c b/fs/namei.c
index 4e0de939fea1..fcf3f3fcd059 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3799,8 +3799,10 @@ static struct file *path_openat(struct nameidata *nd,
 		terminate_walk(nd);
 	}
 	if (likely(!error)) {
-		if (likely(file->f_mode & FMODE_OPENED))
+		if (likely(file->f_mode & FMODE_OPENED)) {
+			kmem_account_file(file);
 			return file;
+		}
 		WARN_ON(1);
 		error = -EINVAL;
 	}

-- 
2.44.0


