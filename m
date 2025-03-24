Return-Path: <linux-fsdevel+bounces-44889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F35A6E294
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 19:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9956188F05E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 18:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105FC264F93;
	Mon, 24 Mar 2025 18:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="XwVZMftb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869F21FCFDC
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Mar 2025 18:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742841806; cv=none; b=SMS8XqyYOMrgHJ5lTKbpP4Z66HpCyplHUFmRkFdOkevydvIraqCyT+0U1YAz/7NbPKxettqehLnITi4mR/i4togSlCh3Y0sPSFibRWRGTMUAu7H+1CTD4KFvc2Ry4xzmSU5nG4UBs29bWSckxuXyi+m/QKcnV3xddaxhCbuQkFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742841806; c=relaxed/simple;
	bh=DyPdR8XejOdJArHhChOKI1F1uccExW7lMxKjafwnONI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Au5q3oXR/ExJZc/AIPyPV+QZS3iK/HVERTV6h6AZ6PfnC3ho+C0ND1ixkvHUqoVtnT/2p2Qe/i3rsfhpsl/l73jlR1nGg5YQ03N/RP8QaHg0lXZ+kA3yfYRTrDE1hzKAU1aPrLyKXYVsQBYB0oKYq4z50K7F4deApvEy4cMcxQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=XwVZMftb; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 561EB3F2E4
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Mar 2025 18:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1742841801;
	bh=bmsw4ewzcXLmD+pkXVGwFfrm6ow1zJu7eLFjnQrlG3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=XwVZMftbXu33p987QScv1DFwyCH/D1i8TOqE6FJaOG6YD/k02o2jnArAK8OpP13Lk
	 b6wEqgQKYqkQCBeLbx0hunBkytERir0RZXQR+qtoPPk14Wcek3upEZr5Vwvk4nZ3HT
	 5XByMnsTk4iV04jn5FmETXx5Vr5p0C0CHPmxLTTlhpzvz/W8iuD+guUnqBg+1eanVg
	 0xCrGc5+BVHYE3tEyd23UxvhQq8R+jvq66HcnNKLjyLg8d8crFv68E3Ehzqbt0qixp
	 V0KyXJvygEt0HK2rl8Yw4StMmIAQLLBS8MmkgQVJbmjCTmLWS9kEP8huG7ZHD5swSC
	 w62LM81cuJ1Ng==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac2aa3513ccso362627866b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Mar 2025 11:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742841801; x=1743446601;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bmsw4ewzcXLmD+pkXVGwFfrm6ow1zJu7eLFjnQrlG3k=;
        b=rXKLafLahmKzrQJG3Ugd5F2/SNd0fMh9+MKyZWFUM+liI/P2m6NhHqX3JlxZc/6eeN
         bv/VC89KmXMMp/WNKwYhh26pfaldB0mmUjgy/BkVNDg+kG2UjRMCflfhRzaOUpP0zU+M
         U1WGsd06YfIGUifsRC8CBnI/YhRABIzGyluo/ntF1I6aJDWJx9B8Og9ba4Hu9McH20OL
         rN9WQCu8c0iBIhC/J+O/oGn2lHa76zKdAzwl5VVqEEHbTuu8Ocg0QCztMTUM/YggaeRA
         3/a/BdPV2EELJxuI1bZk0M7tGipLlHHo7CdY6xqho045eIlLv614tRfYVmI3Ru2wNNUz
         geAg==
X-Forwarded-Encrypted: i=1; AJvYcCUGcg2HPrWLyP/F3AI7zI8n1RxmgMhdbJ/7txht8nH+Q0GY6hwtwMEXhNtyBq7YVYEe8nmVov+mlE1GA/dL@vger.kernel.org
X-Gm-Message-State: AOJu0YxgfJfDNPiTxsIuOlfYi/VSp2VPATgtwZ4wPbS847+Anb0czOzM
	r3Q55g9fELLzR5xpBWDkAmQ1C8VMOWcXQ2aVyd9PE4UQu8u03zinTwbj97T18FwksXIDJaO5qEk
	PDo0r5ekt1mpCwxNs5YR4TxZOuZSkysy2eb/Mcb1gkCIQxBSpFP0IeymdoyvuLcQshDSTjy9KLX
	iJlxc=
X-Gm-Gg: ASbGncuT90JSnWAvewmRkfIKJTztvc+R1MrrcDjnGQxwmkFKDqfF4Kx/gloDz3mONvj
	Z3NTexe5QvTtrax++HraPvkZbE23GzQBR/4hHeYnOlMwHizqNV9V6225EKoXlBdqkqpBQSniuhD
	Sn3eCCRE0QL19PGtSYBX01YERy4wD2JSktgO/BNgbvAbvlEQkTtBhZLDllMrLE5962GbtOEgChH
	R9J8ri657LL0ZJRHHuKbuPn8SrmqknfxIabwj7qqf+4Rr94Y2Cn/lr5kAFMLg3cS8heA7Dr1LMU
	8+U9WAO2EO/ER8e/WcQ=
X-Received: by 2002:a17:907:da4:b0:ac1:e332:b1f5 with SMTP id a640c23a62f3a-ac3f2502f3amr1331213666b.37.1742841800703;
        Mon, 24 Mar 2025 11:43:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHB+I+1R+JqYek+Q0I5+9nDVaAEO0lpIglG7jRbh+7uyr3OSYJUS/du9QNLk3uBN/js20IAkQ==
X-Received: by 2002:a17:907:da4:b0:ac1:e332:b1f5 with SMTP id a640c23a62f3a-ac3f2502f3amr1331210066b.37.1742841800156;
        Mon, 24 Mar 2025 11:43:20 -0700 (PDT)
Received: from localhost ([176.88.101.113])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efb6483fsm721247366b.112.2025.03.24.11.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 11:43:19 -0700 (PDT)
Date: Mon, 24 Mar 2025 21:43:18 +0300
From: Cengiz Can <cengiz.can@canonical.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Salvatore Bonaccorso <carnil@debian.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, lvc-patches@linuxtesting.org, 
	dutyrok@altlinux.org, syzbot+5f3a973ed3dfb85a6683@syzkaller.appspotmail.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH] hfs/hfsplus: fix slab-out-of-bounds in hfs_bnode_read_key
Message-ID: <7qi6est65ekz4kjktvmsbmywpo5n2kla2m3whbvq4dsckdcyst@e646jwjazvqh>
References: <20241019191303.24048-1-kovalev@altlinux.org>
 <Z9xsx-w4YCBuYjx5@eldamar.lan>
 <d4mpuomgxqi7xppaewlpey6thec7h2fk4sm2iktqsx6bhwu5ph@ctkjksxmkgne>
 <2025032402-jam-immovable-2d57@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2025032402-jam-immovable-2d57@gregkh>
User-Agent: NeoMutt/20231103

On 24-03-25 09:17:05, Greg KH wrote:
> On Mon, Mar 24, 2025 at 07:14:07PM +0300, Cengiz Can wrote:
> > On 20-03-25 20:30:15, Salvatore Bonaccorso wrote:
> > > Hi
> > > 
> > 
> > Hello Salvatore,
> > 
> > > On Sat, Oct 19, 2024 at 10:13:03PM +0300, Vasiliy Kovalev wrote:
> > > > Syzbot reported an issue in hfs subsystem:
> > > > 
> > > > BUG: KASAN: slab-out-of-bounds in memcpy_from_page include/linux/highmem.h:423 [inline]
> > > > BUG: KASAN: slab-out-of-bounds in hfs_bnode_read fs/hfs/bnode.c:35 [inline]
> > > > BUG: KASAN: slab-out-of-bounds in hfs_bnode_read_key+0x314/0x450 fs/hfs/bnode.c:70
> > > > Write of size 94 at addr ffff8880123cd100 by task syz-executor237/5102
> > > > 
> > > > Call Trace:
> > > >  <TASK>
> > > >  __dump_stack lib/dump_stack.c:94 [inline]
> > > >  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
> > > >  print_address_description mm/kasan/report.c:377 [inline]
> > > >  print_report+0x169/0x550 mm/kasan/report.c:488
> > > >  kasan_report+0x143/0x180 mm/kasan/report.c:601
> > > >  kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
> > > >  __asan_memcpy+0x40/0x70 mm/kasan/shadow.c:106
> > > >  memcpy_from_page include/linux/highmem.h:423 [inline]
> > > >  hfs_bnode_read fs/hfs/bnode.c:35 [inline]
> > > >  hfs_bnode_read_key+0x314/0x450 fs/hfs/bnode.c:70
> > > >  hfs_brec_insert+0x7f3/0xbd0 fs/hfs/brec.c:159
> > > >  hfs_cat_create+0x41d/0xa50 fs/hfs/catalog.c:118
> > > >  hfs_mkdir+0x6c/0xe0 fs/hfs/dir.c:232
> > > >  vfs_mkdir+0x2f9/0x4f0 fs/namei.c:4257
> > > >  do_mkdirat+0x264/0x3a0 fs/namei.c:4280
> > > >  __do_sys_mkdir fs/namei.c:4300 [inline]
> > > >  __se_sys_mkdir fs/namei.c:4298 [inline]
> > > >  __x64_sys_mkdir+0x6c/0x80 fs/namei.c:4298
> > > >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > > >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> > > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > > RIP: 0033:0x7fbdd6057a99
> > > > 
> > > > Add a check for key length in hfs_bnode_read_key to prevent
> > > > out-of-bounds memory access. If the key length is invalid, the
> > > > key buffer is cleared, improving stability and reliability.
> > > > 
> > > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > > Reported-by: syzbot+5f3a973ed3dfb85a6683@syzkaller.appspotmail.com
> > > > Closes: https://syzkaller.appspot.com/bug?extid=5f3a973ed3dfb85a6683
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
> > > > ---
> > > >  fs/hfs/bnode.c     | 6 ++++++
> > > >  fs/hfsplus/bnode.c | 6 ++++++
> > > >  2 files changed, 12 insertions(+)
> > > > 
> > > > diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
> > > > index 6add6ebfef8967..cb823a8a6ba960 100644
> > > > --- a/fs/hfs/bnode.c
> > > > +++ b/fs/hfs/bnode.c
> > > > @@ -67,6 +67,12 @@ void hfs_bnode_read_key(struct hfs_bnode *node, void *key, int off)
> > > >  	else
> > > >  		key_len = tree->max_key_len + 1;
> > > >  
> > > > +	if (key_len > sizeof(hfs_btree_key) || key_len < 1) {
> > > > +		memset(key, 0, sizeof(hfs_btree_key));
> > > > +		pr_err("hfs: Invalid key length: %d\n", key_len);
> > > > +		return;
> > > > +	}
> > > > +
> > > >  	hfs_bnode_read(node, key, off, key_len);
> > > >  }
> > 
> > Simpler the better. 
> > 
> > Our fix was released back in February. (There are other issues in our attempt I
> > admit).
> > 
> > https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/jammy/commit/?id=2e8d8dffa2e0b5291522548309ec70428be7cf5a
> > 
> > If someone can pick this submission, I will be happy to replace our version.
> 
> any specific reason why you didn't submit this upstream?  Or did that
> happen and it somehow not get picked up?

It was mentioned by the researchers that previous attempts were unanswered. I
didn't question the validity of that statement.

I received excerpts from a private email communication indicating that the
HFSPlus filesystem currently has no maintainers, and that at least one of the
decision-makers does not consider filesystem corruption flaws to be particularly
sensitive.

Re-sharing this publicly on linux-fsdevel probably won't get picked up and would
definitely put Ubuntu users at risk, as we were the only ones shipping the
'enabling' policy lines at org.freedesktop.udisks2.filesystem-mount. 

So I proceeded with downstream fix and we released the fix before announcement
date.

> 
> And why assign a CVE for an issue that is in the mainline kernel, last I
> checked, Canonical was NOT allowed to do that.

This was not ideal, you're right. It should be assigned by kernel.org.

> 
> Please work to revoke that CVE and ask for one properly.

Will do. Thanks.

In the meantime, can we get this fix applied?

> 
> thanks,
> 
> greg k-h

