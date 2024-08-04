Return-Path: <linux-fsdevel+bounces-24958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6451C947126
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 00:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19D111F21054
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 22:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FEA139590;
	Sun,  4 Aug 2024 22:00:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sxb1plsmtpa01-01.prod.sxb1.secureserver.net (sxb1plsmtpa01-01.prod.sxb1.secureserver.net [188.121.53.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBDF1755C
	for <linux-fsdevel@vger.kernel.org>; Sun,  4 Aug 2024 22:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722808856; cv=none; b=dcSck37YpdKfDGzFuRazSUlKVoyBv7dAfIRDx68o7u17o3P/xuMR62VwWSWb5alwg9DyH3JRBzrW6L7yvA1pC7jRfvaZF9iu0WX4cxLrSIGTbeSXNCiRu1K+alAEu3b10SkyCEsMir2bu3l6bik6BKHpIwroAaIOjxcPCgD0bWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722808856; c=relaxed/simple;
	bh=Mvx7rAiUch3Cfin57xpAs/8PbH19eIrf6E8R7cmXm98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q31bymlnbvt2o3TcVptl3MVNPeT732Bdd5g5OPBAliSsyiQyvlMpFr2JLw8rWplL0NaZqgXdoVFXjpjrwnOoDzXK+FLFC5Pm7XP+80pDoHHdAJbtmSX7jLaMBQep843DpCs/rIFQx1GzyNzEyp8IHMYGjFCX/fBMtyu3OGnCrqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=188.121.53.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from [192.168.178.90] ([82.69.79.175])
	by :SMTPAUTH: with ESMTPA
	id aiaIsPLtwT7r3aiaJs6CIe; Sun, 04 Aug 2024 14:16:12 -0700
X-CMAE-Analysis: v=2.4 cv=eKHYj2p1 c=1 sm=1 tr=0 ts=66afef9c
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=IkcTkHD0fZMA:10 a=hSkVLCK3AAAA:8 a=edf1wS77AAAA:8 a=t7CeM3EgAAAA:8
 a=AYFBRnY8-RZy9VRH-ocA:9 a=QEXdDO2ut3YA:10 a=cQPPKAXgyycSBL8etih5:22
 a=DcSpbTIhAlouE1Uv7lRv:22 a=FdTzh2GWekK77mhwV6Dw:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
Message-ID: <ee839d00-fd42-4b69-951d-8571140c077b@squashfs.org.uk>
Date: Sun, 4 Aug 2024 22:16:05 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7] squashfs: Add symlink size check in squash_read_inode
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, squashfs-devel@lists.sourceforge.net,
 syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
References: <20240803040729.1677477-1-lizhi.xu@windriver.com>
 <20240803074349.3599957-1-lizhi.xu@windriver.com>
Content-Language: en-GB
From: Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <20240803074349.3599957-1-lizhi.xu@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfDB39zMuKKKGl0cRk055VM/7sOXB+HnqoLITDfM9xE1xUANA6G3b+/JvI6+zDqGRPd1eI5bq9/MMC4F4Dk/xP7JnyEusxHloHYR5RmJW9zaAsQJeDgpN
 OF9+z5yVJj+JgI6ScB2c0DUAreC8dcrHP8KCtDuWs4RlbRDZwOu+n8+AdFKt4bSLwgrRVk/Ag1uxnLH1dWgXUn54l+2GqXF+kqLjvq5sItCEC5CMuiLgusaO
 k+V9In1ctMh+9k+wE0e2/9meKkNuPR/nhDptnb1pAogFplkMC4Bd+yuGJFrmZTOtNTvEm9kX5oi8Alfuo4WzeIsZajSHSMpLo5eJbfoCa72qtwxUrPr944Cg
 Ys02USnup0N/Yy+cUgGUKolQ0EwWUf6JnMgyKb2WebFP4NcTES+hz2wvoDzFEYVirLz6nqeMeIwlf4xKV8DYVbPg/fcT+ob8rgBGInNrCza5OCS+Q8fdvDmm
 UfeIlDrGrvwivP1+AyubIg7lu1Sa3XA2TIDvWxdAGhoCmkF6hf/DxKaK1J3E3itweHuVdK03QvxBuQ13

On 03/08/2024 08:43, Lizhi Xu wrote:
> syzbot report KMSAN: uninit-value in pick_link, the root cause is that
> squashfs_symlink_read_folio did not check the length, resulting in folio
> not being initialized and did not return the corresponding error code.
> 
> The length is calculated from i_size, this case is about symlink, so i_size
> value is derived from symlink_size, so it is necessary to add a check to
> confirm that symlink_size value is valid, otherwise an error -EINVAL will
> be returned.
> 
> If symlink_size is too large, it may result in a negative value when
> calculating length in squashfs_symlink_read_folio due to int overflow,
> and its value must be greater than PAGE_SIZE at this time.
> 
> Reported-and-tested-by: syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=24ac24ff58dc5b0d26b9
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> ---
>   fs/squashfs/inode.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
> index 16bd693d0b3a..bed6764e4461 100644
> --- a/fs/squashfs/inode.c
> +++ b/fs/squashfs/inode.c
> @@ -273,14 +273,21 @@ int squashfs_read_inode(struct inode *inode, long long ino)
>   	case SQUASHFS_SYMLINK_TYPE:
>   	case SQUASHFS_LSYMLINK_TYPE: {
>   		struct squashfs_symlink_inode *sqsh_ino = &squashfs_ino.symlink;
> +		loff_t symlink_size;
>   
>   		err = squashfs_read_metadata(sb, sqsh_ino, &block, &offset,
>   				sizeof(*sqsh_ino));
>   		if (err < 0)
>   			goto failed_read;
>   
> +		symlink_size = le32_to_cpu(sqsh_ino->symlink_size);
> +		if (symlink_size > PAGE_SIZE) {
> +			ERROR("Corrupted symlink, size [%llu]\n", symlink_size);
> +			return -EINVAL;
> +		}
> +
>   		set_nlink(inode, le32_to_cpu(sqsh_ino->nlink));
> -		inode->i_size = le32_to_cpu(sqsh_ino->symlink_size);
> +		inode->i_size = symlink_size;

NACK. I see no reason to introduce an intermediate variable here.

Please do what Al Viro suggested.

Thanks

Phillip Lougher
--
Squashfs author and maintainer

BTW I have been on vacation since last week, and only saw
this today.

>   		inode->i_op = &squashfs_symlink_inode_ops;
>   		inode_nohighmem(inode);
>   		inode->i_data.a_ops = &squashfs_symlink_aops;


