Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A998C6EC94F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 11:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjDXJpp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 05:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbjDXJp2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 05:45:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850C940F1;
        Mon, 24 Apr 2023 02:45:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3598D21A29;
        Mon, 24 Apr 2023 09:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682329499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s31sOliPxWkPFI+NHah5gRbQohx+4AhbOy0IeldkULI=;
        b=MeOm7yLHmJ6o8FHFw9kbrmokRl38WMbv2ob2DgLfFyLGxqeUjyjO4b79qjG95CZt+Tz/4L
        HyfXyxrkdF69SoLtZdA5BnRJcucQ5h5mWxfbuhmgW1z1lUTJJiXzXlGD9PrYuQOxzWAgXb
        lATIM6yiDIJ4TvWGw95YWjNL66BwG+E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682329499;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s31sOliPxWkPFI+NHah5gRbQohx+4AhbOy0IeldkULI=;
        b=bZhg4ucb3kOuTP12xwwEtKbigYquJAKrnfFD2LF+r/xMyFxy8wfYwwf103BeTvOh//4OL1
        l3qmH05pubHUqKBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2038C1390E;
        Mon, 24 Apr 2023 09:44:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vuzZB5tPRmR3FgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 24 Apr 2023 09:44:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5E5B3A0729; Mon, 24 Apr 2023 11:44:58 +0200 (CEST)
Date:   Mon, 24 Apr 2023 11:44:58 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>, Ted Tso <tytso@mit.edu>
Subject: Re: [PATCHv6 0/9] ext2: DIO to use iomap
Message-ID: <20230424094458.baigjp3pembjti4f@quack3>
References: <20230421112324.mxrrja2hynshu4b6@quack3>
 <87edodigo4.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87edodigo4.fsf@doe.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 21-04-23 17:35:47, Ritesh Harjani wrote:
> Jan Kara <jack@suse.cz> writes:
> > them. The series has an ext4 cleanup (patch 3) and three iomap patches
> 
> Also Patch-3 is on top of ext4 journalled data patch series of yours,
> otheriwse we might see a minor merge conflict.
> 
> https://lore.kernel.org/all/20230329154950.19720-6-jack@suse.cz/

Yes, I have noticed :)

> > I guess I won't rush this for the coming merge window (unless Linus decides
> > to do rc8) but once we settle on the merge strategy I'll push out some
> 
> Ok.
> 
> > branch on which we can base further ext2 iomap conversion work.
> >
> 
> Sure, will this branch also gets reflected in linux-next for wider testing?

Yes, the branch I'll push the ext2+ext4 patches to will be included in
linux-next (I'll merge it to for-next branch).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
