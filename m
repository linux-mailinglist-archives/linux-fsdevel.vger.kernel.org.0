Return-Path: <linux-fsdevel+bounces-54392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABF3AFF417
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 23:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C99A5A7F0B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 21:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DDE23C514;
	Wed,  9 Jul 2025 21:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="M+Vjkmar"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2B923E344
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Jul 2025 21:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752097457; cv=none; b=iBVGUbZy81TP3Kr7uSw6e7a09Q6u3WcyEOxrmTZJqqeC9uIpfiNyLuYDJzaQYHv0llFeiAdj3o3thZBQpn3MjxBeX1yuecqRIYuPBjPcifHqaBBWuJeDe6eCT6OqWj9xg4cdKci6Vevzc8xwVpYNRQsnsBjFvKLyRZxR5iBxye0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752097457; c=relaxed/simple;
	bh=QM3ZwKzZ3tmooQKRsyzdW8dMI+e0bgrGReSxQbsBbz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nhxf74pud0eo8E+W1LTwvAqhKAf+NVi3iKyR9aUidPGr5o2V6nnbRqS9DVvWLxoGhBYTY/zA21OUSfoLHlfT2rpSUymHJCQgF7O3zTht5bjD98gS3MsQwVsh/k9PmXlaBUXEClD4QeTUnm2l+FopTYgg1ytRrZTXK/tjG3sHSPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=M+Vjkmar; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae223591067so44563366b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Jul 2025 14:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1752097453; x=1752702253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2oOfilMeJ3fSH+1jR5dPS+6bpms3vDBaMx9PS7L2n8=;
        b=M+Vjkmar2DZR01VBbGidpjLsj5WkhccV4HkYK/+hg7utLrEMINgnjypBRimA/63N9Z
         yYsj7DHfmQMKO1QAv71VK0sNBQkM9peUJhNd+uT1+KdZik4D91/04Eja8bsYuFfp0NYO
         FQ3oMpJJIDemPPNuxCCNSfbuS55si7hddv+RnXQA0b+5DhFQB8Z7rNyJQXBnKOOuK4Rl
         95Iib0HNh/m9cbmeeGI8t7IUpxYr+cfY+DNwK7eo7gUezPshoSEvsBIeAy7Pg6vTmmhV
         h3t0qqhwOB/bMwwUqNpEiS29wNroRRQR/3a4uP4NUgAMh9KoBsErPHFfXlzrhjWBnwHO
         DNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752097453; x=1752702253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2oOfilMeJ3fSH+1jR5dPS+6bpms3vDBaMx9PS7L2n8=;
        b=w5d8vvZW5EMALGJaOb2T0b3g47sevruP+JmHYVbP5f9Ixb8lUlBU91kIVwVccQlzPS
         fO+6+dhUz9tIR3tTbEksq+e+DCpYh3SiNP1YvhpEPzZcbHgMbyDADxvJ+AZlKtIDd+UI
         2YFPn7r3OkXZkdEFEJP8XK41fDopQ4m/NWgB2fLqjmseJjb2qUj+KknKbpgJH0IkD+mC
         4EThEkfr/gxKh5d/uQC0KdfI4Ekbuz7CajuJoVrt6pr+zSbgS2rONCaEWFVzKzsXH1k9
         w+qvlV6kYmXOugdcoqBTAIyXVMbUsUDYlBLiwwvj1t2gBY8uQHs+0BTZlFgGJH++x4OS
         mLmg==
X-Forwarded-Encrypted: i=1; AJvYcCX9FoDd3uE4AZT29Aa752+hupO9w9BSNpC0N9imVi8iyQHQ85e5e5Ubr7GBw1/qzcObkB684pnrukyLGCtK@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm01R6jKPEZmvzS7+snyGV8XBFel/xLRYvPNOPSaUI8JhNxiV6
	F9x47x+eqJcZhDeG+MSBJ0fXJp4BMvjgWl1IT00H81H7chX0YPaBz5runusLmbL5UEHPGqn9CQf
	UbrkYM8aHuPc1ZlMrLw5pykCSTa0M6c/CRQ1v1lwYjQ==
X-Gm-Gg: ASbGncsNKrA7AmuVBoDytXF1uyn+sQ07LgGec5HSHg6+2SrJwOge9F22MRu68bEpkdh
	BfoVOgLT85aIChkvM9/EuID8QIy2lATQUIBb+DaXNEpSlrBC7I82QSZQ/l3dTewm8mrnCmRRzBl
	P+aI1jyDRbGp7UMXCRNs8e5U1R6uEmCyeCJjb+DpfvOGyhVRydJhvRO/HcPLaLVDhGw6cobT8=
X-Google-Smtp-Source: AGHT+IHRfBgI+JpvIFW5bdEhu8EMbBsinsmaICn0S2xVCrLK7zPglEC6AbVpvLywHBFg/8fSMjerPI4gbWHSZhnMN/4=
X-Received: by 2002:a17:906:46d9:b0:ae3:d1fe:f953 with SMTP id
 a640c23a62f3a-ae6e7099e16mr25848366b.43.1752097453229; Wed, 09 Jul 2025
 14:44:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701163852.2171681-1-dhowells@redhat.com> <CAKPOu+8z_ijTLHdiCYGU_Uk7yYD=shxyGLwfe-L7AV3DhebS3w@mail.gmail.com>
 <2724318.1752066097@warthog.procyon.org.uk> <CAKPOu+_ZXJqftqFj6fZ=hErPMOuEEtjhnQ3pxMr9OAtu+sw=KQ@mail.gmail.com>
 <2738562.1752092552@warthog.procyon.org.uk>
In-Reply-To: <2738562.1752092552@warthog.procyon.org.uk>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 9 Jul 2025 23:44:02 +0200
X-Gm-Features: Ac12FXwGyOaYIBhD6kJLi5Rdp0KMSI4jWTqWW8bY_UVcRj5P-WQCdanG6BjA4Q0
Message-ID: <CAKPOu+-qYtC0iFWv856JZinO-0E=SEoQ6pOLvc0bZfsbSakR8w@mail.gmail.com>
Subject: Re: [PATCH 00/13] netfs, cifs: Fixes to retry-related code
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.com>, netfs@lists.linux.dev, linux-afs@lists.infradead.org, 
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 10:22=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
> > (The above was 6.15.5 plus all patches in this PR.)
>
> Can you check that, please?  If you have patch 12 applied, then the flags
> should be renumbered and there shouldn't be a NETFS_RREQ_ flag with 13, b=
ut
> f=3D80002020 would seem to have 0x2000 (ie. bit 13) set in it.

Oh, I was slightly wrong, I merged only 12 patches, omitting the
renumbering patch because it had conflicts with my branch, and it was
only a cosmetic change, not relevant for the bug. Sorry for the
confusion!

