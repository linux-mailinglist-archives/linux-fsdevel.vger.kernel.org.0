Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2565EB4B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 00:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiIZWoM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 18:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiIZWoJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 18:44:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A2D9E2E5;
        Mon, 26 Sep 2022 15:44:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C24DA2199A;
        Mon, 26 Sep 2022 22:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1664232246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3wqBvT1Pdp5nBIwk7f69QChWKcic6sFvlcDIXYHLhVw=;
        b=bp3sjpaKgKxakHrVYbA6MiKdHvmDJOaK7Knl9ZekzxVGGvefEZtlBRay9JdXNdvtsI1FeT
        BFiGJDTn7+nBrNUAcYcwtC/v/cFeQlQAXMryESS37gkkS89krmeCqqd4ZQnBlnku1Qj9nT
        bHo5wmUgv+yvxmGT2ireKVPFG/FEpiA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1664232246;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3wqBvT1Pdp5nBIwk7f69QChWKcic6sFvlcDIXYHLhVw=;
        b=KNEYqmH80A7uU4gjB/CKhQ0gmEKPEUyR2v8DIyep3Ttnd3fg3CE5jdzAdX4shiTSaiECHR
        w+8QIdUkTfKWlFCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B2E7213486;
        Mon, 26 Sep 2022 22:43:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oE9qGi8rMmOyQwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 26 Sep 2022 22:43:59 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     "Trond Myklebust" <trondmy@hammerspace.com>,
        "jack@suse.cz" <jack@suse.cz>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "lczerner@redhat.com" <lczerner@redhat.com>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
In-reply-to: <baf852dfb57aaf5a670bc88236f8d62c99668fcc.camel@kernel.org>
References: <24005713ad25370d64ab5bd0db0b2e4fcb902c1c.camel@kernel.org>,
 <20220918235344.GH3600936@dread.disaster.area>,
 <87fb43b117472c0a4c688c37a925ac51738c8826.camel@kernel.org>,
 <20220920001645.GN3600936@dread.disaster.area>,
 <5832424c328ea427b5c6ecdaa6dd53f3b99c20a0.camel@kernel.org>,
 <20220921000032.GR3600936@dread.disaster.area>,
 <93b6d9f7cf997245bb68409eeb195f9400e55cd0.camel@kernel.org>,
 <20220921214124.GS3600936@dread.disaster.area>,
 <e04e349170bc227b330556556d0592a53692b5b5.camel@kernel.org>,
 <1ef261e3ff1fa7fcd0d75ed755931aacb8062de2.camel@kernel.org>,
 <20220923095653.5c63i2jgv52j3zqp@quack3>,
 <2d41c08e1fd96d55c794c3b4cd43a51a0494bfcf.camel@hammerspace.com>,
 <baf852dfb57aaf5a670bc88236f8d62c99668fcc.camel@kernel.org>
Date:   Tue, 27 Sep 2022 08:43:56 +1000
Message-id: <166423223623.17572.7229091435446226718@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 23 Sep 2022, Jeff Layton wrote:
> 
> Absolutely. That is the downside of this approach, but the priority here
> has always been to improve nfsd. If we don't get the ability to present
> this info via statx, then so be it. Later on, I suppose we can move that
> handling into the kernel in some fashion if we decide it's worthwhile.
> 
> That said, not having this in statx makes it more difficult to test
> i_version behavior. Maybe we can add a generic ioctl for that in the
> interim?

I wonder if we are over-thinking this, trying too hard, making "perfect"
the enemy of "good".
While we agree that the current implementation of i_version is
imperfect, it isn't causing major data corruption all around the world.
I don't think there are even any known bug reports are there?
So while we do want to fix it as best we can, we don't need to make that
the first priority.

I think the first priority should be to document how we want it to work,
which is what this thread is really all about.  The documentation can
note that some (all) filesystems do not provide perfect semantics across
unclean restarts, and can list any other anomalies that we are aware of.
And on that basis we can export the current i_version to user-space via
statx and start trying to write some test code.

We can then look at moving the i_version/ctime update from *before* the
write to *after* the write, and any other improvements that can be
achieved easily in common code.  We can then update the man page to say
"since Linux 6.42, this list of anomalies is no longer present".

Then we can explore some options for handling unclean restart - in a
context where we can write tests and maybe even demonstrate a concrete
problem before we start trying to fix it.

NeilBrown
