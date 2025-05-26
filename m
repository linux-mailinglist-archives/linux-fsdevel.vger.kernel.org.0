Return-Path: <linux-fsdevel+bounces-49832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4505AC37C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 03:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6BC97AA294
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 01:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BD213B7A3;
	Mon, 26 May 2025 01:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="BC6bGXIp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BBD1C6B4;
	Mon, 26 May 2025 01:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748223702; cv=none; b=cqDtc3zkKziXpDUOznmxPKWHYjW/xf735wxYtjEkINqgzkkarzy8Kru9wNFdgwDYfHuYvZqcveNTjDuvvJZcD7/54A6LPeQx8Tjhdk7Pb57Lel1E3ILBNiiVe6wlTcitWpPSBTRdHQFOkuv/Fj3VCPTiWpirRuJQ9u3ZJpZ8LDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748223702; c=relaxed/simple;
	bh=Yax1o+MAKbtmK05dYLpi7aye+qylXJ7V9v7XhzQLysw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PhfaGg/tYSqDlmPgTmQ30JbnHn2K/fZ3fCwTFki9qvmO4z4b469+D67o5r6xIReza1OpT4d11VFyRs3IjFTZKv5NiSvH+m3BbweT1iQ5FRsR+qG2RVLuHS0krW3U6Skw6toA1l5KzGbzG2svnRIuJuZri9NBzBLxICn6n0qPKeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=BC6bGXIp; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1748223688;
	bh=Yax1o+MAKbtmK05dYLpi7aye+qylXJ7V9v7XhzQLysw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=BC6bGXIpZUt3tv10QmwdrbmpBYbG4lC7PqcK/6MEVWtSbOx8nwFvK1sKXIC7bHZMt
	 GpZhXF939EIMaoxfTH3f3ko+8ZHmk2SBgTWN2OxVXynghDZMedWNUyCjv59tDnu/ww
	 h0myJRRBBJc0Fmbd2ZKK9krlXXnlhMBg2HQ+usNo=
X-QQ-mid: zesmtpsz3t1748223686t10d7057d
X-QQ-Originating-IP: JztrNHiARVaOEtjp27R4f7wQdO2XWozoWxAFuztRmMU=
Received: from mail-yw1-f171.google.com ( [209.85.128.171])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 26 May 2025 09:41:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6048472936183854145
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-70e5599b795so3497447b3.3;
        Sun, 25 May 2025 18:41:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWfgSvdvKy/lTVCaFjMIdiYoJM1GqxTA33iT4eMjz5m1NDI2czD5RS/JTiXJADbf/Zv6iLwOd1b4JAg0FQ+@vger.kernel.org, AJvYcCWjk44dmzw5BbtwEgpfSre/lsOJwAXxHVx2TYtyihQl7pHQfSDyYU/x74JnxoLaUMZDoouyOYifk58Fty1X@vger.kernel.org, AJvYcCXZA19BzfjkxfQitSpLaKHCtBQpaT8dP6/zazTthZXeSkFBptLGUiQP6+W6rP5NoJ/hIwq0tQY7tYWIUfpmTmxo@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr2MwusPd13PD+BF6it+mc4hFu426bmolU6h69T9zyG8iCEoKb
	DB1SpFYk8GXC+2hPyvmuudHvKAjRZjcnaPYE/P4LA14sFJp2Rq9K3DdQpVLywTviLrfDn/VXY8a
	8Tvt+dCNo9BR/sJ2WeaKEHMledM9gm/k=
X-Google-Smtp-Source: AGHT+IFIcNzEsjgbznnYQzRXW0ygG2vmSSt7rowHf9HC1swZI/0KiyyfqvJCuOzjjBY3dlhapMk0D9DQbRZBDk+LahI=
X-Received: by 2002:a05:690c:6410:b0:70e:27fe:ae64 with SMTP id
 00721157ae682-70e2d955c62mr76737287b3.3.1748223683571; Sun, 25 May 2025
 18:41:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250517012350.10317-2-chenlinxuan@uniontech.com> <57f3f9ec-41bf-4a7b-b4b2-a4dd78ad7801@linuxfoundation.org>
In-Reply-To: <57f3f9ec-41bf-4a7b-b4b2-a4dd78ad7801@linuxfoundation.org>
From: Chen Linxuan <chenlinxuan@uniontech.com>
Date: Mon, 26 May 2025 09:41:12 +0800
X-Gmail-Original-Message-ID: <3E15862E876BC25C+CAC1kPDOH+QZDjg46KRNmQQpH-_yLbQwMUGsiBk9gW1kqjyy9xw@mail.gmail.com>
X-Gm-Features: AX0GCFsBni7qi8Ac7p4cj_ZgxAOmlOpRhCXgN6pmm8WD3Mcg5CwSWbbJiA44GgQ
Message-ID: <CAC1kPDOH+QZDjg46KRNmQQpH-_yLbQwMUGsiBk9gW1kqjyy9xw@mail.gmail.com>
Subject: Re: [PATCH v2] selftests: Add functional test for the abort file in fusectl
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Chen Linxuan <chenlinxuan@uniontech.com>, Shuah Khan <shuah@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, zhanjun@uniontech.com, niecheng1@uniontech.com, 
	wentao@uniontech.com, Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: NwIPvWX4YDagj9WH+q98X3TrRPxO0s/DoSAygTtCbBMnwTNbYzjOOrZq
	mC5EESqb5nlkXd7SGm7/+1DssQrvaCr/rdjEDr6AD3LfMQlzVS+7Vo4to3KhhwkmVBmP1LA
	/2f4wOh9mpA22IWAw2k4/0aoAot2OCj5LRkTDq++M5Qskzg97MBXIuLavzVZIvNixhyHaRN
	oLXTkgDzFRlmjD3eAD/7HsqtWJRqqHfbegaIFLKVT1VVRmDYrB4n/PtsS6zKyi1I+L6od4D
	3WRXc3W1v2ox0e1QT0jGLZ7ftzmWFvJb+0W39xyuJ79VPTG70eDzRq9juU04G3nY4xPgYj4
	TrGv8+LPrpw/eb2V3PlZdHecALQAhWdjVpRkru7YfXbVRsWxo0hV06+HSDKyP7aWY+QxkEk
	0bvPidhEns7D5mxsJWB7SN6ZQgW0acFDcXLrmitfbTdWoCADcQWIpruwMiGLJE8hKz51NEs
	LNwFUF32sQNeoYCR8roGHGR3p0FZy/nJveit2f2EJIrtY2yhI1WUue4bDnTa5N80+kjKWA0
	hpmJYIK9oFFEeglAoxgeFYo8iItimOHmh6mr74VN4lbXDVq0aE4JhJ5Ec7uUHEf0bQSdw/h
	ZxGpI8GZLk46HEni4yFnmkGszpp80BoGytrtSdjgEriirdZ5Yk8YsXyTRWYZPZPfAkTgH7J
	lJ38kzG3ubDJAIqdOSpNzulWzMI/OYSvc56h3/+8vXT7tsp8fFypyKJddeK++vUYQX3GkAJ
	zJZMM6/WWZm7mWRb0PHrGkCBC0DuBOei7qzxvA+AfNGXLc8EFyC5eet0upu9RUFnjkCI5Oc
	GAeHPvp/TNRfaRwx6BQeUiQhYngYsrfXiRD3oPL3k269YnHB7xfcya8vGPhyAFJfm84tibM
	3s35Zimw0jp0DWwbqPcGIVe7b08PFSz2zW2Iey8BMIB2u0TQ4Jrk0zDE5MqkGjFfh6+MicP
	CzUD6jBCoTI2T6mX7L1mztSq6dY5S/JAY0pKsbFi14FmLVg==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

On Fri, May 23, 2025 at 6:50=E2=80=AFAM Shuah Khan <skhan@linuxfoundation.o=
rg> wrote:

> Also if this test requires root previlege, add check for it.

Currently, this test does not require root privileges.

Thanks,
Chen Linxuan

