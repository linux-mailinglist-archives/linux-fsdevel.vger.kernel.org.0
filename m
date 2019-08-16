Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F10A68F933
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2019 04:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfHPCq5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 22:46:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:38522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbfHPCq4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 22:46:56 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF8EB206C2;
        Fri, 16 Aug 2019 02:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565923616;
        bh=XYUfWBU6RdshXHwYJ//3wmPdXI1/drA8t4ziHXIGfqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MDr0N0oMJfyQYjzl+krcvsiz0f34Vkob88Nad7ObdVH3LVpP47qq89/9WbaSEUQMZ
         DfOUPCbvr07buFHrBFwRV1W02T+Ao6ISBT2J4M97qeXiFh5qhO38uYksZImUk2zPYK
         TNvRII/FU+B3AJPh7V3I3+tsCxbPQJWq6tKeLZZ8=
Date:   Thu, 15 Aug 2019 19:46:54 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, gregkh@linuxfoundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, miklos@szeredi.hu,
        tglx@linutronix.de, Yin Fengwei <nh26223.lmm@gmail.com>,
        kstewart@linuxfoundation.org
Subject: Re: [PATCH v2] fs: fs_parser: avoid NULL param->string to kstrtouint
Message-ID: <20190816024654.GA12185@sol.localdomain>
Mail-Followup-To: viro@zeniv.linux.org.uk, dhowells@redhat.com,
        gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        miklos@szeredi.hu, tglx@linutronix.de,
        Yin Fengwei <nh26223.lmm@gmail.com>, kstewart@linuxfoundation.org
References: <20190719232949.27978-1-nh26223.lmm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719232949.27978-1-nh26223.lmm@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 20, 2019 at 07:29:49AM +0800, Yin Fengwei wrote:
> syzbot reported general protection fault in kstrtouint:
> https://lkml.org/lkml/2019/7/18/328
> 
> From the log, if the mount option is something like:
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
> ChangeLog:
>  v1 -> v2:
>    - Fix typo in v1
>    - Remove braces {} from single statement blocks
> 
>  fs/fs_parser.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/fs_parser.c b/fs/fs_parser.c
> index 83b66c9e9a24..7498a44f18c0 100644
> --- a/fs/fs_parser.c
> +++ b/fs/fs_parser.c
> @@ -206,6 +206,9 @@ int fs_parse(struct fs_context *fc,
>  	case fs_param_is_fd: {
>  		switch (param->type) {
>  		case fs_value_is_string:
> +			if (!result->has_value)
> +				goto bad_value;
> +
>  			ret = kstrtouint(param->string, 0, &result->uint_32);
>  			break;
>  		case fs_value_is_file:
> -- 
> 2.17.1

Reviewed-by: Eric Biggers <ebiggers@kernel.org>

Al, can you please apply this patch?

- Eric
