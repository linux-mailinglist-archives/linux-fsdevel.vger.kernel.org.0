Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1384D15251D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2020 04:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgBEDI6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Feb 2020 22:08:58 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57974 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbgBEDI5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Feb 2020 22:08:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B9LDa0XPjCzIKceODg69dXaRY5vDVy2Yt+cLAsHZ2iE=; b=PQCpAoMYAzYAXkWKSEO3RGZF4s
        AK6ojSEAycRh8cHHpUbZtVb7KM0F/ojyKZAZKrn7EBESGSRqa/T6/DnaZMEFk+Y1TRw4fo+iTeEg/
        AiRolVywUugJMf867i8TU7jcgVi/Cb3WzTHOaxrEeDR25uQxgNtyA6p5vyxiL8MD6DY8cG7TxK6uL
        iYTl5wvvDyvzqdgU/6DCi8FDWVcB2GZC3kI49PLkwZ8adicSn4VdToOOVrMRIlc2qLaAjUYpsSaKa
        1Yjyvignnce2OK8Ng0b/D/7aWKtJlLdLoU3V4H/W5zdAN4SpOCZw0vuIVUWByWc/kHmlF7sCJKyA9
        r/sGtZ2g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1izB3V-0000ZM-OD; Wed, 05 Feb 2020 03:08:45 +0000
Date:   Tue, 4 Feb 2020 19:08:45 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: Make f2fs_readpages readable again
Message-ID: <20200205030845.GP8731@bombadil.infradead.org>
References: <20200201150807.17820-1-willy@infradead.org>
 <20200203033903.GB8731@bombadil.infradead.org>
 <bd08bf56-f901-33b1-5151-f77fd823e343@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd08bf56-f901-33b1-5151-f77fd823e343@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 05, 2020 at 09:58:29AM +0800, Chao Yu wrote:
> On 2020/2/3 11:39, Matthew Wilcox wrote:
> > 
> > Remove the horrendous ifdeffery by slipping an IS_ENABLED into
> > f2fs_compressed_file().
> 
> I'd like to suggest to use
> 
> if (IS_ENABLED(CONFIG_F2FS_FS_COMPRESSION) && f2fs_compressed_file(inode))
> 
> here to clean up f2fs_readpages' codes.
> 
> Otherwise, f2fs module w/o compression support will not recognize compressed
> file in most other cases if we add IS_ENABLED() condition into
> f2fs_compressed_file().

If we need to recognise them in order to deny access to them, then I
suppose we need two predicates.  Perhaps:

	f2fs_unsupported_attributes(inode)
and
	f2fs_compressed_file(inode)

where f2fs_unsupported_attributes can NACK any set flag (including those
which don't exist yet), eg encrypted.  That seems like a larger change
than I should be making, since I'm not really familiar with f2fs code.
