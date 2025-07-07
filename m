Return-Path: <linux-fsdevel+bounces-54181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C24BAFBCD6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 22:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00B091718FC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 20:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D31F220F5A;
	Mon,  7 Jul 2025 20:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="U0IXC1jA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001281F3BB5
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Jul 2025 20:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751921572; cv=none; b=pjmBHxNuH0vojWkg9P0sHEotG0X3dZZ4OQnA3SlzhQe3zElWVXRb7GoBEUKW5EccBAU20TJ8AgSssv5qP/tMvToD1DRL0EkqCKrZ/fNncQtiJSBIwTh7h7Odbr5pPTZ8JSine2GDSll0oOQSPy7PAxj7UWlIHcuEdB9Hbs1PQ5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751921572; c=relaxed/simple;
	bh=w4LMaLeRrNUt8MnSnBqzz6rdwlBMRKy37DBLGqqWJUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j0dKAIWikIi5oBMk+jWT4Z7RWJKEVTub9CVBGGOnhtfBI1DanT/TIUM0j43S0eAseJyCffVvxENWstzInIOn/0U/2+r+8qrRTOEVIdotTxxNK7hnztAwz5p3qPcUdU9NoYoMK7RZ1DuqcGR7TueQUMiW/WNaQTbuOuRyOot2UxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=U0IXC1jA; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae0de1c378fso554960566b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Jul 2025 13:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1751921569; x=1752526369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQX6DWwky1AfWY62rql4bar7jqcjE9npDiMLJ4boazs=;
        b=U0IXC1jAc4THlA1H3UV1yHCeZuq4SJl9FcTUDBAvfxTH+Szw13RxD7c4tqeSIj+k0r
         DveztMEMHOaZ8MFd3T3jdHS/khSNNRhXdxxRO5I2pzNYRoOiBtj8juOfIA4IBx8He0ky
         +Zuvf0gMZSdGNP2gZDSRI0VQgJi6sfi+sAxpmzJx6nGtvxZGAQzs0ZhBim1TokyQR+to
         +HXk0g+DPYJyzPDLBdcRJnpTVxivvKOBhH1Sa9mJzGkypUX68J9QPfISv1i91Gad2mOO
         ZsLov9zMU544WiZCFyiF/F/+eEO/+B+Q50muzsoMGXpJUwaGfvmHWlRYIqhvaIYWsN/c
         wM9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751921569; x=1752526369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQX6DWwky1AfWY62rql4bar7jqcjE9npDiMLJ4boazs=;
        b=VrTTojnk7J5ShIasBYhrUVIOJtHPBiIzeEpOvwDaem8ZM2L6b8yzlZ8uIR5ZUIU/od
         zsNa5bwYI/ZhGlCMUgbbtntVbDJ7gq8nj12HYuaTGJQ4/MsTBUaOC+rBIYFKQJRA9MZK
         GWj7ijuvZ0iH9loh5skpjhyR7Zv3hE/9W01kb5heRHqbGuEFnSYNeEJSGSGaYuH2gWO6
         DotBVP++OaX46Gm6K4o4PMSqqt6nMDPGli7a6efuXACTa7Y2FmTzyqNjStkPjaT7VN9N
         c3wvu1jhhnRwBJ2R+pDkCpVdbi5FjALfhG4ubi0Hkw2fcb1d2GdCZbl+EkN2+fMoQVo1
         m7nA==
X-Gm-Message-State: AOJu0Yx9KRbW9q7l0/rwnwzdOUnQ+iECPktMKLrHUp43/nFozcW0lJiT
	pRBD34wyfElhetQ64XQo/iKQuWAVV9xjI1Z4Cy34c9isDoipy9LIsU2zoBLYV9LzzxfCjcQRT3w
	j3/svGXhtxN8s8QT8POpzzV/zplt5NAd9ynY4mEF/8Q==
X-Gm-Gg: ASbGncsOySz7tjBILZz2weGIMw6wwZY0B7AwKj+Lb9Ez0zQUFP24LBJC6MTpnwATCbn
	hJLgs8YehA4hxoqlA4f3ItQYHA5juTktpKHDjo/wegYfxSRzS2cX0Rj4ZFu/+6q3mDrlQfvWZqc
	o7XfV7Qbsc+sGsAGvrQR11oUu0PGkWcum9oRPLPS7Yr1hR00NiQN4pmJZrOfKaKPBqk9emmR8=
X-Google-Smtp-Source: AGHT+IFz7LLRL+vSkM9BHhKuuFvAjHAjvLNSo3W/iB1OKAwjLhyy+s/thk9HVFgNxjipAfhMgs5m/WJufsZcLUcjF6Q=
X-Received: by 2002:a17:907:d1a:b0:adb:45eb:7d0b with SMTP id
 a640c23a62f3a-ae3fbc54d9bmr1466680666b.15.1751921569342; Mon, 07 Jul 2025
 13:52:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231124060422.576198-20-viro@zeniv.linux.org.uk>
 <CAKPOu+_Ktbp5OMZv77UfLRyRaqmK1kUpNHNd1C=J9ihvjWLDZg@mail.gmail.com>
 <20250707172956.GF1880847@ZenIV> <CAKPOu+87UytVk_7S4L-y9We710j4Gh8HcacffwG99xUA5eGh7A@mail.gmail.com>
 <20250707180026.GG1880847@ZenIV> <CAKPOu+-QzSzUw4q18FsZFR74OJp90rs9X08gDxWnsphfwfwxoQ@mail.gmail.com>
 <20250707193115.GH1880847@ZenIV> <CAKPOu+_q7--Yfoko2F2B1WD=rnq94AduevZD1MeFW+ib94-Pxg@mail.gmail.com>
 <20250707203104.GJ1880847@ZenIV> <CAKPOu+8kLwwG4aKiArX2pKq-jroTgq0MSWW2AC1SjO-G9O_Aog@mail.gmail.com>
 <20250707204918.GK1880847@ZenIV>
In-Reply-To: <20250707204918.GK1880847@ZenIV>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 7 Jul 2025 22:52:38 +0200
X-Gm-Features: Ac12FXza6Ve6i3S9iai1HVq2DanhfayOa8Ja1g8MIYwGRVUCuy833ZmYwL2Fkzo
Message-ID: <CAKPOu+9qpqSSr300ZDduXRbj6dwQo8Cp2bskdS=gfehcVx-=ug@mail.gmail.com>
Subject: Re: [PATCH v3 20/21] __dentry_kill(): new locking scheme
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 10:49=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
> Yes, but where does that ceph_evict_inode() come from?  What's in its cal=
l chain?
> Is it several shrink_dcache_parent() fighting each other on the same tree=
, or...?

I described that already in my first email, but here you have a full
kernel call stack (in this example, the shrinker is invoked from a
user process due to memcg pressure):

[<0>] ceph_evict_inode+0x232/0x2d0
[<0>] evict+0x104/0x2a0
[<0>] __dentry_kill+0x74/0x190
[<0>] shrink_dentry_list+0x107/0x3a0
[<0>] prune_dcache_sb+0x51/0x80
[<0>] super_cache_scan+0x130/0x1e0
[<0>] do_shrink_slab+0x156/0x670
[<0>] shrink_slab+0x48e/0x8a0
[<0>] shrink_node+0x32d/0x870
[<0>] do_try_to_free_pages+0xaf/0x500
[<0>] try_to_free_mem_cgroup_pages+0x10f/0x290
[<0>] try_charge_memcg+0x182/0x880
[<0>] __mem_cgroup_charge+0x3e/0x2c0
[<0>] filemap_add_folio+0x41/0xd0
[<0>] __filemap_get_folio+0x194/0x310
[<0>] netfs_write_begin+0x98/0x540
[<0>] ceph_write_begin+0x27/0x50
[<0>] generic_perform_write+0x97/0x2b0
[<0>] ceph_write_iter+0x4f1/0x650
[<0>] vfs_write+0x269/0x510
[<0>] ksys_write+0x65/0xe0
[<0>] do_syscall_64+0x82/0x130
[<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e

