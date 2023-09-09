Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06AB779979D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Sep 2023 13:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344931AbjIILVz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Sep 2023 07:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjIILVy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Sep 2023 07:21:54 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A044CF2;
        Sat,  9 Sep 2023 04:21:51 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 601F26732D; Sat,  9 Sep 2023 13:21:47 +0200 (CEST)
Date:   Sat, 9 Sep 2023 13:21:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Zdenek Kabelac <zkabelac@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH] fix writing to the filesystem after unmount
Message-ID: <20230909112147.GA12000@lst.de>
References: <20230906-aufheben-hagel-9925501b7822@brauner> <60f244be-803b-fa70-665e-b5cba15212e@redhat.com> <20230906-aufkam-bareinlage-6e7d06d58e90@brauner> <818a3cc0-c17b-22c0-4413-252dfb579cca@redhat.com> <20230907094457.vcvmixi23dk3pzqe@quack3> <20230907-abgrenzen-achtung-b17e9a1ad136@brauner> <513f337e-d254-2454-6197-82df564ed5fc@redhat.com> <20230908073244.wyriwwxahd3im2rw@quack3> <86235d7a-a7ea-49da-968e-c5810cbf4a7b@redhat.com> <20230908102014.xgtcf5wth2l2cwup@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908102014.xgtcf5wth2l2cwup@quack3>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 08, 2023 at 12:20:14PM +0200, Jan Kara wrote:
> Well, currently you click some "Eject / safely remove / whatever" button
> and then you get a "wait" dialog until everything is done after which
> you're told the stick is safe to remove. What I imagine is that the "wait"
> dialog needs to be there while there are any (or exclusive at minimum) openers
> of the device. Not until umount(2) syscall has returned. And yes, the
> kernel doesn't quite make that easy - the best you can currently probably
> do is to try opening the device with O_EXCL and if that fails, you know
> there's some other exclusive open.

... and the simple answer to the problem is to have an event notification
for when the super_block has finally been destroyed.  That way the
application gets this notification directly instead of having to make
a process synchronous that fundamentally isn't as explained in this thread.

