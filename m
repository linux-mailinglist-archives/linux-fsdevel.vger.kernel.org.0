Return-Path: <linux-fsdevel+bounces-31118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13678991DBC
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 12:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF7AB1C20E38
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 10:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6FA172777;
	Sun,  6 Oct 2024 10:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XmsIJ8r4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833694C8C
	for <linux-fsdevel@vger.kernel.org>; Sun,  6 Oct 2024 10:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728210091; cv=none; b=mnnz5F8IUS8JDeUSAcLRJQagF9z66uXCpatGBo4vRHzhL9pPIgnJ5cfDoDPVMXwAGzP7VTTGKe6/Vl7F0f20EOrQcZwLx0AUHOHWbTQPgaav0AAeCjpFR//kY3Dbabo2s9AuJIYkES+WaVJhaA1QzExFZQT4Tj6b73h6XD16iRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728210091; c=relaxed/simple;
	bh=WfLhK/RQKFIEl06p7SEpp9K1VDNb7qgZKY6HMQATnmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBPAhxupSUOFBgbUJKLmjOo2Jd+guVNFLb+H8bOsR71P9XOnky2igGLYXk6bwj42zpFnrPLzUGMmzp7SN1lN4P4O2dznXTSUq3irDjjRvzvz5PXhKMKShM4MLMq9W0HcNGBYH2I1WUucACidl+MonGe01rWjN9DEjJ3DyOqIY/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XmsIJ8r4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04AD9C4CEC5;
	Sun,  6 Oct 2024 10:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728210091;
	bh=WfLhK/RQKFIEl06p7SEpp9K1VDNb7qgZKY6HMQATnmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XmsIJ8r42xxP9ZPOoHXiNosYQQFo5DnhF5YJ6d6dE3/VzX7afeUxTBd+cseZovVAQ
	 7WOlwJ/pqNVNOSlqr6oyJanz040mMhjLkJnKEhV50vEChHk1Kj7sHdgd4BOMJI8oN+
	 okJM2bNb1EHXKs4HCt6r2ze2IgJVeU3KXng7xLTEicoiIwilDnWyPMjYN70IsQXXYn
	 iAtpX/VJdlA7YQcX/mmQnxplRa7WA1xBkhGCsrrHFbo8K3TmwLfT1zHSKWvn0x/grb
	 Qr41iyzbZa6kWKPFL0zTUpFz3t32wyg9BTe6rdhdrqRRz4nxPbGhQfHXK0tp+Pu1fe
	 X/gGo8z/aZRpQ==
Date: Sun, 6 Oct 2024 12:21:27 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Jann Horn <jannh@google.com>
Subject: Re: [PATCH RFC 0/4] fs: port files to rcuref_long_t
Message-ID: <20241006-textzeilen-liehen-2e3083bd60bb@brauner>
References: <20241005-brauner-file-rcuref-v1-0-725d5e713c86@kernel.org>
 <CAHk-=wj7=Ynmk9+Fm860NqHu5q119AiN4YNXNJPt=6Q=Y=w3HA@mail.gmail.com>
 <CAHk-=wgwPwrao9Bq2SKDExPHXJAYO2QD1F-0C6JMtSaE1_T_ag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgwPwrao9Bq2SKDExPHXJAYO2QD1F-0C6JMtSaE1_T_ag@mail.gmail.com>

On Sat, Oct 05, 2024 at 03:01:45PM GMT, Linus Torvalds wrote:
> On Sat, 5 Oct 2024 at 14:42, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > and I think that might work, although the zero count case worries me
> > (ie 'fput twice').
> >
> > Currently we avoid the fput twice because we use that
> > "inc_not_zero()". So that needs some thinking about.
> 
> Actually, it's worse. Even the
> 
>         if (ret > 1)
> 
> case is dangerous, because we could have two or more threads doing
> that atomic_inc_return() on a dead file descriptor at the same time.
> 
> So that approach is just broken.

Iiuc, then we should retain the deadzone handling but should replace
atomic_long_add_negative() with atomic_long_add_negative_relaxed().

So I would add:

static inline __must_check bool rcuref_long_inc(rcuref_long_t *ref)
{
	/*
	 * Unconditionally increase the reference count with full
	 * ordering. The saturation and dead zones provide enough
	 * tolerance for this.
	 */
	if (likely(!atomic_long_add_negative(1, &ref->refcnt)))
		return true;

	/* Handle the cases inside the saturation and dead zones */
	return rcuref_long_get_slowpath(ref);
}

Or did I miss something else?

