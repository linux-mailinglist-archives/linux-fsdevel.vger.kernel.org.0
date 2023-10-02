Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBB17B599C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 20:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238730AbjJBSEL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 14:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238683AbjJBSEK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 14:04:10 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683B9C6
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Oct 2023 11:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kMkXPY09uh/Uafe680LqPAEf27c3XmgZnFGzu262Tp4=; b=OZn/K1Ho1Hp14WWR0YEt+wNujK
        cbhAczz/M6tJUv3t/NIFPPoT6Noa/27xp/hZ/mobRQBfZ6acHK9uRHQGcN4/Va3FiWMb4K2bf0ssB
        oXTZbrM8DrDqnKvM77Qho2oyn1qQAv9e36UDeEfPem2BJ1W6voue/qzzETzYz1HUV+3tYy+IizIZv
        rfEaIlWXfM0S5H/us2NR8wOXqWU8UVsa3dkX+E9u8diLCraWzgziYMr4UfMWZFzuSdTZ9U4NQY7BF
        y4+FVte7SBXR5nlReRP5JeSfNn8O5tRcmntu6ucEFk35rls3rJVUmy19/xYyruZ2ODm5LYTZqxi9j
        i2opkf5g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qnNGy-00EbUg-2M;
        Mon, 02 Oct 2023 18:04:00 +0000
Date:   Mon, 2 Oct 2023 19:04:00 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Namjae Jeon <linkinjeon@kernel.org>,
        David Sterba <dsterba@suse.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Steve French <sfrench@samba.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH 02/15] exfat: move freeing sbi, upcase table and dropping
 nls into rcu-delayed helper
Message-ID: <20231002180400.GY800259@ZenIV>
References: <20231002022815.GQ800259@ZenIV>
 <20231002022846.GA3389589@ZenIV>
 <20231002023015.GC3389589@ZenIV>
 <CAHk-=wjDRb4OyO9ARykQWuC7GJmj1N0uKH-CghXgjW5ypdnQ4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjDRb4OyO9ARykQWuC7GJmj1N0uKH-CghXgjW5ypdnQ4g@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 02, 2023 at 09:10:22AM -0700, Linus Torvalds wrote:
> On Sun, 1 Oct 2023 at 19:30, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > That stuff can be accessed by ->d_hash()/->d_compare(); as it is, we have
> > a hard-to-hit UAF if rcu pathwalk manages to get into ->d_hash() on a filesystem
> > that is in process of getting shut down.
> >
> > Besides, having nls and upcase table cleanup moved from ->put_super() towards
> > the place where sbi is freed makes for simpler failure exits.
> 
> I don't disagree with moving the freeing,  but the RCU-delay makes me go "hmm".
> 
> Is there some reason why we can't try to do this in generic code? The
> umount code already does RCU delays for other things, I get the
> feeling that we should have a RCu delay between "put_super" and
> "kkill_sb".
> 
> Could we move the ->kill_sb() call into destroy_super_work(), which is
> already RCU-delayed, for example?
> 
> It feels wrong to have the filesystems have to deal with the vfs layer
> doing RCU-lookups.

	For one thing, ->kill_sb() might do tons of IO.  And we really want
to have that done before umount(2) returns to userland, so that part can't
be offloaded via schedule_work()...
