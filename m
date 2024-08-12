Return-Path: <linux-fsdevel+bounces-25718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDB094F7F0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 22:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 831901F23290
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 20:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8748E198858;
	Mon, 12 Aug 2024 20:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnlWM/Jk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929F11953B9;
	Mon, 12 Aug 2024 20:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723493191; cv=none; b=fcSlo6JrYH9MLIS2Y8gpYpX0K9n1ptVolTFj4txCo9u7ijajNtt+cUQW70nqG2DGT6hszpc4+Q4ozafNEguq5NwGfOyFVKybN4jzBZeVIJbon1RRwj6jlURyX/Wit2tMgYgSFjrMQH0Ai2Sr0S925dgQXsEv9VdYDXFyYnpCSKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723493191; c=relaxed/simple;
	bh=YsL1C655win8Uvf7tw+7VbikqZnhSC3xRrRZZ+RmAGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dw49QrsVXJiTv2OLtl6I7gAvhLl4jhZ1drA8/KMzqoTnaXkyjoz1cx6Xte4KGhiByMteAR7fFWZuyYeKPtOZ6Wdt281VRp0vAxn9jbwCrNlZ9vWW4sH+2leTK+2wTLzbDPGsnN0o9IQJsDjy3uwiamAeTfO1wtIiPgFXszyfojs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnlWM/Jk; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2cb5789297eso3125616a91.3;
        Mon, 12 Aug 2024 13:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723493190; x=1724097990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpOEroGtysYF4ielafugNiaUnt54QpoeMG73y+fLisk=;
        b=fnlWM/JkZEXIJfcMZXkvt/77h805czG1WgN/Y4BcGwHSaRgwcTdprarHOXCq9knBNH
         umiMzQuoFV7PBS7uzesdWf+MXDqBzEHaH0eQHHOLfAAjNIjvyTVD0A6M3k8f5n497QtV
         8/Fp1aSFcRWzEDOxXR9uV+OOIbC/LMm4OAmbyzypEj/n8xjqxXg/S93SNChHUdn/C4V0
         AzrZ2GVqb9L1P9DmVBFrfnyZNKsGVdXnuLVOO1hZgtoGb/WMbBWxH/sMccWFypheDfVA
         vKy9AEy1PFrEtYfg9n9IY+Saf0qxWLWQTr642HAwvE7PURoGmxQr76uO8aDk+diyYCsf
         ai5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723493190; x=1724097990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dpOEroGtysYF4ielafugNiaUnt54QpoeMG73y+fLisk=;
        b=OAIq/eXOTbneP+g4w7mzs9doEV0c+vKekgQma9qy93HUDehtyQUHwDlT2bN0mwbTxz
         RJNJLO9y4hx0KMKadXxWrs54CeEAjejmBlJA6kzqI5gK51IJ7/De5/IviCPCBTizXAhP
         F5qgQoZKrAiZ+pM3gGk5pLFOjfi9DPTuFPbui3E9Fte4vABUyNDuKxmxnvrHSxai8kie
         TnqjsqxEFN3LWU5jdgvbD8trW9W+wmsjeYOtQEPCb1o+X+nrl8O1aw3hOWsjxe2Tyytg
         NwIhgqElAj5rT6Vu56p49ZH7lFVQFSLE24iU9VIq65+jRl5+hamWddug1suy9w7m3XZP
         WwBg==
X-Forwarded-Encrypted: i=1; AJvYcCUB5x4noJddlFkM7D8WE7qqtKWBq9Dk/7knQTHsfKO6x0s/IXbSpU9M+uTkMV8qZbpX2J4OIHnEDcLiTljEzwjbY2vzPyKk8sTZ3FBsmtSIbNm6uETQamE5efgemiJ5lTx2Y3KfSFDYQT5hb4SEVZlZfv1vxqijdJTboD1E34Wlkp2M+L8R49wKVsxwYNwtdHikHnuf+/Rh8DQJ65W6tUrIPGVO3eAlSAg=
X-Gm-Message-State: AOJu0YzehjenyvlLCkoq6ZAbvgyAMLfy/IxXwSH+yXyjcAfRZy/G9i5i
	VXsOPdRqgBGYvOppdsldJVIeS6RR5KI6cZbYJ8K3ZWznNFiyQ5pvbNWM9Uqj2OkduR/1E9coIjk
	VzItct6KEsaIcUlebJPs+GW9g/GI=
X-Google-Smtp-Source: AGHT+IElPb2EaTXK/MBk35WwyrKLUOG1Ydv8xeHRyMsqe2bfhQXzbIVKz1s7TXLnA6y6XoLOJpoxQtvntqfBMRcK1VE=
X-Received: by 2002:a17:90b:230b:b0:2c9:69cc:3a6a with SMTP id
 98e67ed59e1d1-2d3924d6069mr1539107a91.3.1723493190015; Mon, 12 Aug 2024
 13:06:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730050927.GC5334@ZenIV> <20240730051625.14349-1-viro@kernel.org>
 <20240730051625.14349-35-viro@kernel.org> <CAEf4BzasSXFx5edPknxVnmk+o6oAyOU0h_Tg_yHVaJcaJfpPOQ@mail.gmail.com>
 <20240810034644.GC13701@ZenIV>
In-Reply-To: <20240810034644.GC13701@ZenIV>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 12 Aug 2024 13:06:17 -0700
Message-ID: <CAEf4BzYGF1aur6W9PDzN3MFoDmVNDQ6G5k0=gv-04m6ZpeK3Jg@mail.gmail.com>
Subject: Re: [PATCH 35/39] convert bpf_token_create()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: viro@kernel.org, linux-fsdevel@vger.kernel.org, amir73il@gmail.com, 
	bpf@vger.kernel.org, brauner@kernel.org, cgroups@vger.kernel.org, 
	kvm@vger.kernel.org, netdev@vger.kernel.org, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 8:46=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> On Tue, Aug 06, 2024 at 03:42:56PM -0700, Andrii Nakryiko wrote:
>
> > By constify you mean something like below?
>
> Yep.  Should go through LSM folks, probably, and once it's in
> those path_get() and path_put() around the call can go to hell,
> along with 'path' itself (we can use file->f_path instead).

Ok, cool. Let's then do that branch you proposed, and I can send
everything on top of it, removing path_get()+path_put() you add here.

