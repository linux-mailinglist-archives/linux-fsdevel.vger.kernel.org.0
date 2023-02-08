Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B8668F805
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Feb 2023 20:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbjBHT2d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Feb 2023 14:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjBHT2c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Feb 2023 14:28:32 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5976E1EFEA;
        Wed,  8 Feb 2023 11:28:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 95F6ACE22A9;
        Wed,  8 Feb 2023 19:28:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBF19C433AA;
        Wed,  8 Feb 2023 19:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675884505;
        bh=uzsSWtQHYWi5gC6am38WANL2mSxXqz9ElGrAHKqEdms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZW78vMNlqHcmI4XxIvqJDPhSOCShn6TyxmtL7nbQaPaHsXELyZXk0Fca0NQ9fGRwB
         tYTbA5ww+IZ9pxZUDf4zK3M2Nqfc3MSYmXtnvSejrt/SFsBGCAMLeiXSO+Veqoe+A4
         bUvP7wOnMlX5Lcoix/PLfGBWerXkJfVuQfqG0C/3FK9YyZxYtIiouGRZBBlw8S9Cdi
         /VGvfcWhO5Foy00sGa13x/8H0FIdP1lxygcG2uprCV7jc4ygRsvi9LES8h5r2PwkKj
         kPWarv3Yay7D6r4xe7Ef/lyHVxwe9nOrbjWDtIgfh7TPS4o9Ptah6g09BeMus49vu7
         CClFpCMHb5nRg==
Date:   Wed, 8 Feb 2023 19:28:02 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Sebastien Buisson <sbuisson.work@gmail.com>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: Backup/restore of fscrypt files and directories
Message-ID: <Y+P3wumJK/znOKgl@gmail.com>
References: <03a87391-1b19-de2d-5c18-581c1d0c47ca@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <03a87391-1b19-de2d-5c18-581c1d0c47ca@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Sebastien,

On Wed, Feb 08, 2023 at 01:09:50PM +0100, Sebastien Buisson wrote:
> I am planning to implement backup and restore for fscrypt files and
> directories and propose the following design, and would welcome feedback on
> this approach.

Thanks for looking into this.  Before getting too far into the details of your
proposal, are you aware of the previous threads about this?  Specifically:

"backup/restore of fscrypt files"
(https://lore.kernel.org/linux-fscrypt/D1AD7D55-94D6-4C19-96B4-BAD0FD33CF49@dilger.ca/T/#u)

And the discussion that happened as part of
"[PATCH RERESEND v9 0/9] fs: interface for directly reading/writing compressed data"
(https://lore.kernel.org/linux-fsdevel/CAHk-=wh74eFxL0f_HSLUEsD1OQfFNH9ccYVgCXNoV1098VCV6Q@mail.gmail.com
and its responses).

Both times before, it was brought up that the hardest part is backing up and
restoring the filenames, including symlinks.  I don't think your proposal really
addresses that.  Your proposal has a single filename in the security.encdata
xattr.  But actually, a file can have many names.  Also, a file can have an
encrypted name without being encrypted itself; that's the case for device node,
socket, and FIFO files.  Also, symlinks have their target encrypted.

I think that your proposal, in general, needs more detail about how *restores*
will work, since that's going to be much harder than backups.  It's not hard to
get the filesystem to give you more information; it's much harder to make
changes to a filesystem while keeping everything self-consistent!

A description of the use cases of this feature would also be helpful.
Historically, people have said they needed this feature when they really didn't.

> The third challenge is to get access to the encryption context of files and
> directories. By design, fscrypt does not expose this information, internally
> stored as an extended attribute but with no associated handler.

Actually, FS_IOC_GET_ENCRYPTION_POLICY_EX and FS_IOC_GET_ENCRYPTION_NONCE
together give you all the information stored in the encryption context.

> In order to address this need for backup/restore of encrypted files, we
> propose to make use of a special extended attribute named security.encdata,
> containing:
> - encoding method used for binary data. Assume name can be up to 255 chars.
> - clear text file data length in bytes (set to 0 for dirs).

st_size already gives the plaintext file length, even while the encryption key
is not present.

> - encryption context. 40 bytes for v2 encryption context.
> - encrypted name. 256 bytes max.
> 
> To improve portability if we need to change the on-disk format in the
> future, and to make the archived data useful over a longer timeframe, the
> content of the security.encdata xattr is expressed as ASCII text with a
> "key: value" YAML format. As encryption context and encrypted file name are
> binary, they need to be encoded.
> So the content of the security.encdata xattr would be something like:
> 
>   { encoding: base64url, size: 3012, enc_ctx: YWJjZGVmZ2hpamtsbW
>   5vcHFyc3R1dnd4eXphYmNkZWZnaGlqa2xtbg, enc_name: ZmlsZXdpdGh2ZX
>   J5bG9uZ25hbWVmaWxld2l0aHZlcnlsb25nbmFtZWZpbGV3aXRodmVyeWxvbmdu
>   YW1lZmlsZXdpdGg }
> 
> Because base64 encoding has a 33% overhead, this gives us a maximum xattr
> size of approximately 800 characters.
> This extended attribute would not be shown when listing xattrs, only exposed
> when fetched explicitly, and unmodified tools would not be able to access
> the encrypted files in any case. It would not be stored on disk, only
> computed when fetched.

An xattr containing multiple key-value pairs is quite strange, since xattrs
themselves are key-value pairs.  This could just be multiple xattrs.

Did you choose this design because you intend for this to be treated as an
opaque blob that userspace must not interpret at all?

> File and file system backups often use the tar utility either directly or
> under the covers. We propose to modify the tar utility to make it
> "encryption aware", but the same relatively small changes could be done with
> other common backup utilities like cpio as needed. When detecting ext4
> encrypted files, tar would need to explicitly fetch the security.encdata
> extended attribute, and store it along with the backup file. Fetching this
> extended attribute would internally trigger in ext4 a mechanism responsible
> for gathering the required information. Because we must not make any clear
> text copy of encrypted files, the encryption key must not be present.

Why can't the encryption key be present during backup?  Surely some people are
going to want to back up encrypted files consistently in ciphertext form,
regardless of whether the key happens to be present or not at the particular
time the backup is being done?  Consider e.g. a bunch of user home directories
which are regularly being locked and unlocked, and the system administrator is
taking backups of everything.

> Tar
> would also need to use a special flag that would allow reading raw data
> without the encryption key. Such a flag could be named O_FILE_ENC, and would
> need to be coupled with O_DIRECT so that the page cache does not see this
> raw data. O_FILE_ENC could take the value of (O_NOCTTY | O_NDELAY) as they
> are unlikely to be used in practice and are not harmful if used incorrectly.

Maybe call this O_CIPHERTEXT?  Also note that a new RWF_* flag to preadv2,
instead of a new O_* flag to open(), has been suggested before.

> The name of the backed-up file would be the encoded+digested form returned
> by fscrypt.

Does this have a meaning, since the actual name would be stored separately?

> The tar utility would be used to extract a previously created tarball
> containing encrypted files. When restoring the security.encdata extended
> attribute, instead of storing the xattr as-is on disk, this would internally
> trigger in ext4 a mechanism responsible for extracting the required
> information, and storing them accordingly. Tar would also need to specify
> the O_FILE_ENC | O_DIRECT flags to write raw data without the encryption
> key.
> 
> To create a valid encrypted file with proper encryption context and
> encrypted name, we can implement a mechanism where the file is first created
> with O_TMPFILE in the encrypted directory to avoid triggering the encryption
> context check before setting the security.encdata xattr, and then atomically
> linking it to the namespace with the correct encrypted name.

How exactly does the link to the correct name happen?  What if there's more than
one name?  What about restoring non-regular files?

> The security.encdata extended attribute contains the encryption context of
> the file or directory. This has a 16-byte nonce (per-file random value) that
> is used along with the master key to derive the per-file key thanks to a KDF
> function. But the master key is not stored in ext4, so it is not backed up
> as part of the scenario described above, which makes the backup of the raw
> encrypted files safe.

Side note: the backup/restore support will need to be disabled on files that use
FSCRYPT_POLICY_FLAG_IV_INO_LBLK_64 or FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32, since
those files are tied to the filesystem they are on.

- Eric
