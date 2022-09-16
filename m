Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0295BA6F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Sep 2022 08:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiIPGpP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Sep 2022 02:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiIPGpN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Sep 2022 02:45:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D393740E30
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Sep 2022 23:45:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 45AD8338B4;
        Fri, 16 Sep 2022 06:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663310711; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CkyAZyn73NUn6sK0kt0cd1SIM6VALF4C3zbB3zAyOyc=;
        b=hUg+GgIGKyjwdDjHU1IGAWd5werPhvCHwVa+i4/UIjzV29XEz81yG1/NnuBI8mmMORbmhg
        uV92mcrROA9szP20AqE8nlujB3PLlK4J7xjvKMnck41/QIeGPyxRN17CQ2Yxv/L8sgFvIT
        iK15RDlYizjPAUGziPb/zu5bNUhHYzM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663310711;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CkyAZyn73NUn6sK0kt0cd1SIM6VALF4C3zbB3zAyOyc=;
        b=AbeQgNbMbHqlzIGTAHiaIBPkVxFqVigv/qaLgdILaJHc7+F808h+qgs3nqFWb9LzBaMn9M
        kB3dQXd0t2Ef6AAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 39AC01346B;
        Fri, 16 Sep 2022 06:45:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8jZrN3QbJGNNGQAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 16 Sep 2022 06:45:08 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Miklos Szeredi" <miklos@szeredi.hu>
Cc:     "Al Viro" <viro@zeniv.linux.org.uk>,
        "Miklos Szeredi" <mszeredi@redhat.com>,
        "Xavier Roche" <xavier.roche@algolia.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC] VFS: lock source directory for link to avoid rename race.
In-reply-to: <CAJfpeguwtADz8D1eUp4JVY-7-WKcf8giiiyvvdv4jccGtxcJKw@mail.gmail.com>
References: <20220221082002.508392-1-mszeredi@redhat.com>,
 <166304411168.30452.12018495245762529070@noble.neil.brown.name>,
 <YyATCgxi9Ovi8mYv@ZenIV>,
 <166311315747.20483.5039023553379547679@noble.neil.brown.name>,
 <YyEcqxthoso9SGI2@ZenIV>,
 <166330881189.15759.13499931397891560275@noble.neil.brown.name>,
 <CAJfpeguwtADz8D1eUp4JVY-7-WKcf8giiiyvvdv4jccGtxcJKw@mail.gmail.com>
Date:   Fri, 16 Sep 2022 16:45:05 +1000
Message-id: <166331070516.15759.2094020081070847080@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 16 Sep 2022, Miklos Szeredi wrote:
> 
> This will break AT_SYMLINK_FOLLOW.
> 
> And yes, we can add all the lookup logic to do_linkat() at which point
> it will about 10x more complex than it was.

Excellent point.  I'll give that some thought.  Thanks.

NeilBrown
