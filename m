Return-Path: <linux-fsdevel+bounces-50410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F154ACBEEE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 05:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C3CA3A2966
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 03:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AAB15573A;
	Tue,  3 Jun 2025 03:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkH/0OMY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB372C3272;
	Tue,  3 Jun 2025 03:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748922697; cv=none; b=IZbNxkjI5PruJvwMrj5QgDreBTRxDznnDNZH0M2dxY5Fj5dol03EUcl4dX8i/x7vqu4qq4aWsx/otxa+oqrQULwzjfcvugMla3yBamKWXfcnUmOO7rmeZfpgsWmxhCOayXS8Sh6ZUK1OsUWz9uP3oTvxYMjTniJMnaixv48/y5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748922697; c=relaxed/simple;
	bh=f4ir0xp6NbjPczdsxTuL2W3li53bsxRCfW9rmKGMWpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I9Orzn49CxertKQsm2gJ2hYuLXpWJwr1cbmSz3rRjY30LynXwmVb9691dbx7+uHFqugEjv4JeIba9Rna3IBEFpjeg5XM6qjts/NOhHK377rza4aKqNvdDIy+HqSaiAtpHWdAFTZpZ6aIgdsyL0+/FAV/aIQzVbtNavd+UmrXE2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JkH/0OMY; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6fad4a1dc33so36147816d6.1;
        Mon, 02 Jun 2025 20:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748922695; x=1749527495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtV92Qim+XXsQYgIgzklo11lucYmmM/sarntLTuHaWg=;
        b=JkH/0OMYGjDKE27n28W3x0K9DNvtm5kg9MiMwnDJRGaMu94hQ8Qlr1IkCubBnMmkob
         Tb8FEID+tvAG7NX5jsTQUP/3xcKUX6KZFV0gpwhBP0vzfY2tR5Oem6NEBK6jI9EJcZa6
         ZvE724SiVl8h/qHjM6pYH0TVykjV3zjkUlV6h70ANWFSRiSAjuLa0diggBds+4CKOHXr
         YZXjUgcP/+ardDWE22X0QIqwO/RxXdmMBlfAzrSw4CKv/CgUpkeSgC64Ag80A0QlUvhi
         9FwwTHFtF+1yBkEiBFIWuxKbJFOxrXozexem++bVVDillRPLRokM6qKEfGMlx0uvkl1f
         eZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748922695; x=1749527495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jtV92Qim+XXsQYgIgzklo11lucYmmM/sarntLTuHaWg=;
        b=XTr9z9rf8tl/IfCa8P9ixjHGg31COheJNA0Ri7wYsmmFxruY1LRPEJ3ujNGNNM6Mk0
         yuSgGBidbDcJaKV4mwSe9jVOqtJOvShZBCko0ghdBcsRw9bQGPvT66KoGTmNcA0wJ1oR
         rhQl3jDBwDygZTa5ECgAJA38Cu09kGv03XCE31HdqpOftsFxtWItahC5ijzb4HGlg2yK
         CMHB1HZzOJLGKingytmLRJ1WglFtN83uyvsqNgH/Pl1UURugh09ce9q+INNldTWW0wok
         L4P4cbSgkBV5q+aqjyOHx/k8J9C9S9/lFs63jZom1W1nj8dVhLC0+870nPHv6d2lKdRG
         dnGA==
X-Forwarded-Encrypted: i=1; AJvYcCVxxBpHYODszN3cqS5Sfu2XdCe9out/s42VI0/UJJV33JIoo7CoC0no9SViJg2R0YvA6Pr0iFtP/t6pll3F@vger.kernel.org, AJvYcCXUdUoGv4I5pfjf8Z4QXPaWdDJM4kNAmz0WbhprBqNQC96rFyZgI584eqJZSSa3tTDzjj/FzEPjqp7M@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Kqmw5DMVdWqc1f/vGJ4cx/mEv2ua01Aner6SPy6F9xmkj/yH
	MmEhWnPFZa/vAJ5LwxwkWk8aMnFc8kcZ+paXdXvZJxfVfRfSv5xaL51WO8jAV0VZJ4IMVMQgbIW
	ZYPGGCFHWg7U01Ad1/hKikvby4IjDsLY=
X-Gm-Gg: ASbGnctacYKv6dfTwG5piwDbKtCjTUoC2cK6ULGI/NA7v2ppqomxEEXX6LN21CywzCS
	iKLq5ToH94Tr38paYUwjNmR8Kfz68eZkyHW+jKsnK+TP/cvc9fD8tzwkAO1Rz6gap3tb0DrVT50
	SgkoRvERHCW/NBk2d/8ub6aZk94B695E7Zpg==
X-Google-Smtp-Source: AGHT+IGD/uonydJomnbd+ikQ61p1KA/L5ZEIP6YtEAsOkVsp4Nm4sJqhrJdrL4eUgCfTjH8gZgyYOJZydcSQDeDdzAs=
X-Received: by 2002:ad4:5c4e:0:b0:6fa:cdc9:8afb with SMTP id
 6a1803df08f44-6fad1a87857mr261089076d6.23.1748922694759; Mon, 02 Jun 2025
 20:51:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALOAHbDm7-byF8DCg1JH5rb4Yi8FBtrsicojrPvYq8AND=e6hQ@mail.gmail.com>
 <aD03HeZWLJihqikU@infradead.org> <CALOAHbDxgvY7Aozf8H9H2OBedcU1efYBQiEvxMg6pj1+arPETQ@mail.gmail.com>
 <aD5obj2G58bRMFlB@casper.infradead.org> <CALOAHbCWra+DskmcWUWJOenTg9EJQfS23Hi-rB1GLYmcRUKf4A@mail.gmail.com>
 <aD5ratf3NF_DUnL-@casper.infradead.org>
In-Reply-To: <aD5ratf3NF_DUnL-@casper.infradead.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 3 Jun 2025 11:50:58 +0800
X-Gm-Features: AX0GCFv2Pl-tFtvaHCh-UlbgczL6E3rN3N2afWqGOcJ3Cwo_LMarDttLMWe9tT4
Message-ID: <CALOAHbB_p=rxT2-7bWudKLUgbD7AvNoBsge90VDgQFpakfTbCQ@mail.gmail.com>
Subject: Re: [QUESTION] xfs, iomap: Handle writeback errors to prevent silent
 data corruption
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>, Christian Brauner <brauner@kernel.org>, djwong@kernel.org, 
	cem@kernel.org, linux-xfs@vger.kernel.org, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 11:26=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Tue, Jun 03, 2025 at 11:21:46AM +0800, Yafang Shao wrote:
> > On Tue, Jun 3, 2025 at 11:13=E2=80=AFAM Matthew Wilcox <willy@infradead=
.org> wrote:
> > >
> > > On Tue, Jun 03, 2025 at 11:03:40AM +0800, Yafang Shao wrote:
> > > > We want to preserve disk functionality despite a few bad sectors. T=
he
> > > > option A  fails by declaring the entire disk unusable upon
> > > > encountering bad blocks=E2=80=94an overly restrictive policy that w=
astes
> > > > healthy storage capacity.
> > >
> > > What kind of awful 1980s quality storage are you using that doesn't
> > > remap bad sectors on write?
> >
> > Could you please explain why a writeback error still occurred if the
> > bad sector remapping function is working properly?
>
> It wouldn't.  Unless you're using something ancient or really really
> cheap,

The drive in question is a Western Digital HGST Ultrastar
HUH721212ALE600 12TB HDD.
The price information is unavailable to me;-)

> getting a writeback error means that the bad block remapping
> area is full.

We have confirmed there are still available remapping sectors, but the
reallocation operation still failed.

> You should be able to use SMART (or similar) to retire
> hardware before it gets to that state.
>

We are always using SMART to do this kind of check.

--=20
Regards
Yafang

