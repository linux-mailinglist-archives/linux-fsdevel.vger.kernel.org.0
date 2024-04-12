Return-Path: <linux-fsdevel+bounces-16775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCAE8A26C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 08:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED72F287CD1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 06:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD5C328A0;
	Fri, 12 Apr 2024 06:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObsexNNh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CAC46537;
	Fri, 12 Apr 2024 06:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712904076; cv=none; b=WjZqvXtvcHsHJ9Ny6KhO5Io1V5Fc0B5CvEMNcbnlFxDxB6XDUElKiTr7RbewovJ0jV2QkhPVgtzcVPjiOHbf1QojVsrS9cQtUCL11MfEsW/xnaWOxsCs1cuqyhTd038ZcTrQZ+TG/u8ySS6sTXOrTF8pj+NZcxw4uVvoQS3KGuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712904076; c=relaxed/simple;
	bh=yVuvk9J4ju/MLmWKDilwX/DtLSYxVCXTim0efesibtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alhxyq5sFclCDbbaQR54HhGNnpk8FUweYmRS+zTN3xcwW+APlCDUnunXlM5u0hNhIfiPkKBTEs3EVsNyqiBsL/8DSxNxbxQAtnPfOiHVij9zPWkaUMSkO+/wwRyWFLbx1Q67KF1BKMbcytAf8VHpjT7ndH8D2aDdVZmOWEoGLKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObsexNNh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB46C2BBFC;
	Fri, 12 Apr 2024 06:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712904076;
	bh=yVuvk9J4ju/MLmWKDilwX/DtLSYxVCXTim0efesibtc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ObsexNNh/MykjBNnn4SPa5J4Vw83Sc01t5KlHy8x9y1kPOUqqlRxAk+ZURiFuP6Iw
	 0M/td8kbvDqcjSszKu+PADPzfBUNHKVYw1KmGPqGxdk+xhGdkKq6sJ4ECdcP7dUfUl
	 RKCJKCEPPb+dTuEMSClietcAmU5LL32+voHWx/9F/FKNbF6/5ljU/CjPJQsbQohusl
	 Dts3hI+jLS3wiiYMtaNX/BRIidbU6zfvbBJp6BhsPnrsftoQSENjEuLE2nMKIsg7yz
	 o04ZVb+ONVWCPfU0sb1AJngCo3+BlYEYKJ2VI4Qu50VaxAx4ilN1f6003wMaHwZ7WE
	 6K6EAn5LtOi4w==
Date: Fri, 12 Apr 2024 08:41:09 +0200
From: Christian Brauner <brauner@kernel.org>
To: Charles Mirabile <cmirabil@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andrew Lutomirski <luto@kernel.org>, Peter Anvin <hpa@zytor.com>
Subject: Re: [PATCH] vfs: relax linkat() AT_EMPTY_PATH - aka flink() -
 requirements
Message-ID: <20240412-gefroren-abzug-49996c3ccc13@brauner>
References: <20240411001012.12513-1-torvalds@linux-foundation.org>
 <CAHk-=wiaoij30cnx=jfvg=Br3YTxhQjp4VWRc6=xYE2=+EVRPg@mail.gmail.com>
 <20240411-alben-kocht-219170e9dc99@brauner>
 <CAHk-=wjrPDx=f5OSnQVbbJ4id6SZk-exB1VW9Uz3R7rKFvTQeQ@mail.gmail.com>
 <CABe3_aGbsPHY9Z5B9WyVWakeWFtief4DpBrDxUiD00qk1irMrg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABe3_aGbsPHY9Z5B9WyVWakeWFtief4DpBrDxUiD00qk1irMrg@mail.gmail.com>

On Thu, Apr 11, 2024 at 12:44:46PM -0400, Charles Mirabile wrote:
> On Thu, Apr 11, 2024 at 12:15 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Thu, 11 Apr 2024 at 02:05, Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > I had a similar discussion a while back someone requested that we relax
> > > permissions so linkat can be used in containers.
> >
> > Hmm.
> >
> > Ok, that's different - it just wants root to be able to do it, but
> > "root" being just in the container itself.
> >
> > I don't think that's all that useful - I think one of the issues with
> > linkat(AT_EMPTY_PATH) is exactly that "it's only useful for root",
> > which means that it's effectively useless. Inside a container or out.
> >
> > Because very few loads run as root-only (and fewer still run with any
> > capability bits that aren't just "root or nothing").
> >
> > Before I did all this, I did a Debian code search for linkat with
> > AT_EMPTY_PATH, and it's almost non-existent. And I think it's exactly
> > because of this "when it's only useful for root, it's hardly useful at
> > all" issue.
> >
> > (Of course, my Debian code search may have been broken).
> >
> > So I suspect your special case is actually largely useless, and what
> > the container user actually wanted was what my patch does, but they
> > didn't think that was possible, so they asked to just extend the
> > "root" notion.
> >
> Yes, that is absolutely the case. When Christian poked holes in my
> initial submission, I started working on a v2 but haven't had a chance
> to send it because I wanted to make sure my arguments etc were
> airtight because I am well aware of just how long and storied the
> history of flink is. In the v2 that I didn't post yet, I extended the
> ability to link *any* file from only true root to also "root" within a
> container following the potentially suspect approach that christian
> suggested (I see where you are coming from with the unobvious approach

I'm sorry, what is suspect about my approach? Your patch in [1] lowered
the capability checks to ns_capable(current_user_ns(), CAP_DAC_READ_SEARCH).
That's very much wrong because it means root in an unprivileged
container could linkat() any file descriptor including any opened by
real root. The permission needs to be tied to the opener of the file.
Otherwise that's guaranteed to break security assumptions. Whereas my
patch avoids that.

[1]: https://lore.kernel.org/all/20231110170615.2168372-2-cmirabil@redhat.com

