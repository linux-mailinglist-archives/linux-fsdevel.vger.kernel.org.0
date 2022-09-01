Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBC15A89D2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 02:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbiIAAcS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 20:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbiIAAcA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 20:32:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452E71286D3;
        Wed, 31 Aug 2022 17:31:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E5D541F93C;
        Thu,  1 Sep 2022 00:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1661992275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cB5mAmPpEkOcXxok3N7b2GrWhRqZB8p53F8wFBIAkgA=;
        b=dlfoKuHeD/b/aFrx0y8MKmQABrwPUZp95hZoAmKmszg87jChSQRVJ+5eR+2C8l9UycuJP6
        eR2QuaWatey+SErOxRoRqjnn+XFOisH497tOdl3bwXbX/0mrxipFu2/INahDAlXqgzm5mO
        FlHC5FUqTjXmqF+J5ietPoM4cLM0Uiw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1661992275;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cB5mAmPpEkOcXxok3N7b2GrWhRqZB8p53F8wFBIAkgA=;
        b=dT21YSs8moxMqfTRyWdY0SNbZvmF65bS+/ZDDqvSBg8pgkoGnXK2gC2JgmKIBgtjdX5mEJ
        Ad82s1ARj7b8xqBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 51F30133DD;
        Thu,  1 Sep 2022 00:31:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Pt/+A1H9D2NqLwAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 01 Sep 2022 00:31:13 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Al Viro" <viro@zeniv.linux.org.uk>
Cc:     "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Daire Byrne" <daire@dneg.com>,
        "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        "Chuck Lever" <chuck.lever@oracle.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        "LKML" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/10] VFS: support parallel updates in the one directory.
In-reply-to: <YwlifYSJYzovBKGB@ZenIV>
References: <166147828344.25420.13834885828450967910.stgit@noble.brown>,
 <166147984370.25420.13019217727422217511.stgit@noble.brown>,
 <CAHk-=wi_wwTxPTnFXsG8zdaem5YDnSd4OsCeP78yJgueQCb-1g@mail.gmail.com>,
 <YwlifYSJYzovBKGB@ZenIV>
Date:   Thu, 01 Sep 2022 10:31:10 +1000
Message-id: <166199227016.17668.15373771428363682061@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 27 Aug 2022, Al Viro wrote:
> On Fri, Aug 26, 2022 at 12:06:55PM -0700, Linus Torvalds wrote:
> 
> > Because right now I think the main reason we cannot move the lock into
> > the filesystem is literally that we've made the lock cover not just
> > the filesystem part, but the "lookup and create dentry" part too.
> 
> How about rename loop prevention?  mount vs. rmdir?  d_splice_alias()
> fun on tree reconnects?

Thanks for this list.

I think the "mount vs. rmdir" usage of inode_lock() is independent of
the usage for directory operations, so we can change the latter as much
as we like without materially affecting the former.

The lock we take on the directory being removed DOES ensure no new
objects are linked into the directory, so for that reason we still need
at least a shared lock when adding links to a directory.
Moving that lock into the filesystem would invert the locking order in
rmdir between the child being removed and the parent being locked.  That
would require some consideration.

d_splice_alias() happens at ->lookup time so it is already under a
shared lock.  I don't see that it depends on i_rwsem - it uses i_lock
for the important locking.

Rename loop prevention is largely managed by s_vfs_rename_mutex.  Once
that is taken, nothing can be moved to a different directory.  That
means 'trap' will keep any relationship it had to new_path and old_path.
It could be renamed within it's parent, but as long as it isn't removed
the comparisons with old_dentry and new_dentry should still be reliable.
As 'trap' clearly isn't empty, we trust that the filesystem won't allow
an rmdir to succeed.

What have I missed?

Thanks,
NeilBrown

> 
> > But once you have that "DCACHE_PAR_LOOKUP" bit and the
> > d_alloc_parallel() logic to serialize a _particular_ dentry being
> > created (as opposed to serializing all the sleeping ops to that
> > directly), I really think we should strive to move the locking - that
> > no longer helps the VFS dcache layer - closer to the filesystem call
> > and eventually into it.
> 
> See above.
> 
