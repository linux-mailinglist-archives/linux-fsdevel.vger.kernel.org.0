Return-Path: <linux-fsdevel+bounces-62691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB68B9DBB5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 08:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A77819C4CC8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 06:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456362DD61E;
	Thu, 25 Sep 2025 06:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRIO8ize"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E172E172E
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 06:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758783157; cv=none; b=Ck9baPnKsyl4oFbmSG1SWaM8WDCrcs9HhUwe1GStLmlM5pE0UdSTyQ6t4qYwb3+6Rits9hIf3sTszxeuZBRzMHpcR/0DOvI2j6uolraprNTbFIrzEniRdeET2/n3YNOfPhy/LlCBmFv++/SqLOikuwJZtakYuAru4T3/4CwREo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758783157; c=relaxed/simple;
	bh=HFVz/QPtAvUiCFUVXP3+5oRqUBad/EwgMPO3kvPfqvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GH3+ZveBZ4L0OAA1mVfQ5Sa5LYJe7tNT3gRUFhZd7Mr/3h56wELpzaIq5JoVJ0lTnPYWMFH+SqQtfmXDmggZ7d6A+DTB84jfZYVjo2bMlsxLclQki6aXvbnqBw0gmHo+QDFEIOVnsUV93rLLcsCSNG2RzJiw5TyTCnGXoo8d6U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRIO8ize; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b30ead58e0cso103037166b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 23:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758783154; x=1759387954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MiZ3M35beekAKI7RSUKVXC+ANqBzIMLfoty25+OxUzs=;
        b=NRIO8izeO50TTLmvKDl6mwgyaZr7tH1xbJTFwNQLTbW28e1K2MVxSrCH2Pj89BWF9W
         e0wuVXniPpSWrDeohu/EkzZ1qqu3zqpI+H8oVfFm46BFAOOtvjr238E2YRRNEwqjzfUF
         NssRSsIPFda60UKOGvqXqFCcqbivUQxl9a4ulx/RH5vZG9EmGqDYv3D0aiTXyxFi4jc+
         jsR02YxwWMPssB+rP+rrn9gqY1SuhJcxRyYhcieFQWN12ARI71pWRTpTlYS4NlgDfNQ1
         fmkbSQXyktqcH6Blqx8YesQypOVzPJ8dObBexhprQ+DSHt+R1/8cFRJQU1gMkuyccL+9
         gisg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758783154; x=1759387954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MiZ3M35beekAKI7RSUKVXC+ANqBzIMLfoty25+OxUzs=;
        b=H2cCEZEXXiphl090Gbuf2vaffTdSgtLdyCfOVw4PFi4U+QWgnA8Xbk5ssT46bKVhlX
         BsgQncb19eSiAkY9Pfqv9VR9b6NMrXikf6fnSaqHQ0LDtXJcRCsRW+8W1fLNsbIfUp9y
         4RlukIh2+X/yp44BHwKAuAhi7Q8gN6ob6D/OpjPGPGf0T5inlWuzY3XiQLkC32g16IG6
         xBcDpOJS5fLNloUxJmnftIEj66bYzCJUQQ4e1Dji/iDDQnHha7mjrGqTeKeG2GtsyCkC
         q6LP4oYJWbskdsDClfsRP/P0Rpmg+KuFg6mBNPE4SY9NYBnXaJoWyuNmiWhjGWVMkm3M
         ejuw==
X-Gm-Message-State: AOJu0YwHQ1any0OpqB6rYzHilsBIFPFzJmc7mNY0tyPOMvNCUE7ncmjj
	mZb7tQy0GxH5lcV4zaQIw8G9Pte4FxLqwDNdNUKDvfjKqqn9+jZHYjLNZRDxl36fRgd+abPVaj+
	hJTE1lN3x6L9gt5IaTtd1zQRzK2mYjrqrePhd3a8=
X-Gm-Gg: ASbGncuv1/LU+On3XTzkyq5ocYctqfczKMOBvPhh1w5lKeT/GeuNeM7wLkr1vGpEvLt
	0NTsn0DbjeBRHxs9e0BnojRAs5dEj8I740lHQgr+ABOjbT3Rz4GXayfFYQad1afHJzCrpsH5w1T
	zBrQ29L1yiAC5jtTobl5d8ds20AVgegSymWYJlgL8Mx+vAdsfiiURk2klrPgtKTzoQW2GfMo3xJ
	sKP
X-Google-Smtp-Source: AGHT+IH2DuoDcNWy9F/uMiBGRBHdXFRko2Fv2dlY7gzD/Ngs8sJ8kkqcVqb5aHWtLYza+9b0GzEoCvQlnRfGQlahRpk=
X-Received: by 2002:a17:907:944e:b0:b04:b435:fc6b with SMTP id
 a640c23a62f3a-b34bbebea0cmr238730966b.60.1758783154038; Wed, 24 Sep 2025
 23:52:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGmFzScM+UFXCuw5F3B3rZ8iFFyZxwSwBHJD6XwPnHVtqr5JMg@mail.gmail.com>
 <E1CDDCDF-0461-4522-985E-07EF212FE927@bsbernd.com> <CAGmFzSe+Qcpmtrav_LUxJtehwXQ3K=5Srd1Y2mvs4Y-k7m05zQ@mail.gmail.com>
 <5f63c8e3-c246-442a-a3a6-d455c0ee9302@bsbernd.com> <CAGmFzSe66awps9Tbnzex3J8Tn18Q6aEVF3uJnwJfVAsn36_yrg@mail.gmail.com>
 <CAGmFzSdD71SxAxCJp5BbJZ7-JVARtoDPPScGvxhTF=+HQ+D6jw@mail.gmail.com>
 <dbb91af0-ef9d-4a17-852e-ffaa1c759661@bsbernd.com> <fb7bc595-bbc6-42b0-a16c-acc79f59cbee@bsbernd.com>
In-Reply-To: <fb7bc595-bbc6-42b0-a16c-acc79f59cbee@bsbernd.com>
From: Gang He <dchg2000@gmail.com>
Date: Thu, 25 Sep 2025 14:52:21 +0800
X-Gm-Features: AS18NWBBvadhW9xh9-VnLkuEV4bLmVCdbY22n5DYkMker8qTwaTjYaw4hNZRgEo
Message-ID: <CAGmFzSdC7AgKNSq8p95y79yr2t09dAZ2bkLehnSvrP8UzaDfNg@mail.gmail.com>
Subject: Re: Fuse over io_uring mode cannot handle iodepth > 1 case properly
 like the default mode
To: Bernd Schubert <bernd@bsbernd.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bernd,

Great to hear this information.
One question,
Does this change impact the existing performance advantages=EF=BC=9F
e.g.,
Single-threaded synchronous IO read and write=EF=BC=9F

Thanks
Gang

Bernd Schubert <bernd@bsbernd.com> =E4=BA=8E2025=E5=B9=B49=E6=9C=8825=E6=97=
=A5=E5=91=A8=E5=9B=9B 05:09=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 9/18/25 10:38, Bernd Schubert wrote:
> > [Added back fsdevel into CC]
> >
>
> I'm getting there, upcoming patch as part of the queue reduction series:
>
> fuse: {io-uring} Queue background requests on a different core
>
> Running background IO on a different core makes quite a difference.
>
> fio --directory=3D/tmp/dest --name=3Diops.\$jobnum --rw=3Drandread \
> --bs=3D4k --size=3D1G --numjobs=3D1 --iodepth=3D4 --time_based\
> --runtime=3D30s --group_reporting --ioengine=3Dio_uring\
>  --direct=3D1
>
> unpatched
>    READ: bw=3D272MiB/s (285MB/s), 272MiB/s-272MiB/s (285MB/s-285MB/s) ...
>
> patched
> Run status group 0 (all jobs):
>    READ: bw=3D674MiB/s (707MB/s), 674MiB/s-674MiB/s (707MB/s-707MB/s) ...
>
>
> fuse-over-io-uring RFC v1 and v2 versions had
>
> https://lore.kernel.org/all/20240529-fuse-uring-for-6-9-rfc2-out-v1-17-d1=
49476b1d65@ddn.com/
>
> I dropped it on request as was an optimization hack. I had
> planned to add it back earlier, but was totally occupied
> from January to beginning of September...
>
>
>
> Thanks,
> Bernd

