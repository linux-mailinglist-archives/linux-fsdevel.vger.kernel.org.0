Return-Path: <linux-fsdevel+bounces-37862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3969F82B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 18:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E578A169860
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 17:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F801A23AF;
	Thu, 19 Dec 2024 17:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hznh+VFk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC28C197A8F
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 17:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734630933; cv=none; b=PjB5Z4R3YCBUymE4w6dIcx7iOJeWENSI2HgOuUm/qDIrePtT+7+cvj/9jlFOmRFhRMMvRwpbOu4ZU+XjPu3WkfivDeDeQ1epg3Y1Gz/5rBB1WtoqhgLJbck9jeYUYOiwRubqHAX8sNCIpLg7EHVNknEaZCNtKPycghbOJb+GFNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734630933; c=relaxed/simple;
	bh=9+LM90YdlzJcr2NeGBRC/8Jsq9SUU5IQcPPHlZf420U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YTHsNxEgpIYlmX171TjJXYUTE6z8PUsH33doS3FunV/AIZLMY50g2/uUrymbWvPRINGKunXtIo8slzenPHtbkeBFgfUsDLxV5i/SlEKUSIgalussFt9J1IdKykdK+g7mxBynsiooa5B7yGnhZ1AP6EVhSa3/WxqA1ruoacwM+hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hznh+VFk; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-467725245a2so7250411cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 09:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734630930; x=1735235730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0juxr8sPMj3buGysieiWx/mGUENjVf1ZhZQjwxnLKQI=;
        b=Hznh+VFksth5uW+W2jL4mh8OO82hsW0Bhp8sWZynIeoGuglwSOH654xGieE+h3r4/J
         ju0/Q2cMBIGpVXz9sO6SeHPOL66KZleGyduTVd9JUpHkOTn3lGzv5u/nfrMhyCsMb1ao
         09fspoLtbmwPzdzKJRxar7PNXupaJA+buJY4KmAcQushb0KCN1TAIH4upZgNwUq/kvQG
         cEAoy7fNogExLkMp2IPVoeUerPnlv5t2pTMAwNn+x6C2O18gjJH3b/36PI4hSUnKhKDp
         bGBe1c0K4/qjEAsYMgCf+KXGPFoj7p2xOyBz7vfYtRCNf0p3b/u1X9d8PyfGz17YNxco
         1ggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734630930; x=1735235730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0juxr8sPMj3buGysieiWx/mGUENjVf1ZhZQjwxnLKQI=;
        b=VIDpwlk/uqolqa6TLhd+0E7adMx3y2Oa/9WNCPFVhkKYyzyHmn3qjRTZzOS0YpfFXu
         IrDpHoEezoJAzG36KIth7QupuUAilPV8FR3PhpZdaob64axFoDv4dyEeyNW9jnrGJXQd
         3OGXODLveIF76lP1EliSXwY0fIfNHPfeoOre/mW7l9Xhrip9UXFh1rZJRUClpdaUKmgH
         48T+J1kHfN2GFwE4aVdNhP43tQpRPPYr433BbieWgW+cWulg+vq2YddXIEkDZ1wqxpQi
         3Cc+uO3lFt0J+8sXbu+z2CGEDUmpQ810LDRiQAwB/PRGnG/E3ikHE/ipxTWR4HAGmSUg
         i81w==
X-Forwarded-Encrypted: i=1; AJvYcCWVB4322oStiXlEA/ErhPo16NUAIFl0UMfGSUflCNj8Rt3KZyHTE6R3eHvu8NSiO92DWJWus2rAF9YTTYhp@vger.kernel.org
X-Gm-Message-State: AOJu0YyJYLmIkErACAKx9zKIqCWc8Yu3s64fSRonsp1SdLGEnm+oSDDD
	ZqXB8TCbrFsph+vo+jln5e35nbzF/nSGXzvcoNjEoLzF8pFhIkf0g5G7K9ZXwAMVr77X/1u4QZz
	d+FCsxqAh4+FHtp4TIy/YqEqVYHY=
X-Gm-Gg: ASbGncu3cgZyLrZYebCg0iQkNa1ScUl2G0DmQgPmaeiUETexvalYP3LXd5C1Tpdr27V
	5g8Fca1YQsaDQptuTDn0Zgq7kzn9gtpsVAQiybww=
X-Google-Smtp-Source: AGHT+IGMJ2+v5ppenam+58Ugzq77XfY8FxUHxRt3N+1ClJ4itcPxzdr15LkdpBA++m3fEQCmHiTIrC1UIqJILT5ING4=
X-Received: by 2002:a05:622a:2291:b0:46a:3579:d137 with SMTP id
 d75a77b69052e-46a3579d38bmr91618781cf.43.1734630930608; Thu, 19 Dec 2024
 09:55:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122232359.429647-5-joannelkoong@gmail.com>
 <c9a76cb3-5827-4b2c-850f-8c830a090196@redhat.com> <hltxbiupl245ea7b4rzpcyz3d62mzs6igcx42g7zsksanbxqb3@sho3dzzht3rx>
 <f30fba5f-b2ca-4351-8c8f-3ac120b2d227@redhat.com> <gdu7kmz4nbnjqenj5vea4rjwj7v67kjw6ggoyq7ok4la2uosqa@i5gxpmoopuii>
 <C34102A1-F571-4700-8D16-74642046376D@nvidia.com> <onnjsfrlgyv6blttpmfn5yhbv5q7niteiwbhoze3qnz2zuwldc@seooqlssrpvx>
 <43e13556-18a4-4250-b4fe-7ab736ceba7d@redhat.com> <ggm2n6wqpx4pnlrkvgzxclm7o7luqmzlv4655yf2huqaxrebkl@2qycr6dhcpcd>
 <968d3543-d8ac-4b5a-af8e-e6921311d5cf@redhat.com> <ssc3bperkpjyqdrlmdbh2woxlghua2t44tg4cywj5pkwwdcpdo@2jpzqfy5zyzf>
 <7b6b8143-d7a4-439f-ae35-a91055f9d62a@redhat.com>
In-Reply-To: <7b6b8143-d7a4-439f-ae35-a91055f9d62a@redhat.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 19 Dec 2024 09:55:19 -0800
Message-ID: <CAJnrk1YFix0W5OW6351UsKujFYLcXnwZJaWYSJTYZMpQWwk5kA@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: David Hildenbrand <david@redhat.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Zi Yan <ziy@nvidia.com>, miklos@szeredi.hu, 
	linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com, 
	josef@toxicpanda.com, bernd.schubert@fastmail.fm, linux-mm@kvack.org, 
	kernel-team@meta.com, Matthew Wilcox <willy@infradead.org>, 
	Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 9:26=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 19.12.24 18:14, Shakeel Butt wrote:
> > On Thu, Dec 19, 2024 at 05:41:36PM +0100, David Hildenbrand wrote:
> >> On 19.12.24 17:40, Shakeel Butt wrote:
> >>> On Thu, Dec 19, 2024 at 05:29:08PM +0100, David Hildenbrand wrote:
> >>> [...]
> >>>>>
> >>>>> If you check the code just above this patch, this
> >>>>> mapping_writeback_indeterminate() check only happen for pages under
> >>>>> writeback which is a temp state. Anyways, fuse folios should not be
> >>>>> unmovable for their lifetime but only while under writeback which i=
s
> >>>>> same for all fs.
> >>>>
> >>>> But there, writeback is expected to be a temporary thing, not possib=
ly:
> >>>> "AS_WRITEBACK_INDETERMINATE", that is a BIG difference.
> >>>>
> >>>> I'll have to NACK anything that violates ZONE_MOVABLE / ALLOC_CMA
> >>>> guarantees, and unfortunately, it sounds like this is the case here,=
 unless
> >>>> I am missing something important.
> >>>>
> >>>
> >>> It might just be the name "AS_WRITEBACK_INDETERMINATE" is causing
> >>> the confusion. The writeback state is not indefinite. A proper fuse f=
s,
> >>> like anyother fs, should handle writeback pages appropriately. These
> >>> additional checks and skips are for (I think) untrusted fuse servers.
> >>
> >> Can unprivileged user space provoke this case?
> >
> > Let's ask Joanne and other fuse folks about the above question.
> >
> > Let's say unprivileged user space can start a untrusted fuse server,
> > mount fuse, allocate and dirty a lot of fuse folios (within its dirty
> > and memcg limits) and trigger the writeback. To cause pain (through
> > fragmentation), it is not clearing the writeback state. Is this the
> > scenario you are envisioning?
>

This scenario can already happen with temp pages. An untrusted
malicious fuse server may allocate and dirty a lot of fuse folios
within its dirty/memcg limits and never clear writeback on any of them
and tie up system resources. This certainly isn't the common case, but
it is a possibility. However, request timeouts can be set by the
system admin [1] to protect against malicious/buggy fuse servers that
try to do this. If the request isn't replied to by a certain amount of
time, then the connection will be aborted and writeback state and
other resources will be cleared/freed.


Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/20241218222630.99920-1-joannelkoo=
ng@gmail.com/T/#t

> Yes, for example causing harm on a shared host (containers, ...).
>
> If it cannot happen, we should make it very clear in documentation and
> patch descriptions that it can only cause harm with privileged user
> space, and that this harm can make things like CMA allocations, memory
> onplug, ... fail, which is rather bad and against concepts like
> ZONE_MOVABLE/MIGRATE_CMA.
>
> Although I wonder what would happen if the privileged user space daemon
> crashes  (e.g., OOM killer?) and simply no longer replies to any messages=
.
>
> --
> Cheers,
>
> David / dhildenb
>

