Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C126E2043
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 12:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjDNKGx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 06:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjDNKGv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 06:06:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67A17DB6;
        Fri, 14 Apr 2023 03:06:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C6D06461A;
        Fri, 14 Apr 2023 10:06:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B22C433EF;
        Fri, 14 Apr 2023 10:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681466800;
        bh=pofcLnZNlI4YpasCM6NShd9Ckkvt2E6/4pxL/gweqTA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=lK8/T9mt3ZXTYQswtJaF8mHP4DHhnUHuGHTPSH6jyi87+7FgNfJWc3riY3JELm2qP
         D/lNwJNB0AnF7zy0LN9q9fNqM+oL21fCII/q+UvMxbINFaCvLcmtSq8TSQMT3edcHO
         EJFUYVTtsswhWS+UR4cnQIU8N+FShFxtyPZ19Qmp5jUP/n+tbhPse+xOh8cccqGRxh
         GBvZmY9YV2+bEmf0RuWP1HghBNMZhJVqmWP2yMh19L163iN7nekNlJpjZWbcmAO8Ce
         lBPmL9W9hyBQ6K1j3B9FeHy7jj1eE6EdJpsTMEHLSXj4L8lNRC0aazzQ8GG4cPVsww
         oV+LrdnjFO0nA==
Message-ID: <2631cb9c05087ddd917679b7cebc58cb42cd2de6.camel@kernel.org>
Subject: Re: allowing for a completely cached umount(2) pathwalk
From:   Jeff Layton <jlayton@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>, NeilBrown <neilb@suse.de>
Cc:     Christian Brauner <brauner@kernel.org>,
        Dave Wysochanski <dwysocha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Date:   Fri, 14 Apr 2023 06:06:38 -0400
In-Reply-To: <20230414024312.GF3390869@ZenIV>
References: <95ee689c76bf034fa2fe9fade0bccdb311f3a04f.camel@kernel.org>
         <168142566371.24821.15867603327393356000@noble.neil.brown.name>
         <20230414024312.GF3390869@ZenIV>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2023-04-14 at 03:43 +0100, Al Viro wrote:
> On Fri, Apr 14, 2023 at 08:41:03AM +1000, NeilBrown wrote:
>=20
> > The path name that appears in /proc/mounts is the key that must be used
> > to find and unmount a filesystem.  When you do that "find"ing you are
> > not looking up a name in a filesystem, you are looking up a key in the
> > mount table.
>=20
> No.  The path name in /proc/mounts is *NOT* a key - it's a best-effort
> attempt to describe the mountpoint.  Pathname resolution does not work
> in terms of "the longest prefix is found and we handle the rest within
> that filesystem".
>=20
> > We could, instead, create an api that is given a mount-id (first number
> > in /proc/self/mountinfo) and unmounts that.  Then /sbin/umount could
> > read /proc/self/mountinfo, find the mount-id, and unmount it - all
> > without ever doing path name lookup in the traditional sense.
> >=20
> > But I prefer your suggestion.  LOOKUP_MOUNTPOINT could be renamed
> > LOOKUP_CACHED, and it only finds paths that are in the dcache, never
> > revalidates, at most performs simple permission checks based on cached
> > content.
>=20
> umount /proc/self/fd/42/barf/something
>=20

Does any of that involve talking to the server? I don't necessarily see
a problem with doing the above. If "something" is in cache then that
should still work.

The main idea here is that we want to avoid communicating with the
backing store during the umount(2) pathwalk.

> Discuss.
>=20
> OTON, umount-by-mount-id is an interesting idea, but we'll need to decide
> what would the right permissions be for it.
>=20
> But please, lose the "mount table is a mapping from path prefix to filesy=
stem"
> notion - it really, really is not.  IIRC, there are systems that work tha=
t way,
> but it's nowhere near the semantics used by any Unices, all variants of L=
inux
> included.

I'm not opposed to something by umount-by-mount-id either. All of this
seems like something that should probably rely on CAP_SYS_ADMIN.
--=20
Jeff Layton <jlayton@kernel.org>
