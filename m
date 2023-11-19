Return-Path: <linux-fsdevel+bounces-3172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F567F09CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 00:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48E891C208C8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 23:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E783C1A594;
	Sun, 19 Nov 2023 23:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Srs5e4BI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4PAv7liN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F1F137;
	Sun, 19 Nov 2023 15:11:42 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2445C218E2;
	Sun, 19 Nov 2023 23:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1700435501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TKLnl/b8FKP562p7zrfLcmIgpEtVLt1qt4EDjEmPx0s=;
	b=Srs5e4BIjVBqkWA0tR1OgOyfaO1V1y+21/Awh6Q5mCwFcf8Hm9PWv5MdYHf2n8KalBaIdU
	qJ0Ysb4qPrH08rGIfmJhLYgtpXCR3yG2mo7nCgYEQjhIa/RFy7T3kxbHQg9/SwmfNtwtcd
	dvFsnedD4omSS2PGdEOVseXfaf/Wq+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1700435501;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TKLnl/b8FKP562p7zrfLcmIgpEtVLt1qt4EDjEmPx0s=;
	b=4PAv7liNx3tzKNeWwZji/+kmb3WJWBqzNRdXEcVsTL8vCBDEb5IgrTPDBgXHu7Ex9obz/e
	hFO4tfC+nIgMqVBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D7C521377F;
	Sun, 19 Nov 2023 23:11:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id arMlLyyWWmWVbQAAMHmgww
	(envelope-from <krisman@suse.de>); Sun, 19 Nov 2023 23:11:40 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Christian Brauner <brauner@kernel.org>
Cc: tytso@mit.edu,  linux-f2fs-devel@lists.sourceforge.net,
  ebiggers@kernel.org,  viro@zeniv.linux.org.uk,
  linux-fsdevel@vger.kernel.org,  jaegeuk@kernel.org,
  linux-ext4@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH v6 0/9] Support negative dentries on
 case-insensitive ext4 and f2fs
In-Reply-To: <20231025-selektiert-leibarzt-5d0070d85d93@brauner> (Christian
	Brauner's message of "Wed, 25 Oct 2023 15:32:02 +0200")
References: <20230816050803.15660-1-krisman@suse.de>
	<20231025-selektiert-leibarzt-5d0070d85d93@brauner>
Date: Sun, 19 Nov 2023 18:11:39 -0500
Message-ID: <87r0kl5oes.fsf@>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 5.60
X-Spamd-Result: default: False [5.60 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 INVALID_MSGID(1.70)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_SPAM_SHORT(3.00)[0.999];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[]

Christian Brauner <brauner@kernel.org> writes:

> On Wed, 16 Aug 2023 01:07:54 -0400, Gabriel Krisman Bertazi wrote:
>> This is v6 of the negative dentry on case-insensitive directories.
>> Thanks Eric for the review of the last iteration.  This version
>> drops the patch to expose the helper to check casefolding directories,
>> since it is not necessary in ecryptfs and it might be going away.  It
>> also addresses some documentation details, fix a build bot error and
>> simplifies the commit messages.  See the changelog in each patch for
>> more details.
>> 
>> [...]
>
> Ok, let's put it into -next so it sees some testing.
> So it's too late for v6.7. Seems we forgot about this series.
> Sorry about that.

Christian,

We are approaching -rc2 and, until last Friday, it didn't shown up in
linux-next. So, to avoid turning a 6 month delay into 9 months, I pushed
your signed tag to linux-next myself.

That obviously uncovered a merge conflict: in v6.6, ceph added fscrypt,
and the caller had to be updated.  I fixed it and pushed again to
linux-next to get more testing.

Now, I don't want to send it to Linus myself. This is 100% VFS/FS code,
I'm not the maintainer and it will definitely raise eyebrows.  Can you
please requeue and make sure it goes through this time?  I'm happy to
drop my branch from linux-next once yours shows up.

  https://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode.git/log/?h=negative-dentries

This branch has the latest version with the ceph conflict folded in.  I
did it this way because I'd consider it was never picked up and there is
no point in making the history complex by adding a fix on top of your
signed tag, since it already fails to build ceph.

I can send it as a v7; but I prefer you just pull from the branch
above. Or you can ack and I'll send to Linus.

This is the diff from you signed tag:

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 629d8fb31d8f..21278a9d9baa 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1869,7 +1869,7 @@ static int ceph_d_revalidate(struct dentry *dentry, const struct qstr *name,
        struct inode *dir, *inode;
        struct ceph_mds_client *mdsc;
 
-       valid = fscrypt_d_revalidate(dentry, flags);
+       valid = fscrypt_d_revalidate(dentry, name, flags);
        if (valid <= 0)
                return valid;
 
diff --git a/fs/ecryptfs/dentry.c b/fs/ecryptfs/dentry.c
index 56093648d838..ce86891a1711 100644
--- a/fs/ecryptfs/dentry.c
+++ b/fs/ecryptfs/dentry.c
@@ -18,6 +18,7 @@
 /**
  * ecryptfs_d_revalidate - revalidate an ecryptfs dentry
  * @dentry: The ecryptfs dentry
+ * @name: The name under lookup
  * @flags: lookup flags
  *
  * Called when the VFS needs to revalidate a dentry. This
diff --git a/fs/gfs2/dentry.c b/fs/gfs2/dentry.c
index 3dd93d36aaf2..5e4910e016a8 100644
--- a/fs/gfs2/dentry.c
+++ b/fs/gfs2/dentry.c
@@ -22,6 +22,7 @@
 /**
  * gfs2_drevalidate - Check directory lookup consistency
  * @dentry: the mapping to check
+ * @name: The name under lookup
  * @flags: lookup flags
  *
  * Check to make sure the lookup necessary to arrive at this inode from its

-- 
Gabriel Krisman Bertazi

