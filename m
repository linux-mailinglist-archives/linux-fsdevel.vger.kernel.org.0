Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB45470BB31
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 13:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbjEVLJj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 07:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjEVLJS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 07:09:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FE62119;
        Mon, 22 May 2023 04:04:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CC766187D;
        Mon, 22 May 2023 10:53:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40EACC43442;
        Mon, 22 May 2023 10:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684752801;
        bh=lxoFdlwyXreWklHMGhjnnVDqvf5QqMirVF69DEG4jMg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ct274itzCgUdbCBjIi3u/ZuZmET312SHUcSUBK2Lkv3upiqkMWaP9Qq0zgj+4HbPE
         fvQijfSZwweDPv0LNSALl1fiE6LtH9LiviXLFaVxf77cyoWoeww2S21gQEAXUCj1pZ
         VtyTeHrbIDNp69dBMo1dR+0Ni43MBESSIkh/MqIyj1hmT6MGiQOS0nwtQs58ujg/5A
         s0i1BLJvJx9Epkd0Bi76KBwOmg+bJ19wLhSSeInBoVPgAHkrzWsB7AW5OfWhKeciyi
         I4UKgE8UBOtfjfmH6OCgbl9+JCvxaCZi+6x6BRI8QYqHd30puM0p91YwBa55dH0yHg
         S8ZcqLivMgRwA==
Date:   Mon, 22 May 2023 12:53:05 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     dsterba@suse.cz, Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Neil Brown <neilb@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Theodore T'so <tytso@mit.edu>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <sfrench@samba.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tom Talpey <tom@talpey.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org
Subject: Re: [PATCH v4 9/9] btrfs: convert to multigrain timestamps
Message-ID: <20230522-bannen-urkunden-9759d84aece5@brauner>
References: <20230518114742.128950-1-jlayton@kernel.org>
 <20230518114742.128950-10-jlayton@kernel.org>
 <20230522095601.GH32559@twin.jikos.cz>
 <cde7bc1874e2d69860ecdb87d4e21c762f355aea.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cde7bc1874e2d69860ecdb87d4e21c762f355aea.camel@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 22, 2023 at 06:08:56AM -0400, Jeff Layton wrote:
> On Mon, 2023-05-22 at 11:56 +0200, David Sterba wrote:
> > On Thu, May 18, 2023 at 07:47:42AM -0400, Jeff Layton wrote:
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > 
> > Acked-by: David Sterba <dsterba@suse.com>
> > 
> > Please add a brief description to the changelog too, there's a similar
> > text in the patches adding the infrastructure. Something like "Allow to
> > optimize lot of metadata updates by encoding the status in the cmtime.
> > The fine grained time is needed for NFS."
> 
> Sure thing.
> 
> Christian, do you want to just alter the changelog with David's
> suggestion, or would you rather I resend the series?

Nah, don't bother resending I'll just add it to the fs specific patches.
I'll end up updating the patch trailers anyway when individual
maintainers add new Acks.
