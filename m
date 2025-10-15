Return-Path: <linux-fsdevel+bounces-64200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FBDBDC9C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 07:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C7DE54EBB38
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 05:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496DD303C96;
	Wed, 15 Oct 2025 05:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="scO9Kl4R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A459F3009D5
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 05:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760506797; cv=none; b=ZcS8srwqLD+hFyE5xyRdTv0dnDto8NxGrGWNWfGBz3kzxhKqRM+EBe1MQE5B9uNpie0+oAkJU6FtUDlDLrE6tLEONLx/lt8HZC5OAfHglmOZbW7V58ddKEdCMpZp+Pm2rmjOYFDw8iTTUuV8C8og/TxpxPuNAYaTylBBUpMH4Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760506797; c=relaxed/simple;
	bh=N2YMTAv5/Erss4vrbn7vowBRWnEvN4sv8YMq6BF6G5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g0/Fayw9a1owPS0+MLAuuC3y/RTJUSCxTp4BOQYhFclKCxUGClrurqGQhMnHfUPiW6F3rw0dv/FEQOCHbBlkPCbqlwcaauVmQ9BitoiJtAP+9y8FXmCh3llogXcYSG45do4mkZKVA0tKl397wNfnFDL9EjbM06YjQpa8O6ZDBwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=scO9Kl4R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A110C113D0
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 05:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760506797;
	bh=N2YMTAv5/Erss4vrbn7vowBRWnEvN4sv8YMq6BF6G5Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=scO9Kl4RafaeNniBn95u3yg7MhdlvRM+SMiQv+fVPNGqXLManr4VTeidZ2y5QsLVi
	 KLNSVquKkWAqEpQ0QYSQel8RhFlMjTkugXrCEiCwD1nDVR+lpaE/Q6aL4QkS/RZ/Oj
	 LtB/pzGr9EVHc1r1/lruQO+1j4GL2Ixvx1qNuu2K2olKp+NNnZtSR0sWP/t0GFkSth
	 wmoJkR0GRqMi7mbulOLWlTF3i56eFqcHiWJU9vJpuLFICTZFmhszFFVF+uXcMrLTHy
	 m5EHNs+ZrlzwOdt8DTR5+5XIPitx/hJ82W6+jiYSuofAmlsc05fI+ljXaDBTWDFs6b
	 LXBHWOWFmRF8w==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b4aed12cea3so970519066b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 22:39:57 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy6kbKdvMt6UhLmxyou1Sm1zRF2CNug8viVCbWplSpF8pEVBN5W
	oEk9cXYCjSxjprXaPPlwoWVY1d6ERMG91E7zj6JHBBjOoCF/fMk8Cvm4G8M5spB8l/hYybdLy1K
	nhHG4FtJxWpiaOoL19nifgvNm0xg/8u4=
X-Google-Smtp-Source: AGHT+IH1vMU/orRGy0ZX6vYibEmnp37EGo9VhkFW5FLl7jTp9OahtUDri88B+d77LmUdc6jIEPU+Xohtq+ywr95c8Os=
X-Received: by 2002:a17:906:ee87:b0:b3c:3c8e:189d with SMTP id
 a640c23a62f3a-b50abfd3442mr2965512266b.32.1760506795889; Tue, 14 Oct 2025
 22:39:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014130146.3948175-1-p22gone@gmail.com>
In-Reply-To: <20251014130146.3948175-1-p22gone@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 15 Oct 2025 14:39:42 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-OSYg3fVoxDKVQm6r2kQDJuR-UfL26_ijoCPMsxX=L8Q@mail.gmail.com>
X-Gm-Features: AS18NWAp2ZUhgfa2PaM3K8dAQn-mvshE5Ir3V9wZGwh6SOrfZ_xhxjVxhKxZhKE
Message-ID: <CAKYAXd-OSYg3fVoxDKVQm6r2kQDJuR-UfL26_ijoCPMsxX=L8Q@mail.gmail.com>
Subject: Re: [PATCH] fs: exfat: fix improper check of dentry.stream.valid_size
To: Jaehun Gou <p22gone@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Seunghun Han <kkamagui@gmail.com>, Jihoon Kwon <jimmyxyz010315@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 10:02=E2=80=AFPM Jaehun Gou <p22gone@gmail.com> wro=
te:
>
> We found an infinite loop bug in the exFAT file system that can lead to a
> Denial-of-Service (DoS) condition. When a dentry in an exFAT filesystem i=
s
> malformed, the following system calls =E2=80=94 SYS_openat, SYS_ftruncate=
, and
> SYS_pwrite64 =E2=80=94 can cause the kernel to hang.
>
> Root cause analysis shows that the size validation code in exfat_find()
> does not check whether dentry.stream.valid_size is negative. As a result,
> the system calls mentioned above can succeed and eventually trigger the D=
oS
> issue.
>
> This patch adds a check for negative dentry.stream.valid_size to prevent
> this vulnerability.
>
> Co-developed-by: Seunghun Han <kkamagui@gmail.com>
> Signed-off-by: Seunghun Han <kkamagui@gmail.com>
> Co-developed-by: Jihoon Kwon <jimmyxyz010315@gmail.com>
> Signed-off-by: Jihoon Kwon <jimmyxyz010315@gmail.com>
> Signed-off-by: Jaehun Gou <p22gone@gmail.com>
Applied it to #dev.
Thanks!

