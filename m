Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C623A10FF6E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 14:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfLCN5j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 08:57:39 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58434 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbfLCN5J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 08:57:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pGZjUh8ellhVGI9ssg4DQAJRtWM/oSsrAhWz58uDLYE=; b=K+oWswS7BbZQhmXrTzt62YVxf
        mKNwgluw/QFfsuhI2q2SwT2RGIfB+UDz+XkbodHVayXzf4yZ7U49NGvpJETvrCpbzXtFKKe0ncN5F
        z6psPTwUdiyKtaWK2e1noIWYD+8MPgF0q5TJg5ftlWJ0jKgOyoxoykYbaP8J2zz7psj19Eh4snUbU
        hfs/OXm9cR1EtryubmeT6YOH4/24FbG8gPGIVAQnIfvxnFFjfFQFRCnUIHBOMbBk35mty6yv3ZH+w
        p1QwiAlusOVQVbSUVFmbnmZjsqCs/12YIeIKqZgxSOg3M5PdmftpMCXuZBdzfMwupQO1aGNv04Zcz
        c0SdgoDgw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ic8fb-0005Ec-5g; Tue, 03 Dec 2019 13:56:51 +0000
Date:   Tue, 3 Dec 2019 05:56:51 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Tyler Hicks <tyhicks@canonical.com>,
        linux-fsdevel@vger.kernel.org, ecryptfs@vger.kernel.org,
        linux-fscrypt@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs: introduce is_dot_dotdot helper for cleanup
Message-ID: <20191203135651.GU20752@bombadil.infradead.org>
References: <1575377810-3574-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575377810-3574-1-git-send-email-yangtiezhu@loongson.cn>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 03, 2019 at 08:56:50PM +0800, Tiezhu Yang wrote:
> There exists many similar and duplicate codes to check "." and "..",
> so introduce is_dot_dotdot helper to make the code more clean.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
> 
> v2:
>   - use the better performance implementation of is_dot_dotdot
>   - make it static inline and move it to include/linux/fs.h

Ugh, not more crap in fs.h.

$ ls -l --sort=size include/linux |head
-rw-r--r--  1 willy willy 154148 Nov 29 22:35 netdevice.h
-rw-r--r--  1 willy willy 130488 Nov 29 22:35 skbuff.h
-rw-r--r--  1 willy willy 123540 Nov 29 22:35 pci_ids.h
-rw-r--r--  1 willy willy 118991 Nov 29 22:35 fs.h

I think this probably fits well in namei.h.  And I think it works
better with bare 'name' and 'len' arguments, rather than taking a qstr.

And, as I asked twice in the last round of review, did you benchmark
this change?
