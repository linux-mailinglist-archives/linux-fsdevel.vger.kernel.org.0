Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D32E3F87E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Aug 2021 14:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234420AbhHZMsg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Aug 2021 08:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbhHZMsf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Aug 2021 08:48:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6176BC061757
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Aug 2021 05:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cfsVs6nWykpEwKCk0uj5S7XpJ7tdNaq56WfJl8uUYrs=; b=GK9ZuNR1bgCkSw7B9UDBJMNb2u
        CJEzeuE5emXzrX36YTPBTqfnBkJtdiUChRTqXgr2/x4x+Obq4cu72xUNwDsgqgP27LVItJz/lVkhl
        WUFwgMfVGHDKVlrOSgImF82EiSxBO8yAN1tnLqXlicyl22J0WJP+gp7FxvbEB3QXyfTfw9PP6vZNh
        sklyzyFZ9LoxJG0ZcOEIVfdhgiQMKeSGkPz2Ezwu3wPwiA/iHY/bvq9ENTYRBCLq34GVVoS4P0BcQ
        12dgZgN3M/uJX7iltMaGCL0OQs8kNB7d+WGDl4JNAiCxs5AmkYsY5C6yCTMR/3lz5+jEbTxEVqrtr
        l4bM8BgQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mJEmM-00DIcr-1D; Thu, 26 Aug 2021 12:47:01 +0000
Date:   Thu, 26 Aug 2021 13:46:46 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Roberto Bergantinos Corpas <rbergant@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: parse sloppy mount option in correct order
Message-ID: <YSeNNnNBW7ceLuh+@casper.infradead.org>
References: <20210721113057.993344-1-rbergant@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721113057.993344-1-rbergant@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 21, 2021 at 01:30:57PM +0200, Roberto Bergantinos Corpas wrote:
> With addition of fs_context support, options string is parsed
> sequentially, if 'sloppy' option is not leftmost one, we may
> return ENOPARAM to userland if a non-valid option preceeds sloopy
> and mount will fail :
> 
> host# mount -o quota,sloppy 172.23.1.225:/share /mnt
> mount.nfs: an incorrect mount option was specified
> host# mount -o sloppy,quota 172.23.1.225:/share /mnt

It isn't clear to me that this is incorrect behaviour.  Perhaps the user
actually wants the options to the left parsed strictly and the options
to the right parsed sloppily?
