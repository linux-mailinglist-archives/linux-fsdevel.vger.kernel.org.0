Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6C0254513
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 14:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgH0MhO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 08:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729085AbgH0Me0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 08:34:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B203CC061264
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2020 05:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4TJCMywC/u0Jjft8iJm8hz2bTyeQ36xiar1IeZSVsz0=; b=AAfIu5fz/lgCQyjXPXcZdWlPkY
        jD02lsrSmjJXRsAWgTDs0bvTDr5IiqiMK7m5AB6+8abXXObVuJ195m5vvQi1Fu2pezxruBbjRUk4L
        Dh8aPrV57JSL87Tz6zmkSiXLIHEXUH6Ol82fXjqSCrdF+XCxoRE3lDCg2qoJGrcrNJXPQcto9M0Ec
        gvs44NnJQUL175WoeFVkH27iDynz5GKCroJUfdtPCuD1yHvNEyVWUMyIMyCLiZ/6i5fJ+S6tiezJq
        iiOMgJHIuAscGd53x+vwzkq99CQAx7XbwuTKWMmza349+DXcfFwbubXNu9qyw+w6Fkv8ZFEKtIG2V
        PmcvGiPA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBH6m-0002a0-Ek; Thu, 27 Aug 2020 12:34:24 +0000
Date:   Thu, 27 Aug 2020 13:34:24 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Pradeep P V K <ppvk@codeaurora.org>
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        stummala@codeaurora.org, sayalil@codeaurora.org
Subject: Re: [PATCH V2] fuse: Fix VM_BUG_ON_PAGE issue while accessing zero
 ref count page
Message-ID: <20200827123424.GF14765@casper.infradead.org>
References: <1598452035-3472-1-git-send-email-ppvk@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598452035-3472-1-git-send-email-ppvk@codeaurora.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 26, 2020 at 07:57:15PM +0530, Pradeep P V K wrote:
> Fix this by protecting fuse_copy_pages() with fc->lock.

No.  This is a spinlock and fuse_copy_pages() can allocate memory
with GFP_KERNEL.  You need to enable more debugging on your test
system.

