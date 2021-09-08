Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F90040411F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 00:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347475AbhIHWlM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 18:41:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:45670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244469AbhIHWlH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 18:41:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DC66760F5E;
        Wed,  8 Sep 2021 22:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1631140799;
        bh=er5DLepHHVt09U5Jzu87DfzTI5uefgw4AGP2yz87GcA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WUH9mZ1NDWKr+ERPDRQ4E5IpMIeu1SZI5DD4e+lLjKaEnq0qefJOX5XHXDORxE5qb
         DRW75dfi/1Wa9wm/V8lhMbHFhdhO0/6/CiUcQJe/4Efp8Ew8gcwtNkdL7TVLz/6zm4
         RKgw/gF7pBhyHI2VgfPd8fHLWuIA3RzwYn/Csuck=
Date:   Wed, 8 Sep 2021 15:39:58 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     yangerkun <yangerkun@huawei.com>
Cc:     <sfr@canb.auug.org.au>, <jack@suse.cz>, <viro@zeniv.linux.org.uk>,
        <gregkh@linuxfoundation.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>, <yukuai3@huawei.com>
Subject: Re: [PATCH] ramfs: fix mount source show for ramfs
Message-Id: <20210908153958.19054d439ae59ee3a7e41519@linux-foundation.org>
In-Reply-To: <720f6c7a-6745-98ad-5c71-7747857a7f01@huawei.com>
References: <20210811122811.2288041-1-yangerkun@huawei.com>
        <720f6c7a-6745-98ad-5c71-7747857a7f01@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 8 Sep 2021 16:56:25 +0800 yangerkun <yangerkun@huawei.com> wrote:

> 在 2021/8/11 20:28, yangerkun 写道:
> > ramfs_parse_param does not parse key "source", and will convert
> > -ENOPARAM to 0. This will skip vfs_parse_fs_param_source in
> > vfs_parse_fs_param, which lead always "none" mount source for ramfs. Fix
> > it by parse "source" in ramfs_parse_param.
> > 
> > Signed-off-by: yangerkun <yangerkun@huawei.com>
> > ---
> >   fs/ramfs/inode.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
> > index 65e7e56005b8..0d7f5f655fd8 100644
> > --- a/fs/ramfs/inode.c
> > +++ b/fs/ramfs/inode.c
> > @@ -202,6 +202,10 @@ static int ramfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
> >   	struct ramfs_fs_info *fsi = fc->s_fs_info;
> >   	int opt;
> >   
> > +	opt = vfs_parse_fs_param_source(fc, param);
> > +	if (opt != -ENOPARAM)
> > +		return opt;
> > +
> >   	opt = fs_parse(fc, ramfs_fs_parameters, param, &result);
> >   	if (opt < 0) {
> >   		/*
> > 

(top-posting repaired)

> Hi, this patch seems still leave in linux-next, should we pull it to
> mainline?

I was hoping for a comment from Al?
