Return-Path: <linux-fsdevel+bounces-20975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7F78FBA9A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 19:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51D1D1F27E99
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 17:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6548514A4CF;
	Tue,  4 Jun 2024 17:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="XIdegFTk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AF014A0B9
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 17:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717522556; cv=none; b=C4Cyn/tn9YxNY+2s2w2QFpwwiEVsWYzn3piUsFqu9ZH9eMGWIJQnEhJWcFstBgUhQ3F7gUSPEMV9Eg3K2Feksvmbh/KuQDUdaSLrYrJ5T9AnumjnDSqUN/vlRdR+814QguFjwS29z3rZyVA3eUcXUFLogX6ZDfH7otdCEqru6f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717522556; c=relaxed/simple;
	bh=AkEvqo/DD4IfwPMjj7Iw1sbemXyBtb+S2Jq6SBF7jOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XDIqkSYLzcps9a3GphQAfpEU6Nv1dAKhwnT8WoHFBV4bIB1tOCTRSBaBt/DhmMZuEw5xkiic9iYSlqIzfSJwu9sCMy79MyQlATi8Rx4LsTt2T4bKLk+xc+ycJRqQ+TluWxmFyXhSFofJgee92zi/n7SSFSRhyM51b7oPgI3sSAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=XIdegFTk; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-df79380ffceso44404276.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Jun 2024 10:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1717522554; x=1718127354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dxwosnSACd3Hcl+oXu6r0gTSfXirocEBSzS4keKjIfs=;
        b=XIdegFTkPEvKJJMgWHYKPieDd3jqW/bgx/VGJIdGzGmG9HvVrNDczVFuiFZg5xLGfd
         lII9JK4JSq6YkbwNpOoQordHUeSkiOmhNQnk50JrY8bWKRkXIwhGlNLUMgulsBy0iPQb
         k+SnfAsFqUn1i6wPs+4FqZ3um0RoYbn0VPJKdGx8S1QPn/DhQ6W836+16O/x3mDOqVr/
         2VTxf7nVy8tQo1d3g7935z1fEKVhNfzS9aaTYk0jSuBKVpRcRsMvcXxQl6MhSR0SZlUT
         H/ZVM1ohHybl4bKicBDp2ZUqz6Q2fQlrzevQsO7aYkBK39k3Lu++Utghi6P4eQi6ZOvU
         0lfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717522554; x=1718127354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dxwosnSACd3Hcl+oXu6r0gTSfXirocEBSzS4keKjIfs=;
        b=jzOX8GDvTCNzTKL8jERVgvM2q0CK3u1H0rDn7YUGAgbV6w9eqpKl9UloIoLGrRjJQD
         syTTXy4jZ2isM5Yhs1qA2mXkILPshDPPCJ/WgAVGJOIraLzws4XexGpB9YREt6b5eaRd
         oyBsCvGUU4DK+MiaNiDbGUym08In3otzCEfVC56VnwhvldFNRldQpNTZo+W3cX8PBXYD
         1NPrGTEQs+K1lpp4xPBD/4yAjgZzagp3/7Lqo068JvdRmUJ+d9W/dt4ekFkI1ZcDJuK9
         mypLAl/LulKrcQXDU0IhmwiC6SNbOBFL2++zVV+sZN/kFRyZVqEqHCIlCO87Kuc4/Wtv
         ncsg==
X-Gm-Message-State: AOJu0Yz9mCmwA5kVwJIchfbzalnJHCeCHJBZTbZJDDoEGsHMx+BK6uyl
	F82ImKFQ/KCCcBx57h5bjJlonKYQPECJienpGLJP+EyNYkbQrrxHM/C5h29Yj5bt939/iTdt5z8
	/9K7KKQBg7Tiduw8J5bnGzN70Sx90GZwujzucQ/sPdhLtORgR
X-Google-Smtp-Source: AGHT+IE24rKa/RcqNnzYH9+rmnRc6yE+LU/DlFJRyf1IJCWV0+ZMmV6si7pNsesF1DiFdLhfmxcad7ZAril4T7+I5XI=
X-Received: by 2002:a25:b294:0:b0:dfa:5b25:48 with SMTP id 3f1490d57ef6-dfac974643cmr362655276.15.1717522554280;
 Tue, 04 Jun 2024 10:35:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604034051.GP1629371@ZenIV>
In-Reply-To: <20240604034051.GP1629371@ZenIV>
From: Ivan Babrou <ivan@cloudflare.com>
Date: Tue, 4 Jun 2024 10:35:43 -0700
Message-ID: <CABWYdi0KTJVsuEokmUF+fQ6w9orGNeaJLyjni0E8T+A0-FHe7g@mail.gmail.com>
Subject: Re: why does proc_fd_getattr() bother with S_ISDIR(inode->i_mode)?
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 8:40=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
>         ... when the only way to get to it is via ->getattr() in
> proc_fd_inode_operations?  Note that proc_fd_inode_operations
> has ->lookup() in it; it _can't_ be ->i_op of a non-directory.
>
>         Am I missing something here?

It's been two years, but I think I was just extra cautious.

