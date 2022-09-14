Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A238D5B90B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Sep 2022 01:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiINXDI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Sep 2022 19:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiINXDH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Sep 2022 19:03:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7FC86C0D;
        Wed, 14 Sep 2022 16:03:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4809E2254E;
        Wed, 14 Sep 2022 23:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663196585; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Der/yD5DoRhA+UaDEdoBo0c+TBGXF1b1eQeHUJoVn24=;
        b=vUOyhbIqIdhUfwjGMcVp0bFWqzSxjg18Byf0Fw6V5BWUlJXfduvZU8AsGTsDkTCUQVX1DI
        3ee//m67w0d3/IaK9foaigRlwNhudHM73ukohor5+efg5TY3is7z+cqHRkrfRs95WC7ga4
        cSOwko1/rNviD4ShdiPw7JiSg1R8Z00=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663196585;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Der/yD5DoRhA+UaDEdoBo0c+TBGXF1b1eQeHUJoVn24=;
        b=EUm8SOBHxcTunrnYlf/7AJ8WMe7OgCxbHb23+u0pbKckxSbiSnW5PX762kvLVY0BH2prcl
        iOFuzg7VO/j6ODDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4E124134B3;
        Wed, 14 Sep 2022 23:02:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ssTxAKFdImMOUgAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 14 Sep 2022 23:02:57 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     "Dave Chinner" <david@fromorbit.com>,
        "Trond Myklebust" <trondmy@hammerspace.com>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jack@suse.cz" <jack@suse.cz>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "lczerner@redhat.com" <lczerner@redhat.com>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
In-reply-to: <166319552167.15759.17894784385240679495@noble.neil.brown.name>
References: <91e31d20d66d6f47fe12c80c34b1cffdfc202b6a.camel@hammerspace.com>,
 <166268467103.30452.1687952324107257676@noble.neil.brown.name>,
 <166268566751.30452.13562507405746100242@noble.neil.brown.name>,
 <29a6c2e78284e7947ddedf71e5cb9436c9330910.camel@hammerspace.com>,
 <8d638cb3c63b0d2da8679b5288d1622fdb387f83.camel@hammerspace.com>,
 <166270570118.30452.16939807179630112340@noble.neil.brown.name>,
 <33d058be862ccc0ccaf959f2841a7e506e51fd1f.camel@kernel.org>,
 <166285038617.30452.11636397081493278357@noble.neil.brown.name>,
 <2e34a7d4e1a3474d80ee0402ed3bc0f18792443a.camel@kernel.org>,
 <166302538820.30452.7783524836504548113@noble.neil.brown.name>,
 <20220913011518.GE3600936@dread.disaster.area>,
 <b67fe8b26977dc1213deb5ec815a53a26d31fbc0.camel@kernel.org>,
 <166311144203.20483.1888757883086697314@noble.neil.brown.name>,
 <f8a41b55efd1c59bc63950e8c1b734626d970a90.camel@kernel.org>,
 <166319552167.15759.17894784385240679495@noble.neil.brown.name>
Date:   Thu, 15 Sep 2022 09:02:53 +1000
Message-id: <166319657348.15759.14602484394176375178@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 15 Sep 2022, NeilBrown wrote:
>=20
> When the code was written, the inode semaphore (before mutexes) was held
> over the whole thing, and timestamp resolution was 1 second.  So
> ordering didn't really matter.  Since then locking has bee reduced and
> precision increased but no-one saw any need to fix the ordering.  I
> think that is fine for timestamps.

Actually it is much more complex than that, though the principle is
still the same

https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/commit/?i=
d=3D636b38438001a00b25f23e38747a91cb8428af29

shows i_mtime updates being moved from *after* a call to
generic_file_write() in each filesystem to *early* in the body of
generic_file_write().  Probably because that was just a convenient place
to put it.

NeilBrown

