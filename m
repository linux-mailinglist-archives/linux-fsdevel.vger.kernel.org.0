Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 565425707F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2019 20:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfFZSVo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jun 2019 14:21:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:35988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbfFZSVm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jun 2019 14:21:42 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07DA221726;
        Wed, 26 Jun 2019 18:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561573301;
        bh=pNDy9ibt9Htg2aMIkROB6dLLyxI5mmHvZKejgIZn7Oc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TuI1lc8jAO4MB0RfvPP/3xjShwRJ5zX3E3hM3QnXjDNiYK2hkpbKcuEqrrq4t9f3Y
         HFbcTFROptxFb6vvrHInrM7dcrlL86yIu0vDiQ9n7kCmvyRn/xKjMfwDx6VqIJcthL
         KS8lIu7/J75DGlTa501xa6kZdnbnaUIMVJWVth/M=
Date:   Wed, 26 Jun 2019 11:21:39 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Victor Hsieh <victorhsieh@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v5 16/16] f2fs: add fs-verity support
Message-ID: <20190626182138.GA30296@gmail.com>
References: <20190620205043.64350-1-ebiggers@kernel.org>
 <20190620205043.64350-17-ebiggers@kernel.org>
 <90495fb1-72eb-ca42-8457-ef8e969eda51@huawei.com>
 <20190625175225.GC81914@gmail.com>
 <68c5a15f-f6a8-75e2-b485-0f1b51471995@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68c5a15f-f6a8-75e2-b485-0f1b51471995@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 26, 2019 at 03:34:35PM +0800, Chao Yu wrote:
> >>> +	err = f2fs_convert_inline_inode(inode);
> >>> +	if (err)
> >>> +		return err;
> >>> +
> >>> +	err = dquot_initialize(inode);
> >>> +	if (err)
> >>> +		return err;
> >>
> >> We can get rid of dquot_initialize() here, since f2fs_file_open() ->
> >> dquot_file_open() should has initialized quota entry previously, right?
> > 
> > We still need it because dquot_file_open() only calls dquot_initialize() if the
> > file is being opened for writing.  But here the file descriptor is readonly.
> > I'll add a comment explaining this here and in the ext4 equivalent.
> 
> Ah, you're right.
> 
> f2fs_convert_inline_inode() may grab one more block during conversion, so we
> need to call dquot_initialize() before inline conversion?
> 
> Thanks,
> 

Good point.  I'll fix that here and in ext4.

- Eric
