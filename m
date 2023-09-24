Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C149A7ACCB5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 00:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjIXWpF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Sep 2023 18:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjIXWpF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Sep 2023 18:45:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296DCA6;
        Sun, 24 Sep 2023 15:44:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 323771F747;
        Sun, 24 Sep 2023 22:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1695595497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hRwyioNPM6VJSpdWYMKoolvI/LXv7s3V/CrVe74w9Tw=;
        b=CzYQ+qQALQzNyMq0OAU9iS3bPdIlpBZay01wf3bK4qilWoxLIQgusBo/3bA7LBs4OqVnDP
        tNQX5HjkAbWEL4Dtbw9F3qtcR0fzUO3ABWpWCDrgGJ/Tf6mR1DnFTFri+GegtdZM7CGG2+
        bFm/PXQE4indUPWlxlXFzrcf2lizJHs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1695595497;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hRwyioNPM6VJSpdWYMKoolvI/LXv7s3V/CrVe74w9Tw=;
        b=IDrrHhTwiqxHwHMNxnDW3xgAjEiseYLkFJC/4lSNvRN5Mo4hbsTvQr7ISNmXUdhp7P4quT
        FoShd7mdvt1r6nAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E13013581;
        Sun, 24 Sep 2023 22:44:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id f7VxFOO7EGWUawAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 24 Sep 2023 22:44:51 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Christian Brauner" <brauner@kernel.org>
Cc:     "Jeff Layton" <jlayton@kernel.org>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        "Chuck Lever" <chuck.lever@oracle.com>,
        "Olga Kornievskaia" <kolga@netapp.com>,
        "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
        "Chandan Babu R" <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "Dave Chinner" <david@fromorbit.com>, "Jan Kara" <jack@suse.cz>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Kent Overstreet" <kent.overstreet@linux.dev>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v8 0/5] fs: multigrain timestamps for XFS's change_cookie
In-reply-to: <20230924-mitfeiern-vorladung-13092c2af585@brauner>
References: <20230922-ctime-v8-0-45f0c236ede1@kernel.org>,
 <20230924-mitfeiern-vorladung-13092c2af585@brauner>
Date:   Mon, 25 Sep 2023 08:44:47 +1000
Message-id: <169559548777.19404.13247796879745924682@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 24 Sep 2023, Christian Brauner wrote:
> > My initial goal was to implement multigrain timestamps on most major
> > filesystems, so we could present them to userland, and use them for
> > NFSv3, etc.
> 
> If there's no clear users and workloads depending on this other than for
> the sake of NFS then we shouldn't expose this to userspace. We've tried
> this and I'm not convinced we're getting anything other than regressions
> out of it. Keep it internal and confined to the filesystem that actually
> needs this.
> 

Some NFS servers run in userspace, and they would a "clear user" of this
functionality.

NeilBrown
