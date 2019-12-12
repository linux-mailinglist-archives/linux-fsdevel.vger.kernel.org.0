Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63EBA11D4F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 19:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730235AbfLLSNM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 13:13:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41574 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730080AbfLLSNM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 13:13:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=G49Rl0ofxGDjV0ebu1h/WHiySZFXkCT6JdTKwgc+3Ho=; b=LEKz4gfOoesGVprlJRemg+jlu
        y3BHsx4zmfnfmGq4f4UDn2GYw3qZGWH1JLLTPtwCy/D5xPR7U3a4MKAnGCfWv3IS+ubNJyrqnIbqt
        tTGPNK+AK0F8W7QxE7aNPMK6bWPFA2WulJJeoH5Br2wUJJE3442kCY4BTUKRM18l9QziV8MQjbgDN
        LRaZ046/THnA0MnX7NKNXa4TrGTJvWFN+Vc89RUb5J5EBJENodCWnRHzP5+rVDhtas/y6Vlbi8xyB
        X608T2PTboYMdcL3cLbijTp+075vI7BlqU/6h/RwSYjZGbLLf4vdklpfZCaCsdLjIA/VQE8WaeUzt
        g3nIla6iw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifSxS-0006Ii-Ow; Thu, 12 Dec 2019 18:13:02 +0000
Date:   Thu, 12 Dec 2019 10:13:02 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        linux-fsdevel@vger.kernel.org, ecryptfs@vger.kernel.org,
        linux-fscrypt@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] fs: introduce is_dot_or_dotdot helper for cleanup
Message-ID: <20191212181302.GT32169@bombadil.infradead.org>
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

Trying to wrench this back on track ...

fscrypt_fname_disk_to_usr is called by:

fscrypt_get_symlink():
       if (cstr.len == 0)
                return ERR_PTR(-EUCLEAN);
ext4_readdir():
	Does not currently check de->name_len.  I believe this check should
	be added to __ext4_check_dir_entry() because a zero-length directory
	entry can affect both encrypted and non-encrypted directory entries.
dx_show_leaf():
	Same as ext4_readdir().  Should probably call ext4_check_dir_entry()?
htree_dirblock_to_tree():
	Would be covered by a fix to ext4_check_dir_entry().
f2fs_fill_dentries():
	if (de->name_len == 0) {
		...
ubifs_readdir():
	Does not currently check de->name_len.  Also affects non-encrypted
	directory entries.

So of the six callers, two of them already check the dirent length for
being zero, and four of them ought to anyway, but don't.  I think they
should be fixed, but clearly we don't historically check for this kind
of data corruption (strangely), so I don't think that's a reason to hold
up this patch until the individual filesystems are fixed.
