Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29852703137
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 17:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241161AbjEOPMk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 11:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239217AbjEOPMi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 11:12:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F9A8E;
        Mon, 15 May 2023 08:12:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AE57625F3;
        Mon, 15 May 2023 15:12:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA3FC433D2;
        Mon, 15 May 2023 15:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684163557;
        bh=W0/Ro3g+UnuQaJT98MLDjMPTmmzKa0SW17mCg2HptuM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qEwtpFA4B/izRqgX0Ybd2/WCOsnAVQoJrCFH/KTc479UYdVLoJ0CCpe6eI64JOn8t
         1IUMF1n1TH7q3GPEeqE3DxNpZlBFGo4xjAV2N8V/AQpZjs78o85IccISP779XvEB0j
         uQ2HJPQ8T3w6XH5FsTz+/wcYHQT39jwQU37RQI9xK7+grnrsT8A+1wDt+loetoEtQE
         kX/E/qdTJRobgxzTV6j0aHTA1+rE8G2HJTsEZymPuCUZCQTepnSwR+L4qLoaMNsfQV
         fa6j7N1q4xFWI0djfVNyNhnX9akdSQcaKgz0lrGYRdbLLg9ZP7ZeD6UeOIf9O1mnRt
         nMKXs1lMWu9tQ==
Date:   Mon, 15 May 2023 17:12:24 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        viro@zeniv.linux.org.uk, dhowells@redhat.com, code@tyhicks.com,
        hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org,
        sfrench@samba.org, senozhatsky@chromium.org, tom@talpey.com,
        chuck.lever@oracle.com, jlayton@kernel.org, miklos@szeredi.hu,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com, dchinner@redhat.com,
        john.johansen@canonical.com, mcgrof@kernel.org,
        mortonm@chromium.org, fred@cloudflare.com, mic@digikod.net,
        mpe@ellerman.id.au, nathanl@linux.ibm.com, gnoack3000@gmail.com,
        roberto.sassu@huawei.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        ecryptfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        wangweiyang2@huawei.com
Subject: Re: [PATCH -next 0/2] lsm: Change inode_setattr() to take struct
Message-ID: <20230515-nutzen-umgekehrt-eee629a0101e@brauner>
References: <20230505081200.254449-1-xiujianfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230505081200.254449-1-xiujianfeng@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 05, 2023 at 04:11:58PM +0800, Xiu Jianfeng wrote:
> Hi,
> 
> I am working on adding xattr/attr support for landlock [1], so we can
> control fs accesses such as chmod, chown, uptimes, setxattr, etc.. inside
> landlock sandbox. the LSM hooks as following are invoved:
> 1.inode_setattr
> 2.inode_setxattr
> 3.inode_removexattr
> 4.inode_set_acl
> 5.inode_remove_acl
> which are controlled by LANDLOCK_ACCESS_FS_WRITE_METADATA.
> 
> and
> 1.inode_getattr
> 2.inode_get_acl
> 3.inode_getxattr
> 4.inode_listxattr
> which are controlled by LANDLOCK_ACCESS_FS_READ_METADATA

It would be helpful to get the complete, full picture.

Piecemeal extending vfs helpers with struct path arguments is costly,
will cause a lot of churn and will require a lot of review time from us.

Please give us the list of all security hooks to which you want to pass
a struct path (if there are more to come apart from the ones listed
here). Then please follow all callchains and identify the vfs helpers
that would need to be updated. Then please figure out where those
vfs helpers are called from and follow all callchains finding all
inode_operations that would have to be updated and passed a struct path
argument. So ultimately we'll end up with a list of vfs helpers and
inode_operations that would have to be changed.

I'm very reluctant to see anything merged without knowing _exactly_ what
you're getting us into.
