Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 126772C1869
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Nov 2020 23:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731077AbgKWWaj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 17:30:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:46198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728649AbgKWWai (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 17:30:38 -0500
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75A21206D5;
        Mon, 23 Nov 2020 22:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606170638;
        bh=qMsLhguUfZGHthn8o/bIe+LRx3PrKd4xYprbL94g5Es=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DNfDxTnuJc/9ZOQO+U1ViZqPntmi9u+PapFohdzgovjh/jy/Yy4xVB33Rww+qBRm7
         az2CJzZnLZkYf7iatMCzDNGSHVMHyPoXq/qiSNoa3lsby8//RGmrveXMtq3Cqen2Q2
         SidiEvRqa7Jbzx0Zmg8juZV1Q8JiUJnD9dIkecsc=
Date:   Mon, 23 Nov 2020 14:30:35 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Daniel Rosenberg <drosen@google.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Chao Yu <chao@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mtd@lists.infradead.org, kernel-team@android.com
Subject: Re: [PATCH v4 2/3] fscrypt: Have filesystems handle their d_ops
Message-ID: <X7w4C8GAy+P9KNU6@sol.localdomain>
References: <20201119060904.463807-1-drosen@google.com>
 <20201119060904.463807-3-drosen@google.com>
 <87y2iuj8y2.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2iuj8y2.fsf@collabora.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 21, 2020 at 11:45:41PM -0500, Gabriel Krisman Bertazi wrote:
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index 6633b20224d5..0288bedf46e1 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -4968,11 +4968,6 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
> >  		goto failed_mount4;
> >  	}
> >  
> > -#ifdef CONFIG_UNICODE
> > -	if (sb->s_encoding)
> > -		sb->s_d_op = &ext4_dentry_ops;
> > -#endif
> 
> This change has the side-effect of removing the capability of the root
> directory from being case-insensitive.  It is not a backward
> incompatible change because there is no way to make the root directory
> CI at the moment (it is never empty). But this restriction seems
> artificial. Is there a real reason to prevent the root inode from being
> case-insensitive?
> 

The problem is that the "lost+found" directory is special in that e2fsck needs
to be able to find it.

That's the reason why ext4 doesn't allow the root directory to be encrypted.
(And encrypting the root directory isn't really useful anyway, since if the goal
is to encrypt a whole filesystem with one key, dm-crypt is a better solution.)

Casefolding is a bit less problematic than encryption.  But it still doesn't
entirely work, as e.g. if you name the directory "LOST+FOUND" instead (the
directory is casefolded after all...), then e2fsck can't find it.

Unless there's a real use case for the root directory being casefolded and
people are willing to fix e2fsck, I think we should just make ext4 return an
error when setting the casefold flag on the root directory, like it does when
trying to enable encryption on the root directory.

- Eric
