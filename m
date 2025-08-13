Return-Path: <linux-fsdevel+bounces-57774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6939AB251D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 19:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02F625C5B10
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 17:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9219C295D99;
	Wed, 13 Aug 2025 17:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPcb2Vux"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE6528D8F4
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 17:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755104611; cv=none; b=jrGCoNPoZZA+ZkrsRThupNpFbR+TUhHdAZ1gVSGaEvtVovCFwC468UAB2UCGYPNfqAd4sMO8HEHF+ozrlr8Xri18G5aFgOfPnO5B7a3USJFDyKjowHM03hbU8A2vWMyCoN3CXPb8wDt03/XefjZ6IO+GyypagXKgI6UZT26uDy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755104611; c=relaxed/simple;
	bh=nUqx1hY4qyRT+Qd5lt4XKpitoAocfwd1ibsjsYM0+1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FF+phHuh1E7g3xcErinROyucu8YcvikHkDi6VMydYjb7l4LjjoY4i0xCL3myA+nHJOlo4Ty3VPR3+526hUfkCKv1q5EetBHtrLHE9pX/afZSOa/m3psUQHU47/8C9S8iggnbtk4QyulMVFMv8zuiT5Gu9wvF2JGeSmXqL3IwgSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPcb2Vux; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b109c59dc9so1301821cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 10:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755104608; x=1755709408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvgcXCw2/QJXgqIdPoXVHtzQe7LQ/EHJFe5VSw+1Lzo=;
        b=VPcb2VuxlymxydZw5YeA+N3Hcc9ctM3TjKMxN9jL/5IOyrzwNSe4PBV3jC55vM2Eje
         9aAhjVuzGv2cdahP+iJw6vAMNNqs90nMdhWMdHJONyuHxhHxVKa+MTbNeIfg0EAQOtdd
         m3k9kXaSPghFvtNqQVqR62dp2RORm6FYSuCPXuvmUG0LCgHCxNxHmTY2A/PGw2cVUsRG
         hhFzQEFpXJWFp7QwmUWXqejXnqPIsgfdxDYFyE2fkdBKLAJtp0nADFJbcz16B7ImFZfk
         nFCFIOFRT+OFb4nmRuRaTC7TJQWtAoS6IWS2dUd3oUZ8DX7sCBgly95udlaQjKj0dwm5
         RWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755104608; x=1755709408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CvgcXCw2/QJXgqIdPoXVHtzQe7LQ/EHJFe5VSw+1Lzo=;
        b=OCBsCFNDz/aEz3TwTj0WM9tOTPdCm0BwfaftWQpnw19orK9wbI+awia1Cfr6CdwdsF
         YocbYBDpY7L8RLMj3TqKf/uPiuUv56uwmu+ZCiUK/6ikzvRbNM8U3DB337b2IVoXyGRU
         jjol6L1EJHNXG9hxKlFimBaOLKz9k11Uq1jiB76L5L6qjzcu2Hh1WPfjv3faifIXoVZz
         Ob1rPrV/sNBiYxBadTmieEsWqJma//stGxEu/Vm6UkBh1yJpHG0wGyIzGw8J3g9eaERE
         ledkP2HudFa474lBANklABSgj//V6ib2UwZ3wpUIu17ooKpMI6qtShujNLxYaNpWIsLn
         tEgA==
X-Gm-Message-State: AOJu0YyXdxnwzQ5zsihDg/am3uJZZD7fWGUR26zd3XBcgp4kzlWLkAok
	62jL6MVneyIWBeUjWio1+Z7OFj9IZlz93+SqIKpzHdaP3AFIqFAr8RKLHocFiPTU15AcNevhABy
	A785Uufz/7hoMlNHF2f3DzbsD620TYTc=
X-Gm-Gg: ASbGncv1ecLox7F3B0Sx2+mkZUF1aaxs1Tc4PmueBVhcx/+skiBnoyYd9Qi+SLcdska
	zYSqPX574D/PvYPMOLpq+YV3Az/qrnhuTbIGbMfBE1zQsv/uXAOf5ZVKRDUWQXYNK1on2GNy5xl
	o/J8dn5+r5L/zuwcSAOcyjiFTmFP+kk04lxbC7EiuKtjKI0hWcNcAa2hyP8wCC/xqaW7oATj4tq
	nvWSLhX
X-Google-Smtp-Source: AGHT+IH65lrSordBtbYAKJOxKWfwVDlE5QOumW3IOPxMOMfdfQwL/BL+sXqrjzFlQzaUG05Pk6DSxJj1RtfZjjI7q0E=
X-Received: by 2002:ac8:6909:0:b0:4b0:74ac:db35 with SMTP id
 d75a77b69052e-4b0fc7135d8mr58197571cf.12.1755104607834; Wed, 13 Aug 2025
 10:03:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813152014.100048-1-mszeredi@redhat.com> <20250813152014.100048-4-mszeredi@redhat.com>
In-Reply-To: <20250813152014.100048-4-mszeredi@redhat.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 13 Aug 2025 10:03:17 -0700
X-Gm-Features: Ac12FXzzp0pZWwwXpihysnH1aF5dwnT1DB_Z35wkjxCjK61QliJtqeKi1wPb6Fg
Message-ID: <CAJnrk1bfoumJHwc5p-WASXYxWG8tzz91LfzpiEkPTSOoTDK1ig@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] fuse: add COPY_FILE_RANGE_64 that allows large copies
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>, 
	Amir Goldstein <amir73il@gmail.com>, Chunsheng Luo <luochunsheng@ustc.edu>, 
	Florian Weimer <fweimer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 8:24=E2=80=AFAM Miklos Szeredi <mszeredi@redhat.com=
> wrote:
>
> The FUSE protocol uses struct fuse_write_out to convey the return value o=
f
> copy_file_range, which is restricted to uint32_t.  But the COPY_FILE_RANG=
E
> interface supports a 64-bit size copies and there's no reason why copies
> should be limited to 32-bit.
>
> Introduce a new op COPY_FILE_RANGE_64, which is identical, except the
> number of bytes copied is returned in a 64-bit value.
>
> If the fuse server does not support COPY_FILE_RANGE_64, fall back to
> COPY_FILE_RANGE.

Is it unacceptable to add a union in struct fuse_write_out that
accepts a uint64_t bytes_copied?
struct fuse_write_out {
    union {
        struct {
            uint32_t size;
            uint32_t padding;
        };
        uint64_t bytes_copied;
    };
};

Maybe a little ugly but that seems backwards-compatible to me and
would prevent needing a new FUSE_COPY_FILE_RANGE64.

>
> Reported-by: Florian Weimer <fweimer@redhat.com>
> Closes: https://lore.kernel.org/all/lhuh5ynl8z5.fsf@oldenburg.str.redhat.=
com/
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/fuse/file.c            | 44 ++++++++++++++++++++++++++++-----------
>  fs/fuse/fuse_i.h          |  3 +++
>  include/uapi/linux/fuse.h | 12 ++++++++++-
>  3 files changed, 46 insertions(+), 13 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 4adcf09d4b01..867b5fde1237 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -3013,33 +3015,51 @@ static ssize_t __fuse_copy_file_range(struct file=
 *file_in, loff_t pos_in,
>         if (is_unstable)
>                 set_bit(FUSE_I_SIZE_UNSTABLE, &fi_out->state);
>
> -       args.opcode =3D FUSE_COPY_FILE_RANGE;
> +       args.opcode =3D FUSE_COPY_FILE_RANGE_64;
>         args.nodeid =3D ff_in->nodeid;
>         args.in_numargs =3D 1;
>         args.in_args[0].size =3D sizeof(inarg);
>         args.in_args[0].value =3D &inarg;
>         args.out_numargs =3D 1;
> -       args.out_args[0].size =3D sizeof(outarg);
> -       args.out_args[0].value =3D &outarg;
> +       args.out_args[0].size =3D sizeof(outarg_64);
> +       args.out_args[0].value =3D &outarg_64;
> +       if (fc->no_copy_file_range_64) {
> +fallback:
> +               /* Fall back to old op that can't handle large copy lengt=
h */
> +               args.opcode =3D FUSE_COPY_FILE_RANGE;
> +               args.out_args[0].size =3D sizeof(outarg);
> +               args.out_args[0].value =3D &outarg;
> +               inarg.len =3D len =3D min_t(size_t, len, UINT_MAX & PAGE_=
MASK);
> +       }
>         err =3D fuse_simple_request(fm, &args);
>         if (err =3D=3D -ENOSYS) {
> -               fc->no_copy_file_range =3D 1;
> -               err =3D -EOPNOTSUPP;
> +               if (fc->no_copy_file_range_64) {

Maybe clearer here to do the if check on the args.opcode? Then this
could just be
if (args.opcode =3D=3D FUSE_COPY_FILE_RANGE) {

which imo is a lot easier to follow.

> +                       fc->no_copy_file_range =3D 1;
> +                       err =3D -EOPNOTSUPP;
> +               } else {
> +                       fc->no_copy_file_range_64 =3D 1;
> +                       goto fallback;
> +               }
>         }
> -       if (!err && outarg.size > len)
> -               err =3D -EIO;
> -
>         if (err)
>                 goto out;
>
> +       bytes_copied =3D fc->no_copy_file_range_64 ?
> +               outarg.size : outarg_64.bytes_copied;
> +
> +       if (bytes_copied > len) {
> +               err =3D -EIO;
> +               goto out;
> +       }
> +
>         truncate_inode_pages_range(inode_out->i_mapping,
>                                    ALIGN_DOWN(pos_out, PAGE_SIZE),
> -                                  ALIGN(pos_out + outarg.size, PAGE_SIZE=
) - 1);
> +                                  ALIGN(pos_out + bytes_copied, PAGE_SIZ=
E) - 1);
>
>         file_update_time(file_out);
> -       fuse_write_update_attr(inode_out, pos_out + outarg.size, outarg.s=
ize);
> +       fuse_write_update_attr(inode_out, pos_out + bytes_copied, bytes_c=
opied);
>
> -       err =3D outarg.size;
> +       err =3D bytes_copied;
>  out:
>         if (is_unstable)
>                 clear_bit(FUSE_I_SIZE_UNSTABLE, &fi_out->state);
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 122d6586e8d4..94621f68a5cc 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -1148,6 +1153,11 @@ struct fuse_copy_file_range_in {
>         uint64_t        flags;
>  };
>
> +/* For FUSE_COPY_FILE_RANGE_64 */
> +struct fuse_copy_file_range_out {

imo having the 64 in the struct name more explicitly makes it clearer
to the server which one they're supposed to use, eg struct
fuse_copy_file_range64_out

Thanks,
Joanne
> +       uint64_t        bytes_copied;
> +};
> +

