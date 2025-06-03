Return-Path: <linux-fsdevel+bounces-50419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E39ACC02B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 08:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 461003A4416
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 06:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2834925D537;
	Tue,  3 Jun 2025 06:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="UBoLwNWX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0E01482E7;
	Tue,  3 Jun 2025 06:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748932007; cv=none; b=WaZLF9TcyYnsOypHnm0ZysxBEbcqNYyLg2+/i1xashDKmE2zUoSKFeNQFrNa3at1PgHT8xPGTfLEUf8KuOXW8GokXu7nETLwuhqElfuJNvNEz75HvCNDKzfyHW7V3mC3eXo+i27O43lM82B0aDS/L/KTzLus1hwIxiLPVDvtb4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748932007; c=relaxed/simple;
	bh=R+OerVyVxj6IqrndRPrUYFsv52NUlRFWDcYIsq2Ylpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cpKADcKLust+oZ1rOF4yEtsST32si/UCruTw/3P/9zOuPStqHRgBnYXCCr3zZokRqi3bc4zsdc27biBcj6dktHVfl2ISiE0NKahJvnuuxwHJNTAVczInV0LvSSApDoXIFWYCcHSBt8kDokzxncEEYIwOwvLg47r8wrEwaqAvF1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=UBoLwNWX; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1748931987;
	bh=R+OerVyVxj6IqrndRPrUYFsv52NUlRFWDcYIsq2Ylpo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=UBoLwNWXsfbw9HMh3GMcLubTcy8o9PD460Gh0Z0RVm3KNaI6yeq7kOy7ZDGxBoxfJ
	 550Hlbwfe7mEmfqy2vCxXnvzxRUM/r0VaScpusx8gecLTEbVrHSYmU7Z6rK8aAJwcZ
	 Yq/WBc1D7Du+U1PBB1dwmxMsAz8/E05WT6pouAGY=
X-QQ-mid: zesmtpgz9t1748931985tb95e0d80
X-QQ-Originating-IP: i+o66jrVhkv3ZXJ7FFjZMcYF1ZaZk/3iW1joDJQYrWY=
Received: from mail-yw1-f172.google.com ( [209.85.128.172])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 03 Jun 2025 14:26:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 510946114599463882
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-70dd2d35449so40748437b3.3;
        Mon, 02 Jun 2025 23:26:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVioy45hkq40Gjr51zt3Xo4wr+z5qK2IY7P9qeSUKqHWm3LuUk/qd56LwRLtakJsUtnctblofzP+95szl3R4sn8@vger.kernel.org, AJvYcCXuFJQZ+phbNb/58/Y45/aeNSdT76jmFySoj6VcSF8aN9vvX1O7RnfSbOr7YAN4Ps2epN1If1G/QMaqdp5E@vger.kernel.org, AJvYcCXzfwABnsAW7mre5kLMYyo0X2zCN2Jjo88aU6mqfQXdENGGP+WOGQx42/i+xcRCuM3clLsnFEWUbwQGhwtN@vger.kernel.org
X-Gm-Message-State: AOJu0YwEvEA78jOTb/Mrq6rn7qsxHFfMhiV9kD0znj6Xb9enGmrmH9Zk
	N5OzOAxm5ypYz41d8BRyfx9YR8lQw43EnLRhXNMT3usHivg6vRJG+L3t/nUsabZwME9y3Fn0gpg
	oHSp9I7xmmP2+FzMfNAtjwrOcqWjaRXM=
X-Google-Smtp-Source: AGHT+IGFv6a8e259ikLqOLxS+7Zsi1dR9R9kdEmpFbse2dsMl6bm+BYsFIg7D+fNCJT5T0VMXAuPEgcSIx+T3sgWG7g=
X-Received: by 2002:a05:690c:6f81:b0:70e:2c7f:2edd with SMTP id
 00721157ae682-71057c1702amr188775307b3.9.1748931982521; Mon, 02 Jun 2025
 23:26:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250517012350.10317-2-chenlinxuan@uniontech.com>
 <57f3f9ec-41bf-4a7b-b4b2-a4dd78ad7801@linuxfoundation.org>
 <CAC1kPDOH+QZDjg46KRNmQQpH-_yLbQwMUGsiBk9gW1kqjyy9xw@mail.gmail.com> <053cab6e-1898-4948-8f82-ac082d85a20d@linuxfoundation.org>
In-Reply-To: <053cab6e-1898-4948-8f82-ac082d85a20d@linuxfoundation.org>
From: Chen Linxuan <chenlinxuan@uniontech.com>
Date: Tue, 3 Jun 2025 14:26:11 +0800
X-Gmail-Original-Message-ID: <85BAB723C5A7D075+CAC1kPDNQqTJVXzH4GYJOOmbHsA6Q17j+W5n0Yr2apghzr61spQ@mail.gmail.com>
X-Gm-Features: AX0GCFs82Z1K6MX8VaHf9i_XOg-ZwKtAnx2bBI9te-zxkwwgfc73GMcNhg8LjEI
Message-ID: <CAC1kPDNQqTJVXzH4GYJOOmbHsA6Q17j+W5n0Yr2apghzr61spQ@mail.gmail.com>
Subject: Re: [PATCH v2] selftests: Add functional test for the abort file in fusectl
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Chen Linxuan <chenlinxuan@uniontech.com>, Shuah Khan <shuah@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, zhanjun@uniontech.com, niecheng1@uniontech.com, 
	wentao@uniontech.com, Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: NEuxXjgkfD8wBi/AxbImeAmkRXq1bKHZNH1nk9PdHl2kcQ1vAdjdtnr5
	kAEDnc+WJ/dDTE6Y55EnALPyx75e5p5OD4mBqUn0HCws3VdVCevnls0vBYsr1WLYqf9SwzW
	atDo3ZY37zA5XyKRQgvSLeIRgVlpnrqVxfzDnrRM7WZeJBhQYcEoAdzEjqRp6+xQ7Yt1bZh
	liVtKQ7VOgKbYe5pH0WgYXsdyCFbG/MlLET28nxcb6GnLuwqjYtKDXsx+SSb5szEh7E8JX3
	EcLPyKa1MLcFPQOSQy4YCQkd1sC/dr8VDo4rnm7GwuNP0PObOCaSkMnbLMiuuMunay8oOQ5
	HPqPpnlvcn+F6LQAup5rXdTvVWZI+/g2jj1Th2Q8cNHN/mgxF1QgLsbD6L4ru1Qf8bNx+N0
	7UprgVlCLnjSlxmEGyzto49tM+SbI2DBm7hmNXz/39V8uxai1jdToHiGiVouGVOUc3/z3zx
	UzEcq06pqNcCYSHPcsJPpQj8NOULpd8dP83UlcBUcN+jz3tVKn7rZSNcoSd4yj1YambG0uI
	Xe+hfZBmf5s02ijKMTweqsxDpAQLtiTUq2u+lXduu+WFmzM6tBSemVlBG7eiewPSjfSOgpC
	clHs3XK0VTuQuFcryGxp8vI6g4tC88K6oo3zAcODfjsGju5kKXq9RR5irbEOc+w02raEt6C
	PfDJL5VN/l0v9NaHLq7WtXJjdvgbiNjjCTqPRVGCOxoBW1/7d2vTpQl9xTL+x79sW1tJWqL
	uEERNEg2fws8XEZ9MCVAn5yfM8ngD4ToMBAcyNlPkFRfT3hJ2kTwsOpdhhGLgvgdrDOkQmR
	Lw2vJrNd3OqBRgCRaAq7WUXd/Y6vXnJalePp0oKu8KAkYxpraN5+EZXnJeHBScz9/xkdy8D
	CBl83hvECLR1xVvcZMKI4VLqTIrOsTgv8ch58mUgZI16gACMnyZcyBMwJw1I+/XaSk/L8Tw
	9TUVlZ05dQwk0HV88wItF2IbBoKs9UyG0021brzyIS5u/o74ain2fyOc6NAFsPHnChrc7tf
	OeY1sO4HBbIg3gT0Lzrdux5sb9Cbb6NIRd9HmGKZBnADrkLudoixJMhM1wt3KlegHTOcPid
	ybRKtAtzD9Z
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

V3 has been sent. See
https://lore.kernel.org/all/20250526014226.14192-1-chenlinxuan@uniontech.co=
m/

On Tue, Jun 3, 2025 at 7:02=E2=80=AFAM Shuah Khan <skhan@linuxfoundation.or=
g> wrote:
>
> On 5/25/25 19:41, Chen Linxuan wrote:
> > On Fri, May 23, 2025 at 6:50=E2=80=AFAM Shuah Khan <skhan@linuxfoundati=
on.org> wrote:
> >
> >> Also if this test requires root previlege, add check for it.
> >
> > Currently, this test does not require root privileges.
> >
> > Thanks,
> > Chen Linxuan
>
> Thanks. Looks good to me.
>
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>
>
> thanks,
> -- Shuah
>
>

