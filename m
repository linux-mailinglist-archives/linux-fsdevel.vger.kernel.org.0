Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22277380281
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 May 2021 05:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbhEND2U convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 May 2021 23:28:20 -0400
Received: from mail-m17657.qiye.163.com ([59.111.176.57]:34602 "EHLO
        mail-m17657.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbhEND2T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 May 2021 23:28:19 -0400
Received: from SZ11126892 (unknown [58.250.176.229])
        by mail-m17657.qiye.163.com (Hmail) with ESMTPA id 03E3A2800A3;
        Fri, 14 May 2021 11:27:06 +0800 (CST)
From:   <changfengnan@vivo.com>
To:     "'Matthew Wilcox'" <willy@infradead.org>
Cc:     <miklos@szeredi.hu>, <linux-fsdevel@vger.kernel.org>
References: <20210514015517.258-1-changfengnan@vivo.com> <YJ3f1lBkwY+9vqss@casper.infradead.org>
In-Reply-To: <YJ3f1lBkwY+9vqss@casper.infradead.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSBmdXNlOiBmaXggaW5jb25zaXN0ZW50IHN0YQ==?=
        =?gb2312?B?dHVzIGJldHdlZW4gZmFjY2VzcyBhbmQgbWtkaXI=?=
Date:   Fri, 14 May 2021 11:27:06 +0800
Message-ID: <001a01d74871$044e3ea0$0ceabbe0$@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="gb2312"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQHSg1k0XIarInm8T5zFb3SbkcTrigLvYnmWqtRgNcA=
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQh1LTlZJGR8YTk9JGUJCHx1VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hOSFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nkk6GTo*Dz8cATApIxw3ChNJ
        LTJPCT5VSlVKTUlLQk1JQ0lMT0hNVTMWGhIXVRgTGhUcHR4VHBUaFTsNEg0UVRgUFkVZV1kSC1lB
        WU5DVUlOS1VKTE1VSUlCWVdZCAFZQUlOTkk3Bg++
X-HM-Tid: 0a7968e9db68da03kuws03e3a2800a3
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

we should us d_find_any_alias() rather than d_obtain_alias(), it's my
mistake.

Fuse is support hardlinks, if an inode with two links, we may found wrong
alias, we may need invalidate all dentry, because of the file is not exist
anymore.
But in other kernel code, I didn't see any handling for this situation. I
can't figure out why.

Thanks.

-----邮件原件-----
发件人: Matthew Wilcox <willy@infradead.org> 
发送时间: 2021年5月14日 10:27
收件人: Fengnan Chang <changfengnan@vivo.com>
抄送: miklos@szeredi.hu; linux-fsdevel@vger.kernel.org
主题: Re: [PATCH] fuse: fix inconsistent status between faccess and mkdir

On Fri, May 14, 2021 at 09:55:17AM +0800, Fengnan Chang wrote:
> +++ b/fs/fuse/dir.c
> @@ -1065,6 +1065,14 @@ static int fuse_do_getattr(struct inode *inode,
struct kstat *stat,
>  				fuse_fillattr(inode, &outarg.attr, stat);
>  		}
>  	}
> +	if (err == -ENOENT) {
> +		struct dentry *entry;
> +
> +		entry = d_obtain_alias(inode);

Why d_obtain_alias() instead of d_find_any_alias()?

And what if you find the wrong alias?  ie an inode with two links?
Or does fuse not support hardlinks?



