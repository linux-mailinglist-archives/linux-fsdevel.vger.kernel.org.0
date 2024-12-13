Return-Path: <linux-fsdevel+bounces-37378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A29C9F1901
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 23:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E63637A0286
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 22:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DDF1AC892;
	Fri, 13 Dec 2024 22:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwjOxgTj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7410C1A3034
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 22:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734128503; cv=none; b=nImhvtbVdpPWcH+MISDtgWS2/v42vCt7erjnsT9sEdf7NngEpTTZQ9+CAk1tETMs/vLmro2XsUg/0IBpgIayrcuu71ex8QzagYEPXCTwzx92MT+x3YrDpBLdRwFttLtC3aNdiJLxhLePmADeDRJJdj2bd6XJVZxJakDFrMSEoNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734128503; c=relaxed/simple;
	bh=7hEKgAiW+Hv+ScDjui8o4RqGMJ4TdWymuli8VhsKMN8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g+3TYR4dIhzh559dcm6dmrW1f+fnwwkbhnLBMsMgxUMZjB/XQyUXMLtv0S3bRs1tUiaMEHsy8L3AeDlf2KxsT5WPeHLp7y/g4+0nTfWKW0DVTKehAahxmAuwxi2UnVphwTAOWRCL7rSZFvpt10vlA1e0EKlLOczpXipa9HWsOxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bwjOxgTj; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7f46d5d1ad5so1643578a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 14:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734128501; x=1734733301; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wqLYNgaFsfhCdC6ZHF4qPWqLcHB1iEwLOJKG4uK8Pj0=;
        b=bwjOxgTjvgcnC2uZpyfkMQGl+w89VNCQKRMRI3pEWXpxOxeo9ROLC2KcxjYEK5uC+f
         tP8w9e16CJ/XahIohJUDNDyToLjJ9/zBYQPgKjqm3nGlvmEU8XMEEBUnMHIzgnEY9zOr
         0a6dARIEDmtoP8MNHgkw+oq0VQ8ygR748xuHHK4zyPK6tsTcSz2W6A8QgrsUklH6FRfk
         heN9DJw2igJTKDvA7x5WRDWDi/242tfHOfB/iDDBI8HF0cMTbb8+j1o7WBffoAgUkN/V
         7rZLghg36uDL0XYuJayWf3KHzJID/QY003D5E7MMiKmaCTYRea772xCIjXWBSGbqDoEd
         ZZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734128501; x=1734733301;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wqLYNgaFsfhCdC6ZHF4qPWqLcHB1iEwLOJKG4uK8Pj0=;
        b=unRKqaskhyywGOts20cdrrXzpE5SrZ8QkiLXw0NxcywtGO19CTHCbbyAOzbk7aHTQU
         nRtjHY9FqIuGsRmxoIpJOlrZ5cAGITNMkQYpgFFPXt1my1IJLfoVpJt39AoTCLNdomnN
         9qh+6g6HrUMGgMI6JACxNfY02WOiohegdiyp0dcDYyO+19h3ziztzlTby1yD05NcV80/
         1kESf1LP+JyTi5TDuAhwY72Hj/G5AdSWq5hLM52aXGOQOTRzEfjd14Bj2Q4p3iq9zL2c
         l9FLCQmlaPZ1RVFawk0sKcg8mF+H8tvqeLDBB2Mb5nbzW/vMNpxstLHjRzo2+ILFsbSN
         L39A==
X-Forwarded-Encrypted: i=1; AJvYcCUoAmXSCbPNJwo8DCXmsjqtgv3cvcCkLV6v+nxbETHJiJomZAdZl5S/5VvX5Evha/pzml+C6d+tfS2bO51t@vger.kernel.org
X-Gm-Message-State: AOJu0YxueF+eFH1MhYGz7kmR3xAyy/Z1lzIBLfLodSkP48TEWF59fk6C
	1Xha5OyDNdt78T8hC20O0xY7jcrsfMXQi1qVQWIqULQb+L4hPc6o
X-Gm-Gg: ASbGncuyxlQUefF2vLIowPcenHfrhR22PPutyH5abNc4O3wEBaCXjwTvy+aW2qt7P42
	XlVSlJT9lUvrkEuB/k5qvlGgzHiM6mPnKE42jGNPw01pCTU67/47ihEx3qt5o4vUQDw1hESvZ2x
	YWrP0YBDum/VrccavMUf1Mta+/cODKm41C7xWzF3C0693jmNfGYrZ/U7Lh0KkykCH1FwLO1KFnU
	kmEUah7L3F6n54mUB86/tStuN6A1NT+JtXBHajYq2/a41XERirA5VqgV6Vd21ZbKBPNuzcHHPCG
	IP5rSHdLMnJ1L8bOUWzscojBlRdD0hxTsuCbF2bi3lc=
X-Google-Smtp-Source: AGHT+IFhh015tdWX9bBaiS6A5cK5GzjNQ0bQgLvyZteLyIrbh989ImvXOXFjQPgnbCFgKEhMRO+e0w==
X-Received: by 2002:a17:90b:3891:b0:2ee:8ea0:6b9c with SMTP id 98e67ed59e1d1-2f28fc67526mr8230463a91.12.1734128500702;
        Fri, 13 Dec 2024 14:21:40 -0800 (PST)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2a2449c45sm265640a91.46.2024.12.13.14.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 14:21:39 -0800 (PST)
Date: Sat, 14 Dec 2024 07:21:35 +0900
Message-ID: <m2o71f5imo.wl-thehajime@gmail.com>
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
In-Reply-To: <87r06bz1uf.fsf@email.froward.int.ebiederm.org>
References: <cover.1733998168.git.thehajime@gmail.com>
	<d387e58f08b929357a2651e82d2ee18bcf681e40.1733998168.git.thehajime@gmail.com>
	<87r06d0ymg.fsf@email.froward.int.ebiederm.org>
	<m2r06c59t9.wl-thehajime@gmail.com>
	<87bjxf1he1.fsf@email.froward.int.ebiederm.org>
	<m2pllv5lb3.wl-thehajime@gmail.com>
	<87r06bz1uf.fsf@email.froward.int.ebiederm.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII


On Sat, 14 Dec 2024 06:53:44 +0900,
Eric W. Biederman wrote:

> >  config BINFMT_ELF
> >         bool "Kernel support for ELF binaries"
> > -       depends on MMU
> >         select ELFCORE
> >         default y
> >         help
> > @@ -58,7 +57,7 @@ config ARCH_USE_GNU_PROPERTY
> >  config BINFMT_ELF_FDPIC
> >         bool "Kernel support for FDPIC ELF binaries"
> >         default y if !BINFMT_ELF
> > -       depends on ARM || ((M68K || RISCV || SUPERH || UML || XTENSA) && !MMU)
> > +       depends on ARM || ((M68K || RISCV || SUPERH || XTENSA) && !MMU)
> >         select ELFCORE
> >         help
> >           ELF FDPIC binaries are based on ELF, but allow the individual load
> 
> You have my apologies I was most definitely confused.  BINFMT_ELF
> currently does not work without an MMU.

no problem.

> >> I just react a little strongly to the assertion that elf_fdpic is
> >> the only path when I don't see why that should be.
> >> 
> >> Especially for an architecture like user-mode-linux where I would expect
> >> it to run the existing binaries for a port.
> >
> > I understand your concern, and will try to work on improving this
> > situation a bit.
> >
> > Another naive question: are there any past attempts to do the similar
> > thing (binfmt_elf without MMU) ?
> 
> At this point what I would recommend is:
> 
> Merge your original patch.  Get nommu UML working with binfmt_elf_fdpic.c.
> I think it is a proper superset of ELF functionality.
> 
> Then I would make it a long term goal to see about removing redundancy
> between binfmt_elf.c and binfmt_elf_fdpic.c with a view to merging them
> in the long term.
> 
> There is a lot of mostly duplicate code between the two and
> binfmt_elf_fdpic.c does not get half the attention and use binfmt_elf.c
> gets.

thanks for the recommendation.  I'll go for this direction.
It would be great if nommu arch (at least) UML can use the regular
binfmt_elf.

-- Hajime

