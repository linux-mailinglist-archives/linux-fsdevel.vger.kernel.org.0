Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248DE5215C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 May 2022 14:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241981AbiEJMtv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 08:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241967AbiEJMtt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 08:49:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 453B22D1E1
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 May 2022 05:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652186749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OHedlp3XgvvvmR96eUT2A7KFNCgoAcFZOekYnqMAIR0=;
        b=c2xnkJDbCT6xKtGRgrD9Bu1aKzgOCJ+fPTGI9vNPlgGaSyCdYIVmJDKUDZfydmM+m1g5lR
        Ox33fSsaKpnMPW7CLarbtOdk7lux+bvkPcS+DoYCaWoMXiuEjX5OY2y5yKxbvI8URftcjN
        FmnOG+caxnXrSOiVuzl+BvkcF18fFHg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-p3o-IMlRPjOSxJC9pFCAqQ-1; Tue, 10 May 2022 08:45:45 -0400
X-MC-Unique: p3o-IMlRPjOSxJC9pFCAqQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 82FF38002BF;
        Tue, 10 May 2022 12:45:44 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.113])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E3BCC43F70C;
        Tue, 10 May 2022 12:45:40 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Karel Zak <kzak@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
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
Subject: Re: [RFC PATCH] getting misc stats/attributes via xattr API
References: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com>
        <20220509124815.vb7d2xj5idhb2wq6@wittgenstein>
        <20220510005533.GA2306852@dread.disaster.area>
Date:   Tue, 10 May 2022 14:45:39 +0200
In-Reply-To: <20220510005533.GA2306852@dread.disaster.area> (Dave Chinner's
        message of "Tue, 10 May 2022 10:55:33 +1000")
Message-ID: <87bkw5d098.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Dave Chinner:

> IOWs, what Linux really needs is a listxattr2() syscall that works
> the same way that getdents/XFS_IOC_ATTRLIST_BY_HANDLE work. With the
> list function returning value sizes and being able to iterate
> effectively, every problem that listxattr() causes goes away.

getdents has issues of its own because it's unspecified what happens if
the list of entries is modified during iteration.  Few file systems add
another tree just to guarantee stable iteration.

Maybe that's different for xattrs because they are supposed to be small
and can just be snapshotted with a full copy?

Thanks,
Florian

