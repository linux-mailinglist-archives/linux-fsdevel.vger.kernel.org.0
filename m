Return-Path: <linux-fsdevel+bounces-73043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 368BED093E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 13:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E57130677E4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 11:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D3F2F12D4;
	Fri,  9 Jan 2026 11:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKOEcdQh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694A52DEA6F
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jan 2026 11:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767959830; cv=none; b=TPD5H1XBR7yyG4JogSMsMWfwDhuPK+ksJpeXPvDrReh6fSoaQYnGnMjwZs2DH7UCN0W1Sp5Pd9JPQUA5BA2lPaDe5qZveuFZ+Tv2fMD/EzfJZKdwchTkciYKDK78nQoOD1p6Rb3u8I2zXZJDJ/QsLyQbAT6XbwhOMxBHqgjF1bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767959830; c=relaxed/simple;
	bh=TJkUINPmsmsT/3FkTPLlswhpPGoa3KRbDHsHX9DxiyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qF1P8REpy70/sMN36YfPsJw7Aho0kWkwSlE4tpdNEF16gdAGEZrsmUY5emDpuUqTWrmqg/doNk4Q/sNij+aDI7ly4TIYdEghUnxaHRsPm9WfO05EmCyC1TXsc6TCNbMskm/k8Ajspt0qQGWR6+PBQcN8tF94eicLq0Mk3hrkOcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKOEcdQh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3008EC19422
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jan 2026 11:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767959830;
	bh=TJkUINPmsmsT/3FkTPLlswhpPGoa3KRbDHsHX9DxiyQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IKOEcdQhDCWefHiMFnHgaTwZ/x0S1/po+qewWSMX1b3GN6M30iNHvqoEqecn52Tu2
	 h8F+HSxlUxJE79TPhtGAp20qLg6mTpVMZ2E7TYJLQdilyyhGEbl6NbqT9/3Z7VunTn
	 4N/u1gf3pw3Yii+Rcwm2w4+USaC5e8RZ0VBtYjTFDJZNdTt+97BWeI8mJM2nO5Ir8X
	 QkJP++KgCROIad3+B70YLj/hywBk67+jXIow0EvZqUXpJDVSLIfBxohBv4iR1FV67p
	 X+LcDmoAbnuSj4Zqk5oPeBEut62ViLSFNc1y8P6x2VU3RdMI/1sljvoBUr6wHzNWAb
	 fWb7jV9xxIdEg==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64ba74e6892so6957427a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jan 2026 03:57:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWyvyvBpx45nhJU0XXBj1wWubmRxTHHLljcL+BMpIGFZXhBbx5pTGfrYyaMVKG+8tYjM6CexiZ2jNlJyBDX@vger.kernel.org
X-Gm-Message-State: AOJu0YxBKqyHKFjZBnmMmPVktXf0PIxKWEnr0r3PyOuv4lzbN1RqS0jm
	tQFlIxNxLyaNjZSHww0QyKzMmnE1eYO2+Z9NyiFjePxGBYaP1O5GjtYh/YhCf4/VmKgM18Z5JPS
	PNQAERGES6M4kqTUvUnjdfkodjzF0a+8=
X-Google-Smtp-Source: AGHT+IE/jCAGzTGVgpwAJL5Ow263x0DjkyeWS+2xbWDTQls/BMqtG0Dy7kovpDjWVS9evcT4OTJS7OnxeMmdWZDa7JE=
X-Received: by 2002:aa7:cd13:0:b0:64b:7e89:811 with SMTP id
 4fb4d7f45d1cf-65097e071f5mr7275192a12.13.1767959828802; Fri, 09 Jan 2026
 03:57:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_E7EF2CBD4DBC5CC047C3EB74D3C52A55C905@qq.com>
In-Reply-To: <tencent_E7EF2CBD4DBC5CC047C3EB74D3C52A55C905@qq.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 9 Jan 2026 20:56:56 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-Dho9GYbv=RBw_Peu113BS+Hyjr+4De6tOZFFeam6z5w@mail.gmail.com>
X-Gm-Features: AZwV_QgFZI04wRFzkhIgwU3xluBEkSJ3ci8p4CmkAhuM5844sc7hWVBFAprMR_4
Message-ID: <CAKYAXd-Dho9GYbv=RBw_Peu113BS+Hyjr+4De6tOZFFeam6z5w@mail.gmail.com>
Subject: Re: [PATCH v1] exfat: reduce unnecessary writes during mmap write
To: yuling-dong@qq.com
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 6:41=E2=80=AFPM <yuling-dong@qq.com> wrote:
>
> From: Yuling Dong <yuling-dong@qq.com>
>
> During mmap write, exfat_page_mkwrite() currently extends
> valid_size to the end of the VMA range. For a large mapping,
> this can push valid_size far beyond the page that actually
> triggered the fault, resulting in unnecessary writes.
>
> valid_size only needs to extend to the start of the page
> being written, because when the page is written, valid_size
> will be extended to the end of the page.
>
> Signed-off-by: Yuling Dong <yuling-dong@qq.com>
Applied it to #dev with Yuezhang's Reviewed-by tag.
Thanks!

