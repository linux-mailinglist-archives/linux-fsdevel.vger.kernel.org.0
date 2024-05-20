Return-Path: <linux-fsdevel+bounces-19738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 831C28C97F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 04:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 230BA1F21E32
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 02:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F322DC2FD;
	Mon, 20 May 2024 02:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RC6RLKlP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BFF6AB8
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 02:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716172782; cv=none; b=hoFmUNiP1qNsq/C9v5zCQluJgAAi7VOe0q/iwqD2Nn1wPiV7xlkZ+vW7HxqKmuAhTFMg6UQvwVGyNr8OsgeP879JcxBs+OqlWdBuDe3AUGrnbP7T5CFqOHHcdWZ+MVycNnnIycZyng8OEYKTSK+Hu7AFXzlBvccngKPDEQQQyLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716172782; c=relaxed/simple;
	bh=Bhzmt83JZJ7YbBBVl7j9UCoBQNog5AENdsi/u2ZQ81w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXS8k2U5pY8QxVaQ+zzmHZx3FOWgcLdNoRFQA/9A9jVB2H8PvyMpXTbE8N5JKtgF/yKovZ0MMicBrNuVSsW1sed8hO/t4Ccpn6Nsti/W5lmH5Zw5nEJsqLQR5GBB83ny5NCnT8oYLwrK8yQSrKBexHA5H6U7+izfvKTvVqt9z+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RC6RLKlP; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1eeabda8590so56271935ad.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 May 2024 19:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716172780; x=1716777580; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6rTDBlCNlynymCY0SceyeFw42XoD5sBEGAEjkXsg060=;
        b=RC6RLKlPhVmGkxXWgtKNSM+ScqX1eFP+k2QZcWRBN9GYrdB85SXKRh072Xd45MZCxE
         fEHAOqqEjQiSIgA1CguclJPKBum2BlVVnb806xDHBOgYRznvHGIgxwOpTQS8uAaDmqoV
         Jml7yYLXPA3rGe8iRN8JA4zD/BrBFNAOo8seI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716172780; x=1716777580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rTDBlCNlynymCY0SceyeFw42XoD5sBEGAEjkXsg060=;
        b=BwPF7KZ2kuQEQPryh443uiEJPSdBNhPqNAfgZA3svK6qm16L3CK+cl5Tp98Maa5nyt
         KrgH4oWj+bH8t1lHh4sy+rsaO4/C+4KA36bBboGWpMV21Di0yMl4y9jdJq7+XKfcjUaa
         0eUPdWvm13t8VGWqEkwCF3MvJizYWmlDDsisgFOrWruTt01pb8oJLuZWyxMyE6GR6xe5
         hQBN9QtV1JMizY2fmNBcHu2OKAKcaNYGOQCXl8hX1vylxBd9c01h8UnEYkf9JMTi1BMa
         r+VYP/yH93mfF/1xL1hYCKZDwTQUe9frgsLIS5DDPkp+rdM1E6N91hz7OUr9hkjoggh7
         K+oQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbo6bpE3/yaq6OjoOLBChPPE9aBYM3LcfCV54CBWt52OnrbkyEsBGhnuT5mP37k9ifIafBRLu05vOJXWAzAPoc5h5WXz03SVK5XMT3EQ==
X-Gm-Message-State: AOJu0YzQcfVD6XjO67MFR6M4uuHYBfrpck66AUNFXjH2FhY4p+wSt7gs
	diUHLrIASpTgMGnteetqZF0pG+lfW/ohD4j/Z/BTlMWU8JKneC2YZ+uA8p4CzQ==
X-Google-Smtp-Source: AGHT+IFS+M442UZQ/j1zlqi20uZ+ipUZA3R+bFtoseCPoe4S0YNUA9TI6FC3wI5ePXaO8d8JsgwJjw==
X-Received: by 2002:a05:6a00:a26:b0:6f3:eaa2:539f with SMTP id d2e1a72fcca58-6f4e02cada1mr33633442b3a.16.1716172780342;
        Sun, 19 May 2024 19:39:40 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f67a1b1c17sm7572989b3a.138.2024.05.19.19.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 19:39:39 -0700 (PDT)
Date: Sun, 19 May 2024 19:39:38 -0700
From: Kees Cook <keescook@chromium.org>
To: Kent Overstreet <kent.overstreet@linux.dev>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs updates fro 6.10-rc1
Message-ID: <202405191921.C218169@keescook>
References: <zhtllemg2gcex7hwybjzoavzrsnrwheuxtswqyo3mn2dlhsxbx@dkfnr5zx3r2x>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zhtllemg2gcex7hwybjzoavzrsnrwheuxtswqyo3mn2dlhsxbx@dkfnr5zx3r2x>

On Sun, May 19, 2024 at 12:14:34PM -0400, Kent Overstreet wrote:
> [...]
> bcachefs changes for 6.10-rc1
> [...]
>       bcachefs: bch2_btree_path_to_text()

Hi Kent,

I've asked after this before[1], but there continues to be a lot of
bcachefs development going on that is only visible when it appears in
-next or during the merge window. I cannot find the above commit on
any mailing list on lore.kernel.org[2]. The rules for -next are clear:
patches _must_ appear on a list _somewhere_ before they land in -next
(much less Linus's tree). The point is to get additional reviews, and
to serve as a focal point for any discussions that pop up over a given
change. Please adjust the bcachefs development workflow to address this.

Anyway, in reference to the above commit, please scrub bcachefs of its
%px format string uses. Neither it nor %p should be used[3][4] in new
code. (Which is, again, something checkpatch.pl will warn about.)

Thanks!

-Kees

[1] https://lore.kernel.org/all/202401101525.112E8234@keescook/
[2] https://lore.kernel.org/linux-bcachefs/?q=bch2_btree_path_to_text
[3] https://docs.kernel.org/process/deprecated.html#p-format-specifier
[4] https://lore.kernel.org/lkml/CA+55aFwQEd_d40g4mUCSsVRZzrFPUJt74vc6PPpb675hYNXcKw@mail.gmail.com/

-- 
Kees Cook

