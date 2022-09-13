Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4C55B6554
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Sep 2022 04:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiIMCEW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 22:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiIMCEV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 22:04:21 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F21A2559A
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Sep 2022 19:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pGO9ACnu1/d/2OR9uQh71DwTQ917A/iyN6gcECJkv08=; b=NCHDy8Lns5kxsJAwAcvtqYgnMn
        8aDLayDrv+zayXkPquK0DqlUVB2iaB8NUZWz4J9HaSDg7ugFnfJiuyp5g3syGztJUbcPzKXwlSp4d
        aUPBAoJ2dHylaGxPmY4+ybaFy795rF5h1iCzbSNlD8dUCuyimpihx4eSFNyJvkjrNAsIkT0hmR2Kh
        U4Dt5N+r5rm3s8N6awgMTUqqduJ0AbO3JbYVjDVoCfLqq8fYGKQB910hvBig64aRxUbYDIiExFHtH
        LMVZKyMEeIYQ9iz30HGLaZCFzhP7YgbVW+LeLp08jj1ImDdVD3iVArj4rbCmwoaRSiMZ4JMnvH++I
        JTEaNqwQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oXvHd-00FhCP-1x;
        Tue, 13 Sep 2022 02:04:17 +0000
Date:   Tue, 13 Sep 2022 03:04:17 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     Xavier Roche <xavier.roche@algolia.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] vfs: fix link vs. rename race
Message-ID: <Yx/lIWoLCWHwM6DO@ZenIV>
References: <20220221082002.508392-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221082002.508392-1-mszeredi@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 21, 2022 at 09:20:02AM +0100, Miklos Szeredi wrote:

[digging through the old piles of mail]

Eyes-watering control flow in do_linkat() aside (it's bound to rot; too
much of it won't get any regression testing and it's convoluted enough
to break easily), the main problem I have with that is the DoS potential.

You have a system-wide lock, and if it's stuck you'll get every damn
rename(2) stuck as well.  Sure, having it taken only upon the race
with rename() (or unlink(), for that matter) make it harder to get
stuck with lock held, but that'll make the problem harder to reproduce
and debug...
