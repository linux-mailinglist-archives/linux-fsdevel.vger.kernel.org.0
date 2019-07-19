Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 513A36EA45
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2019 19:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbfGSRiR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jul 2019 13:38:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:38266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbfGSRiR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jul 2019 13:38:17 -0400
Received: from localhost (unknown [84.241.199.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B04B2082F;
        Fri, 19 Jul 2019 17:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563557896;
        bh=4IKVaQcx3S4tKcqWi+N1+yK9Yr7a/ZRmg6mS6XaTqYo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T55hqAe5p5lWiKR5DK/FAeZe1x/gU296eiaeRSGvig/ZeYKGT1M9hW3likzxhGRpJ
         Yx1/YsEX4Ib5aMJVF+qEoNYwHJT3ov48vmVJw9cBquGsIu/EAV4S7i6YNELfbOIiFG
         suaykTz8HoPvTiZnqyBfeVBLrAxJJTm4gozm7V1Y=
Date:   Fri, 19 Jul 2019 19:38:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yin Fengwei <nh26223.lmm@gmail.com>
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        miklos@szeredi.hu, viro@zeniv.linux.org.uk, tglx@linutronix.de,
        kstewart@linuxfoundation.org
Subject: Re: [PATCH] fs: fs_parser: avoid NULL param->string to kstrtouint
Message-ID: <20190719173811.GA4765@kroah.com>
References: <20190719124329.23207-1-nh26223.lmm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719124329.23207-1-nh26223.lmm@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 19, 2019 at 08:43:29PM +0800, Yin Fengwei wrote:
> syzbot reported general protection fault in kstrtouint:
> https://lkml.org/lkml/2019/7/18/328
> 
> >From the log, if the mount option is something like:
>    fd,XXXXXXXXXXXXXXXXXXXX
> 
> The default parameter (which has NULL param->string) will be
> passed to vfs_parse_fs_param. Finally, this NULL param->string
> is passed to kstrtouint and trigger NULL pointer access.
> 
> Reported-by: syzbot+398343b7c1b1b989228d@syzkaller.appspotmail.com
> Fixes: 71cbb7570a9a ("vfs: Move the subtype parameter into fuse")
> 
> Signed-off-by: Yin Fengwei <nh26223.lmm@gmail.com>
> ---
>  fs/fs_parser.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/fs_parser.c b/fs/fs_parser.c
> index d13fe7d797c2..578e6880ac67 100644
> --- a/fs/fs_parser.c
> +++ b/fs/fs_parser.c
> @@ -210,6 +210,10 @@ int fs_parse(struct fs_context *fc,
>  	case fs_param_is_fd: {
>  		switch (param->type) {
>  		case fs_value_is_string:
> +			if (result->has_value) {
> +				goto bad_value;
> +			}

Always run checkpatch.pl so grumpy maintainers do not tell you to go run
checkpatch.pl :)
