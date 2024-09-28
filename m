Return-Path: <linux-fsdevel+bounces-30304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE8B989188
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Sep 2024 23:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C46B9285E2E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Sep 2024 21:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A4E185B71;
	Sat, 28 Sep 2024 21:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKee8TD0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DE03C0C;
	Sat, 28 Sep 2024 21:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727558251; cv=none; b=jWC8tlt9iXGjiL8cSJ6A2cOYgGF/8euw/7IMcIlLYs5BbeHPBp1cvRZ6uybeKXLNwt6xVcuTNOpwB7V6Tr/cdezYdJkbSiSbU76PsirxtyaJ1H+pPEW9bdPSHyU8B3pQcAdhHEL9SZrtzpQAcTEzCUbLbvhPDduk0/BOJowv7JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727558251; c=relaxed/simple;
	bh=D0r2pMAslanB4R9KKI1cz+nAetpbVmkKyvYYI304mqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VdIGgscl/u7JWFhKMUC9T5u/R3125gc+l9wPpgcccT7Os60mxRdZWqY1k0y9YCxbJuFCnzPgk2hSShZjCLuFYkhWdn2noP6tnr58mZkf/n+8Un3GSkw35tUu0T4ItyEETp3ltJG6KWJL69KA0hqv9i2z0DoCl3JwZuswsNkVMCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKee8TD0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DAFFC4CEC3;
	Sat, 28 Sep 2024 21:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727558250;
	bh=D0r2pMAslanB4R9KKI1cz+nAetpbVmkKyvYYI304mqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RKee8TD0HOzA1sEOmQy+o1YoprUqIz5Nx9I6rrFKrUGy1HZUkPMmOjKnCl3+9maWg
	 1GdsNYYM0sAY/FVkiThXRc3afmVOcZcblIxwyo55OD2/2r3pt+VjmF531qy1ec/AF/
	 nJ4AaI0nancNp+mrRBLDnG3AJJeb4kjXv2FtVJ/VHHglFEDhz9o/mxI/jlnp5X2DlS
	 5Ct0im2UfESxxYEUowIKaR8/cSYh6y1p9AT6lp4oAwdkIRqBdVlWkO89X7OXf1CR2j
	 eKkhJhuoCnM9eYUO/a3XQ19tYfht2hhlkKf5OKlyJQPedvRhQ73TS2vCTd6BMSc8ZQ
	 cA5757sItzN/g==
Date: Sat, 28 Sep 2024 14:17:30 -0700
From: Kees Cook <kees@kernel.org>
To: Alejandro Colomar <alx@kernel.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org,
	torvalds@linux-foundation.org, justinstitt@google.com,
	ebiederm@xmission.com, alexei.starovoitov@gmail.com,
	rostedt@goodmis.org, catalin.marinas@arm.com,
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	audit@vger.kernel.org, linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org, bpf@vger.kernel.org,
	netdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v7 5/8] mm/util: Fix possible race condition in kstrdup()
Message-ID: <202409281414.487BFDAB@keescook>
References: <20240817025624.13157-1-laoar.shao@gmail.com>
 <20240817025624.13157-6-laoar.shao@gmail.com>
 <w6fx3gozq73slfpge4xucpezffrdioauzvoscdw2is5xf7viea@a4doumg264s4>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w6fx3gozq73slfpge4xucpezffrdioauzvoscdw2is5xf7viea@a4doumg264s4>

On Sat, Aug 17, 2024 at 10:48:15AM +0200, Alejandro Colomar wrote:
> Hi Yafang,
> 
> On Sat, Aug 17, 2024 at 10:56:21AM GMT, Yafang Shao wrote:
> > In kstrdup(), it is critical to ensure that the dest string is always
> > NUL-terminated. However, potential race condidtion can occur between a
> > writer and a reader.
> > 
> > Consider the following scenario involving task->comm:
> > 
> >     reader                    writer
> > 
> >   len = strlen(s) + 1;
> >                              strlcpy(tsk->comm, buf, sizeof(tsk->comm));
> >   memcpy(buf, s, len);
> > 
> > In this case, there is a race condition between the reader and the
> > writer. The reader calculate the length of the string `s` based on the
> > old value of task->comm. However, during the memcpy(), the string `s`
> > might be updated by the writer to a new value of task->comm.
> > 
> > If the new task->comm is larger than the old one, the `buf` might not be
> > NUL-terminated. This can lead to undefined behavior and potential
> > security vulnerabilities.
> > 
> > Let's fix it by explicitly adding a NUL-terminator.
> > 
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > ---
> >  mm/util.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/util.c b/mm/util.c
> > index 983baf2bd675..4542d8a800d9 100644
> > --- a/mm/util.c
> > +++ b/mm/util.c
> > @@ -62,8 +62,14 @@ char *kstrdup(const char *s, gfp_t gfp)
> >  
> >  	len = strlen(s) + 1;
> >  	buf = kmalloc_track_caller(len, gfp);
> > -	if (buf)
> > +	if (buf) {
> >  		memcpy(buf, s, len);
> > +		/* During memcpy(), the string might be updated to a new value,
> > +		 * which could be longer than the string when strlen() is
> > +		 * called. Therefore, we need to add a null termimator.
> > +		 */
> > +		buf[len - 1] = '\0';
> > +	}
> 
> I would compact the above to:
> 
> 	len = strlen(s);
> 	buf = kmalloc_track_caller(len + 1, gfp);
> 	if (buf)
> 		strcpy(mempcpy(buf, s, len), "");
> 
> It allows _FORTIFY_SOURCE to track the copy of the NUL, and also uses
> less screen.  It also has less moving parts.  (You'd need to write a
> mempcpy() for the kernel, but that's as easy as the following:)
> 
> 	#define mempcpy(d, s, n)  (memcpy(d, s, n) + n)
> 
> In shadow utils, I did a global replacement of all buf[...] = '\0'; by
> strcpy(..., "");.  It ends up being optimized by the compiler to the
> same code (at least in the experiments I did).

Just to repeat what's already been said: no, please, don't complicate
this with yet more wrappers. And I really don't want to add more str/mem
variants -- we're working really hard to _remove_ them. :P

-Kees

-- 
Kees Cook

