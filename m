Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113C04B5931
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Feb 2022 18:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357297AbiBNR5L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Feb 2022 12:57:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343923AbiBNR5J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Feb 2022 12:57:09 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B418264F;
        Mon, 14 Feb 2022 09:57:01 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B96621F38C;
        Mon, 14 Feb 2022 17:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644861419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Jq4WqG3JZ35tq42akxSVeRM5DeTqRbbqqNWJfU6p8A=;
        b=W3NcQSq/4lKdyRgNGNNKI9g28eZ1u/cj4aXK890sgqcyfbMtpvahbVtGPJxP//RHv0gz4t
        6jL9KRfB1vxxaq9CjMdrzwRAOLXsK41nOsGDmZqS9znRWj6e0GitgfWEAx99B7BUl8gmz+
        uXdi+SAzj2lpckXuHzWklyf4poFMu8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644861419;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Jq4WqG3JZ35tq42akxSVeRM5DeTqRbbqqNWJfU6p8A=;
        b=LdjAUOexVj6ZjbndOjsmakZXDV4AEx4s+5Z+QYvMWT9hXRAexTcWvjGnAnAD59843zCs3p
        ScC1+K9GlfyyT1Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 614ED13398;
        Mon, 14 Feb 2022 17:56:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id s2gdFeuXCmIfNAAAMHmgww
        (envelope-from <lhenriques@suse.de>); Mon, 14 Feb 2022 17:56:59 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 710d1935;
        Mon, 14 Feb 2022 17:57:13 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, idryomov@gmail.com
Subject: Re: [RFC PATCH v10 00/48] ceph+fscrypt: full support
References: <20220111191608.88762-1-jlayton@kernel.org>
Date:   Mon, 14 Feb 2022 17:57:13 +0000
In-Reply-To: <20220111191608.88762-1-jlayton@kernel.org> (Jeff Layton's
        message of "Tue, 11 Jan 2022 14:15:20 -0500")
Message-ID: <87r185tjpi.fsf@brahms.olymp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff Layton <jlayton@kernel.org> writes:

> This patchset represents a (mostly) complete rough draft of fscrypt
> support for cephfs. The context, filename and symlink support is more or
> less the same as the versions posted before, and comprise the first half
> of the patches.
>
> The new bits here are the size handling changes and support for content
> encryption, in buffered, direct and synchronous codepaths. Much of this
> code is still very rough and needs a lot of cleanup work.
>
> fscrypt support relies on some MDS changes that are being tracked here:
>
>     https://github.com/ceph/ceph/pull/43588
>

Please correct me if I'm wrong (and I've a feeling that I *will* be
wrong): we're still missing some mechanism that prevents clients that do
not support fscrypt from creating new files in an encryption directory,
right?  I'm pretty sure I've discussed this "somewhere" with "someone",
but I can't remember anything else.

At this point, I can create an encrypted directory and, from a different
client (that doesn't support fscrypt), create a new non-encrypted file in
that directory.  The result isn't good, of course.

I guess that a new feature bit can be used so that the MDS won't allow any
sort of operations (or, at least, write/create operations) on encrypted
dirs from clients that don't have this bit set.

So, am I missing something or is this still on the TODO list?

(I can try to have a look at it if this is still missing.)

Cheers,
--=20
Lu=C3=ADs


>
> In particular, this PR adds some new opaque fields in the inode that we
> use to store fscrypt-specific information, like the context and the real
> size of a file. That is slated to be merged for the upcoming Quincy
> release (which is sometime this northern spring).
>
> There are still some notable bugs:
>
> 1/ we've identified a few more potential races in truncate handling
> which will probably necessitate a protocol change, as well as changes to
> the MDS and kclient patchsets. The good news is that we think we have
> an approach that will resolve this.
>
> 2/ the kclient doesn't handle reading sparse regions in OSD objects
> properly yet. The client can end up writing to a non-zero offset in a
> non-existent object. Then, if the client tries to read the written
> region back later, it'll get back zeroes and give you garbage when you
> try to decrypt them.
>
> It turns out that the OSD already supports a SPARSE_READ operation, so
> I'm working on implementing that in the kclient to make it not try to
> decrypt the sparse regions.
>
> Still, I was able to run xfstests on this set yesterday. Bug #2 above
> prevented all of the tests from passing, but it didn't oops! I call that
> progress! Given that, I figured this is a good time to post what I have
> so far.
>
> Note that the buffered I/O changes in this set are not suitable for
> merge and will likely end up being discarded. We need to plumb the
> encryption in at the netfs layer, so that we can store encrypted data
> in fscache.
>
> The non-buffered codepaths will likely also need substantial changes
> before merging. It may be simpler to just move that into the netfs layer
> too as cifs will need something similar anyway.
>
> My goal is to get most of this into v5.18, but v5.19 might be more
> realistiv. Hopefully I'll have a non-RFC patchset to send in a few
> weeks.
>
> Special thanks to Xiubo who came through with the MDS patches. Also,
> thanks to everyone (especially Eric Biggers) for all of the previous
> reviews. It's much appreciated!
>
> Jeff Layton (43):
>   vfs: export new_inode_pseudo
>   fscrypt: export fscrypt_base64url_encode and fscrypt_base64url_decode
>   fscrypt: export fscrypt_fname_encrypt and fscrypt_fname_encrypted_size
>   fscrypt: add fscrypt_context_for_new_inode
>   ceph: preallocate inode for ops that may create one
>   ceph: crypto context handling for ceph
>   ceph: parse new fscrypt_auth and fscrypt_file fields in inode traces
>   ceph: add fscrypt_* handling to caps.c
>   ceph: add ability to set fscrypt_auth via setattr
>   ceph: implement -o test_dummy_encryption mount option
>   ceph: decode alternate_name in lease info
>   ceph: add fscrypt ioctls
>   ceph: make ceph_msdc_build_path use ref-walk
>   ceph: add encrypted fname handling to ceph_mdsc_build_path
>   ceph: send altname in MClientRequest
>   ceph: encode encrypted name in dentry release
>   ceph: properly set DCACHE_NOKEY_NAME flag in lookup
>   ceph: make d_revalidate call fscrypt revalidator for encrypted
>     dentries
>   ceph: add helpers for converting names for userland presentation
>   ceph: add fscrypt support to ceph_fill_trace
>   ceph: add support to readdir for encrypted filenames
>   ceph: create symlinks with encrypted and base64-encoded targets
>   ceph: make ceph_get_name decrypt filenames
>   ceph: add a new ceph.fscrypt.auth vxattr
>   ceph: add some fscrypt guardrails
>   libceph: add CEPH_OSD_OP_ASSERT_VER support
>   ceph: size handling for encrypted inodes in cap updates
>   ceph: fscrypt_file field handling in MClientRequest messages
>   ceph: get file size from fscrypt_file when present in inode traces
>   ceph: handle fscrypt fields in cap messages from MDS
>   ceph: add infrastructure for file encryption and decryption
>   libceph: allow ceph_osdc_new_request to accept a multi-op read
>   ceph: disable fallocate for encrypted inodes
>   ceph: disable copy offload on encrypted inodes
>   ceph: don't use special DIO path for encrypted inodes
>   ceph: set encryption context on open
>   ceph: align data in pages in ceph_sync_write
>   ceph: add read/modify/write to ceph_sync_write
>   ceph: plumb in decryption during sync reads
>   ceph: set i_blkbits to crypto block size for encrypted inodes
>   ceph: add fscrypt decryption support to ceph_netfs_issue_op
>   ceph: add encryption support to writepage
>   ceph: fscrypt support for writepages
>
> Luis Henriques (1):
>   ceph: don't allow changing layout on encrypted files/directories
>
> Xiubo Li (4):
>   ceph: add __ceph_get_caps helper support
>   ceph: add __ceph_sync_read helper support
>   ceph: add object version support for sync read
>   ceph: add truncate size handling support for fscrypt
>
>  fs/ceph/Makefile                |   1 +
>  fs/ceph/acl.c                   |   4 +-
>  fs/ceph/addr.c                  | 128 +++++--
>  fs/ceph/caps.c                  | 211 ++++++++++--
>  fs/ceph/crypto.c                | 374 +++++++++++++++++++++
>  fs/ceph/crypto.h                | 237 +++++++++++++
>  fs/ceph/dir.c                   | 209 +++++++++---
>  fs/ceph/export.c                |  44 ++-
>  fs/ceph/file.c                  | 476 +++++++++++++++++++++-----
>  fs/ceph/inode.c                 | 576 +++++++++++++++++++++++++++++---
>  fs/ceph/ioctl.c                 |  87 +++++
>  fs/ceph/mds_client.c            | 349 ++++++++++++++++---
>  fs/ceph/mds_client.h            |  24 +-
>  fs/ceph/super.c                 |  90 ++++-
>  fs/ceph/super.h                 |  43 ++-
>  fs/ceph/xattr.c                 |  29 ++
>  fs/crypto/fname.c               |  44 ++-
>  fs/crypto/fscrypt_private.h     |   9 +-
>  fs/crypto/hooks.c               |   6 +-
>  fs/crypto/policy.c              |  35 +-
>  fs/inode.c                      |   1 +
>  include/linux/ceph/ceph_fs.h    |  21 +-
>  include/linux/ceph/osd_client.h |   6 +-
>  include/linux/ceph/rados.h      |   4 +
>  include/linux/fscrypt.h         |  10 +
>  net/ceph/osd_client.c           |  32 +-
>  26 files changed, 2700 insertions(+), 350 deletions(-)
>  create mode 100644 fs/ceph/crypto.c
>  create mode 100644 fs/ceph/crypto.h
>
> --=20
> 2.34.1
>

