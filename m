Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF25256477E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Jul 2022 15:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbiGCNQT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Jul 2022 09:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbiGCNQS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Jul 2022 09:16:18 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD4463E9;
        Sun,  3 Jul 2022 06:16:17 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 263DFRbI024097
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 3 Jul 2022 09:15:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1656854134; bh=yN7VurO+JH7Mo0Ckmg7/VswnfnxYfW2lA7CXiFOOZa8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ENt1xY3yANlkp01oZmFFQ1vZpE5hmxZSOapOmMq1o5KLT10yJRziY0BKdKrjhgJ35
         KNDLYbuCEEoqhnlCinIttTawZM2ofnrLQcVKtZNNX7UXnGs/s+osL1b6aDzo2JPulX
         CP9wmtbj1ncOzLJNn1R39ZLIxFvzuuXefQ+2W9Co7/CnsjEDWz+cW5ERywjH/bOxr6
         JT+NWKgEln2ytRbYong40dTokBPmcyEttS5JuwhqTeF3y9MiIYXnzH4grRXI3Dd/Ek
         iKbcMoQyFaaScDOSSzBfNEEcUzBREwE+W3WTsPeba3UJguLF8KZF/258dp8FUgqRD7
         r9telvU5q75uA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C788315C3E94; Sun,  3 Jul 2022 09:15:27 -0400 (EDT)
Date:   Sun, 3 Jul 2022 09:15:27 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>, jmeneghi@redhat.com,
        Jan Kara <jack@suse.cz>, Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Jake Edge <jake@lwn.net>, Klaus Jensen <its@irrelevant.dk>,
        fstests <fstests@vger.kernel.org>, Zorro Lang <zlang@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [RFC: kdevops] Standardizing on failure rate nomenclature for
 expunges
Message-ID: <YsGWb8nPUySuhos/@mit.edu>
References: <YoW0ZC+zM27Pi0Us@bombadil.infradead.org>
 <a120fb86-5a08-230f-33ee-1cb47381fff1@acm.org>
 <CAOQ4uxgBtMifsNt1SDA0tz098Rt7Km6MAaNgfCeW=s=FPLtpCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgBtMifsNt1SDA0tz098Rt7Km6MAaNgfCeW=s=FPLtpCQ@mail.gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 03, 2022 at 08:56:54AM +0300, Amir Goldstein wrote:
> 
> That is true for some use cases, but unfortunately, the flaky
> fstests are way too valuable and too hard to replace or improve,
> so practically, fs developers have to run them, but not everyone does.
> 
> Zorro has already proposed to properly tag the non deterministic tests
> with a specific group and I think there is really no other solution.

The non-deterministic tests are not the sole, or even the most likely
cause of flaky tests.  Or put another way, even if we used a
deterministic pseudo-random numberator seed for some of the curently
"non-determinstic tests" (and I believe we are for many of them
already anyway), it's not going to be make the flaky tests go away.

That's because with many of these tests, we are running multiple
threads either in the fstress or fsx, or in the antogonist workload
that is say, running the space utilization to full to generate ENOSPC
errors, and then deleting a bunch of files to trigger as many ENOSPC
hitter events as possible.

> The only question is whether we remove them from the 'auto' group
> (I think we should).

I wouldn't; if someone wants to exclude the non-determistic tests,
once they are tagged as belonging to a group, they can just exclude
that group.  So there's no point removing them from the auto group
IMHO.

> filesystem developers that will run ./check -g auto -g soak
> will get the exact same test coverage as today's -g auto
> and the "commoners" that run ./check -g auto will enjoy blissful
> determitic test results, at least for the default config of regularly
> tested filesystems (a.k.a, the ones tested by kernet test bot).?

First of all, there are a number of tests today which are in soak or
long_rw which are not in auto, so "-g auto -g soak" will *not* result
in the "exact same test coverage".

Secondly, as I've tested above, deterministic tests does not
necessasrily mean determinsitic test results --- unless by
"determinsitic tests" you mean "completely single-threaded tests",
which would eliminate a large amount of useful test coverage.

Cheers,

					- Ted
