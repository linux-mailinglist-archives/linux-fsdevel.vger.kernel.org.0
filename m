Return-Path: <linux-fsdevel+bounces-49300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E260DABA3D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 21:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAEE218889AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 19:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB8128001C;
	Fri, 16 May 2025 19:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="k57DJFDm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0BF22758F;
	Fri, 16 May 2025 19:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747423889; cv=none; b=BBShFW58jmam/ga1mcgJ6Ic6zbEdYUU8T46ouTAB9QYPN5jBhZn4Q+JwOkIK2Xe3xAasD4hZ+gvT4YWV/ECl8dAf2wctnfAVllXZrw21zqiwp1aB8NzQPwLAOxtffWx2NApHEjZwnb2K3SKwqhcRoXiKsbzFUs0tDTq8TuVObl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747423889; c=relaxed/simple;
	bh=NaqEM84cu4ycUxBbCQx13HKvKQs+ctdwMpFshxVrNuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dizdbl9xI3QvZz9jdLnIFqedGwqwElf0K6oPDJASgF9DNi2QX0qrBVEDpiT5LABx+PAf4Qp+HGZx7zqvz7zYSU9XfE8eakpQUWcPqVUwVZ+d++TAVQV8+Ql9yEA9jSwELU3k3Bd5WTTX17zNxc3Qn3Kt793WR1mKG9S2x3+KkjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=k57DJFDm; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zOXMxc5W6wuiCar1u6v5ZVlTOFZ/jKB4sF/AGJ9NqVY=; b=k57DJFDmLvKVekiZ031vy3siG0
	GFrJpNfmBGFRmsBdFA5EC6rpWAPIihDustQCLHMpTiVOIu3W077CZBdyRLvSq2qrjz52AKNDA5OQc
	MsAlAhJEGvpWZWgWexb4A8OWB4Tplw9AiffVSZldwERVcDfqFqyIB7tVEXtfircFQeU/k/9BeKj43
	msiFpfWgAYKq2U+c9/SY+gKYCY5HkKtojJHYVIC3cZzLzDH3n74euHF8OA4LywmgRMfZov1hYL6uS
	fg1+f7DG+oxxtjyr5dg/bjii+q0/NE1bperzxAucMeQfvCpiClAfisGKSOzpgnA/hkgtBqNBzyeSR
	RmwOkaSg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uG0mA-00000002VNC-1rUf;
	Fri, 16 May 2025 19:31:22 +0000
Date: Fri, 16 May 2025 20:31:22 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+321477fad98ea6dd35b7@syzkaller.appspotmail.com,
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] fs: Additional checks on new and old dir
Message-ID: <20250516193122.GS2023217@ZenIV>
References: <680809f3.050a0220.36a438.0003.GAE@google.com>
 <tencent_55ACA45C1762977206C3B376C36BA96B8305@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_55ACA45C1762977206C3B376C36BA96B8305@qq.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, May 14, 2025 at 06:39:40AM +0800, Edward Adam Davis wrote:
> In the reproducer, when calling renameat2(), olddirfd and newdirfd passed
> are the same value r0, see [1]. This situation should be avoided.
> 
> [1]
> renameat2(r0, &(0x7f0000000240)='./bus/file0\x00', r0, &(0x7f00000001c0)='./file0\x00', 0x0)
> 
> Reported-by: syzbot+321477fad98ea6dd35b7@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=321477fad98ea6dd35b7
> Tested-by: syzbot+321477fad98ea6dd35b7@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  fs/namei.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 84a0e0b0111c..ff843007ca94 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -5013,7 +5013,7 @@ int vfs_rename(struct renamedata *rd)
>  	struct name_snapshot old_name;
>  	bool lock_old_subdir, lock_new_subdir;
>  
> -	if (source == target)
> +	if (source == target || old_dir == target)
>  		return 0;

What the hell?

1) olddirfd and newdirfd have nothing to do with vfs_rename() - they are
bloody well gone by the time we get there.

2) there's nothing wrong with having the same value passed in both -
and it's certainly not a "quietly do nothing".

3) the check added in this patch is... odd.  You are checking essentically
for rename("foo/bar", "foo").  It should fail (-ENOTEMPTY or -EINVAL, depending
upon RENAME_EXCHANGE in flags) without having reached vfs_rename().

