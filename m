Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E60720503
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 16:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236300AbjFBO6f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 10:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbjFBO6e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 10:58:34 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337E4123
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jun 2023 07:58:33 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-119-27.bstnma.fios.verizon.net [173.48.119.27])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 352EwGbf018150
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Jun 2023 10:58:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1685717898; bh=dm8M0XPjrZMbj5kv6cSbTBNglQs4/hYnlvZYkoIUjfE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=MRom152hJvxtxgO34t1PpVfrQ8bgrFNaLf+9nEPtT5UX+l416vDplleCtKszLc8SW
         qtTpkT6beYpsRV0Dxq56/J9jJcFArzbDnopIkMAL6Wk6CBtu8zDiDb8h+pdzj5jJZ9
         EF19XNZTFb5VWIvXJ296XTTPUQEP0/VY8DZv1m6OwXUltwtlLH2y2GseoSSaKje59d
         kpIOZFCnv6HuaMDQ4KD9Ag2fpPYwvz7DQzeKHZLUmNM9x1WXfpEXeBxCv6VyDL9de8
         A1FJiciM7XaPlAnYgoNOceDWyq6Bl1L85HUHUfx9F9HmTKuHHrUOq1ujBXs0fizqcs
         VlshFHizmkjug==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7F68315C02EE; Fri,  2 Jun 2023 10:58:16 -0400 (EDT)
Date:   Fri, 2 Jun 2023 10:58:16 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: uuid ioctl - was: Re: [PATCH] overlayfs: Trigger file
 re-evaluation by IMA / EVM after writes
Message-ID: <20230602145816.GA1144615@mit.edu>
References: <20230407-trasse-umgearbeitet-d580452b7a9b@brauner>
 <078d8c1fd6b6de59cde8aa85f8e59a056cb78614.camel@linux.ibm.com>
 <20230520-angenehm-orangen-80fdce6f9012@brauner>
 <ZGqgDjJqFSlpIkz/@dread.disaster.area>
 <20230522-unsensibel-backblech-7be4e920ba87@brauner>
 <20230602012335.GB16848@frogsfrogsfrogs>
 <20230602042714.GE1128744@mit.edu>
 <ZHmNksPcA9tudSVQ@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHmNksPcA9tudSVQ@dread.disaster.area>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 02, 2023 at 04:34:58PM +1000, Dave Chinner wrote:
> IOWs, not only was the ext4 functionality was poorly thought out, it
> was *poorly implemented*.

Shrug.  It's 100% compatible with "tune2fs -U <uuid>" which existed
prior to sb->s_uuid and /proc/XXX/mountstats, and which has allowed
on-line, mounted changes of the UUID.  So as far as I'm concerned,
it's "working as intended".  It fixed a real bug where racing
resize2fs and tune2fs -U in separate systemd unit files could result
in superblock checksum failures, and it fixed the that issue.

It doesn't make any changes to how on-line "tune2fs -U <uuid>"
functioned, because the definition of s_uuid wasn't terribly well
defined (and "tune2fs -U" predates it in any case).  Originally s_uuid
was just to allow /proc/XXX/mountstats expose the UUID, but at this
point, I don't anyone has a complete understanding of other
assumptions of how overlayfs, IMA, and other userspace utilities have
in terms of the assumption of how file system UUID should be used and
what it denotes.

> However, we have a golden image that every client image is cloned
> from. Say we set a special feature bit in that golden image that
> means "need UUID regeneration". Then on the first mount of the
> cloned image after provisioning, the filesystem sees the bit and
> automatically regenerates the UUID with needing any help from
> userspace at all.

> Problem solved, yes? We don't need userspace to change the uuid on
> first boot of the newly provisioned VM - the filesystem just makes
> it happen.

I agree that's a good design --- and ten years now, from all of the
users using old versions of RHEL have finally migrated off to a
version of some enterprise linux that supports this new feature, the
cloud agents which are using "tune2fs -U <uuid>" or "xfs_admin -U
<uuid>" can stop relying on it and switching to this new scheme.

What we could do is to make it easy to determine whether the kernel
supports the "UUID regeneration" feature, and whether the file system
had its UUID regnerated (because some cloud images generated using an
older distro's installer won't request the UUID renegeration), so that
cloud agents (which are typically installed as a daemon that starts
out of an init.d or systemd unit file) will know whether or not they
need to fallback to the userspace UUID regeneration.

For cloud agents which are installed as a one-shop executable run out
of the initramfs, we might be able to change the UUID before the root
file system is mounted.  Of course, there are those userspace setups
where the use of an initramfs is optional or not used at all.

So for the short-term, we're going to be stuck with userspace mediated
UUID changes, and if there are going to be userspace or kernel
subsystems that are going to be surprised when UUID changes out from
under them.  So having some kind of documentation which describes how
various subsystems are using the file system UUID, and whether they
are getting it from sb->s_uuid, /proc/XXX/mountstats, or some other
source, that would probably be useful.  After all, system
administrators' access to "tune2fs -U" and "xfs_admin -U" isn't going
away, and if we're saying "it's up to them to understand the
implications", it's nice if we document the gotchas.   :-)

	       	    	       		    - Ted
