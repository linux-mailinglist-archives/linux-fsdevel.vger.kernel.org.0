Return-Path: <linux-fsdevel+bounces-55208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C416B0864C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 09:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 538B21690F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 07:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C4B1F9F73;
	Thu, 17 Jul 2025 07:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8b4s420"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A162E3700;
	Thu, 17 Jul 2025 07:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752736454; cv=none; b=NZYtxRNhawoL1VFy+auMWjdzvAxXWJ7E1C6QhNFNQQdMT9vpLdQp4Fx6r+eNOh6JPLOHBkMBG9KuyLzIKKtt+UF4cOvYZpD9r/aXSBaqTMlKLvaTawKh/yX8/5e/8tQgK4WUl9lmUBmB5Di3sdW0OWuTGULn9OMjzuzWZXtUZRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752736454; c=relaxed/simple;
	bh=MSAIaEvvvYCEK96VzRIynmo1cJnmfI4w8dWBFlZ00y8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mxFeDsGXbvxq2XwtUb33B1Y8Sz3E123nWpSdwbdrWa9MKEyA8OgUjOWvngACoW0KhegxukZNVmP0LA7PnjDALvUT2JZdbWpuhW8Hz/3DuoxobFFPLpr97fux7Ma4CV6Pr9q6RAlc/B//Ri0gU+cb0gpEcV1Dz83IRfs4uO8xFnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8b4s420; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae6fa02d8feso101689866b.0;
        Thu, 17 Jul 2025 00:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752736451; x=1753341251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C93Jllk6qxwTfkg9YjGalQ9gTu1w7SAGocOEdb4F+7E=;
        b=l8b4s4209XgaBL8ty69ntglsHxbsAuoaHFdhgtWwahPNE/YvGE6BD1ejBGsxUsAIi3
         wWLNAuGaDsb/dBwzPzos+yrnC4DZmlgA6x7lDwlec7rx4gXhGeWOdQ5u9YaqZxiSjsZ+
         aknveUSWW1psF6b44mJQJl18JU6h4Q0094ZKWgy5z1pwjFDXYjPyVV3WBXK70naW1K6w
         HWaMWBGbqxesnYhBdjvB7Ldi/N4iZs15og+6wpW8uXXXZsUPo1ZBDb3vr0nb3/8x5Bfc
         72q7xu7zYpFBBNK1l9CImO8HH/ND0LmrOpULfEXXIdLwgzArIvXUV6YLN9IThtEexC6f
         Uxnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752736451; x=1753341251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C93Jllk6qxwTfkg9YjGalQ9gTu1w7SAGocOEdb4F+7E=;
        b=wonZWUVRx91M4vU2a6VqfOQ6OYqzbGvRSJrvajKvCU9Wy8W4qS6gacpeoY2noKYVRt
         sESYFiVjn80VGauCWLi+HKKuYpKwqmnTcT94jlsnNSG1+wGqFpjFRqQaK/4GS58Omtxh
         zvm93viZo+RwToJdOeNqad24V0udgvRJudSqF1y8Ih+PzUFzsA5vezSzmyFSXwfzBJ7I
         qIfNoTjw3HFepw2FQ5gGReuxJxLzynnos5ijzC5BuQTv5iQDd3DHls3SpocM6btbFenp
         4acKQyySFvQZuRvTf9ar85mhHn84A/ORcWfI2Klr9tm3OyU168adfyBBOPzxMaWtC/rz
         ZEpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWadeT3r+Q8h5O1vVM6H+QtrnqVr6VeSe+vzN3UPTCC0fw7AAA4C3JuNvhlw56UfA1ULfX0u4+JFK+Ndd4RS4Ph@vger.kernel.org, AJvYcCWzIlGAWUegu+GiXlKaChbXuwg9FeZxtCzZaQAghlbpeF8Uf3e5cLBPcX4NLwgwFYqrduv84Al5hmXzmkgX@vger.kernel.org, AJvYcCXarKHYdPi1AR7OiMsQSASDl/jNh3ic1icjE28gDuaF8SXPd2x1WjvHUSuhxLFULeZNVyJvr4bW0jol205/@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx1FUiy/f1r/3NigDH8Poetxoc7U0iPtExVefbDSenjlHq+2rc
	E8VoJLcnrXPuVhkh1+vpcFn24MR61odgURkZDzauv6s+BOKtw/9hKXzMirTxsLLF5ihxxWZAOWu
	XA5t75aW/MkSC10ZJURn5/65QaasewLq7zy16MGY=
X-Gm-Gg: ASbGncu/YZQKlUobKS/zXGZdjHI0Zp0CbBIJ7jpNf2tXENPnnlRelGd3AqRE0DEaX5F
	wxLn6gBZks5/v3UVevcevuEEJVIknvf+XLPNQI6FO+gBb2Sd8xeSbvsXVOiSbPpcphLJS55IB/C
	PhdYRbvvPw3zCqqjzs+f1A7NTC74KRXO8aqVdKVi/oOQB4W7mA0JiRazreUE4pOcKldLX3siUJq
	Zr2joI=
X-Google-Smtp-Source: AGHT+IE74WlkqiWkmooxNsrAqSlEbZb+daM4v058S8sDcqp/cGo/Fxz5pcLdVaR2FOB4Zg2B2CgIA5eiRxTOVptq+5M=
X-Received: by 2002:a17:907:9f13:b0:ae3:70cb:45d5 with SMTP id
 a640c23a62f3a-ae9ce14b143mr506925166b.48.1752736449302; Thu, 17 Jul 2025
 00:14:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612094033.2538122-2-chenlinxuan@uniontech.com> <20250619-nennen-eisvogel-6311408892e0@brauner>
In-Reply-To: <20250619-nennen-eisvogel-6311408892e0@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 17 Jul 2025 09:13:57 +0200
X-Gm-Features: Ac12FXwn1hZHGqytMW1VeaSUVrUBU71ovrUEFhcRwxqEPtOM8_b9MH1qx2AZORQ
Message-ID: <CAOQ4uxi3tT02zmZehAE06MyewER=NOj9iSZK14-nvPHJxD74kQ@mail.gmail.com>
Subject: Re: [PATCH v4] selftests: filesystems: Add functional test for the
 abort file in fusectl
To: Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>
Cc: Shuah Khan <shuah@kernel.org>, Chen Linxuan <chenlinxuan@uniontech.com>, zhanjun@uniontech.com, 
	niecheng1@uniontech.com, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 12:04=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Thu, 12 Jun 2025 17:40:29 +0800, Chen Linxuan wrote:
> > This patch add a simple functional test for the "abort" file
> > in fusectlfs (/sys/fs/fuse/connections/ID/about).

Miklos,

I see that this patch ended up in your tree.

Please fix above typo .../connections/ID/about =3D> abort

Thanks,
Amir.

> >
> > A simple fuse daemon is added for testing.
> >
> > Related discussion can be found in the link below.
> >
> > [...]
>
> Applied to the vfs-6.17.selftests branch of the vfs/vfs.git tree.
> Patches in the vfs-6.17.selftests branch should appear in linux-next soon=
.
>
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs-6.17.selftests
>
> [1/1] selftests: filesystems: Add functional test for the abort file in f=
usectl
>       https://git.kernel.org/vfs/vfs/c/0f505cf71c63

