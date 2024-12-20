Return-Path: <linux-fsdevel+bounces-37986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDDF9F9B4F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 22:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4B131896BE4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 21:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5305B21CA09;
	Fri, 20 Dec 2024 21:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCW2YaEQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A1E157A48
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 21:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734728519; cv=none; b=lTJHRWNjh98C7gPVsOoXkoYNhhrchGKk8f9Tck0w3FG4Jq8ElH88+8ddRH22X01hrdK0Arje/AOEzTf7xEpq+22SVSApPtu28VJM6xzChFTTx0IY27pNke0iu9hFwCacbPFCyXoOD3dzDE5FxkRyNBe23ePn/ASPx2M9YmqYOR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734728519; c=relaxed/simple;
	bh=Ytr1v1Bw7arE5zymE2nO4szf5NYsr7gMv345sU8XBbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YyNnNjq1I7Kqm0Uobc9XM1/9tutnkvhc7kH88YjvBwGRa0/QNvOWeK4Oolr1yGZluk2gWTt7GY0a8TbAdOxlAeXe2RtafUlIZHm1kTl+N0wANIhIpZRcegPwIVgxv7A9VroZMGrSfL5EmeEZYDF5b5ZHSFzfk7l1zGbpjXKUKbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCW2YaEQ; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-46785fbb949so23990491cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 13:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734728517; x=1735333317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ytr1v1Bw7arE5zymE2nO4szf5NYsr7gMv345sU8XBbM=;
        b=LCW2YaEQ+M213mD90jKRvC2rP4ZFdQBDV0ZJc0j5dbWd4itiqbNPxWHdr7k7y9HlNE
         xSd5Ed9tIrK5PrfQNqoPCAJbS8X2rwHyqfJZzXhNgWnP8wIFPcBGU4KNpm4vYjEajfTQ
         W9PRUNUbftzde1lhiCrXU1e66XawKrkNVX2ey/HnMAGaTEEs28K9J6BVGtmt+4Z4QsHu
         mnreZtPrYz+LR53DQc/uz54Hjy025EaO25EiIKLAHvSef1P68DrM+DYY9yxEOndvYhHI
         1fQZVN6UOntSsW7hGh9rZ1RcK1nZLi6nyo2UkIJxLjkiCVRU18CrlKlAnCVcLrpiz959
         lJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734728517; x=1735333317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ytr1v1Bw7arE5zymE2nO4szf5NYsr7gMv345sU8XBbM=;
        b=AC8wkRnyv2geUXaraEwFFVi2KGPvUdkAzdarVovv5GFZmoCk0EApIX+/XujxxASoB5
         /wDW4rZtEsRELWWTCsaMnTcrkmtHQosa/DdDXsrSShnq0OXBWDVAOAAjX6qsJA5M3Ez3
         3eqt6BImla9KTaOdJu0EMv462rC30DijGwz7BGMelLpFZXoRrfjJxtTFa2TQJUtUk4KF
         0iV8JbzEoqNpCXJre+pogAbniEWHwEzZ1vlgl4e6hbnDcq5mU39ukSb5W60rnQcyTHAB
         8+GHgcNbK01fE1XOTlr2hL7nBzc6Uzm5nLrqOr71jFDJJB2XtiAqK0o5Wcj4Do0hS8Jg
         aCAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcNH2kKDBXdejAQaDCipLjvN3Zr2Kpq27DkVyJbh8KMuX76YTx0VlPcZHGGlBXyeNKNSZl/BR4PUfuC4e0@vger.kernel.org
X-Gm-Message-State: AOJu0YxMNTy7Gx5lH5nZaPgDIYpgvLS0NjAd31QI6l5GeyyrxAzCd4S0
	zKma3Jyndy6g7OmaMio+dEWQ+VybUkXcUN1a80lIHEE0XCBTZsIjksDXARND9mtWbltVFLf4W0O
	r+jdgSdn63pMDpAXIdnJVYuHZAiM=
X-Gm-Gg: ASbGnctMIM/XfOyKc4SJBrmIM62j8JsLxXblUKiZfUPLQGGD6oNrnJGYtEK8eoISRHr
	ihcvWL2ungKXjLICuKOjw9fs3OZWP+5DFE1ep9ig=
X-Google-Smtp-Source: AGHT+IFTGFkhw3g3zTscn7M0FHo1K9ZsZAMHNzDMdz7Nd2l4rxPJQJcx5/GQ32u4yMAggjh+Sibjlwq8D5DzUNuzS6k=
X-Received: by 2002:a05:622a:1a07:b0:466:99a9:c354 with SMTP id
 d75a77b69052e-46a4a8cc49cmr77255841cf.22.1734728516983; Fri, 20 Dec 2024
 13:01:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <C34102A1-F571-4700-8D16-74642046376D@nvidia.com>
 <onnjsfrlgyv6blttpmfn5yhbv5q7niteiwbhoze3qnz2zuwldc@seooqlssrpvx>
 <43e13556-18a4-4250-b4fe-7ab736ceba7d@redhat.com> <ggm2n6wqpx4pnlrkvgzxclm7o7luqmzlv4655yf2huqaxrebkl@2qycr6dhcpcd>
 <968d3543-d8ac-4b5a-af8e-e6921311d5cf@redhat.com> <ssc3bperkpjyqdrlmdbh2woxlghua2t44tg4cywj5pkwwdcpdo@2jpzqfy5zyzf>
 <7b6b8143-d7a4-439f-ae35-a91055f9d62a@redhat.com> <2e13a67a-0bad-4795-9ac8-ee800b704cb6@fastmail.fm>
 <ukkygby3u7hjhk3cgrxkvs6qtmlrigdwmqb5k22ru3qqn242au@s4itdbnkmvli>
 <CAJnrk1bRk9xkVkMg8twaNi-gWBRps7A6HubMivKBHQiHzf+T8w@mail.gmail.com>
 <2bph7jx4hvhxpgp77shq2j7mo4xssobhqndw5v7hdvbn43jo2w@scqly5zby7bm>
 <71d7ac34-a5e5-4e59-802b-33d8a4256040@redhat.com> <b16bff80-758c-451b-a96c-b047f446f992@fastmail.fm>
 <9404aaa2-4fc2-4b8b-8f95-5604c54c162a@redhat.com>
In-Reply-To: <9404aaa2-4fc2-4b8b-8f95-5604c54c162a@redhat.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 20 Dec 2024 13:01:46 -0800
Message-ID: <CAJnrk1YWJKcMT41Boa_NcMEgx1rd5YN-Qau3VV6v3uiFcZoGgQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: David Hildenbrand <david@redhat.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Zi Yan <ziy@nvidia.com>, miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	jefflexu@linux.alibaba.com, josef@toxicpanda.com, linux-mm@kvack.org, 
	kernel-team@meta.com, Matthew Wilcox <willy@infradead.org>, 
	Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2024 at 6:49=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> >> I'm wondering if there would be a way to just "cancel" the writeback a=
nd
> >> mark the folio dirty again. That way it could be migrated, but not
> >> reclaimed. At least we could avoid the whole AS_WRITEBACK_INDETERMINAT=
E
> >> thing.
> >>
> >
> > That is what I basically meant with short timeouts. Obviously it is not
> > that simple to cancel the request and to retry - it would add in quite
> > some complexity, if all the issues that arise can be solved at all.
>
> At least it would keep that out of core-mm.
>
> AS_WRITEBACK_INDETERMINATE really has weird smell to it ... we should
> try to improve such scenarios, not acknowledge and integrate them, then
> work around using timeouts that must be manually configured, and ca
> likely no be default enabled because it could hurt reasonable use cases :=
(
>
> Right now we clear the writeback flag immediately, indicating that data
> was written back, when in fact it was not written back at all. I suspect
> fsync() currently handles that manually already, to wait for any of the
> allocated pages to actually get written back by user space, so we have
> control over when something was *actually* written back.
>
>
> Similar to your proposal, I wonder if there could be a way to request
> fuse to "abort" a writeback request (instead of using fixed timeouts per
> request). Meaning, when we stumble over a folio that is under writeback
> on some paths, we would tell fuse to "end writeback now", or "end
> writeback now if it takes longer than X". Essentially hidden inside
> folio_wait_writeback().
>
> When aborting a request, as I said, we would essentially "end writeback"
> and mark the folio as dirty again. The interesting thing is likely how
> to handle user space that wants to process this request right now (stuck
> in fuse_send_writepage() I assume?), correct?

This would be fine if the writeback request hasn't been sent yet to
userspace but if it has and the pages are spliced, then ending
writeback could lead to memory crashes if the pipebuf buf->page is
accessed as it's being migrated. When a page/folio is being migrated,
is there some state set on the page to indicate that it's currently
under migration? The only workaround I can see for the splice case
that doesn't resort to bringing back extra copies is to have splice
somehow ensure that the page isn't being migrated when it's accessing
it.


Thanks,
Joanne

>
> Just throwing it out there ... no expert at all on fuse ...
>
> --
> Cheers,
>
> David / dhildenb
>

