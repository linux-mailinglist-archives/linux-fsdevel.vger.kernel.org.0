Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5897427AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 15:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjF2Nt0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 09:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjF2NtY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 09:49:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2491358A
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 06:49:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 95DDA1F892;
        Thu, 29 Jun 2023 13:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688046561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xABarwN0L5RHYJ+bXO64WN8ow+NziMypZSpUKtgfS4c=;
        b=ExptP5+e7NhQm/eHSU0Y5zGAzBHEBLKuA3WYsiy2DIQwzDI3ma96MQUDOCZJGd2AcZ471f
        DjTE5IrnJRrXgQw/na/ORpuenQ4HKh0+MXoGQ5y31sdCEghZcR6KizU4TG6AL9Ugazy9pc
        mFR/81yVfmUR079FO08GmcAzREio1bE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688046561;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xABarwN0L5RHYJ+bXO64WN8ow+NziMypZSpUKtgfS4c=;
        b=3R8e8IdHN6ZIeuxydQpowUFxqK/AO1z8MJIKawAvFK36HKSl43AOwrrBtnpX7EpRBFxumF
        TqThP7Nsv2KrosBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 87F02139FF;
        Thu, 29 Jun 2023 13:49:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PUgjIeGLnWSvAwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 29 Jun 2023 13:49:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 23BF2A0722; Thu, 29 Jun 2023 15:49:21 +0200 (CEST)
Date:   Thu, 29 Jun 2023 15:49:21 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH] fanotify: disallow mount/sb marks on kernel
 internal pseudo fs
Message-ID: <20230629134921.aai2vwideeng3fh6@quack3>
References: <20230629042044.25723-1-amir73il@gmail.com>
 <20230629101858.72ftsgnfblb5kv64@quack3>
 <CAOQ4uxhNH2FKhvsyLuCU7EFrbWy=8kmCi-c1u=63yuQoCkH74w@mail.gmail.com>
 <CAOQ4uxgfOc-HEj9dDGw4M5aqiitu_wFJf+5gz37N4h1bwqwfLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgfOc-HEj9dDGw4M5aqiitu_wFJf+5gz37N4h1bwqwfLg@mail.gmail.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 29-06-23 15:51:58, Amir Goldstein wrote:
> On Thu, Jun 29, 2023 at 3:20 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > > The tricky point in banning anonymous pipes from inotify, which
> > > > could have existing users (?), but maybe not, so maybe this is
> > > > something that we need to try out.
> > > >
> > > > I think we can easily get away with banning anonymous pipes from
> > > > fanotify altogeter, but I would not like to get to into a situation
> > > > where new applications will be written to rely on inotify for
> > > > functionaly that fanotify is never going to have.
> > >
> > > Yeah, so didn't we try to already disable inotify on some virtual inodes
> > > and didn't it break something? I have a vague feeling we've already tried
> > > that in the past and it didn't quite fly but searching the history didn't
> > > reveal anything so maybe I'm mistaking it with something else.
> > >
> >
> > I do have the same memory now that you mention it.
> > I will try to track it down.
> >
> 
> Here it is:
> https://lore.kernel.org/linux-fsdevel/20200629130915.GF26507@quack2.suse.cz/
> 
> A regression report on Mel's patch:
> e9c15badbb7b ("fs: Do not check if there is a fsnotify watcher on
> pseudo inodes")
> 
> Chromium needs IN_OPEN/IN_CLOSE on anon pipes.
> It does not need IN_ACCESS/IN_MODIFY, but the value of eliminating
> those was deemed as marginal after the alternative optimizations by Mel:
> 
> 71d734103edf ("fsnotify: Rearrange fast path to minimise overhead when
> there is no watcher")

Ah, yes. Thanks for the history digging! My grep-foo over the changelogs
was not good enough to find it :)

> The reason I would like to ban the "global" watch on all anon inodes
> is because it is just wrong and an oversight of sb/mount marks that
> needs to be fixed.
> 
> The SB_NOUSER optimization is something that we can consider later.
> It's not critical, but just a very low hanging fruit to pick.
> 
> Based on this finding, I would go with this RFC patch as is.
> I will let you decide how to CC stable and about the timing
> of sending this to Linus.

Yes, let's go with the patch as is. Currently I have pull request pending
with Linus so I won't merge the patch yet but I plan on merging it early
next week and then sending it to Linus towards the end of the next week.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
