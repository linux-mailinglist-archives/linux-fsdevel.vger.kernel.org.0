Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC95971861B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 17:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbjEaPWo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 11:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234654AbjEaPW2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 11:22:28 -0400
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc0e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7C71A2;
        Wed, 31 May 2023 08:22:16 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4QWY0Q2wK1zMqBkH;
        Wed, 31 May 2023 17:22:14 +0200 (CEST)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4QWY0G4Z6QzMqFfF;
        Wed, 31 May 2023 17:22:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1685546534;
        bh=8echtExvY903wL+VZOZ6yhBJAcvuAYpaWxyyr0rVy8w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UCoFqVu9Y/RRO0Tl+8GYdhg+QL2jsnrLmJVc95PGsjviUz1MFlPNr9Ls9etbgky2f
         +NJTVdzCzpayOxC7AXXulIEL5iaLoblXaS+YwfxQZuO5HILy95zRI7Soj1IzfZ1+CL
         pp3TTVVWN5YMTh+pZ03O1kvnD/qtJwnRtDiHcV8s=
Message-ID: <4b3fff12-f696-3d02-5873-645fef2117e1@digikod.net>
Date:   Wed, 31 May 2023 17:22:05 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH -next 0/2] lsm: Change inode_setattr() to take struct
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>,
        Christian Brauner <brauner@kernel.org>
Cc:     Xiu Jianfeng <xiujianfeng@huawei.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com,
        code@tyhicks.com, hirofumi@mail.parknet.co.jp,
        linkinjeon@kernel.org, sfrench@samba.org, senozhatsky@chromium.org,
        tom@talpey.com, chuck.lever@oracle.com, jlayton@kernel.org,
        miklos@szeredi.hu, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, casey@schaufler-ca.com, dchinner@redhat.com,
        john.johansen@canonical.com, mcgrof@kernel.org,
        mortonm@chromium.org, fred@cloudflare.com, mpe@ellerman.id.au,
        nathanl@linux.ibm.com, gnoack3000@gmail.com,
        roberto.sassu@huawei.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        ecryptfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        wangweiyang2@huawei.com
References: <20230505081200.254449-1-xiujianfeng@huawei.com>
 <20230515-nutzen-umgekehrt-eee629a0101e@brauner>
 <75b4746d-d41e-7c9f-4bb0-42a46bda7f17@digikod.net>
 <20230530-mietfrei-zynisch-8b63a8566f66@brauner>
 <20230530142826.GA9376@lst.de>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20230530142826.GA9376@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 30/05/2023 16:28, Christoph Hellwig wrote:
> On Tue, May 30, 2023 at 03:58:35PM +0200, Christian Brauner wrote:
>> The main concern which was expressed on other patchsets before is that
>> modifying inode operations to take struct path is not the way to go.
>> Passing struct path into individual filesystems is a clear layering
>> violation for most inode operations, sometimes downright not feasible,
>> and in general exposing struct vfsmount to filesystems is a hard no. At
>> least as far as I'm concerned.
> 
> Agreed.  Passing struct path into random places is not how the VFS works.

I understand, it makes sense for the FS layer to not get access to 
things not required. IIUC, the main issue is the layering, with LSM 
calls being sometime at the last layer.


> 
>> So the best way to achieve the landlock goal might be to add new hooks
> 
> What is "the landlock goal", and why does it matter?

Landlock's goal is to enable (unprivileged) users to set their own 
access rights for their (ephemeral) processes (on top of the existing 
access-controls of course) i.e., to sandbox applications. Landlock rules 
are defined by users, and then according to the FS topology they see. 
This means that Landlock relies on inodes and mount points to define and 
enforce a policy.


> 
>> or not. And we keep adding new LSMs without deprecating older ones (A
>> problem we also face in the fs layer.) and then they sit around but
>> still need to be taken into account when doing changes.
> 
> Yes, I'm really worried about th amount of LSMs we have, and the weird
> things they do.

About Landlock, it's a new LSM that fit an actual need. I'd be glad to 
hear about not recommended things and how to improve the situation. I 
don't know all the history between VFS and LSM.
