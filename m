Return-Path: <linux-fsdevel+bounces-73640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD19D1D248
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 09:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5E59730090F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 08:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0BF35E551;
	Wed, 14 Jan 2026 08:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="G039VSQZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A8B37B407
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 08:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768379756; cv=none; b=eB08ktPCRQ3U8b0FctHrXiakt50Czvz9/dTx8f4gh89DjWCXTMtIkDTDkPzy6kdk2/VSWFMry30JsO/KaiDt3dAe72i8JqtOcSS7ml/07U0iMjHMZ6bSo0CHWo5bUA20UuLKpVad3oUg9AakxdFsYpdr/ew1fLRyovHyblpQZ2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768379756; c=relaxed/simple;
	bh=g7UxWR6zNuQUmm2GVSrSH6RwgetKAzX/Hd9cqIclbxM=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=RS4IoFaSngyGTjhjknPicJqu7/Gswffv8AZU0Jmk4SIl8p5lpzA1AZrdwH1TMUKoVtM369oF/PXYXlfj/uBvjXwe5JcpQQ4ZjCAFgvcuLIhdZRi3GjuEKfWFjJHwugtZxbRakN/JAAMYdmgA4dlK+dCt/7HbTXFiaUfofFZvoXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=G039VSQZ; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-64c893f3a94so1116453a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 00:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768379749; x=1768984549; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPPloNl7llTdagSQiWBgrN0JSa6mGncDJ/7BeD2LLwI=;
        b=G039VSQZaZoLCdJVFfvZ0KviLMt9qUaR6Mb+y7I5IlOwiGthsJzj1+iNPGCyvuTdFz
         G6Mdbhw+HxGVbkvIDbXJ0JyLQ+gk7jaEGFDWnlFVlaW/DuDUyrxHIOgNUCNWArr+h5ZY
         gOi3wikMxMNVLGmQ04GN0IPMuQXRDgrm30FIJmGGpVaTztaX8ers0MyezkXht4+z5pa8
         5Zi2jJfUKpmRjF6CZmmv26Qov+nlcpjxh4mBpiUYaXIb3EaJ7yin8/S5qyktTchOEciS
         lojD0kdkPJMtQfiruQJavaKKtaC/AlNwrrGenM6UnJg+I+HumsLrrNHgEWxh++YrcuSi
         voGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768379749; x=1768984549;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XPPloNl7llTdagSQiWBgrN0JSa6mGncDJ/7BeD2LLwI=;
        b=eS2Vql4EAqE+YznxxbqpjCdmh1I0VkEaZAA9roj/0FuJQaaQn/cZmWtnwdzBHgks6Y
         Q6v6at3ijAPUwQU2D4JjFxqozUBhNhimB/F8XAchpRUOERWGPkpM55utK7Uh3LvjSDHs
         wuXNljyAs9gnK6K/YJ4O8BMNrcDzXoF5wJvYfBtUH7pwFXVZ4tBjunReUo8MpVehiKHv
         jfKItkcdGYVHomZdRiulG4Fmv/zTHdZDqRZsPWEGoisb3Xvf2dPQPBtzxMrNlLo1d1z3
         6WjeaxEqDw51IDI3WO3kypPFLIKTpsazpeqmSbWs95hnWniaOpmnsyCAwfzfu9fRvg2D
         s7cw==
X-Gm-Message-State: AOJu0Yzvf6hVpR/kD0EvnmQgooxkSl6rp9eFwgu2bVV564yJ9I+na87a
	7a2t6osZ8J0W+c1Itc5uZLGjGEcYi2qoGsuP3R7/ytGOHCz3huc/cFlJ9b2PEMjvfu1bck38fY8
	4LdxJVLUYXg==
X-Gm-Gg: AY/fxX7pOUSP5O+a+qH3Vq1wRiZY2Uiy2ets1xbD1JdrUZ40wqkOtpUH63ufaGqp4Cj
	OaqyjuGTz/evpje/+FXaqlFLhkhr2UZrkx703IoEZFjsaHj7NIP+N2IQL2b5R2za0FBibIUFJfx
	J4331FoDo15I627iFhwOrho9VJJyvJ6FUMItRVJlEkmdo8/kglfIR2BLur4HUXVkR7Edr2g+g6F
	XXZn/yUs/c7RGi7V86Xhn9v/ChiaFdLR3z9zYFYCHi7X5h2ynEi95mZpRletBI1BhSqflutxEDa
	B6NU2ot88AR9wHbC2RHOeGFPoYiLjRcfJqcOYCFTfGBC60u4RFNiMOj6CdViSJNfVvZ91XgUcVI
	uycsI4Xawrdo2kR6Ys0OlHhFey2mst03ykFqVBUlFHTGVOGYc/R4SD7sN6fW+9/ztvh3pkHEwAH
	QMPdiJAFbPfKbXRgTKAih8bqIBqpTDGcLyFZIa7XkH+M0bTHJLS4fZ81BK1/ODjFpjVUL8bzdGP
	fO3sPI=
X-Received: by 2002:a17:907:6d17:b0:b87:2abc:4a2a with SMTP id a640c23a62f3a-b8761be4dc8mr132227166b.1.1768379749303;
        Wed, 14 Jan 2026 00:35:49 -0800 (PST)
Received: from localhost (p200300ef2f1649001c626999955e52c8.dip0.t-ipconnect.de. [2003:ef:2f16:4900:1c62:6999:955e:52c8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a56c547sm2437958966b.69.2026.01.14.00.35.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jan 2026 00:35:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 14 Jan 2026 09:35:48 +0100
Message-Id: <DFO6AXBPYYE4.2BD108FK6ACXE@suse.com>
From: "Andrea Cervesato" <andrea.cervesato@suse.com>
To: "Al Viro" <viro@zeniv.linux.org.uk>, <ltp@lists.linux.it>
Cc: <linux-fsdevel@vger.kernel.org>
Subject: Re: [LTP] [PATCH] lack of ENAMETOOLONG testcases for pathnames
 longer than PATH_MAX
X-Mailer: aerc 0.18.2
References: <20260113194936.GQ3634291@ZenIV>
In-Reply-To: <20260113194936.GQ3634291@ZenIV>

Hi!

On Tue Jan 13, 2026 at 8:49 PM CET, Al Viro wrote:
> 	There are different causes of ENAMETOOLONG.  It might come from
> filesystem rejecting an excessively long pathname component, but there's
> also "pathname is longer than PATH_MAX bytes, including terminating NUL"
> and that doesn't get checked anywhere.
>
> 	Ran into that when a braino in kernel patch broke that logics
> (ending up with cutoff too low) and that didn't get caught by LTP run.
>
> 	Patch below adds the checks to one of the tests that do deal
> with the other source of ENAMETOOLONG; it almost certainly not the
> right use of infrastructure, though.

The description is not well formatted, spaces at the beginning of the
phrases should be removed.

Also, we can make it slightly more clear, by saying that error can be
caused by a path name that is bigger than NAME_MAX, if relative, or
bigger than PATH_MAX, if absolute (when we use '/').

In this test we only verifies if relative paths are longer than
NAME_MAX (we give 273 bytes instead of 255 max), but we don't test if
path name is bigger than PATH_MAX.

We should correctly distinguish these two cases inside the test with
proper names as well. Check below..

>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
> diff --git a/testcases/kernel/syscalls/chdir/chdir04.c b/testcases/kernel=
/syscalls/chdir/chdir04.c
> index 6e53b7fef..e8dd5121d 100644
> --- a/testcases/kernel/syscalls/chdir/chdir04.c
> +++ b/testcases/kernel/syscalls/chdir/chdir04.c
> @@ -11,6 +11,8 @@
>  #include "tst_test.h"
> =20
>  static char long_dir[] =3D "abcdefghijklmnopqrstmnopqrstuvwxyzabcdefghij=
klmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopq=
rstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnop=
qrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvw=
xyz";
> +static char long_path[PATH_MAX+1];
> +static char shorter_path[PATH_MAX];
>  static char noexist_dir[] =3D "noexistdir";

When it comes to syscall testing, it's better to use guarded buffers.
This is easy to do: please check tst_test.bufs usage in here:

https://linux-test-project.readthedocs.io/en/latest/developers/api_c_tests.=
html#guarded-buffers-introduction

Many old tests are not using these buffers, but it's better to
introduce them when a test is refactored or fixed, like in this case.

You need to define:

static char *long_rel_path;
static char *long_abs_path;

...

static void setup(void) {
	..
	// initialize long_rel_path content
	// initialize long_abs_path content
}

static struct tst_test test =3D {
	..
	.bufs =3D (struct tst_buffer []) {
		{&long_rel_path, .size =3D NAME_MAX + 10},
		{&long_abs_path, .size =3D PATH_MAX + 10},
		{}
	}
};

> =20
>  static struct tcase {
> @@ -20,16 +22,23 @@ static struct tcase {
>  	{long_dir, ENAMETOOLONG},
>  	{noexist_dir, ENOENT},
>  	{0, EFAULT}, // bad_addr
> +	{long_path, ENAMETOOLONG},
> +	{shorter_path, 0},
>  };
> =20
>  static void verify_chdir(unsigned int i)
>  {
> -	TST_EXP_FAIL(chdir(tcases[i].dir), tcases[i].exp_errno, "chdir()");
> +	if (tcases[i].exp_errno)
> +		TST_EXP_FAIL(chdir(tcases[i].dir), tcases[i].exp_errno, "chdir()");
> +	else
> +		TST_EXP_PASS(chdir(tcases[i].dir), "chdir()");

In this test we only verify errors, so TST_EXP_PASS is not needed.

--=20
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


