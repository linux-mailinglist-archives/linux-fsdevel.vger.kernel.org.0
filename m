Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA882252E1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jul 2020 18:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgGSQ5v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jul 2020 12:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgGSQ5v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jul 2020 12:57:51 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01199C0619D2;
        Sun, 19 Jul 2020 09:57:50 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxCdG-00G0xu-6G; Sun, 19 Jul 2020 16:57:46 +0000
Date:   Sun, 19 Jul 2020 17:57:46 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Xu, Yanfei" <yanfei.xu@windriver.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] userfaultfd: avoid the duplicated release for
 userfaultfd_ctx
Message-ID: <20200719165746.GJ2786714@ZenIV.linux.org.uk>
References: <20200714161203.31879-1-yanfei.xu@windriver.com>
 <e3cbdb26-9bfb-55e7-c9a7-deb7f8831754@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3cbdb26-9bfb-55e7-c9a7-deb7f8831754@windriver.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 19, 2020 at 09:58:34PM +0800, Xu, Yanfei wrote:
> ping Al Viro
> 
> Could you please help to review this patch? Thanks a lot.

That's -next, right?  As for the patch itself...  Frankly,
Daniel's patch looks seriously wrong.
	* why has O_CLOEXEC been quietly smuggled in?  It's
a userland ABI change, for fsck sake...
	* the double-put you've spotted
	* the whole out: thing - just make it
	if (IS_ERR(file)) {
		userfaultfd_ctx_put(ctx);
		return PTR_ERR(file);
	}
	and be done with that.
