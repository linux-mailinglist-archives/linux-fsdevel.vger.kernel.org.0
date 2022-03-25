Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C434E6FFB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Mar 2022 10:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356919AbiCYJ1k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Mar 2022 05:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356904AbiCYJ1j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Mar 2022 05:27:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6FC2FCF4B6
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Mar 2022 02:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648200364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ct4y/2vagTEoL5DgWAoLz+jJ6PVTSzZLkKcuQNOy3tk=;
        b=ZI8qUbzyPoYj+qcRQlLBK3GG/1Shxm4Q98+ipE8MwtQSTnOkIyU0vnnNYvXgfsw5CX3IOZ
        Uk9sfMJCMJoFUYZ/32qtnFJJtH46kY/BHPwmPwP87bAWLcHkT5I12CXtLnVEm41NwNlNpn
        o/NhjdznSvT4aYQ1GC9BmZbumMk1aSo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-404-2Br8BHt3OfiW6g1sQx0YHQ-1; Fri, 25 Mar 2022 05:26:01 -0400
X-MC-Unique: 2Br8BHt3OfiW6g1sQx0YHQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 976D41044560;
        Fri, 25 Mar 2022 09:26:00 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A2A12166B2D;
        Fri, 25 Mar 2022 09:25:55 +0000 (UTC)
Date:   Fri, 25 Mar 2022 10:25:53 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, Theodore Ts'o <tytso@mit.edu>,
        Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [RFC PATCH] getvalues(2) prototype
Message-ID: <20220325092553.rncxqrjslv6e4c7v@ws.net.home>
References: <20220322192712.709170-1-mszeredi@redhat.com>
 <20220323114215.pfrxy2b6vsvqig6a@wittgenstein>
 <CAJfpegsCKEx41KA1S2QJ9gX9BEBG4_d8igA0DT66GFH2ZanspA@mail.gmail.com>
 <YjudB7XARLlRtBiR@mit.edu>
 <CAJfpegtiRx6jRFUuPeXDxwJpBhYn0ekKkwYbGowUehGZkqVmAw@mail.gmail.com>
 <20220325084646.7g6oto2ce3vou54x@ws.net.home>
 <Yj2DPRusMAzV/N5U@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yj2DPRusMAzV/N5U@kroah.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 25, 2022 at 09:54:21AM +0100, Greg KH wrote:
> On Fri, Mar 25, 2022 at 09:46:46AM +0100, Karel Zak wrote:
> > On Thu, Mar 24, 2022 at 09:44:38AM +0100, Miklos Szeredi wrote:
> > > > If so, have you benchmarked lsof using this new interface?
> > > 
> > > Not yet.  Looked yesterday at both lsof and procps source code, and
> > > both are pretty complex and not easy to plug in a new interface.   But
> > > I've not yet given up...
> > 
> > I can imagine something like getvalues(2) in lsblk (based on /sys) or
> > in lsfd (based on /proc; lsof replacement). The tools have defined set
> > of information to read from kernel, so gather all the requests to the
> > one syscall for each process or block device makes sense and it will
> > dramatically reduce number of open+read+close syscalls.
> 
> And do those open+read+close syscalls actually show up in measurements?
> 
> Again, I tried to find a real-world application that turning those 3
> into 1 would matter, and I couldn't.  procps had no decreased system
> load that I could notice.  I'll mess with lsof but that's really just a
> stress-test, not anything that is run all the time, right?


Right, the speed of ps(1) or lsof(1) is not important. IMHO the current
discussion about getvalues() goes in wrong direction :-)  

I guess the primary motivation is not to replace open+read+close, but
provide to userspace something usable to get information from mount
table, because the current /proc/#/mountinfo and notification by
poll() is horrible.

Don't forget that the previous attempt was fsinfo() from David Howells
(unfortunately, it was too complex and rejected by Linus).

> And as others have said, using io_uring() would also solve the 3 syscall
> issue, but no one seems to want to convert these tools to use that,
> which implies that it's not really an issue for anyone :)

OK, I'll think about it :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

