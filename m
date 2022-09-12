Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152185B5A04
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 14:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiILMNZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 08:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiILMNX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 08:13:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDF333A11
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Sep 2022 05:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662984799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mrkO2o7NLCcYAn3dzHQJOYSP8ki543AiPRGrSsHduoY=;
        b=f9CFJ9rM5L1sVAR7E7B2GwUS7CdZbdVEV77x0e2k5bpZ4JKbpgKD1WZev7kjOio1Kgkzv9
        zeh59zENqhuYiGY+CveljzEjIyQqpnC9hKqWrNEbuEN0h7KUEr4BS5VQaxidJ/B5X9sLZi
        SKm21bxa50o+IHb54nmHId2UseRiqps=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-146-fPG4ltTxOjK_xKdfMFGHXQ-1; Mon, 12 Sep 2022 08:13:13 -0400
X-MC-Unique: fPG4ltTxOjK_xKdfMFGHXQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8D7F43C0D848;
        Mon, 12 Sep 2022 12:13:12 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.193.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 21BFE2166B26;
        Mon, 12 Sep 2022 12:13:06 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        NeilBrown <neilb@suse.de>, adilger.kernel@dilger.ca,
        djwong@kernel.org, david@fromorbit.com, trondmy@hammerspace.com,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, brauner@kernel.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
References: <166259786233.30452.5417306132987966849@noble.neil.brown.name>
        <20220908083326.3xsanzk7hy3ff4qs@quack3> <YxoIjV50xXKiLdL9@mit.edu>
        <02928a8c5718590bea5739b13d6b6ebe66cac577.camel@kernel.org>
        <20220908155605.GD8951@fieldses.org>
        <9e06c506fd6b3e3118da0ec24276e85ea3ee45a1.camel@kernel.org>
        <20220908182252.GA18939@fieldses.org>
        <44efe219dbf511492b21a653905448d43d0f3363.camel@kernel.org>
        <20220909154506.GB5674@fieldses.org>
        <125df688dbebaf06478b0911e76e228e910b04b3.camel@kernel.org>
        <20220910145600.GA347@fieldses.org>
        <9eaed9a47d1aef11fee95f0079e302bc776bc7ff.camel@kernel.org>
Date:   Mon, 12 Sep 2022 14:13:05 +0200
In-Reply-To: <9eaed9a47d1aef11fee95f0079e302bc776bc7ff.camel@kernel.org> (Jeff
        Layton's message of "Mon, 12 Sep 2022 07:42:16 -0400")
Message-ID: <87a67423la.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Jeff Layton:

> To do this we'd need 2 64-bit fields in the on-disk and in-memory 
> superblocks for ext4, xfs and btrfs. On the first mount after a crash,
> the filesystem would need to bump s_version_max by the significant
> increment (2^40 bits or whatever). On a "clean" mount, it wouldn't need
> to do that.
>
> Would there be a way to ensure that the new s_version_max value has made
> it to disk? Bumping it by a large value and hoping for the best might be
> ok for most cases, but there are always outliers, so it might be
> worthwhile to make an i_version increment wait on that if necessary. 

How common are unclean shutdowns in practice?  Do ex64/XFS/btrfs keep
counters in the superblocks for journal replays that can be read easily?

Several useful i_version applications could be negatively impacted by
frequent i_version invalidation.

Thanks,
Florian

