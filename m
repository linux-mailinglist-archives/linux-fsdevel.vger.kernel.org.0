Return-Path: <linux-fsdevel+bounces-65009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A57BF9061
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 00:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DEE3B3534C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 22:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC76B2BCF7F;
	Tue, 21 Oct 2025 22:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="39kj7JE8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7B028726E;
	Tue, 21 Oct 2025 22:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761084910; cv=none; b=dNW8tQ72YbgwRSIYN1nGZ7llMgwSrUDwSECdwdEAMiT0Rf7JLICM4ezbWuxMdYH6s1MtQOaBEwM3XdIjt4UAm2aw8md52MpukkHBeL2lm08R2zFi+OUQyMFHG4IS9vk6GJqGQvV8tfqJ135sC5Gfew7cGj186W2RH/mFcPhCmLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761084910; c=relaxed/simple;
	bh=ldQAI4BRJFmmqy3xoslndrgZGiE2rVoT8TBMFRA/xjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EX9rk1Bo1vAncrZiFdSQUPJLcIHhXiaUU57s9GjkuNmyo91FFx9yj8Rrd8Teo//tZ3QIl9YRvt6KGsd4pxqV4PalB315UHuj8qb3fANvZKKR1s/MrHMRvJd7rzUSh6wJYm7wMcVzRsK8EjM5BZJPumf+/5OeDP9uFaCSpDs+e8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=39kj7JE8; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id CF92E14C2D3;
	Wed, 22 Oct 2025 00:15:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1761084905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PNRzJByaf1w3cRLviNXJCnTJ87QZjB0GM+XYE3IMdz8=;
	b=39kj7JE83CSnRM+StI16XqiYKI75TQS2QjVxky6X9LakUU/AEky+GDyYbHpPcUKuI+BTfz
	3SruiX8w9dYW7apSTHMJpUKZVFVXsmNVTp7ATk5JEQWbY+XQIuXpHate82Sq8JKh7k9Xuv
	g6I45etMSlW+xz5PHOfVu6LiKfF4JhKiCw0h3VbleT9lixLWWWiWLOv3PjvP+g347ZjDxM
	5NRRofx/QymecJ+t47tEkb+Ny5c54tB39SvAk1GEcotPercOP8s9GT5HRVZIU6U4T0TKhV
	MkWe6neA1TuLzXgnn1qhRFcDUm5oYe1ywYyOZOa0SRcqF5Wxv7V4IDUL/SnOvg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id d6a04676;
	Tue, 21 Oct 2025 22:15:01 +0000 (UTC)
Date: Wed, 22 Oct 2025 07:14:46 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Xing Guo <higuoxing@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	Jiri Olsa <olsajiri@gmail.com>, sveiss@meta.com,
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: strace log before the fix, with fsync fix and with fclose fix.
Message-ID: <aPgF1u8OaMkWvWK2@codewreck.org>
References: <CAEf4Bza6ynjUHanEEqQZ_mke3oBCzSitxBt9Jb5tx8rxt8q4vg@mail.gmail.com>
 <20251020085918.1604034-1-higuoxing@gmail.com>
 <CAADnVQLDQpNEa0bT6nyX3UfGTE94YxrM4gPD+PirmqHwXRB15Q@mail.gmail.com>
 <CAEf4BzZbCE4tLoDZyUf_aASpgAGFj75QMfSXX4a4dLYixnOiLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEf4BzZbCE4tLoDZyUf_aASpgAGFj75QMfSXX4a4dLYixnOiLg@mail.gmail.com>

Andrii Nakryiko wrote on Mon, Oct 20, 2025 at 01:12:16PM -0700:
> So unclear, which is why it would be nice for FS folks to double
> check. It's certainly a change in behavior, it used to work reliably
> before. [0] is the source code of the test (and note that we now added
> fsync(), without it the test is now broken).

It's a 9p bug, sorry.
tentative fix:
https://lkml.kernel.org/r/20251022-mmap-regression-v1-1-980365ee524e@codewreck.org

other thread with repro:
https://lkml.kernel.org/r/CAHzjS_u_SYdt5=2gYO_dxzMKXzGMt-TfdE_ueowg-Hq5tRCAiw@mail.gmail.com

I'll send the fix to Linus once someone can confirm this works for this
usecase as well (and try to improve our testing a bit... maybe just run
the bpf test suite for starters)
-- 
Dominique Martinet | Asmadeus

