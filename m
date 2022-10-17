Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE946600E81
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 14:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiJQMDU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 08:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiJQMDS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 08:03:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799405D739;
        Mon, 17 Oct 2022 05:03:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 22E24205DF;
        Mon, 17 Oct 2022 12:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666008185;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H9rmmj8x9/pRGSP0rhWzAN2XdXyBU8aire6+hcOWaqg=;
        b=EinRM8cmED2AkAp5rHQ9Q/lhD8djKWOsD88oc+NtD13fI7XxVo1WUUyzmKt/GVSI6gbzAB
        avLzqrApgtjFLBBG/xJ+AFWnU8r7YZVrpEWdvAM7p60Y5lEedj8arNYOaEbKzaLwxt/Hc/
        U1NJTeEZ2sDSl3Q+1AEau/ybC7ZtAR8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666008185;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H9rmmj8x9/pRGSP0rhWzAN2XdXyBU8aire6+hcOWaqg=;
        b=+HpnUQkgMm3dqcglnnoPcbVqtG7gqDj2H/lOtRIyBB+kZhaON0Kk1MTD50LMU/hFLdJhAr
        f8WVAuBtfTzw7QAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9608D13398;
        Mon, 17 Oct 2022 12:03:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ovthI3hETWM0JQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 17 Oct 2022 12:03:04 +0000
Date:   Mon, 17 Oct 2022 14:02:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     dsterba@suse.cz, Hrutvik Kanabar <hrkanabar@gmail.com>,
        Hrutvik Kanabar <hrutvik@google.com>,
        Marco Elver <elver@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        kasan-dev@googlegroups.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [PATCH RFC 0/7] fs: Debug config option to disable filesystem
 checksum verification for fuzzing
Message-ID: <20221017120255.GM13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20221014084837.1787196-1-hrkanabar@gmail.com>
 <20221014091503.GA13389@twin.jikos.cz>
 <CACT4Y+as3SA6C_QFLSeb5JYY30O1oGAh-FVMLCS2NrNahycSoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+as3SA6C_QFLSeb5JYY30O1oGAh-FVMLCS2NrNahycSoQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 17, 2022 at 10:31:03AM +0200, Dmitry Vyukov wrote:
> On Fri, 14 Oct 2022 at 11:15, David Sterba <dsterba@suse.cz> wrote:
> > On Fri, Oct 14, 2022 at 08:48:30AM +0000, Hrutvik Kanabar wrote:
> > > From: Hrutvik Kanabar <hrutvik@google.com>
> > I think the build-time option inflexible, but I see the point when
> > you're testing several filesystems that it's one place to set up the
> > environment. Alternatively I suggest to add sysfs knob available in
> > debuging builds to enable/disable checksum verification per filesystem.
> 
> What usage scenarios do you have in mind for runtime changing of this option?
> I see this option intended only for very narrow use cases which
> require a specially built kernel in a number of other ways (lots of
> which are not tunable at runtime, e.g. debugging configs).

For my own development and testing usecase I'd like to build the kernel
from the same config all the time, then start a VM and run random tests
that do not skip the checksum verification. Then as the last also run
fuzzing with checksums skipped. The debugging (lockdep, various sanity
checks, ...) config options are enabled. We both have a narrow usecase,
what I'm suggesting is a common way to enable them.
