Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5FD770394
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 16:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjHDOxQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 10:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjHDOxO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:53:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE6249C6;
        Fri,  4 Aug 2023 07:53:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 022196202B;
        Fri,  4 Aug 2023 14:53:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84358C433C8;
        Fri,  4 Aug 2023 14:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691160792;
        bh=i8frHjWssprhpqflEJzk6UJ9+pA/7h0hxhFuqQQSANA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KVFNg+BHtMnxXyFuN6oOmmIFpEUkKftUrVowYVMSMKRBpYchss3ecC3vHLpw6P6Dy
         lBCB7b06NhjmnsJma5e3lt01sn8uCwR4Wtm+/vWn7MQMOgS7Tsm+8jNGcQHKoxM/G3
         6AZ+bjD58DV9vzU7aYAcg4CW1URu9+kVCB+L0kLKt/u727d7BCIGSbx8RkyImBlmLY
         d8KowtFBkHkDz6EEmnMDBMRqxgOA3/eIRm9m3AbIl7RSY0gWiqZLO2UZySJWyMnMQH
         fEBkAft5AeAjiWFwW4WkSaaaHeaMl3sN2f8q50gFbPI1jB9G4OyXia7emXgwt+QP7V
         NkRvxfZYHft5Q==
Date:   Fri, 4 Aug 2023 16:53:02 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     xiubli@redhat.com, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 03/12] ceph: handle idmapped mounts in
 create_request_message()
Message-ID: <20230804-paket-zuziehen-8615127094f3@brauner>
References: <20230804084858.126104-1-aleksandr.mikhalitsyn@canonical.com>
 <20230804084858.126104-4-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230804084858.126104-4-aleksandr.mikhalitsyn@canonical.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 04, 2023 at 10:48:49AM +0200, Alexander Mikhalitsyn wrote:
> From: Christian Brauner <brauner@kernel.org>
> 
> Inode operations that create a new filesystem object such as ->mknod,
> ->create, ->mkdir() and others don't take a {g,u}id argument explicitly.
> Instead the caller's fs{g,u}id is used for the {g,u}id of the new
> filesystem object.
> 
> In order to ensure that the correct {g,u}id is used map the caller's
> fs{g,u}id for creation requests. This doesn't require complex changes.
> It suffices to pass in the relevant idmapping recorded in the request
> message. If this request message was triggered from an inode operation
> that creates filesystem objects it will have passed down the relevant
> idmaping. If this is a request message that was triggered from an inode
> operation that doens't need to take idmappings into account the initial
> idmapping is passed down which is an identity mapping.
> 
> This change uses a new cephfs protocol extension CEPHFS_FEATURE_HAS_OWNER_UIDGID
> which adds two new fields (owner_{u,g}id) to the request head structure.
> So, we need to ensure that MDS supports it otherwise we need to fail
> any IO that comes through an idmapped mount because we can't process it
> in a proper way. MDS server without such an extension will use caller_{u,g}id
> fields to set a new inode owner UID/GID which is incorrect because caller_{u,g}id
> values are unmapped. At the same time we can't map these fields with an
> idmapping as it can break UID/GID-based permission checks logic on the
> MDS side. This problem was described with a lot of details at [1], [2].
> 
> [1] https://lore.kernel.org/lkml/CAEivzxfw1fHO2TFA4dx3u23ZKK6Q+EThfzuibrhA3RKM=ZOYLg@mail.gmail.com/
> [2] https://lore.kernel.org/all/20220104140414.155198-3-brauner@kernel.org/
> 
> Link: https://github.com/ceph/ceph/pull/52575
> Link: https://tracker.ceph.com/issues/62217
> Cc: Xiubo Li <xiubli@redhat.com>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: Ilya Dryomov <idryomov@gmail.com>
> Cc: ceph-devel@vger.kernel.org
> Co-Developed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> ---

I like the new extension,
Acked-by: Christian Brauner <brauner@kernel.org>
