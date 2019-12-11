Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEB311AC3F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 14:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbfLKNka (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Dec 2019 08:40:30 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52272 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729694AbfLKNk3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Dec 2019 08:40:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TO/NQu43CwshSv+vhfJaELWZCqACamoqyzyHY52rGyI=; b=Hm5ukJbKRW/dIRfBb/2QNZWe2
        Vae7uQ8jSnwfWdaHao9+Puztkj99WQrJ7zQDtxi3TKPOo51rd+fWVnahFZcDzJMLSfqaeCVOxY8r8
        hSDFkS06G9RcE/1zSS+DssYsnx/A7E90d2pwJo7gUwe3HnBcGCaB6EInTzmXq7MjnqZrB6PQ9l80I
        7ew0MBvO3B1tKmL5VXVbKgHK2ypAVx9SJpNzWZYDva4N0EkaT4mjOj0OdxLfNDh2Hm0LJ+ExnAOxv
        /fglK8GQjc+Ilwz9wP2d/9ugBdBSYMjmgf/rR71BiJvLC/FiZ8ANkzJvpE2LyxvPeev4t3IujdjyX
        vbRr8RJTA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1if2Du-00050n-Qc; Wed, 11 Dec 2019 13:40:14 +0000
Date:   Wed, 11 Dec 2019 05:40:14 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        linux-fsdevel@vger.kernel.org, ecryptfs@vger.kernel.org,
        linux-fscrypt@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v5] fs: introduce is_dot_or_dotdot helper for cleanup
Message-ID: <20191211134014.GM32169@bombadil.infradead.org>
References: <1576030801-8609-1-git-send-email-yangtiezhu@loongson.cn>
 <20191211024858.GB732@sol.localdomain>
 <febbd7eb-5e53-6e7c-582d-5b224e441e37@loongson.cn>
 <20191211044723.GC4203@ZenIV.linux.org.uk>
 <4a90aaa9-18c8-f0a7-19e4-1c5bd5915a28@loongson.cn>
 <20191211071711.GA231266@architecture4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211071711.GA231266@architecture4>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 11, 2019 at 03:17:11PM +0800, Gao Xiang wrote:
> > static inline bool is_dot_or_dotdot(const unsigned char *name, size_t len)
> > {
> >         if (len >= 1 && unlikely(name[0] == '.')) {
> 
> 
> And I suggest drop "unlikely" here since files start with prefix
> '.' (plus specical ".", "..") are not as uncommon as you expected...

They absolutely are uncommon.  Even if you just consider
/home/willy/kernel/linux/.git/config, only one of those six path elements
starts with a '.'.
