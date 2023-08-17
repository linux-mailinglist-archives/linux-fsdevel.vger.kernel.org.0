Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E1277FBB1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 18:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351830AbjHQQMJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 12:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353632AbjHQQLw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 12:11:52 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B003359B
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 09:11:49 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-102-95.bstnma.fios.verizon.net [173.48.102.95])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37HGBITO024446
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 12:11:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692288680; bh=fHPwV6TxvRwbeuDja45CNkKtsuGepircRHRBRc+9VD0=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=k//JNo1Dto08rEtdMfX3xvu+Q84a+tcpM7rjCcVEZCZ/4bJAp37FiUVVd5W9RCF9U
         sIldjWLdoh9rNe0k0f9Ub9a2zTWfPqbzfqIAA+n8FDlJpEaMe5W+sjwR2W+81bluaH
         dKL2iJHt28/zBZUs+8KwVe1Ptg7dSXIbKpJpTmQHTS1p0Dha8MOiqZB/mjqDjkgF4f
         dZ7A9XiHtuZGdE3Xp6mkUKAGMab7oMPaYrlHE3qWDJK9N2x+4tvp4QuXVRwDeOwWVi
         3yyNZOlBCaynD30v42Lxjh2jTu9gRVWOXhcLj2Hv3PdoExGooJDQBKEq3K7OslVP8H
         zSD37HkvPfHUA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0CB9515C0501; Thu, 17 Aug 2023 12:11:18 -0400 (EDT)
Date:   Thu, 17 Aug 2023 12:11:18 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     sandeen@redhat.com
Cc:     syzbot <syzbot+27eece6916b914a49ce7@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Subject: Re: [syzbot] [ext4?] kernel panic: EXT4-fs (device loop0): panic
 forced after error (3)
Message-ID: <20230817161118.GC2247938@mit.edu>
References: <000000000000530e0d060312199e@google.com>
 <20230817142103.GA2247938@mit.edu>
 <81f96763-51fe-8ea1-bf81-cd67deed9087@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81f96763-51fe-8ea1-bf81-cd67deed9087@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 17, 2023 at 09:47:48AM -0500, Eric Sandeen wrote:
> 
> Just to play devil's advocate here - (sorry) - I don't see this as any
> different from any other "malicious" filesystem image.
> 
> I've never been a fan of the idea that malicious images are real security
> threats, but whether the parking lot USB stick paniced the box in an
> unexpected way or "on purpose," the result is the same ...
> 
> I wonder if it might make sense to put EXT4_MOUNT_ERRORS_PANIC under a
> sysctl or something, so that admins can enable it only when needed.

Well, if someone is stupid enough to plug in a parking lot USB stick
into their system, they get everything they deserve.  And a forced
panic isn't going to lead a more privilege escalation attack, so I
really don't see a problem if a file system which is marked "panic on
error", well, causes a panic.  It's a good way of (harmlessly)
punishing stupid user tricks.  :-)

The other way of thinking about it is that if your threat model
includes an attacker with physical access to the server with a USB
port, attacks include a cable which has a USB port on one side, and a
120V/240V AC mains plug on the the other.  This will very likely cause
a system shutdown, even if they don't have automount enabled.   :-)

							- Ted
