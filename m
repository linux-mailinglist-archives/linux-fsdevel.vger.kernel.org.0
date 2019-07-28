Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24464780FB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jul 2019 20:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbfG1Su0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Jul 2019 14:50:26 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36980 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726098AbfG1Su0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Jul 2019 14:50:26 -0400
Received: from callcc.thunk.org (96-72-102-169-static.hfc.comcastbusiness.net [96.72.102.169] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x6SIo4Jb028047
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Jul 2019 14:50:05 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 68A2E4202F5; Sun, 28 Jul 2019 14:50:03 -0400 (EDT)
Date:   Sun, 28 Jul 2019 14:50:03 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-api@vger.kernel.org,
        linux-crypto@vger.kernel.org, keyrings@vger.kernel.org,
        Paul Crowley <paulcrowley@google.com>,
        Satya Tangirala <satyat@google.com>
Subject: Re: [PATCH v7 06/16] fscrypt: add FS_IOC_ADD_ENCRYPTION_KEY ioctl
Message-ID: <20190728185003.GF6088@mit.edu>
References: <20190726224141.14044-1-ebiggers@kernel.org>
 <20190726224141.14044-7-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726224141.14044-7-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 26, 2019 at 03:41:31PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Add a new fscrypt ioctl, FS_IOC_ADD_ENCRYPTION_KEY.  This ioctl adds an
> encryption key to the filesystem's fscrypt keyring ->s_master_keys,
> making any files encrypted with that key appear "unlocked".

Note: it think it's going to be useful to make the keyring id
available someplace like /sys/fs/<fs>/<blkdev>/keyring, or preferably
in the new fsinfo system call.  Yes, the system administrator can paw
through /proc/keys and try to figure it out, but it will be nicer if
there's a direct way to do that.

For that matter, we could just add a new ioctl which returns the file
system's keyring id.  That way an application program won't have to
try to figure out what a file's underlying sb->s_id happens to be.
(Especially if things like overlayfs are involved.)

> diff --git a/include/uapi/linux/fscrypt.h b/include/uapi/linux/fscrypt.h
> index 29a945d165def..93d6eabaa7de4 100644
> --- a/include/uapi/linux/fscrypt.h
> +++ b/include/uapi/linux/fscrypt.h
> +
> +struct fscrypt_key_specifier {
> +#define FSCRYPT_KEY_SPEC_TYPE_DESCRIPTOR	1
> +	__u32 type;
> +	__u32 __reserved;

Can you move the definition of FSCRYPT_KEY_SPEC_TYPE_DESCRIPTOR
outside of the structure definition, and then add a comment about what
is a "descriptor" key spec?  (And then in a later patch, please add a
comment about what is an "identifier" key type.)  There's an
explanation in Documentation/filesystems/fscrypt.rst, I know, but a
one or two line comment plus a pointer to
Documentation/filesystems/fscrypt.rst in the header file would be
really helpful.

Otherwise, it looks good.   Feel free to add:

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

						- Ted
