Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A3C4E6F96
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Mar 2022 09:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355909AbiCYIsa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Mar 2022 04:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355891AbiCYIs3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Mar 2022 04:48:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A4BACD313
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Mar 2022 01:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648198015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3LAcZ86phd5KooVZZ6Y1mPcr9GXiECGS2GkKBYOKDWE=;
        b=hI/u9nIO4HBIeCDlozChnTs72LZu/wEuDTr+zExr0aycNc1E4nYHsHjy9iP0tG6K3r9Ykz
        +fax6r6U4jo1Q5MQELiwDfXUXLTgH1Dv3Cn/6EYhYdesSbv3JAI84IQg4jBPUyJwCqfsUA
        Z6pBhlsAw5uQhplniYcfkQZt4Ov7i04=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-159-Obdy5gfrMnOVvgfhwSjOuA-1; Fri, 25 Mar 2022 04:46:52 -0400
X-MC-Unique: Obdy5gfrMnOVvgfhwSjOuA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5519A1C05151;
        Fri, 25 Mar 2022 08:46:51 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E23D4432703;
        Fri, 25 Mar 2022 08:46:48 +0000 (UTC)
Date:   Fri, 25 Mar 2022 09:46:46 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Theodore Ts'o <tytso@mit.edu>,
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
Message-ID: <20220325084646.7g6oto2ce3vou54x@ws.net.home>
References: <20220322192712.709170-1-mszeredi@redhat.com>
 <20220323114215.pfrxy2b6vsvqig6a@wittgenstein>
 <CAJfpegsCKEx41KA1S2QJ9gX9BEBG4_d8igA0DT66GFH2ZanspA@mail.gmail.com>
 <YjudB7XARLlRtBiR@mit.edu>
 <CAJfpegtiRx6jRFUuPeXDxwJpBhYn0ekKkwYbGowUehGZkqVmAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtiRx6jRFUuPeXDxwJpBhYn0ekKkwYbGowUehGZkqVmAw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 24, 2022 at 09:44:38AM +0100, Miklos Szeredi wrote:
> > If so, have you benchmarked lsof using this new interface?
> 
> Not yet.  Looked yesterday at both lsof and procps source code, and
> both are pretty complex and not easy to plug in a new interface.   But
> I've not yet given up...

I can imagine something like getvalues(2) in lsblk (based on /sys) or
in lsfd (based on /proc; lsof replacement). The tools have defined set
of information to read from kernel, so gather all the requests to the
one syscall for each process or block device makes sense and it will
dramatically reduce number of open+read+close syscalls.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

