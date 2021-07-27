Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBD53D8333
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 00:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbhG0Wmr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 18:42:47 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57098 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbhG0Wmr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 18:42:47 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7B63021E78;
        Tue, 27 Jul 2021 22:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627425765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jpgPD5RojPABcTMZULE6R7dcTBRiP3N2liSuqkAN1xY=;
        b=LMyD+4WcK7zDEfC+MFkXkbm4u0MMKJhZGrx3wykC6W5yYa8VGzDLSZnYVjS+rqnbFutBxS
        Ki/1B0Yv9VgP1fDcCv6AjsXN/IYBIUiat7mOfYOrEmHIDVditzSwcSBP1L7hYo0pQLFmxU
        RJ7sbGkalpJtTVIbeczlQ6GRrwSm8Dk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627425765;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jpgPD5RojPABcTMZULE6R7dcTBRiP3N2liSuqkAN1xY=;
        b=gQl3LzlyrzrgRj1iFmV9PwaZk0LRCtv5DDnAgMdZXrYf/Oz4vtZfIj8oCo+gNm/pC1dgwc
        Mg4KAEtZ5NLNALBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 95D3013A5D;
        Tue, 27 Jul 2021 22:42:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hvjwFOKLAGGVVQAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 27 Jul 2021 22:42:42 +0000
Subject: [PATCH 02/11] VFS: allow d_automount to create in-place bind-mount.
From:   NeilBrown <neilb@suse.de>
To:     Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Date:   Wed, 28 Jul 2021 08:37:45 +1000
Message-ID: <162742546549.32498.76256513179684921.stgit@noble.brown>
In-Reply-To: <162742539595.32498.13687924366155737575.stgit@noble.brown>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

finish_automount() prevents a mount trap from mounting a dentry onto
itself, as this could cause a loop - repeatedly automounting.  There is
nothing intrinsically wrong with this arrangement, and the d_automount
function can easily avoid the loop.  btrfs will use it to expose subvols
in the mount table.

It may well be a problem to mount a dentry onto itself when it is
already the root of the vfsmount, so narrow the test to only check that
case.

The test on mnt_sb is redundant and has been removed.  path->mnt and
path->dentry must have the same sb, so if m->mnt_root == dentry, then
m->mnt_sb must be the same as path->mnt->mnt_sb.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/namespace.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index ab4174a3c802..81b0f2b2e701 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2928,7 +2928,7 @@ int finish_automount(struct vfsmount *m, struct path *path)
 	 */
 	BUG_ON(mnt_get_count(mnt) < 2);
 
-	if (m->mnt_sb == path->mnt->mnt_sb &&
+	if (m->mnt_root == path->mnt->mnt_root &&
 	    m->mnt_root == dentry) {
 		err = -ELOOP;
 		goto discard;


