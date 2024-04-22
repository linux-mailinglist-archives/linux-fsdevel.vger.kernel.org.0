Return-Path: <linux-fsdevel+bounces-17412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D404B8AD102
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 17:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F6ADB20CED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 15:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053B5153518;
	Mon, 22 Apr 2024 15:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGiVSfI/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABDC152523;
	Mon, 22 Apr 2024 15:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713800101; cv=none; b=l5j3uJARGOk3Y0KtwF+QvavWD0dgrcpRCx/iwax/e6Rq0kVo6oexHMYRdDhuYMp3o1Q9qV8eDdkHcmzOZx0kUW4tibA0macx0tIWKW1EBaI5nt653quKdRiER7MLBhi/kbWLtzr9F5OfM02+YmbgBEZIEiYh4WzEJ5Gf2cFopa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713800101; c=relaxed/simple;
	bh=k+hbCfeBQPRpXXeKDg3W6ZAq2kwbOldMPCT7MKeU7xA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iWUoin+6i1tPvpPa5U5yTGvslnTvMKvvPH4k6X8K3brb7WfVvPmOmvyyss6acJYqHlMzJ2QdRb7OGmsLtTZetqJi4Jq1Tt+XRDEMqjrAQ6BynJwTuaCWUnoFX1sHtrDdpz41gWMU2U34SNEk0B0/Oc0qWBSMpnKIdk32Aw5i2v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGiVSfI/; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d872102372so42289411fa.0;
        Mon, 22 Apr 2024 08:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713800098; x=1714404898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wN70iPYr3n9W1U+WIrHwJM/MMTxEMvnw8AZRwUzGnOI=;
        b=gGiVSfI/J/bKvPkIxlMn4IXC37a3foRqSwz8mGuQkE2dW6J5TpcgoM8LvVpzGtW2mw
         CMGYG4WBR2tPXkl8ndggSz6nTBqlHr7A2VNV4mKGby1JSolLELa2yfDZun4ytfFuiLmK
         L/0v1+3i47yJ4ojOPK8+AVQeCDDNrFVtdkZ5gXoxHyE8PoKTIlqIcCF2nBqUuJzNBTBz
         m5kDn/OM6u23MIMtrvn9ttCJIcY5g4O+BNwQNzbnPKd+j9pBNsdiI1JUqVf1BjDTNzzm
         Hf5aM69xQ5PA3zATxtOJE5XJIxsSWDTi/TLWA++I4/YS+hrJ9XbSjZ5HU5tRtAneKuyR
         1M8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713800098; x=1714404898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wN70iPYr3n9W1U+WIrHwJM/MMTxEMvnw8AZRwUzGnOI=;
        b=XREIp95U6huwDAIKiwhoWggc5bSnBN0tiGlH8hV86Cec1tlBoqonV0zFdaoozWm4zj
         dP87ouBMZh5DyXzmUwluIAn9QHXV10yblgCvtAx3uzr73NAAabCxr+muoz0OaMJI7gzS
         npY/Sta0fZJZunCwDNgO4zypPGJsjVFOfUyK6ISkVbgImDG1t/k+KTMVFHTYIMPwV8ex
         68YsKPxvCZam9o8+3sy3MXLj7w+3S/yt/OAuV0x6WDXy3psEpTStlSAMCLsEr4L+frIT
         IY4sjDUqnToQY5UlXUMB9NmxkSqRCIbrhiCZcIM7acsDhxYBONSJBcDNsrIty33VCWV3
         juqA==
X-Forwarded-Encrypted: i=1; AJvYcCVlpQcHZQ2GPtZxVj3Pf1dzYqjj78iQlBiR+RuIP08ZcgOwBgZMo7m0OilnRYRA0BdC+JOqtFJ/VkeyoYiIVlEAaGnVRes8LA/X6Y2dw1w22lYBz9teoP8CXOFoOncrTEZUbo+nC7SQ5YUQD1lTTz5EO8G6jbvxmTOIo8FZUci0phcpd/V+2vM=
X-Gm-Message-State: AOJu0Yw+Sh4l6qO0w7z8Q7zmC6NnW6uGsr4CYyJM3jVd9yzRpt+p+i95
	yDN6WoEG/H+FKEZeKz8J676LAYlgmcb7RnKiIsgg509fVberDqSuzsi4s0IB42DrG8Wd8oAHfKn
	PCYc7v4N79Oj2xQySWd4fwTmsWL4=
X-Google-Smtp-Source: AGHT+IFVaXdFYTTUUh/Ynnj3KGqzpi6jgLFcOLxDKW0sdOvKDfA0SAHpCjiqna5bFgyiQX7G5wZqnnHNc+OwlBR8vKc=
X-Received: by 2002:a2e:86ca:0:b0:2d8:606d:c797 with SMTP id
 n10-20020a2e86ca000000b002d8606dc797mr7960ljj.10.1713800097720; Mon, 22 Apr
 2024 08:34:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417160842.76665-1-ryncsn@gmail.com> <20240417160842.76665-5-ryncsn@gmail.com>
 <fc89e5b9-cfc4-4303-b3ff-81f00a891488@redhat.com> <ZiB3rp6m4oWCdszj@casper.infradead.org>
 <e5b9172c-3123-4926-bd1d-1c1c93f610bb@redhat.com>
In-Reply-To: <e5b9172c-3123-4926-bd1d-1c1c93f610bb@redhat.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 22 Apr 2024 23:34:40 +0800
Message-ID: <CAMgjq7AKwxBkw+tP0GhmLh8aRqXA81i1QOgoqyJ2LP5xqeeJWA@mail.gmail.com>
Subject: Re: [PATCH 4/8] ceph: drop usage of page_index
To: Xiubo Li <xiubli@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Huang, Ying" <ying.huang@intel.com>, 
	Chris Li <chrisl@kernel.org>, Barry Song <v-songbaohua@oppo.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Neil Brown <neilb@suse.de>, Minchan Kim <minchan@kernel.org>, 
	Hugh Dickins <hughd@google.com>, David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ilya Dryomov <idryomov@gmail.com>, Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 9:40=E2=80=AFAM Xiubo Li <xiubli@redhat.com> wrote:
> On 4/18/24 09:30, Matthew Wilcox wrote:
> > On Thu, Apr 18, 2024 at 08:28:22AM +0800, Xiubo Li wrote:
> >> Thanks for you patch and will it be doable to switch to folio_index()
> >> instead ?
> > No.  Just use folio->index.  You only need folio_index() if the folio
> > might belong to the swapcache instead of a file.
> >
> Hmm, Okay.
>
> Thanks
>
> - Xiubo
>

Hi Xiubo

Thanks for the comment,

As Matthew mentioned there is no need to use folio_index unless you
are access swapcache. And I found that ceph is not using folios
internally yet, needs a lot of conversions. So I think I'll just keep
using page->index here, later conversions may change it to
folio->index.

