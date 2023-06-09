Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E6E72A13B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 19:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjFIR3L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 13:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjFIR3K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 13:29:10 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63553592
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jun 2023 10:29:06 -0700 (PDT)
Received: from jerom (unknown [128.107.241.177])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: serge)
        by mail.hallyn.com (Postfix) with ESMTPSA id 70452993;
        Fri,  9 Jun 2023 12:29:01 -0500 (CDT)
Date:   Fri, 9 Jun 2023 12:28:52 -0500
From:   Serge Hallyn <serge@hallyn.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Colin Walters <walters@verbum.org>,
        "Ariel Miculas (amiculas)" <amiculas@cisco.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [RFC PATCH 00/80] Rust PuzzleFS filesystem driver
Message-ID: <ZINhVBtxvUr5ntnu@jerom>
References: <20230609063118.24852-1-amiculas@cisco.com>
 <20230609-feldversuch-fixieren-fa141a2d9694@brauner>
 <CH0PR11MB529981313ED5A1F815350E41CD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
 <20230609-nachrangig-handwagen-375405d3b9f1@brauner>
 <6b90520e-c46b-4e0d-a1c5-fcbda42f8f87@betaapp.fastmail.com>
 <20230609-breitengrad-hochdekoriert-06ff26b96c13@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609-breitengrad-hochdekoriert-06ff26b96c13@brauner>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 09, 2023 at 02:42:47PM +0200, Christian Brauner wrote:
> On Fri, Jun 09, 2023 at 08:20:30AM -0400, Colin Walters wrote:
> > 
> > 
> > On Fri, Jun 9, 2023, at 7:45 AM, Christian Brauner wrote:
> > >
> > > Because the series you sent here touches on a lot of things in terms of
> > > infrastructure alone. That work could very well be rather interesting
> > > independent of PuzzleFS. We might just want to get enough infrastructure
> > > to start porting a tiny existing fs (binderfs or something similar
> > > small) to Rust to see how feasible this is and to wet our appetite for
> > > bigger changes such as accepting a new filesystem driver completely
> > > written in Rust.
> > 
> > (Not a kernel developer, but this argument makes sense to me)
> > 
> > > But aside from the infrastructure discussion:
> > >
> > > This is yet another filesystem for solving the container image problem
> > > in the kernel with the addition of yet another filesystem. We just went
> > > through this excercise with another filesystem. So I'd expect some
> > > reluctance here. Tbh, the container world keeps sending us filesystems
> > > at an alarming rate. That's two within a few months and that leaves a
> > > rather disorganized impression.
> > 
> > I am sure you are aware there's not some "container world"
> > monoculture, there are many organizations, people and companies here
> 
> That submission here explicitly references OCI v2. Composefs explicitly
> advertises 100% compatibility with OCI. So, there's a set of OCI specs

OCI v2 doesn't currently exist :)  There were many design goals for
it, and near as I can tell, after everyone discussed those together,
everyone went off to work on implementing the bits the needed - which
is a right and proper step before coming back and comparing notes
about what went well, etc.

The two main things where puzzlefs is experimenting are the use of
content defined chunking (CDC), and being written in rust (and,
especially, to have the same rust code base be used for the in kernel
driver, the fuse mounter, the builder, and the userspace extractor).
(Well, and reproducible images through a canonical representation,
but...)

It requires a POC in order to really determine whether the CDC will
be worth it, or will have pitfalls.  So far, it looks very promising.
Adding that functionality to composefs one day could be cool.

Likewise, it requires a user in order to push on the infrastructure
required to support a full filesystem in rust in the kernel.  But that
really isn't something we can "add to composefs".  :)

The main goal of this posting, then, was to show the infrastructure
pieces and work on that with the community.  We're definitely not
(currently :) asking for puzzlefs to be included.  However, it is
our (business and personal) justification for the rest of the work.

> including runtime and image. As far as I'm concerned you're all one
> container world under the OCI umbrella.

One big happy family!

> We're not going to push multiple filesystems into the kernel that all do
> slightly different things but all serve the OCI container world and use
> some spec as an argument to move stuff into the kernel.
> 
> The OCI initiative is hailed as unifying the container ecosystem. Hence,
> we can expect coordination.
