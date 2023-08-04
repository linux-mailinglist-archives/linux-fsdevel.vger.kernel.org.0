Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4F1770431
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 17:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjHDPRN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 11:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjHDPRL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:17:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6791E49C6
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Aug 2023 08:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691162185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=obUjDUYXYeTUDK2opFgvx08zifi9IeBL/RTGGVT6YBY=;
        b=VNToWIH0Kw19q+8ZAgitqD7o+GmHIA/cniAA4EMCnLWSKf0UOMeNw1tlsInQ1kDuL3tA3k
        JkcUwXjI+7zrmo+HA5eszIf2oXqLo5qHrIEM9V6RbOpxe7l+GoSEoFVe6UbjG71NR9+8TM
        xYTOpiFUF7le2CoCv7rrsSKVhCMdnes=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-93-1FSrIDZ_MvOnd_-k6mrKOQ-1; Fri, 04 Aug 2023 11:16:22 -0400
X-MC-Unique: 1FSrIDZ_MvOnd_-k6mrKOQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6DEDE856F67;
        Fri,  4 Aug 2023 15:16:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CBD192166B25;
        Fri,  4 Aug 2023 15:16:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <bac543537058619345b363bbfc745927.paul@paul-moore.com>
References: <bac543537058619345b363bbfc745927.paul@paul-moore.com> <20230802-master-v6-1-45d48299168b@kernel.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Scott Mayhew <smayhew@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Subject: Re: [PATCH v6] vfs, security: Fix automount superblock LSM init problem, preventing NFS sb sharing
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2678221.1691162178.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 04 Aug 2023 16:16:18 +0100
Message-ID: <2678222.1691162178@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Paul Moore <paul@paul-moore.com> wrote:

> =

> I generally dislike core kernel code which makes LSM calls conditional
> on some kernel state maintained outside the LSM.  Sometimes it has to
> be done as there is no other good options, but I would like us to try
> and avoid it if possible.  The commit description mentioned that this
> was put here to avoid a SELinux complaint, can you provide an example
> of the complain?  Does it complain about a double/invalid mount, e.g.
> "SELinux: mount invalid.  Same superblock, different security ..."?
> =

> I'd like to understand why the sb_set_mnt_opts() call fails when it
> comes after the fs_context_init() call.  I'm particulary curious to
> know if the failure is due to conflicting SELinux state in the
> fs_context, or if it is simply an issue of sb_set_mnt_opts() not
> properly handling existing values.  Perhaps I'm being overly naive,
> but I'm hopeful that we can address both of these within the SELinux
> code itself.
> =

> In a worst case situation, we could always implement a flag *inside*
> the SELinux code, similar to what has been done with 'lsm_set' here.

IIRC, the issue is when you make a mount with an explicit context=3D setti=
ng and
make another mount from some way down the export tree that doesn't have an
explicit setting, e.g.:

	mount carina:/ /mnt -o context=3Dsystem_u:object_r:root_t:s0
	mount carina:/nfs/scratch /mnt2

and then cause an automount to walk from one to the other:

	stat /mnt/nfs/scratch/foo

For reference, my server has:

	/nfs/scratch 192.168.6.0/255.255.255.0,90.155.74.16/255.255.255.248
	/nfs         192.168.6.0/255.255.255.0,90.155.74.16/255.255.255.248
	/            192.168.6.0/255.255.255.0,90.155.74.16/255.255.255.248

and if I look in /proc/fs/nfsfs/volumes, I can see the individual superblo=
cks:

	NV SERVER   PORT DEV          FSID                              FSC
	v4 c0a80601  801 0:51         0:0                               no =

	v4 c0a80601  801 0:56         3:0                               no =

	v4 c0a80601  801 0:52         1:0                               no =

	v4 c0a80601  801 0:55         3:0                               no =


As you can see, there are two referring to the same 'volume'.

Without the "fc->lsm_set=3Dtrue" bit, you get an error something like:

	SELinux: mount invalid.  Same superblock, different security settings for=
 (dev 0:56, type nfs4)

One important question is how should sharing of a mount with unspecified
context be handled when we try to unify it with a mount that has an explic=
it
context?

David

