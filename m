Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16E4C8E0D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 00:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbfHNWfr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Aug 2019 18:35:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:34600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727217AbfHNWfq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Aug 2019 18:35:46 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 081B12064A;
        Wed, 14 Aug 2019 22:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565822145;
        bh=l8Slk/c9NCmIURt4vJ515GO1o+OGPytEBQ6mmXfsoCc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HZrWel2TOGlxa/OLzSgK6FZYkC9k5fmPXmA7SczQPr/nZXF5fhlrN12mEtzuphrKx
         naClhxqMHYFXy1R/MsRWN561L+U0nJMj+RQmokWi+/oM+CwhuEESn4oiXIYXhBuZnf
         2ZHVbx8JH1SSewjdXfJj0RGtoca3cSvPVjunHj9Y=
Date:   Wed, 14 Aug 2019 15:35:43 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-crypto@vger.kernel.org, keyrings@vger.kernel.org,
        linux-api@vger.kernel.org, Satya Tangirala <satyat@google.com>,
        Paul Crowley <paulcrowley@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v8 10/20] fscrypt: add FS_IOC_REMOVE_ENCRYPTION_KEY ioctl
Message-ID: <20190814223542.GE101319@gmail.com>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-crypto@vger.kernel.org, keyrings@vger.kernel.org,
        linux-api@vger.kernel.org, Satya Tangirala <satyat@google.com>,
        Paul Crowley <paulcrowley@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
References: <20190805162521.90882-1-ebiggers@kernel.org>
 <20190805162521.90882-11-ebiggers@kernel.org>
 <20190813000644.GH28705@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813000644.GH28705@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 12, 2019 at 08:06:44PM -0400, Theodore Y. Ts'o wrote:
> > +		/* Some inodes still reference this key; try to evict them. */
> > +		if (try_to_lock_encrypted_files(sb, mk) != 0)
> > +			status_flags |=
> > +				FSCRYPT_KEY_REMOVAL_STATUS_FLAG_FILES_BUSY;
> > +	}
> 
> try_to_lock_encrypted_files() can return other errors besides -EBUSY;
> in particular sync_filesystem() can return other errors, such as -EIO
> or -EFSCORUPTED.  In that case, I think we're better off returning the
> relevant status code back to the user.  We will have already wiped the
> master key, but this situation will only happen in exceptional
> conditions (e.g., user has ejected the sdcard, etc.), so it's not
> worth it to try to undo the master key wipe to try to restore things
> to the pre-ioctl execution state.
> 
> So I think we should capture the return code from
> try_to_lock_encrypted_files, and if it is EBUSY, we can set FILES_BUSY
> flag and return success.  Otherwise, we should return the error.
> 
> If you agree, please fix that up and then feel free to add:
> 
> Reviewed-by: Theodore Ts'o <tytso@mit.edu>
> 
> 						- Ted

Yes, that makes sense.  I've made the following change to this patch:

diff --git a/fs/crypto/keyring.c b/fs/crypto/keyring.c
index 9901593051424b..c3423f0edc7014 100644
--- a/fs/crypto/keyring.c
+++ b/fs/crypto/keyring.c
@@ -479,6 +479,7 @@ int fscrypt_ioctl_remove_key(struct file *filp, void __user *_uarg)
 	struct key *key;
 	struct fscrypt_master_key *mk;
 	u32 status_flags = 0;
+	int err;
 	bool dead;
 
 	if (copy_from_user(&arg, uarg, sizeof(arg)))
@@ -514,11 +515,15 @@ int fscrypt_ioctl_remove_key(struct file *filp, void __user *_uarg)
 		 * key object is free to be removed from the keyring.
 		 */
 		key_invalidate(key);
+		err = 0;
 	} else {
 		/* Some inodes still reference this key; try to evict them. */
-		if (try_to_lock_encrypted_files(sb, mk) != 0)
+		err = try_to_lock_encrypted_files(sb, mk);
+		if (err == -EBUSY) {
 			status_flags |=
 				FSCRYPT_KEY_REMOVAL_STATUS_FLAG_FILES_BUSY;
+			err = 0;
+		}
 	}
 	/*
 	 * We return 0 if we successfully did something: wiped the secret, or
@@ -527,7 +532,9 @@ int fscrypt_ioctl_remove_key(struct file *filp, void __user *_uarg)
 	 * including all files locked.
 	 */
 	key_put(key);
-	return put_user(status_flags, &uarg->removal_status_flags);
+	if (err == 0)
+		err = put_user(status_flags, &uarg->removal_status_flags);
+	return err;
 }
 EXPORT_SYMBOL_GPL(fscrypt_ioctl_remove_key);
 
