Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B5474794C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 22:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjGDU4I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 16:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjGDU4G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 16:56:06 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCA0E7B
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jul 2023 13:56:06 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-102-5.bstnma.fios.verizon.net [173.48.102.5])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 364KtTX5016481
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Jul 2023 16:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1688504133; bh=+IHk8YSJoTMTlfyKSqeJRbN0ZDGPNH4j7UG15hoATpY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=KsE/PTPPyIAtzyeQEVRROjWK4C270r6UA8WxxecB3vEiwUx0vkLRY2Nc5Cytin9uw
         j5+RxqtRgCasXKlCRDkJ+ZjqOkZ2aawBSNmGoekNMEpfGCFDSF5xo3ozSuOBULVH5y
         MMezXK1KH8Jqqm+xO001ohXUlztNJeEWLBA9l5fCnOkdogaObBEdtQxOzpM2gVrB6j
         cGXKNxQSW1NOOTyaWMhCc7sHYhyAGfNqfu0gpTl4iqfHdcRlrBwgL1vs7LVkIZPS7v
         hho8LiIA3ooAxUNWVQWJzURK4nUz2cPcYhydAwlUy00OJEUWyIaYV3+4WS1ZfmshTF
         sGIoUbYg+B+Uw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 24F9E15C0280; Tue,  4 Jul 2023 16:55:29 -0400 (EDT)
Date:   Tue, 4 Jul 2023 16:55:29 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Kees Cook <keescook@google.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Alexander Popov <alex.popov@linux.com>,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH 1/6] block: Add config option to not allow writing to
 mounted devices
Message-ID: <20230704205529.GH1178919@mit.edu>
References: <20230704122727.17096-1-jack@suse.cz>
 <20230704125702.23180-1-jack@suse.cz>
 <20230704184416.GE1851@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704184416.GE1851@sol.localdomain>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 04, 2023 at 11:44:16AM -0700, Eric Biggers wrote:
> Does this prevent the underlying storage from being written to?  Say if the
> mounted block device is /dev/sda1 and someone tries to write to /dev/sda in the
> region that contains sda1.
> 
> I *think* the answer is no, writes to /dev/sda are still allowed since the goal
> is just to prevent writes to the buffer cache of mounted block devices, not
> writes to the underlying storage.  That is really something that should be
> stated explicitly, though.

Well, at the risk of giving the Syzbot developers any ideas, we also
aren't preventing someone from opening the SCSI generic device and
manually sending raw SCSI commands to modify a mounted block device,
and then no doubt they would claim that the kernel config
CONFIG_CHR_DEV_SG is "insecure", and so therefore any kernel that
could support writing CD or DVD's is by definition "insecure" by their
lights...

Which is why talking about security models without having an agreed
upon threat model is really a waste of time...

     	    	     	      	       - Ted
				       
