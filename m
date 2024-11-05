Return-Path: <linux-fsdevel+bounces-33667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B3B9BCE00
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 14:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA1551F21F3B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 13:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207531D88D4;
	Tue,  5 Nov 2024 13:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="aisbAwxY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UlOOkI14"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A98F1DD0D5
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Nov 2024 13:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730813719; cv=none; b=p+TaCAC1QGN2Y1hUdlhPeyKUMLbJQ/Y+tZHgsrtULfNjRtu+8OJT867j/n2X3qlDyy3dgtj821usihbruvgVjSc3H5sHacUIdtPxPg/rPZMWQCwhHc5uegz2sLQ1Dors52s+NgV7/Hu1ErZ7W0wa0oUtLvdzzwB1TT3odfpZyhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730813719; c=relaxed/simple;
	bh=Pg1aOPjDnh6jcj3oFs8FHIeMSoM4Qq6LUX8LtXC0TMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avIkv5epiUrrHRzY+aqBBlf2e5GXHnA14SWrX6OlWIhs5kkBMc6KHQveIVvg/SDIiIutBxqfUJc7T2m8lU1JdUCDbtwZWkXgrcxXS7NkdQTJ9GdEQy0Fb0qoFoP5wESRn/bZ3C/DZ7Nf4bi/Oyfk60EcCHHGuUh27kLqTfXBGNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=aisbAwxY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UlOOkI14; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 3D0AF1140182;
	Tue,  5 Nov 2024 08:35:16 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 05 Nov 2024 08:35:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1730813716; x=
	1730900116; bh=6oqwhGf49empqu1G+xlSv+uWH5j3k5vlDScx7Tuto50=; b=a
	isbAwxYv56EUZ/Bnd+uGEhixRGIH9OJIHwYkN+NyaHRb2FlcalyeqCMriPx8k6Ek
	Skn1+c/PT6yjT+nSLLoMUcUJuaaQN59EGfDa8XTKN5c2kXCvCQnxQWECQH+LVW1t
	8SoQXnsaNlyCsGhF2KpoKCFvI+CyCApUQmBUvJwHMx6jKspnnnIs8tNdLmnkLhVq
	399p2bxsFw0vkRNxklKSlZpp+sMZ5JZO3KMJ80PZgp4OOr3skvtRF7CuQQ5ONdwa
	lo1AhvA15pf26nxjomjFqXe1092MY0Q6VXd0fv/IF2E8ojd9Z1E/gr3Gn9W4spSj
	Z2JEg1pWWPaAj9FWIOZlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730813716; x=1730900116; bh=6oqwhGf49empqu1G+xlSv+uWH5j3k5vlDSc
	x7Tuto50=; b=UlOOkI147dq4G7sKMhOm//TIfnYsVA8Ckr0huffIM+OQxltejGw
	U8gga1YKlfOTMZOxtwSIWwFK4JKqdsNBkZeI8vOmtF4wwgg/M9Xo1wLPYYuImAoN
	FX2DXVCXUnYKfmxHN1OCyYpsqf2/pkZHkrw+nFIQxVUq6TL5I9A6vOGHNHL033Eo
	zkORm762pbwavdGuHLr7cP5XwrCr/1/YNAhdBUpk0Cr1iS3471f4FVAZJHN/xx4l
	tE48FvhlEmlnzAA1sNevxSkxN/cG4T6Fe5txq6yqG0k35iARC7a6o2DDZzQBeJ79
	XIXiBkqyQbExcwGBFYcCaBWAWqW5atuWa3g==
X-ME-Sender: <xms:Ex8qZxFu8EHjUPUHcCGDQmMOZ6flCKhzef1evT773iDlskhndxKQvA>
    <xme:Ex8qZ2U_5JMY07F75MXNIxlkhyYiOjorWTaI0wGFrtzFJoUcX1HJEzejF0ktjiZDz
    z6LcBmF4P_HKen42gc>
X-ME-Received: <xmr:Ex8qZzIUoAdhLssmkQ_OdUjYhKr57SfpF7gjbRmy5Q5C_06w1VM8IUKFnyJJNrnCTJx7YQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddtgddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecu
    hfhrohhmpedfmfhirhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhessh
    hhuhhtvghmohhvrdhnrghmvgeqnecuggftrfgrthhtvghrnhepveeifeekheelhfduffek
    ueegtdeuhffgkeegteeihfeltdevgedvveegfefhheehnecuffhomhgrihhnpehshiiikh
    grlhhlvghrrdgrphhpshhpohhtrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpd
    hnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegumhgr
    nhhtihhpohhvseihrghnuggvgidrrhhupdhrtghpthhtohepthgrnhguvghrshgvnhesnh
    gvthhflhhigidrtghomhdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidr
    ohhrghdruhhkpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtoheplhhinhhugidqfhhsuggv
    vhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhmmh
    eskhhvrggtkhdrohhrghdprhgtphhtthhopehlvhgtqdhprhhojhgvtghtsehlihhnuhig
    thgvshhtihhnghdrohhrghdprhgtphhtthhopehshiiisghothdotdefvgdurghfhegtfe
    efvdhfjegvtdgvsgekgegssehshiiikhgrlhhlvghrrdgrphhpshhpohhtmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:Ex8qZ3HxSFC3m8mFX0XUDT8LPlBalqDUfgCvVra97kepRt2QOsqSJQ>
    <xmx:Ex8qZ3UXaoaZ8HKbejcOPGFDIefR2j-ULPSiLBaUc5QO3joP9K0ZSw>
    <xmx:Ex8qZyO3ASMQA8vhCqSTqwCLpr0zCw6960NhPB_Ow7hvnFz55bmgZA>
    <xmx:Ex8qZ239JROLsZaHM0NJaUJvG0oFtajk4nc4ZKtwfFYcsAgSTqgTqA>
    <xmx:FB8qZ3RQsdgAJYMuMtz-sW9PmlF0FiF5EdkjcDI66ETbsXg2InPROZ7E>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 08:35:12 -0500 (EST)
Date: Tue, 5 Nov 2024 15:35:07 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Tycho Andersen <tandersen@netflix.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, lvc-project@linuxtesting.org, 
	syzbot+03e1af5c332f7e0eb84b@syzkaller.appspotmail.com
Subject: Re: [PATCH] exec: do not pass invalid pointer to kfree() from
 free_bprm()
Message-ID: <rd7o5657tji22pbhat2jhpeeggpxz5injgbnpnvrdmufss5q4g@xaw5hjceh3bo>
References: <20241105111344.2532040-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105111344.2532040-1-dmantipov@yandex.ru>

On Tue, Nov 05, 2024 at 02:13:44PM +0300, Dmitry Antipov wrote:
> Syzbot has reported the following BUG:
> 
> kernel BUG at arch/x86/mm/physaddr.c:23!
> Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> CPU: 2 UID: 0 PID: 5869 Comm: repro Not tainted 6.12.0-rc5-next-20241101-syzkaller #0
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-3.fc41 04/01/2014
> RIP: 0010:__phys_addr+0x16a/0x170
> Code: 40 a8 7a 8e 4c 89 f6 4c 89 fa e8 b1 4d aa 03 e9 45 ff ff ff e8 a7 1a 52 00 90 0f 0b e8 9f 1a 52 00 90 0f 0b e8 97 1a 52 00 90 <0f> 0b 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
> RSP: 0018:ffffc90002f7fda0 EFLAGS: 00010293
> RAX: ffffffff8143a369 RBX: 000000007ffffff2 RCX: ffff888106df5640
> RDX: 0000000000000000 RSI: 000000007ffffff2 RDI: 000000001fffffff
> RBP: 1ffff11020df6d09 R08: ffffffff8143a305 R09: 1ffffffff203a1f6
> R10: dffffc0000000000 R11: fffffbfff203a1f7 R12: dffffc0000000000
> R13: fffffffffffffff2 R14: 000000007ffffff2 R15: ffff88802bc12d58
> FS:  00007f01bd1a7600(0000) GS:ffff888062900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: fffffffffffffff8 CR3: 0000000011f80000 CR4: 00000000000006f0
> Call Trace:
>  <TASK>
>  ? __die_body+0x5f/0xb0
>  ? die+0x9e/0xc0
>  ? do_trap+0x15a/0x3a0
>  ? __phys_addr+0x16a/0x170
>  ? do_error_trap+0x1dc/0x2c0
>  ? __phys_addr+0x16a/0x170
>  ? __pfx_do_error_trap+0x10/0x10
>  ? handle_invalid_op+0x34/0x40
>  ? __phys_addr+0x16a/0x170
>  ? exc_invalid_op+0x38/0x50
>  ? asm_exc_invalid_op+0x1a/0x20
>  ? __phys_addr+0x105/0x170
>  ? __phys_addr+0x169/0x170
>  ? __phys_addr+0x16a/0x170
>  ? free_bprm+0x2b5/0x300
>  kfree+0x71/0x420
>  ? free_bprm+0x295/0x300
>  free_bprm+0x2b5/0x300
>  do_execveat_common+0x3ae/0x750
>  __x64_sys_execveat+0xc4/0xe0
>  do_syscall_64+0xf3/0x230
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f01bd0c36a9
> Code: 5c c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 4f 37 0d 00 f7 d8 64 89 01 48
> RSP: 002b:00007fff034da398 EFLAGS: 00000246 ORIG_RAX: 0000000000000142
> RAX: ffffffffffffffda RBX: 0000000000403e00 RCX: 00007f01bd0c36a9
> RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000004
> RBP: 0000000000000001 R08: 0000000000001000 R09: 0000000000403e00
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff034da4b8
> R13: 00007fff034da4c8 R14: 0000000000401050 R15: 00007f01bd1dca80
>  </TASK>
> 
> Since 'bprm_add_fixup_comm()' may set 'bprm->argv0' to 'ERR_PTR()',
> errno-lookalike invalid pointer should not be passed to 'kfree()'.
> 
> Reported-by: syzbot+03e1af5c332f7e0eb84b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=03e1af5c332f7e0eb84b
> Fixes: 7afad450c998 ("exec: fix up /proc/pid/comm in the execveat(AT_EMPTY_PATH) case")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  fs/exec.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index ef18eb0ea5b4..df70ed8e36fe 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1496,7 +1496,8 @@ static void free_bprm(struct linux_binprm *bprm)
>  	if (bprm->interp != bprm->filename)
>  		kfree(bprm->interp);
>  	kfree(bprm->fdpath);
> -	kfree(bprm->argv0);
> +	if (!IS_ERR(bprm->argv0))
> +		kfree(bprm->argv0);
>  	kfree(bprm);
>  }

It's better to avoid setting bprm->argv0 if strndup_user() fails.

diff --git a/fs/exec.c b/fs/exec.c
index ef18eb0ea5b4..9380e166eff5 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1504,6 +1504,7 @@ static int bprm_add_fixup_comm(struct linux_binprm *bprm,
 			       struct user_arg_ptr argv)
 {
 	const char __user *p = get_user_arg_ptr(argv, 0);
+	char *argv0;
 
 	/*
 	 * If p == NULL, let's just fall back to fdpath.
@@ -1511,10 +1512,11 @@ static int bprm_add_fixup_comm(struct linux_binprm *bprm,
 	if (!p)
 		return 0;
 
-	bprm->argv0 = strndup_user(p, MAX_ARG_STRLEN);
-	if (IS_ERR(bprm->argv0))
-		return PTR_ERR(bprm->argv0);
+	argv0 = strndup_user(p, MAX_ARG_STRLEN);
+	if (IS_ERR(argv0))
+		return PTR_ERR(argv0);
 
+	bprm->argv0 = argv0;
 	return 0;
 }
 
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

