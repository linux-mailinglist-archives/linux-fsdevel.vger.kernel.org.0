Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F66A5B2D1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 03:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfGABxE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jun 2019 21:53:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48272 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfGABxE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jun 2019 21:53:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IQmkMM1JbQkMUOFEWKJh4CCDHgZMSq3hfCbzhlKCSW4=; b=BTeeKCOp1glaz1TGfF4D62nKbk
        GaK3XIxiIoXRgypewASRQCNFnxVg+PKkAK+Lp2Uq5LlDQbZB4bWkTzfqfA4nrC7D+odleGrAB3zv4
        UA+ugWTV7mP4Z1yu/sRgAkiMyc3y+oN1IFQvzbsSPw4DOZcNY6GnIaD2qkrX/DrHtEK3wzmq8lZeU
        PbTEmyIX9RLBGh4En7CJ0YXs5GV5Yd52POdR8CKtsujHzg3QeZgp8R2kTTKif0CiisirADf0QwNL6
        RE14Rd5AL8TETbJHUSjZQc3uZ8LrHz0B+RJP59r/iJZbfgVa4C06y+zfzCc3mzJxbPNg0HXg1deKe
        XYiNfBTg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hhlV3-0004Zm-9A; Mon, 01 Jul 2019 01:52:57 +0000
Date:   Sun, 30 Jun 2019 18:52:57 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     "zhengbin (A)" <zhengbin13@huawei.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        houtao1@huawei.com, yi.zhang@huawei.com, rui.xiang@huawei.com
Subject: Re: [PATCH] fs: change last_ino type to unsigned long
Message-ID: <20190701015257.GA18754@bombadil.infradead.org>
References: <1561811293-75769-1-git-send-email-zhengbin13@huawei.com>
 <20190629142101.GA1180@bombadil.infradead.org>
 <b8edc95d-0073-ab0f-27f2-3aee3a728d00@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b8edc95d-0073-ab0f-27f2-3aee3a728d00@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 01, 2019 at 09:48:03AM +0800, zhengbin (A) wrote:
> 
> On 2019/6/29 22:21, Matthew Wilcox wrote:
> > On Sat, Jun 29, 2019 at 08:28:13PM +0800, zhengbin wrote:
> >> tmpfs use get_next_ino to get inode number, if last_ino wraps,
> >> there will be files share the same inode number. Change last_ino
> >> type to unsigned long.
> > Is this a serious problem?
> 
> Yes, if two files share the same inode number, when application uses dlopen to get
> 
> file handle,  there will be problems.

That wasn't what I meant.  Does it happen in practice?  Have you observed
it, or are you just worrying about a potential problem?

> Maybe we could use iunique to try to get a unique i_ino value(when we allocate new inode,
> 
> we need to add it to the hashtable), the questions are:
> 
> 1. inode creation will be slow down, as the comment of function  iunique says:
> 
>  *    BUGS:
>  *    With a large number of inodes live on the file system this function
>  *    currently becomes quite slow.
> 
> 2. we need to convert all callers of  get_next_ino to use iunique (tmpfs, autofs, configfs...),
> 
> moreover, the more callers are converted, the function of iunique will be more slower.
> 
> 
> Looking forward to your reply, thanks.

> > I'd be more convinced by a patch to use
> > the sbitmap data structure than a blind conversion to use atomic64_t.

You ignored this sentence.
