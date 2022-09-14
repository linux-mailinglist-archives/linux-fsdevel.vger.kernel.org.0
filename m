Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F715B908E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Sep 2022 00:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiINWpl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Sep 2022 18:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiINWpg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Sep 2022 18:45:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B6D422CC;
        Wed, 14 Sep 2022 15:45:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3BA5033D6B;
        Wed, 14 Sep 2022 22:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663195532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WrYI2akpyFGc973gFDZLeSpSTKSsio96AxzmoFqBEZc=;
        b=O4JEJvUSBG/iz0aqWIc3jFihEuQnr5iNTcRbnWIfrOZ2B7JD+59PwdOnrKWR3y0adHORkD
        +xPfhuJYotoG8E+PP1gDgPKDRFYBARV3myr4Kkj/GPoJFnxTmLSgAc5Edq6268ChL1I6GN
        yA399nNlO1Gh118LF2tGqQW0A2AoY/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663195532;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WrYI2akpyFGc973gFDZLeSpSTKSsio96AxzmoFqBEZc=;
        b=R8LAajefsyTNx6If59Zi3oC+dC8ttmgAtr+3Cz+rfzpWzFyHg90I8T8jhfP/QBj5D46wP+
        ltJnBA1wSEEi12Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 27DF613494;
        Wed, 14 Sep 2022 22:45:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xOSiNIRZImOSTQAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 14 Sep 2022 22:45:24 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
In-reply-to: <f8a41b55efd1c59bc63950e8c1b734626d970a90.camel@kernel.org>
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
 <f8a41b55efd1c59bc63950e8c1b734626d970a90.camel@kernel.org>
Date:   Thu, 15 Sep 2022 08:45:21 +1000
Message-id: <166319552167.15759.17894784385240679495@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 14 Sep 2022, Jeff Layton wrote:
> On Wed, 2022-09-14 at 09:24 +1000, NeilBrown wrote:
> > On Wed, 14 Sep 2022, Jeff Layton wrote:
> > > 
> > > At that point, bumping i_version both before and after makes a bit more
> > > sense, since it better ensures that a change will be noticed, whether
> > > the related read op comes before or after the statx.
> > 
> > How does bumping it before make any sense at all?  Maybe it wouldn't
> > hurt much, but how does it help anyone at all?
> > 
> 
> My assumption (maybe wrong) was that timestamp updates were done before
> the actual write by design. Does doing it before the write make increase
> the chances that the inode metadata writeout will get done in the same
> physical I/O as the data write? IDK, just speculating here.

When the code was written, the inode semaphore (before mutexes) was held
over the whole thing, and timestamp resolution was 1 second.  So
ordering didn't really matter.  Since then locking has bee reduced and
precision increased but no-one saw any need to fix the ordering.  I
think that is fine for timestamps.

But i_version is about absolute precision, so we need to think carefully
about what meets our needs.

> 
> If there's no benefit to doing it before then we should just move it
> afterward.

Great!
Thanks,
NeilBrown
