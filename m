Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83DE74C2203
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 04:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbiBXDAs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 22:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiBXDAr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 22:00:47 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5B617584A;
        Wed, 23 Feb 2022 19:00:14 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nN4MW-004RC0-Bt; Thu, 24 Feb 2022 03:00:12 +0000
Date:   Thu, 24 Feb 2022 03:00:12 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Yun Levi <ppbuk5246@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, ebiederm@xmission.com,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs/exec.c: Avoid a race in formats
Message-ID: <Yhb0vB/G2a92zJJP@zeniv-ca.linux.org.uk>
References: <20220223231752.52241-1-ppbuk5246@gmail.com>
 <YhbCGDzlTWp2OJzI@zeniv-ca.linux.org.uk>
 <CAM7-yPTM6FNuT4vs2EuKAKitTWMTHw_XzKVggxQJzn5hqbBHpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM7-yPTM6FNuT4vs2EuKAKitTWMTHw_XzKVggxQJzn5hqbBHpw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 24, 2022 at 08:59:59AM +0900, Yun Levi wrote:

> I think if someone wants to control their own binfmt via "ioctl" not
> on time on LOAD.
> For example, someone wants to control exec (notification,
> allow/disallow and etc..)
> and want to enable and disable own's control exec via binfmt reg / unreg
> In that situation, While the module is loaded, binfmt is still live
> and can be reused by
> reg/unreg to enable/disable his exec' control.

Er...  So have your ->load_binary() start with
	if (I_want_it_disabled)
		return -ENOEXEC;
and be done with that.

The only caller of that thing is
        list_for_each_entry(fmt, &formats, lh) {
		if (!try_module_get(fmt->module))
			continue;
		read_unlock(&binfmt_lock);

		retval = fmt->load_binary(bprm);

		read_lock(&binfmt_lock);
		put_binfmt(fmt);
		if (bprm->point_of_no_return || (retval != -ENOEXEC)) {
			read_unlock(&binfmt_lock);
			return retval;
		}
	}
so returning -ENOEXEC is equivalent to not having it in the list.
IDGI...  Why bother unregistering/re-registering/etc.?
