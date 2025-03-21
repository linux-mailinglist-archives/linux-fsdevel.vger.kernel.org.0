Return-Path: <linux-fsdevel+bounces-44668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0733A6B3DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 05:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5115B18993CD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 04:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B0F1E7C0B;
	Fri, 21 Mar 2025 04:57:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168781E9B22
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Mar 2025 04:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742533046; cv=none; b=kBPKlyChv1bER75c3VzPMFoFM62cxL+NTtqT1D58rirb/A5nlM5FrSQ6fE1J7xNWgWsmNgoyRZNpgBg4lJn/FkLNRWHLWMyecTvb935VfSUVAr84MufPJwx+Gi3dl+YNQXN/2R1yNedPn5KFjYHhz6eVAnBYBOcqDiCGDujU7TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742533046; c=relaxed/simple;
	bh=rRmUba39KTsEHOeZzHpKubZyYOoZt779v9WaFak49HI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxbF9wyDEWwjvRclb6KFllxhQmEmFsmJcmux7m5ohVHiIRCwZTk88iFD8JeSa1U/git9KtdCgImVrI2Rwmm/O2hzybAJy/oCNH/sUMuPUm6ngcb2bYccxAFqPAq2MNzjdlf2YqIxgkR4k6ABH1HHLKah8TJ986lgvCiRU/KlwrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-222.bstnma.fios.verizon.net [173.48.82.222])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52L4u4WI017316
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 00:56:04 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 131D02E010B; Fri, 21 Mar 2025 00:56:04 -0400 (EDT)
Date: Fri, 21 Mar 2025 00:56:04 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Ritesh Harjani <ritesh.list@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        lsf-pc@lists.linux-foundation.org, david@fromorbit.com,
        leon@kernel.org, hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
        axboe@kernel.dk, joro@8bytes.org, brauner@kernel.org, hare@suse.de,
        willy@infradead.org, john.g.garry@oracle.com, p.raghav@samsung.com,
        gost.dev@samsung.com, da.gomez@samsung.com
Subject: Re: [LSF/MM/BPF TOPIC] breaking the 512 KiB IO boundary on x86_64
Message-ID: <20250321045604.GA1161423@mit.edu>
References: <Z9v-1xjl7dD7Tr-H@bombadil.infradead.org>
 <87o6xvsfp7.fsf@gmail.com>
 <20250320213034.GG2803730@frogsfrogsfrogs>
 <87jz8jrv0q.fsf@gmail.com>
 <20250321030526.GW89034@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250321030526.GW89034@frogsfrogsfrogs>

On Thu, Mar 20, 2025 at 08:05:26PM -0700, Darrick J. Wong wrote:
> > So now applications need to be careful to not submit any direct-io &
> > buffered-io in parallel with such above patterns on a raw block device,
> > correct? That is what I would like to confirm.
> 
> I think that's correct, and kind of horrifying if true.  I wonder if
> ->invalidate_folio might be a reasonable way to clear the uptodate bits
> on the relevant parts of a large folio without having to split or remove
> it?

FWIW, I've always recommended not mixing DIO and buffered I/O, either
for filesystems or block device.

> > >> And IIUC, what Linux recommends is to never mix any kind of direct-io
> > >> and buffered-io when doing I/O on raw block devices, but I cannot find
> > >> this recommendation in any Documentation? So can someone please point me
> > >> one where we recommend this?
> > 
> > And this ^^^

From the open(2) man page, in the NOTES section:

    Applications should avoid mixing O_DIRECT and normal I/O to the
    same file, and especially to overlap‐ ping byte regions in the
    same file.  Even when the filesystem correctly handles the
    coherency issues in this situation, overall I/O throughput is
    likely to be slower than using either mode alone.  Likewise,
    applications should avoid mixing mmap(2) of files with direct I/O
    to the same files.

As I recall, in the eary days Linux's safety for DIO and Bufered I/O
was best efforts, and other Unix system the recommendation to "don't
mix the streams" was far stronger.  Even if it works reliably for
Linux, it's still something I recommend that people avoid if at all
possible.

						- Ted

