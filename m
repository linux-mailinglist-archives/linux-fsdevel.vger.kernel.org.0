Return-Path: <linux-fsdevel+bounces-27358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A284B96091C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 13:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 603E81F244CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 11:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C2A1A2C12;
	Tue, 27 Aug 2024 11:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vs16pudN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD77E1A00C9
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 11:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724758866; cv=none; b=Cg/iQNm2eiTe3f4TO4YgKZ0cwn99aY0G3zkKfX5j6qaj4MF4vM/F7152OGpr1BHgJPgEo3clUnwiBUiVJJtUcX7+dKJqYFfbWknPKLLp6aphVCUWVMYw+tJ8FGzo9MV60FsnINA+J13ujjDShxY8IKbWISCdH8nULs9TwsjXcpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724758866; c=relaxed/simple;
	bh=ic1TjHHCwiAO3n+kXu6PMjvoD055u5QT7EvE2Cthyf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FGTEdsa1wXCoORCuXzXc9Bm3qWsFZxEsH/M4QwXimok8T7U2LNvjAiTmfmaJn/INngrCpq0z/m4SoeK9J88FiWXNjWcH/ZtSUJNXWVXqiC9rwz5CYdyy71FWf5IQZtR/bgRZ1H7ERyZwUCviIJ7y4XL32vZ9Lx4KVRjEN7/JJVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vs16pudN; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2020b730049so41590505ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 04:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724758864; x=1725363664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ic1TjHHCwiAO3n+kXu6PMjvoD055u5QT7EvE2Cthyf4=;
        b=Vs16pudNnsdtnEl73wZz5QMkL176Y1Zh/Fk1LrCuRfl9ipb4xxfcA5LfhWjWhvbo7t
         scXJe40+rBTybD7F+H5uUAC9rkmYc7R+y0uu4/sWsLi9JGySpglsnjjAN4wroMZ6hRGl
         wa8XMb0ko7E48PdgQw2g1htX/0hfeNZyzHm22YeVvQpKdx3tzwMZ3q1tIWN4kB/tz6pM
         cDyloVWuBtLAwbFZz7CS+ahhGKxlEYD3cpsCuktJPitkcy0gX8MyQ3luY0Ocqe25HEv3
         S7d67etnTELSxrI9mAe3u8Z8PN/7R0rhUVloFgnVMJymITAZOEeE9H7+kaCuaKSFMsoa
         6vPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724758864; x=1725363664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ic1TjHHCwiAO3n+kXu6PMjvoD055u5QT7EvE2Cthyf4=;
        b=M+es4D1Nn/WrtPdspZndJ1gLaYaIeM2BKTEmX0ywDGWezhNW8HWfyBX/rBI29OooYX
         DBHjwSbFCoP/fexTxRUg1NKamy047j+7rV41hS4MAwMNHop/Rxbw/XLptzS8rqPWp8uE
         en3nh/bedlZCodAfqsPnDIfBqttDzbsehdc0WRrL7utZIaJztnM+DmX5RPavXvQWtWD5
         afao7M6veLLlyLxUvO31Yg4TEiB4XuQ2cxSh/iyl81kSO7haWDs1v3f16z91zIpVgZqc
         2L4BxuPPoXGno0XDw7QTUmm1DRtiJP0MLt5wlKFrq2d3+MNXQLnufmgMi6kliCNGqhfl
         yhYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHi+wLidv6h+TBlLjtW0wXRHkQgFmTGybBgHAsL2jWsa8OuYjJsfAWDEqqW1Bwa/XsPi15QWOHadEIeQZR@vger.kernel.org
X-Gm-Message-State: AOJu0YwkMh4WhGulommsC74gZK79qzj6VuhfCFYEv8KirZJ3+UPOwd1Q
	PGL1rsw9ySrLRHmlzoJEu052A1U0xRuc6Vu+/QK2wnjBfthmucpWJnvhLdV4VJTYA9bLeae+7NC
	I31E8J2bYwEiyO+5M4PNgVg5PSDT/infkzPR1
X-Google-Smtp-Source: AGHT+IG04JrGD6kdcZPMN0hf7XIpw/QNrjq/J6phLsQZ/V++jHPx6aJM5lCRImy/Aen1tbnoYSBDPSY3y+t8EfG56BE=
X-Received: by 2002:a17:902:ecd1:b0:1f7:1655:825c with SMTP id
 d9443c01a7336-2039e4ca7c3mr132078745ad.36.1724758863636; Tue, 27 Aug 2024
 04:41:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000008964f1061f8c32b6@google.com> <de72f61cd96c9e55160328dd8b0c706767849e45.camel@gmail.com>
 <Zs2m1cXz2o8o1IC-@infradead.org> <9cf7d25751d18729d14eef077b58c431f2267e0f.camel@gmail.com>
 <Zs26gKEQzSzova4d@infradead.org>
In-Reply-To: <Zs26gKEQzSzova4d@infradead.org>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Tue, 27 Aug 2024 13:40:52 +0200
Message-ID: <CANp29Y4JzKFbDiCoYykH1zO1xxeG8MNCtNZO8aXV47JdLF6UXw@mail.gmail.com>
Subject: Re: [syzbot] [iomap?] [xfs?] WARNING in iomap_write_begin
To: Christoph Hellwig <hch@infradead.org>
Cc: Julian Sun <sunjunchao2870@gmail.com>, 
	syzbot <syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com>, brauner@kernel.org, 
	chandan.babu@oracle.com, djwong@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 1:37=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Tue, Aug 27, 2024 at 07:13:57PM +0800, Julian Sun wrote:
> > Did you use the config and reproducer provided by syzbot? I can easily
> > reproduce this issue using the config and c reproducer provided by
> > syzbot.
>
> I used the reproducer on my usual test config for a quick run.
> I'll try the syzcaller config when I get some time.

FWIW if you just want to check if the bug is still present in the
kernel tree, you can ask syzbot to build the latest revision and run
the reproducer there.

#syz test

