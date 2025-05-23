Return-Path: <linux-fsdevel+bounces-49786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A878AC2858
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 19:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C24417213D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 17:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB8B297B72;
	Fri, 23 May 2025 17:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNAJsHMU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D161FBE83;
	Fri, 23 May 2025 17:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748020483; cv=none; b=c176S+afjAxk0aUh8lo6WwQktmDalAwQ1b+gQd5r74VQ03SnJ0csTNZQZJ7OBmmMoLn+OOzRKDpL4xk12PmLMgGAakrInS+FusyN7t+YU+tdmOEHFlQC9KW8L2rMVzEmCDCjnAtTKFF12lWnjB9d4WG/6TPnrI0h5rJuubAUmIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748020483; c=relaxed/simple;
	bh=atQBNKHKezlnn+go8nHj7UjOigG9EzlAH0iGaInVnBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kyy2f8nsxRIofuGhtUJ+mQjf6til7UK37/c3M7MmsZEbxtCaXw1oAeDwMYkrYaj78hRvWKqcOGEw0mR+PAO1TB8parjR/xI1HUTNhrwBd7S6GMkRe/YdsobidleUDVZOtk+QEtUAQ2L5CYjMK8ZL6PCKlaDTQ8iz4UKYWP1ur6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNAJsHMU; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ad572ba1347so6975666b.1;
        Fri, 23 May 2025 10:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748020479; x=1748625279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=atQBNKHKezlnn+go8nHj7UjOigG9EzlAH0iGaInVnBw=;
        b=gNAJsHMUIDUNt3LoSv35UNoECrPJFYJE7REE2yVLGnuqM6Jwm/ZydDjVS2ujzcd/Sg
         90pwH2vBdbV+F+7J3i8EAC6l/ApeotDvcYW6W4i8AEtxMl43wkWIoPJKyN/RTevfHJbi
         8vZZGTBrwntUZUhAsfQGLTnqe21LLIzWne87iNXp3KFwvvbbWaoCMrK3ojqtNdxF2hOg
         XxmCXNF/FPbEV6nYzC4WSxrHzvXHC+vrL8PK9aLoprOkMRiEPSvd8g86TuNav/2jO8W5
         gEHEdPShArrkaL8BlI2y4Z34I8DHnEAL8kqgGsGnrxU/OAciOXv7/qrIjPoXZx4g0jDg
         BJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748020479; x=1748625279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=atQBNKHKezlnn+go8nHj7UjOigG9EzlAH0iGaInVnBw=;
        b=fg7cF51ot2Ly1Hrx0tQnLcFlji9ae0NLfA5bFOJt4IM/0Uh4zM5KrLl2DlGmeMnTGt
         0NNvw45pX7H29rymyEJi0inQwygcexovNCDsx3K4FA9q5a+CXCcKpEx5z9wu7L39lUxf
         ILbaqQgJZ06L2aaA4OvOblBMPATfb5ch8hH7+xFV7rioa2FAIJdu8wjanUw/laIzdKbU
         xowj6UzAC17STOVob8awySFeY+3HKHeJsd/GtbPclzG0TdThtcS59xpslFWEqCMbtSvX
         +Rnhf1p8dC2/AdVGkSxZOJX8ch0yIT9CV5etvQcn0OzdOyDLmkINxlEYDrAyhjHD7tPh
         /95w==
X-Forwarded-Encrypted: i=1; AJvYcCW4ZNfTAw6qqt+NkJJcwfgkyrvAsJhK/XFNbHlgGRSPias1oYRsdEqSV7P7KzgpPSWget8grwil89OMTBD+gw==@vger.kernel.org, AJvYcCWQbEUMBL6hQScGUujA5x3vArLIDF59efKHGkb8tA0C2fvjhT0DVYwkKJgL0m3nu2PZ8s0pnI7f1HpcfGms@vger.kernel.org, AJvYcCWgIZWdyn/MYDkJicB5SCi0aD4nF/plMMl9nWjH9ihMeQZ5avxWCRulFKgKI9qIA7CGc5HPbPRBCt0KKNF/Og==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8auIdwU1OSOQS059sQm8NVhknt+wQLwcPuwXGsipT+9zgSz5S
	eJWg7qWiw8SWdeTzy8jvYu+KU/0OBiIrTLDOTTFanip9kgHoKBngtLUFpHs83aBFqxhOBegNei0
	Aoqxej6gUYhh8DRnbyZxgJKb+fVNrLc0=
X-Gm-Gg: ASbGnctqbJw+EQrm4moADHBqcPlype/QHT/YQFoWR2rxAKjK9b3CO/6bDpf4ZqHinU3
	sWqfam0S/vbA2o9hioriQq/MVwbpIho62yPPaOmmRx5/LW8Afbp+IWq62lHwypmN/lpZfibao4/
	RbDeMyrRiwJMsyiKZVB/VWIHvGTKOBnQ6x
X-Google-Smtp-Source: AGHT+IGqiLGCyt+aaxUVjuHc6e2CiBYsixZGc5EbCgT9ChhUIypncg3vR0+O5tMXvcwdmw1Q4LC5KYuSjRK/dSP71Jo=
X-Received: by 2002:a17:907:7e9a:b0:ad5:3746:591b with SMTP id
 a640c23a62f3a-ad71c145017mr336743966b.55.1748020478850; Fri, 23 May 2025
 10:14:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520051600.1903319-1-kent.overstreet@linux.dev>
 <CAOQ4uxg8p2Kg0BKrU4NSUzLVVLWcW=vLaw4kJkVR1Q-LyRbRXA@mail.gmail.com>
 <osbsqlzkc4zttz4gxa25exm5bhqog3tpyirsezcbcdesaucd7g@4sltqny4ybnz>
 <CAOQ4uxjUC=1MinjDCOfY5t89N3ga6msLmpVXL1p23qdQax6fSg@mail.gmail.com>
 <gdvg6zswvq4zjzo6vntggoacrgxxh33zmejo72yusp7aqkqzic@kaibexik7lvh>
 <CAOQ4uxg9sKC_8PLARkN6aB3E_U62_S3kfnBuRbAvho9BNzGAsQ@mail.gmail.com>
 <rkbkjp7xvefmtutkwtltyd6xch2pbw47x5czx6ctldemus2bvj@2ukfdmtfjjbw>
 <CAOQ4uxgOM83u1SOd4zxpDmWFsGvrgqErKRwea=85_drpF6WESA@mail.gmail.com> <q6o6jrgwpdt67xsztsqjmewt66kjv6btyayazk7zlk4zjoww4n@2zzowgibx5ka>
In-Reply-To: <q6o6jrgwpdt67xsztsqjmewt66kjv6btyayazk7zlk4zjoww4n@2zzowgibx5ka>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 23 May 2025 19:14:26 +0200
X-Gm-Features: AX0GCFv2oRlM7FHSR5Ynjf9N9iEswnp1zWupsoF1CkKw5ZI9WwCyO1ri0UtyyOM
Message-ID: <CAOQ4uxisCFNuHtSJoP19525BDdfeN2ukehj_-7PxepSTDOte9w@mail.gmail.com>
Subject: Re: [PATCH 0/6] overlayfs + casefolding
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 4:10=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Tue, May 20, 2025 at 04:33:14PM +0200, Amir Goldstein wrote:
> > I am saying that IMO a smaller impact (and less user friendly) fix is m=
ore
> > appropriate way to deal with this problem.
>
> What do you think about doing your approach as a stopgap?
>
> It seems this is hitting a lot of people, something we can backport to
> 6.15 would be good to have.

Yes, I think I can do that.
Will try to get to it next week.

Thanks,
Amir.

