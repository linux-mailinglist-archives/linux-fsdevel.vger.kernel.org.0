Return-Path: <linux-fsdevel+bounces-49098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 154C6AB7F16
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 09:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D25311BA33FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 07:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBA2280A5A;
	Thu, 15 May 2025 07:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="VknxU4lR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4412222CB;
	Thu, 15 May 2025 07:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747295080; cv=none; b=d0kP/AAoFaMmZnlaSrzHMwXSDGxinpHdw2unOLsPM5EHZn/ix59oOzupJ3p3Z974PT/itDtPS99Ff/YRfahHNFwM0Ny2YxCMkoqnVicz/ejt9vwNVKeIMp1/wQK0aNij2Y/b/3tQVlHaJNfjjnO4KYRzng0HRxQJMSg5BDx5ZY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747295080; c=relaxed/simple;
	bh=IMQvQEXAbMtLn0avQkGWmOl1RBiTKKHsgdf86doIKHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YqpcgFR+5n8nw6JvKnInnsoNR7eIOjO2nI8Zax3gp9x/T61rvliwnYLUUBo2PEpE+aHJmN0CGdkSiQc6FlRIRhyVmPorpgprgm504y3SOxmMZIMtokV0Bs91YSzIGQLuq1tCkkJXbkQRXvHy+sppPnBryoTX4NnwkdV7Mwr+Sm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=VknxU4lR; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1747295064;
	bh=IMQvQEXAbMtLn0avQkGWmOl1RBiTKKHsgdf86doIKHs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=VknxU4lRKTUZSDTSYPo8ThNP6vCJmwT19TdLNDUrrdPQGnOmDNUzmOg1g7Y14NOZh
	 lbFPmDkoM+iHc7AEzxedI5OhEYA8r1mTf3moQXlKOkTrQZ6QhBOYMyjPlNrBA8DDBj
	 OSsEv9GRMfz5MCWxObhKO/lXgUSp/a+obD1GNB44=
X-QQ-mid: zesmtpsz2t1747295061t2e20bf15
X-QQ-Originating-IP: EK7ysgycBQsENx9vhDyf+Up1nBtRX5iWp30Xu4CteuY=
Received: from mail-yw1-f181.google.com ( [209.85.128.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 15 May 2025 15:44:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15215953735421502448
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-70a2d8a8396so4966167b3.3;
        Thu, 15 May 2025 00:44:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV7sTtKzgdqnPDs/huVf/ytapd4KOrwR1MK1Sd9YTc3EeQb9tYoDAkjtU48rDUrLmVFOAQughw9iwjv07X1dOb3@vger.kernel.org, AJvYcCVwFnqiRfh/XIWc2mPuV/nXwoanBfXDcU8NSxAQI2AECnA+xIcfVoespyYVMeddlJGDU0Ni/jUcyHfvcXSO@vger.kernel.org, AJvYcCWthG7yWDXtpL11jL8EmJfzeT4D2HVzOIdW8tq9KPBpnyhWS02qTSBFfbA3PIeC6X20P70xOTTd3uHXZhzt@vger.kernel.org
X-Gm-Message-State: AOJu0YxRnusmp5grhUXQivZ3h2cNZWl3fTYyust69HXklN9WBNej65bh
	+H5QW/txlpg+pf5Hee4+Uu4ITWD1O53bSuct+8Udkh4oNNDFLfwCACp1YXAfu7gRXVhmRA6YMKd
	quSC4S8ElkXxY3hLdBc5LLjUky8s=
X-Google-Smtp-Source: AGHT+IEGJTpkV3dekgtnpuOu+UZn7MT9MPI7RliMvzoXhDXsIktnB7RhQWpNvEpQfAzDRbW1xvIH/BO7II2CejNmFzE=
X-Received: by 2002:a05:690c:6009:b0:702:591a:6958 with SMTP id
 00721157ae682-70c7f13b8bfmr90605607b3.22.1747295059001; Thu, 15 May 2025
 00:44:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515073449.346774-2-chenlinxuan@uniontech.com>
In-Reply-To: <20250515073449.346774-2-chenlinxuan@uniontech.com>
From: Chen Linxuan <chenlinxuan@uniontech.com>
Date: Thu, 15 May 2025 15:44:08 +0800
X-Gmail-Original-Message-ID: <02C56AF5B595EA64+CAC1kPDM5BtDUJm6PtFsbRBP9OOcXGxE+K-AZingxsCSD=V8i9A@mail.gmail.com>
X-Gm-Features: AX0GCFsRC37eddsWjKPdqpayqyMPV9qQhsWOI3R-G6JP5Hccr-2BEYQQlQaVVfk
Message-ID: <CAC1kPDM5BtDUJm6PtFsbRBP9OOcXGxE+K-AZingxsCSD=V8i9A@mail.gmail.com>
Subject: Re: [PATCH] selftests: Add functional test for the abort file in fusectl
To: Chen Linxuan <chenlinxuan@uniontech.com>
Cc: Shuah Khan <shuah@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, zhanjun@uniontech.com, 
	niecheng1@uniontech.com, wentao@uniontech.com, 
	Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: MQeLyr+N5AxPZM5DXzmSt1kdaM4CWy9W/TnUnIuSSayOIhcgj2pLpUxU
	HSL4yoAs1AMJnPLf4WbFGNJhOwoaaGGGEKbRaEf0grNBDkqG3vD/kS2LCERFhgW5CzmvUAe
	vUqFn8F/HMFCHYQCTy/U71JQwXpZVHlRAxkAxWxbfkc7QjX4/4o4GGdH4myn+MiVVXdJLaz
	Mh29K68EFKUISVPUcItE0JXxsAYNMxVrf2u8EvNK3ZEjq68jGyP1Upho4+FipufkamHqmpR
	VMClvBy6hLIo7FDSoBLIomgR3FJPvcUe1PLlisc8bIAxRQUYHFDme+D+Q16yUbudvS+rW+J
	o0X3wPxpm8gH4hPOGI/6MqfPwi7u80XwW5+5EogN/4RBax4hTFg/CPQJokmsD3fxUEPV22L
	t+s9V3EwzB2/LwxDNI9rfWFJF0HBqWLPMQsTr5VlujuCDrny64hmJdmJ6n1dUMDXfBc+ngd
	bT/YEbAx2ik+A53Q79jcK7erciCWmTRj5MrjH+oL2tDDnUJfnYc4+N+5z8SVdTpFfd2XNVz
	hPknW6wvKFKhIi7V1D6JyTTA4lyMTT1hgjHQReSx0wAfJqs6brhyqKoIJ92JV/aDeTh97fz
	n76ECOePjCz13PPaoRHUzvJOUnUVWOuaiGQrb+rWYQzz+SDpf4/h2kxeFi9Urvkmx3T+nvf
	7w0AJLvxEMBK1svQibupz8okPCj4GWxr3xOFvAoDOYceuP4PUgYvYJvoC5zFfG57UW4T9Qr
	ReL5FmN3sCipsv4ObF2lNNuAZdrG/UQBXKE+HvONxy21cSGBTo/6lsQa8xOi8HEgMFPNNLK
	QughoOYR0Q2xo7iannd+hp904nx1wjAPYYsklT/glN2+1DCeNrznbwwSj+VbeKi33jHf6kZ
	J601LDD/XpYxpRy7tC+vE4bDcsrhIdjDwVAWHouv6Xmd9ziwUS5PMwogFjUfW7VCfy/zQpx
	8XCLkQ4pouZHqhu3ntkSD+ElQ13RVQvolUUyTqQ5N5ipmQUN4iS72axCCK0ooJws/3dyr2n
	EnIKevzaMq333C9QnMr+Fi60G6NEu49Tgc9I4pJQ==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

On Thu, May 15, 2025 at 3:35=E2=80=AFPM Chen Linxuan <chenlinxuan@uniontech=
.com> wrote:

> This patch add a simple functional test for the "about" file

Sorry for the typo, it should be "abort".

