Return-Path: <linux-fsdevel+bounces-37273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA619F0562
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 08:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD717168D88
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 07:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F93318E750;
	Fri, 13 Dec 2024 07:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMh9/VNN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246151372
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 07:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734074393; cv=none; b=cNfXJXw74gRiqTY/CsOPkYPK44WxZCiJR/NydCKGsxiflHNsB5enS4zZPT+cTGrPjyxDznqYLvf2A5nZGXZKmEgp2FF/O52ymDkDZkscPIW4sdfN9LMIQkbay2br53WvvbS3wYFPvXv7LsieKMMF5G6IYjgVos36rn8lItFrNyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734074393; c=relaxed/simple;
	bh=rFCJRzs2DcwdwB9sb5u6nGdzoZqHonmIqP3i/yhPy/w=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NIJDuAjwRIBufd5wfOLwLULEvOWCG2FHX2EhEgI3SCyoe5bc6sr7HJmcuj1cTyTjnu4dBLOI3jvJWA9YBeEHZNNNlIcR+yjRdv8tzeDM8SEKpucmlQkG+WO0QowjeLx92m+ZwiVEucN/OBq7hkLNco6n6j0C4dCn0X0cJ5Re2X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMh9/VNN; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-728ea1573c0so1246604b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 23:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734074391; x=1734679191; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/vScXgcTqsyhMOd0iR3wquLB4CKZKhnJgSRF2gJO3wY=;
        b=TMh9/VNNdgZm2iCDyDK70ZsL2EB9FNUaocUK7KDvMfzuTWVLyqW2zfgO50uF3TIJ0l
         HNS67mCXEkh1auyupwTj06LlBM4TJeaTxM46qpDY6QnC/k66D9IBOjVXXyuyKz8wJidQ
         8akuEfcwDSJc+Bk4BlaGfVaSqrihxtCqIBAjFOp//ErJnBnnLSASKF//oTrapW3QRmbA
         3MkTI8BxK9XvUjfTqt1vg5cObkDfEOSJnxDwKT/B2kSzTmLcmiDYTC9y3UO1/ZGMmPdg
         v0111kj4ZyIsOleWmywpaX/Z+h4z81Ilu0hYWEQgR6SI7dryhP1HsfesfBZOcP7b4/pG
         Xcjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734074391; x=1734679191;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vScXgcTqsyhMOd0iR3wquLB4CKZKhnJgSRF2gJO3wY=;
        b=ruU6d0dPJyAc7j1Zu1s4w2HJEZWBFbU4FxkblW1G3CkuGAqudx1nKoo/YtAMzrfLhd
         7EAGADDQ2T0HHfLx34vPLHjdvJ9tWgpYrP2UAIlVrdt+DmAbVP2fPfDFSXfaKYUSPq/0
         3BMCngG0q7ZyD6w9S6k7gM9QTtvr78eSOAkRG1HWLmGv4KbTO0aNzsnxUL3VVAbynZXZ
         Kd1fZaHIF4qQcTHPn8n6lUIC/c7VCrCs74A/9f5dGbgwA1UtZT7mOEP51hPK21WyN01B
         4EnjL3oIVkMY+EWCC97NhHGAl0H3CAlYaeluOz45X1WHJGWeXQuBwi1FupDJK7lzVKNL
         o0Og==
X-Forwarded-Encrypted: i=1; AJvYcCX4Fbxp0RXwRUmuCom6CbZasL/Rh+kbdT70HSJgIltGp7paPEt2LhxgA66sRZEpxcLpBtqFc6hu+eiXwXs4@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7/07wpJuizqXas5SrQGRbSNoYcVoGGdJsWvCEXbd4lV2DaKUn
	oBbNFdkApjrWRwYkjz5lWK+0h6yy3otZ2USN08EAL6pIL/4r/o7x
X-Gm-Gg: ASbGnctEuHB8G6BBQ0MX4TjxDA+f8PRiyE9Xszc6B7wpQ9MwhiP5Gpg//ypRwtgbOvf
	Z0MQk4CU5du6pRqGEMjAelF2naoW3acL0X7anElF2mH8FsQhkaN3/n1ibFDYIyTitE9OhNT/de1
	HnPGPa4dsYNuCyXIaeshjcH2G8BMqezQS6ndlIXfL3X5KbK1qiKLMeuNtM2ujnEQPG1FA7hzpqZ
	OlBciNHB8R8CunwouUZTXavHrSYh3hC59sHLDEza+PCFybhHu8HGbtTipGRenaTJXLwtbhG6HyF
	AWt3pDZe2++liVOH0A0cUYI4PmETfrHZQgQfhNhwEBFpx8Na
X-Google-Smtp-Source: AGHT+IHIc+AAtt3sr4T1GtwqdHMtSVSWX5aosI17cxg3x5s92xDXSiqKxcV+dY6R+QBB/DcfnPzLHA==
X-Received: by 2002:a05:6a21:3a94:b0:1e1:b014:aec9 with SMTP id adf61e73a8af0-1e1dfe6a0c9mr2940346637.29.1734074391232;
        Thu, 12 Dec 2024 23:19:51 -0800 (PST)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725d899efe4sm10403960b3a.161.2024.12.12.23.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 23:19:50 -0800 (PST)
Date: Fri, 13 Dec 2024 16:19:46 +0900
Message-ID: <m2r06c59t9.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: ebiederm@xmission.com
Cc: linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	kees@kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 02/13] x86/um: nommu: elf loader for fdpic
In-Reply-To: <87r06d0ymg.fsf@email.froward.int.ebiederm.org>
References: <cover.1733998168.git.thehajime@gmail.com>
	<d387e58f08b929357a2651e82d2ee18bcf681e40.1733998168.git.thehajime@gmail.com>
	<87r06d0ymg.fsf@email.froward.int.ebiederm.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII


Hello Eric,

thanks for the feedback.

On Thu, 12 Dec 2024 23:22:47 +0900,
Eric W. Biederman wrote:
> 
> Hajime Tazaki <thehajime@gmail.com> writes:
> 
> > As UML supports CONFIG_MMU=n case, it has to use an alternate ELF
> > loader, FDPIC ELF loader.  In this commit, we added necessary
> > definitions in the arch, as UML has not been used so far.  It also
> > updates Kconfig file to use BINFMT_ELF_FDPIC under !MMU environment.
> 
> Why does the no mmu case need an alternative elf loader?

I was simply following the way how other nommu architectures (riscv,
etc) did.

> Last time I looked the regular binfmt_elf works just fine
> without an mmu.  I looked again and at a quick skim the
> regular elf loader still looks like it will work without
> an MMU.

I'm wondering how you looked at it and how you see that it works
without MMU.

> You would need ET_DYN binaries just so they will load and run
> in a position independent way.  But even that seems a common
> configuration even with a MMU these days.

Yes, our perquisite for this nommu port is to use PIE binaries so,
ET_DYN assumption works fine for the moment.

> There are some funny things in elf_fdpic where it departs
> from the ELF standard and is no fun to support unless it
> is necessary.  So I am not excited to see more architectures
> supporting ELF_FDPIC.

I understand.

I also wish to use the regular binfmt_elf, but it doesn't allow me to
compile with !CONFIG_MMU right now.

I've played a little bit with touching binfmt_elf.c, but not finished
yet with a trivial attempt.

sorry, i'm not familiar with this part but wish to fix it for
nommu+ET_EYN if possible with a right background information.

-- Hajime

