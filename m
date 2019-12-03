Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF1E10F527
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 03:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfLCCrM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Dec 2019 21:47:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41538 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfLCCrK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Dec 2019 21:47:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZcADr+fqCjkrKggMHp7c9VH2W4nKJ3vIQ/9FqtJ6+po=; b=ZKQ9aFJ8e7Bhuk3ldud6Rv7p/
        Je8/Oq4ghvtMDdZ8xuWLgrVCOvrGyDituzDk4crgA+cEk4nin2pU4fg8ut/8BbnezXZ6fW1zs4puf
        /NEQvnTLJjDVL6Ne/aiKA2DvBXW7SGEVg45+6RXCl/tkSRT2ggQfv9XtCwMTjM4HgP0RHeMLXzfaZ
        ILM/mwJWbX0+PMA+ItQzDIs6Fqmba7YXOgvaGwWfO7qJ1qR0yYQSrlf1tldOt/v/ylTnZztvmEbhf
        IuVdNzza1Der/TDr1frVSMfl/TZhKmijCNYX8JpZOXLykJreuOp23+d5Rg82kK6DIuCCRwCEEXOry
        J95N0jq/A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ibyDB-0006M1-QQ; Tue, 03 Dec 2019 02:46:49 +0000
Date:   Mon, 2 Dec 2019 18:46:49 -0800
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
Subject: Re: [PATCH] fs: introduce is_dot_dotdot helper for cleanup
Message-ID: <20191203024649.GQ20752@bombadil.infradead.org>
References: <1575281413-6753-1-git-send-email-yangtiezhu@loongson.cn>
 <20191202200302.GN20752@bombadil.infradead.org>
 <357ad021-a58c-ad46-42bd-d5012126276f@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <357ad021-a58c-ad46-42bd-d5012126276f@loongson.cn>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 03, 2019 at 10:07:41AM +0800, Tiezhu Yang wrote:
> On 12/03/2019 04:03 AM, Matthew Wilcox wrote:
> > On Mon, Dec 02, 2019 at 06:10:13PM +0800, Tiezhu Yang wrote:
> > > There exists many similar and duplicate codes to check "." and "..",
> > > so introduce is_dot_dotdot helper to make the code more clean.
> > The idea is good.  The implementation is, I'm afraid, badly chosen.
> > Did you benchmark this change at all?  In general, you should prefer the
> 
> Thanks for your reply and suggestion. I measured the
> performance with the test program, the following
> implementation is better for various of test cases:
> 
> bool is_dot_dotdot(const struct qstr *str)
> {
>         if (unlikely(str->name[0] == '.')) {
>                 if (str->len < 2 || (str->len == 2 && str->name[1] == '.'))
>                         return true;
>         }
> 
>         return false;
> }
> 
> I will send a v2 patch used with this implementation.

Well, hang on.  If you haven't done any benchmarking, please do so
before sending a v2.  In particular, you've now moved this to being a
function call.  That might slow things down, or it might speed things up.
I also don't know if passing a qstr is going to be the right API --
let's hear from the filesystems affected by the API change that they're
OK with this change.
