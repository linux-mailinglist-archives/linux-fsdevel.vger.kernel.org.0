Return-Path: <linux-fsdevel+bounces-16777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 911F78A26E2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 08:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2AC01C22123
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 06:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA09481C2;
	Fri, 12 Apr 2024 06:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IX+9AUAk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1E547A5D;
	Fri, 12 Apr 2024 06:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712904268; cv=none; b=bl09+sSqni1+EjGJq8Dx46pNHa10NxSkLWcXKjZk7XbdqgPjrGhT2MYgVYawUKm50KWD+E9vdIioAktZojFrxP3JjSmSedEK3598blWX5JCzgcX1vQLHS78q18Ld/AE0VGp2LEzU7A+2GLpqiZwMni7VQS6r2K3jdTQrkVAe+Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712904268; c=relaxed/simple;
	bh=p/wEHDi9WkTon8K9W0QGAWN2QZ/PbnxknsFcFz7yp9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c9v72qSIL71q4ivhPBk/Er0nxHd9btG9oE/sUJMDAT6wpY0TXfPsZLg2mfzchOGAEggYW74vrMvTtYyAchxmdQCrIrLI3yxRGu9KTNwEpTu19qm29/O5x8Vlx/AMUKajBqXUmjHt92Z0km/du8J5+8c2I8xcM2f2Cn613+TkGbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IX+9AUAk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B65E1C2BBFC;
	Fri, 12 Apr 2024 06:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712904268;
	bh=p/wEHDi9WkTon8K9W0QGAWN2QZ/PbnxknsFcFz7yp9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IX+9AUAkW6h0r9HL+ctHFkv4loKhrTf5AD7L3futOE2ncVsLk687T62Vp+OMIugqk
	 s4GO23iJsYZAyIP4YPY3+Tu53HBDyXXK1xg1iqpfglR/CZpRfJ5ezdcgU8yw0FMnh2
	 eMoq9twdsdmSxmJGVd8x3z0YpCELMTyi4P5aVEerXuaXzAgppM77V4vzt6JfKV2/bi
	 rGywNo5jF6EWnaQvYVg3RjmF19Cc9TPlEYSZv2GQ712+lf8j3gHCUuDNxiwWfRTRlD
	 qzg2GIkd92R1n9qnC+z5K2dNCKm+qaJoesYyzHv1vFL0BMfWRqWpGsd+Rr3xZ7I7zT
	 gNAXAs8Rs3IQA==
Date: Fri, 12 Apr 2024 08:44:21 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Charles Mirabile <cmirabil@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andrew Lutomirski <luto@kernel.org>, Peter Anvin <hpa@zytor.com>
Subject: Re: [PATCH] vfs: relax linkat() AT_EMPTY_PATH - aka flink() -
 requirements
Message-ID: <20240412-zander-graustufen-bf63bbaa88fd@brauner>
References: <20240411001012.12513-1-torvalds@linux-foundation.org>
 <CAHk-=wiaoij30cnx=jfvg=Br3YTxhQjp4VWRc6=xYE2=+EVRPg@mail.gmail.com>
 <20240411-alben-kocht-219170e9dc99@brauner>
 <CAHk-=wjrPDx=f5OSnQVbbJ4id6SZk-exB1VW9Uz3R7rKFvTQeQ@mail.gmail.com>
 <CABe3_aGbsPHY9Z5B9WyVWakeWFtief4DpBrDxUiD00qk1irMrg@mail.gmail.com>
 <CABe3_aGGf7kb97gE4FdGmT79Kh5OhbB_2Hqt898WZ+4XGg6j4Q@mail.gmail.com>
 <CABe3_aE_quPE0zKe-p11DF1rBx-+ecJKORY=96WyJ_b+dbxL9A@mail.gmail.com>
 <CAHk-=wjuzUTH0ZiPe0dAZ4rcVeNoJxhK8Hh_WRBY-ZqM-pGBqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjuzUTH0ZiPe0dAZ4rcVeNoJxhK8Hh_WRBY-ZqM-pGBqg@mail.gmail.com>

On Thu, Apr 11, 2024 at 11:13:53AM -0700, Linus Torvalds wrote:
> On Thu, 11 Apr 2024 at 10:35, Charles Mirabile <cmirabil@redhat.com> wrote:
> >
> > And a slightly dubious addition to bypass these checks for tmpfiles
> > across the board.
> 
> Does this make sense?
> 
> I 100% agree that one of the primary reasons why people want flink()
> is that "open tmpfile, finalize contents and permissions, then link
> the final result into the filesystem".
> 
> But I would expect that the "same credentials as open" check is the
> one that really matters.

Yes. There's no need to give O_TMPFILE special status there. We also end
up with a collection of special-cases which is just unpleasant.

