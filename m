Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECBE5983EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 15:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244790AbiHRNPG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 09:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244970AbiHRNPE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:15:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A55D6B
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Aug 2022 06:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660828497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c6QQzktQOsLF5gvz1m1JMJhC3Jcc7lkjkkVix5pQvuU=;
        b=JRJPFUzgtoteZgUdW13KKet9YPJvGX4UgW842lT55r3Sll388eA4ettZ+NKplRk8YoiY1p
        qSL5s8gXtwJJzTnK1Xgv6Z+Mm0djK49BLZq+yu1t1+lZWPElEn+QvEkPJxe2GftW2db899
        /qcCQ3+v8WR31fiqoRj3O40qepMflec=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-211-4KzSz-gKPE24pj2vCPoWYw-1; Thu, 18 Aug 2022 09:14:47 -0400
X-MC-Unique: 4KzSz-gKPE24pj2vCPoWYw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4E58D1019C91;
        Thu, 18 Aug 2022 13:14:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8524D9457F;
        Thu, 18 Aug 2022 13:14:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHC9VhTpqvFbjKG5FMKGRBRHavOUrsCSFgayh+BNgSrry8bWLg@mail.gmail.com>
References: <CAHC9VhTpqvFbjKG5FMKGRBRHavOUrsCSFgayh+BNgSrry8bWLg@mail.gmail.com> <165970659095.2812394.6868894171102318796.stgit@warthog.procyon.org.uk> <CAFqZXNv+ahpN3Hdv54ixa4u-LKaqTtCyjtkpzKGbv7x4dzwc0Q@mail.gmail.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     dhowells@redhat.com, Ondrej Mosnacek <omosnace@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Scott Mayhew <smayhew@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        dwysocha@redhat.com,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] nfs: Fix automount superblock LSM init problem, preventing sb sharing
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2026284.1660828477.1@warthog.procyon.org.uk>
Date:   Thu, 18 Aug 2022 14:14:37 +0100
Message-ID: <2026286.1660828477@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Paul Moore <paul@paul-moore.com> wrote:

> I guess my question is this: for inodes inside the superblock, does
> their superblock pointer point to the submount's superblock, or the
> parent filesystem's superblock?

They have to point to the submount superblock.  Too many things would break, I
think, if inode->i_sb pointed to the wrong place.  As far as the VFS is
concerned, apart from the way it is mounted, it's a perfectly normal
superblock.

David

