Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4847902CE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Sep 2023 22:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350720AbjIAUZC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Sep 2023 16:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350717AbjIAUZB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Sep 2023 16:25:01 -0400
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc0b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF05E7E
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Sep 2023 13:24:56 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4RcqJk4phnzMqJ78;
        Fri,  1 Sep 2023 20:24:54 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4RcqJj6f1pzMpnPd;
        Fri,  1 Sep 2023 22:24:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1693599894;
        bh=EgaudXTLVB2Z3ZuXye/H8fFu5K/48RR41qfT8koWAoA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IbPX/HCJQAuKsDQgr2BmAGc3Pjryrjdw7irGRXwkVjJ9Av8Y78+BcA/RgJgPq1M0a
         +jual7Izi5b8VKage26qXj/Ulr3C4gzpMcFjL72HXNIXpvslc17cYnsVhGDatj/UPU
         zHizYs+Gj9JuURNoSuKj9MWJjd4aihiG/Lk9I6hw=
Date:   Fri, 1 Sep 2023 22:24:43 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc:     linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Matt Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: Re: [PATCH v3 2/5] selftests/landlock: Test ioctl support
Message-ID: <20230901.OhT2suinooGh@digikod.net>
References: <20230814172816.3907299-1-gnoack@google.com>
 <20230814172816.3907299-3-gnoack@google.com>
 <20230818.HopaLahS0qua@digikod.net>
 <ZOjN7dub5QGJOzSX@google.com>
 <20230825.ohtoh6aivahX@digikod.net>
 <20230901133559.gazeeteejw2ebpxm@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230901133559.gazeeteejw2ebpxm@google.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 01, 2023 at 03:35:59PM +0200, Günther Noack wrote:
> Hello!
> 
> On Fri, Aug 25, 2023 at 07:07:01PM +0200, Mickaël Salaün wrote:
> > On Fri, Aug 25, 2023 at 05:51:09PM +0200, Günther Noack wrote:
> > > Hello!
> > > 
> > > On Fri, Aug 18, 2023 at 07:06:07PM +0200, Mickaël Salaün wrote:
> > > > On Mon, Aug 14, 2023 at 07:28:13PM +0200, Günther Noack wrote:
> > > > > @@ -3639,7 +3639,7 @@ TEST_F_FORK(ftruncate, open_and_ftruncate)
> > > > >  	};
> > > > >  	int fd, ruleset_fd;
> > > > >  
> > > > > -	/* Enable Landlock. */
> > > > > +	/* Enables Landlock. */
> > > > >  	ruleset_fd = create_ruleset(_metadata, variant->handled, rules);
> > > > >  	ASSERT_LE(0, ruleset_fd);
> > > > >  	enforce_ruleset(_metadata, ruleset_fd);
> > > > > @@ -3732,6 +3732,96 @@ TEST(memfd_ftruncate)
> > > > >  	ASSERT_EQ(0, close(fd));
> > > > >  }
> > > > 
> > > > We should also check with O_PATH to make sure the correct error is
> > > > returned (and not EACCES).
> > > 
> > > Is this remark referring to the code before it or after it?
> > > 
> > > My interpretation is that you are asking to test that test_fioqsize_ioctl() will
> > > return errnos correctly?  Do I understand that correctly?  (I think that would
> > > be a little bit overdone, IMHO - it's just a test utility of ~10 lines after
> > > all, which is below the threshold where it can be verified by staring at it for
> > > a bit. :))
> > 
> > I was refering to the previous memfd_ftruncate test, which is changed
> > with a next patch. We should check the access rights tied (and checkd)
> > to FD (i.e. truncate and ioctl) opened with O_PATH.
> 
> OK, I added a test that checks ioctl(2) and ftruncate(2) on files that
> were opened with O_PATH, both before and after enabling Landlock.
> ftruncate() and ioctl() always give an EBADF error, both before and
> after enabling Landlock (as described in open(2) in the section about
> O_PATH).

Good!

> 
> A bit outside of the IOCTL path set scope:
> 
> I was surprised that it is even possible to successfully open a file
> with O_PATH, even after Landlock is enabled and restricts all it can
> in that file hierarchy.  This lets you detect that a file exists, even
> when that file is in a directory whose contents you are otherwise not
> permitted to list due to Landlock.

This is indeed intended and tested with the effective_access test.
O_PATH is handled the same way as chdir (and similar path-based
syscalls) and always allowed. However, I just realized that the O_PATH
case is not explicitly mentioned in the documentation.

> 
> The logic for that is in the get_required_file_open_access() function.
> Should we add a "LANDLOCK_ACCESS_FS_PATH_FILE" right, which would work
> similar to LANDLOCK_ACCESS_FS_READ_FILE and
> LANDLOCK_ACCESS_FS_WRITE_FILE, so that this can be restricted?

Having a file descriptor opened with O_PATH should not give any specific
access (hence the need to test with IOCTLs). O_PATH is designed to get an
explicit reference to the filesystem (without the issues of paths) and
use the related FD with *at() syscalls, including landlock_add_rule()
with a path_beneath rule.  FDs opened with O_PATH should not be an issue
by themselves for a sandbox, but the real issue is to discover paths,
i.e. the directory's execute access right.  This is why I think it would
make more sense to have something like a LANDLOCK_ACCESS_FS_WALK right
instead. This would enable to definitely deny any access to a file
hierarchy.

For chdir-like syscalls, we could rely on path_permission(), but for a
more holistic approach we need to properly handle the execute permission
on directories. See Christian's comment on chdir/path_permission and the
limit of what an LSM can infer from paths:
https://lore.kernel.org/r/20230530-mietfrei-zynisch-8b63a8566f66@brauner

We could rely on the last walked (leaf) dentry to allow or deny such
walk, but that would still enable malicious processes to infer path
because of intermediate walk that may return ENOENT. We could also
return ENOENT instead of EACCES, but this would not handle the case of
other access controls returning EACCES.

With this in mind, I think the better solution is to properly check each
intermediate directory during a path walk. This is not
currently possible with path-based LSM hooks but I think that we could
add a new LSM hook in filename_lookup(), close to the audit_inode()
call, to get the necessary information about the currently walked
directory.

Simply using this new hook with Landlock would add a significant
performance impact because of the way Landlock identifies paths (i.e.
walk back). An interesting approach to efficiently check Landlock access
right would be to store the collected access rights of a path in a
cache, and use it when checking a "child" of this path. According to
task_struct, there is only one path walk at a time per thread, which
would enable us to have only one cached path per task and
opportunistically use it in Landlock's is_access_to_paths_allowed() as a
backstop to end the walk. With this trick, I think in most cases no walk
back would be required, which would be great for performance. The main
challenge would be to efficiently handle the ".." directories.
See an initial approach of caching for Landlock:
https://lore.kernel.org/r/20210630224856.1313928-1-mic@digikod.net

Being able to control path walks would be a way to use (most?)
inode-based LSM hooks for Landlock, especially the
security_inode_permission(). Indeed. we could then tie an inode to a
path (resolution) thanks to the cache (and potentially other caches
according to the number of checked inodes).  This would be great for new
access rights such as LANDLOCK_ACCESS_FS_{READ,WRITE}_METADATA.

Xiu, that would be a good opportunity to continue your work, and
probably without waiting for IMA to be converted to a proper LSM. What
do you think?
