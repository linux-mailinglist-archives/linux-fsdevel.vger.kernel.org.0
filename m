Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A5777262D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Aug 2023 15:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbjHGNlk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 09:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234286AbjHGNl0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:41:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B722010E5;
        Mon,  7 Aug 2023 06:41:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B966C61B6B;
        Mon,  7 Aug 2023 13:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DBC1C433C8;
        Mon,  7 Aug 2023 13:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691415617;
        bh=V2tsL4jeg3HSFJuBx8yZJw57Ak6ra8aQiPq/AhurRJY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Njps/r6JcoEoGt7sfD/MSeh8xyyp9Nxv8KzryG/hl6nCWfJWyBeuvzYHeHpKt0Eun
         97e8mT7p3vsV3BxNGNduPnMKzouCxqVtS5qdKbpBjhqn5II7cNZjJxWT2kXcqGNNPK
         qUEVlc0DI6pbhBZ7awHxEDSShh8KOHvAcsOMAW/fq+Vra7U/B3M4OCoo+/C3xl7bYy
         w56NEhPP/Yp4KMrImVJE3BdanAI1zEI8vSNDUsjnA4ZUB20Cntbg6jBweZ1WxL0zse
         sy2WOJtq0JKcHoA1GPHXQwApvRp/3RMbStpvZuP//QQQK0ilN0FKtF+mmEjwkuLS5r
         Spy6OjvljkvKg==
Date:   Mon, 7 Aug 2023 15:40:12 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     xiubli@redhat.com, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 00/12] ceph: support idmapped mounts
Message-ID: <20230807-gepinselt-begeistern-89bf404c2c12@brauner>
References: <20230807132626.182101-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230807132626.182101-1-aleksandr.mikhalitsyn@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 07, 2023 at 03:26:14PM +0200, Alexander Mikhalitsyn wrote:
> Dear friends,
> 
> This patchset was originally developed by Christian Brauner but I'll continue
> to push it forward. Christian allowed me to do that :)
> 
> This feature is already actively used/tested with LXD/LXC project.
> 
> Git tree (based on https://github.com/ceph/ceph-client.git testing):
> v10: https://github.com/mihalicyn/linux/commits/fs.idmapped.ceph.v10
> current: https://github.com/mihalicyn/linux/tree/fs.idmapped.ceph
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
> Changelog for version 5:
> - a few commits were squashed into one (as suggested by Xiubo Li)
> - started passing an idmapping everywhere (if possible), so a caller
> UID/GID-s will be mapped almost everywhere (as suggested by Xiubo Li)
> 
> Changelog for version 6:
> - rebased on top of testing branch
> - passed an idmapping in a few places (readdir, ceph_netfs_issue_op_inline)
> 
> Changelog for version 7:
> - rebased on top of testing branch
> - this thing now requires a new cephfs protocol extension CEPHFS_FEATURE_HAS_OWNER_UIDGID
> https://github.com/ceph/ceph/pull/52575
> 
> Changelog for version 8:
> - rebased on top of testing branch
> - added enable_unsafe_idmap module parameter to make idmapped mounts
> work with old MDS server versions
> - properly handled case when old MDS used with new kernel client
> 
> Changelog for version 9:
> - added "struct_len" field in struct ceph_mds_request_head as requested by Xiubo Li
> 
> Changelog for version 10:
> - fill struct_len field properly (use cpu_to_le32)
> - add extra checks IS_CEPH_MDS_OP_NEWINODE(..) as requested by Xiubo to match
>   userspace client behavior
> - do not set req->r_mnt_idmap for MKSNAP operation
> - atomic_open: set req->r_mnt_idmap only for CEPH_MDS_OP_CREATE as userspace client does

I won't RVB my own patches so I only added RVBs for the ones you
specifically added. So fwiw, I'm done reviewing.
