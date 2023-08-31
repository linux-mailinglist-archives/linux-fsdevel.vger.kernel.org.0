Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B64678EE33
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 15:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241865AbjHaNLs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 09:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbjHaNLr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 09:11:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5F6BC;
        Thu, 31 Aug 2023 06:11:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD66862864;
        Thu, 31 Aug 2023 13:11:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0759DC433C8;
        Thu, 31 Aug 2023 13:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693487504;
        bh=Y6uyv+2gganhTBJ0ddzhZT+tYtsq/iQAhfWTVlRR5X4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QrhIPV6nhA8C0cBtaG8x1Ez6psDK7/WNTpaCWMTpRKieQmxK8Jb7n0dAjRdpKsQEX
         GJmQbySkF/Am6vVdASEQk8szF8LjOB5NM4fOSdppzXidCJq7gcOS3ZFpa1CfGgk8i+
         gWXcmyAp1f+iHAc/J3XjWmMDy3ip7tZNzeGpcLoanosam2N7FstZzJ1ZULpFR7QNb5
         58WuIOy0b3WfTqEuKfs6HLxsokl/pAS0yXVzlSLIoZgw8fGGdvKYqCwVcUCZHaDsRX
         n098azRGbZE+i9JwMuQmfa8zNtGKktKqc+IFumGb897lEAowKkvu5+XQFSnVV3xnhz
         dffTTPl0+bJzA==
Date:   Thu, 31 Aug 2023 15:11:39 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: sb->s_fs_info freeing fixes
Message-ID: <20230831-wohlig-lehrveranstaltung-7c27e05dc9ae@brauner>
References: <20230831053157.256319-1-hch@lst.de>
 <20230831-dazulernen-gepflanzt-8a64056bf362@brauner>
 <20230831-tiefbau-freuden-3e8225acc81d@brauner>
 <20230831123619.GB11156@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230831123619.GB11156@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > If that is good enough for people then I can grab it.
> 
> Fine with me.  And yes, I'd rather not have private data freed before
> SB_ACTIVE is cleared even if it is fine right now.  It's just a bug
> waiting to happen.

Applied to the vfs.super branch of the vfs/vfs.git tree.
Patches in the vfs.super branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.super

[1/4] ramfs: free sb->s_fs_info after shutting down the super block
      https://git.kernel.org/vfs/vfs/c/c5725dff056d
[2/4] devpts: free sb->s_fs_info after shutting down the super block
      https://git.kernel.org/vfs/vfs/c/fee7516be512
[3/4] selinuxfs: free sb->s_fs_info after shutting down the super block
      https://git.kernel.org/vfs/vfs/c/3105b94e7d62
[4/4] hypfs: free sb->s_fs_info after shutting down the super block
      https://git.kernel.org/vfs/vfs/c/993d214eb394
