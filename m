Return-Path: <linux-fsdevel+bounces-48543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 480B0AB0BEB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 09:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F3421BC7543
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 07:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5BD2701AD;
	Fri,  9 May 2025 07:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="EsiRaRfT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B710224AF9;
	Fri,  9 May 2025 07:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746776473; cv=none; b=N119ZI7T2XEFJEF5L+DAKtH20Eqsmb/BmQdOr03/pGMQEag1CQoMDuINRhF2Xzg1yW40cqlQYKc3v7qvuNBaE9g2E9omyolysm418X0TrRmZWeOQJyimhFQrFmmRVuqjvsIxiitbleNPdZRdmqPUA4tSAsvG4nqyNgyqCkYjifg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746776473; c=relaxed/simple;
	bh=DW1BKxTlV1yYmqBkfcAWvYM5e+Uuh8hcjIt6CNs+G2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nYuM1drXPHUI9W+8FU+46Fa9aaRxgNfRGu+aObHNrcOUVWJ5s71JTuPIvSy6HH7eZiNjjspq51zlWm3K0WOB73eonHASE5BrMvuQeBPdZk7vBj8F57ZNi/Zf55m3QJs8RCRTSdIubBqt22xDmdPtsloxQPVu0cikxKPJvrjlwhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=EsiRaRfT; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1746776460;
	bh=DW1BKxTlV1yYmqBkfcAWvYM5e+Uuh8hcjIt6CNs+G2M=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=EsiRaRfThIRLES2khdy4ycmxeu8Jf0ERcLuP0B5Ycm3QkYZW1Rnb3umX0JCY6cgnj
	 kATZD7WP1uSWjHWXlqNU6DDpdEKwtffs8ZjYOLLUE8/pc8x3hUaiQ4fcen4Nnk+ISD
	 cjWnev8gkrrRpR8OdirweE4PnkYcMZ+hgqNV1Kv4=
X-QQ-mid: zesmtpsz9t1746776458te5f03d3f
X-QQ-Originating-IP: jpOgmuWxThU2N9IujBG7zz83uiKhLp8YmONv9lRkilQ=
Received: from mail-yw1-f182.google.com ( [209.85.128.182])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 09 May 2025 15:40:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1265807080710549643
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7082ce1e47cso17756357b3.2;
        Fri, 09 May 2025 00:40:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUETYNIYlhewUnyNNRQJB/hzzLxrBsLRBCw6bynH0W/otRbF+Ma8Y9m9SAK4BKCadZhvuWeiu40LLTTNsqZ@vger.kernel.org, AJvYcCUKiHgJ9qle883dEVK08W8VP9/AWBkpDpyUPgozZcrkbdG2zHPADIG1XGuCXHGrHm1T+lKYSyly3mYIcFGq@vger.kernel.org
X-Gm-Message-State: AOJu0YwTFXPM9dAsYaqovp1DcxfdQ9re/5bb2qbcqgb1BdDNfrjxxZRb
	V9lcfZmWezTWWc8OPx530tBeLecTvW2dTAWODzuwla2VSq1zgYUk8bDoNS1iWW48vbPGFfVML3L
	rKaa7bT0zxFWhthnSWuG0w5vETZw=
X-Google-Smtp-Source: AGHT+IEmabRY5SROPxQjOoo2hdunN8s5tP16e1+Gk/9mjjjxidAP1RlkUwls01CWU2CR89VhRsFMqKW++viXH6XpHC0=
X-Received: by 2002:a05:690c:3605:b0:708:c37e:6269 with SMTP id
 00721157ae682-70a3fb7d500mr30917727b3.37.1746776455637; Fri, 09 May 2025
 00:40:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509-fusectl-backing-files-v3-0-393761f9b683@uniontech.com>
 <20250509-fusectl-backing-files-v3-2-393761f9b683@uniontech.com> <CAOQ4uxhuD0QF16jbYPqnoAUQHGw_ab3wi0ZONHVTXjCh0fug-Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxhuD0QF16jbYPqnoAUQHGw_ab3wi0ZONHVTXjCh0fug-Q@mail.gmail.com>
From: Chen Linxuan <chenlinxuan@uniontech.com>
Date: Fri, 9 May 2025 15:40:44 +0800
X-Gmail-Original-Message-ID: <F774A3CF92DC75A7+CAC1kPDMy7j6zCdGSSSrXUOEz6ejKX93WJaFU=e11=gF8E_QoQA@mail.gmail.com>
X-Gm-Features: ATxdqUHOkjHFsf8QsHwzv-BDvVpyi3wt9jjwxsvPaHIEoPw4Iw2S28WtaVkA8fY
Message-ID: <CAC1kPDMy7j6zCdGSSSrXUOEz6ejKX93WJaFU=e11=gF8E_QoQA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] fs: fuse: add backing_files control file
To: Amir Goldstein <amir73il@gmail.com>
Cc: chenlinxuan@uniontech.com, Miklos Szeredi <miklos@szeredi.hu>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: MPtvDXbctkRmKuaD5fbLmBcfgrWUMp63yYx1DQA2QLfHFHhj/8DxoE3u
	HmdqkGVM3Vc7+poWeNOK7MlYIrESQ7WODBc4GcTi+C7vL6FnXwzGXULJv5SVZ5KAMSJprEa
	6NC2jImeHvCkROF563cpIWyJAB8ituPwvYx1ukfJnos6HZt47YvFHhyU1BYGn59GzisOjU/
	sjFJeb7lk1x/pcUFNrwnArY7CAqe5A16ipO6MaQp5PbEvrk+/G63g3zTHv1V90U3oDUHt5p
	uJvhxCr8ee6tWtlLNfZXiFRPucZGwMv1fNQp7EuJF2fLM4xD6OZNZuI9QogbT+01A8yRecZ
	AYgDAXgxMwyRW5OTAhfKqCemAns0HrsCpbJfOOf4+UMFlzcaeBsGxFqoT5INEUZDWiCeoLF
	jnbj3J2u0KfDs4GrkOpLCjwciBStwh8LpWhaM2p2G5BmlsucGgFXBos1QgdMsvmoVJTDxcp
	3rYcYfyxBgO1LK7VJ6d04TD0eyBbFDAqOvX3FiUZ2uHxWBu9x27WvzmD9V0VfBgV+DqgSsd
	6jM0QbqFxTDo9dlDPct61LLZEGTrR32J9+fYehd+yBLoPMAQOO7Rtxc4yTWiHLIdO9npzg6
	5Ii/XfJp52jAK64C5ZzGpDX/ZIOclFCw04jLrYROQyADFw+eaHk3890mKec8Dc8Ik41lMOp
	gu3gT7bGUrNliTRDlsGHjkM/GAWfU97/uilHCGS/3P3JohDeU9SKQ5V1URFr1J/kU3KEGVv
	nGiZxLy8JzqaXg0WklcEdufLnf/7btBRb3EwuDpSZx6Qd3lYEkvVxxbMB6ryLbL+nviB4Uq
	HikqOYYF/8lrH1kWyxW//PtDjalQ4LQYC/14qcVA5Yk0PNgCx6RHVYMVOUA621hQfxEDMdo
	Z1oe4q0O/MghrsPpOXrM0kOIIwzV1mJvVoynNT/++GEE6SUFDZSBE+CMZ+Yb/pyA+lxAUvf
	RNH5mkGUOSf4U7pRrcgqHT/WMDkARU1AHMaF1SL1xHgbRDvvpkNOHaqnE9OX/t07et4eknG
	aQY+k/Qpk1ZFx11XY5JfLZrGKscDQ=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

On Fri, May 9, 2025 at 3:20=E2=80=AFPM Amir Goldstein <amir73il@gmail.com> =
wrote:
> Please undo these whitespace changes.

Sorry for that, I run clang-format somehow. They will be removed in V4.

