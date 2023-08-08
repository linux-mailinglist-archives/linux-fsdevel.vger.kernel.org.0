Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D06773EF9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 18:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbjHHQjx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 12:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjHHQjN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:39:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE04C3A4C9
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Aug 2023 08:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691510001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I61UNjTLAG95oq9qtMKUyrUKZXpIaEksaYyC4k2Zul0=;
        b=JAIOVhEE9j0ytcNa+Gx5idvnXK727zmgmMANh59mVPo4wsnCXrcxcRudmCMC1yIzBlJjir
        oX56oAVgNZfKViFYyIf8+8XhzNHKDQBpxx6PG5IEc3bBLW9fLPJPzIZpa/qnGrgt4Cv23a
        lYpfI5POqY1W+fJrUt/dFRbVm9wtomo=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-wNfu8JjrMaaOQUxE-zg8gg-1; Tue, 08 Aug 2023 03:51:07 -0400
X-MC-Unique: wNfu8JjrMaaOQUxE-zg8gg-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2694a083e16so1659593a91.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Aug 2023 00:51:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691481066; x=1692085866;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I61UNjTLAG95oq9qtMKUyrUKZXpIaEksaYyC4k2Zul0=;
        b=C9OU8ThzNTffsqVhQB2i0Q6PtOkWfZJswcYhL5XuakaAEQklp29rBGBmWTC+MeqQ8j
         tha72J8heGgGbP7etNOb3dwScOBLfG6c/c4J6eRVTd/yjaoSVyB4BuYjJcLJCg7NLkml
         +Wu/e3xgRf5yGT9ZBUnIBfGeaN5+5Sorx0r0SOihRylb8pjYQ7ywdw0WAxG3upl2dAzO
         RLQ7sGDavW02QebGscKRZ+8V9fUK4ZTki5/fHf4ryjM1YMOKqu9dEveshH+MYiKjAqqL
         aY21b+HNiUqJv4StIcEroB4ZIKYMH01F53KAVpTlyCTS/uSOiTL+llrQ7qVWFAl8Uuyt
         eKyA==
X-Gm-Message-State: AOJu0Yz3V/P5Mai8q5U1LcwRaMT9MuYQtsnIL7yNj74HPBQ2syfOyyZd
        M0jCA1o7eLXPOJlXpr1SM+1j0LnptLcB7Ipba6B9U+GEHFcCHD/o540rQhO1LcWGbUpbQgwb0jJ
        HBTK1TdqiRsFxoEj3bAfDA0LC6A==
X-Received: by 2002:a17:90a:1f06:b0:262:e49b:12d0 with SMTP id u6-20020a17090a1f0600b00262e49b12d0mr7464994pja.48.1691481066322;
        Tue, 08 Aug 2023 00:51:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTrnPTN25dJ5Xvq4lyfSvE+5LAMnJSWzkQdpqVJ6TSUnn1I/3RUmRCjFP3/Qd+tphTyy7tWw==
X-Received: by 2002:a17:90a:1f06:b0:262:e49b:12d0 with SMTP id u6-20020a17090a1f0600b00262e49b12d0mr7464986pja.48.1691481065875;
        Tue, 08 Aug 2023 00:51:05 -0700 (PDT)
Received: from [10.72.12.166] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id js22-20020a17090b149600b00262e485156esm9877439pjb.57.2023.08.08.00.51.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 00:51:05 -0700 (PDT)
Message-ID: <72db4603-e350-ac24-5819-d2519ce809b6@redhat.com>
Date:   Tue, 8 Aug 2023 15:50:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v10 00/12] ceph: support idmapped mounts
To:     Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230807132626.182101-1-aleksandr.mikhalitsyn@canonical.com>
 <bcda164b-e4b7-1c16-2714-13e3c6514b47@redhat.com>
 <CAEivzxfsj82q2x3C2U6yemB9qRrLnW+fLAAE=e7Tq-LDDfH0-g@mail.gmail.com>
Content-Language: en-US
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <CAEivzxfsj82q2x3C2U6yemB9qRrLnW+fLAAE=e7Tq-LDDfH0-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 8/8/23 14:30, Aleksandr Mikhalitsyn wrote:
> On Tue, Aug 8, 2023 at 2:45 AM Xiubo Li <xiubli@redhat.com> wrote:
>> LGTM.
>>
>> Reviewed-by: Xiubo Li <xiubli@redhat.com>
>>
>> I will queue this to the 'testing' branch and then we will run ceph qa
>> tests.
> Thanks, Xiubo!
>
> JFYI: commit ordering in
> https://github.com/ceph/ceph-client/commits/testing looks a little bit
> weird
> probably something got wrong during patch application to the tree.

I will check it.

Thanks

- Xiubo


> Kind regards,
> Alex
>
>> Thanks Alex.
>>
>> - Xiubo
>>
>> On 8/7/23 21:26, Alexander Mikhalitsyn wrote:
>>> Dear friends,
>>>
>>> This patchset was originally developed by Christian Brauner but I'll continue
>>> to push it forward. Christian allowed me to do that :)
>>>
>>> This feature is already actively used/tested with LXD/LXC project.
>>>
>>> Git tree (based on https://github.com/ceph/ceph-client.git testing):
>>> v10: https://github.com/mihalicyn/linux/commits/fs.idmapped.ceph.v10
>>> current: https://github.com/mihalicyn/linux/tree/fs.idmapped.ceph
>>>
>>> In the version 3 I've changed only two commits:
>>> - fs: export mnt_idmap_get/mnt_idmap_put
>>> - ceph: allow idmapped setattr inode op
>>> and added a new one:
>>> - ceph: pass idmap to __ceph_setattr
>>>
>>> In the version 4 I've reworked the ("ceph: stash idmapping in mdsc request")
>>> commit. Now we take idmap refcounter just in place where req->r_mnt_idmap
>>> is filled. It's more safer approach and prevents possible refcounter underflow
>>> on error paths where __register_request wasn't called but ceph_mdsc_release_request is
>>> called.
>>>
>>> Changelog for version 5:
>>> - a few commits were squashed into one (as suggested by Xiubo Li)
>>> - started passing an idmapping everywhere (if possible), so a caller
>>> UID/GID-s will be mapped almost everywhere (as suggested by Xiubo Li)
>>>
>>> Changelog for version 6:
>>> - rebased on top of testing branch
>>> - passed an idmapping in a few places (readdir, ceph_netfs_issue_op_inline)
>>>
>>> Changelog for version 7:
>>> - rebased on top of testing branch
>>> - this thing now requires a new cephfs protocol extension CEPHFS_FEATURE_HAS_OWNER_UIDGID
>>> https://github.com/ceph/ceph/pull/52575
>>>
>>> Changelog for version 8:
>>> - rebased on top of testing branch
>>> - added enable_unsafe_idmap module parameter to make idmapped mounts
>>> work with old MDS server versions
>>> - properly handled case when old MDS used with new kernel client
>>>
>>> Changelog for version 9:
>>> - added "struct_len" field in struct ceph_mds_request_head as requested by Xiubo Li
>>>
>>> Changelog for version 10:
>>> - fill struct_len field properly (use cpu_to_le32)
>>> - add extra checks IS_CEPH_MDS_OP_NEWINODE(..) as requested by Xiubo to match
>>>     userspace client behavior
>>> - do not set req->r_mnt_idmap for MKSNAP operation
>>> - atomic_open: set req->r_mnt_idmap only for CEPH_MDS_OP_CREATE as userspace client does
>>>
>>> I can confirm that this version passes xfstests and
>>> tested with old MDS (without CEPHFS_FEATURE_HAS_OWNER_UIDGID)
>>> and with recent MDS version.
>>>
>>> Links to previous versions:
>>> v1: https://lore.kernel.org/all/20220104140414.155198-1-brauner@kernel.org/
>>> v2: https://lore.kernel.org/lkml/20230524153316.476973-1-aleksandr.mikhalitsyn@canonical.com/
>>> tree: https://github.com/mihalicyn/linux/commits/fs.idmapped.ceph.v2
>>> v3: https://lore.kernel.org/lkml/20230607152038.469739-1-aleksandr.mikhalitsyn@canonical.com/#t
>>> v4: https://lore.kernel.org/lkml/20230607180958.645115-1-aleksandr.mikhalitsyn@canonical.com/#t
>>> tree: https://github.com/mihalicyn/linux/commits/fs.idmapped.ceph.v4
>>> v5: https://lore.kernel.org/lkml/20230608154256.562906-1-aleksandr.mikhalitsyn@canonical.com/#t
>>> tree: https://github.com/mihalicyn/linux/commits/fs.idmapped.ceph.v5
>>> v6: https://lore.kernel.org/lkml/20230609093125.252186-1-aleksandr.mikhalitsyn@canonical.com/
>>> tree: https://github.com/mihalicyn/linux/commits/fs.idmapped.ceph.v6
>>> v7: https://lore.kernel.org/all/20230726141026.307690-1-aleksandr.mikhalitsyn@canonical.com/
>>> tree: https://github.com/mihalicyn/linux/commits/fs.idmapped.ceph.v7
>>> v8: https://lore.kernel.org/all/20230803135955.230449-1-aleksandr.mikhalitsyn@canonical.com/
>>> tree: -
>>> v9: https://lore.kernel.org/all/20230804084858.126104-1-aleksandr.mikhalitsyn@canonical.com/
>>> tree: https://github.com/mihalicyn/linux/commits/fs.idmapped.ceph.v9
>>>
>>> Kind regards,
>>> Alex
>>>
>>> Original description from Christian:
>>> ========================================================================
>>> This patch series enables cephfs to support idmapped mounts, i.e. the
>>> ability to alter ownership information on a per-mount basis.
>>>
>>> Container managers such as LXD support sharaing data via cephfs between
>>> the host and unprivileged containers and between unprivileged containers.
>>> They may all use different idmappings. Idmapped mounts can be used to
>>> create mounts with the idmapping used for the container (or a different
>>> one specific to the use-case).
>>>
>>> There are in fact more use-cases such as remapping ownership for
>>> mountpoints on the host itself to grant or restrict access to different
>>> users or to make it possible to enforce that programs running as root
>>> will write with a non-zero {g,u}id to disk.
>>>
>>> The patch series is simple overall and few changes are needed to cephfs.
>>> There is one cephfs specific issue that I would like to discuss and
>>> solve which I explain in detail in:
>>>
>>> [PATCH 02/12] ceph: handle idmapped mounts in create_request_message()
>>>
>>> It has to do with how to handle mds serves which have id-based access
>>> restrictions configured. I would ask you to please take a look at the
>>> explanation in the aforementioned patch.
>>>
>>> The patch series passes the vfs and idmapped mount testsuite as part of
>>> xfstests. To run it you will need a config like:
>>>
>>> [ceph]
>>> export FSTYP=ceph
>>> export TEST_DIR=/mnt/test
>>> export TEST_DEV=10.103.182.10:6789:/
>>> export TEST_FS_MOUNT_OPTS="-o name=admin,secret=$password
>>>
>>> and then simply call
>>>
>>> sudo ./check -g idmapped
>>>
>>> ========================================================================
>>>
>>> Alexander Mikhalitsyn (3):
>>>     fs: export mnt_idmap_get/mnt_idmap_put
>>>     ceph: add enable_unsafe_idmap module parameter
>>>     ceph: pass idmap to __ceph_setattr
>>>
>>> Christian Brauner (9):
>>>     ceph: stash idmapping in mdsc request
>>>     ceph: handle idmapped mounts in create_request_message()
>>>     ceph: pass an idmapping to mknod/symlink/mkdir
>>>     ceph: allow idmapped getattr inode op
>>>     ceph: allow idmapped permission inode op
>>>     ceph: allow idmapped setattr inode op
>>>     ceph/acl: allow idmapped set_acl inode op
>>>     ceph/file: allow idmapped atomic_open inode op
>>>     ceph: allow idmapped mounts
>>>
>>>    fs/ceph/acl.c                 |  6 +--
>>>    fs/ceph/crypto.c              |  2 +-
>>>    fs/ceph/dir.c                 |  4 ++
>>>    fs/ceph/file.c                | 11 ++++-
>>>    fs/ceph/inode.c               | 29 +++++++------
>>>    fs/ceph/mds_client.c          | 78 ++++++++++++++++++++++++++++++++---
>>>    fs/ceph/mds_client.h          |  8 +++-
>>>    fs/ceph/super.c               |  7 +++-
>>>    fs/ceph/super.h               |  3 +-
>>>    fs/mnt_idmapping.c            |  2 +
>>>    include/linux/ceph/ceph_fs.h  | 10 ++++-
>>>    include/linux/mnt_idmapping.h |  3 ++
>>>    12 files changed, 136 insertions(+), 27 deletions(-)
>>>

