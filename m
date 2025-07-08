Return-Path: <linux-fsdevel+bounces-54240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4AEAFCAA3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 14:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DEFA188F5A8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 12:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE382DCC03;
	Tue,  8 Jul 2025 12:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SsTW1GIL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CBE2DBF46;
	Tue,  8 Jul 2025 12:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751978505; cv=none; b=a7CZnc0Zbquf7CtuZ1wjil3QKVJLMciE0Wol0iIIbbubeY0UEFU/3YYaLce0TmpYLs8y7G0L2PWuc6Tqx5vlF/xGcJR2RGDZWINbY1l5hD3wvUTKesYtPJ5GWBA9SJXvEG9KKGOolgHEc/ckszOEoETq8HdPHf4xApaBcJPRrJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751978505; c=relaxed/simple;
	bh=UDADHF9j7uzd5QoSv3jvR04UvpD5yl4ti/QBxd3YBx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MNgzmg9Igw/Vbkx+90VfTgfFzF49YzBH1qnEz8KXpToKOAnZy4aOlhCZiYTUv4R3glbTGQCEb0ZjpgGuQ9QmydFRBjoTKNEJThRH41qju8C6tH4M835RaYA82/+ZurkjXCXZGS0F9DQaHgwgg1WaIaRgbn8+xdqiLyoENfjEEqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SsTW1GIL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A151FC4CEFB;
	Tue,  8 Jul 2025 12:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751978504;
	bh=UDADHF9j7uzd5QoSv3jvR04UvpD5yl4ti/QBxd3YBx0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SsTW1GILr2212peynD7tzYfofUC+MgaQgdZ248l+zKny5n7HeUD+MtPwmEO7qKYSM
	 lefSk23gkJtEDG7J0sKpM3gbLROPq7FpH5scZTSbjSrdwfBAVWKLkTMO8e/Yng3v4H
	 Dlug8XEGLd0jHswufNYClBeCkaiubh2NFIs01QS/JRx67om7w1/2rQ94PsFLHoE0NE
	 aBOif3Hpz1ywlZwB20atdA0RLLYF0Z5ccttlC7O+pIxDM+wkvQbZRvcAT0Dy1IePSj
	 AvLNjXjE90DMhwEkYROCaL3d2p/81mav3Y/+++CP3aw867pukENTOHPsIg++AGAeNM
	 pKOhQMq78BhjA==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-553b544e7b4so4236114e87.3;
        Tue, 08 Jul 2025 05:41:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCViws9PZi4bSAMZLkFKsYBT36LUESlvmaBHC/GnFnzQBZyuHmaIXJ14xMcTiex394AKZdYw4GS+f1HNRtpnag==@vger.kernel.org, AJvYcCVu9pTscDxbe/8jVvYpk8sNNFuoHbAzve71Cm6BMkYTJk1lybUWXi2AKS1gtLhC5CY1xrAs6FUKHpA=@vger.kernel.org, AJvYcCWC4B2hKwe8QndN36V7QQUqNRv0x35yU+y9Z8Zqdhn931vsUWWElzSJX7bKyfmnhcTh3hcTqJIuBNC/1+PS@vger.kernel.org, AJvYcCWFUl4ABoHjFyhjh5FYC826fUe08Ey7HF84MckOQU3AxuLVNqpIR77ol4zFSSztwsG4XDs4P5U9WKp4Q2XJFQ==@vger.kernel.org, AJvYcCWMW/5NnnuZDTPC26akSDhJ5IgaQBsJBHsW7QxkoQNQPBEmmPmRvz7miUkOrDYfrcXKz76aIP2LWpYN3uHe@vger.kernel.org
X-Gm-Message-State: AOJu0YzNdO+eh3tjDtqtv+gJw01PcZEBQffGW/W+A04YDFkUvA26LbWc
	x2i2G84HEuFnX+vKZLcWLYphWMmMjvHBkWTLCTcmpaixmgwvoEgGO5/s0sJynSurQWJTVKvmAfO
	NtGmltxXF8RA2kws0ikm7zwqrCkS2ca4=
X-Google-Smtp-Source: AGHT+IHnkIrMN8rQO1Bq02PlrdcivXsZiXfu4vY290OBC0doTWbVX97bege4WFESW0Skf3G3JWewKwGqnc4dnFeTqYg=
X-Received: by 2002:a05:6512:ac8:b0:553:d910:932b with SMTP id
 2adb3069b0e04-557ab019fadmr4874002e87.46.1751978503246; Tue, 08 Jul 2025
 05:41:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708-export_modules-v1-0-fbf7a282d23f@suse.cz> <20250708-export_modules-v1-1-fbf7a282d23f@suse.cz>
In-Reply-To: <20250708-export_modules-v1-1-fbf7a282d23f@suse.cz>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 8 Jul 2025 21:41:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNATpQrHX_8x4WvhDN7cODCCLr8kihydtfM-6wxhY17xtQw@mail.gmail.com>
X-Gm-Features: Ac12FXzLKEAaSK0UCVY02u21bjI8ZtyUUPqLJc13t8D_Olyr5l1LvUDi-odjq5Y
Message-ID: <CAK7LNATpQrHX_8x4WvhDN7cODCCLr8kihydtfM-6wxhY17xtQw@mail.gmail.com>
Subject: Re: [PATCH 1/2] module: Restrict module namespace access to in-tree modules
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Matthias Maennich <maennich@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Christoph Hellwig <hch@infradead.org>, Peter Zijlstra <peterz@infradead.org>, 
	David Hildenbrand <david@redhat.com>, Shivank Garg <shivankg@amd.com>, 
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 4:29=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wro=
te:
>
> The module namespace support has been introduced to allow restricting
> exports to specific modules only, and intended for in-tree modules such
> as kvm. Make this intention explicit by disallowing out of tree modules
> both for the module loader and modpost.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>



In my understanding, an external module with the same name
can override the internal one.

This change disallows such a use-case.



--=20
Best Regards
Masahiro Yamada

