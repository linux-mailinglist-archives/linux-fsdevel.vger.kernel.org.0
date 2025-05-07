Return-Path: <linux-fsdevel+bounces-48409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D60AAE75C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 19:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5142D9C4091
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 17:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84FE28C2D8;
	Wed,  7 May 2025 17:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="PyRPQmvK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017862147EE;
	Wed,  7 May 2025 17:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746637420; cv=none; b=jCW6y+yIVDmqi/ax2ofaa7NiZBwltrxyz3NfOUI2yu9Ft2mqteaMbX5L//GctvSwxrhmgjnN0MA07sxC4sQx43lw2gDQxqxW2dGWazgSYp7qHgvvsulV+x0Zi5sRf8s8/HfDFYiIBFm3o9THSkMq5ABR2lWNS51aDgISY/gZels=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746637420; c=relaxed/simple;
	bh=5TAhFObYg7zZDMui/hMZM8JDbT69wYaipxEKQMXqeUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=igWPreJroSvvKparFxGSYrn6MGWTNiM5ty8UH+W00h6vvttGa7YD7tk715JL+4jVuYaqD6RHwAMYNYfL9B1ooiopxtOE0SKWoCwRrx4xfNs65xiwSQUmXNlNwnEC1PMsjBnSa+11Med9taANdJRLTQNW8WbulhbIup22LxdI2bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=PyRPQmvK; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1746637407;
	bh=5TAhFObYg7zZDMui/hMZM8JDbT69wYaipxEKQMXqeUs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=PyRPQmvKBvLdOJiUQRZ1h7X+PFHT6n4snimB0ekkFwh4NW5dpVhAN6vPNNXj6hqMh
	 i6kZKAhx+1akWDoTTPydJs2nuS9SoRx15W/O38pTfHS0XQBz/3vqz6hOGEWjwQ7R3a
	 9vwGbX2TyanK3Sc8InZzyw8f/xLoooMuTRYJf/yI=
X-QQ-mid: esmtpgz14t1746637404t6f1d7e20
X-QQ-Originating-IP: wHEFxwwMZcx8373H9xGyhJ2zpWqxA8Dkd5gvKEGsg6k=
Received: from mail-yw1-f181.google.com ( [209.85.128.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 08 May 2025 01:03:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7374583256002677600
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7053f85f059so593487b3.2;
        Wed, 07 May 2025 10:03:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW+8/kPsqfKfgm7n9fdAvhXFucdID1tqou3lrmWvJ5umVKQ7DEglAw2t1cQL4bx1d7RJTRAbZ90Uun1Wnaj@vger.kernel.org, AJvYcCXjMAX8hprhXJ3FL9hTwM+fgtSuzZhzWt8w8u4HSnh4B5t5ZrtlzaUP/b1nwkmGF4c+qURDQJ2MypYSTCQz@vger.kernel.org
X-Gm-Message-State: AOJu0YynDVGqElS9DZwkNpIEH/GpkrIdznZi56LurhmOl8g5QNX2E01S
	51tJMp+TRhu2N59x4uboChe1PD88fWPNpC4jcXQpy+Lee4WgTjMK6tyeNW01niUCe6cEe6QoJA6
	YnFk19ZVwvCElZcOQdW28tlLhnAY=
X-Google-Smtp-Source: AGHT+IEB01ceoUeRdveS4boU89jBoptUVv0fs/vajQv4IpiFz42jTRAQsh6IhFh1tBJYKgn08X+p6yNbuG9bfjFod1A=
X-Received: by 2002:a05:690c:3749:b0:709:176d:2b5 with SMTP id
 00721157ae682-70a2ce86309mr3461347b3.2.1746637402104; Wed, 07 May 2025
 10:03:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507032926.377076-2-chenlinxuan@uniontech.com>
 <CAOQ4uxjKFXOKQxPpxtS6G_nR0tpw95w0GiO68UcWg_OBhmSY=Q@mail.gmail.com>
 <CAC1kPDP4oO29B_TM-2wvzt1+Gc6hWTDGMfHSJhOax4_Cg2dEkg@mail.gmail.com> <CAOQ4uxgS3OUy9tpphAJKCQFRAn2zTERXXa0QN_KvP6ZOe2KVBw@mail.gmail.com>
In-Reply-To: <CAOQ4uxgS3OUy9tpphAJKCQFRAn2zTERXXa0QN_KvP6ZOe2KVBw@mail.gmail.com>
From: Chen Linxuan <chenlinxuan@uniontech.com>
Date: Thu, 8 May 2025 01:03:08 +0800
X-Gmail-Original-Message-ID: <792479EEC274B193+CAC1kPDPY=qpGNRO3CH6_jSMKh6RyfHPFw71gCcpBZ-ogG41psA@mail.gmail.com>
X-Gm-Features: ATxdqUEnZjnlcVOxnEDi_RdK47R8Vtl6mCVCgMItBEKveTQPCEKYTRG2lP9l4oo
Message-ID: <CAC1kPDPY=qpGNRO3CH6_jSMKh6RyfHPFw71gCcpBZ-ogG41psA@mail.gmail.com>
Subject: Re: [RFC PATCH] fs: fuse: add backing_files control file
To: Amir Goldstein <amir73il@gmail.com>
Cc: Chen Linxuan <chenlinxuan@uniontech.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: OStqjMFNanKnuIfUx9301bN4eKlmdiUbBcs54cHnm9NuFBI+9U3X4uCv
	Vs5+CaSAWKmV+pcjqeFFvtwHEP3S7ZIi48Lh2ceZ65FyNFMKDBrSUdJ/SnbsMHbJ+kX7BG4
	RGEAafEus1JUU1Aw9Htxyf6Oe5lEovOoqBgjQOsGQFNOfnxxMXZ4OLSYC0xVMl8GYaLbPmZ
	macbaU9phAq3YBED4XPIM/v5kbmTnGLQ9qfAeHRAbQl0Lxq3TtKbZ/6TFoSgqshAmUKX/Ll
	iSITsppyLkA8NAefKRZfddw2IYlgry585GU4gT/TbGndVw9BznUw6JdMANfjuo5qfqnPaVE
	bJxyvEdPNmDImaiJoUz3deJITygdPhzUK4nIo3qMnboeZ66uxRYYIf+R8W1MtFOFfYmYq6L
	bS3FGEp0dmvxPnZZIu52uth8eDNfa/9/Rw/IRWBlSkbr3eXXccAnHMamCeq+rXuz6r52Cgi
	W2alYB7T+N+oQU0TNnIfqCYmsKzV9ZTu2qEam089jrPVfkpaSEBXFXnwG3sFl+tNpVcA2Li
	vgE40/igYx9Fi8jqyRZP+nJBIqOlbJClt6ad+jWy5njgWuW7v5LZwfxQiscaqhs81tX5Rud
	OBWW7fL8EyhZ3G4ZbyVB5eWvhwBUxmJXKpD4NhxXQr0lgLFCaGgX/9bqQBuY1RHD05gIY+j
	At47639TicgRitiTTrayAUOAw+JBIFXzrGQJTdsb7ThOvKFQVrKust4pyqFbZxmDXNoueQm
	r/kFefTNjO0adSgUtARmkw8CcAvpq/kAFLcdoqP2Iu3zSm/kCgFPB0UbwfAztGOepsnjPHO
	8JA7nA2CmFLUVJvOsLBY5TESL4wZmqBVVxfCyFKbzfReh5vjEZin2UnkjXsM3nb6oXWCzTK
	xLyP4TBJSQSNR4v2/XM06156qLpyEMMMDBSbhlOFzB/G1X6ErR4p9djkfVKu6P7rJMqF1NC
	UqlzGdDH/twQBCKqLUCNH9COgPIllT2bjb6mkc0bAFmVwCKxWGBD/y7W1jFAvYQCsqbvjG8
	1oZkRzztzo4TUgESFuQjPGr8Rx9HhNtc3SKOJJhphKF8EZJ8yD
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

On Thu, May 8, 2025 at 12:57=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:

> It means everything to userspace.
> backing ids are part of the userspace UAPI - you have documented it yours=
elf.
> The fuse server used backing ids to manage access to backing files
> https://github.com/libfuse/libfuse/blob/master/example/passthrough_hp.cc#=
L855

Oh, I see.

> This is extra and nice to have.
> It can show admin which files are using fuse passthrough.
> It cannot replace displaying all backing ids under connection
> because server can register backing ids without using them to open files
> and most importantly server can leak backing ids, which is a good
> reason to kill it.

I will have a try later.

