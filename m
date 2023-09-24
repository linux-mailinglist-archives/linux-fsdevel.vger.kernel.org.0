Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BC07AC7AF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Sep 2023 13:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjIXLbe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Sep 2023 07:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjIXLbd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Sep 2023 07:31:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEA6FF;
        Sun, 24 Sep 2023 04:31:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F13C433C7;
        Sun, 24 Sep 2023 11:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695555086;
        bh=BU7gXHG2Ddzg0jBacxkT5peevj5SLAgGvy3mqhhxUCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KP8dQxeBMcRUZGCkoKma/ZQeBFfQmTC48UOM03zTEy6zVq6Z5V4IF0Ju87hyTi3T3
         PY5lWMpzfByjfQKkIWRvzD05eZPQdHszniZa7l63YF+q+fuX6DsBKHuTa78aNYdTm0
         NL75psSv2cCEInBHKc+9SWkGy1jM6lT4Pgm3Ke3HyqVQgpQsvCyyoIK8FqplhkkveP
         MOIVDynnuMgMUmYvRUTtFqxJjcLopNCIja+O0SsahyOgOAacL2P7ARMVb94dIv/k9k
         Z9kryMZNIHIOKqUNfgghNSRo0b8d/Hj4BAGRZW36POUrAS5xjaTE05ixocldAwrYGk
         JfJx923IO0E2Q==
Date:   Sun, 24 Sep 2023 13:31:20 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Chuck Lever <chuck.lever@oracle.com>,
        Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v8 0/5] fs: multigrain timestamps for XFS's change_cookie
Message-ID: <20230924-mitfeiern-vorladung-13092c2af585@brauner>
References: <20230922-ctime-v8-0-45f0c236ede1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230922-ctime-v8-0-45f0c236ede1@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> My initial goal was to implement multigrain timestamps on most major
> filesystems, so we could present them to userland, and use them for
> NFSv3, etc.

If there's no clear users and workloads depending on this other than for
the sake of NFS then we shouldn't expose this to userspace. We've tried
this and I'm not convinced we're getting anything other than regressions
out of it. Keep it internal and confined to the filesystem that actually
needs this.
