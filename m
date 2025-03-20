Return-Path: <linux-fsdevel+bounces-44635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 835C0A6AE79
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 20:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D490D1890C10
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 19:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F08228C9D;
	Thu, 20 Mar 2025 19:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jB9rxHJg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9EB1E47C5;
	Thu, 20 Mar 2025 19:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742498777; cv=none; b=AbQFFPK/YTNC36BRi9CcSzrLRb5UMakwp2eqj0j0IAI+TnTnCEiFjMXjXBvMwc1ah3wQwGQftg7Pbd1wgHPIB/9nl3UPHIp0qY9nDnhTNyfFeZRYbOgNTCkjcJR3bHpV++YsxIPFlFKHQ7VxiHPOfkDtsuodoxTR+6+J+qU8rc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742498777; c=relaxed/simple;
	bh=19tfhp2GugR7eMrOHtnPn8YzV6Ano4p3UItGwPar+s4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=r/ABw7ZuGvRuRsgHSUvGaUhz2ArFAYIkrDd12626vq519DcvXvgUrGhLIGhdOFEgYBYFTkKYItR9vXdcIVxQ3Cmdsmj93MazDAPd2Bs8Uclvx2ngzJbwoY5VYVIyRzUlPnUu0imvStYQmoumxvD+iBB7dRhBB1G1tISdaZpNPVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jB9rxHJg; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-224100e9a5cso23668345ad.2;
        Thu, 20 Mar 2025 12:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742498775; x=1743103575; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IT5Y1CECgMcgiJ0AS3xtcoX9bxP9q8Li12z0Jmxks94=;
        b=jB9rxHJg2o8cpdELdEqNdTvrepiMrPkTpf5ZYlMoKj4s50DX7QBBlZGRGJGK7vt65C
         u7iiwX7zilCpjIlk6v/nHWY6eepgIEOGmEWOL81/XVM/2ap+/vaLXLpjG/J2nuaN8fIf
         1wfmi5/M25qz/TsJR6O5qZMLNXWGhsBi40lqsHOt+Qximz/BMKATKhtEP2p5/l8DJb+K
         AdFeou4oIfU4fMhcOpmNngBrpyOyB2wdsoU3wzTDdk97gapnKvgxLqYJHCYE1XsAgNoA
         0f/lNpuwS2LzGhyYuKoLqR9ffKRcV8ttIreW2f8O8oY5x5wLL516JwBZXwHkyvwrhMx7
         +goQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742498775; x=1743103575;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IT5Y1CECgMcgiJ0AS3xtcoX9bxP9q8Li12z0Jmxks94=;
        b=Rq7/la7bb2Q0UecbtuYCMWYQd7+20Rv7zVc8lpj469dYrDLnJzmlIz/uLAtO6TRuXo
         dty7g1jVbtJLKwE0A6ASjZSUnsXl7h+fCBQIu1BZOlm79znLUyDmjS1dt/BcGa6wQWc4
         SMratH3LmphryAAsvg+EPOas2RqRExo8PowaydKkqJkkE6fKghkamFABwF7h8qQYpyXP
         ZSb+eQhUud5ChsMr9fNzN+t1tduWbjbbe3M1s4l22TEqUGrLLZ/RYYhsS4Zf8zJExX/v
         nC7T6lLbbf+QYM5e3RkuanbMyseA4E5vSqIN318mhvh5rQw5KEnol6eTCbmkoOuaFCNK
         k79w==
X-Forwarded-Encrypted: i=1; AJvYcCVip3WmZnDfuGxEjE7m2P3pZgrCpzaRakqDE8BSnLZw+Lg9jMNhFOBZsBDemrRVzew7F+66tkuHB3kusA==@vger.kernel.org, AJvYcCXtJyHojoUTGdtxBobsoGnZb4FZPHGIqLC7xTQJm3ub8LFnahsjX+LkaQlCZnN9HwILKWWoRbGf1I02O/uiLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3eeC6V/1RnWtQ/d2TZd6ys1Kb/L7KwLQauL+ikEx5EpwG85U6
	qjm9fu6ilMnWhIhSLhQ9pCtKqCpz8kOguEM4dhjrdhp1frQ+J1VO
X-Gm-Gg: ASbGncteSZdodkH4flE9j5/c6zVcmN7t1px3XlnqU4XrJYGNlwl4FbXn2XIJQRFbtEI
	5WbYFU5vn27NDMSTMoGq17t7RB9TvWCjP1PGwjZ9hG1Avid8bC0bNiUo1XXFbsQsmNIWm5L9Y+T
	dKPgiwdq/Pd8bgclMU7GFNjzO2ZdLoD1u8zlxsadUP2ERXNhkzR7YQ5UzYAmk07FEJHvF5CpAtz
	m60d/6ukg8Z36UujVXu9g47DKX19qp6OURRE83oJX0TxZE9IMrKbdEGFAoCDTKYVCjGrtcS7rE5
	YJwRne1jQA4Kegi0W9S+QtA4KaUoD/2kYs4t5exVsCsbEzYG
X-Google-Smtp-Source: AGHT+IFiUbe6+CRoKA0l1QROXCFvcvYY/0q35paihFSYabz3ziCBZXR+Acwdt5E/e3qDJoE5kc+e6g==
X-Received: by 2002:a05:6a21:688:b0:1f5:7353:c303 with SMTP id adf61e73a8af0-1fe42f2cbf3mr1025749637.11.1742498774445;
        Thu, 20 Mar 2025 12:26:14 -0700 (PDT)
Received: from dw-tp ([171.76.82.198])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390611bd23sm186775b3a.96.2025.03.20.12.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 12:26:13 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-block@vger.kernel.org
Cc: lsf-pc@lists.linux-foundation.org, david@fromorbit.com, leon@kernel.org, hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk, joro@8bytes.org, brauner@kernel.org, hare@suse.de, willy@infradead.org, djwong@kernel.org, john.g.garry@oracle.com, p.raghav@samsung.com, gost.dev@samsung.com, da.gomez@samsung.com, Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] breaking the 512 KiB IO boundary on x86_64
In-Reply-To: <Z9v-1xjl7dD7Tr-H@bombadil.infradead.org>
Date: Fri, 21 Mar 2025 00:16:28 +0530
Message-ID: <87o6xvsfp7.fsf@gmail.com>
References: <Z9v-1xjl7dD7Tr-H@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Luis Chamberlain <mcgrof@kernel.org> writes:

> We've been constrained to a max single 512 KiB IO for a while now on x86_64.
> This is due to the number of DMA segments and the segment size. With LBS the
> segments can be much bigger without using huge pages, and so on a 64 KiB
> block size filesystem you can now see 2 MiB IOs when using buffered IO.
> But direct IO is still crippled, because allocations are from anonymous
> memory, and unless you are using mTHP you won't get large folios. mTHP
> is also non-deterministic, and so you end up in a worse situation for
> direct IO if you want to rely on large folios, as you may *sometimes*
> end up with large folios and sometimes you might not. IO patterns can
> therefore be erratic.
>
> As I just posted in a simple RFC [0], I believe the two step DMA API
> helps resolve this.  Provided we move the block integrity stuff to the
> new DMA API as well, the only patches really needed to support larger
> IOs for direct IO for NVMe are:
>
>   iomap: use BLK_MAX_BLOCK_SIZE for the iomap zero page
>   blkdev: lift BLK_MAX_BLOCK_SIZE to page cache limit

Maybe some naive questions, however I would like some help from people
who could confirm if my understanding here is correct or not.

Given that we now support large folios in buffered I/O directly on raw
block devices, applications must carefully serialize direct I/O and
buffered I/O operations on these devices, right?

IIUC. until now, mixing buffered I/O and direct I/O (for doing I/O on
/dev/xxx) on separate boundaries (blocksize == pagesize) worked fine,
since direct I/O would only invalidate its corresponding page in the
page cache. This assumes that both direct I/O and buffered I/O use the
same blocksize and pagesize (e.g. both using 4K or both using 64K).
However with large folios now introduced in the buffered I/O path for
block devices, direct I/O may end up invalidating an entire large folio,
which could span across a region where an ongoing direct I/O operation
is taking place. That means, with large folio support in block devices,
application developers must now ensure that direct I/O and buffered I/O
operations on block devices are properly serialized, correct?

I was looking at posix page [1] and I don't think posix standard defines
the semantics for operations on block devices. So it is really upto the
individual OS implementation, correct? 

And IIUC, what Linux recommends is to never mix any kind of direct-io
and buffered-io when doing I/O on raw block devices, but I cannot find
this recommendation in any Documentation? So can someone please point me
one where we recommend this?

[1]: https://pubs.opengroup.org/onlinepubs/9799919799/


-ritesh

>
> The other two nvme-pci patches in that series are to just help with
> experimentation now and they can be ignored.
>
> It does beg a few questions:
>
>  - How are we computing the new max single IO anyway? Are we really
>    bounded only by what devices support?
>  - Do we believe this is the step in the right direction?
>  - Is 2 MiB a sensible max block sector size limit for the next few years?
>  - What other considerations should we have?
>  - Do we want something more deterministic for large folios for direct IO?
>
> [0] https://lkml.kernel.org/r/20250320111328.2841690-1-mcgrof@kernel.org
>
>   Luis

