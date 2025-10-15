Return-Path: <linux-fsdevel+bounces-64257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 370F1BDFF0E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 19:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B15C934436D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 17:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A862FB967;
	Wed, 15 Oct 2025 17:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApawYAOk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FAE1547EE
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 17:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760550580; cv=none; b=o75KL9GdiA0cvx7StQuDIzMXHFoPc7C7HBwY5o9EVrSZbMW1DssRHoJueuGvrkiSdpzR+UoIxFn9NMjsCmSsdQ8oAUfFhJGtO/riTa98UjFWimrIOQUfGQ6E7YEHEyNV08q3muytU3DSyodnrHU1BycRiRaCNRzbP60Bd8LWjcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760550580; c=relaxed/simple;
	bh=H0Gp5ixszVrrYPJI69yYG2CevFqzo3/xy0fMkdup3cc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=or9jvOvfcurZ8z5mBvXS+hhc8UA2+oW9f732rhpiQxdxer5Hn25wU1nPlynqM0eZm0Sk2kojGq0GUVqSzePp/lmd59Ly5WPORkN0bmTVyZM8fXGcyBCUC1esQvyn/OGDP3fSjoeSeNvocVUzVn4oNBwhxG0mpAkUelKHdIMuq3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ApawYAOk; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-87c103928ffso146676d6.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 10:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760550578; x=1761155378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0Gp5ixszVrrYPJI69yYG2CevFqzo3/xy0fMkdup3cc=;
        b=ApawYAOkwCznnZcmwR/JPXRdsGRS3EXcTbOJQ0ew+f+KTVAOH7OmEVdqeCFUJNpfv1
         lzwkR51JMkelUTlgZfy16wxNhXMTNJu94OgYrExn5EpM/slmbnAqYlLRfjinmFUskUoL
         R8aE8tovnraZxrp9blrjHeVmy23NvuIPKyosG5j2DtOUw4Z4XDn7dTKCeRnM6N+1+1Ja
         vngk9C07FycmgvU9pgrsa2vzZ7ZYPdIJCQaj2v4+0wZmN6qigY7Gzx+PvsnCHq46rOcO
         MNf9NfIha7oJmKLD6OaM335XFAM5/XZXsMr24nf6kY4SKE/KsaZRIW+gUOLQrFzj+mpW
         sUUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760550578; x=1761155378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H0Gp5ixszVrrYPJI69yYG2CevFqzo3/xy0fMkdup3cc=;
        b=dBjnBMR8SINcnagVLsutHyOVEmJSqH0LTl+8w6hmmZsz5WNPP7/051kRI0OUjJ4ro6
         pysOm17Pc3S62sWgcnzGiw8M2t2gvxZNofxptefyVuEsFa/91cgrh58cb95MiuTUpQvj
         HOHn9OpNzgKbDYHvgfG6rTa8KavuiQT1ikyb/ESa7WIyQ3HJc94CbCE/9t2K0s3QZmwg
         mNJ/msBD2feqHCMsFWj0Wsl4RdXKYPGtyi62UFKysaa6czbHlwLn30WLroRtVYZBY5kR
         1mNkOnPRxBftlqOiOTmP0V15b7PW39xoJ6sS0+C2AIPMM9eioq/vD0FpTJsi9RjBLeb1
         LqVw==
X-Forwarded-Encrypted: i=1; AJvYcCXiq88J/CCVcNctNTHuqosF3eFSVwFXlSTOrPiiGpleTGE2ky8EzNJuPqo4ujEEZ7gcGakLXSHwcsfSWn2A@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6kmC0Y18H23K8e+JfMkDbFgTiOd6aRufof452/MDd15zxljFc
	O08rXiDvuR9j6MeZ118RQv4ZMVBynlfRfBUhnFHZq522dcSsN3rft1G8hfP4WKRqidrfh7ovHyc
	rZL6fo03jK+V6T3+CbsnI9c6Y+a3CfyNvZG4HcGo=
X-Gm-Gg: ASbGnctYayxBhElzoFhXrlPT/2T3elMZ+P9whKtaFgkEkwPQiSiaEtFrtyQqykmXfC9
	HT+irOWxEON5l26AmH2ArgZBIYg8RMgy8v9nQPS5XdczfCtvGL74j+kHEhLAgN5GTIu8YPaYoPE
	Im4AniNfukPs5gs+7txTrKzZWqF5TRw85abtkrjNWk8K8Q80/75EN5ugS9maXm5JY0PWfhhVVEM
	BqsEphs/ZBhambMBE8thYmE06399BvGkDgBtyaEBN8jd/rwf7uQMQUzFh8V2vZMOAIo
X-Google-Smtp-Source: AGHT+IGu1UC7b44kaY4u9K+Dzad0nx/z0Fxy02OP7FsfBbERhl5NqZnxWboVoE9FcuU9G6PPR0WUpNja0ocYG5ZDlQU=
X-Received: by 2002:a05:622a:4e8a:b0:4da:ee50:d150 with SMTP id
 d75a77b69052e-4e6eacf47damr344636651cf.30.1760550577774; Wed, 15 Oct 2025
 10:49:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009225611.3744728-1-joannelkoong@gmail.com>
 <20251009225611.3744728-2-joannelkoong@gmail.com> <aOxrXWkq8iwU5ns_@infradead.org>
 <CAJnrk1YpsBjfkY0_Y+roc3LzPJw1mZKyH-=N6LO9T8qismVPyQ@mail.gmail.com> <a8c02942-69ca-45b1-ad51-ed3038f5d729@linux.alibaba.com>
In-Reply-To: <a8c02942-69ca-45b1-ad51-ed3038f5d729@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 15 Oct 2025 10:49:27 -0700
X-Gm-Features: AS18NWAZ_pRS6roEd3G92tWsE7Le_kL9VDzUvhRJUOq0X7FV95xYMqZUY9X3-1Y
Message-ID: <CAJnrk1aEy-HUJiDVC4juacBAhtL3RxriL2KFE+q=JirOyiDgRw@mail.gmail.com>
Subject: Re: [PATCH v1 1/9] iomap: account for unaligned end offsets when
 truncating read range
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christoph Hellwig <hch@infradead.org>, brauner@kernel.org, djwong@kernel.org, 
	bfoster@redhat.com, linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 10:40=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba=
.com> wrote:
>
> On 2025/10/16 01:34, Joanne Koong wrote:
> > On Sun, Oct 12, 2025 at 8:00=E2=80=AFPM Christoph Hellwig <hch@infradea=
d.org> wrote:
> >>
> >> On Thu, Oct 09, 2025 at 03:56:03PM -0700, Joanne Koong wrote:
> >>> The end position to start truncating from may be at an offset into a
> >>> block, which under the current logic would result in overtruncation.
> >>>
> >>> Adjust the calculation to account for unaligned end offsets.
> >>
> >> Should this get a fixes tag?
> >
> > I don't think this needs a fixes tag because when it was originally
> > written (in commit 9dc55f1389f9 ("iomap: add support for sub-pagesize
> > buffered I/O without buffer heads") in 2018), it was only used by xfs.
> > think it was when erofs started using iomap that iomap mappings could
> > represent non-block-aligned data.
>
> What non-block-aligned data exactly? erofs is a strictly block-aligned
> filesystem except for tail inline data.
>
> Is it inline data? gfs2 also uses the similar inline data logic.

This is where I encountered it in erofs: [1] for the "WARNING in
iomap_iter_advance" syz repro. (this syzbot report was generated in
response to this patchset version [2]).

When I ran that syz program locally, I remember seeing pos=3D116 and length=
=3D3980.

Thanks,
Joanne

[1] https://ci.syzbot.org/series/6845596a-1ec9-4396-b9c4-48bddc606bef
[2] https://lore.kernel.org/linux-fsdevel/68ca71bd.050a0220.2ff435.04fc.GAE=
@google.com/

>
> Thanks,
> Gao Xiang
>
> >
> >
> > Thanks,
> > Joanne
> >
> >>
> >> Otherwise looks good:
> >>
> >> Reviewed-by: Christoph Hellwig <hch@lst.de>
>

