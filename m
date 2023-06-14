Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92B872F4D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 08:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242750AbjFNGaF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 02:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243194AbjFNG3p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 02:29:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442C31BF7;
        Tue, 13 Jun 2023 23:29:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E979563DEF;
        Wed, 14 Jun 2023 06:29:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D9C5C433C8;
        Wed, 14 Jun 2023 06:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686724178;
        bh=XjFkOsOx183EvSiM4yPrENjUW2d5opZ5TvQfHk7+D2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XnX11RI911zmZAW2F67s3+Ymqh1WyrS9FAGLruYi0rzwQOXU1+S0hh65U7iPNXoq6
         chqapxeFWuQPWe1xw5png9URTFBluyLfk4L59UjPan9xuJTRHK//t2Z5ie2yzGNTva
         qtQi48csnlK0bKeNPyWNQ7KX8SMFwBcnhVywwMAmbDknwoN451G2FPeFgN+O75pBm3
         WtTXZEDZE2FCRdCej0zaWKFjud0zNmD8JJuXe2p307imyZZdCdixaF6gKTcbWD0OOt
         9+GJw+FhGue1elde/UvtQ6Neflo/LSA/woAWF7Btga+5DatyoY4t6prX187y6cupLw
         qW86pY+AZP7aQ==
Date:   Wed, 14 Jun 2023 08:29:29 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Chuck Lever <chuck.lever@oracle.com>,
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
Subject: Re: [PATCH v4 2/9] fs: add infrastructure for multigrain inode
 i_m/ctime
Message-ID: <20230614-fanal-infamieren-b9c106e37b73@brauner>
References: <20230518114742.128950-1-jlayton@kernel.org>
 <20230518114742.128950-3-jlayton@kernel.org>
 <20230523100240.mgeu4y46friv7hau@quack3>
 <bf0065f2c9895edb66faeacc6cf77bd257088348.camel@kernel.org>
 <20230523124606.bkkhwi6b67ieeygl@quack3>
 <11dc42c327c243ea1def211f352cb4fc38094cc0.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <11dc42c327c243ea1def211f352cb4fc38094cc0.camel@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 13, 2023 at 09:09:29AM -0400, Jeff Layton wrote:
> On Tue, 2023-05-23 at 14:46 +0200, Jan Kara wrote:
> > On Tue 23-05-23 06:40:08, Jeff Layton wrote:
> > > On Tue, 2023-05-23 at 12:02 +0200, Jan Kara wrote:
> > > > 
> > > > So there are two things I dislike about this series because I think they
> > > > are fragile:
> > > > 
> > > > 1) If we have a filesystem supporting multigrain ts and someone
> > > > accidentally directly uses the value of inode->i_ctime, he can get bogus
> > > > value (with QUERIED flag). This mistake is very easy to do. So I think we
> > > > should rename i_ctime to something like __i_ctime and always use accessor
> > > > function for it.
> > > > 
> > > 
> > > We could do this, but it'll be quite invasive. We'd have to change any
> > > place that touches i_ctime (and there are a lot of them), even on
> > > filesystems that are not being converted.
> > 
> > Yes, that's why I suggested Coccinelle to deal with this.
> 
> 
> I've done the work to convert all of the accesses of i_ctime into
> accessor functions in the kernel. The current state of it is here:
> 
>    
> https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git/commit/?h=ctime
> 
> As expected, it touches a lot of code, all over the place. So far I have
> most of the conversion in one giant patch, and I need to split it up
> (probably per-subsystem).

Yeah, you have time since it'll be v6.6 material.

> 
> What's the best way to feed this change into mainline? Should I try to
> get subsystem maintainers to pick these up, or are we better off feeding
> this in via a separate branch?

I would prefer if we send them all through the vfs tree since trickle
down conversions are otherwise very painful and potentially very slow.
