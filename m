Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8845F72755F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 05:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbjFHDCM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 23:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233910AbjFHDCD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 23:02:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D402115
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jun 2023 20:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686193274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VAX/4doU6LsuAU3r2edHNFmZkCL67LPKV2wnDv9MzVE=;
        b=iPZiUchh3Kut1tp95UbJyxV0XuAKDeo8KcZG3BNNM5yW4MgUopJCnGB4xTjyFd5nTFC/QZ
        WAJ8456F03vZ8P2Ln7bVK3NDHq87xLcurkxdW4nS3EilSCPAD57HwJrsJ6uKISTq/JQo9F
        x4GGobk4Q0ndo0fPbfC319OKM2rMBI8=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-APaiT3CpPMerY2TxwOR0cQ-1; Wed, 07 Jun 2023 23:01:12 -0400
X-MC-Unique: APaiT3CpPMerY2TxwOR0cQ-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-39c715d6d5dso195086b6e.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jun 2023 20:01:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686193271; x=1688785271;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VAX/4doU6LsuAU3r2edHNFmZkCL67LPKV2wnDv9MzVE=;
        b=CV0Lelbu21a3Q+lvDKmOq74bpIn/bUhVMIWw8I/Srsf99r2rRuw7L1Z2NKsa0BX8Nn
         JMNiyma/0525cIA62poXf2GOyrK5vuS51cSEsA2Tuo/wzJVhRiOItnIH8/pQNtAuI39H
         AST1tTx91okcY/0bkfd2NRbluF4YLhnIRSKbXvoNKuTUkaJWljcfoHaKgQOU3MKYFOh8
         +8kbl8H0MLwiuhX7I3ah21h5h29Hxa48Uk8zvbXIPPvjqWqTYHLUDI1UhPDhmSFrhgqT
         WvG6GCz+z6SezKyRzvzAU7BxazUkZDOC10k4iOAWhGlFFOpV/S8DSzXAVUoJIjPyAuOG
         aT6A==
X-Gm-Message-State: AC+VfDyoxSR3Mc9ATMA7M04J6SctIzUF9tL79q2GqXM83EeltCUpnJts
        j/6rtpRGj5BldHzt0R0nsInbzYM2BtjYntUv1xz/6Nrx30yfnoXYgMc6uBWRy5zAe8cecf0nSjC
        LWh1lnk7FPdS/GRSfrmfPRz/PXA==
X-Received: by 2002:a05:6808:6387:b0:39c:6e23:5e07 with SMTP id ec7-20020a056808638700b0039c6e235e07mr2522399oib.12.1686193271486;
        Wed, 07 Jun 2023 20:01:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6quQf8Z87kps9NEUI8o515lXNLfPZudB9sqUZwpIdz/52Yu1Ep2Y4w+w3PWmRwcE3eNHd86Q==
X-Received: by 2002:a05:6808:6387:b0:39c:6e23:5e07 with SMTP id ec7-20020a056808638700b0039c6e235e07mr2522374oib.12.1686193271110;
        Wed, 07 Jun 2023 20:01:11 -0700 (PDT)
Received: from [10.72.13.135] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id s12-20020a17090a5d0c00b0025930e50e28sm1995376pji.41.2023.06.07.20.01.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 20:01:10 -0700 (PDT)
Message-ID: <8b22fc1e-595a-b729-dd21-2714f22a28a7@redhat.com>
Date:   Thu, 8 Jun 2023 11:00:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 00/14] ceph: support idmapped mounts
Content-Language: en-US
To:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230607180958.645115-1-aleksandr.mikhalitsyn@canonical.com>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20230607180958.645115-1-aleksandr.mikhalitsyn@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Alexander,

As I mentioned in V2 thread 
https://www.spinics.net/lists/kernel/msg4810994.html, we should use the 
'idmap' for all the requests below, because MDS will do the 
'check_access()' for all the requests by using the caller uid/gid, 
please see 
https://github.com/ceph/ceph/blob/main/src/mds/Server.cc#L3294-L3310.


Cscope tag: ceph_mdsc_do_request
    #   line  filename / context / line
    1    321  fs/ceph/addr.c <<ceph_netfs_issue_op_inline>>
              err = ceph_mdsc_do_request(mdsc, NULL, req);
    2    443  fs/ceph/dir.c <<ceph_readdir>>
              err = ceph_mdsc_do_request(mdsc, NULL, req);
    3    838  fs/ceph/dir.c <<ceph_lookup>>
              err = ceph_mdsc_do_request(mdsc, NULL, req);
    4    933  fs/ceph/dir.c <<ceph_mknod>>
              err = ceph_mdsc_do_request(mdsc, dir, req);
    5   1045  fs/ceph/dir.c <<ceph_symlink>>
              err = ceph_mdsc_do_request(mdsc, dir, req);
    6   1120  fs/ceph/dir.c <<ceph_mkdir>>
              err = ceph_mdsc_do_request(mdsc, dir, req);
    7   1180  fs/ceph/dir.c <<ceph_link>>
              err = ceph_mdsc_do_request(mdsc, dir, req);
    8   1365  fs/ceph/dir.c <<ceph_unlink>>
              err = ceph_mdsc_do_request(mdsc, dir, req);
    9   1431  fs/ceph/dir.c <<ceph_rename>>
              err = ceph_mdsc_do_request(mdsc, old_dir, req);
   10   1927  fs/ceph/dir.c <<ceph_d_revalidate>>
              err = ceph_mdsc_do_request(mdsc, NULL, req);
   11    154  fs/ceph/export.c <<__lookup_inode>>
              err = ceph_mdsc_do_request(mdsc, NULL, req);
   12    262  fs/ceph/export.c <<__snapfh_to_dentry>>
              err = ceph_mdsc_do_request(mdsc, NULL, req);
   13    347  fs/ceph/export.c <<__get_parent>>
              err = ceph_mdsc_do_request(mdsc, NULL, req);
   14    490  fs/ceph/export.c <<__get_snap_name>>
              err = ceph_mdsc_do_request(fsc->mdsc, NULL, req);
   15    561  fs/ceph/export.c <<ceph_get_name>>
              err = ceph_mdsc_do_request(mdsc, NULL, req);
   16    339  fs/ceph/file.c <<ceph_renew_caps>>
              err = ceph_mdsc_do_request(mdsc, NULL, req);
   17    434  fs/ceph/file.c <<ceph_open>>
              err = ceph_mdsc_do_request(mdsc, NULL, req);
   18    855  fs/ceph/file.c <<ceph_atomic_open>>
              err = ceph_mdsc_do_request(mdsc, (flags & O_CREAT) ? dir : 
NULL, req);
   19   2715  fs/ceph/inode.c <<__ceph_setattr>>
              err = ceph_mdsc_do_request(mdsc, NULL, req);
   20   2839  fs/ceph/inode.c <<__ceph_do_getattr>>
              err = ceph_mdsc_do_request(mdsc, NULL, req);
   21   2883  fs/ceph/inode.c <<ceph_do_getvxattr>>
              err = ceph_mdsc_do_request(mdsc, NULL, req);
   22    126  fs/ceph/ioctl.c <<ceph_ioctl_set_layout>>
              err = ceph_mdsc_do_request(mdsc, NULL, req);
   23    171  fs/ceph/ioctl.c <<ceph_ioctl_set_layout_policy>>
              err = ceph_mdsc_do_request(mdsc, inode, req);
   24    216  fs/ceph/locks.c <<ceph_lock_wait_for_completion>>
              err = ceph_mdsc_do_request(mdsc, inode, intr_req);
   25   1091  fs/ceph/super.c <<open_root_dentry>>
              err = ceph_mdsc_do_request(mdsc, NULL, req);
   26   1151  fs/ceph/xattr.c <<ceph_sync_setxattr>>
              err = ceph_mdsc_do_request(mdsc, NULL, req);


And also could you squash the similar commit into one ?


Thanks

- Xiubo


On 6/8/23 02:09, Alexander Mikhalitsyn wrote:
> Dear friends,
>
> This patchset was originally developed by Christian Brauner but I'll continue
> to push it forward. Christian allowed me to do that :)
>
> This feature is already actively used/tested with LXD/LXC project.
>
> Git tree (based on https://github.com/ceph/ceph-client.git master):
> https://github.com/mihalicyn/linux/tree/fs.idmapped.ceph
>
> In the version 3 I've changed only two commits:
> - fs: export mnt_idmap_get/mnt_idmap_put
> - ceph: allow idmapped setattr inode op
> and added a new one:
> - ceph: pass idmap to __ceph_setattr
>
> In the version 4 I've reworked the ("ceph: stash idmapping in mdsc request")
> commit. Now we take idmap refcounter just in place where req->r_mnt_idmap
> is filled. It's more safer approach and prevents possible refcounter underflow
> on error paths where __register_request wasn't called but ceph_mdsc_release_request is
> called.
>
> I can confirm that this version passes xfstests.
>
> Links to previous versions:
> v1: https://lore.kernel.org/all/20220104140414.155198-1-brauner@kernel.org/
> v2: https://lore.kernel.org/lkml/20230524153316.476973-1-aleksandr.mikhalitsyn@canonical.com/
> v3: https://lore.kernel.org/lkml/20230607152038.469739-1-aleksandr.mikhalitsyn@canonical.com/#t
>
> Kind regards,
> Alex
>
> Original description from Christian:
> ========================================================================
> This patch series enables cephfs to support idmapped mounts, i.e. the
> ability to alter ownership information on a per-mount basis.
>
> Container managers such as LXD support sharaing data via cephfs between
> the host and unprivileged containers and between unprivileged containers.
> They may all use different idmappings. Idmapped mounts can be used to
> create mounts with the idmapping used for the container (or a different
> one specific to the use-case).
>
> There are in fact more use-cases such as remapping ownership for
> mountpoints on the host itself to grant or restrict access to different
> users or to make it possible to enforce that programs running as root
> will write with a non-zero {g,u}id to disk.
>
> The patch series is simple overall and few changes are needed to cephfs.
> There is one cephfs specific issue that I would like to discuss and
> solve which I explain in detail in:
>
> [PATCH 02/12] ceph: handle idmapped mounts in create_request_message()
>
> It has to do with how to handle mds serves which have id-based access
> restrictions configured. I would ask you to please take a look at the
> explanation in the aforementioned patch.
>
> The patch series passes the vfs and idmapped mount testsuite as part of
> xfstests. To run it you will need a config like:
>
> [ceph]
> export FSTYP=ceph
> export TEST_DIR=/mnt/test
> export TEST_DEV=10.103.182.10:6789:/
> export TEST_FS_MOUNT_OPTS="-o name=admin,secret=$password
>
> and then simply call
>
> sudo ./check -g idmapped
>
> ========================================================================
>
> Alexander Mikhalitsyn (2):
>    fs: export mnt_idmap_get/mnt_idmap_put
>    ceph: pass idmap to __ceph_setattr
>
> Christian Brauner (12):
>    ceph: stash idmapping in mdsc request
>    ceph: handle idmapped mounts in create_request_message()
>    ceph: allow idmapped mknod inode op
>    ceph: allow idmapped symlink inode op
>    ceph: allow idmapped mkdir inode op
>    ceph: allow idmapped rename inode op
>    ceph: allow idmapped getattr inode op
>    ceph: allow idmapped permission inode op
>    ceph: allow idmapped setattr inode op
>    ceph/acl: allow idmapped set_acl inode op
>    ceph/file: allow idmapped atomic_open inode op
>    ceph: allow idmapped mounts
>
>   fs/ceph/acl.c                 |  6 +++---
>   fs/ceph/dir.c                 |  4 ++++
>   fs/ceph/file.c                | 10 ++++++++--
>   fs/ceph/inode.c               | 29 +++++++++++++++++------------
>   fs/ceph/mds_client.c          | 27 +++++++++++++++++++++++----
>   fs/ceph/mds_client.h          |  1 +
>   fs/ceph/super.c               |  2 +-
>   fs/ceph/super.h               |  3 ++-
>   fs/mnt_idmapping.c            |  2 ++
>   include/linux/mnt_idmapping.h |  3 +++
>   10 files changed, 64 insertions(+), 23 deletions(-)
>

