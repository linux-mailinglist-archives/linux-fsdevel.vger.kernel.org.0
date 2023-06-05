Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011007228ED
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 16:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbjFEOhD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 10:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbjFEOhB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:37:01 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7145C9C
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jun 2023 07:37:00 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-119-27.bstnma.fios.verizon.net [173.48.119.27])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 355EacRo022190
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 5 Jun 2023 10:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1685975802; bh=Gf0lmbvGbinyQFXlk1n8DOtloRliNEg8wNbWAkf1Cn8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=SkA7AZmFJArAGOqu+xDl560hqDN5mkZhJ3f0GSbLHx7CptVTwK93YNspsCQwOUzLj
         Dw/OOQ6ajFeXDkb7KMSRxjsxDERHNcFWyGnydL7mIPuE22BllXq4KAjqelwaC1Ka2x
         omW8SP7nGKnt/BXgl7gRa9+aazdY13aFXB3GFq9qlei4A9cr7LhAI0xIRorBUy0AfY
         +26JiHgOXnJGPeKRbdP7vx38pCupVzpruLwyCEkCI7W0Gn4pr8x9pKNh7rKCzn/N6g
         Z9XrsTSlk/Twl4cCGZmdrxmCUUv196L86U7RNIlic+WVDGYBziJhuOjXOWel5CiIqr
         zir9KteZEmWJg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id CCD6815C02EE; Mon,  5 Jun 2023 10:36:38 -0400 (EDT)
Date:   Mon, 5 Jun 2023 10:36:38 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: uuid ioctl - was: Re: [PATCH] overlayfs: Trigger file
 re-evaluation by IMA / EVM after writes
Message-ID: <20230605143638.GA1151212@mit.edu>
References: <078d8c1fd6b6de59cde8aa85f8e59a056cb78614.camel@linux.ibm.com>
 <20230520-angenehm-orangen-80fdce6f9012@brauner>
 <ZGqgDjJqFSlpIkz/@dread.disaster.area>
 <20230522-unsensibel-backblech-7be4e920ba87@brauner>
 <20230602012335.GB16848@frogsfrogsfrogs>
 <20230602042714.GE1128744@mit.edu>
 <ZHmNksPcA9tudSVQ@dread.disaster.area>
 <20230602-dividende-model-62b2bdc073cf@brauner>
 <ZH0XVWBqs9zJF69X@dread.disaster.area>
 <20230605-allgegenwart-bellt-e05884aab89a@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605-allgegenwart-bellt-e05884aab89a@brauner>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 05, 2023 at 01:37:40PM +0200, Christian Brauner wrote:
> Using a zero/special UUID would have made this usable for most
> filesystems which allows userspace to more easily detect this. Using a
> filesystem feature bit makes this a lot more fragmented between
> filesystems.

Not all file systems have feature bits.  So I'd suggest that how this
should be a file system specific implementation detail.  If with a
newer kernel, a file systems sets the UUID to a random value if it is
all zeros when it is mounted should be relatively simple.

However, there are some questions this brings up.  What should the
semantics be if a file system creates a file system-level snapshot ---
should the UUID be refreshed?  What if it is a block-level file system
snapshot using LVM --- should the UUID be refreshed in that case?

As I've been trying to point out, exactly what the semantics of a file
system level UUID has never been well defined, and it's not clear what
various subsystems are trying to *do* with the UUID.  And given that
what can happen with mount name spaces, bind mounts, etc., we should
ask whether the assumptions they are making with respect to UUID is in
fact something we should be encouraging.

> But allowing to refuse being mounted on older kernels when the feature
> bit is set and unknown can be quite useful. So this is also fine by me.

This pretty much guarantees people won't use the feature for a while.
People complain when a file system cann't be mounted.  Using a feature
bit is also very likely to mean that you won't be able to run an older
fsck on that file system --- for what users would complain would be no
good reason.  And arguably, they would be right to complain.

						- Ted
