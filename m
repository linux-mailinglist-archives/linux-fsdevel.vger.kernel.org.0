Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF451120A5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 01:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbfLDAcO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 19:32:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:37848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbfLDAcO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 19:32:14 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F59820674;
        Wed,  4 Dec 2019 00:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575419533;
        bh=8ZaeCwEq+6xIABYU+SGqp6hX6Y6XpUzqAIOiEL+4ptk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H+JHr/MY13+OR7Xg3FnTUgq77Cu2JRb/F5u+aykghFc6qGYlML4b6ddbV54qHYV0C
         HkJpYWB7n8o3CzDTRpPQ6YK/SIfmqLJ7ehkznxzeKGCk0Je1hCzegtpse65co4wjGM
         dAdXmhvWd1VFRWMfustTw3Kz4aCxFW4LVjSG3khk=
Date:   Tue, 3 Dec 2019 16:32:11 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Gao Xiang <gaoxiang25@huawei.com>,
        Daniel Rosenberg <drosen@google.com>,
        Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH 4/8] vfs: Fold casefolding into vfs
Message-ID: <20191204003211.GE727@sol.localdomain>
References: <20191203051049.44573-1-drosen@google.com>
 <20191203051049.44573-5-drosen@google.com>
 <20191203074154.GA216261@architecture4>
 <85wobdb3hp.fsf@collabora.com>
 <20191203203414.GA727@sol.localdomain>
 <85zhg96r7l.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85zhg96r7l.fsf@collabora.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 03, 2019 at 04:21:02PM -0500, Gabriel Krisman Bertazi wrote:
> Eric Biggers <ebiggers@kernel.org> writes:
> 
> > On Tue, Dec 03, 2019 at 02:42:10PM -0500, Gabriel Krisman Bertazi wrote:
> >> Gao Xiang <gaoxiang25@huawei.com> writes:
> 
> >> I think Daniel's approach of moving this into VFS is the simplest way to
> >> actually solve the issue, instead of extending and duplicating a lot of
> >> functionality into filesystem hooks to support the possible mixes of
> >> case-insensitive, overlayfs and fscrypt.
> >> 
> >
> > I think we can actually get everything we want using dentry_operations only,
> > since the filesystem can set ->d_op during ->lookup() (like what is done for
> > encrypted filenames now) rather than at dentry allocation time.  And fs/crypto/
> > can export fscrypt_d_revalidate() rather than setting ->d_op itself.
> 
> Problem is, differently from fscrypt, case-insensitive uses the d_hash()
> hook and for a lookup, we actually use
> dentry->d_parent->d_ops->d_hash().  Which works well, until you are flipping the
> casefold flag.  Then the dentry already exists and you need to modify
> the d_ops on the fly, which I couldn't find precedent anywhere.  I tried
> invalidating the dentry whenever we flip the flag, but then if it has
> negative dentries as children,I wasn't able to reliably invalidate it,
> and that's when I reached the limit of my knowledge in VFS.  In
> particular, in every attempt I made to implement it like this, I was
> able to race and do a case-insensitive lookup on a directory that was
> just made case sensitive.
> 
> I'm not saying there isn't a way.  But it is a bit harder than this
> proposal. I tried it already and still didn't manage to make it work.
> Maybe someone who better understands vfs.

Yes you're right, I forgot that for ->d_hash() and ->d_compare() it's actually
the parent's directory dentry_operations that are used.

> 
> > It's definitely ugly to have to handle the 3 cases of encrypt, casefold, and
> > encrypt+casefold separately -- and this will need to be duplicated for each
> > filesystem.  But we do have to weigh that against adding additional complexity
> > and overhead to the VFS for everyone.  If we do go with the VFS changes, please
> > try to make them as simple and unobtrusive as possible.
> 
> Well, it is just not case-insensitive+fscrypt. Also overlayfs
> there. Probably more.  So we have much more cases.  I understand the VFS
> changes need to be very well thought, but when I worked on this it
> started to look a more correct solution than using the hooks.

Well the point of my proof-of-concept patch having separate ext4_ci_dentry_ops,
ext4_encrypted_dentry_ops, and ext4_encrypted_ci_dentry_ops is supposed to be
for overlayfs support -- since overlayfs requires that some operations are not
present.  If we didn't need overlayfs support, we could just use a single
ext4_dentry_ops for all dentries instead.

I think we could still support fscrypt, casefold, fscrypt+casefold, and
fscrypt+overlayfs with dentry_operations only.  It's casefold+overlayfs that's
the biggest problem, due to the possibility of the casefold flag being set on a
directory later as you pointed out.

- Eric
