Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FB36D9133
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 10:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbjDFIJI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 04:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235194AbjDFIJF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 04:09:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B85BE4A
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Apr 2023 01:09:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1987662D10
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Apr 2023 08:09:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D39FAC433D2;
        Thu,  6 Apr 2023 08:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680768543;
        bh=NTeRRWZxlm/R6TvohJy6rQ145WrsAqqZ4FjvkJL6G+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FhalXvsdwGfhDc7dwUJayBb7g0jbXdw7gU7DYBL3Rb5aMpoTNGulCNLRZvNlDjEOX
         pLH+kpDsbV+Bdz/zskFBe6h2E7vxibIOXpY4gpWjJdjjc8iiz1M4bKj3eTmoSVN609
         p/G61WR7unzESVhgeBSb/kKdOiqvAfNX3KI2NPlvt5UsR6Jil3KQywtQj2SC3tpleR
         q1Ob6Y57j2xiiOvaqrwP8M+esgCy0tyoNAyBFl98R4JJX16LJqRl8vH+SdH75VZoRu
         Uza9JelUssg6pFRqtbXXRul37B0d/5WPPK9aZSjbaCtQ3jkSpfRm7BUTmXVBo552ke
         Md6EFwTEGomzg==
Date:   Thu, 6 Apr 2023 10:08:58 +0200
From:   Carlos Maiolino <cem@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     hughd@google.com, jack@suse.cz, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH 0/6] shmem: Add user and group quota support for tmpfs
Message-ID: <20230406080858.gvnbiscxloxydvhh@andromeda>
References: <20230403084759.884681-1-cem@kernel.org>
 <fdtiyXbw8TmG_ejIJ5vPraJdjBI167s5n57S8oBv03Q0TzQZc1TE_rf4qJ3_NVURUq7L56qAOqkEhAjLJE_1Tw==@protonmail.internalid>
 <20230405-klarkommen-zellkern-03af0950b80f@brauner>
 <20230405104427.rndb5skuubfhucpv@andromeda>
 <2xIltWe9jbdVUHS6W6lJDWnsQr2jOTDSaSi9y8nXWeb_71v-fLJNaRB-tkdauohZxz1xFAm4bd-471M41qA1eg==@protonmail.internalid>
 <20230405-hebamme-anonym-d41aa62ffea6@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405-hebamme-anonym-d41aa62ffea6@brauner>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 05, 2023 at 03:11:22PM +0200, Christian Brauner wrote:
> On Wed, Apr 05, 2023 at 12:44:27PM +0200, Carlos Maiolino wrote:
> > Hi Christian.
> >
> > On Wed, Apr 05, 2023 at 10:52:44AM +0200, Christian Brauner wrote:
> > > On Mon, Apr 03, 2023 at 10:47:53AM +0200, cem@kernel.org wrote:
> > > > From: Carlos Maiolino <cmaiolino@redhat.com>
> > > >
> > > > Hi folks. this work has been done originally by Lukas, but he left the company,
> > > > so I'm taking over his work from where he left it of. This series is virtually
> > > > done, and he had updated it with comments from the last version, but, I'm
> > >
> > > I've commented on the last version:
> > >
> > > https://lore.kernel.org/linux-fsdevel/20221129112133.rrpoywlwdw45k3qa@wittgenstein
> > >
> > > trying to point out that tmpfs can be mounted in user namespaces. Which
> > > means that the quota uids and gids need to take the idmapping of the
> > > user namespace in which the tmpfs instances is mounted in into account;
> > > not the one on the host.
> > >
> > > See the link above for some details. Before we can merge this it would
> > > be very good if we could get tests that verify tmpfs being mounted
> > > inside a userns with quotas enabled because I don't think this is
> > > covered yet by xfstests. Or you punt on it for now and restricted quotas
> > > to tmpfs instances mounted on the host.
> > >
> >
> > Thanks for the link, I've read it before, and this is by now a limitation I'd
> > like to keep in this series. I can extend it to be namespace aware later on, but
> > the current goal of this series is to be able tmpfs mounts on the host to limit
> > the amount of memory consumed by users. Being namespace aware is something I
> 
> This is fine with me. But please point the restriction out in the
> documentation and in the commit message. This is especially important
> because the check is hidden in the bowls of dquot_load_quota_sb().

Sounds reasonable, I'll work on the comments I received and re-send this series
next week if nothing urgent comes up.

> 
> Ideally we'd probably check for fc->user_ns == &init_user_ns directly
> when parsing the quota mount options instead of waiting until
> fill_super.

-- 
Carlos Maiolino
