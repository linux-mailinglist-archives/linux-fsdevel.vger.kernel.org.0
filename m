Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905845B7D7F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Sep 2022 01:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiIMXYT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Sep 2022 19:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiIMXYR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Sep 2022 19:24:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9778227DE6;
        Tue, 13 Sep 2022 16:24:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 111195C81A;
        Tue, 13 Sep 2022 23:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663111455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lCZbTt8MqzDxXBhNECVaeYq92wrfjuXQyXb1QCL9L08=;
        b=xlbgGCcX1vaqfVo0T7/7HHkGJClHbYwVmCkEjYU+yukwvWlmi/KV4I9oCfaEa4wMX0rAE+
        SEsmeldoOIOeCxP5qYRC+CdkHQdKTtaC4+4AbfA5fyhqvZZp3SIKD2vcprwsRNYTCxFz9M
        JLUB3aTflnqVKCKYq+IrL7uyVXYqhBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663111455;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lCZbTt8MqzDxXBhNECVaeYq92wrfjuXQyXb1QCL9L08=;
        b=f3V4jz9cjD4/+YabArl2nlr3TvCKBf+HRA2DIYhIcYM7hGDyhFP9+9JyddEfjRtGauQ9MS
        eeY+o8dgRHryQzBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A5AC313AB5;
        Tue, 13 Sep 2022 23:24:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DEmgFxYRIWMlZgAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 13 Sep 2022 23:24:06 +0000
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
In-reply-to: <b67fe8b26977dc1213deb5ec815a53a26d31fbc0.camel@kernel.org>
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
 <b67fe8b26977dc1213deb5ec815a53a26d31fbc0.camel@kernel.org>
Date:   Wed, 14 Sep 2022 09:24:02 +1000
Message-id: <166311144203.20483.1888757883086697314@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 14 Sep 2022, Jeff Layton wrote:
>
> At that point, bumping i_version both before and after makes a bit more
> sense, since it better ensures that a change will be noticed, whether
> the related read op comes before or after the statx.

How does bumping it before make any sense at all?  Maybe it wouldn't
hurt much, but how does it help anyone at all?

  i_version must appear to change no sooner than the change it reflects
  becomes visible and no later than the request which initiated that
  change is acknowledged as complete.

Why would that definition ever not be satisfactory?

NeilBrown
