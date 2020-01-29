Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD50114C6EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 08:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbgA2Hgc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 02:36:32 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48012 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgA2Hgc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 02:36:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Avo4He8qBbr62a57mfvK3GgHqTnsEBDHZsSXy+0DrDc=; b=LdYZZJcitPY8XqIYzSWrI3n6a
        QkN2rM38s0xPABU4IaSmMAD0IcMtkGUqtda6IdfNzG5VLdsSGGalRzRbzvF//cYMivtu6Xcc2Cmxk
        VSL7rh7CYTYzGDwM5Hjv62HsMuEXdUBE16TdUwoprPnmsGDqP4khbIe3Zi0nIMKsJoV85P6QQ6o6R
        zH14Qh75FW8sQJ6IeiVHktJ1LrsapCO/yywXaG594849tljISh2o6RkzgtXRIrORO5ABtL/JPKv58
        zxA1yVVVRPxZnEnJq1DpxgQidpUy/d1adbSyck8fyIx5Xwp7Al87wrDbbqxgH3VQsacpX8DhC9iZZ
        K5V88hy/w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwhtm-0000OR-Gj; Wed, 29 Jan 2020 07:36:30 +0000
Date:   Tue, 28 Jan 2020 23:36:30 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Chao Yu <yuchao0@huawei.com>,
        linux-fscrypt@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v4] fs: introduce is_dot_or_dotdot helper for cleanup
Message-ID: <20200129073630.GF6615@bombadil.infradead.org>
References: <20200128221112.GA30200@bombadil.infradead.org>
 <1901841E-AE43-4AE2-B8F0-8F745B00664F@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1901841E-AE43-4AE2-B8F0-8F745B00664F@dilger.ca>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 28, 2020 at 06:23:18PM -0700, Andreas Dilger wrote:
> On Jan 28, 2020, at 3:11 PM, Matthew Wilcox <willy@infradead.org> wrote:
> > I've tried to get Ted's opinion on this a few times with radio silence.
> > Or email is broken.  Anyone else care to offer an opinion?
> 
> Maybe I'm missing something, but I think the discussion of the len == 0
> case is now moot, since PATCH v6 (which is the latest version that I can
> find) is checking for "len >= 1" before accessing name[0]:

Regardless of _this_ patch, the question is "Should ext4 be checking
for filenames of zero length and reporting -EUCLEAN if it finds any?"
I believe the answer is yes, since it's clearly a corrupted filesystem,
but I may be missing something.

Thanks for your reply.

> >> fscrypt_get_symlink():
> >>       if (cstr.len == 0)
> >>                return ERR_PTR(-EUCLEAN);
> >> ext4_readdir():
> >> 	Does not currently check de->name_len.  I believe this check should
> >> 	be added to __ext4_check_dir_entry() because a zero-length directory
> >> 	entry can affect both encrypted and non-encrypted directory entries.
> >> dx_show_leaf():
> >> 	Same as ext4_readdir().  Should probably call ext4_check_dir_entry()?
> >> htree_dirblock_to_tree():
> >> 	Would be covered by a fix to ext4_check_dir_entry().
> >> f2fs_fill_dentries():
> >> 	if (de->name_len == 0) {
> >> 		...
> >> ubifs_readdir():
> >> 	Does not currently check de->name_len.  Also affects non-encrypted
> >> 	directory entries.
> >> 
> >> So of the six callers, two of them already check the dirent length for
> >> being zero, and four of them ought to anyway, but don't.  I think they
> >> should be fixed, but clearly we don't historically check for this kind
> >> of data corruption (strangely), so I don't think that's a reason to hold
> >> up this patch until the individual filesystems are fixed.

