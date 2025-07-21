Return-Path: <linux-fsdevel+bounces-55545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD3FB0B9A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 02:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4136E7A1BB6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 00:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A6F149DE8;
	Mon, 21 Jul 2025 00:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSWnaIAC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70024128395;
	Mon, 21 Jul 2025 00:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753058645; cv=none; b=lOIIArzRLDpV/pqRQy+K7jVnoSP3NwrFelQ+Hmovw/N8T5I64lWfTbnbj9prJTKlVjc3iyLhx4nzvNGWi00IqXCAqtx5QA3ZXvA/i7okLHLs5GyXlyOPAqOCLnhKtFJ02Hf0BMBiMOwouIaQr6v4qeDevwdpH3RrTvXCrL2oML4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753058645; c=relaxed/simple;
	bh=sZh7nAa2H+zz6Rw4iCplFxXECYnUeug3lpaO6Yshh1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qz00Wclb4UkaU6D8od1fwIH9l4kQbtb4WRQ03YBR4Ztgv8LUlr2zyWEubecSdTp3YJzeMXRKkCA22WZVu4pQ4z5H84G3p1cqI8YXrQCWyaKwc2SGVJE8+BugKWaWX19Vc/BY07w5+uIqwhJuNDFNYHhQ8FMAiTWcR3RY7Ut+pFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSWnaIAC; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-87ec5e1cd4aso2320973241.0;
        Sun, 20 Jul 2025 17:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753058643; x=1753663443; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CtTXofz3YZU8ZHZgSXsRm5LIUyeVOephgcfaxbmgBHg=;
        b=hSWnaIACmfhsUu78WwLqZ29mQfEJcw1E5ycwuZ+10TnBNKOXW6fwJ3ZkEmYR5/6AgM
         qUHOqC/rEqOOojGFf3lo04FkC+ZbjFIhgcxePeDfr4yQYOhp0HBMX2C55+s1x0OlWRke
         Szp2h/Pm2G5oagxRpBCdw9Zl837/R1L4xfClFPpolPcAvCYHokAxpfmrxzzCHshFe0Yz
         VDvbY/ffPCg0XNtl0yen6HbfsMWvXcf5aiFDHSCs/JGB+yO7O1br+RYslEztnpRgb5QX
         YXP8Pc6AuT12dVyzzpfIdyE7U3fvw7ImqxVVBOhAs/s/Yoy+dDAPEoAPcklN0gUXXB1k
         wbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753058643; x=1753663443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CtTXofz3YZU8ZHZgSXsRm5LIUyeVOephgcfaxbmgBHg=;
        b=rlB+IhiSKq5201bekJp0bEa0g/YHHHTwQLerpRcuruqiV6rBcYYEgOuWZSV44cQvlX
         pCKd0J69GQCuRSrCBRh1IRuRvlr72MmYMhjgc+9SkzMcuRCBP6hrHz9FqEGQDIsIOgsl
         icJkmpSt27BycslqtzlgrmLtjY2oi8hwg2D1FbxIpSMuhB+tE/1UxE0n8mwB+EmCt3yE
         V2kpy60akxPWkx33SucdSTGhDfnHaR0lbmJLw+H2ErIax6A80umOFqpU7RV9l1wuDeiF
         7h3GZwYTPzlnIpcByIIoD+hJa4siIAblrlNUzehClRkB5GIrwb6LV0IrZiPmW/hgjBME
         NnXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYH9+BtoBiYfMqSipiP1KdvavbjCLq26Q0clfE8sIRSoOCgigQ2dgGSuN8hcsYQM4sYhBmQVJvM5DCCw==@vger.kernel.org, AJvYcCUzKDPRjqyfRH+NsYQpWrar0d4+3Tqk4G5vfG0K1p6+kEL6Hfbjay478IvTAL4PjumWDEMGHdRJUTyAC8N8lw==@vger.kernel.org, AJvYcCVw5jtHZZGDbFmrwhcnaWeMn413necaiwidwCrauwknImLfLXhE69OlUF6TF9tPkmw+0eo7+XPumFRnbA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHsOKs2JWD6MEMuW0Zp0sMdPbcckBiEYtblx3Hy9hYW+RRqa6H
	ISrEE3XSawAqI3dR4Jq9yR2RpRUDMoet0BNl+hYFSl4NIxW7WDmtx9FvGh69UrLfiPXI5TzXfaD
	eNu8eFsGNv9kdi8kzReZY4U7mnEJgX4M=
X-Gm-Gg: ASbGncszqqa2hjqL/XaAmagFeFIcV+gBrNRIkO6NvggIc198n6NozVqSDgoYPvAIuVC
	6dqrqN7akMbY0AVbC3wijxNlXTElf9DFX0peSdahN0JnG13PrOGtE0wCLBs0INtfCTclYGJ3xFH
	fJxA6Fz6HI+D8b4gzr1d/XVLqZCt7RplxjOeg8+DPdPnJkiQHZPLCoTRYEbo++P4DrLnzi6pmSc
	/s6rVg=
X-Google-Smtp-Source: AGHT+IGFRYyrS35WTP3i9Qe8TXmZslY6x6nCRq1gIJA/O9dosgodOs3uPYD7WXYU49lcEb5mCGS05wblqRqGVV/3QiI=
X-Received: by 2002:a05:6102:6316:10b0:4f9:6a91:cc95 with SMTP id
 ada2fe7eead31-4f96a91cec6mr5610145137.27.1753058643165; Sun, 20 Jul 2025
 17:44:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aHa8ylTh0DGEQklt@casper.infradead.org> <e5165052-ead3-47f4-88f6-84eb23dc34df@linux.alibaba.com>
In-Reply-To: <e5165052-ead3-47f4-88f6-84eb23dc34df@linux.alibaba.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 21 Jul 2025 08:43:51 +0800
X-Gm-Features: Ac12FXzyFbI4GjwypQZFYPLAZaBnNxcXr0fPPaJY0y3WB9_zSNUgD719YOscIeg
Message-ID: <CAGsJ_4wOeBwm2=1CbtZk+gHXe0wVyAYZuV-RZcV-wXe4Rj+h7g@mail.gmail.com>
Subject: Re: Compressed files & the page cache
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	Nicolas Pitre <nico@fluxnic.net>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
	linux-erofs@lists.ozlabs.org, Jaegeuk Kim <jaegeuk@kernel.org>, 
	linux-f2fs-devel@lists.sourceforge.net, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, 
	Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org, 
	David Howells <dhowells@redhat.com>, netfs@lists.linux.dev, 
	Paulo Alcantara <pc@manguebit.org>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, ntfs3@lists.linux.dev, 
	Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org, 
	Phillip Lougher <phillip@squashfs.org.uk>, Hailong Liu <hailong.liu@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 7:32=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
[...]
>
> I don't see this will work for EROFS because EROFS always supports
> variable uncompressed extent lengths and that will break typical
> EROFS use cases and on-disk formats.
>
> Other thing is that large order folios (physical consecutive) will
> caused "increase the latency on UX task with filemap_fault()"
> because of high-order direct reclaims, see:
> https://android-review.googlesource.com/c/kernel/common/+/3692333
> so EROFS will not set min-order and always support order-0 folios.

Regarding Hailong's Android hook, it's essentially a complaint about
the GFP mask used to allocate large folios for files. I'm wondering
why the page cache hasn't adopted the same approach that's used for
anon large folios:

    gfp =3D vma_thp_gfp_mask(vma);

Another concern might be that the allocation order is too large,
which could lead to memory fragmentation and waste. Ideally, we'd
have "small" large folios=E2=80=94say, with order <=3D 4=E2=80=94to strike =
a better
balance.

>
> I think EROFS will not use this new approach, vmap() interface is
> always the case for us.
>
> Thanks,
> Gao Xiang
>
> >
>

Thanks
Barry

