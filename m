Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11693753A33
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jul 2023 13:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235667AbjGNLxA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jul 2023 07:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235689AbjGNLwz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jul 2023 07:52:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66410136;
        Fri, 14 Jul 2023 04:52:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 01A3B2215C;
        Fri, 14 Jul 2023 11:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689335573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8KDV1nJ5Jz4wRDhIKmz6NBTzJCSWRm0jEnj5bKK8jms=;
        b=RaI2ovdDvUPrEZfWKhoWhNZo8wczuah4soS9qZNmjNs4m77GOOhIkliWi0AW6JeIY2bpTl
        sS1XdU5o65Y83yhWiMvQHDPuT8pXn8OAcj/xhWpT2sCettpHZpXHdcAwUxw32zO95FET5+
        a7afrjnmliXMK10v/s4xRw7EosrSLdQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689335573;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8KDV1nJ5Jz4wRDhIKmz6NBTzJCSWRm0jEnj5bKK8jms=;
        b=Xwjlf4wtU20I149ib7jAHqHYtFJHRAEQ7KLGUG/IqQ27Glob67oL5W1MoWY3aYVfy9nRQk
        tVWwL8O32q1ldDBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DBF04138F8;
        Fri, 14 Jul 2023 11:52:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vwKmNRQ3sWT7PwAAMHmgww
        (envelope-from <chrubis@suse.cz>); Fri, 14 Jul 2023 11:52:52 +0000
Date:   Fri, 14 Jul 2023 13:53:58 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Jan Stancek <jstancek@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>, cluster-devel@redhat.com,
        Ilya Dryomov <idryomov@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Chao Yu <chao@kernel.org>, oe-lkp@lists.linux.dev,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Xiubo Li <xiubli@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        ltp@lists.linux.it, lkp@intel.com, Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <brauner@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>,
        Anna Schumaker <anna@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [LTP] [linus:master] [iomap] 219580eea1: ltp.writev07.fail
Message-ID: <ZLE3Vh5yHq_floF7@yuki>
References: <202307132107.2ce4ea2f-oliver.sang@intel.com>
 <20230713150923.GA28246@lst.de>
 <ZLAZn_SBmoIFG5F5@yuki>
 <CAASaF6xbgSf+X+SF8wLjFrsMA4=XxHti0SXDZQP1ZqdGYp4aUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAASaF6xbgSf+X+SF8wLjFrsMA4=XxHti0SXDZQP1ZqdGYp4aUQ@mail.gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!
> > > I can't reproduce this on current mainline.  Is this a robust failure
> > > or flapping test?  Especiall as the FAIL conditions look rather
> > > unrelated.
> 
> It's consistently reproducible for me on xfs with HEAD at:
> eb26cbb1a754 ("Merge tag 'platform-drivers-x86-v6.5-2' of
> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86")

Should be fixed by https://lore.kernel.org/linux-fsdevel/20230714085124.548920-1-hch@lst.de/T/#t

-- 
Cyril Hrubis
chrubis@suse.cz
