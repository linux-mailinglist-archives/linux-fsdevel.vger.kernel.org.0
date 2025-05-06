Return-Path: <linux-fsdevel+bounces-48164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5926AAAB9FA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 09:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9D115A0A7B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 06:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03D3278776;
	Tue,  6 May 2025 04:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="k30NXRBH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373782D2693
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 May 2025 02:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746499712; cv=none; b=pVKbuos9bK+i3sKwDG0c5P+yt2Jpf0X5dMVd/9amaelHf0mHxUio6WoEBkyyOEfgD1FmvrGZbjn/j2h07acGutEIHLMvNG5yCU31ouZc+7EfqphOOoX98CQQV4yhHCBSpWHFtDKEowmm7vkJ75oT9cV6Jdhg0DtmFCD78Vpd9W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746499712; c=relaxed/simple;
	bh=lESGC6aZRbjMUeFinxQkj5BF3WE2a+Fwj91rdLS0t2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NOoLUZPA2JXfzHb0YanNTzg6p1IkHaSzgTRxdug/n715zoYMATVH3ccbbxrm6zHJ8C9p/BsSHUN40ua38R5n2FnIUN8nub7HTJoasCD1HbzYVhqwNMq3Sa9IgRW/lzYEPAzka5+weTxcz0d13sr5U3OHZfE9DAyHRORPK7jzYGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=k30NXRBH; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1746499696;
	bh=lESGC6aZRbjMUeFinxQkj5BF3WE2a+Fwj91rdLS0t2M=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=k30NXRBH5wHogeBGoX45ORynE8ZKz1jiW2gKsdlYvi6cskL4G/gA5Prun5eZe7oMP
	 faJTbT32qz9EBey/K7YdDFbzYII4uutU3UIj+nNWXVIqE869N1CwZXrlBG7S0ppfK5
	 l8i0StA4oWu1mPZbgAmQ/JKf+a21pto9fqy6E8eQ=
X-QQ-mid: zesmtpsz4t1746499692ta7315774
X-QQ-Originating-IP: ymkZsv06Ek93hW9qegQrc4WaymVEPD8FlZH+tRtW4ls=
Received: from mail-yb1-f170.google.com ( [209.85.219.170])
	by bizesmtp.qq.com (ESMTP) with SMTP id 0
	for <linux-fsdevel@vger.kernel.org>; Tue, 06 May 2025 10:48:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14190113298413557877
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e743bffc234so4059532276.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 May 2025 19:48:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXvn3N/gvxhOD/6/HG7LSjn1P+owfBtTL7U9wf5s1cj683QNK7rh+65UYv/AAgSxi0sGKmskAkzGVlauG06@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa4Shd4HI8pxPMCh4uPlZZ4lBZXv++4COtbZ1XMXxFurpVqSpH
	b9XtvOxwD0Pdrx5J2F3n7I+p6U78WVI2eAZhb6oUtuwq+Sjzr+I2RCQAu7fI+EZV7oHvMM8FSxy
	lS7YTYQ6xM5lKCu43kQN3P6jSHXM=
X-Google-Smtp-Source: AGHT+IENQXzTasux+h/Er8Nb1TBsKrrm9Xh9BPp6jbQyh8r3pZ56fUI+7QDwt0vU7ehdv/KdN/hOLpB68uBntMbFuLc=
X-Received: by 2002:a05:6902:144d:b0:e72:ed11:32b with SMTP id
 3f1490d57ef6-e757d0dbf4fmr12154889276.18.1746499689905; Mon, 05 May 2025
 19:48:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOYeF9V_FM+0iZcsvi22XvHJuXLXP6wUYPwRYfwVFThajww9YA@mail.gmail.com>
 <ec87f7f4-5c12-4e71-952c-861f67dc4603@bsbernd.com>
In-Reply-To: <ec87f7f4-5c12-4e71-952c-861f67dc4603@bsbernd.com>
From: Chen Linxuan <chenlinxuan@uniontech.com>
Date: Tue, 6 May 2025 10:47:59 +0800
X-Gmail-Original-Message-ID: <E8720A2B82C8F866+CAC1kPDM2gm_Lsg-0KqDm9R3b_TV_JDX1RL9iqD_mJzgLdG+Bzw@mail.gmail.com>
X-Gm-Features: ATxdqUHPWtnlpkH38y_LJhMXFnuUB1FKtxftG6hZgqPrWe5Jh_SwDF5vJKlga1o
Message-ID: <CAC1kPDM2gm_Lsg-0KqDm9R3b_TV_JDX1RL9iqD_mJzgLdG+Bzw@mail.gmail.com>
Subject: Re: CAP_SYS_ADMIN restriction for passthrough fds (fuse)
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Allison Karlitskaya <lis@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Chen Linxuan <chenlinxuan@uniontech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: MI0yrMZxA1C4agwxpBGjOsVDd2f74DXErEeOGbg/LlFEYUjvVUOOkklw
	dANKFhJn/mSSrtcf/+Si0zUwK4SEeTuOxANepipe9MVldXhg3q9Fnqhyna0ypQjMvENYHi1
	G5aiWmTVRCVqLC5MoOEtr6XamPPyu8bEuD0BYh7Mlc7YiClDNTiyzpa4xl75gSwLNLzv/Hl
	QA/H5aU7oTUMLBFvmHQQgknrgthRfik7bWKams+qeYNtE4RJzBs/3hFQ6iFQnIr3UrjkfN1
	C12zjsQXDNrgkkt0kLNd2MBxjiOKAtwr9GKtmDnF+KvFS0WlPqSk7BZsQ90IuVfvwUTlG+x
	svFNTO8OO2qkfkSVn95jCv/bzi23P4vGfGZNAVc9pqaEykmr+xCtuA68UIGn+81fGs51h2C
	rX7KGTu49vsybreTswYzXsuEu9DnYBvXDXqoulV3F5HWBzjaYiBO5crtaLrMh1w0oiLPbdw
	f2qRVbURU0+Tbxh0sF0Osl6Dkq9XmHSZrgcAbrGylDTGS5u6U4iabvQs5VYVMXCq0AFr54a
	TwBRdBCdA1h/yebJmT9GG64berqMNuH2MQrjqgj70cla/x33LsIudLdrcE4X3hHilBZYtHM
	yQ8MU91dncpLOphzghpQ0RNyDe0gDFgnI3uw99/ntv6Ep+aUsT/gK+iy1NxWtvpMn1Hl1wS
	IAa3vweZtDRWtLCTpTEgMUp99i8+csOgx1G0cacT+ecvaduI0cpC347UYOlQbwLmi+zReVP
	bXta3tJb4pK/Wja7W5KhIn9mRcUPVHgSGg9467P7SqLvmUxbxOohAInx/te2X7r7CPwAKw8
	zdgsV0EWMnu7IM9O/cLI1NGlw8qjVHYI6LGJdQfL8tw9+AOoTlMp+BXLYrBt0BnUUSb449w
	v3FRitn8U75G9rOvTxryHo/aHOgY4OvEmpbaYWK8LhLNM6lfs84BP8MPwL4mSQEhh3+Cl/v
	Mguw1QKqXXs4LuTbCANBi/Vm5/caYVCJk3i3wuWKKF1mW2iT3S00cBumUkLcCvNQlJ3IPX8
	xt1JIQRS4T9tVvFNQY
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

On Fri, May 2, 2025 at 9:22=E2=80=AFPM Bernd Schubert <bernd@bsbernd.com> w=
rote:

> I think it would be good to document all these details somewhere,
> really hard to follow all of it.

I agree with you but where should we document these details?

