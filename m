Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B611C119F1A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 00:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfLJXKZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 18:10:25 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:48608 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfLJXKY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 18:10:24 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ieodt-00083G-9G; Tue, 10 Dec 2019 23:10:09 +0000
Date:   Tue, 10 Dec 2019 23:10:09 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        linux-fsdevel@vger.kernel.org, ecryptfs@vger.kernel.org,
        linux-fscrypt@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] fs: introduce is_dot_or_dotdot helper for cleanup
Message-ID: <20191210231009.GB4203@ZenIV.linux.org.uk>
References: <1575979801-32569-1-git-send-email-yangtiezhu@loongson.cn>
 <20191210191912.GA99557@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210191912.GA99557@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 10, 2019 at 11:19:13AM -0800, Eric Biggers wrote:

> > +static inline bool is_dot_or_dotdot(const unsigned char *name, size_t len)
> > +{
> > +	if (unlikely(name[0] == '.')) {
> > +		if (len < 2 || (len == 2 && name[1] == '.'))
> > +			return true;
> > +	}
> > +
> > +	return false;
> > +}
> 
> This doesn't handle the len=0 case.  Did you check that none of the users pass
> in zero-length names?  It looks like fscrypt_fname_disk_to_usr() can, if the
> directory entry on-disk has a zero-length name.  Currently it will return
> -EUCLEAN in that case, but with this patch it may think it's the name ".".
> 
> So I think there needs to either be a len >= 1 check added, *or* you need to
> make an argument for why it's okay to not care about the empty name case.

Frankly, the only caller that matters in practice is link_path_walk(); _that_
is by far the hottest path that might make use of that thing.

BTW, the callers that might end up passing 0 for len really ought to take
a good look at another thing - that name[0] is, in fact, mapped.  Something
along the lines of
	if (name + len > end_of_buffer)
		sod off
	if (<that function>(name, len))
		....
is not enough, for obvious reasons.
