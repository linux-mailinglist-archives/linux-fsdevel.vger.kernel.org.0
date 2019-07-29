Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D64D795E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2019 21:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390245AbfG2Tqt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jul 2019 15:46:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:36198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390242AbfG2Tqs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:46:48 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C031C205F4;
        Mon, 29 Jul 2019 19:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564429607;
        bh=8Slb/dcgJuOY+mm6dVYYikaN4v+qkAQ5N+ZwtSce/eI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r/QgV/Aa24jZcj1+VmNkDQtk9eYteOJ3HaDEJxXWAnq67HBQqoCgM4v64bpEo3cnW
         d1fLgk4VdQ6kcWFSM/MvQYxGQ2fT7ccgYrDTaxOtNdJ8pNCRzoXEdrLqM1gGUs5W5i
         cYniPprJp6BlXGrbGMSEofsXk1WX4mUaAEFckltY=
Date:   Mon, 29 Jul 2019 12:46:45 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-api@vger.kernel.org,
        linux-crypto@vger.kernel.org, keyrings@vger.kernel.org,
        Paul Crowley <paulcrowley@google.com>,
        Satya Tangirala <satyat@google.com>
Subject: Re: [PATCH v7 06/16] fscrypt: add FS_IOC_ADD_ENCRYPTION_KEY ioctl
Message-ID: <20190729194644.GE169027@gmail.com>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-api@vger.kernel.org,
        linux-crypto@vger.kernel.org, keyrings@vger.kernel.org,
        Paul Crowley <paulcrowley@google.com>,
        Satya Tangirala <satyat@google.com>
References: <20190726224141.14044-1-ebiggers@kernel.org>
 <20190726224141.14044-7-ebiggers@kernel.org>
 <20190728185003.GF6088@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190728185003.GF6088@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 28, 2019 at 02:50:03PM -0400, Theodore Y. Ts'o wrote:
> On Fri, Jul 26, 2019 at 03:41:31PM -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Add a new fscrypt ioctl, FS_IOC_ADD_ENCRYPTION_KEY.  This ioctl adds an
> > encryption key to the filesystem's fscrypt keyring ->s_master_keys,
> > making any files encrypted with that key appear "unlocked".
> 
> Note: it think it's going to be useful to make the keyring id
> available someplace like /sys/fs/<fs>/<blkdev>/keyring, or preferably
> in the new fsinfo system call.  Yes, the system administrator can paw
> through /proc/keys and try to figure it out, but it will be nicer if
> there's a direct way to do that.
> 
> For that matter, we could just add a new ioctl which returns the file
> system's keyring id.  That way an application program won't have to
> try to figure out what a file's underlying sb->s_id happens to be.
> (Especially if things like overlayfs are involved.)

Keep in mind that the new ioctls (FS_IOC_ADD_ENCRYPTION_KEY,
FS_IOC_REMOVE_ENCRYPTION_KEY, FS_IOC_GET_ENCRYPTION_KEY_STATUS) don't take the
keyring ID as a parameter, since it's already known from the filesystem the
ioctl is executed on.  So there actually isn't much that can be done with the
keyring ID.  But sure, if it's needed later we can add an API to get it.

> 
> > diff --git a/include/uapi/linux/fscrypt.h b/include/uapi/linux/fscrypt.h
> > index 29a945d165def..93d6eabaa7de4 100644
> > --- a/include/uapi/linux/fscrypt.h
> > +++ b/include/uapi/linux/fscrypt.h
> > +
> > +struct fscrypt_key_specifier {
> > +#define FSCRYPT_KEY_SPEC_TYPE_DESCRIPTOR	1
> > +	__u32 type;
> > +	__u32 __reserved;
> 
> Can you move the definition of FSCRYPT_KEY_SPEC_TYPE_DESCRIPTOR
> outside of the structure definition, and then add a comment about what
> is a "descriptor" key spec?  (And then in a later patch, please add a
> comment about what is an "identifier" key type.)  There's an
> explanation in Documentation/filesystems/fscrypt.rst, I know, but a
> one or two line comment plus a pointer to
> Documentation/filesystems/fscrypt.rst in the header file would be
> really helpful.

I'll add a brief comment that explains the key specifier.

I've already added a pointer to Documentation/filesystems/fscrypt.rst at the top
of the header (this was one of the cleanups in v6 => v7):

/*
 * fscrypt user API
 *
 * These ioctls can be used on filesystems that support fscrypt.  See the
 * "User API" section of Documentation/filesystems/fscrypt.rst.
 */

- Eric
