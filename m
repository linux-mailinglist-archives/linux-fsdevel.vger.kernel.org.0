Return-Path: <linux-fsdevel+bounces-59667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD19B3C573
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 01:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C52D25A428D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 23:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C759B35AAA1;
	Fri, 29 Aug 2025 23:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2slv/+C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A92525EFBC
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 23:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756508590; cv=none; b=ZK3U9d3uwnVgSnYxe33w+l8GbZWobqPX+YLcyf1URdAUIV0xdX55wd2CzwypQVfMmy4vUdV8YAqtZdiRO0ONGmT2HT1OYNjRGdzP6cA5cCGlMPB7UkZFhv1NDPVty1qum4Q9J7VdJ5XqimQVkTxi/q4y6jTC+iD+TFBooFVQasQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756508590; c=relaxed/simple;
	bh=oNRHPoR8C22I1emQJoFdePMszc/3gDq29g3GRzxuHC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FU6qs2avZqp4GyK0r6gk34HB3FPTiVuqiI9V3QMIwkDaak41YtPTwbJJf3dvhlAHbeAH/u/VE1vvQEk0a0Z/bwxFbToDDaLJpHuwHt21Mt7QQGF4unjBQToNy8E0K1zagRuhv0Uiws8H3KDMwrWDcSw0GZDrO4UcvutPNE3z7Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2slv/+C; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b308ace753so20612771cf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 16:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756508587; x=1757113387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHahEkW90E3K8vme96BrNc+kv0QVOb2ty07V9mAlLKc=;
        b=L2slv/+CR32W5IDpTCmn0ZfRL3QaLCABGnLMXArJ8JJYaEzwB/yo71ibRlQRDOD28N
         FkOQYYPDwcvxMM+EaS68XUG3Xmzb+kmxF7ESEZV5oA6aRxpb95H9GDbDIHzOB8mvB1lL
         YvJOb+fSwE6VeqgKG522l5rV05CnyLnPXFVDuMiGBAyb9/XyhmzT8bTy8Cxkib7HyV0L
         3BVb8lv5EQzhs1MjYslMOZfFqOmu5WaAGVG1cMEL6TIedLi+27/Q44klluoBlLQopbDm
         Men3H7VW8Vrd6U/2KKZr/Pk+7qdztherrU8yr9wzFkRksuscW1aGL+V7zPfiS7iWSO59
         6r4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756508587; x=1757113387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EHahEkW90E3K8vme96BrNc+kv0QVOb2ty07V9mAlLKc=;
        b=MQtQmr8JsHqFLYU3my20t4cgepHF+6fUJIGrt2k9ihWZy+u5cv3Ze5uT8MmDN/fqfN
         Z3pSpv8gCxvvBhdCy77SbaJZQHv5AD3GxVcwb2JmC2rV9/cnI08obnYUTovNRRRuPyZQ
         vnt4WY2eripqudos01XR3xAYsOkCzu8IQjLyn93M5KS1qAiR9pN+9MlUD+u2zlrwfFTI
         M9FWpvFMio45l4Tyo23C9q4RYDcQW2+gXCQSKCr5KPftHxyFtAABbv1TpKaY6Q5hvx1O
         6D9AHd8eiSfaJedd+jXQBy3UQ7bx6pVkjzVm7446why87hC4jt6RmPrrQvDDV+esCQbz
         xe8g==
X-Forwarded-Encrypted: i=1; AJvYcCXn7MS0TnnQ3awMVGcjNjBN7hIQIH0n0Ujcwzn2WqX4Sdvxf7EZ5fHnzTRsc5WCJ+hKciWwB+28tmFaEt1q@vger.kernel.org
X-Gm-Message-State: AOJu0YxnbClAVuJFlZ7tJuo6uUzRXEu8kKiUppKoVvuD1LvN2CXla7lA
	bLzDh1LH2DIVFzaor6+soXuDPlzxONYefrKG7+YHScGezM57F1qjx0oZDht0kzIGnZLCA3CUZJ9
	7XMQZxdF+ISSuxCvTt6Co5of+It39ccA=
X-Gm-Gg: ASbGncsXGXwenumzdo2sixFMPT4ohdqCY8HN/VbvqXUXZcDP9B9pU2UXjpomt43WnzZ
	dQsKuMVypXP9jK13NmIe7P8wp0VJ6CLh62QOJltInpZvohnIAwQQdrvWbZnBxf0N2dwuGXPbUCr
	6sZxpclbhOVUBNDshqHR5QoaLxxpm4GkAvLMEqmRyyZ4nPGDrD0Fn00UkMHXFRQMiTNMAaWnAio
	E1rkakICoY2WvOPac6RST9oJMeQ6Q==
X-Google-Smtp-Source: AGHT+IEIYCRuciJtYQI04fSLLqlCBDLF0lt7nU8NQFo+iWPHSQ6IDWvFYIydMBOVUlxgvhfaag1SSff7sZA2WpX/muk=
X-Received: by 2002:ac8:5914:0:b0:4b2:8e4c:71ca with SMTP id
 d75a77b69052e-4b31d89e531mr4292841cf.12.1756508587329; Fri, 29 Aug 2025
 16:03:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801002131.255068-1-joannelkoong@gmail.com>
 <20250801002131.255068-11-joannelkoong@gmail.com> <20250814163759.GN7942@frogsfrogsfrogs>
 <CAJnrk1a0vBqcbwDGnhr2A-H26Jr=0WauX7A2VLU9wvtV3UtpDQ@mail.gmail.com> <CAJnrk1bqZzKvxxCrok2zqWoy8tXtY+hZF9kXa8PTWmZnihOMTw@mail.gmail.com>
In-Reply-To: <CAJnrk1bqZzKvxxCrok2zqWoy8tXtY+hZF9kXa8PTWmZnihOMTw@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 29 Aug 2025 16:02:54 -0700
X-Gm-Features: Ac12FXw5jDz9qTpnLWvZYMoaFe9FRA8t701a9u-9bJuhJPsiRtiPt18hnfxL7Y8
Message-ID: <CAJnrk1YP2dkmvvMjMg8w3AgVNzQVzq+CDUY3c1+8JRCBcaP2sg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 10/10] iomap: add granular dirty and writeback accounting
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-mm@kvack.org, brauner@kernel.org, willy@infradead.org, jack@suse.cz, 
	hch@infradead.org, linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 5:08=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Fri, Aug 15, 2025 at 11:38=E2=80=AFAM Joanne Koong <joannelkoong@gmail=
.com> wrote:
> >
> > On Thu, Aug 14, 2025 at 9:38=E2=80=AFAM Darrick J. Wong <djwong@kernel.=
org> wrote:
> > >
> > > On Thu, Jul 31, 2025 at 05:21:31PM -0700, Joanne Koong wrote:
> > > > Add granular dirty and writeback accounting for large folios. These
> > > > stats are used by the mm layer for dirty balancing and throttling.
> > > > Having granular dirty and writeback accounting helps prevent
> > > > over-aggressive balancing and throttling.
> > > >
> > > > There are 4 places in iomap this commit affects:
> > > > a) filemap dirtying, which now calls filemap_dirty_folio_pages()
> > > > b) writeback_iter with setting the wbc->no_stats_accounting bit and
> > > > calling clear_dirty_for_io_stats()
> > > > c) starting writeback, which now calls __folio_start_writeback()
> > > > d) ending writeback, which now calls folio_end_writeback_pages()
> > > >
> > > > This relies on using the ifs->state dirty bitmap to track dirty pag=
es in
> > > > the folio. As such, this can only be utilized on filesystems where =
the
> > > > block size >=3D PAGE_SIZE.
> > >
> > > Apologies for my slow responses this month. :)
> >
> > No worries at all, thanks for looking at this.
> > >
> > > I wonder, does this cause an observable change in the writeback
> > > accounting and throttling behavior for non-fuse filesystems like XFS
> > > that use large folios?  I *think* this does actually reduce throttlin=
g
> > > for XFS, but it might not be so noticeable because the limits are muc=
h
> > > more generous outside of fuse?
> >
> > I haven't run any benchmarks on non-fuse filesystems yet but that's
> > what I would expect too. Will run some benchmarks to see!
>
> I ran some benchmarks on xfs for the contrived test case I used for
> fuse (eg writing 2 GB in 128 MB chunks and then doing 50k 50-byte
> random writes) and I don't see any noticeable performance difference.
>
> I re-tested it on fuse but this time with strictlimiting disabled and
> didn't notice any difference on that either, probably because with
> strictlimiting off we don't run into the upper limit in that test so
> there's no extra throttling that needs to be mitigated.
>
> It's unclear to me how often (if at all?) real workloads run up
> against their dirty/writeback limits.
>

I benchmarked it again today but this time with manually setting
/proc/sys/vm/dirty_bytes to 20% of 16 GiB and
/proc/sys/vm/dirty_background_bytes to 10% of 16 GB and testing it on
a more intense workload (the original test scenario but on 10+
threads) and and I see results now on xfs, around 3 seconds (with some
variability of taking 0.3 seconds to 5 seconds sometimes) for writes
prior to this patchset vs. a pretty consistent 0.14 seconds with this
patchset. I ran the test scenario setup a few times but it'd be great
if someone else could also run it to verify it shows up on their
system too.

I set up xfs by following the instructions in the xfstests readme:
    # xfs_io -f -c "falloc 0 10g" test.img
    # xfs_io -f -c "falloc 0 10g" scratch.img
    # mkfs.xfs test.img
    # losetup /dev/loop0 ./test.img
    # losetup /dev/loop1 ./scratch.img
    # mkdir -p /mnt/test && mount /dev/loop0 /mnt/test

and then ran:
sudo sysctl -w vm.dirty_bytes=3D$((3276 * 1024 * 1024)) # roughly 20% of 16=
GB
sudo sysctl -w vm.dirty_background_bytes=3D$((1638*1024*1024)) # roughly
10% of 16 GB

and then ran this test program (ai-generated) https://pastebin.com/CbcwTXjq

I'll send out an updated v2 of this series.


Thanks,
Joanne

