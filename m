Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 284722C1CB4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 05:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgKXEbM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 23:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgKXEbM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 23:31:12 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2B9C0613CF;
        Mon, 23 Nov 2020 20:31:12 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 0F22D1F44A84
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Eric Biggers <ebiggers@kernel.org>
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
Organization: Collabora
References: <20201119060904.463807-1-drosen@google.com>
        <20201119060904.463807-3-drosen@google.com>
        <87y2iuj8y2.fsf@collabora.com> <X7w4C8GAy+P9KNU6@sol.localdomain>
Date:   Mon, 23 Nov 2020 23:31:05 -0500
In-Reply-To: <X7w4C8GAy+P9KNU6@sol.localdomain> (Eric Biggers's message of
        "Mon, 23 Nov 2020 14:30:35 -0800")
Message-ID: <87blfnpe9i.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> writes:

> On Sat, Nov 21, 2020 at 11:45:41PM -0500, Gabriel Krisman Bertazi wrote:
>> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>> > index 6633b20224d5..0288bedf46e1 100644
>> > --- a/fs/ext4/super.c
>> > +++ b/fs/ext4/super.c
>> > @@ -4968,11 +4968,6 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
>> >  		goto failed_mount4;
>> >  	}
>> >  
>> > -#ifdef CONFIG_UNICODE
>> > -	if (sb->s_encoding)
>> > -		sb->s_d_op = &ext4_dentry_ops;
>> > -#endif
>> 
>> This change has the side-effect of removing the capability of the root
>> directory from being case-insensitive.  It is not a backward
>> incompatible change because there is no way to make the root directory
>> CI at the moment (it is never empty). But this restriction seems
>> artificial. Is there a real reason to prevent the root inode from being
>> case-insensitive?
>> 
>
> The problem is that the "lost+found" directory is special in that e2fsck needs
> to be able to find it.
>
> That's the reason why ext4 doesn't allow the root directory to be encrypted.
> (And encrypting the root directory isn't really useful anyway, since if the goal
> is to encrypt a whole filesystem with one key, dm-crypt is a better solution.)
>
> Casefolding is a bit less problematic than encryption.  But it still doesn't
> entirely work, as e.g. if you name the directory "LOST+FOUND" instead (the
> directory is casefolded after all...), then e2fsck can't find it.
>
> Unless there's a real use case for the root directory being casefolded and
> people are willing to fix e2fsck, I think we should just make ext4 return an
> error when setting the casefold flag on the root directory, like it does when
> trying to enable encryption on the root directory.

I don't have a use case where I need a root directory to be CI.  In
fact, when I first implemented CI, I did want to block the root directory
from being made CI, just to prevent people from doing "chattr +F /" and
complaining afterwards when /usr/lib breaks.

My concern with the curent patch was whether this side-effect was
considered, but I'm happy with either semantics.

-- 
Gabriel Krisman Bertazi
