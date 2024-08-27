Return-Path: <linux-fsdevel+bounces-27362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7140C96095F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 13:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA7BAB23D35
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 11:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6033E1A071C;
	Tue, 27 Aug 2024 11:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6VHObzs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7844419EEA1;
	Tue, 27 Aug 2024 11:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724759789; cv=none; b=qAUZnitd3qBjccRg2BNvuefUozpyj+0+GMgDZy3MpsJdyIwKWYZ/iCLeiZz6/Luu1FgMtSmXIpiJ8b1tRBL1SVyFrNJTQDblZfHBiWhQnmaik6Yt5NqP0kT8V0F7S4T/9rETEGWpbc+gsCqaS6L0NxZ1q/6rMJOmmXlC6TZqTMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724759789; c=relaxed/simple;
	bh=zIIlH/1eILLEKC06D2I1Pu2PIAcknVoKtcQdLzlTRIQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LbXlCjyVhBGqp5TdNKx5b1p2cSZZ53VMryPOUCGVcSHjyfJGR7Mz8B+KxuZXUECaNZutZk8J2/2xaQiIMCdSeFwLaFx2ra7LNXYgwF4lbxEA6hlm5c7rofiH+L46Lee+0QkY7Y0JD5v08JaSThchJOc25z5aZ6ezg0wtv//i8Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6VHObzs; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20219a0fe4dso52890125ad.2;
        Tue, 27 Aug 2024 04:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724759788; x=1725364588; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zIIlH/1eILLEKC06D2I1Pu2PIAcknVoKtcQdLzlTRIQ=;
        b=O6VHObzs9aPDh8jJDNgkJeEljhlLYo/NZZtdElundiEZExvr+CwLBw9UzPLJ4Is5Vv
         QQS2Y2nxjaivvu1RvX+MIF0fD+m6xbhmK4h68upsS55xEBmo8L7gH6poBqIqW2CGRlT+
         q6LrJMdPFh7hGKn+upCvrkCYUR4gYH7/XQBjZcriNm0bQXwl0iFxifySvR789hY2zMbc
         aV6kqQ4t5tu/ijuV9Z3B+BhS/MxA614EzSBXI/TeQtF8T0z5qC0VByjaqb27Lf2gY1WP
         AHOVdbyogFLaiqhwXM1YZjszfKSLzKn4ymV2pfe+EDhdOCJRUhMpmOuoESsQEz4ltmF5
         Kpnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724759788; x=1725364588;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zIIlH/1eILLEKC06D2I1Pu2PIAcknVoKtcQdLzlTRIQ=;
        b=GVaOAXu1Jn0EXuPJKCLV6bJtcyvZyx9TOSJBjcJFmZVdERlAsho8VNLXkDxg0Fv+bu
         AMNbD5jB2PNTW9wo+fPvgCzSbk2b3pL+PhRs+TjgbPSqSUh29Px79+6Ly295lyY75sWo
         aWv5vqu8EMChE/N/+NlwWQe+GXtCM7T0Jm+jk+Oq9OeNW0SKmz8c1Vho63yfICvftMKo
         nWggRH2IcWhVKjFg+OHeB1/8zfjHTGzI17yMBTHNPkXQcy/qbJUWotvhfh9Wwnqz0QS0
         iwZbxape74FhxQ0h7Mq8E1Rys3e/d+/J+zGC05M97HVJttqGVniqvDvKbEftk3SaiiKO
         8EjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUibON1oz3B7S1xzgcfkZH51gv+SD7GVojfmCakr+Ln0rsmjns4hHnYoJDBJxw12adXsWqaQaB0KxeK+tsX@vger.kernel.org, AJvYcCVdJLGoVhp2W6QDNIoZ9zKX//+3ULQHV0dbbig7Szb0Nhbk6pAsPd91y4mIr8vgohui4RjGurkpXlVM@vger.kernel.org, AJvYcCVs2QppsrgMszJ6X0MbIS3GFz2niifmwwokjaNPZ/5qFp8sRaLTaKNAqVY3xkMVDKKgo2gc61hGZARXuovg@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi2hLAJiElIRduopg/bC+4ilfoahbkWnqg2j74HVicmgfGPQK2
	R5YNDps1D7pdY2Y31O5OHYOAymJB+X4TJ0mOirmTN1cFqlgN3ZXC
X-Google-Smtp-Source: AGHT+IGFqLm2BIcPsAt/sy3YXl5oqvh5sEArYUg39s0DaeC+Ji+3QjFB5YAZ03tyGp01X7XC+OKIuA==
X-Received: by 2002:a17:903:41c3:b0:1fb:8c35:6036 with SMTP id d9443c01a7336-2039e44af01mr146880295ad.5.1724759787386;
        Tue, 27 Aug 2024 04:56:27 -0700 (PDT)
Received: from [127.0.0.1] ([103.85.75.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038557e895sm81794195ad.71.2024.08.27.04.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 04:56:26 -0700 (PDT)
Message-ID: <0bdaf103f5f8de02a48b33481f787c4ac8806df5.camel@gmail.com>
Subject: Re: [syzbot] [iomap?] [xfs?] WARNING in iomap_write_begin
From: Julian Sun <sunjunchao2870@gmail.com>
To: Aleksandr Nogikh <nogikh@google.com>, Christoph Hellwig
 <hch@infradead.org>
Cc: syzbot <syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com>, 
	brauner@kernel.org, chandan.babu@oracle.com, djwong@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Date: Tue, 27 Aug 2024 19:56:23 +0800
In-Reply-To: <CANp29Y4JzKFbDiCoYykH1zO1xxeG8MNCtNZO8aXV47JdLF6UXw@mail.gmail.com>
References: <0000000000008964f1061f8c32b6@google.com>
	 <de72f61cd96c9e55160328dd8b0c706767849e45.camel@gmail.com>
	 <Zs2m1cXz2o8o1IC-@infradead.org>
	 <9cf7d25751d18729d14eef077b58c431f2267e0f.camel@gmail.com>
	 <Zs26gKEQzSzova4d@infradead.org>
	 <CANp29Y4JzKFbDiCoYykH1zO1xxeG8MNCtNZO8aXV47JdLF6UXw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-08-27 at 13:40 +0200, Aleksandr Nogikh wrote:
> On Tue, Aug 27, 2024 at 1:37=E2=80=AFPM Christoph Hellwig <hch@infradead.=
org>
> wrote:
> >=20
> > On Tue, Aug 27, 2024 at 07:13:57PM +0800, Julian Sun wrote:
> > > Did you use the config and reproducer provided by syzbot? I can
> > > easily
> > > reproduce this issue using the config and c reproducer provided
> > > by
> > > syzbot.
> >=20
> > I used the reproducer on my usual test config for a quick run.
> > I'll try the syzcaller config when I get some time.
>=20
> FWIW if you just want to check if the bug is still present in the
> kernel tree, you can ask syzbot to build the latest revision and run
> the reproducer there.
>=20

> #syz test

Thanks for the remainder, I will try it.

Thanks,
--=20
Julian Sun <sunjunchao2870@gmail.com>

