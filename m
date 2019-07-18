Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2101F6CE23
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2019 14:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390212AbfGRMdN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jul 2019 08:33:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50748 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbfGRMdM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jul 2019 08:33:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=x53+CV+Y72wm5tbY2pxzl4o53xkAeZpkDnqiP+1WEK0=; b=Ns5qduh9GU6cWPoWdOXnbjUcj
        Emn/JMPLVHaGDz4e1jvlQ/3Rc5tk6DOGxAgZs0OyPeS4CHqzQf0tj2G2h+ep5vrr2xearP8OxVeXY
        t0Ld3kXIInZFAjb1TTXGS/QrspPYhqx4jUlat22QoItM0GYBghYu9pkQ+Y1wS7mR7CY77iSoJUj8Y
        UbHR9vIBxytQr8+ChTb0z7NiT1My3T0BBhcB3j+Q6QNz1fQWG02I7ONe4YsXsT4d/oD8CJsYCPjSL
        p9HUbLg/PZMz6zCLDB0jqvsoYhH4+BIZs57sYfEai0PAWntszOP7shPwWyra6xHcra57yADt/2PET
        ADm3typQA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1ho5av-0000Qz-FN; Thu, 18 Jul 2019 12:33:09 +0000
Date:   Thu, 18 Jul 2019 05:33:09 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Chao Yu <yuchao0@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Gao Xiang <gaoxiang25@huawei.com>, chao@kernel.org
Subject: Re: [RFC PATCH] iomap: generalize IOMAP_INLINE to cover tail-packing
 case
Message-ID: <20190718123309.GB21252@infradead.org>
References: <20190703075502.79782-1-yuchao0@huawei.com>
 <CAHpGcM+s77hKMXo=66nWNF7YKa3qhLY9bZrdb4-Lkspyg2CCDw@mail.gmail.com>
 <39944e50-5888-f900-1954-91be2b12ea5b@huawei.com>
 <20190711122831.3970-1-agruenba@redhat.com>
 <cb41acf2-f222-102a-d31b-02243c77996c@huawei.com>
 <CAHc6FU5tBXeJ6xzZzfCQeaQFy-NZ5ryZ+QMGLu7yxcGXwYisNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU5tBXeJ6xzZzfCQeaQFy-NZ5ryZ+QMGLu7yxcGXwYisNw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 12, 2019 at 01:54:07PM +0200, Andreas Gruenbacher wrote:
> Yes, probably by returning i_blocksize(inode) after
> iomap_read_inline_data, but that alone isn't enough to make the patch
> work completely. This really needs a review from Christoph and careful
> testing of all the code paths.

Well, lets start with the testing.  Can we get a coherent series that
includes the erofs bits?
