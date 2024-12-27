Return-Path: <linux-fsdevel+bounces-38167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 069669FD6EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2024 19:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73B1F18829EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2024 18:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917761F893C;
	Fri, 27 Dec 2024 18:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCX/cCOx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3B957C93
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Dec 2024 18:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735323970; cv=none; b=t1d3Vbh6Mo3Gcl3CeYGDFkVfuhRvwlLz/uhbXDq5EKtLfmN2QyeI/oKIlycL4SGR0LyCREk4fEo9y8RY7PKdgpqjHnT4IJatrpFUiTySr9/2tO5auM2rSvcVNtHqwZPm1waDZM9pRbFJdUc0hNNJNav3puVG04fFhlL94AzZUJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735323970; c=relaxed/simple;
	bh=Ig5gouwWaaMKJO51PA+kJMXTsFyIn9deY7Su+fNHxgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tNrXfAwf929Sebyy9GjIOOOY2Vh2Egtfy3dNq+yJUtwBN75jPj8Z3yXx+KTr8J4YR4577VWW0WGWPCU6P/w8vurAe8FsjtFtxw8t7PxnLHziAcZXDBiWt4pakSVekPavnc09KlDXmT3WBaCgm/QRpWlU/5JFsE0L1xcyq/pEcdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hCX/cCOx; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-467a17055e6so83179511cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Dec 2024 10:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735323967; x=1735928767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADXKvKpKDzwI9mOaMH3qaGZERZnHzlEkr8M4zdCnWUI=;
        b=hCX/cCOxmUwOEtBGNjs43MfSiPS3vCJVZ8FQYaUAd2ujJXqxxgD7cQf9BNWxMZ/l2L
         AuxmImaLc4P8aTFhm439QutjOs95JDX7hPja8Lxg1SuUeyRoDiCcv6jSD1qTA9xP3yiK
         woK47JUnkwICXg9wS/9PKjlBsS/ktexRbCZSC/20r3V8dSuxIqDDtRjRqOhgdP70jGuF
         sUS0kZrdlJOeqEvTFDIB5iHWDKDQKu5erxiCU16MncpLbXIwhesvyja6ljW4/+9F9jZ1
         UuIWdgetkJJKvCCnIHQYdBVL+xJWqGNW2sxOm0DngLqkBHyIkVZMlCjDRo3NzOEYOYDX
         lGbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735323967; x=1735928767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADXKvKpKDzwI9mOaMH3qaGZERZnHzlEkr8M4zdCnWUI=;
        b=VL/BT1q6HkE2VZO/JuPEbdmxcZAzjhuFJ+UOc0DRK59vZAvdpVx0vaLmDr1P8GaOFi
         2z5A0ckNO7NLsJRmR0kcXUVI7+DlT+M5g19atp+CIYdy13t85xUbldvnG3psdwUzGHrB
         97nHQ+y7yqtFXOOWuMaWPZZblUbvwcklbiN2sm3XioimWt9CBXLdAP0uWPdQY+rJGb1c
         QT7xP6DeB48G+QULpzQTIzPlng/YwQfH2ABy5pC5j7Zd6GX/6wFlQ8gtQl2Jt9MgYnzO
         F4d3I+FEwzZoFOEWSSWtNKKOz7wX7NY9wwZe830nuY+1jMKaF4sgf4K0ZIFFv8SkEJD9
         1PVg==
X-Forwarded-Encrypted: i=1; AJvYcCVg+pRVKPOcEW5Jj+Vk0bPZzOakOFHWmlCCI/bPkp8tEs0Y3Fw/HekFeOFCIbM6fenlU9mQDNG17DS7jR+V@vger.kernel.org
X-Gm-Message-State: AOJu0YzDlTBPKPgEQHY1TEPEFCjd1SoTT4Ap3PPNaJqQcD131dTTmbVk
	WGHX5OC5dWb32e+XqszBjl1id+0Ecll2EKhDXCZM+xBHMKxcSDRt1fThCBPMoa6H1OVhanBKeX1
	qD6EAp3Z2dTmpywePsDS+u7kbz3A=
X-Gm-Gg: ASbGncuWPygqJm9KOx3/V88/PlK7OM/Xz0K12izXejJgbk199e0XHC/aX/zl+vnpA+c
	Ur632MtKc0cW0dkvWoiV7e+sfjEoFXQKLcPFX5S0=
X-Google-Smtp-Source: AGHT+IGEqqOYVw4AgSs8GoKDFZuk4x/RBCaVRAJzuDPEBGIbx5+tcT1S0gfjuu6kVnYWSokD9rMmmaSTG+Qkl8z9KGs=
X-Received: by 2002:a05:622a:d2:b0:467:6e45:2177 with SMTP id
 d75a77b69052e-46a4a8cddbdmr433357311cf.12.1735323967252; Fri, 27 Dec 2024
 10:26:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <C34102A1-F571-4700-8D16-74642046376D@nvidia.com>
 <43e13556-18a4-4250-b4fe-7ab736ceba7d@redhat.com> <ggm2n6wqpx4pnlrkvgzxclm7o7luqmzlv4655yf2huqaxrebkl@2qycr6dhcpcd>
 <968d3543-d8ac-4b5a-af8e-e6921311d5cf@redhat.com> <ssc3bperkpjyqdrlmdbh2woxlghua2t44tg4cywj5pkwwdcpdo@2jpzqfy5zyzf>
 <7b6b8143-d7a4-439f-ae35-a91055f9d62a@redhat.com> <2e13a67a-0bad-4795-9ac8-ee800b704cb6@fastmail.fm>
 <ukkygby3u7hjhk3cgrxkvs6qtmlrigdwmqb5k22ru3qqn242au@s4itdbnkmvli>
 <CAJnrk1bRk9xkVkMg8twaNi-gWBRps7A6HubMivKBHQiHzf+T8w@mail.gmail.com>
 <2bph7jx4hvhxpgp77shq2j7mo4xssobhqndw5v7hdvbn43jo2w@scqly5zby7bm>
 <71d7ac34-a5e5-4e59-802b-33d8a4256040@redhat.com> <b16bff80-758c-451b-a96c-b047f446f992@fastmail.fm>
 <9404aaa2-4fc2-4b8b-8f95-5604c54c162a@redhat.com> <CAJnrk1YWJKcMT41Boa_NcMEgx1rd5YN-Qau3VV6v3uiFcZoGgQ@mail.gmail.com>
 <61a4bcb1-8043-42b1-bf68-1792ee854f33@redhat.com> <166a147e-fdd7-4ea6-b545-dd8fb7ef7c2f@fastmail.fm>
 <CAJnrk1ZzOnBwj8HoABWuUZvigMzFaha+YeC117DR1aDJDuOQRg@mail.gmail.com> <b3466cec-7689-485a-8ffb-206c9b50ccc2@fastmail.fm>
In-Reply-To: <b3466cec-7689-485a-8ffb-206c9b50ccc2@fastmail.fm>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 27 Dec 2024 10:25:56 -0800
Message-ID: <CAJnrk1Y8wdk4oCOyj0xvSqsqerxMSJLCcrHbX+RJhQa6bFucOg@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: David Hildenbrand <david@redhat.com>, Shakeel Butt <shakeel.butt@linux.dev>, Zi Yan <ziy@nvidia.com>, 
	miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com, 
	josef@toxicpanda.com, linux-mm@kvack.org, kernel-team@meta.com, 
	Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>, 
	Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 26, 2024 at 2:44=E2=80=AFPM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
> On 12/23/24 20:00, Joanne Koong wrote:
> > On Sat, Dec 21, 2024 at 1:59=E2=80=AFPM Bernd Schubert
> > <bernd.schubert@fastmail.fm> wrote:
> >>
> >>
> >>
> >> On 12/21/24 17:25, David Hildenbrand wrote:
> >>> On 20.12.24 22:01, Joanne Koong wrote:
> >>>> On Fri, Dec 20, 2024 at 6:49=E2=80=AFAM David Hildenbrand <david@red=
hat.com>
> >>>> wrote:
> >>>>>
> >>>>>>> I'm wondering if there would be a way to just "cancel" the
> >>>>>>> writeback and
> >>>>>>> mark the folio dirty again. That way it could be migrated, but no=
t
> >>>>>>> reclaimed. At least we could avoid the whole
> >>>>>>> AS_WRITEBACK_INDETERMINATE
> >>>>>>> thing.
> >>>>>>>
> >>>>>>
> >>>>>> That is what I basically meant with short timeouts. Obviously it i=
s not
> >>>>>> that simple to cancel the request and to retry - it would add in q=
uite
> >>>>>> some complexity, if all the issues that arise can be solved at all=
.
> >>>>>
> >>>>> At least it would keep that out of core-mm.
> >>>>>
> >>>>> AS_WRITEBACK_INDETERMINATE really has weird smell to it ... we shou=
ld
> >>>>> try to improve such scenarios, not acknowledge and integrate them, =
then
> >>>>> work around using timeouts that must be manually configured, and ca
> >>>>> likely no be default enabled because it could hurt reasonable use
> >>>>> cases :(
> >>>>>
> >>>>> Right now we clear the writeback flag immediately, indicating that =
data
> >>>>> was written back, when in fact it was not written back at all. I su=
spect
> >>>>> fsync() currently handles that manually already, to wait for any of=
 the
> >>>>> allocated pages to actually get written back by user space, so we h=
ave
> >>>>> control over when something was *actually* written back.
> >>>>>
> >>>>>
> >>>>> Similar to your proposal, I wonder if there could be a way to reque=
st
> >>>>> fuse to "abort" a writeback request (instead of using fixed timeout=
s per
> >>>>> request). Meaning, when we stumble over a folio that is under write=
back
> >>>>> on some paths, we would tell fuse to "end writeback now", or "end
> >>>>> writeback now if it takes longer than X". Essentially hidden inside
> >>>>> folio_wait_writeback().
> >>>>>
> >>>>> When aborting a request, as I said, we would essentially "end write=
back"
> >>>>> and mark the folio as dirty again. The interesting thing is likely =
how
> >>>>> to handle user space that wants to process this request right now (=
stuck
> >>>>> in fuse_send_writepage() I assume?), correct?
> >>>>
> >>>> This would be fine if the writeback request hasn't been sent yet to
> >>>> userspace but if it has and the pages are spliced
> >>>
> >>> Can you point me at the code where that splicing happens?
> >>
> >> fuse_dev_splice_read()
> >>   fuse_dev_do_read()
> >>     fuse_copy_args()
> >>       fuse_copy_page
> >>
> >>
> >> Btw, for the non splice case, disabling migration should be
> >> only needed while it is copying to the userspace buffer?
> >
> > I don't think so. We don't currently disable migration when copying
> > to/from the userspace buffer for reads.
>
>
> Sorry for my late reply. I'm confused about "reads". This discussions
> is about writeback?

Whether we need to disable migration for copying to/from the userspace
buffers for non-tmp pages should be the same between handling reads or
writes, no? That's why I brought up reads, but looking more at how
fuse handles readahead and read_folio(), it looks like the folio's
lock is held while it's being copied out, and IIUC that's enough to
disable migration since migration will wait on the lock. So if we end
writeback on the non-tmp, it seems like we'd probably need to do
something similar first.

> Without your patches we have tmp-pages - migration disabled on these.
> With your patches we have AS_WRITEBACK_INDETERMINATE - migration
> also disabled?
>
> I think we have two code paths
>
> a) fuse_dev_read - does a full buffer copy. Why do we need tmp-pages
> for these at all? The only time migration must not run on these pages
> while it is copying to the userspace buffer?

The tmp pages were originally introduced for avoiding deadlock on
reclaim and avoiding hanging sync()s as well.

[1] https://lore.kernel.org/linux-kernel/bd49fcba-3eb6-4e84-a0f0-e73bce31dd=
b2@linux.alibaba.com/

>
> b) fuse_dev_splice_read - isn't this our real problem, as we don't
> know when pages in the pipe are getting consumed?

Yes, the splice case nixes the idea unfortunately. Everything else we
could find a workaround for, but there's no way I can see to avoid
this for splice


Thanks,
Joanne
>
>
> Thanks,
> Bernd
>

