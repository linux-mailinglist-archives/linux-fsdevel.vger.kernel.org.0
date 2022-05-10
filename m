Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FB0521588
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 May 2022 14:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241447AbiEJMjW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 08:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241050AbiEJMjV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 08:39:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7C2B2AA2D0
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 May 2022 05:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652186122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KAQGt/RronM2MwKu2wT61Gar8OOVM6I6Ip3NAsTYhRo=;
        b=E0J6XMFQEObfdm7tbLVsEWV2bkGrhA+CRQcZ7k7QOQ8A75tsXvwu5PWp1LvWH4KnOvheMw
        aTppLTLbA4nAX1DgYaOu/vrWC+SpZiNKRUW4mnv2FlkVKwrhQ61VHAe7ZgmjaZ6gw0e2Iw
        gwMe7Cv/tBQa6coDuQJ7VVSL4+yvQCU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-g2GRWnOBOiO81XZFgG9qpA-1; Tue, 10 May 2022 08:35:17 -0400
X-MC-Unique: g2GRWnOBOiO81XZFgG9qpA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2139E803D45;
        Tue, 10 May 2022 12:35:17 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 89779400E115;
        Tue, 10 May 2022 12:35:14 +0000 (UTC)
Date:   Tue, 10 May 2022 14:35:12 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Theodore Ts'o <tytso@mit.edu>,
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
Message-ID: <20220510123512.h6jjqgowex6gnjh5@ws.net.home>
References: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com>
 <20220509124815.vb7d2xj5idhb2wq6@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509124815.vb7d2xj5idhb2wq6@wittgenstein>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 09, 2022 at 02:48:15PM +0200, Christian Brauner wrote:
> One comment about this. We really need to have this interface support
> giving us mount options like "relatime" back in numeric form (I assume
> this will be possible.). It is royally annoying having to maintain a
> mapping table in userspace just to do:
> 
> relatime -> MS_RELATIME/MOUNT_ATTR_RELATIME
> ro	 -> MS_RDONLY/MOUNT_ATTR_RDONLY
> 
> A library shouldn't be required to use this interface. Conservative
> low-level software that keeps its shared library dependencies minimal
> will need to be able to use that interface without having to go to an
> external library that transforms text-based output to binary form (Which
> I'm very sure will need to happen if we go with a text-based
> interface.).

Sounds like David's fsinfo() :-)

We need an interface where the kernel returns a consistent mount table    
entry (more syscalls to get more key=value could be a way how to get
inconsistent data).                                              

IMHO all the attempts to make a trivial interface will be unsuccessful
because the mount table is complex (tree) and mixes strings, paths,
and flags. We will always end with a complex interface or complex
strings (like the last xatts attempt). There is no 3rd path to go ...

The best would be simplified fsinfo() where userspace defines
a request (wanted "keys"), and the kernel fills a buffer with data
separated by some header metadata struct. In this case, the kernel can
return strings and structs with binary data.  


I'd love something like:

ssize_t sz;
fsinfo_query query[] = {
    { .request = FSINFO_MOUNT_PATH },
    { .request = FSINFO_PROPAGATION },
    { .request = FSINFO_CHILDREN_IDS },
};

sz = fsinfo(dfd, "", AT_EMPTY_PATH,
                &query, ARRAY_SIZE(query),
                buf, sizeof(buf));

for (p = buf; p < buf + sz; ) {
{
    fsinfo_entry *e = (struct fsinfo_entry) p;
    char *data = p + sizeof(struct fsinfo_entry);

    switch(e->request) {
    case FSINFO_MOUNT_PATH:
        printf("mountpoint %s\n", data);
        break;
    case FSINFO_PROPAGATION:
        printf("propagation %x\n", (uintptr_t) data);
        break;
    case FSINFO_CHILDREN_IDS:
        fsinfo_child *x = (fsinfo_child *) data;
        for (i = 0; i < e->count; i++) {
            printf("child: %d\n", x[i].mnt_id);
        }
        break;
    ...
    }

    p += sizeof(struct fsinfo_entry) + e->len;
}



... my two cents :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

