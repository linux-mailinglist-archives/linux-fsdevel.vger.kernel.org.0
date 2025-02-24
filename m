Return-Path: <linux-fsdevel+bounces-42444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F3CA42721
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 16:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01384189C3EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 15:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5E12586E8;
	Mon, 24 Feb 2025 15:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=scylladb.com header.i=@scylladb.com header.b="mgOFLmbP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2F41EA7CD
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 15:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740412395; cv=none; b=fL27S6cuZhP7mChRinZPydnTkqPtJdl6SCNeTPLFdVU30qJW5Oc+jk4oEOI/MgwptNDGPvwkFdONTUwfLD81dPG+Ci1AEf0FKV6nvIkfgnBjrrTORxjIg6pjn5oawyCFOTNQ97mSndirc5QHgrcRjMCl22kVe7u7soqAlEoIdSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740412395; c=relaxed/simple;
	bh=uYb2SdR+XjED6l2vwiNXxNeoIQOwpomZpCV/miLW6OI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jf1gWZ1kPK0Pzf8vry4IlY6ktDdw7sATpvr/P02Hc+rebx4xge/q8AfDaPrDOW+MSI2yF6Hevp8WquVOCr9JGJpo8XG21gPcKCPjCObkqrjG61xvI3MQ51aUmpu2Jx+IHZ3z8FURi4KowhZkRb84w2piPXlWAfqh+u95veGIHrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scylladb.com; spf=pass smtp.mailfrom=scylladb.com; dkim=pass (2048-bit key) header.d=scylladb.com header.i=@scylladb.com header.b=mgOFLmbP; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scylladb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scylladb.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2fc0bd358ccso9261528a91.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 07:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb.com; s=google; t=1740412393; x=1741017193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=klSee0+9neLh/O+vcsAj+EUBQ1CcxR/LJT3Y630rmY8=;
        b=mgOFLmbPBM8r1zZ00oMuK9L1Yt3KX1QEJTWk1NVEy13PY9TI95yA+OWBIjQu00hsWV
         qjZ2S10eekUP6Ew4mAJmBBWEgsk9DPMn5+e2sH1mB0PMr3RUtxj54h+IKEX1uM1dzTIp
         u7RSdKJ9yiYXEQcw2+mGUlZd6u1IXkgrUn1uB403arGYi42pDCPW/zsF1hba7okzNRFk
         GTmNH7D061GEKxhyL/V7XK2e6OMauaFleg3PQh00LSAaDeMayB94bmC8u+tTju9nVm0i
         rS1f214Z3dBL6PRhDaNm8yaDuzes0UbxP8Eqj/t8B1c8zuURuUbMFloi0aQ6IfN8e9Qr
         dwbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740412393; x=1741017193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=klSee0+9neLh/O+vcsAj+EUBQ1CcxR/LJT3Y630rmY8=;
        b=WL8atxxeSfK7zfivlm0vfMN9AK+zZDiYARIxThUWe+58zwPA1AIX7cWaOiB26E1eJS
         TaiqhE52yJcllZKPn1GySIaRnNqKPYLvpnjo/Zl3bruxcSvdiEeARIt4nXDhw+PaYi90
         VmV7Uva1PbFLzJGfM3cTC8q55BOdwz3kNOkTb82F/y7Ho2QmFUBRMIZh7pNFBpBXadKs
         TRyqqnXLyMU08ho+3JzntacVkjXSOx93l0/kvOyvu1/HvtHYVlvHJaqoh9Nh2jLlBSQt
         rmPLVvYf+aKOmqDS4VeXG72+ynSUhWd/YNTTCYXNYL3Na47Jsesog1KwMHgMRPwkWi43
         lJrA==
X-Forwarded-Encrypted: i=1; AJvYcCW5o+gXsRe8u8dqtDWCCu7NvGA6ukSVYPm3HC9xBDc3cRJ+ez+LPMdYpya5IeHtcjZiMykjrZvSkCoS4QvQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwQZxA1JuBrCrnb1JQfKM+TQHx9cZMKgHNRE0CoRUTUoMe2mPd3
	TxsivjCBNbzJpz+pwrxAn+DCFocEySElzbGn7zI4L1D3TQUq4NjwPllNlLTONROcxh/62k7837w
	af45kHvozWtrlaKEHlRjclc7Vizbd8tlQv437JQFZTc2epZUEr8bmr/StlbQd34sInv5WYGmhh3
	KlD/eJcIrSn5frjDFf1VOXx4Xd2DBT3/ObiQUMaAyx/oTvyU/Ux/DdP/1fMbGwOoLW6eWkrSzWl
	xsBcxxrD9DV3bHEjqMesrWqNddeYj1Y/lIYi/cMgLyAnrx7bXCSl5b8mUfDbUGb+iAE1kVnUm+E
	X2P3f1uzOWtiaJNEXx/mAE4OmEjg+24dp4Mm09tbDmPC8nnEXP8jl13BTijIPjHCFSrP1p6661c
	w8eWnaQBu3AlHFSgkwRgk55C3
X-Gm-Gg: ASbGncsUB8tbtwiY2G0G1KjYyaZ6hzlnYo+hYiI9xyPvE+fs8SBBYwxvRCe6Iq/ZfzK
	3MURYiOPnIS5EJGw87wKWrOlQaM+z5MHNFUT6ZOMP4aHX4DUfkXn0o6QEX+Qey8sJ8Qrtmq5rrS
	Ut2qa06ltSn/K+qoi0AT5TiA==
X-Google-Smtp-Source: AGHT+IHGE2C3it+MkWdE5/3EIhsU0uJaSmbSOYkJ0M0osQn818HqOwYmz0ZERxOz4BJpJCZKkMY4BzhOWCJ0JXJcC2Y=
X-Received: by 2002:a17:90b:2e44:b0:2f5:63a:44f9 with SMTP id
 98e67ed59e1d1-2fce7b0acaamr19760932a91.23.1740412393194; Mon, 24 Feb 2025
 07:53:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224081328.18090-1-raphaelsc@scylladb.com>
 <20250224141744.GA1088@lst.de> <Z7yRSe-nkfMz4TS2@casper.infradead.org>
 <CAKhLTr1s9t5xThJ10N9Wgd_M0RLTiy5gecvd1W6gok3q1m4Fiw@mail.gmail.com>
 <Z7yVB0w7YoY_DrNz@casper.infradead.org> <CAKhLTr26AEbwyTrTgw0GF4_FSxfKC2rdJ79vsAwqwrWG8bakwg@mail.gmail.com>
 <Z7yVnlkJx23JbBmG@casper.infradead.org>
In-Reply-To: <Z7yVnlkJx23JbBmG@casper.infradead.org>
From: "Raphael S. Carvalho" <raphaelsc@scylladb.com>
Date: Mon, 24 Feb 2025 12:52:56 -0300
X-Gm-Features: AWEUYZkpULmB7ggdWZq0vQLW6dT8AZhCNwNVQSj2mIp6VwfSCWyVNpmgUWs2yvk
Message-ID: <CAKhLTr2tNHimdu+QeMq=qu4n+K+VyW4PcZdB_nusaW9NSUBG3Q@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Fix error handling in __filemap_get_folio() with FGP_NOWAIT
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, djwong@kernel.org, 
	Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: scylladb,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: scylla,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0

On Mon, Feb 24, 2025 at 12:51=E2=80=AFPM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Mon, Feb 24, 2025 at 12:50:48PM -0300, Raphael S. Carvalho wrote:
> > Ok, so I will proceed with v4 now, removing the comment.
>
> No.  Give Christoph 24 hours to respond.

I am still getting used to linux development rules / culture. Sure.

