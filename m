Return-Path: <linux-fsdevel+bounces-6811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5415981D235
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 05:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78B9E1C22AB4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 04:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85326ABF;
	Sat, 23 Dec 2023 04:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="x/6Gk3SK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SqMAW7Xb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="x/6Gk3SK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SqMAW7Xb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414A5469E;
	Sat, 23 Dec 2023 04:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 277461FD11;
	Sat, 23 Dec 2023 04:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703305423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5JaqA2wt90SmZ4y/OQc30pqU+gGjb2WEHa8FTpQVI0I=;
	b=x/6Gk3SKhI/F7FND4GXtGO4BLdcrq8kHR6dInEcdxdxw/eTQvi27dBWXv17Fo9pN5kM5fW
	bO2Vix/NhSEYELHXrRrQyOuv4V/CLy6DFw7TNKFLr59xpeDnvoehYZhbQMPEht2jNqesFe
	7W+lJg9nEfxHoPDQn65StLBZOwd9nw8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703305423;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5JaqA2wt90SmZ4y/OQc30pqU+gGjb2WEHa8FTpQVI0I=;
	b=SqMAW7XbThI4yZhOhWKoJZZrxEx0/8P4xMcRIb8KAFIruvKhVpm6BLKTAKARLbK7ECLaC0
	OXt5ET/renWgTJBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703305423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5JaqA2wt90SmZ4y/OQc30pqU+gGjb2WEHa8FTpQVI0I=;
	b=x/6Gk3SKhI/F7FND4GXtGO4BLdcrq8kHR6dInEcdxdxw/eTQvi27dBWXv17Fo9pN5kM5fW
	bO2Vix/NhSEYELHXrRrQyOuv4V/CLy6DFw7TNKFLr59xpeDnvoehYZhbQMPEht2jNqesFe
	7W+lJg9nEfxHoPDQn65StLBZOwd9nw8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703305423;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5JaqA2wt90SmZ4y/OQc30pqU+gGjb2WEHa8FTpQVI0I=;
	b=SqMAW7XbThI4yZhOhWKoJZZrxEx0/8P4xMcRIb8KAFIruvKhVpm6BLKTAKARLbK7ECLaC0
	OXt5ET/renWgTJBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D35F2137E8;
	Sat, 23 Dec 2023 04:23:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id amS1Lc5ghmU9QAAAD6G6ig
	(envelope-from <krisman@suse.de>); Sat, 23 Dec 2023 04:23:42 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Eric Biggers <ebiggers@kernel.org>, Amir Goldstein <amir73il@gmail.com>
Cc: viro@zeniv.linux.org.uk,  jaegeuk@kernel.org,  tytso@mit.edu,
  linux-f2fs-devel@lists.sourceforge.net,  linux-ext4@vger.kernel.org,
  linux-fsdevel@vger.kernel.org
Subject: [PATCH] ovl: Reject mounting case-insensitive filesystems
In-Reply-To: <20231219231222.GI38652@quark.localdomain> (Eric Biggers's
	message of "Tue, 19 Dec 2023 16:12:22 -0700")
Organization: SUSE
References: <20231215211608.6449-1-krisman@suse.de>
	<20231219231222.GI38652@quark.localdomain>
Date: Fri, 22 Dec 2023 23:23:41 -0500
Message-ID: <87a5q1eecy.fsf_-_@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Level: ****
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 HAS_ORG_HEADER(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="x/6Gk3SK";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SqMAW7Xb
X-Spam-Score: -3.31
X-Rspamd-Queue-Id: 277461FD11

Eric Biggers <ebiggers@kernel.org> writes:

> On Fri, Dec 15, 2023 at 04:16:00PM -0500, Gabriel Krisman Bertazi wrote:
>> [Apologies for the quick spin of a v2.  The only difference are a couple
>> fixes to the build when CONFIG_UNICODE=n caught by LKP and detailed in
>> each patch changelog.]
>> 
>> When case-insensitive and fscrypt were adapted to work together, we moved the
>> code that sets the dentry operations for case-insensitive dentries(d_hash and
>> d_compare) to happen from a helper inside ->lookup.  This is because fscrypt
>> wants to set d_revalidate only on some dentries, so it does it only for them in
>> d_revalidate.
>> 
>> But, case-insensitive hooks are actually set on all dentries in the filesystem,
>> so the natural place to do it is through s_d_op and let d_alloc handle it [1].
>> In addition, doing it inside the ->lookup is a problem for case-insensitive
>> dentries that are not created through ->lookup, like those coming
>> open-by-fhandle[2], which will not see the required d_ops.
>> 
>> This patchset therefore reverts to using sb->s_d_op to set the dentry operations
>> for case-insensitive filesystems.  In order to set case-insensitive hooks early
>> and not require every dentry to have d_revalidate in case-insensitive
>> filesystems, it introduces a patch suggested by Al Viro to disable d_revalidate
>> on some dentries on the fly.
>> 
>> It survives fstests encrypt and quick groups without regressions.  Based on
>> v6.7-rc1.
>> 
>> [1] https://lore.kernel.org/linux-fsdevel/20231123195327.GP38156@ZenIV/
>> [2] https://lore.kernel.org/linux-fsdevel/20231123171255.GN38156@ZenIV/
>> 
>> Gabriel Krisman Bertazi (8):
>>   dcache: Add helper to disable d_revalidate for a specific dentry
>>   fscrypt: Drop d_revalidate if key is available
>>   libfs: Merge encrypted_ci_dentry_ops and ci_dentry_ops
>>   libfs: Expose generic_ci_dentry_ops outside of libfs
>>   ext4: Set the case-insensitive dentry operations through ->s_d_op
>>   f2fs: Set the case-insensitive dentry operations through ->s_d_op
>>   libfs: Don't support setting casefold operations during lookup
>>   fscrypt: Move d_revalidate configuration back into fscrypt
>
> Thanks Gabriel, this series looks good.  Sorry that we missed this when adding
> the support for encrypt+casefold.
>
> It's slightly awkward that some lines of code added by patches 5-6 are removed
> in patch 8.  These changes look very hard to split up, though, so you've
> probably done about the best that can be done.
>
> One question/request: besides performance, the other reason we're so careful
> about minimizing when ->d_revalidate is set for fscrypt is so that overlayfs
> works on encrypted directories.  This is because overlayfs is not compatible
> with ->d_revalidate.  I think your solution still works for that, since
> DCACHE_OP_REVALIDATE will be cleared after the first call to
> fscrypt_d_revalidate(), and when checking for usupported dentries overlayfs does
> indeed check for DCACHE_OP_REVALIDATE instead of ->d_revalidate directly.
> However, that does rely on that very first call to ->d_revalidate actually
> happening before the check is done.  It would be nice to verify that
> overlayfs+fscrypt indeed continues to work, and explicitly mention this
> somewhere (I don't see any mention of overlayfs+fscrypt in the series).

Hi Eric,

From my testing, overlayfs+fscrypt should work fine.  I tried mounting
it on top of encrypted directories, with and without key, and will add
this information to the commit message.  If we adopt the suggestion from
Al in the other subthread, even better, we won't need the first
d_revalidate to happen before the check, so I'll adopt that.

While looking into overlayfs, I found another reason we would need this
patchset.  A side effect of not configuring ->d_op through s_d_op is
that the root dentry won't have d_op set.  While this is fine for
casefold, because we forbid the root directory from being
case-insensitive, we can trick overlayfs into mounting a
filesystem it can't handle.

Even with this merged, and as Christian said in another thread regarding
ecryptfs, we should handle this explicitly.  Something like below.

Amir, would you consider this for -rc8?

-- >8 --
Subject: [PATCH] ovl: Reject mounting case-insensitive filesystems

overlayfs relies on the filesystem setting DCACHE_OP_HASH or
DCACHE_OP_COMPARE to reject mounting over case-insensitive directories.

Since commit bb9cd9106b22 ("fscrypt: Have filesystems handle their
d_ops"), we set ->d_op through a hook in ->d_lookup, which
means the root dentry won't have them, causing the mount to accidentally
succeed.

In v6.7-rc7, the following sequence will succeed to mount, but any
dentry other than the root dentry will be a "weird" dentry to ovl and
fail with EREMOTE.

  mkfs.ext4 -O casefold lower.img
  mount -O loop lower.img lower
  mount -t overlay -o lowerdir=lower,upperdir=upper,workdir=work ovl /mnt

Mounting on a subdirectory fails, as expected, because DCACHE_OP_HASH
and DCACHE_OP_COMPARE are properly set by ->lookup.

Fix by explicitly rejecting superblocks that allow case-insensitive
dentries.

Fixes: bb9cd9106b22 ("fscrypt: Have filesystems handle their d_ops")
Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
---
 fs/overlayfs/params.c | 2 ++
 include/linux/fs.h    | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index 3fe2dde1598f..99495f079644 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -286,6 +286,8 @@ static int ovl_mount_dir_check(struct fs_context *fc, const struct path *path,
 	if (!d_is_dir(path->dentry))
 		return invalfc(fc, "%s is not a directory", name);
 
+	if (sb_has_encoding(path->mnt->mnt_sb))
+		return invalfc(fc, "caseless filesystem on %s not supported", name);
 
 	/*
 	 * Check whether upper path is read-only here to report failures
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 98b7a7a8c42e..e6667ece5e64 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3203,6 +3203,15 @@ extern int generic_check_addressable(unsigned, u64);
 
 extern void generic_set_encrypted_ci_d_ops(struct dentry *dentry);
 
+static inline bool sb_has_encoding(const struct super_block *sb)
+{
+#if IS_ENABLED(CONFIG_UNICODE)
+	return !!sb->s_encoding;
+#else
+	return false;
+#endif
+}
+
 int may_setattr(struct mnt_idmap *idmap, struct inode *inode,
 		unsigned int ia_valid);
 int setattr_prepare(struct mnt_idmap *, struct dentry *, struct iattr *);
-- 
2.43.0


