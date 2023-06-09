Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48FFE729A31
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 14:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjFIMm4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 08:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjFIMmx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:42:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AF31BC6;
        Fri,  9 Jun 2023 05:42:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14AE4650F5;
        Fri,  9 Jun 2023 12:42:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4F8C433D2;
        Fri,  9 Jun 2023 12:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686314571;
        bh=qgQMLvlfBHyBTcVqPwiFlAvpmoby0L12zJsI2Q/cVkk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KefGdIsByC1sOiXXv2RsalMBsOiXJ90nmk92ULVYLDQn3bLzwS3eA/LX+tm0o+K1q
         ZbQhBSHZmoI5k+NiH0OnnyC1uAdgof9tmVwIOZnG44RjkJcBoBgA7bkiTxj+uluqrh
         /4ckvsBFu+65CYqcUigkXP0SPGvcI94TOrI6oIWftAbYFn4l4naGrDWEWLSk91MYyW
         BQnyoVK2oTxjIc7jLKFqEn06mKcJn485GaO1aHT6aao7nThu7Jvl05SNf454di6HXq
         8HkIEbc8Di5anmHwrj56xF7f7gABkLJK1RePdkEnwuprdC0dEUhmpxJ6P2O5en2R+V
         aiCRa+0SggJzA==
Date:   Fri, 9 Jun 2023 14:42:47 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Colin Walters <walters@verbum.org>
Cc:     "Ariel Miculas (amiculas)" <amiculas@cisco.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [RFC PATCH 00/80] Rust PuzzleFS filesystem driver
Message-ID: <20230609-breitengrad-hochdekoriert-06ff26b96c13@brauner>
References: <20230609063118.24852-1-amiculas@cisco.com>
 <20230609-feldversuch-fixieren-fa141a2d9694@brauner>
 <CH0PR11MB529981313ED5A1F815350E41CD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
 <20230609-nachrangig-handwagen-375405d3b9f1@brauner>
 <6b90520e-c46b-4e0d-a1c5-fcbda42f8f87@betaapp.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6b90520e-c46b-4e0d-a1c5-fcbda42f8f87@betaapp.fastmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 09, 2023 at 08:20:30AM -0400, Colin Walters wrote:
> 
> 
> On Fri, Jun 9, 2023, at 7:45 AM, Christian Brauner wrote:
> >
> > Because the series you sent here touches on a lot of things in terms of
> > infrastructure alone. That work could very well be rather interesting
> > independent of PuzzleFS. We might just want to get enough infrastructure
> > to start porting a tiny existing fs (binderfs or something similar
> > small) to Rust to see how feasible this is and to wet our appetite for
> > bigger changes such as accepting a new filesystem driver completely
> > written in Rust.
> 
> (Not a kernel developer, but this argument makes sense to me)
> 
> > But aside from the infrastructure discussion:
> >
> > This is yet another filesystem for solving the container image problem
> > in the kernel with the addition of yet another filesystem. We just went
> > through this excercise with another filesystem. So I'd expect some
> > reluctance here. Tbh, the container world keeps sending us filesystems
> > at an alarming rate. That's two within a few months and that leaves a
> > rather disorganized impression.
> 
> I am sure you are aware there's not some "container world"
> monoculture, there are many organizations, people and companies here

That submission here explicitly references OCI v2. Composefs explicitly
advertises 100% compatibility with OCI. So, there's a set of OCI specs
including runtime and image. As far as I'm concerned you're all one
container world under the OCI umbrella.

We're not going to push multiple filesystems into the kernel that all do
slightly different things but all serve the OCI container world and use
some spec as an argument to move stuff into the kernel.

The OCI initiative is hailed as unifying the container ecosystem. Hence,
we can expect coordination.
