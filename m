Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D94522EDB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 10:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237841AbiEKI65 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 04:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233944AbiEKI6v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 04:58:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8EA0212FC2D
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 01:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652259528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+Zc2Huyl9u354IxnbxBuQkxC8HSnVrj0E9v/FWkHr5U=;
        b=KIimfw/atWY4mPM9dFhwD6RVpn5A+BWgjkWjjLL49OemNlEeBrehpNmtbJNNM6inlDalqB
        qclAIs7IW32JFitCCZ6WOcabXM+9L6yKliwgPWpgsxN4n84CQfiLshhagJpu/WkhCh1xQo
        esT77h3eE6FwmKMnh2Uvgls7xN6PWmA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-494-koZ8mR_ePsmDMcgIYEqBfg-1; Wed, 11 May 2022 04:58:43 -0400
X-MC-Unique: koZ8mR_ePsmDMcgIYEqBfg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AFE50185A7B2;
        Wed, 11 May 2022 08:58:42 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 117071121314;
        Wed, 11 May 2022 08:58:39 +0000 (UTC)
Date:   Wed, 11 May 2022 10:58:37 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
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
Message-ID: <20220511085837.xkxo5c5fevtgaekz@ws.net.home>
References: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com>
 <20220509124815.vb7d2xj5idhb2wq6@wittgenstein>
 <20220510123512.h6jjqgowex6gnjh5@ws.net.home>
 <20220510232552.GD2306852@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510232552.GD2306852@dread.disaster.area>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 11, 2022 at 09:25:52AM +1000, Dave Chinner wrote:
> > I'd love something like:
> > 
> > ssize_t sz;
> > fsinfo_query query[] = {
> >     { .request = FSINFO_MOUNT_PATH },
> >     { .request = FSINFO_PROPAGATION },
> >     { .request = FSINFO_CHILDREN_IDS },
> > };
> > 
> > sz = fsinfo(dfd, "", AT_EMPTY_PATH,
> >                 &query, ARRAY_SIZE(query),
> >                 buf, sizeof(buf));
> > 
> > for (p = buf; p < buf + sz; ) {
> > {
> >     fsinfo_entry *e = (struct fsinfo_entry) p;
> >     char *data = p + sizeof(struct fsinfo_entry);
> > 
> >     switch(e->request) {
> >     case FSINFO_MOUNT_PATH:
> >         printf("mountpoint %s\n", data);
> >         break;
> >     case FSINFO_PROPAGATION:
> >         printf("propagation %x\n", (uintptr_t) data);
> >         break;
> >     case FSINFO_CHILDREN_IDS:
> >         fsinfo_child *x = (fsinfo_child *) data;
> >         for (i = 0; i < e->count; i++) {
> >             printf("child: %d\n", x[i].mnt_id);
> >         }
> >         break;
> >     ...
> >     }
> > 
> >     p += sizeof(struct fsinfo_entry) + e->len;
> > }
> 
> That's pretty much what a multi-xattr get operation looks like.
> It's a bit more more intricate in the setup of the request/return
> buffer, but otherwise the structure of the code is the same.
> 
> I just don't see why we need special purpose interfaces like this
> for key/value information when small tweaks to the existing
> generic key/value interfaces can provide exactly the same
> functionality....

I don't say we need a new interface ;-) I'd be happy with whatever as
long as:

  * minimal strings parsing (wish than a requirement)
  * one syscall returns multiple key/value
  * can address mount table entries by ID
  * can ask for list of children (submounts)
  * extensible

if this will be possible with xattr (listxattr2(), or so) when great.

  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

