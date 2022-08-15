Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6780F592BE4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Aug 2022 12:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbiHOKAz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Aug 2022 06:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbiHOKAx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Aug 2022 06:00:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6115596;
        Mon, 15 Aug 2022 03:00:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27F6E60D3A;
        Mon, 15 Aug 2022 10:00:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08702C433C1;
        Mon, 15 Aug 2022 10:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660557651;
        bh=9ZRWMUIwm/t3sHqvInJijL0j9kWxqZeofrlGARqlGOI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B6dKWE0dIWxc13kXUMjjXH3tmnScnyXC1ZUz6+8T2d8reqh+qAY3pY7InfREVAUlW
         JbgsjKSEgRaDi88LjlUeMJbC97GtFcOtTU5JG1ldDARvMRS9DHVGmgLDCybG/7+YpA
         Ey15Ot5/+E6Ec7RGLMfGevl3sK+Ph3MQSexZ2RDLRHU5iYyN1tYqeyWL++lz+AloLd
         K+ab9n6Lqf0oNFEL73GvPCRqrKnIr5M5ua37QpIysvP4wutD3cKMgTitQ/n3FB0zRI
         TXkeRVqYn84ZKjFoPceVbOAnxPSiS5JULMYdGpLgdAQ+2BTd6YfZxbjr/86NYTFPTG
         u2TXeFxBk75ow==
Date:   Mon, 15 Aug 2022 12:00:44 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Stefan Roesch <shr@fb.com>, Christoph Hellwig <hch@lst.de>,
        Jan Kara <jack@suse.cz>
Cc:     Stefan Roesch <shr@fb.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, lkp@lists.01.org, lkp@intel.com,
        ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [fs]  faf99b5635:  will-it-scale.per_thread_ops -9.0% regression
Message-ID: <20220815100044.7j2u2yjlkanhkrfg@wittgenstein>
References: <YvnMWbRDhM0fH4E/@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YvnMWbRDhM0fH4E/@xsang-OptiPlex-9020>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 15, 2022 at 12:32:25PM +0800, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed a -9.0% regression of will-it-scale.per_thread_ops due to commit:
> 
> 
> commit: faf99b563558f74188b7ca34faae1c1da49a7261 ("fs: add __remove_file_privs() with flags parameter")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

This seems overall pretty odd tbh at least it's not immediately obvious
how that specific commit would've caused this. But fwiw, I think there's
one issue in this change which we originally overlooked which might
explain this.

Before faf99b563558 ("fs: add __remove_file_privs() with flags
parameter") inode_has_no_xattr() was called when
dentry_needs_remove_privs() returned 0.

	int error = 0
	[...]
	kill = dentry_needs_remove_privs(dentry);
	if (kill < 0)
		return kill;
	if (kill)
		error = __remove_privs(file_mnt_user_ns(file), dentry, kill);
	if (!error)
		inode_has_no_xattr(inode);

but now we do:

	kill = dentry_needs_remove_privs(dentry);
	if (kill <= 0)
		return kill;

which means we don't call inode_has_no_xattr(). I don't think that we
did this intentionally. inode_has_no_xattr() just sets S_NOSEC which
means next time we call into __file_remove_privs() we can return earlier
instead of hitting dentry_needs_remove_privs() again:

if (IS_NOSEC(inode) || !S_ISREG(inode->i_mode))
	return 0;

So I think that needs to be fixed?

Christian
