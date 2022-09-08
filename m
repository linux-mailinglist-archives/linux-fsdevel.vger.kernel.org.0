Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F755B171B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Sep 2022 10:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbiIHIdg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 04:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiIHId3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:33:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4450E1A96;
        Thu,  8 Sep 2022 01:33:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7CA5F22486;
        Thu,  8 Sep 2022 08:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662626007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8sjzYxBjz9/JeFT8Y7oHbqmg7W+DAyx1ya6iI90ZaMQ=;
        b=G99I5obrt4hV3c27dz2o4YfAIhoIVrbbH3dfLPAMW0LzbBqu0EvtmmhrUcACOb2o9ed70/
        cNXhGP9N/+SW8xSfPOoGS+uL+IcwKESwEcFuRCZSQaJZZy4oj7W1K/mG+gn7S20YmAbsz1
        rqsKa2EzYzVRz173gUhOyD7GM3th61E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662626007;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8sjzYxBjz9/JeFT8Y7oHbqmg7W+DAyx1ya6iI90ZaMQ=;
        b=+whd4o3JKfEbh5M21ThDe8yY7TUw+sX0ZNwz+FFg91wQqsJpbtfAwaWS5pMeJQ6pxu12Mo
        I/KruOUqr3Z7G+Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 68BFC1322C;
        Thu,  8 Sep 2022 08:33:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 95yKGdeoGWNILwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 08 Sep 2022 08:33:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id EE081A067E; Thu,  8 Sep 2022 10:33:26 +0200 (CEST)
Date:   Thu, 8 Sep 2022 10:33:26 +0200
From:   Jan Kara <jack@suse.cz>
To:     NeilBrown <neilb@suse.de>
Cc:     Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>, tytso@mit.edu,
        adilger.kernel@dilger.ca, djwong@kernel.org, david@fromorbit.com,
        trondmy@hammerspace.com, viro@zeniv.linux.org.uk,
        zohar@linux.ibm.com, xiubli@redhat.com, chuck.lever@oracle.com,
        lczerner@redhat.com, brauner@kernel.org, fweimer@redhat.com,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
Message-ID: <20220908083326.3xsanzk7hy3ff4qs@quack3>
References: <20220907111606.18831-1-jlayton@kernel.org>
 <166255065346.30452.6121947305075322036@noble.neil.brown.name>
 <79aaf122743a295ddab9525d9847ac767a3942aa.camel@kernel.org>
 <20220907125211.GB17729@fieldses.org>
 <771650a814ab1ff4dc5473d679936b747d9b6cf5.camel@kernel.org>
 <20220907135153.qvgibskeuz427abw@quack3>
 <166259786233.30452.5417306132987966849@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166259786233.30452.5417306132987966849@noble.neil.brown.name>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 08-09-22 10:44:22, NeilBrown wrote:
> On Wed, 07 Sep 2022, Jan Kara wrote:
> > On Wed 07-09-22 09:12:34, Jeff Layton wrote:
> > > On Wed, 2022-09-07 at 08:52 -0400, J. Bruce Fields wrote:
> > > > On Wed, Sep 07, 2022 at 08:47:20AM -0400, Jeff Layton wrote:
> > > > > On Wed, 2022-09-07 at 21:37 +1000, NeilBrown wrote:
> > > > > > On Wed, 07 Sep 2022, Jeff Layton wrote:
> > > > > > > +The change to \fIstatx.stx_ino_version\fP is not atomic with respect to the
> > > > > > > +other changes in the inode. On a write, for instance, the i_version it usually
> > > > > > > +incremented before the data is copied into the pagecache. Therefore it is
> > > > > > > +possible to see a new i_version value while a read still shows the old data.
> > > > > > 
> > > > > > Doesn't that make the value useless?
> > > > > > 
> > > > > 
> > > > > No, I don't think so. It's only really useful for comparing to an older
> > > > > sample anyway. If you do "statx; read; statx" and the value hasn't
> > > > > changed, then you know that things are stable. 
> > > > 
> > > > I don't see how that helps.  It's still possible to get:
> > > > 
> > > > 		reader		writer
> > > > 		------		------
> > > > 				i_version++
> > > > 		statx
> > > > 		read
> > > > 		statx
> > > > 				update page cache
> > > > 
> > > > right?
> > > > 
> > > 
> > > Yeah, I suppose so -- the statx wouldn't necessitate any locking. In
> > > that case, maybe this is useless then other than for testing purposes
> > > and userland NFS servers.
> > > 
> > > Would it be better to not consume a statx field with this if so? What
> > > could we use as an alternate interface? ioctl? Some sort of global
> > > virtual xattr? It does need to be something per-inode.
> > 
> > I was thinking how hard would it be to increment i_version after updating
> > data but it will be rather hairy. In particular because of stuff like
> > IOCB_NOWAIT support which needs to bail if i_version update is needed. So
> > yeah, I don't think there's an easy way how to provide useful i_version for
> > general purpose use.
> > 
> 
> Why cannot IOCB_NOWAIT update i_version?  Do we not want to wait on the
> cmp_xchg loop in inode_maybe_inc_iversion(), or do we not want to
> trigger an inode update?
> 
> The first seems unlikely, but the second seems unreasonable.  We already
> acknowledge that after a crash iversion might go backwards and/or miss
> changes.

It boils down to the fact that we don't want to call mark_inode_dirty()
from IOCB_NOWAIT path because for lots of filesystems that means journal
operation and there are high chances that may block.

Presumably we could treat inode dirtying after i_version change similarly
to how we handle timestamp updates with lazytime mount option (i.e., not
dirty the inode immediately but only with a delay) but then the time window
for i_version inconsistencies due to a crash would be much larger.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
