Return-Path: <linux-fsdevel+bounces-60023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 863B9B40F12
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 23:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF5A07AC40E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 21:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F291A356915;
	Tue,  2 Sep 2025 21:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOycWYG2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73A82E7652;
	Tue,  2 Sep 2025 21:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756847510; cv=none; b=kkzAvPVYzSJU5AkFBwytVje3eq/a1Tnw33sCn3tQnrP349ql6E5EmIxp9ApsRvF5JzTIrq2X2pkRPNpxmfmrmb7CdZ8zuBRGqcM4ebUd8zipz2M77KJVQqovk3uO/LUuJEqGeChIKONwb8M8AcLWXozZbkejOmuUDa+WXWRyN0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756847510; c=relaxed/simple;
	bh=En6G2eogi2Ak0VEhe2GzlXeUm7r4URlO92zGyKVeJns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qcmThmUz5q6WIhPNuDPQAHJDhGzNFe2lY68P90CfX26RcNDKWJAsUCV5qSZQd2BPNIHFXyglmZdQPu+cqjYnkDognWAreODaIIup2UIDJ8IIobEDXLuTFEzRbXUainG3zDzyKebT1FtyTvz+uQ6jTPoA8w5UmlK8kTLQoxT0Nvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOycWYG2; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-80aa386c1b6so8014685a.2;
        Tue, 02 Sep 2025 14:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756847507; x=1757452307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCHkgvBow6Wq5EnSYoxUILGM52dlyxcFCHXB4GdKvJU=;
        b=kOycWYG2ujjbggVxFjnFNFVpjZc4mqTNV+imG9P1wvzuPa87gU/qcR+OayXGdLKvuM
         ijbctZfqgx4BPKbE9wgsThNT9KjjfUUXAzR5xnB81+btzvqEnqgZ+qjJUf/WLyB0pXef
         6iHpi6R8jY3ZVajJcPJTMXLJ7WEG1phfdRlz67lkutTnjlatqPtbdBG5tSDCK86f48Gd
         Q/jOaD3wbkmH390TnEo3YtCBbExfFGfzIx1Nljqx2ilTjFMfQCDuuHoq6E+bu24OOdjN
         VMY1TeCkaWUEbC3RGcYHfpdZkfQ8wb7YWlz1BfS435o1Sb+WBfCODpLKjclTOoNfLXVB
         V6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756847507; x=1757452307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jCHkgvBow6Wq5EnSYoxUILGM52dlyxcFCHXB4GdKvJU=;
        b=NjnStGyrrY8L506iOkQt6lykPopqnkNkrIUFbmcNK0y2erMOzrfzArtvPdoS9IofBr
         1oaQgAWiP7bgBbimgEjZD1DikwDXWJsiyLc40SRmpeNZcOIEK51jMttBI7eyMpw2Jrpx
         YSSP71O4VYExUtziX/BbtfDSSCzqmiGjY9rBGiss7WCdsCT7E5vj/T+AQOuQSX0ZttFh
         7GvofQBq3Ou8hpEqHfcqkF0jNKyyncBRiMbytkrSZl5PdMfH9n+/xmrpR27OeFSDG+Gv
         BA1UgXdNkvk9/z7sEbf3mbv6+TtkLPEuKfuWDGVqXEtJWJ8XbscoyGNA/CldX1Qth325
         PKDg==
X-Forwarded-Encrypted: i=1; AJvYcCW2ZkN78Kc8Cvsain/3/5oUM9Ku7alVTjjxBa5m3/ebsMb8GtZrvYSJmH4JEwNJdelkBfiztYeJ18c+@vger.kernel.org, AJvYcCXiPPZdEFNf0VwKBaz2ZeynnrkeIcakT5nI/BK34OL4mGd/3EHulpnFnS+gU/5uQzEkAqBHfW7uBpTU@vger.kernel.org
X-Gm-Message-State: AOJu0YxcX7mxnE5tAfFzD2wTp+Ox3SwGo/7LA/ZzZ4hlupse9UpWnkEV
	fxT12i8jUWSk1hzknk3vDQm4BJ6njF4Kgaa+4EpXkYt45tUVOgjAZjKFL7qsJWmtWGx1zxVLNx/
	/NC2jrhyyZEwIOpnqd9WJtamY4Fo3LYs=
X-Gm-Gg: ASbGncsgIEyoESCl33lXh5/0XZfc16AuhW27HJFmXQ7/9AcNP0eF4QJOoTm0ikhtq3y
	cv3u9ZVKfoZo2fL/x2grKR8rwwBreXrFDMpJgewfz1gk5wFUVWcmrcPAA4rf4ntTLBV0G9zpBCN
	9+JJy/3my/nHv85oIF0Xq7b3a1sND6zyy3wed/QPTePulGA8Xqt1u4Q7inU/AzaFtS09MuWu/oi
	DKmzYVA
X-Google-Smtp-Source: AGHT+IGJ7/GEbIRDqu62C0RaYP9AkR0sCcicw44qUHV3Ppe4xqLIwN5sA1O7DI0SvbG0CYIMmtzKsvIXoEpxSDpCzHg=
X-Received: by 2002:ac8:578e:0:b0:4b2:8ac4:ef62 with SMTP id
 d75a77b69052e-4b31dc91342mr142663481cf.69.1756847506587; Tue, 02 Sep 2025
 14:11:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902150755.289469-1-bfoster@redhat.com> <20250902150755.289469-3-bfoster@redhat.com>
In-Reply-To: <20250902150755.289469-3-bfoster@redhat.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 2 Sep 2025 14:11:35 -0700
X-Gm-Features: Ac12FXzd5Tc0gZD3hhmZX6rQA-TF4cDxkCM1ruPesS0dAQoRnvT1P0EvGbzzbuo
Message-ID: <CAJnrk1bmjCB=8o-YOkPScftoXMrgpBKU3vtkMOViEfFQ9LXLfg@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] iomap: revert the iomap_iter pos on ->iomap_end() error
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, jack@suse.cz, djwong@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 8:04=E2=80=AFAM Brian Foster <bfoster@redhat.com> wr=
ote:
>
> An iomap op iteration should not be considered successful if
> ->iomap_end() fails. Most ->iomap_end() callbacks do not return
> errors, and for those that do we return the error to the caller, but
> this is still not sufficient in some corner cases.
>
> For example, if a DAX write to a shared iomap fails at ->iomap_end()
> on XFS, this means the remap of shared blocks from the COW fork to
> the data fork has possibly failed. In turn this means that just
> written data may not be accessible in the file. dax_iomap_rw()
> returns partial success over a returned error code and the operation
> has already advanced iter.pos by the time ->iomap_end() is called.
> This means that dax_iomap_rw() can return more bytes processed than
> have been completed successfully, including partial success instead
> of an error code if the first iteration happens to fail.
>
> To address this problem, first tweak the ->iomap_end() error
> handling logic to run regardless of whether the current iteration
> advanced the iter. Next, revert pos in the error handling path. Add
> a new helper to undo the changes from iomap_iter_advance(). It is
> static to start since the only initial user is in iomap_iter.c.
>
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
>  fs/iomap/iter.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
> index 7cc4599b9c9b..69c993fe51fa 100644
> --- a/fs/iomap/iter.c
> +++ b/fs/iomap/iter.c
> @@ -27,6 +27,22 @@ int iomap_iter_advance(struct iomap_iter *iter, u64 *c=
ount)
>         return 0;
>  }
>
> +/**
> + * iomap_iter_revert - revert the iterator position
> + * @iter: iteration structure
> + * @count: number of bytes to revert
> + *
> + * Revert the iterator position by the specified number of bytes, undoin=
g
> + * the effect of a previous iomap_iter_advance() call. The count must no=
t
> + * exceed the amount previously advanced in the current iter.
> + */
> +static void iomap_iter_revert(struct iomap_iter *iter, u64 count)
> +{
> +       count =3D min_t(u64, iter->pos - iter->iter_start_pos, count);
> +       iter->pos -=3D count;
> +       iter->len +=3D count;
> +}
> +
>  static inline void iomap_iter_done(struct iomap_iter *iter)
>  {
>         WARN_ON_ONCE(iter->iomap.offset > iter->pos);
> @@ -80,8 +96,10 @@ int iomap_iter(struct iomap_iter *iter, const struct i=
omap_ops *ops)
>                                 iomap_length_trim(iter, iter->iter_start_=
pos,
>                                                   olen),
>                                 advanced, iter->flags, &iter->iomap);
> -               if (ret < 0 && !advanced && !iter->status)
> +               if (ret < 0 && !iter->status) {
> +                       iomap_iter_revert(iter, advanced);
>                         return ret;
> +               }

Should iomap_iter_revert() also be called in the "if (iter->status <
0)" case a few lines below? I think otherwise, that leads to the same
problem in dax_iomap_rw() you pointed out in the commit message.

Thanks,
Joanne
>         }
>
>         /* detect old return semantics where this would advance */
> --
> 2.51.0
>
>

