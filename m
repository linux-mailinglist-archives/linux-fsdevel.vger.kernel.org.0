Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624387AEC32
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Sep 2023 14:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbjIZMLI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Sep 2023 08:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234540AbjIZMLH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Sep 2023 08:11:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F0610E;
        Tue, 26 Sep 2023 05:11:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25C1C433C7;
        Tue, 26 Sep 2023 12:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695730260;
        bh=O2z7OioDXm74KMl0zRdCUt79HUvbW522ehMNV8lx44s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M73Byivq+oBHbE1CDYzwaclHKGN2Ea0ZQd9tRJ6IGot1wG2PE8CwkZ+DuJ65sbqyH
         DsTvyI3TGqTWYqZxpp1NCd6jzikRLUnbrNgtKgWEFTcvdy+GHPeYvxtOSi5OXLFGEz
         7RO8n7IiDbc8D+jEAFi7ug8f5rPLIX3IEh47czWRqaZHctRx0VdZ42AYMB4sn4v4Hx
         LKyuFGTjGCIwjFnDM+2VE+jSW0OPAPbyDTAF5p9Qeba9Wr+6EzIdaLEyr1wQV4JMi+
         105RQyKapSzvRVeQ6+ycfyY5wx7OhzsvksWOK/3NR1ZWa4bFOmr8ydOAAqiMV7PVXf
         XjKtdx7YAwoYw==
Date:   Tue, 26 Sep 2023 14:10:54 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     NeilBrown <neilb@suse.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Chuck Lever <chuck.lever@oracle.com>,
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
Message-ID: <20230926-anregen-einplanen-6fd7d1a89ef8@brauner>
References: <20230922-ctime-v8-0-45f0c236ede1@kernel.org>
 <20230924-mitfeiern-vorladung-13092c2af585@brauner>
 <169559548777.19404.13247796879745924682@noble.neil.brown.name>
 <9b81a1f52b4dc777dbb5259b2e12e90eba0ff507.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9b81a1f52b4dc777dbb5259b2e12e90eba0ff507.camel@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > Some NFS servers run in userspace, and they would a "clear user" of this
> > functionality.
> > 
> 
> Indeed. Also, all of the programs that we're concerned about breaking
> here (make, rsync, etc.) could benefit from proper fine-grained
> timestamps:
> 
> Today, when they see two identical timestamps on files, these programs
> have to assume the worst: rsync has to do the copy, make has to update
> the target, etc. With a real distinguishable fine-grained timestamps,
> these programs would likely be more efficient and some of these unneeded
> operations would be avoided.

The whole sales pitch falls flat if we end up with wrong ordering of
timestamps which caused us to revert this. So unless this is fixed
we shouldn't expose this to userspace again.
