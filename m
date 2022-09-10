Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B975B4A76
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Sep 2022 00:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiIJWN3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Sep 2022 18:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiIJWN2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Sep 2022 18:13:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5EB65E3;
        Sat, 10 Sep 2022 15:13:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ACF6C1F931;
        Sat, 10 Sep 2022 22:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662848002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p/t9XoKe6JDgLqefB7W9+evIBh18o9QxoMvh7Ovrcl0=;
        b=xKNunlCPh3CvPxBa/rNxPqx+bIQ6e9eE3nSuqzMEmSJ3SJNjsk81Q91RHQ9MtJdCzP1hhJ
        xgP8hc4f9hCj8J2vTeN7yq8lNdKrB3umeqrSFH58T1fe9Imo4RZxgw2EDVG0V6GyLXfjST
        UV/Jh2R5aE5X2P3XXyASbKJSaegDi9Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662848002;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p/t9XoKe6JDgLqefB7W9+evIBh18o9QxoMvh7Ovrcl0=;
        b=/Iyu3yh6+xqg3JiqhL+2mgJ8SAgB3gxb5Y8E/FhgXDN/MyKwhRcLMnzY28GHlUgViTcfEI
        qoutkVt9kNxdSwBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8D26913441;
        Sat, 10 Sep 2022 22:13:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MdalEfsLHWMkPAAAMHmgww
        (envelope-from <neilb@suse.de>); Sat, 10 Sep 2022 22:13:15 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        "Theodore Ts'o" <tytso@mit.edu>, "Jan Kara" <jack@suse.cz>,
        adilger.kernel@dilger.ca, djwong@kernel.org, david@fromorbit.com,
        trondmy@hammerspace.com, viro@zeniv.linux.org.uk,
        zohar@linux.ibm.com, xiubli@redhat.com, chuck.lever@oracle.com,
        lczerner@redhat.com, brauner@kernel.org, fweimer@redhat.com,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
In-reply-to: <44efe219dbf511492b21a653905448d43d0f3363.camel@kernel.org>
References: <79aaf122743a295ddab9525d9847ac767a3942aa.camel@kernel.org>,
 <20220907125211.GB17729@fieldses.org>,
 <771650a814ab1ff4dc5473d679936b747d9b6cf5.camel@kernel.org>,
 <20220907135153.qvgibskeuz427abw@quack3>,
 <166259786233.30452.5417306132987966849@noble.neil.brown.name>,
 <20220908083326.3xsanzk7hy3ff4qs@quack3>, <YxoIjV50xXKiLdL9@mit.edu>,
 <02928a8c5718590bea5739b13d6b6ebe66cac577.camel@kernel.org>,
 <20220908155605.GD8951@fieldses.org>,
 <9e06c506fd6b3e3118da0ec24276e85ea3ee45a1.camel@kernel.org>,
 <20220908182252.GA18939@fieldses.org>,
 <44efe219dbf511492b21a653905448d43d0f3363.camel@kernel.org>
Date:   Sun, 11 Sep 2022 08:13:11 +1000
Message-id: <166284799157.30452.4308111193560234334@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 09 Sep 2022, Jeff Layton wrote:
> 
> The machine crashes and comes back up, and we get a query for i_version
> and it comes back as X. Fine, it's an old version. Now there is a write.
> What do we do to ensure that the new value doesn't collide with X+1? 

(I missed this bit in my earlier reply..)

How is it "Fine" to see an old version?
The file could have changed without the version changing.
And I thought one of the goals of the crash-count was to be able to
provide a monotonic change id.

NeilBrown
