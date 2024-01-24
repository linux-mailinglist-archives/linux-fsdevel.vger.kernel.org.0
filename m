Return-Path: <linux-fsdevel+bounces-8798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D1D83B19C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 19:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 989721C23CD9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 18:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F814131E38;
	Wed, 24 Jan 2024 18:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dM7g1WyC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32636131743
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 18:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706122662; cv=none; b=OaSYvXRGoMnuhDRJjk5y4F2/fGto99f3MQ/WqsunfO8zuchioAm8ibc5wNCC3D9OW1IfzZ6/CB1e0MhcBxwbtSJFzQu7wjm+Lrc8SQZyw9T5j+qUbUICmNdMZieuTZNoEkLyc73ay6SQ4gkqdhv/FdC/DyOUHr1gaKDp4Xxna9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706122662; c=relaxed/simple;
	bh=JbibW8U25bNz/f8wJkz9E5pM/409HM7Q0ODyuc6AO9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dv+/pBMayyh7dEGSd1Mv69kXfzk3hJ8rZpEg7E0O657SbUqqQ76aSS+SguB2fRPzgq+I4AHdq2reDFeA+FFBQySRF9JXJNWLwDx14Hy6luwrxHiElkpPX1cOE2pWxn4BL6f5Qb+Mxgw7t/fyMhuvhTKVbp7Qov/a2OCNVIIsUyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dM7g1WyC; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-361a8bfa168so19957915ab.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 10:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706122659; x=1706727459; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dN/DcvuXwyp2yCQExIUGYH7ZCG5JTRWzNGVK64AipF8=;
        b=dM7g1WyC0ZlAX8G1QKMTEI74plEDR8SroJkqsn3vemEIAJh8JR8H5WlktpU0qPjy1w
         dJZ/3ykygHHmngrsQRA2xEZNiFlOT37iisb8b+qhaLIIlhZkc1OPaO2URgIQd8KYQuXD
         D1pAXOPmeMQUmhcFs2zSWPd3QH2sKJ8h3LyAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706122659; x=1706727459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dN/DcvuXwyp2yCQExIUGYH7ZCG5JTRWzNGVK64AipF8=;
        b=dHF5mIy02sNHicYHZzNO50FW0gwbsZEMB+ZXMqxaShANKaaUek0R0UA556KsFvFf9W
         RkNTl5xuBH5NvXvC+uHDOqKnK6+mEapM6rjQG4XquZVIj2+NVgRP7WcTgv3W9oXeB2+C
         ylCZbqnDTRMijf7OjhEIYYMLkXL6f7n1+HhXFCtpN5ynEt7aDQbNP12rpUMCG8shBX7o
         qYD6TJo2POtglmnluDliizPTaZNCh/ALNdQwoHeMpKT2683G7FdlSESKoagG4h70YdqL
         RiwgH+K3yVsD3tOE32JGiWANISmzqzQL0RnStPi4Z5nUvGMHKhpdFjX9DERgvgt9QbNk
         JxVQ==
X-Gm-Message-State: AOJu0YyVQsY29BURcSkL9i05znuh8N5tPXA90AzyM+Jdgc6CumYBSvo4
	CNRDk02t6QUi+w4MeANwdgiHABakp3OceCcedjf/MnKPaMyjbrjQZL/B4SMVDw==
X-Google-Smtp-Source: AGHT+IE9qMB02EEUOxq/2jciZEyscL4XjQWdCqiITyqm3a3wtmsxRnL15cr80ulcxNXnl3HXms9o/Q==
X-Received: by 2002:a05:6e02:16c7:b0:35f:ff56:c0fd with SMTP id 7-20020a056e0216c700b0035fff56c0fdmr2473407ilx.14.1706122659347;
        Wed, 24 Jan 2024 10:57:39 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q22-20020a631f56000000b005cfd6b98d9bsm4724604pgm.87.2024.01.24.10.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 10:57:38 -0800 (PST)
Date: Wed, 24 Jan 2024 10:57:38 -0800
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kevin Locke <kevin@kevinlocke.name>,
	John Johansen <john.johansen@canonical.com>,
	Kentaro Takeda <takedakn@nttdata.co.jp>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Josh Triplett <josh@joshtriplett.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [6.8-rc1 Regression] Unable to exec apparmor_parser from
 virt-aa-helper
Message-ID: <202401240958.8D9A11E8E@keescook>
References: <ZbE4qn9_h14OqADK@kevinlocke.name>
 <202401240832.02940B1A@keescook>
 <CAHk-=wgJmDuYOQ+m_urRzrTTrQoobCJXnSYMovpwKckGgTyMxA@mail.gmail.com>
 <CAHk-=wijSFE6+vjv7vCrhFJw=y36RY6zApCA07uD1jMpmmFBfA@mail.gmail.com>
 <CAHk-=wiZj-C-ZjiJdhyCDGK07WXfeROj1ACaSy7OrxtpqQVe-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiZj-C-ZjiJdhyCDGK07WXfeROj1ACaSy7OrxtpqQVe-g@mail.gmail.com>

On Wed, Jan 24, 2024 at 09:10:58AM -0800, Linus Torvalds wrote:
> On Wed, 24 Jan 2024 at 08:54, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Hmm. That whole thing is disgusting. I think it should have checked
> > FMODE_EXEC, and I have no idea why it doesn't.
> 
> Maybe because FMODE_EXEC gets set for uselib() calls too? I dunno. I
> think it would be even better if we had the 'intent' flags from
> 'struct open_flags' available, but they aren't there in the
> file_open() security chain.

I've tested AppArmor, and this works fine:

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 7717354ce095..ab104ce05f96 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -470,7 +470,7 @@ static int apparmor_file_open(struct file *file)
 	 * implicit read and executable mmap which are required to
 	 * actually execute the image.
 	 */
-	if (current->in_execve) {
+	if (file->f_flags & __FMODE_EXEC) {
 		fctx->allow = MAY_EXEC | MAY_READ | AA_EXEC_MMAP;
 		return 0;
 	}

Converting TOMOYO is less obvious to me, though, as it has a helper that
isn't strictly always called during open(). I haven't finished figuring
out the call graphs for it...

-- 
Kees Cook

