Return-Path: <linux-fsdevel+bounces-67390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C183C3DBB1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 00:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCFD6188AE97
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 23:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0373306B1A;
	Thu,  6 Nov 2025 23:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xd/KXJsF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4517B23B605
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Nov 2025 23:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762470518; cv=none; b=MvsP981WkDBWdbXwB26NxOMSfAxOA02X1VemqGRgP35uTOJfdkPd9aAC+Ob52HzeVOfvDId5Csevx1leccj9ArWXBrRz7OjWoyYoW86XzaX9Ttk5DoiJrGAoxkTngLoQf9BV/hAQWYJOY/LaoMjACHORqDq4RoZIPuzlmv5ZqwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762470518; c=relaxed/simple;
	bh=FiL4pPlx+52QgSIPWJWIiNXFOW1iKBav3oMBElAZ6cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+x1kR3QaYIyIUroN/rx+IfYpYS6siMtxaHYIXYNTw8IAm7Z9RrRnKLvxaktk1AqBYtyH+bcGzr9PZkX1J5o6LmQRIcupINr4ieXUkqRu//ra711yhEMblJiHe+9ZVoXVQh7AKZuOqPo1PCe0bp+hEKVu5LFvbriqZzpu0EUeRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xd/KXJsF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8ADC19423;
	Thu,  6 Nov 2025 23:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762470517;
	bh=FiL4pPlx+52QgSIPWJWIiNXFOW1iKBav3oMBElAZ6cY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xd/KXJsFlpejA/WaJz4GpDapTCJTAzcgvU/x51R8pezLS00aZJ45kmeL4K+mJv2Oj
	 NZ3Ol7jf+tqSudDhAA1TjghRbmsshTNp9o2LX5cxttL5TMoFkQU/V2Dau5Di7G7bga
	 5m7fCpAjqjJpGdDpgIoxVYdecjvPcBF+FHeRPuJvpLuvTChW6dUEgDT7iIl6mjjXA6
	 iuWsI6ToSYiZyqQEsMopGqLgAiNkzd7vXQiqzjAa8/K3B/drYdM/6fEp2jfFtJS1hz
	 UJO9Ys4oCvSR89CDsgdnoq+bLhVk0qIElYn+jyWrnJ6szSVE+AhK27hL+iTIPRzSt+
	 7h3qoSVQ0hLhw==
Date: Thu, 6 Nov 2025 15:08:36 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, hch@infradead.org, bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 1/8] iomap: account for unaligned end offsets when
 truncating read range
Message-ID: <20251106230836.GS196362@frogsfrogsfrogs>
References: <20251104205119.1600045-1-joannelkoong@gmail.com>
 <20251104205119.1600045-2-joannelkoong@gmail.com>
 <20251105012721.GD196362@frogsfrogsfrogs>
 <CAJnrk1aMZPoRKgPA39pqjHvH8zPsu0vhqpoVmPdyHYEo8Nszww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1aMZPoRKgPA39pqjHvH8zPsu0vhqpoVmPdyHYEo8Nszww@mail.gmail.com>

On Thu, Nov 06, 2025 at 09:08:47AM -0800, Joanne Koong wrote:
> On Tue, Nov 4, 2025 at 5:27 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Tue, Nov 04, 2025 at 12:51:12PM -0800, Joanne Koong wrote:
> > > The end position to start truncating from may be at an offset into a
> > > block, which under the current logic would result in overtruncation.
> > >
> > > Adjust the calculation to account for unaligned end offsets.
> >
> > When would the read offset be in the middle of a block?  My guess is
> > that happens when fuse reads some unaligned number of bytes into a folio
> > and then stops?  Can this also happen with inlinedata mappings?  I think
> > those are the only two conditions where iomap isn't dealing with
> > fsblock-aligned mappings and/or IOs.
> >
> 
> The end offset may be in the middle of a block if the filesystem sets
> an unaligned mapping size (the length of the read used is derived from
> iomap_length(), which considers iter->iomap.length which is set by the
> filesystem's ->iomap_begin() handler). This is what we saw on erofs
> for inline mappings for example in this syzbot report [1].
> 
> [1] https://lore.kernel.org/linux-fsdevel/68ca71bd.050a0220.2ff435.04fc.GAE@google.com/

Ahh ok.  Then I've understood this patch sufficiently. :)
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> 
> Thanks,
> Joanne
> 
> > (Obviously the pagecache copies themselves aren't required to be
> > aligned)
> >
> > --D
> 

