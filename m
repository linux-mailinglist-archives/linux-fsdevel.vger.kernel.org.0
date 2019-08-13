Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4C4F8ABC7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 02:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfHMAHE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 20:07:04 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33893 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726890AbfHMAHD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 20:07:03 -0400
Received: from callcc.thunk.org (guestnat-104-133-9-109.corp.google.com [104.133.9.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7D06i57014906
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Aug 2019 20:06:46 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 3F35E4218EF; Mon, 12 Aug 2019 20:06:44 -0400 (EDT)
Date:   Mon, 12 Aug 2019 20:06:44 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-crypto@vger.kernel.org, keyrings@vger.kernel.org,
        linux-api@vger.kernel.org, Satya Tangirala <satyat@google.com>,
        Paul Crowley <paulcrowley@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v8 10/20] fscrypt: add FS_IOC_REMOVE_ENCRYPTION_KEY ioctl
Message-ID: <20190813000644.GH28705@mit.edu>
References: <20190805162521.90882-1-ebiggers@kernel.org>
 <20190805162521.90882-11-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805162521.90882-11-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +		/* Some inodes still reference this key; try to evict them. */
> +		if (try_to_lock_encrypted_files(sb, mk) != 0)
> +			status_flags |=
> +				FSCRYPT_KEY_REMOVAL_STATUS_FLAG_FILES_BUSY;
> +	}

try_to_lock_encrypted_files() can return other errors besides -EBUSY;
in particular sync_filesystem() can return other errors, such as -EIO
or -EFSCORUPTED.  In that case, I think we're better off returning the
relevant status code back to the user.  We will have already wiped the
master key, but this situation will only happen in exceptional
conditions (e.g., user has ejected the sdcard, etc.), so it's not
worth it to try to undo the master key wipe to try to restore things
to the pre-ioctl execution state.

So I think we should capture the return code from
try_to_lock_encrypted_files, and if it is EBUSY, we can set FILES_BUSY
flag and return success.  Otherwise, we should return the error.

If you agree, please fix that up and then feel free to add:

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

						- Ted
