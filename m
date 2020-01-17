Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE71140169
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 02:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387985AbgAQBYk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 20:24:40 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39086 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729031AbgAQBYk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 20:24:40 -0500
Received: by mail-lf1-f65.google.com with SMTP id y1so17062330lfb.6;
        Thu, 16 Jan 2020 17:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=8OEzNGE8WntpLTWt1EhAJDqUk5LPizHOkSh4Q6wW+cQ=;
        b=REqHSi0dN9BShLxCV4GA/cwh6FWboGIR8iRPkn6a54TPyjrWZZYomsvt2njt6g7oPD
         MBZ1TykRn8jfJLqctE4/7qzp4zZ+xIMvBw62jY7YlYS5+kxXZIDi1znnxB3WKdRnnDaR
         eEaV/WJYeS7gFpm0gCN7mk8uCwSactA5ghNu4GrfixBEW709qRZOuUesi1gCAOm4FDUn
         YWeppve/OdgOjitcQiCDPiJpFQ62952H7p1prdwnCc8fgf6TvbSqvodyCK7pk16paC+p
         hcVj5DZd6d4FcH1zDQnBy1v7hY0Gw0eK67F7K4OJMPva21BTVZ62c9nJORFT5i7L9TmV
         7O+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=8OEzNGE8WntpLTWt1EhAJDqUk5LPizHOkSh4Q6wW+cQ=;
        b=ksJbEJVnLP6CNzN3gplSQ9y57dfXD6LD5Al7sSzrWVy0YpeB67/HRjTkISOMK2cQ7W
         IvHOohunw0NeLsNCN1jpS4LJpYBLRgu3Inpk0G7JhGoptk9xpRgw4hF91D3RE5Zz4mIN
         +MED2skRoiXS/20hOaxm4Gabn35O1MFS9K7bWO/cyfM36uXq7GPRv5zou12Acz2Wd/b1
         ZI6Tw0eNYpJbbHy3C093Q68UTKyQWJVeRvYvgOm46DUwgsrClulM/w0eJavJXSEMUzua
         Rxr7b5QBDtCdKxUlPmnDRjMoYuG1ET+zAZRm3jF247xQuDuwm2rGLwbyZUahSydwbu7c
         orLg==
X-Gm-Message-State: APjAAAUuxSJuswASYUvlWt+P+3drnGzvxehzOTDUIk8fZ7+BIXa2uzQR
        fo8C/jEFmpQC+RLFCMRXSAZdcpyp
X-Google-Smtp-Source: APXvYqxOxkxJTpypF17ZY7w7zxplQ3eU1dxCDmjvTIfjgPTj5MhVQKgImsWtHoCooRwF+/WEXAFvLQ==
X-Received: by 2002:a19:8456:: with SMTP id g83mr4181374lfd.0.1579224277226;
        Thu, 16 Jan 2020 17:24:37 -0800 (PST)
Received: from [192.168.43.54] ([109.126.145.157])
        by smtp.gmail.com with ESMTPSA id s2sm11459145lji.53.2020.01.16.17.24.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2020 17:24:36 -0800 (PST)
Subject: Re: [PATCH] fs: optimise kiocb_set_rw_flags()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <7d493d4872b75fc59556a63ee62c43b30c661ff9.1579223790.git.asml.silence@gmail.com>
 <20200117012123.GA9226@bombadil.infradead.org>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Message-ID: <8cecd243-38aa-292d-15cd-49b485f9253f@gmail.com>
Date:   Fri, 17 Jan 2020 04:23:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200117012123.GA9226@bombadil.infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="z25OKxZY3gL4n82P5hoaAq2IkX4AunVHc"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--z25OKxZY3gL4n82P5hoaAq2IkX4AunVHc
Content-Type: multipart/mixed; boundary="LjIWb8WWfCwl2iU753V9YLMquf9pCeF9w";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <8cecd243-38aa-292d-15cd-49b485f9253f@gmail.com>
Subject: Re: [PATCH] fs: optimise kiocb_set_rw_flags()
References: <7d493d4872b75fc59556a63ee62c43b30c661ff9.1579223790.git.asml.silence@gmail.com>
 <20200117012123.GA9226@bombadil.infradead.org>
In-Reply-To: <20200117012123.GA9226@bombadil.infradead.org>

--LjIWb8WWfCwl2iU753V9YLMquf9pCeF9w
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17/01/2020 04:21, Matthew Wilcox wrote:
> On Fri, Jan 17, 2020 at 04:16:41AM +0300, Pavel Begunkov wrote:
>> kiocb_set_rw_flags() generates a poor code with several memory writes
>> and a lot of jumps. Help compilers to optimise it.
>>
>> Tested with gcc 9.2 on x64-86, and as a result, it its output now is a=

>> plain code without jumps accumulating in a register before a memory
>> write.
>=20
> Nice!
>=20
>>  static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
>>  {
>> +	int kiocb_flags =3D 0;
>> +
>>  	if (unlikely(flags & ~RWF_SUPPORTED))
>>  		return -EOPNOTSUPP;
>> =20
>>  	if (flags & RWF_NOWAIT) {
>>  		if (!(ki->ki_filp->f_mode & FMODE_NOWAIT))
>>  			return -EOPNOTSUPP;
>> -		ki->ki_flags |=3D IOCB_NOWAIT;
>> +		kiocb_flags |=3D IOCB_NOWAIT;
>>  	}
>>  	if (flags & RWF_HIPRI)
>> -		ki->ki_flags |=3D IOCB_HIPRI;
>> +		kiocb_flags |=3D IOCB_HIPRI;
>>  	if (flags & RWF_DSYNC)
>> -		ki->ki_flags |=3D IOCB_DSYNC;
>> +		kiocb_flags |=3D IOCB_DSYNC;
>>  	if (flags & RWF_SYNC)
>> -		ki->ki_flags |=3D (IOCB_DSYNC | IOCB_SYNC);
>> +		kiocb_flags |=3D (IOCB_DSYNC | IOCB_SYNC);
>>  	if (flags & RWF_APPEND)
>> -		ki->ki_flags |=3D IOCB_APPEND;
>> +		kiocb_flags |=3D IOCB_APPEND;
>> +
>> +	if (kiocb_flags)
>> +		ki->ki_flags |=3D kiocb_flags;
>>  	return 0;
>>  }
>=20
> Might it generate even better code to do ...

Good idea, thanks! I'll resend

>=20
>  	int kiocb_flags =3D 0;
> =20
> +	if (!flags)
> +		return 0;
>  	if (unlikely(flags & ~RWF_SUPPORTED))
>  		return -EOPNOTSUPP;
> =20
> ...
>=20
> -	if (kiocb_flags)
> -		ki->ki_flags |=3D kiocb_flags;
> +	ki->ki_flags |=3D kiocb_flags;
>=20

--=20
Pavel Begunkov


--LjIWb8WWfCwl2iU753V9YLMquf9pCeF9w--

--z25OKxZY3gL4n82P5hoaAq2IkX4AunVHc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl4hDLUACgkQWt5b1Glr
+6Wm3A//aDJGM3s1upPd3JYSDCGp46ZsB3TNq4qJGEaGJsycGT46ZbXllqareMc2
5BBDIKAD8e4hqi/I0vM5jDLB1gmPCWuO5ktOWfI86m0jQfzCjNho64VZd2rmnf2y
fANkTryj3a7Nay9ClR6LjCm3C54orILRUi3gn15S1v7+2THVVg5Dh/6W29lCtplC
UXlGed/72+y8fxbY2tYmHTx6yRTJigMIBFqe+kYqoWItvvMwRuJHBHoty1PwvXaz
INXqzKmWelMmzaCbBMfso9NJv0s8g3XT51BF81BrgErf8M77Wj1ybem+VFprk+uY
wzIsl8HxC82Z1Q3/F/+kebtfKXL9pxphfgP2xocSb0ewjtE1QHMRxgrZRFFf4lVI
KfVlSE2LhQtjTroeqLJqiAtsUXOqKhXl68HRXfoKYDTqmvYWDE8r1F1G8kjM/Hnj
zv0AsP2uZIpgk8H3lxTG35PgsYcccEcNR97lQDIWj/NhHxNx4z+6MSp0wdK/IV4H
Q+4HtuFsJQUOlHe/QfNs315Y1G4M8oqWqqpsBfpuUf+fP4oC87Ihyix58/5lZOMk
9Zgoo6IiT/j4BDeeBgINJmT28aqaeJt76TW3Xl3vhTdogb8LvvaMTfjRQ/ABXFym
Zj0J1gWL+dGlJiFaD2D8uBHLVfP/JFeZ0WX4YuPMxWW/8m4Afy0=
=BWZu
-----END PGP SIGNATURE-----

--z25OKxZY3gL4n82P5hoaAq2IkX4AunVHc--
