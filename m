Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD016E1A81
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 04:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjDNCn5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 22:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjDNCno (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 22:43:44 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AD95FE2;
        Thu, 13 Apr 2023 19:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jqKaCs+Xg68lf0Aqkm/WtZSel69SOQIWeTNIPifGmoU=; b=eJZu5Pa60RMhD7xuIeezWoX/Vu
        cX2TrHOrhTIikLL12aBK6EPDzCAr83e04vWNBJg0LicwEQgo2VSOY/8BWMIzMwsOxeMHI7ALrE/WM
        1xPlSmoDW33+lRp8QaYpHxgZGe1tzq7epqAB80whfpmwU052Wovzgnpv5fnzy7sAZYo6F9WN11jNS
        RV32GB/Xv3ZoHFt8Jz8nrhhSC7iKMKBWkXhBj2W4G2aUThZj/wsHW1NdUKMvFE5DPL+psn8v8SKuU
        aPWjsdB4a51Ru2BuOoIOwVswWSmWHH62ur1sRqzJRK0E5ume7OpmYuNKBBv6Is1ggVc3AE8EUp+Jp
        CUq6YG7w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pn9P6-008p9d-2x;
        Fri, 14 Apr 2023 02:43:12 +0000
Date:   Fri, 14 Apr 2023 03:43:12 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Dave Wysochanski <dwysocha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: allowing for a completely cached umount(2) pathwalk
Message-ID: <20230414024312.GF3390869@ZenIV>
References: <95ee689c76bf034fa2fe9fade0bccdb311f3a04f.camel@kernel.org>
 <168142566371.24821.15867603327393356000@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168142566371.24821.15867603327393356000@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 14, 2023 at 08:41:03AM +1000, NeilBrown wrote:

> The path name that appears in /proc/mounts is the key that must be used
> to find and unmount a filesystem.  When you do that "find"ing you are
> not looking up a name in a filesystem, you are looking up a key in the
> mount table.

No.  The path name in /proc/mounts is *NOT* a key - it's a best-effort
attempt to describe the mountpoint.  Pathname resolution does not work
in terms of "the longest prefix is found and we handle the rest within
that filesystem".

> We could, instead, create an api that is given a mount-id (first number
> in /proc/self/mountinfo) and unmounts that.  Then /sbin/umount could
> read /proc/self/mountinfo, find the mount-id, and unmount it - all
> without ever doing path name lookup in the traditional sense.
> 
> But I prefer your suggestion.  LOOKUP_MOUNTPOINT could be renamed
> LOOKUP_CACHED, and it only finds paths that are in the dcache, never
> revalidates, at most performs simple permission checks based on cached
> content.

umount /proc/self/fd/42/barf/something

Discuss.

OTON, umount-by-mount-id is an interesting idea, but we'll need to decide
what would the right permissions be for it.

But please, lose the "mount table is a mapping from path prefix to filesystem"
notion - it really, really is not.  IIRC, there are systems that work that way,
but it's nowhere near the semantics used by any Unices, all variants of Linux
included.
