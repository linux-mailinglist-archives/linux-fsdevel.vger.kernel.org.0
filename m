Return-Path: <linux-fsdevel+bounces-49089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4DFAB7C24
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 05:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02C694C5CC6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 03:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2053819CD01;
	Thu, 15 May 2025 03:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="dMD2lRja"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FA41388;
	Thu, 15 May 2025 03:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747279070; cv=none; b=jugbpcmyhzpUIRrpwZIdAkoioAGX0fsG+jPPrlwgaCGyCLouAJOYRg6BKi90H2GjQcVuq9rEC+0Ww8Qk76ipB3PWV3gUs9XQBbMQcurFcShyqRAvBw7sR38Bym3JnV/f/kASADKr/fgMV84C8ldV74jn2fT6+DWPyjHWeuhbe34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747279070; c=relaxed/simple;
	bh=/a0JhvZH0BvKlsYUt9B/YBq8a+S2ARoGi5cT+GvM3kw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J1+BI+jzJTAnDvdeILkqWbUcYKqMD5s0tpxIB4c6bxuSasqLfDTiQ2uTZTtqvBft43BIq61lIhODOlpcm4QeizXR9vn9Hcz/38YfKZc9eveuwTUSbOHYZAPdQyLJWidpqoRzAjfkaxwwzYX1BSF/kR5LDfZxji8qcrkhHeo2V0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=dMD2lRja; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1747279051;
	bh=/a0JhvZH0BvKlsYUt9B/YBq8a+S2ARoGi5cT+GvM3kw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=dMD2lRja0iwLotaCv11x4OINXic8Mnr07/e1OolhdG3qVS5VqZyKOjA1LgqXJgLFR
	 EtggLrqrdm49+L2iVcpyDKhyDF8SpGxOMfPeOeE/0hptYCyIN93yDKEvqlb0uTgWz2
	 FtI/iM/gHEYpwZfrbfuz5Ro67EWT+D84907ZUDXc=
X-QQ-mid: zesmtpsz8t1747279049t71d1380c
X-QQ-Originating-IP: BEvtqE/Lnki/7a6eSED+EL8mQS6RziqEDhemgRxI3OM=
Received: from mail-yb1-f170.google.com ( [209.85.219.170])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 15 May 2025 11:17:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1971914962749413789
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e7387d4a336so444868276.2;
        Wed, 14 May 2025 20:17:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWXIMjsexOEbP8Mw/wFQbz7sMdHgwOIcfpgdQ0Cq8K5uV1MFbsECPOjn6zX48FcmynqC6uxnA0jr7JPquyd@vger.kernel.org, AJvYcCWkKjYlckVQxfelPZgsU+QndNGOD1Ux/SNeQjGDRv8YK7NJ//+yzQUYWEbnWT+x511RSjhGl6gJ2MqrSFXG@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6x7dMugPcy0IJb2D56UFFi+xRD+3O7ems359Qtr82/81b7W4T
	z3bqHtaYVQNDkmYaZSkZaVg6t6pruRuMi4+xhf3G9P2Vlhd/+x54lp+gIHn09z7EB0kmNfz0MSQ
	ve7dLQP7iRIAoDRcD5AMIVfiNZTo=
X-Google-Smtp-Source: AGHT+IH5y8xeiMNaVoa2HE6Agxnd1KD1YvfAEq0eD4qv8SLLfMJl8U/VJelXIaEWilJkOrRGhCByUx2y9THv4+8imKQ=
X-Received: by 2002:a05:690c:4881:b0:708:be8b:841e with SMTP id
 00721157ae682-70c9476ac17mr13431497b3.36.1747279046694; Wed, 14 May 2025
 20:17:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509-fusectl-backing-files-v3-0-393761f9b683@uniontech.com>
 <CAOQ4uxjDwk6NA_UKiJuXfyY=2G33rruu3jr70pthFpBBbSgp1A@mail.gmail.com>
 <CAJfpegvEYUgEbpATpQx8NqVR33Mv-VK96C+gbTag1CEUeBqvnA@mail.gmail.com>
 <CAJnrk1ZxpOBENHk3Q1dJVY78RSdE+PtFR8UpYukT0dLJv3scHw@mail.gmail.com>
 <CAJfpegunxRn3EG3ZoQYteyZ3B6ny_DG1U65=VX25tohQuHCpVQ@mail.gmail.com> <CAJnrk1ZH3hwgtgOq7a=J-vxop5fCm5K_ZEek0W3kX9N1xf4HAA@mail.gmail.com>
In-Reply-To: <CAJnrk1ZH3hwgtgOq7a=J-vxop5fCm5K_ZEek0W3kX9N1xf4HAA@mail.gmail.com>
From: Chen Linxuan <chenlinxuan@uniontech.com>
Date: Thu, 15 May 2025 11:17:15 +0800
X-Gmail-Original-Message-ID: <AFE2E8F793F737FE+CAC1kPDMATpB4GiaX+-sBZ058igt1QuXf_V4NAt0tC=-3aG__TQ@mail.gmail.com>
X-Gm-Features: AX0GCFtolruZ1WjR-dXGe_jv5Fbw1WWoohXiP7_MKSC1SxfRUjot_e79_xLvBGg
Message-ID: <CAC1kPDMATpB4GiaX+-sBZ058igt1QuXf_V4NAt0tC=-3aG__TQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] fuse: Expose more information of fuse backing
 files to userspace
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, chenlinxuan@uniontech.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: M21ph8MgUKJrUU3xgsZlIawmZ5bm/+gAAT4oaAuQjZyq753Lv/WmU7Zf
	JZ7tti1sQgytaPY3WDaxefadMan66Fw/nldgtBg5RuWyr5w7+1FXrjgdcSI+/e5txXyTp17
	2z0o9K6QxsK2xKudfIWh9ZpUnm5jEQlqApp1LYLujbeaCOE34J9Wf+MCsNbHQR+H+Qe8IkT
	n2ilfoyMvp6ssWOelec/JS7ZT8sHcOCr6ySzA3/vsAtBjT+cF7dcZ+HcR5fHMKgJxi3S9FU
	jxNKtbTchhWByQHQzCDm4kLfnTeskXC2V70flpKA0nAUjrLqxcEE6d6E7MGqsicyVYPQ3dE
	DVylTUezHhB4pIh6KSuB59W9wxv4y2qvxZG79MZloR0JTgz/z830Ni+Kzn7FOI9wfKahQJ/
	0vENfZ/P2LTbnuy22L6FHrEpEUGQiQe/VNVBcfyWxJuvaQd3/ShNen0ikXwZLMiL6UG7cMz
	UpDTaRI139OFlH/Mv4L41RhCpByADCrszoFD2Q/9IvkCvRnloMBAWmIjCRajw7YXqULELHq
	DzZr6iREN+Cya3Nt6txlq73Tb1pPNs3SDrHX6ClNDX0M8UIuXM5Cdf9CiLKxnfHO4KSZsmv
	/5MEvwnZLa6eohDO8g8Dz8n6QGEw1EHEl3v4+Fe32dwifKa8wa2k5ns3Zs0p5i4nlmRpOqZ
	7783YaonMlgZq+lJaGhLrrzuVpdHzIc6w/pa19wCgC6m/3R+WC/+MoMH3Od2qveJwXL0zv/
	iFIxMzI7sIE9M34dDD+LOqQlwDJ5QrgkvisXVMUNPTig1MTEeIqyoHOT4jRm1aQKlCHDJcm
	NyJtb++m3JmrtrscvsGUdrXKJMw5oMW6bYoiItqg8qiA2e6PYxRlOvznuip8q+lMpQ90f5w
	5jdlhN+OCEtQCWmEiItH6q2E5Q+3ZBeYLPK82iTilkxM/yA/hXHza+kJHlgNHWJYD1nhsIK
	5m29wEL+ghMgjtzidqBLad/x7dBDE4p/MUPGvSNAYA6JZDbOLcs94HEyUZJONaBl6px0uzY
	L4oauclRuM8ej7yLw3/WbmBVvEmTfO/eXESK76Pg==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

On Thu, May 15, 2025 at 7:04=E2=80=AFAM Joanne Koong <joannelkoong@gmail.co=
m> wrote:

> But I guess one advantage of doing it in sysfs is that it'll work for
> unprivileged servers whereas I think with /var/run/, there needs
> to be elevated permissions to write to anything in that directory path.

I suggest something like $XDG_RUNTIME_DIR/libfuse for unprivileged servers.
It usually is something like /var/run/user/1000/libfuse.

Thanks,
Chen Linxuan

