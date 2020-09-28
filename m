Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7949F27B442
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Sep 2020 20:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgI1SRj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Sep 2020 14:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgI1SRi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Sep 2020 14:17:38 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986CDC061755;
        Mon, 28 Sep 2020 11:17:38 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kMxiP-0088R7-38; Mon, 28 Sep 2020 18:17:33 +0000
Date:   Mon, 28 Sep 2020 19:17:33 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     David Laight <David.Laight@aculab.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Mount options may be silently discarded
Message-ID: <20200928181733.GC3421308@ZenIV.linux.org.uk>
References: <CACE9dm_eypZ4wn8PpYYCYNuM501_M-8pH7by=U-6hOmJCwuxig@mail.gmail.com>
 <87bb66c2a7f94bd1ab768a8160e48e39@AcuMS.aculab.com>
 <CACE9dm8CPAFSY53Bm+vJvmh2m=Nm0FDe1mCtrwFAQnDE1p-XVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACE9dm8CPAFSY53Bm+vJvmh2m=Nm0FDe1mCtrwFAQnDE1p-XVw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 28, 2020 at 09:00:54PM +0300, Dmitry Kasatkin wrote:

> But why "we" should allow "discarding" failed part instead of failing
> with EFAULT as a whole?

Because there might very well be absolutely legitimate users of mount(2)
passing it something smaller than 4Kb immediately followed by an unmapped
area.

What can mount(2) do?  It can't go up to the first \0 and stop there,
thanks to filesystems (NFS) that want to get struct some_shite filled
by userland.  It can't require the entire 4Kb from the pointer passed
to mount(2) to be mapped and readable, simply because passing it
a string literal for e.g. ext4 mount can violate that requirement,
not to mention the result of strdup(3)/asprintf(3)/etc.

And it can't even tell which semantics to use by looking at the
filesystem type - NFS allows both the string and binary structure for
options.
