Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93D1597AAD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 02:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242475AbiHRAey (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 20:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239875AbiHRAex (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 20:34:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC95A7203;
        Wed, 17 Aug 2022 17:34:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 206AD209E1;
        Thu, 18 Aug 2022 00:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1660782890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YBXVfe0ZfrfKjLJfnSxqwmOSeeUnu57Xv54a6CjL3Yg=;
        b=zOYiNTTQ3R4+eldvxoJrZuK6sYaG+yb5ccMj0oF5bN+OSzJvc4J9Ct/afO7osfmG8uYfvy
        uLcCo7oI4zEmM+xda9tk/mU5ytb/jLcszC7T+jfMixe7u7h4E9r0HPqICElxGUUM5sseNJ
        FP7VQTSQu6YdMVkpNwkbXHHCCd5iECc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1660782890;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YBXVfe0ZfrfKjLJfnSxqwmOSeeUnu57Xv54a6CjL3Yg=;
        b=tY1VaN88LwQsclu8eZSZYrHV2EsYMNpLl6Djz+CwUKzt8Ms7/j9KcjA40y00uyuStjXglq
        OCLfLAss6fxl00Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 306F913440;
        Thu, 18 Aug 2022 00:34:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2qUrNyeJ/WK9SAAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 18 Aug 2022 00:34:47 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Dave Chinner" <david@fromorbit.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] xfs: fix i_version handling in xfs
In-reply-to: <20220816224257.GV3600936@dread.disaster.area>
References: <20220816131736.42615-1-jlayton@kernel.org>,
 <Yvu7DHDWl4g1KsI5@magnolia>,
 <e77fd4d19815fd661dbdb04ab27e687ff7e727eb.camel@kernel.org>,
 <20220816224257.GV3600936@dread.disaster.area>
Date:   Thu, 18 Aug 2022 10:34:40 +1000
Message-id: <166078288043.5425.8131814891435481157@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 17 Aug 2022, Dave Chinner wrote:
> 
> In XFS, we've defined the on-disk i_version field to mean
> "increments with any persistent inode data or metadata change",
> regardless of what the high level applications that use i_version
> might actually require.
> 
> That some network filesystem might only need a subset of the
> metadata to be covered by i_version is largely irrelevant - if we
> don't cover every persistent inode metadata change with i_version,
> then applications that *need* stuff like atime change notification
> can't be supported.

So what you are saying is that the i_version provided by XFS does not
match the changeid semantics required by NFSv4.  Fair enough.  I guess
we shouldn't use the one to implement the other then.

Maybe we should just go back to using ctime.  ctime is *exactly* what
NFSv4 wants, as long as its granularity is sufficient to catch every
single change.  Presumably XFS doesn't try to ensure this.  How hard
would it be to get any ctime update to add at least one nanosecond?
This would be enabled by a mount option, or possibly be a direct request
from nfsd.

<rant>NFSv4 changeid is really one of the more horrible parts of the
design</rant>

NeilBrown
