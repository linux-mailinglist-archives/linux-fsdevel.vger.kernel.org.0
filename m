Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56F87977C0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 18:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240400AbjIGQcL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 12:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237826AbjIGQbn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:31:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF37729D;
        Thu,  7 Sep 2023 09:19:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47749C4163D;
        Thu,  7 Sep 2023 10:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694083425;
        bh=1vXm+N0KQAmOUF0rkbuYz8BuTT/Y/M1TZb80uOOLxBE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fe/+0m7vI5L4s3w22eRJ8BLMFELOVYkfJ6kVol8/cK8OppAeCZti0ensvkP99bj+f
         1QSl3CbpRe45f1eNmENJTorrh4H0QwCcWyg+lxCHeKuFZGBEH1ehR4SaaDCqSnBiG9
         f24bFSQEWhVFHR8DqY0zkiLdbsgj2F4+1NIFvR1Woiz7ewQrXiXyKYaS3ikRQIFBB8
         0DCZ1Oz+VYuhHjOcsRLB9hEqeg5jV9TVDiVlOqMoo7H4mBfqqFxaiWX14fmovvjhoN
         NEtp++Swq9pI8uVAotln55KmC4p/WG4yk48JoLonoWK64O6DZ4Rwy4afge8osS0LAw
         g823czBcOE6RQ==
Date:   Thu, 7 Sep 2023 12:43:40 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Zdenek Kabelac <zkabelac@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH] fix writing to the filesystem after unmount
Message-ID: <20230907-abgrenzen-achtung-b17e9a1ad136@brauner>
References: <59b54cc3-b98b-aff9-14fc-dc25c61111c6@redhat.com>
 <20230906-launenhaft-kinder-118ea59706c8@brauner>
 <f5d63867-5b3e-294b-d1f5-a128817cfc7@redhat.com>
 <20230906-aufheben-hagel-9925501b7822@brauner>
 <60f244be-803b-fa70-665e-b5cba15212e@redhat.com>
 <20230906-aufkam-bareinlage-6e7d06d58e90@brauner>
 <818a3cc0-c17b-22c0-4413-252dfb579cca@redhat.com>
 <20230907094457.vcvmixi23dk3pzqe@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230907094457.vcvmixi23dk3pzqe@quack3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> I think we've got too deep down into "how to fix things" but I'm not 100%

We did.

> sure what the "bug" actually is. In the initial posting Mikulas writes "the
> kernel writes to the filesystem after unmount successfully returned" - is
> that really such a big issue? Anybody else can open the device and write to
> it as well. Or even mount the device again. So userspace that relies on
> this is kind of flaky anyway (and always has been).

Yeah, agreed.

> namespaces etc. I'm not sure such behavior brings much value...

It would in any case mean complicating our code for little gain imho.
And as I showed in my initial reply the current patch would hang on any
bind-mount unmount. IOW, any container. And Al correctly points out
issues with exit(), close() and friends on top of that.

But I also hate the idea of waiting on the last umount because that can
also lead to new unexpected behavior when e.g., the system is shutdown
and systemd goes on to unmount all things and then suddenly just hangs
when before it was able to make progress.

And returning EBUSY is tricky as well as we somehow would need to have a
way to refcount in a manner that let's us differentiate between last-
"user-visible"-superblock-reference" and
last-active-superblock-reference which would complicate things even more.

I propose we clearly document that unmounting a frozen filesystem will
mean that the superblock stays active at least until the filesystem is
unfrozen.

And if userspace wants to make sure to not recycle such a frozen
superblock they can now use FSCONFIG_CMD_CREATE_EXCL to detect that.

What might be useful is to extend fanotify. Right now we have
fsnotify_sb_delete() which lets you detect that a superblock has been
destroyed (generic_shutdown_super()). It could be useful to also get
notified when a superblock is frozen and unfrozen?
