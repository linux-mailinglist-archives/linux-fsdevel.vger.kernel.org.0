Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE82F52ADF8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 May 2022 00:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbiEQWUK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 May 2022 18:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiEQWUJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 May 2022 18:20:09 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695563C719;
        Tue, 17 May 2022 15:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YUsMCylN0zh8xJplquTMkjli5fF8AmheIudUgY6ptis=; b=O6t4fRjq0KN7eDopqIXl0NbsKe
        WqcgBXtLQn9rUHmkMpIKX/cYJxvWBiOSqkD+qJIUMfpCe6xo1G+mUMGSbXuG9hpuFypEvXpr3THHD
        2spEYAhkghuLewdADFku7kwhdY3U+I9koD8pLej++6ybMVT11E221rSo9OoSt0lLoDRlBxHCUYPrj
        fGmBfvwqBMv7n7tNLaG63gWJYYtYjp3ntnv03UPMeN3Uap2x0WiDPUMY27fuDgifjyOk8mdJN9fZH
        bubLM+AV+fGNVfLoIxI8Do6GATRyHwdAtZ8caYkVjMXIhemOP3HZz7b6MSjjDzHo9SzpNMgii3uV/
        OZqHU9Yw==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nr5Xy-00FqqD-Mi; Tue, 17 May 2022 22:20:06 +0000
Date:   Tue, 17 May 2022 22:20:06 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Daniil Lunev <dlunev@chromium.org>
Cc:     linux-fsdevel@vger.kernel.org, hch@infradead.org,
        fuse-devel@lists.sourceforge.net, tytso@mit.edu, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] FUSE: Retire superblock on force unmount
Message-ID: <YoQfls6hFcP3kCaH@zeniv-ca.linux.org.uk>
References: <20220511222910.635307-1-dlunev@chromium.org>
 <20220512082832.v2.2.I692165059274c30b59bed56940b54a573ccb46e4@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512082832.v2.2.I692165059274c30b59bed56940b54a573ccb46e4@changeid>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 12, 2022 at 08:29:10AM +1000, Daniil Lunev wrote:
> Force unmount of FUSE severes the connection with the user space, even
> if there are still open files. Subsequent remount tries to re-use the
> superblock held by the open files, which is meaningless in the FUSE case
> after disconnect - reused super block doesn't have userspace counterpart
> attached to it and is incapable of doing any IO.

	Why not simply have those simply rejected by fuse_test_super()?
Looks like that would be much smaller and less invasive patch...
Confused...
