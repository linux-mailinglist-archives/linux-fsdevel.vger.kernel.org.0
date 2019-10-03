Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F606C9579
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2019 02:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbfJCAR3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Oct 2019 20:17:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55356 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbfJCAR2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Oct 2019 20:17:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=r/4tKD7Z80pSB1NpFz6ktZvS4AeDOiTyO5tnMVQxFzE=; b=AwsNENxfH6r20XNC5bvoj5r3b
        Y5AcfJMCXynID6UqP63WtmwV90T30fCdSabszN+9PUzwbZlH6/aZpUgka37ESsDymXtIYznDYj2/f
        mKjK3MkNDZSaiycOyt1fLLeENAHMNxAYdstuQhaZBeIWEBfUc4yQyZcsJ2viXZoqvTLOsFPzHvwhS
        RIzhjBR+CaGRwKmDp5jy8aTrhLfIG8eJAWGRVaBud6KPAcNQV8Lmj7PBtssntdwL7b2WdnRl3xzoY
        2IWiVRKjrnMVlbr6UF3rzm2ox6m2chzLsEfACyMcPqVTdsLa+6Bp1B7HPAdQw/blBxXARYyBb2q05
        3lNnwPLwQ==;
Received: from [2601:1c0:6280:3f0::9a1f]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iFooC-0002SA-Bn; Thu, 03 Oct 2019 00:17:28 +0000
To:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: fs/nfsd/nfs4state.c use of "\%s"
Message-ID: <b76bde04-7970-c870-5af7-359141958c4f@infradead.org>
Date:   Wed, 2 Oct 2019 17:17:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Bruce,

In commit 78599c42ae3c70300a38b0d1271a85bc9f2d704a
(nfsd4: add file to display list of client's opens), some of the %s printk
specifiers are \-escaped:

+       seq_printf(s, "access: \%s\%s, ",
+               access & NFS4_SHARE_ACCESS_READ ? "r" : "-",
+               access & NFS4_SHARE_ACCESS_WRITE ? "w" : "-");
+       seq_printf(s, "deny: \%s\%s, ",
+               deny & NFS4_SHARE_ACCESS_READ ? "r" : "-",
+               deny & NFS4_SHARE_ACCESS_WRITE ? "w" : "-");


sparse complains about these, as does gcc when used with --pedantic.
sparse says:

../fs/nfsd/nfs4state.c:2385:23: warning: unknown escape sequence: '\%'
../fs/nfsd/nfs4state.c:2385:23: warning: unknown escape sequence: '\%'
../fs/nfsd/nfs4state.c:2388:23: warning: unknown escape sequence: '\%'
../fs/nfsd/nfs4state.c:2388:23: warning: unknown escape sequence: '\%'

Is this just a typo?

Please just fix it.

thanks,
-- 
~Randy
