Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7316EA84A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 12:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjDUKYI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 06:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbjDUKYF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 06:24:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EC99016;
        Fri, 21 Apr 2023 03:23:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7651721A27;
        Fri, 21 Apr 2023 10:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682072634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cO98WjpLnKzbhvXvYHzR4JeJNriOWh1/Af9bFncN/i8=;
        b=AuJkSwrP90R+MVtx2igqjsiRdCKDM59nlAKKpuS/eUqSRAjSC0Imi0d+EgLbxksW9FnXog
        Ay1ukngqOGv0ypHAmjWOcFv1Cmf4w4cNrekqGErZkW5ONv2p4Ntpjrp0iSYomHfN2iLifg
        Kp2rKnAa4AKW9GFRNQHSlC6pT0bz/8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682072634;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cO98WjpLnKzbhvXvYHzR4JeJNriOWh1/Af9bFncN/i8=;
        b=otDAQ5ed1MEY4ABWsMgBA+Rq+33mWUeXLSe4ioruzGgwkVg7AN/+yHTaOlBgY133KaGU8r
        9zDTMd6ZvfeJhRBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 61E201390E;
        Fri, 21 Apr 2023 10:23:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yeTcFzpkQmTtbQAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 21 Apr 2023 10:23:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E0F91A0729; Fri, 21 Apr 2023 12:23:53 +0200 (CEST)
Date:   Fri, 21 Apr 2023 12:23:53 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH 1/3][RESEND] fs: add infrastructure for opportunistic
 high-res ctime/mtime updates
Message-ID: <20230421102353.blzqjrglgyiupf3g@quack3>
References: <20230411143702.64495-1-jlayton@kernel.org>
 <20230411143702.64495-2-jlayton@kernel.org>
 <20230411-unwesen-prunk-cb7de3cc6cc8@brauner>
 <c63c4c811cfa6c6396674e497920ec984cb476d1.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c63c4c811cfa6c6396674e497920ec984cb476d1.camel@kernel.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 11-04-23 12:04:36, Jeff Layton wrote:
> On Tue, 2023-04-11 at 17:07 +0200, Christian Brauner wrote:
> > On Tue, Apr 11, 2023 at 10:37:00AM -0400, Jeff Layton wrote:
> > There's some performance concerns here. Calling
> > stat() is super common and it would potentially make the next iop more
> > expensive. Recursively changing ownership in the container use-case come
> > to mind which are already expensive.
> 
> stat() is common, but not generally as common as write calls are. I
> expect that we'll get somewhat similar results tochanged i_version over
> to use a similar QUERIED flag.
> 
> The i_version field was originally very expensive and required metadata
> updates on every write. After making that change, we got the same
> performance back in most tests that we got without the i_version field
> being enabled at all. Basically, this just means we'll end up logging an
> extra journal transaction on some writes that follow a stat() call,
> which turns out to be line noise for most workloads.
> 
> I do agree that performance is a concern here though. We'll need to
> benchmark this somehow.

So for stat-intensive read-only workloads the additional inode_lock locking
during stat may be noticeable. I suppose a stress test stating the same
file in a loop from all CPUs the machine has will certainly notice :) But
that's just an unrealistic worst case.

We could check whether the QUERIED flag is already set and if yes, skip the
locking. That should fix the read-only workload case. We just have to think
whether there would not be some unpleasant races created.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
