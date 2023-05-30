Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A138716422
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 16:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbjE3O3c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 10:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbjE3O31 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 10:29:27 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66716102;
        Tue, 30 May 2023 07:29:05 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 277B268B05; Tue, 30 May 2023 16:28:27 +0200 (CEST)
Date:   Tue, 30 May 2023 16:28:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        viro@zeniv.linux.org.uk, dhowells@redhat.com, code@tyhicks.com,
        hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org,
        sfrench@samba.org, senozhatsky@chromium.org, tom@talpey.com,
        chuck.lever@oracle.com, jlayton@kernel.org, miklos@szeredi.hu,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com, dchinner@redhat.com,
        john.johansen@canonical.com, mcgrof@kernel.org,
        mortonm@chromium.org, fred@cloudflare.com, mpe@ellerman.id.au,
        nathanl@linux.ibm.com, gnoack3000@gmail.com,
        roberto.sassu@huawei.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        ecryptfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        wangweiyang2@huawei.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH -next 0/2] lsm: Change inode_setattr() to take struct
Message-ID: <20230530142826.GA9376@lst.de>
References: <20230505081200.254449-1-xiujianfeng@huawei.com> <20230515-nutzen-umgekehrt-eee629a0101e@brauner> <75b4746d-d41e-7c9f-4bb0-42a46bda7f17@digikod.net> <20230530-mietfrei-zynisch-8b63a8566f66@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530-mietfrei-zynisch-8b63a8566f66@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 30, 2023 at 03:58:35PM +0200, Christian Brauner wrote:
> The main concern which was expressed on other patchsets before is that
> modifying inode operations to take struct path is not the way to go.
> Passing struct path into individual filesystems is a clear layering
> violation for most inode operations, sometimes downright not feasible,
> and in general exposing struct vfsmount to filesystems is a hard no. At
> least as far as I'm concerned.

Agreed.  Passing struct path into random places is not how the VFS works.

> So the best way to achieve the landlock goal might be to add new hooks

What is "the landlock goal", and why does it matter?

> or not. And we keep adding new LSMs without deprecating older ones (A
> problem we also face in the fs layer.) and then they sit around but
> still need to be taken into account when doing changes.

Yes, I'm really worried about th amount of LSMs we have, and the weird
things they do.
