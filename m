Return-Path: <linux-fsdevel+bounces-63671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B670BCA2F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 09 Oct 2025 18:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A9DF834FD0E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 16:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99ADF224AFA;
	Thu,  9 Oct 2025 16:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPUGXPax"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1F1205E25;
	Thu,  9 Oct 2025 16:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760027317; cv=none; b=anyo8Ub1qaGcXQX23fDWYVN3Hpa6YcLIYSUlfyFLnFvif85Ybc0FVGJ3IynxAL6DfO11cfnr6vRutpayFdsiGA5L8t5hVRDy33n2LaURVJqTXS8nLdUUcWJy1yNQJXXk4nIR3ZeBA7tRZOkNrzqmyZL55UONqt/elFZu6JIVtU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760027317; c=relaxed/simple;
	bh=2wArb6McKN8XDi7aNFLZi+tNZ6xI/BBBQekeTD7ykeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RkT2EiweW1yDqPqDRuLiCPfKftI8MDYIYarz9MvRej4dqrLzIRf4VzcbP2h3tl1KzsQlQDrMYMY/PTSGW/jCEdk4BV9/6NNR/GBG5sOz/IE+3uQs8ByIwNpAlPWep1xwYLBY8YfzLK9SZCSdQaG+2F1UYTPK8gLsY8VpJVyaXaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPUGXPax; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1479BC4CEE7;
	Thu,  9 Oct 2025 16:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760027316;
	bh=2wArb6McKN8XDi7aNFLZi+tNZ6xI/BBBQekeTD7ykeI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LPUGXPax0HqpgV/RqSODMWwUBKp8JeXUVKMeqW3DaYCo3X6O/7K0oe5igbMZeNAuQ
	 9DOQ6JV9t4c1ESegbQp2A9t5UABdzoCuHTH4A9UXmRVoWY8tJBkmHNJ+rZgkXMxs0O
	 h2rP6yYfrsz6cq/D2iJDZSXcOMdslwjWdslCdjN7hEF4YlZhtjWaLeC3cxGWJzmBPn
	 C3CqXBOd9s95UylE92RPRNjo6OkZmFz7bcpItGI8lG3Zvj7B+pkDFWBvTDCubw4ERc
	 +AC8Z93KRy9IKg0Zaecfs/sf3AVXYvfwWv9PucFN+jAkTydo9c0kI9fx9ueP3KuEuk
	 IGgSCwgQbwAjQ==
Received: by pali.im (Postfix)
	id B7AA556D; Thu,  9 Oct 2025 18:28:31 +0200 (CEST)
Date: Thu, 9 Oct 2025 18:28:31 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: linkinjeon@kernel.org, sj1557.seo@samsung.com, yuezhang.mo@sony.com,
	viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com
Subject: Re: [PATCH] exfat: fix out-of-bounds in exfat_nls_to_ucs2()
Message-ID: <20251009162831.ullg2fxcpkhcsnkh@pali>
References: <20251006114507.371788-1-aha310510@gmail.com>
 <20251008173935.4skifawm57zqpsai@pali>
 <CAO9qdTFk94yDCMAuTkx5yW9VXYExWuhgpi0X15C5F7e5DQgibA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO9qdTFk94yDCMAuTkx5yW9VXYExWuhgpi0X15C5F7e5DQgibA@mail.gmail.com>
User-Agent: NeoMutt/20180716

On Thursday 09 October 2025 18:05:26 Jeongjun Park wrote:
> Hi Pali
> 
> Pali Rohár <pali@kernel.org> wrote:
> >
> > Hello!
> >
> > On Monday 06 October 2025 20:45:07 Jeongjun Park wrote:
> > > After the loop that converts characters to ucs2 ends, the variable i
> > > may be greater than or equal to len.
> >
> > It is really possible to have "i" greater than len? Because I do not see
> > from the code how such thing could happen.
> >
> > I see only a case when i is equal to len (which is also overflow).
> >
> > My understanding:
> > while-loop condition ensures that i cannot be greater than len and i is
> > increased by exfat_convert_char_to_ucs2() function which has upper bound
> > of "len-i". So value of i can be increased maximally by (len-i) which
> > could lead to maximal value of i to be just "len".
> >
> > > However, when checking whether the
> > > last byte of p_cstring is NULL, the variable i is used as is, resulting
> > > in an out-of-bounds read if i >= len.
> > >
> > > Therefore, to prevent this, we need to modify the function to check
> > > whether i is less than len, and if i is greater than or equal to len,
> > > to check p_cstring[len - 1] byte.
> > >
> > > Cc: <stable@vger.kernel.org>
> > > Reported-by: syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=98cc76a76de46b3714d4
> > > Fixes: 370e812b3ec1 ("exfat: add nls operations")
> > > Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> > > ---
> > >  fs/exfat/nls.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
> > > index 8243d94ceaf4..a52f3494eb20 100644
> > > --- a/fs/exfat/nls.c
> > > +++ b/fs/exfat/nls.c
> > > @@ -616,7 +616,7 @@ static int exfat_nls_to_ucs2(struct super_block *sb,
> > >               unilen++;
> > >       }
> > >
> > > -     if (p_cstring[i] != '\0')
> > > +     if (p_cstring[min(i, len - 1)] != '\0')
> >
> > What about "if (i < len)" condition instead?
> >
> > The p_cstring is the nul term string and my understanding is that the
> > "p_cstring[i] != '\0'" is checking that i is at position of strlen()+1.
> > So should not be "if (i < len)" the same check without need to
> > dereference the p_cstring?
> >
> 
> Thank you for the detailed explanation! I misunderstood.
> 
> In summary, since the variable i can never be greater than len, we don't
> need to consider this case. Therefore, if i is less than len, we can
> determine that an nls loss has occurred.
> 
> I think that under normal nls conditions, i should be equal to len
> immediately after the while loop terminates, so changing the condition
> here to "if (i != len)" would be a better way to make this clear.
> 
> This way, we can check for an nls loss without dereferencing p_cstring,
> and we can clearly indicate that i should be equal to len when the while
> loop terminates. What do you think?
> 
> Regards,
> Jeongjun Park

Hello, yes, this is how I understood what is the code doing and how to
simple fix this reported problem.

