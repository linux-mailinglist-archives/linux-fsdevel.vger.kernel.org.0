Return-Path: <linux-fsdevel+bounces-46009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FD9A8138E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 19:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEB9E1BA8463
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 17:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B4023E25A;
	Tue,  8 Apr 2025 17:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VR/3sGpW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D9523DE80;
	Tue,  8 Apr 2025 17:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744133096; cv=none; b=gLX+YQZMTkVwYvj7vA+FOVp97twndDt1g/RfKYkluDt8sQhy2Ago1ZvWED+/Q+g1KnO6zcimDVNrsUV3RuHH3XVZYU7seJJ2dMe43haUnTF17XV4pzXSeiBVVrYLewmcy2Wf+f+0XGOTD0HO3aTqpFd4aLTutjyWrOQ3SVvF6JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744133096; c=relaxed/simple;
	bh=Qn5Ck1vJ06hGQa9KFxXgN+oEMgiIIvvFkdSa9O9bo6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kiDdMMEhm+IqWFUnxnizKSPtDBNASO+HmSntawaI7SZhSaAqUFIHDcox+bAvkjBM9Sg61HlKvXqIbcpAUqtjdgaB/VJECBhPTIjgFjzhQxltDTkoa3/TeATDmM+w7Ci/0MZMqe///Y5/jdo7ZLYOe+walq6p12z/0dQAGzfgMYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VR/3sGpW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8767C4CEF1;
	Tue,  8 Apr 2025 17:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744133095;
	bh=Qn5Ck1vJ06hGQa9KFxXgN+oEMgiIIvvFkdSa9O9bo6s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VR/3sGpWJ5rWLSoCgzu87J7ftnRZs66hq5WQ1VtAatTEGudI1q5w90Thdvz5lQvLN
	 dxZOMTiVnlgNEVxY+NgiLIvN0gPQA308PFzDRpGgnf3NHsG3BMuaoFh6SU63LutXV5
	 08CgQBk4un/8b8A6pubJKz+tPfxAwfIE7VC7ezSAUZ9QZuqOoBuOcz6H7FeLgNS4XO
	 zGnCIhMdWCDphR5NFS9pphv1SwbHmZs8Ivc3fu07U/WMUUCjnZKPhZpuMRR0znKmGw
	 9DuPj1Ty3cCW+cqmn4PebZf/mSqWg5of2YEMi9t7Z0C2KPtgxKeCwL85FMJ3dpFGzZ
	 TW7jLv1H97tHQ==
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso39494725e9.2;
        Tue, 08 Apr 2025 10:24:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWn5vodr1THOTKfpRhq7iv/nG2D6H1Wf7Kc85Tx3XIsZqsgV+oCLjcK7EuxYhaGEOskpodgb2UqUdLUug==@vger.kernel.org, AJvYcCXaeVGJCchZgiFoQf0dg0jwEM90Io4COcL10GbiNnmglMj2r1taJagDEV80mXTsOYvh820XduYRyNJLD0TYEA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxRH7V+XrFOZzP8MfpX2WLEdOfMg8Tgw1fto3Yfy7NpJgRugWj
	+emnP1Uylg0lt0rYL7JG9pViy7RyNgFIO6FbjmwDgAZXYUdUbehf+wnjWQ0oqlAcw9NvEuJaD76
	LEF281GFaHFsy8TjPl27Y+/kbJsw=
X-Google-Smtp-Source: AGHT+IFRAjLfQCBr3rX6vZ2fsBVsMr2T23eGspawcofOM/TZGshy7w4DX7acOT1xhfx/YgNGxx0ILqYbu7TKlmgMCSE=
X-Received: by 2002:a05:600c:4f0e:b0:43b:c0fa:f9dd with SMTP id
 5b1f17b1804b1-43ecf9c3224mr136041325e9.25.1744133094266; Tue, 08 Apr 2025
 10:24:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331074541.gK4N_A2Q@linutronix.de> <20250408164307.GK6266@frogsfrogsfrogs>
 <Z_VXpD-d8iC57dBc@bombadil.infradead.org>
In-Reply-To: <Z_VXpD-d8iC57dBc@bombadil.infradead.org>
From: Luis Chamberlain <mcgrof@kernel.org>
Date: Tue, 8 Apr 2025 10:24:40 -0700
X-Gmail-Original-Message-ID: <CAB=NE6X2QztC4OGnJwxRWdeCVEekLBcnFf7JcgV1pKDn6DqhcA@mail.gmail.com>
X-Gm-Features: ATxdqUG4s7BXjovPaP_VhFNUVZgChGE0cW8x125v6xnSaCbjN2XcbNiVp5avVwc
Message-ID: <CAB=NE6X2QztC4OGnJwxRWdeCVEekLBcnFf7JcgV1pKDn6DqhcA@mail.gmail.com>
Subject: Re: [linux-next:master] [block/bdev] 3c20917120: BUG:sleeping_function_called_from_invalid_context_at_mm/util.c
To: "Darrick J. Wong" <djwong@kernel.org>, David Bueso <dave@stgolabs.net>
Cc: Jan Kara <jack@suse.cz>, Kefeng Wang <wangkefeng.wang@huawei.com>, Tso Ted <tytso@mit.edu>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Oliver Sang <oliver.sang@intel.com>, Matthew Wilcox <willy@infradead.org>, 
	David Hildenbrand <david@redhat.com>, Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org, 
	Christian Brauner <brauner@kernel.org>, Hannes Reinecke <hare@suse.de>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	John Garry <john.g.garry@oracle.com>, linux-block@vger.kernel.org, ltp@lists.linux.it, 
	Pankaj Raghav <p.raghav@samsung.com>, Daniel Gomez <da.gomez@samsung.com>, 
	Dave Chinner <david@fromorbit.com>, gost.dev@samsung.com, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 10:06=E2=80=AFAM Luis Chamberlain <mcgrof@kernel.org=
> wrote:
> Fun
> puzzle for the community is figuring out *why* oh why did a large folio
> end up being used on buffer-heads for your use case *without* an LBS
> device (logical block size) being present, as I assume you didn't have
> one, ie say a nvme or virtio block device with logical block size  >
> PAGE_SIZE. The area in question would trigger on folio migration *only*
> if you are migrating large buffer-head folios. We only create those

To be clear, large folios for buffer-heads.

> if
> you have an LBS device and are leveraging the block device cache or a
> filesystem with buffer-heads with LBS (they don't exist yet other than
> the block device cache).

  Luis

