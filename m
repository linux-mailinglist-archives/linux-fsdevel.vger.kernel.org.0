Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFBA702106
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 03:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237721AbjEOBP3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 May 2023 21:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237798AbjEOBP1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 May 2023 21:15:27 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFE1170B
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 May 2023 18:15:26 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 34F1FD2l026343
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 May 2023 21:15:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1684113315; bh=NUk36MnobZ5doR8W/LOe+yxBh26GENvuifgWegftmzs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=kh/l6xzOc2xfI7R6XUEqUmxz+wbGlBanvDKC5eKdp3Cs6nom2RMTTNx54BN8/7+sa
         TH25DJ00FeQJ/d3D5YAqpSh/fhqgPY1QX4ZxZ3K9Fmu8AfVyZG2yk5Jsl6EFje7vyW
         9US2XkAI+e4ezfrYNcWYo5ceVCg5IGnO/lG+o055840atlQUeOXdjeFXEbDja0XE3f
         FFZcaXEQdIyI3aTNdJxb6sP3eu+zc8gW6xQLXGwKNrQ8J+fTGSR9fJ79qcWvBf8mZ9
         VjivQYYQ3dLn1CX4bqxEHOLXRehUwhl6va4jgSFnVYzYHzW3fTsBCQxnJOdsaJfznO
         osklg0hfRzCfg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4617C15C04AC; Sun, 14 May 2023 21:15:13 -0400 (EDT)
Date:   Sun, 14 May 2023 21:15:13 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     syzbot <syzbot+cbb68193bdb95af4340a@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, elic@nvidia.com, jasowang@redhat.com,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, parav@nvidia.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ext4?] possible deadlock in ext4_setattr
Message-ID: <20230515011513.GA1905432@mit.edu>
References: <000000000000a74de505f2349eb1@google.com>
 <000000000000a9377e05fbac4945@google.com>
 <20230514163907-mutt-send-email-mst@kernel.org>
 <20230515005321.GB1903212@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515005321.GB1903212@mit.edu>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 14, 2023 at 08:53:21PM -0400, Theodore Ts'o wrote:
> However, somewhere in the bisection, we start seeing this:
> 
> run #0: boot failed: WARNING in kvm_wait
   ...
> 
> This is a completely different failure signature, and the "WARNING in
> kvm_wait" should be ignored, and this should be considered a "git
> bisect good".  However, the syzkaller bisection doesn't understand
> this, and so it gets sent down the primrose path.  :-(

Sorry, I spoke too soon.  It did get this right; it looks like it
ignores "boot failed: " messages, although it treats is as one of the
10 tries for a particular commit.

I don't see anything obviously wrong with the bisect log, although
obviously I'd want to retry some of the "All OK" results to see if
somehow things got confused.  In any case, there have been a large
number of timees where the bisection results have been less than
correct, and unfortunately, there's not much that can be done other
than just to ignore them.  It would be nice to have a human being be
able to mark the bisection as Obviously Wrong(tm), and maybe ask it do
do a slightly different bisection.

Also unfortunate is that I've had more than one case where the problem
doesn't reproduce at all using KVM, but only reproduces using #syz
test.  Which means that manual bisection may be the only way for now
to work some of these.

					- Ted
