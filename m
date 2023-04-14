Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358176E2690
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 17:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjDNPNc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 11:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjDNPNb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 11:13:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD119757;
        Fri, 14 Apr 2023 08:13:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8803564779;
        Fri, 14 Apr 2023 15:13:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A02A3C433EF;
        Fri, 14 Apr 2023 15:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681485195;
        bh=TfKcpzUzJiZiOkD5VW46FyS8XxYrNl4SHEfqZfPZhuY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Te8N4Z+iev2n2EKLmN5OCafSRClIvluBR/5npS4FKc2Oy4t0+pAtzruCMHxTCU4B3
         rgR20b8V5kuuoArhJPVCLqEh3/VjlXb44C1MpaBuZ3RKamQwfOblhDU4NGiMrduCF4
         RGoLajqXP3EtKVN9UQ4fCWsnJG0hTcO/tWrdiDoncybxnhlPQP7oz4iI9hBL0qef+1
         O+iCpqh2g2oUtI+jMUOIw3RcjIUYgSJqU2WKG6ZB7FGudRhS+sTMo7ddhgQNphNhQf
         ltXH+B2oGfoW4r7UMdQnI5b4gHAgxXw6EXDhl/2bnfwOPALlJjW3C+qrYijxNrQeuO
         u2bIqrP4Icwdw==
Date:   Fri, 14 Apr 2023 17:13:06 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     Jeffrey Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Neil Brown <neilb@suse.de>,
        Dave Wysochanski <dwysocha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: allowing for a completely cached umount(2) pathwalk
Message-ID: <20230414-leiht-lektion-18f5a7a38306@brauner>
References: <95ee689c76bf034fa2fe9fade0bccdb311f3a04f.camel@kernel.org>
 <168142566371.24821.15867603327393356000@noble.neil.brown.name>
 <20230414024312.GF3390869@ZenIV>
 <2631cb9c05087ddd917679b7cebc58cb42cd2de6.camel@kernel.org>
 <20230414-sowas-unmittelbar-67fdae9ca5cd@brauner>
 <9192A185-03BF-4062-B12F-E7EF52578014@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9192A185-03BF-4062-B12F-E7EF52578014@hammerspace.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 14, 2023 at 02:21:00PM +0000, Trond Myklebust wrote:
> 
> 
> > On Apr 14, 2023, at 09:41, Christian Brauner <brauner@kernel.org> wrote:
> > 
> > On Fri, Apr 14, 2023 at 06:06:38AM -0400, Jeff Layton wrote:
> >> On Fri, 2023-04-14 at 03:43 +0100, Al Viro wrote:
> >>> On Fri, Apr 14, 2023 at 08:41:03AM +1000, NeilBrown wrote:
> >>> 
> >>>> The path name that appears in /proc/mounts is the key that must be used
> >>>> to find and unmount a filesystem.  When you do that "find"ing you are
> >>>> not looking up a name in a filesystem, you are looking up a key in the
> >>>> mount table.
> >>> 
> >>> No.  The path name in /proc/mounts is *NOT* a key - it's a best-effort
> >>> attempt to describe the mountpoint.  Pathname resolution does not work
> >>> in terms of "the longest prefix is found and we handle the rest within
> >>> that filesystem".
> >>> 
> >>>> We could, instead, create an api that is given a mount-id (first number
> >>>> in /proc/self/mountinfo) and unmounts that.  Then /sbin/umount could
> >>>> read /proc/self/mountinfo, find the mount-id, and unmount it - all
> >>>> without ever doing path name lookup in the traditional sense.
> >>>> 
> >>>> But I prefer your suggestion.  LOOKUP_MOUNTPOINT could be renamed
> >>>> LOOKUP_CACHED, and it only finds paths that are in the dcache, never
> >>>> revalidates, at most performs simple permission checks based on cached
> >>>> content.
> >>> 
> >>> umount /proc/self/fd/42/barf/something
> >>> 
> >> 
> >> Does any of that involve talking to the server? I don't necessarily see
> >> a problem with doing the above. If "something" is in cache then that
> >> should still work.
> >> 
> >> The main idea here is that we want to avoid communicating with the
> >> backing store during the umount(2) pathwalk.
> >> 
> >>> Discuss.
> >>> 
> >>> OTON, umount-by-mount-id is an interesting idea, but we'll need to decide
> >>> what would the right permissions be for it.
> >>> 
> >>> But please, lose the "mount table is a mapping from path prefix to filesystem"
> >>> notion - it really, really is not.  IIRC, there are systems that work that way,
> >>> but it's nowhere near the semantics used by any Unices, all variants of Linux
> >>> included.
> >> 
> >> I'm not opposed to something by umount-by-mount-id either. All of this
> >> seems like something that should probably rely on CAP_SYS_ADMIN.
> > 
> > The permission model needs to account for the fact that mount ids are
> > global and as such you could in principle unmount any mount in any mount
> > namespace. IOW, you can circumvent lookup restrictions completely.
> > 
> > So we could resolve the mnt-id to an FMODE_PATH and then very roughly
> > with no claim to solving everything:
> > 
> > may_umount_by_mnt_id(struct path *opath)
> > {
> > struct path root;
> > bool reachable;
> > 
> > // caller in principle able to circumvent lookup restrictions
> >        if (!may_cap_dac_readsearch())
> > return false;
> > 
> > // caller can mount in their mountns
> > if (!may_mount())
> > return false;
> > 
> > // target mount and caller in the same mountns
> > if (!check_mnt())
> > return false;
> > 
> > // caller could in principle reach mount from it's root
> > get_fs_root(current->fs, &root);
> >        reachable = is_path_reachable(real_mount(opath->mnt), opath->dentry, &root);
> > path_put(&root);
> > 
> > return reachable;
> > }
> > 
> > However, that still means that we have laxer restrictions on unmounting
> > by mount-id then on unmount with lookup as for lookup just having
> > CAP_DAC_READ_SEARCH isn't enough. Usually - at least for filesytems
> > without custom permission handlers - we also establish that the inode
> > can be mapped into the caller's idmapping.
> > 
> > So that would mean that unmounting by mount-id would allow you to
> > unmount mounts in cases where you wouldn't with umount. That might be
> > fine though as that's ultimately the goal here in a way.
> > 
> > One could also see a very useful feature in this where you require
> > capable(CAP_DAC_READ_SEARCH) and capable(CAP_SYS_ADMIN) and then allow
> > unmounting any mount in the system by mount-id. This would obviously be
> > very useful for privileged service managers but I haven't thought this
> > Through.
> 
> That is exactly why having a separate syscall to do the lookup of the mount-id is good: it provides separation of privilege.
> 
> The conversion of mount-id to an O_PATH file descriptor is just akin to a path lookup, so only needs CAP_DAC_READ_SEARCH (since you require privilege only to bypass the ACL directory read and lookup restrictions). The resulting O_PATH file descriptor has no special properties that require any further privilege.
> 
> Then use that resulting file descriptor for the umount, which normally requires CAP_SYS_ADMIN.

There's a difference between unmounting directly by providing a mount id
and getting an O_PATH file descriptor from a mnt-id. If you can simply
unmount by mount-id it's useful for users that have CAP_DAC_READ_SEARCH
in a container. Without it you likely need to require
capable(CAP_DAC_READ_SEARCH) aka system level privileges just like
open_to_handle_at() which makes this interface way less generic and
usable. Otherwise you'd be able to get an O_PATH fd to something that
you wouldn't be able to access through normal path lookup.
