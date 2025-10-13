Return-Path: <linux-fsdevel+bounces-63994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CB4BD52E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 18:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56993188A4D7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 16:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0892741DF;
	Mon, 13 Oct 2025 16:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnszU/S7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABE8274FDC;
	Mon, 13 Oct 2025 16:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760373990; cv=none; b=pQvahoSDFRohJmq6pG7o0jMsiAh1yOid4Av3Ed9KQrDMCYxBhN55JHAz0wVXo80yPgyO0lH3+xWfM9VLO2tP1jfNDv6UyzXM3y8f2AWcwqHRrpvcxa/XSwYZzzE5w5aXLTPPpmsv5C1VMmNxzbN3cHJuI5jYh4r39ue86kJr8NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760373990; c=relaxed/simple;
	bh=gxIAqG/scBYhaZ9vj8aZdm7V+FHB+EsklZHcQAKBPOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lnQWTqGAET5CIkRfbMZ3rFytC/MZWGMLQ3kkSoBZD89KODCPAzo7KDqo21Oliztf09eN6Ygb6rfWCqIOMy2Ir7iXeOEtimo1nLkp0Jf4VDiMCw6b0k4mzw9gmeA/tDyO5hS2ebBmOZdr7fR10DmRuyo1+uElHoQRbHTUOX6/fBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnszU/S7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9AE2C4CEE7;
	Mon, 13 Oct 2025 16:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760373990;
	bh=gxIAqG/scBYhaZ9vj8aZdm7V+FHB+EsklZHcQAKBPOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AnszU/S7VE+pxvk0IH9dd5U0qkT8N8joHyVjE82lE/plX3e3CfS/Xm9A02sDh/wBx
	 C7QYWmmCelZcepG6eZBbKZBooStQh0zZbsgAw4t0EdDp+Gqtuq4tIUOD0eENrTNRM/
	 vzfD7FNcIgv1rBxd+bJDr7+WzUEJGXwz41JZH3vaONX0Us+v+Igo7e0ZG8UwIZaWoj
	 cZaApewlNompuIP9AxxxJllMUzi/YxMAfCLT4C36KgrP0th97BuvCAnHVdQ9OynHoB
	 nftgE28RWKMhCJbF6hrF9wwscZWwPD9XBk4ugm4+RFG8el1mn3gEE0UFEVKrnSxCMN
	 ZLXAneyglfehQ==
Received: by pali.im (Postfix)
	id 787D5788; Mon, 13 Oct 2025 18:46:25 +0200 (CEST)
Date: Mon, 13 Oct 2025 18:46:25 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: Ethan Ferguson <ethan.ferguson@zetier.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] exfat: fix out-of-bounds in exfat_nls_to_ucs2()
Message-ID: <20251013164625.nphymwx25fde5eyk@pali>
References: <20251013134708.1270704-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013134708.1270704-1-aha310510@gmail.com>
User-Agent: NeoMutt/20180716

On Monday 13 October 2025 22:47:08 Jeongjun Park wrote:
> Since the len argument value passed to exfat_ioctl_set_volume_label()
> from exfat_nls_to_utf16() is passed 1 too large, an out-of-bounds read
> occurs when dereferencing p_cstring in exfat_nls_to_ucs2() later.
> 
> And because of the NLS_NAME_OVERLEN macro, another error occurs when
> creating a file with a period at the end using utf8 and other iocharsets,
> so the NLS_NAME_OVERLEN macro should be removed and the len argument value
> should be passed as FSLABEL_MAX - 1.
> 
> Cc: <stable@vger.kernel.org>
> Reported-by: syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=98cc76a76de46b3714d4
> Fixes: 370e812b3ec1 ("exfat: add nls operations")

Fixes: line is for sure wrong as the affected
exfat_ioctl_set_volume_label function is not available in the mentioned
commit.

I guess it should be commit d01579d590f72d2d91405b708e96f6169f24775a.

Now I have looked at that commit and I think I finally understood what
was the issue. exfat_nls_to_utf16() function is written in a way that
it expects null-term string and its strlen as 3rd argument.

This was achieved for all code paths except the new one introduced in
that commit. "label" is declared as char label[FSLABEL_MAX]; so the
FSLABEL_MAX argument in exfat_nls_to_utf16() is effectively
sizeof(label). And here comes the problem, it should have been
strlen(label) (or rather strnlen(label, sizeof(label)-1) in case
userspace pass non-nul term string).

So the change below to FSLABEL_MAX - 1 effectively fix the overflow
problem. But not the usage of exfat_nls_to_utf16.

API of FS_IOC_SETFSLABEL is defined to always take nul-term string:
https://man7.org/linux/man-pages/man2/fs_ioc_setfslabel.2const.html

And size of buffer is not the length of nul-term string. We should
discard anything after nul-term byte.

So in my opinion exfat_ioctl_set_volume_label() should be fixed in a way
it would call exfat_nls_to_utf16() with 3rd argument passed as:

  strnlen(label, sizeof(label) - 1)

or

  strnlen(label, FSLABEL_MAX - 1)

Or personally I prefer to store this length into new variable (e.g.
label_len) and then passing it to exfat_nls_to_utf16() function.
For example:

  ret = exfat_nls_to_utf16(sb, label, label_len, &uniname, &lossy);

Adding Ethan to CC as author of the mentioned commit.


And about NLS_NAME_OVERLEN, it is being used by the
__exfat_resolve_path() function. So removal of the "setting" of
NLS_NAME_OVERLEN bit but still checking if the NLS_NAME_OVERLEN bit is
set is quite wrong.


Namjae, could you re-check my analysis? Just to be sure that I have not
misunderstood something. It is better to do proper analysis than having
incomplete or incorrect fix.

> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---
>  fs/exfat/file.c | 2 +-
>  fs/exfat/nls.c  | 3 ---
>  2 files changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/fs/exfat/file.c b/fs/exfat/file.c
> index f246cf439588..7ce0fb6f2564 100644
> --- a/fs/exfat/file.c
> +++ b/fs/exfat/file.c
> @@ -521,7 +521,7 @@ static int exfat_ioctl_set_volume_label(struct super_block *sb,
>  
>  	memset(&uniname, 0, sizeof(uniname));
>  	if (label[0]) {
> -		ret = exfat_nls_to_utf16(sb, label, FSLABEL_MAX,
> +		ret = exfat_nls_to_utf16(sb, label, FSLABEL_MAX - 1,
>  					 &uniname, &lossy);
>  		if (ret < 0)
>  			return ret;
> diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
> index 8243d94ceaf4..57db08a5271c 100644
> --- a/fs/exfat/nls.c
> +++ b/fs/exfat/nls.c
> @@ -616,9 +616,6 @@ static int exfat_nls_to_ucs2(struct super_block *sb,
>  		unilen++;
>  	}
>  
> -	if (p_cstring[i] != '\0')
> -		lossy |= NLS_NAME_OVERLEN;
> -
>  	*uniname = '\0';
>  	p_uniname->name_len = unilen;
>  	p_uniname->name_hash = exfat_calc_chksum16(upname, unilen << 1, 0,
> --

