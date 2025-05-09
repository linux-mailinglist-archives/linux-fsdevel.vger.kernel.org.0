Return-Path: <linux-fsdevel+bounces-48541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A38BAB0BD2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 09:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 969A21C21286
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 07:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B3726FD95;
	Fri,  9 May 2025 07:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcWJKAxa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF451D7E41;
	Fri,  9 May 2025 07:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746776185; cv=none; b=NX1yccc22H/zEBg1XbG7/sHGThrg0MgCZBdo7lPgrvF+CxcK9r7big8R6Iaa6SPvsF9xN1XI4RooodC+ApmrpPvPB3r25H+lH4YM7n2eAj3+/XlJdpC7sRYissiMuSLYWSafO5P0Q4ro8ENRHPlvCuUPXWDe/S0hXEOIQfmVWBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746776185; c=relaxed/simple;
	bh=J9QbrfM4U6ptK292VIafrVLrHL0eK1mmlDQ6kNmCF1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rePD30Li+Nw5CloP3Mb2mKlymziN9VVIX2HcgMtlPWhU881X9ya0IU8SG/GYsw3gwdjPsiwttRaF/XSSzkgKGQ62tY/iFx3rbrSoxjQvI8I9P0H7jqzXGCfR6+m5JuWMIlsSLSghU+l03vLfMzLub/6aWmDKiw7ArkQJawiGoxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GcWJKAxa; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5fbf007ea38so2961040a12.3;
        Fri, 09 May 2025 00:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746776182; x=1747380982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9QbrfM4U6ptK292VIafrVLrHL0eK1mmlDQ6kNmCF1g=;
        b=GcWJKAxazjXZb0CRm+afJzcdWufL9Oyr+zOwyQ+APOO7hsd8Am7nPkWwQ2tZXmsE8p
         cDL8uboRQdAlzFyZXgr3rItRIdGKsfSnWqRjD/AxmBZiQSrx8BB6YvKyAz/lokzTHYb2
         UW7s+41VNjDyyt20Li4X3ipbpGJROU8ZZw19RFsRyeHUZqgE51Elo9ErMD25nmluES9s
         jBEPk4PyniFdV+gzo70c1+lm6yovdaR4efv0E84FbXqPGwjrk7QYm7ggTlu25695oei6
         xOQl7CajlYvsNwY8OADPdC/PWEcDcmIvDpL0eeWdAWxYn/c373AFV1PCUrqXTRhzar0R
         oEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746776182; x=1747380982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9QbrfM4U6ptK292VIafrVLrHL0eK1mmlDQ6kNmCF1g=;
        b=qAOe6waZOwXyjAHauTUVx4u9F/SIRi0pS6YbbaUtjzkALxClO87cu2983M/Epg5xnx
         ZWASdZezck3sqg/IgNuswOHfYxrbUZIeJFBWilOaomJSoWvlBgR/4zXGDS4J04bPpFcH
         NFFSApiRCn3btg7KU7iBN5TwuAfzxReOdVbqvsW5SGkujNimgICFLbYI2p3iLvxJ1V3/
         UIapq3sqajL/u8MyTwavs671g5JaHAW3D1m3VBspQqi2PluuIkXSkTMAPWq46EK6RtCE
         WWMpz1u/0uk73DNb/uKSWTg+CIUpC1i5a0EyOyiQT7xnyUsphn9eJetmDNK7bvPtrBte
         xoPw==
X-Forwarded-Encrypted: i=1; AJvYcCVWTSEHFU9AioDX4igoGuOGFGpgqY4n/CswtcICr3TYjL/97JZ+MV00/gKQabeJT7a2+Po1JEWCE3w1t6Eu@vger.kernel.org, AJvYcCWO015tpwYVX85SAfwMWV2d1W87XO5SKquUC/qw7rxV4xU/F11AoZX6LFl32Z4XpjISKLoBHcd3Vx7iNFZE@vger.kernel.org
X-Gm-Message-State: AOJu0YxSIXmJTXRI/ij9uRjL80N6uMuBoYO65XCxKdV1MhkJSnq1AeyD
	wqYSmwqYI0t+HW0ZaQJkksAS+fA5TCG7tQpGk20BQL5viH0gCDDtjY1XwT32VqK+NcsNgiSGsUe
	OyjrmYeEVnrTUihPVjGbMxHrdlfQ=
X-Gm-Gg: ASbGnct5siE9Fth41pXGqLBwey6hDsdiyVz28MCqmHOjYlRT4jlDrJBKT7OSJo3MPS7
	VEPTURczSU5ac6iKkAVb8FIQdpyUAlIyvCjRr4IkiMOAb8zrjskS9iReiBXPNQ4XtryjdvC6U8C
	iXar6QEByyYuGaUyU0DKhvSg==
X-Google-Smtp-Source: AGHT+IFZ1BZviChgXYQ9pBGUY5KawwmhgVPnmwaR3jALvTLATujp+2yj/ei6kQDHBtcK2KdGorYYjkMLA85T4qldgiQ=
X-Received: by 2002:a17:907:7ea0:b0:aca:a347:c050 with SMTP id
 a640c23a62f3a-ad2187ba1demr229273366b.0.1746776181887; Fri, 09 May 2025
 00:36:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509-fusectl-backing-files-v3-0-393761f9b683@uniontech.com>
In-Reply-To: <20250509-fusectl-backing-files-v3-0-393761f9b683@uniontech.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 9 May 2025 09:36:10 +0200
X-Gm-Features: ATxdqUEibn5I5wmSi6Gm3KV7GmrnDGo5HHc-tbERNYy3mZ3ktviboTyENjDwM88
Message-ID: <CAOQ4uxjDwk6NA_UKiJuXfyY=2G33rruu3jr70pthFpBBbSgp1A@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] fuse: Expose more information of fuse backing
 files to userspace
To: chenlinxuan@uniontech.com
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 8:34=E2=80=AFAM Chen Linxuan via B4 Relay
<devnull+chenlinxuan.uniontech.com@kernel.org> wrote:
>
> Please review this patch series carefully. I am new to kernel
> development and I am not quite sure if I have followed the best
> practices, especially in terms of seq_file, error handling and locking.
> I would appreciate any feedback.
>
> I have do some simply testing using libfuse example [1]. It seems to
> work well.
>
> [1]: https://github.com/libfuse/libfuse/blob/master/example/passthrough_h=
p.cc
>
> Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
> ---

Very nice work Chen!

Please give reviewers some more time to review before posting v4
and you do not have to post v4 on account of my minor comments
unless Miklos requests it.

One thing that now comes to mind is how lsof is going to use and present
this information?

I did not look at how lsof presents io_uring fixed files, but I assume that
an io_uring is always associated with a specific user process.
How does lsof display the io_uring files?

I guess with io_uring, lsof can list a pid which admin can kill to release =
the
open files?
This is not the case with displaying conn, because lsof is not designed
to list fuse conn.

Is there a way for userspace to get from conn to fuse server pid?

Even if there were a way, I think that the fuse connection and open
backing files can certainly outlive the killed fuse server process.

But still, in the common case, if lsof can blame the fuse server process,
in most cases, killing the fuse server process will release the backing fil=
es,
so it may be worth looking into this.

Thanks,
Amir.

