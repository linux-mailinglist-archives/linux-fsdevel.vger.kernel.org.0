Return-Path: <linux-fsdevel+bounces-29785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FF797DC70
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Sep 2024 11:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 517061F21D78
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Sep 2024 09:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8DF156F45;
	Sat, 21 Sep 2024 09:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+tgV2iV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74026153803;
	Sat, 21 Sep 2024 09:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726911892; cv=none; b=MosNikk/cb6qc+uAIlI9jCMHZQ5m6kZ2/I91fsqXXrJk/v+MSAgMRRyejqd1fRpMCBy+6A2h07PqOfGVJGh7h7BK/N+7qIHJTLhspDqTjnx7YyQCgI/L7lwXGn7wmEvfJUV2e1mrnqOJwZr6DhdVQnNdZ1KYBH5qWOZ538O+bJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726911892; c=relaxed/simple;
	bh=6Phqsl9iMeUtupsVAY2eZ8WVBngHTyrcT+r5eK72yfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h2uyWfZrec4iwJh4JQi0mbYLcUOEjv7DEPmQkg0EUWDf7A5K4fqP2xx7GHcPd4ShkyB6p5hxUsYLKtOeF27TbsmTbfC/n30SGebM5RNCgfEHTWxQ088zISHb/Qwy1f1+sDaYDWhwaFUeradd6mjttD1epfrHXtOZnPxoBcfDf+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+tgV2iV; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6dbb24ee34dso24414067b3.2;
        Sat, 21 Sep 2024 02:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726911889; x=1727516689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iT/pooyDWx+cXonngBHeD7hY6o8n6hEZ+T12BUFn3eU=;
        b=g+tgV2iVKL0S39gv64nB2vdg0Mt5sISh/OndWkEjkXyfnMVYmIpSBMF1Tni+VLShsK
         VCeyisjYlEYUCrMbHelW6qJ31k7BFg94xeZX1AncxkshsOMrL/zItKuoThJjMewqrpnP
         iTG6Ux3Ie02yT2idxJV9Or1eAbQAQiLAXTzKf9kyhRNMi0SYegveeBwaeaPcApiSUtdE
         yDkZ0O9ERK06ph2ab4LczSdBi1O6v4IMuJkg1jJh/Yqoyw6tRHmieWYqdjX0trqiHRCI
         1uDJanSsnB0ieKaowrPJICXkorTlAtkmiQWnnGLU0gSPZqbQluvLntf7G8PJhgUjL0ae
         jNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726911889; x=1727516689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iT/pooyDWx+cXonngBHeD7hY6o8n6hEZ+T12BUFn3eU=;
        b=uabcHsI0EvIS6jlFntPzcn1/cNmj0N39a/NmuhbiM/mcJKsw3WsvJ8pAmElj4tardq
         gPFDvDqzhmJqZb/MfxJI0DEWV4T03IPPXZ9BFrQpRjAYciNq69yXlM+NKxmilrJ4c4yq
         84lL1v660saP0kpAq0ncLIH+suf77bzOLf3BeLkaXXzqLbv99TFVJ88um+GS/02yZ3YD
         sgIo/99eC0v1lcDnJw/SGZT4Y+Lp4fwkZDTokuWS2gAOqyOuERTS4iUA0yE2m9mDMiw5
         sKrOMZq+DUS9ZCO5zoRtSyWCvgUOH7ivhgZllryO1O0IyFRXEi4Ejg8FMVZ5snLufgZd
         YnWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRPCGyQ/GU4Vgq9tALOpAK/b/quRrr1adBBj4kgCMS424RAQHaqy1YQ9Ah8fgS70JAIyY+Km4fQ9OonF/3OPA=@vger.kernel.org, AJvYcCW+5qSsmapN+f8d+ALIa8SmsS0wxQzRabfYmMejqrJYcKpog2hTnFrp4185IQaDabcs+QrPhzIc27yZysU6@vger.kernel.org, AJvYcCXApA+kf9kVHOm5BV9T5ESJP+/8cUGyustOGnv+zqkz/9urjFqbEqMfKhDd/bgRH26v0/HlIC2CBjAF02TX@vger.kernel.org
X-Gm-Message-State: AOJu0YxugJfu0pwnFN13bSHuu5Dyhi8S+4i/42m7MqqwhI09DJPsbx72
	xhwrLtKnlRrg+P0GgcUwDCRzqgZz+twal1d030zco1EcytBpPoXfVzPcGiApm96YM0Aw1NnLaDt
	f+XUzjS0gUxVK86WFAdfvgRgfxSLxBMM8LKY=
X-Google-Smtp-Source: AGHT+IH7ANdlTlvW/Mj7eVhLgLzw9ibdGPzl72d8JbFblPa9x1BA+ryCfZKd5D4ZNR1894gY3DwL4D76QQESJDYX57Y=
X-Received: by 2002:a05:690c:d81:b0:6dd:d82c:4923 with SMTP id
 00721157ae682-6dfeec1393amr60883837b3.7.1726911889342; Sat, 21 Sep 2024
 02:44:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916135634.98554-1-toolmanp@tlmp.cc> <20240916135634.98554-11-toolmanp@tlmp.cc>
In-Reply-To: <20240916135634.98554-11-toolmanp@tlmp.cc>
From: Jianan Huang <jnhuang95@gmail.com>
Date: Sat, 21 Sep 2024 17:44:34 +0800
Message-ID: <CAJfKizpW1rQuVfB3cNKVsEMYvHBegGcy5fgxqTBrr0wGsjjpjw@mail.gmail.com>
Subject: Re: [RFC PATCH 10/24] erofs: add device_infos implementation in Rust
To: Yiyang Wu <toolmanp@tlmp.cc>
Cc: linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yiyang Wu via Linux-erofs <linux-erofs@lists.ozlabs.org> =E4=BA=8E2024=E5=
=B9=B49=E6=9C=8816=E6=97=A5=E5=91=A8=E4=B8=80 21:57=E5=86=99=E9=81=93=EF=BC=
=9A
>
> Add device_infos implementation in rust. It will later be used
> to be put inside the SuperblockInfo. This mask and spec can later
> be used to chunk-based image file block mapping.
>
> Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
> ---
>  fs/erofs/rust/erofs_sys/devices.rs | 47 ++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/fs/erofs/rust/erofs_sys/devices.rs b/fs/erofs/rust/erofs_sys=
/devices.rs
> index 097676ee8720..7495164c7bd0 100644
> --- a/fs/erofs/rust/erofs_sys/devices.rs
> +++ b/fs/erofs/rust/erofs_sys/devices.rs
> @@ -1,6 +1,10 @@
>  // Copyright 2024 Yiyang Wu
>  // SPDX-License-Identifier: MIT or GPL-2.0-or-later
>
> +use super::alloc_helper::*;
> +use super::data::raw_iters::*;
> +use super::data::*;
> +use super::*;
>  use alloc::vec::Vec;
>
>  /// Device specification.
> @@ -21,8 +25,51 @@ pub(crate) struct DeviceSlot {
>      reserved: [u8; 56],
>  }
>
> +impl From<[u8; 128]> for DeviceSlot {
> +    fn from(data: [u8; 128]) -> Self {
> +        Self {
> +            tags: data[0..64].try_into().unwrap(),
> +            blocks: u32::from_le_bytes([data[64], data[65], data[66], da=
ta[67]]),
> +            mapped_blocks: u32::from_le_bytes([data[68], data[69], data[=
70], data[71]]),
> +            reserved: data[72..128].try_into().unwrap(),
> +        }
> +    }
> +}
> +
>  /// Device information.
>  pub(crate) struct DeviceInfo {
>      pub(crate) mask: u16,
>      pub(crate) specs: Vec<DeviceSpec>,
>  }
> +
> +pub(crate) fn get_device_infos<'a>(
> +    iter: &mut (dyn ContinuousBufferIter<'a> + 'a),
> +) -> PosixResult<DeviceInfo> {
> +    let mut specs =3D Vec::new();
> +    for data in iter {
> +        let buffer =3D data?;
> +        let mut cur: usize =3D 0;
> +        let len =3D buffer.content().len();
> +        while cur + 128 <=3D len {


It is better to use macros instead of hardcode, like:
const EROFS_DEVT_SLOT_SIZE: usize =3D size_of::<DeviceSlot>();
Also works to the other similar usages in this patch set.

Thanks,
Jianan

>
> +            let slot_data: [u8; 128] =3D buffer.content()[cur..cur + 128=
].try_into().unwrap();
> +            let slot =3D DeviceSlot::from(slot_data);
> +            cur +=3D 128;
> +            push_vec(
> +                &mut specs,
> +                DeviceSpec {
> +                    tags: slot.tags,
> +                    blocks: slot.blocks,
> +                    mapped_blocks: slot.mapped_blocks,
> +                },
> +            )?;
> +        }
> +    }
> +
> +    let mask =3D if specs.is_empty() {
> +        0
> +    } else {
> +        (1 << (specs.len().ilog2() + 1)) - 1
> +    };
> +
> +    Ok(DeviceInfo { mask, specs })
> +}
> --
> 2.46.0
>

