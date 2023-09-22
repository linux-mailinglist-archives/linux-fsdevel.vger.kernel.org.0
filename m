Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C176C7AAD7D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 11:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbjIVJJq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 05:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbjIVJJn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:09:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D9D99
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Sep 2023 02:09:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 740BA1F38A;
        Fri, 22 Sep 2023 09:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695373775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=onGdSnf1TabhST/nVQOzguCOB3OwnFwkbl9U7FML82U=;
        b=QQWghVX07yAEd/c8giGyj2aEmDo+G/Nrdhdvi5pyuL7lXrmlUdxjDG2Lguao/8N4tv7zTv
        yT/FmpboyILjqAavxFaxW8CtXIK/u7q4ZdR7Tl62C+YLNK6ZYq4er0Sde/5aJIVtY6gE1w
        5tg8jI1RtR0CJBHZFeCx/zsQ47rjhWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695373775;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=onGdSnf1TabhST/nVQOzguCOB3OwnFwkbl9U7FML82U=;
        b=ohri14qvNI6wH0btb6pqb/u4FXiGUIfOjHLYfJdc9tzLbQZgtJnDLd3Hty0RfgP8qoO1Ja
        bDifj/b95uzQaqDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5D23D13478;
        Fri, 22 Sep 2023 09:09:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tEqNFc9ZDWWgUgAAMHmgww
        (envelope-from <chrubis@suse.cz>); Fri, 22 Sep 2023 09:09:35 +0000
Date:   Fri, 22 Sep 2023 11:10:20 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Reuben Hawkins <reubenhwk@gmail.com>
Cc:     Amir Goldstein <amir73il@gmail.com>, mszeredi@redhat.com,
        brauner@kernel.org, lkp@intel.com, willy@infradead.org,
        linux-fsdevel@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>,
        viro@zeniv.linux.org.uk, oe-lkp@lists.linux.dev, ltp@lists.linux.it
Subject: Re: [LTP] [PATCH] vfs: fix readahead(2) on block devices
Message-ID: <ZQ1Z_JHMPE3hrzv5@yuki>
References: <20230909043806.3539-1-reubenhwk@gmail.com>
 <202309191018.68ec87d7-oliver.sang@intel.com>
 <CAOQ4uxhc8q=GAuL9OPRVOr=mARDL3TExPY0Zipij1geVKknkkQ@mail.gmail.com>
 <CAD_8n+TpZF2GoE1HUeBLs0vmpSna0yR9b+hsd-VC1ZurTe41LQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD_8n+TpZF2GoE1HUeBLs0vmpSna0yR9b+hsd-VC1ZurTe41LQ@mail.gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!
> ack.  Will try to test.  My Ubuntu 22.04 system wasn't able to find
> packages called
> for by the test case, so it'll take me a little while to figure out how to
> get the
> test case working...

Huh? The test is a simple C binary you shouldn't need anything more
than:

$ git clone https://github.com/linux-test-project/ltp.git
$ cd ltp
$ make autotools
$ ./configure

$ cd testcases/kernel/syscalls/readahead
$ make
$ ./readahead01

And this is well described in the readme at:

https://github.com/linux-test-project/ltp/

And the packages required for the compilation are make, C compiler and
autotools nothing extraordinary.

-- 
Cyril Hrubis
chrubis@suse.cz
