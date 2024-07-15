Return-Path: <linux-fsdevel+bounces-23680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0A993124C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 12:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDE251C21A92
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 10:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7170188CA4;
	Mon, 15 Jul 2024 10:32:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1E613B5BD;
	Mon, 15 Jul 2024 10:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721039545; cv=none; b=MKQs5wmcmzUwjyMSR6a2Rfq1AIgDDOzHGef7PnWBBrizDnGWX/KXaDiGKPuRUm+oJcCP7EAVCdqxaaDtoOAEJ4KwNj6rHlDEpSQ1II1wPtlK7C3KdlaskB+ZKvjtHT5OTwkraVts56EyWXLPUFxc0CMjG3FX5vkLzHHlZkoFUhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721039545; c=relaxed/simple;
	bh=1vvbywj5eeKaY/5Q3zxYZaJ25/BZeER05pTRkQz95R4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwyMaee5bpXO7t+45o/SqQb1k0/EWZR7FCLviken/mBjMXitsZrUnv2prfaPSpwv5DiSgQW6FET5DvU5E1H5DSyNLljRThIbausMN0Fm4c+RxKWZbkcfF0YkVWAz90X+6VeiuuUpofy0gj9zfVv9UKa/ZKlpSZGKGuofTTd8em0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-27-6694faaa4f59
Date: Mon, 15 Jul 2024 19:32:05 +0900
From: Byungchul Park <byungchul@sk.com>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	max.byungchul.park@sk.com,
	Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
	kernel_team@skhynix.com
Subject: Re: Possible circular dependency between i_data_sem and folio lock
 in ext4 filesystem
Message-ID: <20240715103205.GA38263@system.software.com>
References: <CAB=+i9SmrqEEqQp+AQvv+O=toO9x0mPam+b1KuNT+CgK0J1JDQ@mail.gmail.com>
 <20240711153846.GG10452@mit.edu>
 <20240712044420.GA62198@system.software.com>
 <20240712053150.GA68384@system.software.com>
 <e71f73d5-4dbc-4194-9409-6daf807cb27e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e71f73d5-4dbc-4194-9409-6daf807cb27e@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJLMWRmVeSWpSXmKPExsXC9ZZnoe6qX1PSDH6fUbeY2GNgcfH1HyaL
	mfPusFns2XuSxeLemv+sFq09P9ktOl7eZ3Fg99g56y67x+I9L5k8Nq3qZPPY9GkSu0fTmaPM
	Hp83yQWwRXHZpKTmZJalFunbJXBlfPlwjq1ghkjFpvZtbA2MJ/m7GDk5JARMJH5NfcrWxcgB
	Zp9ZUAwSZhFQlbi6YCcjiM0moC5x48ZPZhBbRMBAYvfm86xdjFwczALzmST6jy1iAUkICyRI
	vJh5GqyBV8BC4uKzOywgRUICrUwSzS0XmCASghInZz4Ba2AW0JK48e8lE8hiZgFpieX/OEBM
	TgE7id8TpUAqRAWUJQ5sO84EceYRNokLCwQhbEmJgytusExgFJiFZOgsJENnIQxdwMi8ilEo
	M68sNzEzx0QvozIvs0IvOT93EyMwwJfV/onewfjpQvAhRgEORiUe3gN7J6cJsSaWFVfmHmKU
	4GBWEuH1/jklTYg3JbGyKrUoP76oNCe1+BCjNAeLkjiv0bfyFCGB9MSS1OzU1ILUIpgsEwen
	VANjqZbJl0f6/RfsL/yR7c7RYzicxnRIMHpO8u3yFG6u2FqtlnLDn58/By9NNT9kuK7T/mzd
	gyIpmZ1R0n90z3K2SccV36la1ZqetP2Ky0zxV/WTZj5x0I//avPwkOCbXbGz87bOkjE75KK/
	v/lwbvfJBDdp3ufah951nhAxXmTUPX2NTHfz74lKLMUZiYZazEXFiQDIhurvbAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsXC5WfdrLvq15Q0g+nrZS0m9hhYXHz9h8ni
	8NyTrBYz591hs9iz9ySLxb01/1ktZrTlWbT2/GS36Hh5n8WB02PnrLvsHov3vGTy2LSqk81j
	06dJ7B5NZ44ye3y77eGx+MUHJo/Pm+QCOKK4bFJSczLLUov07RK4Mr58OMdWMEOkYlP7NrYG
	xpP8XYwcHBICJhJnFhR3MXJysAioSlxdsJMRxGYTUJe4ceMnM4gtImAgsXvzedYuRi4OZoH5
	TBL9xxaxgCSEBRIkXsw8DdbAK2AhcfHZHRaQIiGBViaJ5pYLTBAJQYmTM5+ANTALaEnc+PeS
	CWQxs4C0xPJ/HCAmp4CdxO+JUiAVogLKEge2HWeawMg7C0nzLCTNsxCaFzAyr2IUycwry03M
	zDHVK87OqMzLrNBLzs/dxAgM4GW1fybuYPxy2f0QowAHoxIP74G9k9OEWBPLiitzDzFKcDAr
	ifB6/5ySJsSbklhZlVqUH19UmpNafIhRmoNFSZzXKzw1QUggPbEkNTs1tSC1CCbLxMEp1cC4
	JJmjhmvCh9feVo+3lMR39+Tv8lJTKt//Ro1D8PDcRa+WL/R2mlX/u3zn6+2P0t5Yqnx7y93m
	8PrVq9nFWQu53uilHvQzSMowdf27lYVJU6vzq8c1I4tE5je22wqbxE99c37/aKHFrHfL6u9n
	Gfv6ctUx/W3T+CBfdkSIL3Hh+nm/buixLZJXYinOSDTUYi4qTgQAKIayOlwCAAA=
X-CFilter-Loop: Reflected

On Fri, Jul 12, 2024 at 11:23:36PM +0200, Vlastimil Babka (SUSE) wrote:
> On 7/12/24 7:31 AM, Byungchul Park wrote:
> > On Fri, Jul 12, 2024 at 01:44:20PM +0900, Byungchul Park wrote:
> >> 
> >> What a funny guy...  He did neither 1) insisting it's a bug in your code
> >> nor 3) insisting DEPT is a great tool, but just asking if there's any
> >> locking rules based on the *different acqusition order* between folio
> >> lock and i_data_sem that he observed anyway.
> >> 
> >> I don't think you are a guy who introduces bugs, but the thing is it's
> >> hard to find a *document* describing locking rules.  Anyone could get
> >> fairly curious about the different acquisition order.  It's an open
> >> source project.  You are responsible for appropriate document as well.
> >> 
> >> I don't understand why you act to DEPT like that by the way.  You don't
> >> have to becasue:
> >> 
> >>    1. I added the *EXPERIMENTAL* tag in Kconfig as you suggested, which
> >>       will prevent autotesting until it's considered stable.  However,
> >>       the report from DEPT can be a good hint to someone.
> >> 
> >>    2. DEPT can locate code where needs to be documented even if it's not
> >>       a real bug.  It could even help better documentation.
> >> 
> >> DEPT hurts neither code nor performance unless enabling it.
> 
> enabling means building with CONFIG_DEPT right?

Yes.

> >> > If you want to add lock annotations into the struct page or even
> >> > struct folio, I cordially invite you to try running that by the mm
> >> > developers, who will probably tell you why that is a terrible idea
> >> > since it bloats a critical data structure.
> 
> I doubt anyone will object making struct page larger for a non-production
> debugging config option, which AFAIU DEPT is, i.e. in the same area as
> LOCKDEP or KASAN etc... I can see at least KMSAN already adds some fields to
> struct page already.

I think so.

> >> I already said several times.  Doesn't consume struct page.
> > 
> > Sorry for that.  I've changed the code so the current version consumes
> > it by about two words if enabled.  I can place it to page_ext as before
> > if needed.
> 
> page_ext is useful if you have a debugging feature that can be compiled in
> but adds no overhead (memory, nor cpu thanks to static keys) unless enabled
> on boot time, i.e. page_owner... so for DEPT it seems it would be an
> unnecessary complication.

Yeah, I will think it more.  However, maybe, as you said, it could
introduce a complication.  Thanks.

	Byungchul

