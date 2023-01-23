Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600EB677832
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 11:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjAWKGA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 05:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjAWKF7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 05:05:59 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F68610F;
        Mon, 23 Jan 2023 02:05:58 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C82F81F86B;
        Mon, 23 Jan 2023 10:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674468356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1SH4cG+K9PIUmuCGlaDzJqg6vm0VNBfB4+WWhDCmF2c=;
        b=l7Q1mt+TA0L5LVazeKsyDD5epfLdI81Q3imn+r8qyrCPXeJywMd8T5OBOi20sGS/AqVs25
        BbFWsUPfbPh5Rd9q3QvUKpVIxWNO91iWWXGMzQcOV71Gzs2hUP5o7jI22Ld0HbwFMWe7+1
        vbtSZ18wlppoTUFcgaAVXo1Ajb2ilxc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674468356;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1SH4cG+K9PIUmuCGlaDzJqg6vm0VNBfB4+WWhDCmF2c=;
        b=9rCaJAYUzNnz+++slorjf+1wMNKNPFMGMSPcK8i79W3CAM5A4IylIb7i/HKrBhpZKJCb54
        4BZVjfoxkUdZsnCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B75CB134F5;
        Mon, 23 Jan 2023 10:05:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OtXBLARczmOsDwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 23 Jan 2023 10:05:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4CBEBA06B5; Mon, 23 Jan 2023 11:05:56 +0100 (CET)
Date:   Mon, 23 Jan 2023 11:05:56 +0100
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Steve French <smfrench@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [GIT PULL] gfs2 writepage fix
Message-ID: <20230123100556.qxdjdmcms5ven52v@quack3>
References: <20230122090115.1563753-1-agruenba@redhat.com>
 <CAHk-=wgjMNbNG0FMatHtmzEZPj0ZmQpNRsnRvH47igJoC9TBww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgjMNbNG0FMatHtmzEZPj0ZmQpNRsnRvH47igJoC9TBww@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 22-01-23 12:05:53, Linus Torvalds wrote:
> On Sun, Jan 22, 2023 at 1:01 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> >
> > gfs2 writepage fix
> >
> > - Fix a regression introduced by commit "gfs2: stop using
> >   generic_writepages in gfs2_ail1_start_one".
> 
> Hmm. I'm adding a few more people and linux-fsdevel to the reply,
> because we had a number of filesystems remove writepages use lately,
> including some that did it as a fix after the merge window.
> 
> Everybody involved seemed to claim it was just a no-brainer
> switch-over, and I just took that on faith. Now it looks like that
> wasn't true at least for gfs2 due to different semantics.
> 
> Maybe the gfs2 issue is purely because of how gfs2 did the conversion
> (generic_writepages -> filemap_fdatawrite_wbc), but let's make people
> look at their own cases.

Thanks for the heads up. So we had kind of a similar issue for ext4 but it
got caught by Ted during his regression runs so we've basically done what
GFS2 is doing for the merge window and now there's patchset pending to
convert the data=journal path as well because as Andreas states in his
changelog of the revert that's a bit more tricky. But at least for ext4
the conversion of data=journal path resulted in much cleaner and shorter
code.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
