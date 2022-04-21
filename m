Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F08509AD2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 10:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386759AbiDUIkF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 04:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386750AbiDUIjl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:39:41 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A273890;
        Thu, 21 Apr 2022 01:36:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 05164CE2156;
        Thu, 21 Apr 2022 08:36:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B6BC385A5;
        Thu, 21 Apr 2022 08:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650530209;
        bh=DgIpTRUz3aTs8B7+zg6ZlAUylyg4ZKn2RJmN1t6ecgg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FEd6/BoXKhVfHShY9OucHDiLBrSFQWP3B37jLfvDLhcV6zGNusUDtuYUqX3EXcYOB
         8iIsGGlwaT/pO+y7WQgbFpvwPw/XphoLSl1uIKFo3FkLse+ZgDabTnkcZaR/MOLS0w
         kkkCtIpiCv/qaQlgBQnr81/R+heGEfTapbVKkLyVhuOVEW1bRzb+yUR1Sx/wkzgAMn
         nPy/wL24NFJubxhrjEZhW89nTyZfO7MRxbSs3YrjnLI94dtBataBWP3b8VhMmGBPZC
         JNmEFtrX/Xd0w4VURFz3FcTxvO5BnuwLlnfoeLu2Q12bx8Wtfq7AQEGsumxCevPCmm
         1PaZK+pM02qIw==
Date:   Thu, 21 Apr 2022 10:36:43 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [PATCH v5 4/4] ceph: Remove S_ISGID clear code in
 ceph_finish_async_create
Message-ID: <20220421083643.yzdcberj3azuj2ep@wittgenstein>
References: <1650527658-2218-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1650527658-2218-4-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220421081852.rrmj2log3fln22lp@wittgenstein>
 <626123F9.8070004@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <626123F9.8070004@fujitsu.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 21, 2022 at 08:28:12AM +0000, xuyang2018.jy@fujitsu.com wrote:
> on 2022/4/21 16:18, Christian Brauner wrote:
> > On Thu, Apr 21, 2022 at 03:54:18PM +0800, Yang Xu wrote:
> >> Since vfs has stripped S_ISGID in the previous patch, the calltrace
> >> as below:
> >>
> >> vfs:	lookup_open
> >> 	...
> >> 	  if (open_flag&  O_CREAT) {
> >>                  if (open_flag&  O_EXCL)
> >>                          open_flag&= ~O_TRUNC;
> >>                  mode = prepare_mode(mnt_userns, dir->d_inode, mode);
> >> 	...
> >> 	   dir_inode->i_op->atomic_open
> >>
> >> ceph:	ceph_atomic_open
> >> 	...
> >> 	      if (flags&  O_CREAT)
> >>              		ceph_finish_async_create
> >>
> >> We have stripped sgid in prepare_mode, so remove this useless clear
> >> code directly.
> >
> > I'd replace this with:
> >
> > "Previous patches moved sgid stripping exclusively into the vfs. So
> > manual sgid stripping by the filesystem isn't needed anymore."
> Looks more clear, so should I drop the above calltrace?

Imho, yes.
