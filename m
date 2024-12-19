Return-Path: <linux-fsdevel+bounces-37855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 551ED9F8265
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 18:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E51DF164F9A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 17:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCC91A38F9;
	Thu, 19 Dec 2024 17:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RD3Bn1CL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3199B1A0B12
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 17:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734630295; cv=none; b=DH5JZRvcWjE9miK9FOe4MOVG2o3hqEwU4oZyKNlZlGReVMssccScY++MRK4o5GOishL+oZ24mqKDbc0nev7hz4m5offJTOhSq50QavcaZes3n6N0PekDZ1U3Gb9OKpLzopLEXb/hmvyg53Qwbe4DgJ7cVpWR9wzEUnUWPDNzeLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734630295; c=relaxed/simple;
	bh=YZ6YVDNR/T4WABBd7vK7BEbKlFIlOz+OQifG0ZsCits=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oG4HUtiYh5044tpE5D++1nEz6rlUnsYiLkAJ208gkrgyZrb/c3Z9VDUPyl/EV5VFwGXTsmrIztUs8rfiIc1LB5kW4+UcyMeywU+rZs+II1j41FaD/IJ41Bt3IB4yIpUd0mk8dnMqnebQ+AgS30DTZQAFKylTBilzukgZLMhg+8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RD3Bn1CL; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4678664e22fso8407591cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 09:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734630293; x=1735235093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOWnHsk58LEisFTupGhSlXEEpiCe7RKkGgtg+2S7HhQ=;
        b=RD3Bn1CLJfAQy4E7cEX/m1YHk6Cuj6HnRECdwXII5j8lTh35eO+7jCD9S/YjUrzB0F
         gipPurLF7nseQcGtynKYJJDB44rMjQEYgh49vebRaap2tKABguCM7lHpDfNIBbIL4bkN
         czIhrJELbNQKnENoQyKgU2e4EEEkua4oWI2vFs9ylCV7FMBw6EPqwEYqqwQNhTh4ns2g
         BRH2tY3jGxwmNjYpL821gYwZQUydk2TOkmHlurf8FKJmzIFNEMyMke2Y4mVLklnpd5IU
         fCjyPI80uuPkGyeETi3wNFBK9cDWaXayygETQsnP4q0irWGjjv3jzmCEk8MUjFvTEmjB
         thQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734630293; x=1735235093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jOWnHsk58LEisFTupGhSlXEEpiCe7RKkGgtg+2S7HhQ=;
        b=TG92TRoQS050dkJs79qdihzsWk1o24UMel+JCZ/SLCS99zPlSiIrSz5WxOAlTsSade
         +/KNHz3u0ZGqjX10Vm7cHSm2jdO/vaIk0i7K5PoQzXbCCrqIcoADu28e5iz06h5WaO5G
         iqz5ZtmbS28xdWEq9vkcLYVUbPWFlhpV+r4X+WqottcaRuxGTh1qy3HoFEo/f78ONKAj
         4R9UJwqqYzrs2UwQ2RKJE01GzJ80F/uwMr1DTCrJr+1PVqD3kdD1xZC2nH6JRkRlVAw6
         y+5szkHAK6uvtVeTQi5GoizItiAgoDn4wgioBdUt2y1oiluLJFpRqvfHsPLtowSa88nX
         HapA==
X-Forwarded-Encrypted: i=1; AJvYcCUdgRzRPZKuXQb4P1h51v0DDgKoe4wqgkS3Yy4MDl8OxW42vhHY5ytx1qENIHiudET89vsS0C16obWLE0oA@vger.kernel.org
X-Gm-Message-State: AOJu0Yziu1w+3rRF0sBLSnevdjTjcHRFgOCn7ZrQadS0fsB8yFkFXKHr
	Q19XSaqa7gWu1Kodz6G8gNd6zQG/ZgEb8EXLdWw+DSlNuW9e5JBJGmF98ZUbKlr4sB8N5skRZQ3
	iuCYKwCUbKxU+DSVo/Cb2Q0A1hEY=
X-Gm-Gg: ASbGncvgw0bmObzH4UxQ2V2PZO1by3+PgTJqwByPg5SDaaUTsAOULaRUx3/1BOQ8KcK
	OH6Z/QPPN+KyL+rSa4oJ2jOEJx1uNxKVs2ZhqJeE=
X-Google-Smtp-Source: AGHT+IFfm1c5TKG3NbPLfRn7IXWp7kmYfdPLU69mqMPaE4XrXA6Bdido8NZHSAjhLpcJfKHLr+M3idkr0ijn7Nrh61I=
X-Received: by 2002:a05:622a:13d4:b0:466:948e:bef6 with SMTP id
 d75a77b69052e-46908e6f405mr130775701cf.43.1734630292992; Thu, 19 Dec 2024
 09:44:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f30fba5f-b2ca-4351-8c8f-3ac120b2d227@redhat.com>
 <gdu7kmz4nbnjqenj5vea4rjwj7v67kjw6ggoyq7ok4la2uosqa@i5gxpmoopuii>
 <C34102A1-F571-4700-8D16-74642046376D@nvidia.com> <onnjsfrlgyv6blttpmfn5yhbv5q7niteiwbhoze3qnz2zuwldc@seooqlssrpvx>
 <43e13556-18a4-4250-b4fe-7ab736ceba7d@redhat.com> <ggm2n6wqpx4pnlrkvgzxclm7o7luqmzlv4655yf2huqaxrebkl@2qycr6dhcpcd>
 <968d3543-d8ac-4b5a-af8e-e6921311d5cf@redhat.com> <ssc3bperkpjyqdrlmdbh2woxlghua2t44tg4cywj5pkwwdcpdo@2jpzqfy5zyzf>
 <7b6b8143-d7a4-439f-ae35-a91055f9d62a@redhat.com> <2e13a67a-0bad-4795-9ac8-ee800b704cb6@fastmail.fm>
 <ukkygby3u7hjhk3cgrxkvs6qtmlrigdwmqb5k22ru3qqn242au@s4itdbnkmvli>
In-Reply-To: <ukkygby3u7hjhk3cgrxkvs6qtmlrigdwmqb5k22ru3qqn242au@s4itdbnkmvli>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 19 Dec 2024 09:44:42 -0800
Message-ID: <CAJnrk1bRk9xkVkMg8twaNi-gWBRps7A6HubMivKBHQiHzf+T8w@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, David Hildenbrand <david@redhat.com>, 
	Zi Yan <ziy@nvidia.com>, miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	jefflexu@linux.alibaba.com, josef@toxicpanda.com, linux-mm@kvack.org, 
	kernel-team@meta.com, Matthew Wilcox <willy@infradead.org>, 
	Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 9:37=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Thu, Dec 19, 2024 at 06:30:34PM +0100, Bernd Schubert wrote:
> >
> >
> > On 12/19/24 18:26, David Hildenbrand wrote:
> > > On 19.12.24 18:14, Shakeel Butt wrote:
> > >> On Thu, Dec 19, 2024 at 05:41:36PM +0100, David Hildenbrand wrote:
> > >>> On 19.12.24 17:40, Shakeel Butt wrote:
> > >>>> On Thu, Dec 19, 2024 at 05:29:08PM +0100, David Hildenbrand wrote:
> > >>>> [...]
> > >>>>>>
> > >>>>>> If you check the code just above this patch, this
> > >>>>>> mapping_writeback_indeterminate() check only happen for pages un=
der
> > >>>>>> writeback which is a temp state. Anyways, fuse folios should not=
 be
> > >>>>>> unmovable for their lifetime but only while under writeback whic=
h is
> > >>>>>> same for all fs.
> > >>>>>
> > >>>>> But there, writeback is expected to be a temporary thing, not
> > >>>>> possibly:
> > >>>>> "AS_WRITEBACK_INDETERMINATE", that is a BIG difference.
> > >>>>>
> > >>>>> I'll have to NACK anything that violates ZONE_MOVABLE / ALLOC_CMA
> > >>>>> guarantees, and unfortunately, it sounds like this is the case
> > >>>>> here, unless
> > >>>>> I am missing something important.
> > >>>>>
> > >>>>
> > >>>> It might just be the name "AS_WRITEBACK_INDETERMINATE" is causing
> > >>>> the confusion. The writeback state is not indefinite. A proper fus=
e fs,
> > >>>> like anyother fs, should handle writeback pages appropriately. The=
se
> > >>>> additional checks and skips are for (I think) untrusted fuse serve=
rs.
> > >>>
> > >>> Can unprivileged user space provoke this case?
> > >>
> > >> Let's ask Joanne and other fuse folks about the above question.
> > >>
> > >> Let's say unprivileged user space can start a untrusted fuse server,
> > >> mount fuse, allocate and dirty a lot of fuse folios (within its dirt=
y
> > >> and memcg limits) and trigger the writeback. To cause pain (through
> > >> fragmentation), it is not clearing the writeback state. Is this the
> > >> scenario you are envisioning?
> > >
> > > Yes, for example causing harm on a shared host (containers, ...).
> > >
> > > If it cannot happen, we should make it very clear in documentation an=
d
> > > patch descriptions that it can only cause harm with privileged user
> > > space, and that this harm can make things like CMA allocations, memor=
y
> > > onplug, ... fail, which is rather bad and against concepts like
> > > ZONE_MOVABLE/MIGRATE_CMA.
> > >
> > > Although I wonder what would happen if the privileged user space daem=
on
> > > crashes  (e.g., OOM killer?) and simply no longer replies to any mess=
ages.
> > >
> >
> > The request is canceled then - that should clear the page/folio state
> >
> >
> > I start to wonder if we should introduce really short fuse request
> > timeouts and just repeat requests when things have cleared up. At least
> > for write-back requests (in the sense that fuse-over-network might
> > be slow or interrupted for some time).
> >
> >
>
> Thanks Bernd for the response. Can you tell a bit more about the request
> timeouts? Basically does it impact/clear the page/folio state as well?

Request timeouts can be set by admins system-wide to protect against
malicious/buggy fuse servers that do not reply to requests by a
certain amount of time. If the request times out, then the whole
connection will be aborted, and pages/folios will be cleaned up
accordingly. The corresponding patchset is here [1]. This helps
mitigate the possibility of unprivileged buggy servers tieing up
writeback state by not replying.


Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/20241218222630.99920-1-joannelkoo=
ng@gmail.com/T/#t

