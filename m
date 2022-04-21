Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD38509A98
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 10:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386596AbiDUIVu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 04:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381397AbiDUIVt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:21:49 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB335FB4;
        Thu, 21 Apr 2022 01:19:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 70C37CE2063;
        Thu, 21 Apr 2022 08:18:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE793C385A5;
        Thu, 21 Apr 2022 08:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650529137;
        bh=VdNxwP7aYb9VyqZ4005iAR+M48UJLLNuBcEHx/YnJFk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZwYjVQZWJE7QIsnWmuXKJo26AayUTAiBBuKB1A9B5MJBO1ebGmNdDGM5ZGHxiEEst
         XbPj4cjOytRxpbLUnQzv6++BSurRoWbe2MR+MBW0NF+KNKprEAEC76xNoa5Di6VAut
         JJWY45UmTSmxaxn6GG9nR8SYmBne4hKPXKjsvFiUj63qJwxwHcpnveTW/Iup62jS0H
         JVEgsZNJhbPafhwvQxKvLtFtzb6e0kiUFiNZuFxBl6frEXUlPWUUsdBDWNFrU1GBLh
         Bl/2uPwCskMEggygo+U3qnLppeiKA/PCpNcaNMEl0pua7VrGr31XfgMBdc40Va2cnl
         zQKRTUt6m38zw==
Date:   Thu, 21 Apr 2022 10:18:52 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        viro@zeniv.linux.org.uk, david@fromorbit.com, djwong@kernel.org,
        willy@infradead.org, jlayton@kernel.org
Subject: Re: [PATCH v5 4/4] ceph: Remove S_ISGID clear code in
 ceph_finish_async_create
Message-ID: <20220421081852.rrmj2log3fln22lp@wittgenstein>
References: <1650527658-2218-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1650527658-2218-4-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1650527658-2218-4-git-send-email-xuyang2018.jy@fujitsu.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 21, 2022 at 03:54:18PM +0800, Yang Xu wrote:
> Since vfs has stripped S_ISGID in the previous patch, the calltrace
> as below:
> 
> vfs:	lookup_open
> 	...
> 	  if (open_flag & O_CREAT) {
>                 if (open_flag & O_EXCL)
>                         open_flag &= ~O_TRUNC;
>                 mode = prepare_mode(mnt_userns, dir->d_inode, mode);
> 	...
> 	   dir_inode->i_op->atomic_open
> 
> ceph:	ceph_atomic_open
> 	...
> 	      if (flags & O_CREAT)
>             		ceph_finish_async_create
> 
> We have stripped sgid in prepare_mode, so remove this useless clear
> code directly.

I'd replace this with:

"Previous patches moved sgid stripping exclusively into the vfs. So
manual sgid stripping by the filesystem isn't needed anymore."

> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---

Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
