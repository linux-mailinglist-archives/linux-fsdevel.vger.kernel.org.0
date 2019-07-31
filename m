Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF1347CC19
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2019 20:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730381AbfGaSiG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 14:38:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730372AbfGaSiF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 14:38:05 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 196BF206A3;
        Wed, 31 Jul 2019 18:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564598284;
        bh=mwf/L4kawPnA1+kq4IqMkos0fqY4xHcvedV1SVvmgr4=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=0SBhBqvGEFIUO9Q+X1GiRxRfAhxkriFVan66HT0bGDPhuMdNTX8kCHLadzRChzP4O
         OKShL0aapWqVZ6CtauvlQDheMoSsBzO54aB87yx0xEz7IKpbCUA8GYPua8suG6ultw
         koL6k+O0wO1Ftp9+M/dFACaiJQwyP8yBpRpTOjac=
Date:   Wed, 31 Jul 2019 11:38:02 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-api@vger.kernel.org,
        linux-crypto@vger.kernel.org, keyrings@vger.kernel.org,
        Paul Crowley <paulcrowley@google.com>,
        Satya Tangirala <satyat@google.com>
Subject: Re: [PATCH v7 07/16] fscrypt: add FS_IOC_REMOVE_ENCRYPTION_KEY ioctl
Message-ID: <20190731183802.GA687@sol.localdomain>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-api@vger.kernel.org,
        linux-crypto@vger.kernel.org, keyrings@vger.kernel.org,
        Paul Crowley <paulcrowley@google.com>,
        Satya Tangirala <satyat@google.com>
References: <20190726224141.14044-1-ebiggers@kernel.org>
 <20190726224141.14044-8-ebiggers@kernel.org>
 <20190728192417.GG6088@mit.edu>
 <20190729195827.GF169027@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729195827.GF169027@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 29, 2019 at 12:58:28PM -0700, Eric Biggers wrote:
> On Sun, Jul 28, 2019 at 03:24:17PM -0400, Theodore Y. Ts'o wrote:
> > > +
> > > +/*
> > > + * Try to remove an fscrypt master encryption key.  If other users have also
> > > + * added the key, we'll remove the current user's usage of the key, then return
> > > + * -EUSERS.  Otherwise we'll continue on and try to actually remove the key.
> > 
> > Nit: this should be moved to patch #11
> > 
> > Also, perror(EUSERS) will display "Too many users" which is going to
> > be confusing.  I understand why you chose this; we would like to
> > distinguish between there are still inodes using this key, and there
> > are other users using this key.
> > 
> > Do we really need to return EUSERS in this case?  It's actually not an
> > *error* that other users are using the key.  After all, the unlink(2)
> > system call doesn't return an advisory error when you delete a file
> > which has other hard links.  And an application which does care about
> > this detail can always call FS_IOC_ENCRYPTION_KEY_STATUS() and check
> > user_count.
> > 
> 
> Returning 0 when the key wasn't fully removed might also be confusing.  But I
> guess you're right that returning an error doesn't match how syscalls usually
> work.  It did remove the current user's usage of the key, after all, rather than
> completely fail.  And as you point out, if someone cares about other users
> having added the key, they can use FS_IOC_GET_ENCRYPTION_KEY_STATUS.
> 
> So I guess I'll change it to 0.
> 

So after making this change and thinking about it some more, I'm not sure it's
actually an improvement.

The normal use case for this ioctl is to "lock" some encrypted directory(s).  If
it returns 0 and doesn't lock the directory(s), that's unexpected.

This is perhaps different from what users expect from unlink().  It's well known
that unlink() just deletes the filename, not the file itself if it's still open
or has other links.  And unlink() by itself isn't meant for use cases where the
file absolutely must be securely erased.  But FS_IOC_REMOVE_ENCRYPTION_KEY
really is meant primarily for that sort of thing.

To give a concrete example: my patch for the userspace tool
https://github.com/google/fscrypt adds a command 'fscrypt lock' which locks an
encrypted directory.  If, say, someone runs 'fscrypt unlock' as uid 0 and then
'fscrypt lock' as uid 1000, then FS_IOC_REMOVE_ENCRYPTION_KEY can't actually
remove the key.  I need to make the tool show a proper error message in this
case.  To do so, it would help to get a unique error code (e.g. EUSERS) from
FS_IOC_REMOVE_ENCRYPTION_KEY, rather than get the ambiguous error code ENOKEY
and have to call FS_IOC_GET_ENCRYPTION_KEY_STATUS to get the real status.

Also, we already have the EBUSY case.  This means that the ioctl removed the
master key secret itself; however, some files were still in-use, so the key
remains in the "incompletely removed" state.  If we were actually going for
unlink() semantics, then for consistency this case really ought to return 0 and
unlink the key object, and people who care about in-use files would need to use
FS_IOC_GET_ENCRYPTION_KEY_STATUS.  But most people *will* care about this, and
may even want to retry the ioctl later, which isn't something you can do with
pure unlink() semantics.

So I'm leaning towards keeping the EUSERS and EBUSY errors.

- Eric
