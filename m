Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE79354AF1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 04:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243426AbhDFCik (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Apr 2021 22:38:40 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37812 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S243408AbhDFCij (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Apr 2021 22:38:39 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1362cNbi030846
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 5 Apr 2021 22:38:24 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6C30615C3399; Mon,  5 Apr 2021 22:38:23 -0400 (EDT)
Date:   Mon, 5 Apr 2021 22:38:23 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
Subject: Re: [PATCH v2 1/2] ext4: Handle casefolding with encryption
Message-ID: <YGvJn09vECHxKCMP@mit.edu>
References: <20210319073414.1381041-1-drosen@google.com>
 <20210319073414.1381041-2-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319073414.1381041-2-drosen@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 19, 2021 at 07:34:13AM +0000, Daniel Rosenberg wrote:
> This adds support for encryption with casefolding.
> 
> Since the name on disk is case preserving, and also encrypted, we can no
> longer just recompute the hash on the fly. Additionally, to avoid
> leaking extra information from the hash of the unencrypted name, we use
> siphash via an fscrypt v2 policy.
> 
> The hash is stored at the end of the directory entry for all entries
> inside of an encrypted and casefolded directory apart from those that
> deal with '.' and '..'. This way, the change is backwards compatible
> with existing ext4 filesystems.
> 
> Signed-off-by: Daniel Rosenberg <drosen@google.com>

Applied, thanks with the following addition so that tests, e2fsprogs,
etc., can determine whether or not the currently running kernel has
this feature enabled:

diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index a3d08276d441..7367ba406e01 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -313,6 +313,7 @@ EXT4_ATTR_FEATURE(verity);
 #endif
 EXT4_ATTR_FEATURE(metadata_csum_seed);
 EXT4_ATTR_FEATURE(fast_commit);
+EXT4_ATTR_FEATURE(encrypted_casefold);
 
 static struct attribute *ext4_feat_attrs[] = {
 	ATTR_LIST(lazy_itable_init),
@@ -330,6 +331,7 @@ static struct attribute *ext4_feat_attrs[] = {
 #endif
 	ATTR_LIST(metadata_csum_seed),
 	ATTR_LIST(fast_commit),
+	ATTR_LIST(encrypted_casefold),
 	NULL,
 };
 ATTRIBUTE_GROUPS(ext4_feat);


Future versions of e2fsprogs may issue a warning if tune2fs or mke2fs
tries to modify or create a file system such that both the encryption
and casefold feature is enabled if it appears that the kernel won't
support this combination.  Daniel, if you could try to get this change
into the Android kernels that are using encrypted casefold, that would
be a good thing.

					- Ted
