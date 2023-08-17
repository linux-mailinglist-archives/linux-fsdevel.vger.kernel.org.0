Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707E777F98D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 16:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352186AbjHQOqL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 10:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352260AbjHQOpy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:45:54 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800EC2D78
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 07:45:36 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-102-95.bstnma.fios.verizon.net [173.48.102.95])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37HEj5ra010416
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 10:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692283508; bh=gqsQDXWAnHGIA5wHjYhwbJKrvhNPOC3ihUy4KEVsRbg=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=VCLuFhlGxpiG5q5PKk9rfLuahkD+JTe4C8shieNnJ+qEvLQFZ5MD7sARRyYRIUIh1
         t6xYC9YZ/wG/LMGz770Pe3iSn0XOAGGcgKGzV+pYrfz6blivZRSeispcufwVXEswZj
         xyAOPJEiym13NldRb6wmoLug5KhV0rqU5BoAv0MUyiVBuzC3ZNPPDTLYBk5JtPtbBj
         YGkP7SbdQriEmBWs1jFIwpEI+IYqyZMVkcX5tihxzOhoeVNl4u5mPh7ErJUewMn2tT
         tGO499QHqGlLi8BHiznCT13uO46P6AjauaoUUNGW71RshxHhBBz6l6P1P5895YcUF7
         uZvjcskeFMW8w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3D6B115C0501; Thu, 17 Aug 2023 10:45:05 -0400 (EDT)
Date:   Thu, 17 Aug 2023 10:45:05 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Aleksandr Nogikh <nogikh@google.com>
Cc:     syzbot <syzbot+27eece6916b914a49ce7@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Subject: Re: [syzbot] [ext4?] kernel panic: EXT4-fs (device loop0): panic
 forced after error (3)
Message-ID: <20230817144505.GB2247938@mit.edu>
References: <000000000000530e0d060312199e@google.com>
 <20230817142103.GA2247938@mit.edu>
 <CANp29Y7jbcOw_rS5vbfWNo7Y+ySYhYS-AWC356QN=JRVOm9B8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANp29Y7jbcOw_rS5vbfWNo7Y+ySYhYS-AWC356QN=JRVOm9B8w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 17, 2023 at 04:28:33PM +0200, Aleksandr Nogikh wrote:
> The console log has the following line:
> 
> [   60.708717][ T5061] Kernel panic - not syncing: EXT4-fs (device
> loop0): panic forced after error
> 
> Can we consider a "panic forced after error" line to be a reliable
> indicator that syzbot must ignore the report?

Yes.  And the file system image that generated this bug should be
discarded, because otherwise successive mutations will generate a
large number of crashes that syzbot will then need to ignore, thus
consuming syzbot resources.

Alternatively, you can do the moral equivalent of "tune2fs -e continue
foo.img" on any mutated file system seed, which will clear the "panic
on error".

(The other alternative is "tune2fs -e remount-ro", but given syzbot's
desire to find kernel crashes, "tune2fs -e continue" is more likely
find ways in which the kernel will find itself into trouble.  Some
sysadmins will want to chose "remount-ro", however, since that is more
likely to limit file system damage once the file system is discovered
to be corrupted.)

					- Ted
					
