Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA235BC44A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Sep 2022 10:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiISI3C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 04:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiISI3B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 04:29:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C858D2019B
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Sep 2022 01:29:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87DA3B81639
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Sep 2022 08:28:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9301BC433C1;
        Mon, 19 Sep 2022 08:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663576138;
        bh=Ha+eeqhUlf0ehpSv2YXMZkYKlghKje9sBd4fbHLKsbQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZSZ1VoGiimLWVAD4VB3+UQNA6EGcAGKDPTvsZL8nSWfG08YYVcd6jLPjyW3CbjQZX
         AqkXZdEvOeJKpSn9zg5UCtlCZQPk+84cIBSlKcu5Ktn79ja7Q5C133xb+PA7VPHug1
         w+FgkcHiYEQ6kqIuRVKAoDgq34yqV/gDptObQCdGrCuoi0lqXVz7B9Jn4fBczyr1cu
         4GSQLrUgjtndp2eMDLBcF557zUv3IzzywNCaRdfO0DLyS33IpxBCNiKaxxlYpE5pf5
         BAZ6r3+iHyDS7HiRPZLifMwdkCX5Q7mkju3KyS81ZwBjB8V6WYVcg+Kyjj93n+9u+G
         mGO6QMnqHqSUg==
Date:   Mon, 19 Sep 2022 10:28:48 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     NeilBrown <neilb@suse.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Xavier Roche <xavier.roche@algolia.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC] VFS: lock source directory for link to avoid rename
 race.
Message-ID: <20220919082848.s7dwk4hwxxejwm7s@wittgenstein>
References: <20220221082002.508392-1-mszeredi@redhat.com>
 <166304411168.30452.12018495245762529070@noble.neil.brown.name>
 <YyATCgxi9Ovi8mYv@ZenIV>
 <166311315747.20483.5039023553379547679@noble.neil.brown.name>
 <YyEcqxthoso9SGI2@ZenIV>
 <166330881189.15759.13499931397891560275@noble.neil.brown.name>
 <CAOQ4uxgS5T=C6E=MeVXg0-kK7cdkXqbVCwnhmStb13yr4y0gxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgS5T=C6E=MeVXg0-kK7cdkXqbVCwnhmStb13yr4y0gxA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 16, 2022 at 05:32:45PM +0300, Amir Goldstein wrote:
> On Fri, Sep 16, 2022 at 9:26 AM NeilBrown <neilb@suse.de> wrote:
> >
> >
> > rename(2) is documented as
> >
> >        If newpath already exists, it will be atomically replaced, so
> >        that there is no point at which another process attempting to
> >        access newpath will find it missing.
> >
> > However link(2) from a given path can race with rename renaming to that
> > path so that link gets -ENOENT because the path has already been unlinked
> > by rename, and creating a link to an unlinked file is not permitted.
> >
> 
> I have to ask. Is this a real problem or just a matter of respecting
> the laws of this man page?

I have to say that I have the same reaction. The commit message doesn't
really explain where the current behavior becomes an issue and whether
there are any users seeing issues with this. And the patch makes
do_linkat() way more complex than it was before.
