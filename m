Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFB25206D4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 23:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiEIVqv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 17:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiEIVqr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 17:46:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2133B1C0F28
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 May 2022 14:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652132571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QL1F9UPYT7jlxdo3Go3SmyooqLgW/z19aEMgC8ZMp+U=;
        b=hNFKwQU8JscAslW2YhICLNX/X6wGJ0h6aOe8Ol2Cat7zb/5ksfUHnHutX0yy4tHGxB5Luy
        z56ADsENXeQiyCWCrlFy5jFyBJGp/J+eLG6vtTMxtgIaNQtok3cm9NFqrHAdhALtNZ1VKp
        Jz9/xJ/V9xR1/HABID74TsBgH3/JgRQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-8-vciVVmlzPqmBLYONgGMbxw-1; Mon, 09 May 2022 17:42:48 -0400
X-MC-Unique: vciVVmlzPqmBLYONgGMbxw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 32F6A185A7B2;
        Mon,  9 May 2022 21:42:42 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.11.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CAF6D2166B2F;
        Mon,  9 May 2022 21:42:41 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 7F0F0220463; Mon,  9 May 2022 17:42:41 -0400 (EDT)
Date:   Mon, 9 May 2022 17:42:41 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Theodore Ts'o <tytso@mit.edu>, Karel Zak <kzak@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [RFC PATCH] getting misc stats/attributes via xattr API
Message-ID: <YnmK0VJhQ4sf8AMI@redhat.com>
References: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com>
 <20220509124815.vb7d2xj5idhb2wq6@wittgenstein>
 <CAOQ4uxgCSJ2rpJkPy1FkP__7zhaVXO5dnZQXSzvk=fReaZH7Aw@mail.gmail.com>
 <20220509150856.cfsxn5t2tvev2njx@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509150856.cfsxn5t2tvev2njx@wittgenstein>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 09, 2022 at 05:08:56PM +0200, Christian Brauner wrote:

[..]
> Having "xattr" in the system call name is just confusing. These are
> fundamentally not "real" xattrs and we shouldn't mix semantics. There
> should be a clear distinction between traditional xattrs and this vfs
> and potentially fs information providing interface.
> 
> Just thinking about what the manpage would look like. We would need to
> add a paragraph to xattr(7) explaining that in addition to the system.*,
> security.*, user.* and other namespaces we now also have a set of
> namespaces that function as ways to get information about mounts or
> other things instead of information attached to specific inodes.
> 
> That's super random imho. If I were to be presented with this manpage
> I'd wonder if someone was too lazy to add a proper new system call with
> it's own semantics for this and just stuffed it into an existing API
> because it provided matching system call arguments. We can add a new
> system call. It's not that we're running out of them.

FWIW, I also felt that using xattr API to get some sort of mount info felt
very non-intutive.

Thanks
Vivek

