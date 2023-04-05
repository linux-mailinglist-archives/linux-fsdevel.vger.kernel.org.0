Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0799A6D7D73
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 15:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238033AbjDENLb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Apr 2023 09:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237052AbjDENL3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Apr 2023 09:11:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA60310C4
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Apr 2023 06:11:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85F5A622FD
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Apr 2023 13:11:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3028CC433D2;
        Wed,  5 Apr 2023 13:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680700287;
        bh=7FfDTxJvbOVviT3J6yLlgvJZC9NZNe/AGg0tWqZF8Hg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ikevyq1CULjkmoZ+S55Qk/+H1NM+SIqJrHMFbTE33+yGbBgwK83QWtb0mSI2fZTYY
         CUEc5qynWg57PYlBw5c+0WEZI6k+yj3BGwSdhal0v0fKoLQJvx5gj+R7jHNaFyj1Ic
         ug6qD2ztCBn62WD01iRFgz5ANMhkpv3JZrF85ozzJylO9IAZtVa5RcOc0tcvdj/M6v
         W1hrRbXtEOsfH6IGwvRVoBVm3F9nrs9nwclhuincajjRt+PGRrd+WveqD71bHoSHbd
         X/AI3VjRAa95yux7Adi7j1iFRZozmMYil2GvW7E6LdAr4Ckj+V5vFdTUfsS7n6+qh9
         lMTOQYcRzyxMg==
Date:   Wed, 5 Apr 2023 15:11:22 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Carlos Maiolino <cem@kernel.org>
Cc:     hughd@google.com, jack@suse.cz, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH 0/6] shmem: Add user and group quota support for tmpfs
Message-ID: <20230405-hebamme-anonym-d41aa62ffea6@brauner>
References: <20230403084759.884681-1-cem@kernel.org>
 <fdtiyXbw8TmG_ejIJ5vPraJdjBI167s5n57S8oBv03Q0TzQZc1TE_rf4qJ3_NVURUq7L56qAOqkEhAjLJE_1Tw==@protonmail.internalid>
 <20230405-klarkommen-zellkern-03af0950b80f@brauner>
 <20230405104427.rndb5skuubfhucpv@andromeda>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230405104427.rndb5skuubfhucpv@andromeda>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 05, 2023 at 12:44:27PM +0200, Carlos Maiolino wrote:
> Hi Christian.
> 
> On Wed, Apr 05, 2023 at 10:52:44AM +0200, Christian Brauner wrote:
> > On Mon, Apr 03, 2023 at 10:47:53AM +0200, cem@kernel.org wrote:
> > > From: Carlos Maiolino <cmaiolino@redhat.com>
> > >
> > > Hi folks. this work has been done originally by Lukas, but he left the company,
> > > so I'm taking over his work from where he left it of. This series is virtually
> > > done, and he had updated it with comments from the last version, but, I'm
> > 
> > I've commented on the last version:
> > 
> > https://lore.kernel.org/linux-fsdevel/20221129112133.rrpoywlwdw45k3qa@wittgenstein
> > 
> > trying to point out that tmpfs can be mounted in user namespaces. Which
> > means that the quota uids and gids need to take the idmapping of the
> > user namespace in which the tmpfs instances is mounted in into account;
> > not the one on the host.
> > 
> > See the link above for some details. Before we can merge this it would
> > be very good if we could get tests that verify tmpfs being mounted
> > inside a userns with quotas enabled because I don't think this is
> > covered yet by xfstests. Or you punt on it for now and restricted quotas
> > to tmpfs instances mounted on the host.
> > 
> 
> Thanks for the link, I've read it before, and this is by now a limitation I'd
> like to keep in this series. I can extend it to be namespace aware later on, but
> the current goal of this series is to be able tmpfs mounts on the host to limit
> the amount of memory consumed by users. Being namespace aware is something I

This is fine with me. But please point the restriction out in the
documentation and in the commit message. This is especially important
because the check is hidden in the bowls of dquot_load_quota_sb().

Ideally we'd probably check for fc->user_ns == &init_user_ns directly
when parsing the quota mount options instead of waiting until
fill_super.
