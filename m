Return-Path: <linux-fsdevel+bounces-46324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C637A86F56
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Apr 2025 22:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EB7417F21B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Apr 2025 20:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C56203716;
	Sat, 12 Apr 2025 20:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ThxM3Rh9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDB914F117
	for <linux-fsdevel@vger.kernel.org>; Sat, 12 Apr 2025 20:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744489381; cv=none; b=C49BN1syb2zPrDcGMj0+jlFWCaSnkh57RBghuH6qTNgFjw8bllMPL+qb5SQsBR8fa25Fg4FtFl+PykfCzhkMMSeQZMTzAG/d/nHDL2z0JrzVLaI4okgWeWH8T9LWXwdconYeWE16OQaX0djlNAMuycJjbTKUvz6kNoIWdj0u8R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744489381; c=relaxed/simple;
	bh=6Y5KdDVzjvazrOIApCipo1B6aUyEJJR4k42kybjK5BA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DcHz5YzWgXQ3ODIhGwU0QebfdS0Mk2XI7Pmt1qI9esMCBvoeeO/yXyx3cxlcTEG35xQ4ZJoj0tCV5mtBIOVb7UaAl+XD091emQfDtk001q3WMPJ5NaocBSuhv5sbwKgF7nVY9LiqLG919Yf63FtOU+mT+SlqL5WSbhhuytKBQNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ThxM3Rh9; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac34257295dso595986366b.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Apr 2025 13:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1744489376; x=1745094176; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d/539aLu+mB+lczaep/CgFHmero7rpBQwrzIrFuK2HQ=;
        b=ThxM3Rh92No5WgNJiWsBpnYE7VJo8TJNQWS948czd/HYxofWNuSQ5OveJ6TYve7kiZ
         AH1r4IvAGrWQitiyjuFehAX/czAfQPhm5gt697vrbzdt33VtsJ8QsjLOxahtrLaUYX3a
         H3pPu5vMAlihggzx6n68VrhHQdpQHRbcS52zc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744489376; x=1745094176;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d/539aLu+mB+lczaep/CgFHmero7rpBQwrzIrFuK2HQ=;
        b=a9JSUFeDxCQC7V9bBaap0KQqxRZSQ7ZP9mFn9IMHrSTIiq0Es8SY1KbnGDhHQ3pVKj
         SyXKTwT4ybinQ3DiwHiIyQo7N9BQ0bAXdMoXztZkpKCvirCtJUChPOveiSqSrA606QV5
         DJWRWtpNK6FmKqFJSs1l7aoBzEqsh9YfG9cIYykw0AzeWtzh9opHdcyEPAvVi/0RKlbK
         FW4i1iZNBAUj8ZeLzwaU+X6yqU952vfZ3hc9yK7m9EJDNS2ZaDEE/QbfpO0/eK5Y0JJC
         f4qPmXWvzzvDQ7fwKsJGejRZUKHXK4h93upoPQo4e7uvd9c1/awnUt4BJPTQA03t71KX
         cIPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjjcORiuUqRY+KnIo90UNzb/owkrhXPnCk0NYvDgGf4JmAcqXfBv173JdAH0OX95+MpWVReQOhMlNTF3pm@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ8v0t2/FpyFIhh5eKTeR09AgDed+CfuV1zP/KQ5kufAgJLsMD
	jas3xjOUOURkOv/EiLR/5WjPw13h6Dg4XeHTuQvFJnfxi8nlQXjrxxA5qlAwN/cd4MpYv+UrFqG
	da+4=
X-Gm-Gg: ASbGncuPggYC9LBJO04D2YC34hhnHyAwRu4bb8ErqNSpXekJlFVO/vo2qB4BLCaeW2x
	KivAQwbvuHie6LbK37nFh/5NFEiUHsof74mgPZc9WxVCNNrHf00pJnScAQ2G6qX2Tbh7E0lKNd1
	iKYNPIXHTlaC+6yUar1zTRFmUkyfAuylWKSbL24jQTDqxuisHlwM9PnfNo1oSUVy+vuENVfT4hc
	lSKj+1nVAi3gHV2QTSYf6NaKbGzNG3eQeIrm7n5654lBmHJ2Qty795/gYLBZJymRW4S29Co4q1S
	8AcPF98ww8pTqierv+Tqf4g6+H7LWvyaPbkDOWZrSm1IWCdxGm3M8dCr0PHnXCSvtFA9gEAHc2E
	mMc9iQnEFQwi5yaU=
X-Google-Smtp-Source: AGHT+IHT55U/pRcO1PDGP0/bUvCvazdrocwLVzJRTt/Tt6KjvJbhaif8LxewhNQAldiM5Api/fLvBQ==
X-Received: by 2002:a17:907:96a0:b0:ac3:d19b:e07f with SMTP id a640c23a62f3a-acad36a5b3fmr709244266b.41.1744489376145;
        Sat, 12 Apr 2025 13:22:56 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1bb359dsm649239866b.10.2025.04.12.13.22.55
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Apr 2025 13:22:55 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac2ab99e16eso633676866b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Apr 2025 13:22:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVu+yrJ2XVT7yaqsBIf3vtwW/xkFn6/HNCWjBYytt8Mzzb32s3V+JgHBS8KvRL9sb/k+PHqlDD+OVyKzNUw@vger.kernel.org
X-Received: by 2002:a17:907:f1e0:b0:aca:e220:8ebc with SMTP id
 a640c23a62f3a-acae22090efmr370708266b.25.1744489375035; Sat, 12 Apr 2025
 13:22:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whJgRDtxTudTQ9HV8BFw5-bBsu+c8Ouwd_PrPqPB6_KEQ@mail.gmail.com>
 <20241031-klaglos-geldmangel-c0e7775d42a7@brauner> <CAHk-=wjwNkQXLvAM_CKn2YwrCk8m4ScuuhDv2Jzr7YPmB8BOEA@mail.gmail.com>
 <CAHk-=wiKyMzE26G7KMa_D1KXa6hCPu5+3ZEPUN0zB613kc5g4Q@mail.gmail.com>
 <CAHk-=wiB6vJNexDzBhc3xEwPTJ8oYURvcRLsRKDNNDeFTSTORg@mail.gmail.com>
 <CAHk-=whSzc75TLLPWskV0xuaHR4tpWBr=LduqhcCFr4kCmme_w@mail.gmail.com>
 <a7gys7zvegqwj2box4cs56bvvgb5ft3o3kn4e7iz43hojd4c6g@d3hihtreqdoy>
 <CAHk-=wgEvF3_+sa5BOuYG2J_hXv72iOiQ8kpmSzCpegUhqg4Zg@mail.gmail.com> <CAGudoHGxr5gYb0JqPqF_J0MoSAb_qqoF4gaJMEdOhp51yobbLw@mail.gmail.com>
In-Reply-To: <CAGudoHGxr5gYb0JqPqF_J0MoSAb_qqoF4gaJMEdOhp51yobbLw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 12 Apr 2025 13:22:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh+pk72FM+a7PoW2s46aU9OQZrY-oApMZSUH0Urg9bsMA@mail.gmail.com>
X-Gm-Features: ATxdqUFGJ-r2ok5MOh_Re055tlx2zhUC_4ZHvO5jGJV_FifGa7Yruu_r-HNtF4w
Message-ID: <CAHk-=wh+pk72FM+a7PoW2s46aU9OQZrY-oApMZSUH0Urg9bsMA@mail.gmail.com>
Subject: Re: generic_permission() optimization
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>, 
	Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 12 Apr 2025 at 09:26, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> I plopped your snippet towards the end of __ext4_iget:

That's literally where I did the same thing, except I put it right after the

          brelse(iloc.bh);

line, rather than before as you did.

And it made no difference for me, but I didn't try to figure out why.
Maybe some environment differences? Or maybe I just screwed up my
testing...

As mentioned earlier in the thread, I had this bi-modal distribution
of results, because if I had a load where the *non*-owner of the inode
looked up the pathnames, then the ACL information would get filled in
when the VFS layer would do the lookup, and then once the ACLs were
cached, everything worked beautifully.

But if the only lookups of a path were done by the owner of the inodes
(which is typical for at least my normal kernel build tree - nothing
but my build will look at the files, and they are obviously always
owned by me) then the ACL caches will never be filled because there
will never be any real ACL lookups.

And then rather than doing the nice efficient "no ACLs anywhere, no
need to even look", it ends up having to actually do the vfsuid
comparison for the UID equality check.

Which then does the extra accesses to look up the idmap etc, and is
visible in the profiles due to that whole dance:

        /* Are we the owner? If so, ACL's don't matter */
        vfsuid = i_uid_into_vfsuid(idmap, inode);
        if (likely(vfsuid_eq_kuid(vfsuid, current_fsuid()))) {

even when idmap is 'nop_mnt_idmap' and it is reasonably cheap. Just
because it ends up calling out to different functions and does extra
D$ accesses to the inode and the suberblock (ie i_user_ns() is this

        return inode->i_sb->s_user_ns;

so just to *see* that it's nop_mnt_idmap takes effort.

One improvement might be to cache that 'nop_mnt_idmap' thing in the
inode as a flag.

But it would be even better if the filesystem just initializes the
inode at inode read time to say "I have no ACL's for this inode" and
none of this code will even trigger.

                  Linus

