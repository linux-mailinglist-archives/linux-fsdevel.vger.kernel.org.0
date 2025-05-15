Return-Path: <linux-fsdevel+bounces-49094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57508AB7E2B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 08:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 591893B7C7C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 06:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DC5296FB2;
	Thu, 15 May 2025 06:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="C4fNRBze"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2538F6B;
	Thu, 15 May 2025 06:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747291311; cv=none; b=n7/BkJZwbJAizdlZVCy2fK5dvBWPipryskl1uCWeW3VAYtESrGyp6KgX8qm6lGXL3V9heqgc8AWO+vAgU7cIKwwBKhlrU/K6hW0Fq+PvN5W03Q6B0C+2wKwzORdKY8+r9cbQV2MUKnby/FuBGZ6S4XoIR44gO1E2jbM8Pq/3hMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747291311; c=relaxed/simple;
	bh=Pv6C9wmqOTvYR6XxVYsJacLeb11nK38fPSPZdYYRbmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=puQpCbMwrRPYK9pVdtbGTSNB6elO3SqHBJOBApIZnlipMrVJ7l9BOH8GdQm0yXKeIQ7fx8+8Numq1LNNTxPBOiTCNINSrewAjMyXdimdJo3YQVaMsFfO4/5BFGCheke98XkV13YPu+FMF1KywM0V8yfZIHHu32oMRr0bz3O6D4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=C4fNRBze; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1747291299;
	bh=Pv6C9wmqOTvYR6XxVYsJacLeb11nK38fPSPZdYYRbmM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=C4fNRBzeBaG/QUhJFw7HdAPbwjy/ukOXR27BFdCV969F2UcAa4xRK98GUxhKBWCH2
	 a6XnDTtwRumEfixRevACAir3e+ai/giM2MVyUZlF7CUNtJrBkEbKU6CwesiA6QoJhy
	 VCUhb4f++e8wO2crHO4IGKpoGAO6wSXSHOxyryJA=
X-QQ-mid: zesmtpsz3t1747291297t1d3c26d5
X-QQ-Originating-IP: oN9SqwewSJgHzg/+UlmPwfIMMf7bRvfD0mv2EQOlL/k=
Received: from mail-yw1-f172.google.com ( [209.85.128.172])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 15 May 2025 14:41:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12567563911921161485
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-70a2d8a8404so4977147b3.3;
        Wed, 14 May 2025 23:41:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVzFOZ6xKrIxhHppSVTPhASxDcFfBrWwewCAYrLMDgPojoJlkjetSOE9RQca10Mvf2TKJZOlToXx9C82MOf@vger.kernel.org, AJvYcCXv5F0M5F3neXUYHhyc3vcGCjR7N+Td8iVNvLGZ+jfXNu1zk6RpBThg6Y+Zr3VzcLSSLjLGCE88LSHmdh2j@vger.kernel.org
X-Gm-Message-State: AOJu0YyG2slY1MuhO6mTiJC4qiaTEZiZ3hReqsand1qB4cGlin5L2r7n
	Khac5LIzQ54L4eMv4XrD33wYMMWi/oaUayfVMLd4XMt230onQVNrEyLUG0sQsS8WH0W9gdwL+rT
	V05aUkfDwAqlfoBFYRdpnOsOypKo=
X-Google-Smtp-Source: AGHT+IH1hrC3auLTUMVebNlwUh1G/xvE0Z6gAJGCTODIFZU2L6qsdqgviOVXEovfHZf1xm12AtckLvK+4rgQ9gtVc/Y=
X-Received: by 2002:a05:690c:680e:b0:6fd:a226:fb2b with SMTP id
 00721157ae682-70c7f10bed6mr88556677b3.3.1747291294859; Wed, 14 May 2025
 23:41:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250511084859.1788484-3-chenlinxuan@uniontech.com>
 <CAJfpegtJ423afKvQaai8EeFrP4soep6LrA3jZg4A1oth3Fi2gg@mail.gmail.com> <CAC1kPDNvU-F=09Dsm1DW43Xrm1e4T3BQ0K5j7R1PHrQ-Ju0i6g@mail.gmail.com>
In-Reply-To: <CAC1kPDNvU-F=09Dsm1DW43Xrm1e4T3BQ0K5j7R1PHrQ-Ju0i6g@mail.gmail.com>
From: Chen Linxuan <chenlinxuan@uniontech.com>
Date: Thu, 15 May 2025 14:41:23 +0800
X-Gmail-Original-Message-ID: <C7BF8CEA36D77D0B+CAC1kPDMuAPV+3SwsqnNBLhQag73TLA5+HivQFcJ3m-QKHAGbXg@mail.gmail.com>
X-Gm-Features: AX0GCFsFe0p4IyYETThGWdU0wO3jtNOIJaJeaMc46GW6MRKtwIQjPONZTrknaVc
Message-ID: <CAC1kPDMuAPV+3SwsqnNBLhQag73TLA5+HivQFcJ3m-QKHAGbXg@mail.gmail.com>
Subject: Re: [PATCH v4] fs: fuse: add more information to fdinfo
To: Chen Linxuan <chenlinxuan@uniontech.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: NrxvMG+AXCyEr8nOWJPdkOBxfjOOLtlQWzrcIth2qRUNxrQ0Yv77eYsa
	PhbnDQVw5sAseHC8n3n5FErVjPRryqhi4t05GE/roE7F0NatGFGkENu0ygf2f5IzrJqvpFD
	JMXQb/YQr3kMdHc3durqgMh4W2TL42PYD3XKUf+2MSm9K3RWyig0jw4bugzhhEbKN2XBdgV
	21HJ0EsJ/juB8dMhdCH8u2BZ/jVSGv0R+tQ+ZqO9Tua9A1Xc3gjg648AiQntHHZzYNd+3t6
	Cl7b56w55t96oqX5HzeQoCoyHSaMt8Mny+NHziA+IOkfZsXA2Ihvro8Ic6Z+a5j2xgEYqvf
	PQW3YSQo/fcegd4qqo3GSufV+YxfZ5vFX0MRr1AyY+juP2URghReqn5vhVSQrkB/25Cw5W/
	xY8KmU0mcUbHY77UlpuOVWSqV50NXkGQkZ94IAz3uOtHpMvPGbo65hJSgDG8fSqyLwUyaQO
	2SetEqQvYxQy5cyojYE7ysEZeyV/1YAdbtfDSan9HTTuJVXufO3U7aEdC/KuCP4jktRgKUw
	8d6jqfAMqHqbqfe+3277e5J1Sc50nrb8K/rZ3Qs1Wb797qo4RMiR63BEEKlQ0+rFQ+CVpYB
	plhfIqHkS0GYnY6t8P2P1eT8qrTKjKIVpQVafOUd6r3s1vhE4fKxcVGArYGt8il+BsjHFoB
	VUMwdiSUyhqo5u7PCQhVDJ9SACaLRBT8S8d8wLjhlFyyZS194jvlWRPTI2TFRMZ7uH6uzdV
	LtbnxwkdB4wZwySaiQhLFQ7tttlCRRpjctbmRzWAq87OAQrZCvkjnc0ysYzl0qBZNJF23c6
	eMnjGInzqNKBfPzNXEB5gBjqqtFc757mMibxCOro8IdjFyCJr8bbGybuHMUcZjhyUl7BBIC
	Wryz6uIoQxh1QMP/n1IO281rrFyk3Y7RHIPies6l1A/Gx+usXWz0MPX/v6piu/nabs1W52l
	AWkSDFYBVNXd/TBXH2RkjGGmGj46Fjd7qt0ZTPWCUMzM22+oMR1AiUQLHlXslm4YXNwfil0
	1NJ3PMdb7Gf856gDUdjZVAJqQ+jHIbs0AhAGNjZN3v01hEev1zf1bfe8lw4bI=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

On Thu, May 15, 2025 at 2:36=E2=80=AFPM Chen Linxuan <chenlinxuan@uniontech=
.com> wrote:

> But it doesn't seem like exposing this information here would be a bad
> idea either, does it?
> For example, if a system administrator wants to write a script to
> abort the FUSE connection
> corresponding to a specific directory,
> the script could use this information to locate the relevant connection.

Oh I see I can get connection id via .st_dev from stat(2)

