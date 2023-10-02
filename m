Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7A27B4C7E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 09:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235729AbjJBHXh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 03:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235696AbjJBHXg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 03:23:36 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6BD8E
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Oct 2023 00:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=SRXOr9gSjU2laD7D7wii+BuW599f+TtGiurhtWOQKNY=; b=afQKreWSx7HXeT1InmbDhnRKY0
        tAOWRkhR1VQ+35YtOz2UNP6wN2tKq2KEtC0EO7Rh9sj35t72jfhpOKJQ6ot4bjmWfV2uXA/wmTNLq
        tUh8PQ1fWsrX49ON7tcorw5CtfVP9rT08gTXFwpvKRdoNasnc+riCP7c4XNrgCB+6NFnf03A1PUE2
        S2y6iiTWQmHc8LeEhxAQ0n0USah42ntunnzL9Zf7gksvpKyxgU9AmhA0UOefkxU/L6Go8QRuD2+ze
        XoLhrWSxB8aRpILGnMJoek+t+465RPwuNGeYiafGCd6sdSGvwyWEYN9DVnkiDQCWSpDnZaasF9+8X
        LembeEaQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qnDHA-00EKG1-0U;
        Mon, 02 Oct 2023 07:23:32 +0000
Date:   Mon, 2 Oct 2023 08:23:32 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        David Sterba <dsterba@suse.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Steve French <sfrench@samba.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH 15/15] overlayfs: make use of ->layers safe in rcu
 pathwalk
Message-ID: <20231002072332.GV800259@ZenIV>
References: <20231002022815.GQ800259@ZenIV>
 <20231002022846.GA3389589@ZenIV>
 <20231002023613.GN3389589@ZenIV>
 <20231002023643.GO3389589@ZenIV>
 <20231002023711.GP3389589@ZenIV>
 <CAOQ4uxjAcKVGT03uDTNYiSoG2kSgT9eqbqjBThwTo7pF0jef4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjAcKVGT03uDTNYiSoG2kSgT9eqbqjBThwTo7pF0jef4g@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 02, 2023 at 09:40:15AM +0300, Amir Goldstein wrote:
> On Mon, Oct 2, 2023 at 5:37 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > ovl_permission() accesses ->layers[...].mnt; we can't have ->layers
> > freed without an RCU delay on fs shutdown.  Fortunately, kern_unmount_array()
> > used to drop those mounts does include an RCU delay, so freeing is
> > delayed; unfortunately, the array passed to kern_unmount_array() is
> > formed by mangling ->layers contents and that happens without any
> > delays.
> >
> > Use a separate array instead; local if we have a few layers,
> > kmalloc'ed if there's a lot of them.  If allocation fails,
> > fall back to kern_unmount() for individual mounts; it's
> > not a fast path by any stretch of imagination.
> 
> If that is the case, then having 3 different code paths seems
> quite an excessive over optimization...
> 
> I think there is a better way -
> layout the mounts array linearly in ofs->mounts[] to begin with,
> remove .mnt out of ovl_layer and use ofs->mounts[layer->idx] to
> get to a layer's mount.
> 
> I can try to write this patch to see how it ends up looking.

Fine by me; about the only problem I see is the cache footprint...
How many layers do you consider the normal use, actually?
