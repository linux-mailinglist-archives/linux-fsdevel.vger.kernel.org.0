Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B9F5A6495
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Aug 2022 15:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiH3NYs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Aug 2022 09:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiH3NYr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Aug 2022 09:24:47 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA0CF2;
        Tue, 30 Aug 2022 06:24:44 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 279875FF7; Tue, 30 Aug 2022 09:24:43 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 279875FF7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1661865883;
        bh=kiFZ7lPyA7HTC4vyRAxhN92WkWxK7wUpm+dV4qOIgZ8=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=Nf36xb9rXfFGjVLBbMApNpIsXTzE8YkdK1hXQKX0LIG4aE5uqu40B8r9SDNAy5zvl
         yFkby6QMMofGlZI0ZzDu2/evtTnYejNDoCWY31ec7vxzAy36igLSpogZSRKZB5cvZA
         AenBPsSONL821mtDhhLoo8b+qko91m9EJCxicWJA=
Date:   Tue, 30 Aug 2022 09:24:43 -0400
To:     Jeff Layton <jlayton@kernel.org>
Cc:     NeilBrown <neilb@suse.de>, Dave Chinner <david@fromorbit.com>,
        tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        trondmy@hammerspace.com, viro@zeniv.linux.org.uk,
        zohar@linux.ibm.com, xiubli@redhat.com, chuck.lever@oracle.com,
        lczerner@redhat.com, jack@suse.cz, brauner@kernel.org,
        linux-api@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ceph@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        Colin Walters <walters@verbum.org>
Subject: Re: [PATCH v3 1/7] iversion: update comments with info about atime
 updates
Message-ID: <20220830132443.GA26330@fieldses.org>
References: <20220826214703.134870-1-jlayton@kernel.org>
 <20220826214703.134870-2-jlayton@kernel.org>
 <20220829075651.GS3600936@dread.disaster.area>
 <549776abfaddcc936c6de7800b6d8249d97d9f28.camel@kernel.org>
 <166181389550.27490.8200873228292034867@noble.neil.brown.name>
 <f5c42c0d87dfa45188c2109ccf9baeb7a42aa27e.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5c42c0d87dfa45188c2109ccf9baeb7a42aa27e.camel@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 30, 2022 at 07:40:02AM -0400, Jeff Layton wrote:
> Yes, saying only that it must be different is intentional. What we
> really want is for consumers to treat this as an opaque value for the
> most part [1]. Therefore an implementation based on hashing would
> conform to the spec, I'd think, as long as all of the relevant info is
> part of the hash.

It'd conform, but it might not be as useful as an increasing value.

E.g. a client can use that to work out which of a series of reordered
write replies is the most recent, and I seem to recall that can prevent
unnecessary invalidations in some cases.

--b.
