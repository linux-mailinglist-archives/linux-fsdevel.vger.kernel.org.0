Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A52CA1040DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 17:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbfKTQfE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 11:35:04 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56024 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728488AbfKTQfD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 11:35:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MwZWupiSwoX5j5mENHy05kP0FGbIABMO7rM4iqDs5RY=; b=XVaRzTwwOoq7hudzEGLuX9k3n
        uM8sKqABcsa6w1yOIAcJlYjbOhm3N9xRVOONrS+BpL1E0nNPub1CHPbYvikVjKVF83gA0PuNYW90Y
        SioU9d2DR5GrA7wyoMguCWYjO5/6syitDEizuzVYliU2Thx7a0C6SLwpdJhY10UccagysVb9omnwz
        EgVfA7yhE0AItWgroaFPYha37/r1VmuPhnuwTt1OPVbVF9Vn6mOL8/C3/lmzgmBYqYgmkDVSgWTtr
        tE19NKad8yT5hYqoCtU3VyIAku1adrSVcLcT2DFWopP6LkGUnj6r9/aMEfUewbKFuBVB4U1sm5VDw
        oZXksys3A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iXSwW-0006Zw-IG; Wed, 20 Nov 2019 16:35:00 +0000
Date:   Wed, 20 Nov 2019 08:35:00 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>, jack@suse.cz,
        tytso@mit.edu, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFCv3 2/4] ext4: Add ext4_ilock & ext4_iunlock API
Message-ID: <20191120163500.GT20752@bombadil.infradead.org>
References: <20191120050024.11161-1-riteshh@linux.ibm.com>
 <20191120050024.11161-3-riteshh@linux.ibm.com>
 <20191120112339.GB30486@bobrowski>
 <20191120121831.9639B42047@d06av24.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120121831.9639B42047@d06av24.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 20, 2019 at 05:48:30PM +0530, Ritesh Harjani wrote:
> Not against your suggestion here.
> But in kernel I do see a preference towards object followed by a verb.
> At least in vfs I see functions like inode_lock()/unlock().
> 
> Plus I would not deny that this naming is also inspired from
> xfs_ilock()/iunlock API names.

I see those names as being "classical Unix" heritage (eh, maybe SysV).

> hmm, it was increasing the name of the macro if I do it that way.
> But that's ok. Is below macro name better?
> 
> #define EXT4_INODE_IOLOCK_EXCL		(1 << 0)
> #define EXT4_INODE_IOLOCK_SHARED	(1 << 1)

In particular, Linux tends to prefer read/write instead of
shared/exclusive terminology.  rwlocks, rwsems, rcu_read_lock, seqlocks.
shared/exclusive is used by file locks.  And XFS ;-)

I agree with Jan; just leave them opencoded.

Probably worth adding inode_lock_downgrade() to fs.h instead of
accessing i_rwsem directly.
