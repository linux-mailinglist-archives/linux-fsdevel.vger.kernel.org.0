Return-Path: <linux-fsdevel+bounces-72218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4660FCE84F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 00:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C52073022F3E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 23:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9AD202F65;
	Mon, 29 Dec 2025 23:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H763YPE/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D7D2236E5
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 23:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767049351; cv=none; b=Rui/5XD5WKaBdpSpz82AoRbXS9GNKWQUYoUDi80ZHK5wuxTCfXkkRgn7sWC0akNDfXZfBA0uTwrG9yIMkgMIWgOmNeaJmv7Cm4wE9dGPT2UKhQNALUQl9K8Ic69Ni/U0OSTifO8oaFud4vke4aEL+faEnUNH1LA4TDHlD+2Q1LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767049351; c=relaxed/simple;
	bh=ohGA0JdhsXA/jF8PdRIkPkksbIe+L57fzMkaKEW7pkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JbKDol0s1patSsrCxP1g2b0xE8GaIFkX0KITFxcq6W53GFS6K1v20D9uV2M76zNwyYbJ38a43RK9jcQSyDIRI2Aa+OYamefB0ygVOX9kjs1JyQMO8NV1Oust7cMf+wquBgUrujjsCr0werQnABBzXwN0OJUAq2PVMN+nGtx5aO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H763YPE/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B25ECC2BCB3
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 23:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767049350;
	bh=ohGA0JdhsXA/jF8PdRIkPkksbIe+L57fzMkaKEW7pkg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=H763YPE/aQXTcS/Ey+kcC+mJhy95ZoLntcr7bMGqaLEyTaT4HkWGRZwY/v1MFBBOT
	 vep2ECXhadbqNj2jt9FH/2Bg3DRs7bRht3f8KBENVuGO01qbdI58rHDc1xO95AJFDQ
	 gfTqy1TVCiCVLdV9iwKAfwyCyFOceVoLDR2yNpA1928MXEzkQFgboe891vF+bmNqKk
	 kfzZIwpsEzHsC+bpJDvuIvxbdDj8nx9H1ItNgeu+2epaFJxvRdJtwpQ2ITHdvvV/rK
	 8ZxifWosmWZLR02k1qfyET1gbIk9gyn4lu7mq4leWtCGQzCfl+TmQ64i2RN3EaDWld
	 sDrxjfCxD6Rfg==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-64b8e5d1611so12001941a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 15:02:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWmj+mS8ENYiqJXRhc65DuFyfISFCX3MZUcRdY5wLW1OdoZZhMQNo802AmyWIt6yGz0JeZfgHnMS3CtnLnt@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/DW50BaZFV2oHjwUf8BtdJZStxyexycZSrvMLUkDmCXYvtIeD
	W8cx0nCfnLEbQhw985LLaCJAHwBI+K+AuXV3JSrGlH/0mL2hibTq5BuwERQNZij7CS1WCea77Uj
	fOtvv1tDxDTCAoX7qttN+vJXm2oR/FeE=
X-Google-Smtp-Source: AGHT+IG6/mkuhjO5hgHQTMbSWsjBD55pDVxjL704c1xCR62x1VYdOTx7dXkDPJFLrNMySba/dseceXmMBG62PvJAPzw=
X-Received: by 2002:a17:907:1de2:b0:b80:4117:b6b3 with SMTP id
 a640c23a62f3a-b804117f48bmr2232622366b.10.1767049349185; Mon, 29 Dec 2025
 15:02:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251229112446.12164-1-linkinjeon@kernel.org> <20251229112446.12164-2-linkinjeon@kernel.org>
 <aVKi-ZiyIRj9IF1h@amir-ThinkPad-T480>
In-Reply-To: <aVKi-ZiyIRj9IF1h@amir-ThinkPad-T480>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 30 Dec 2025 08:02:17 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9_6WOZNpM2XxgmWugBE6keJ-=FXWM9Uh9svPaviox0ew@mail.gmail.com>
X-Gm-Features: AQt7F2pYjnhrfBrVtVHxBjtR1quEf7IH2IeOC8nDbpOnBjkX81n_Hp9AEYLUaI0
Message-ID: <CAKYAXd9_6WOZNpM2XxgmWugBE6keJ-=FXWM9Uh9svPaviox0ew@mail.gmail.com>
Subject: Re: [PATCH v3 RESEND 01/14] Revert "fs: Remove NTFS classic"
To: Amir Goldstein <amir73il@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org, hch@lst.de, 
	tytso@mit.edu, willy@infradead.org, jack@suse.cz, djwong@kernel.org, 
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com, 
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org, ebiggers@kernel.org, 
	neil@brown.name, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 12:49=E2=80=AFAM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> On Mon, Dec 29, 2025 at 08:24:33PM +0900, Namjae Jeon wrote:
> > This reverts commit 7ffa8f3d30236e0ab897c30bdb01224ff1fe1c89.
> > ---
> >  fs/ntfs/aops.c     | 1744 ++++++++++++++++++++++++
> >  fs/ntfs/aops.h     |   88 ++
> >  fs/ntfs/attrib.c   | 2624 ++++++++++++++++++++++++++++++++++++
> >  fs/ntfs/attrib.h   |  102 ++
> >  fs/ntfs/bitmap.c   |  179 +++
> >  fs/ntfs/bitmap.h   |  104 ++
> >  fs/ntfs/collate.c  |  110 ++
> >  fs/ntfs/collate.h  |   36 +
> >  fs/ntfs/compress.c |  950 +++++++++++++
> >  fs/ntfs/debug.c    |  159 +++
> >  fs/ntfs/debug.h    |   57 +
> >  fs/ntfs/dir.c      | 1540 +++++++++++++++++++++
> >  fs/ntfs/dir.h      |   34 +
> >  fs/ntfs/endian.h   |   79 ++
> >  fs/ntfs/file.c     | 1997 +++++++++++++++++++++++++++
> >  fs/ntfs/index.c    |  440 ++++++
> >  fs/ntfs/index.h    |  134 ++
> >  fs/ntfs/inode.c    | 3102 ++++++++++++++++++++++++++++++++++++++++++
> >  fs/ntfs/inode.h    |  310 +++++
> >  fs/ntfs/layout.h   | 2421 +++++++++++++++++++++++++++++++++
> >  fs/ntfs/lcnalloc.c | 1000 ++++++++++++++
> >  fs/ntfs/lcnalloc.h |  131 ++
> >  fs/ntfs/logfile.c  |  849 ++++++++++++
> >  fs/ntfs/logfile.h  |  295 ++++
> >  fs/ntfs/malloc.h   |   77 ++
> >  fs/ntfs/mft.c      | 2907 ++++++++++++++++++++++++++++++++++++++++
> >  fs/ntfs/mft.h      |  110 ++
> >  fs/ntfs/mst.c      |  189 +++
> >  fs/ntfs/namei.c    |  392 ++++++
> >  fs/ntfs/ntfs.h     |  150 +++
> >  fs/ntfs/quota.c    |  103 ++
> >  fs/ntfs/quota.h    |   21 +
> >  fs/ntfs/runlist.c  | 1893 ++++++++++++++++++++++++++
> >  fs/ntfs/runlist.h  |   88 ++
> >  fs/ntfs/super.c    | 3202 ++++++++++++++++++++++++++++++++++++++++++++
> >  fs/ntfs/sysctl.c   |   58 +
> >  fs/ntfs/sysctl.h   |   27 +
> >  fs/ntfs/time.h     |   89 ++
> >  fs/ntfs/types.h    |   55 +
> >  fs/ntfs/unistr.c   |  384 ++++++
> >  fs/ntfs/upcase.c   |   73 +
> >  fs/ntfs/volume.h   |  164 +++
> >  42 files changed, 28467 insertions(+)
> >  create mode 100644 fs/ntfs/aops.c
> >  create mode 100644 fs/ntfs/aops.h
> >  create mode 100644 fs/ntfs/attrib.c
> >  create mode 100644 fs/ntfs/attrib.h
> >  create mode 100644 fs/ntfs/bitmap.c
> >  create mode 100644 fs/ntfs/bitmap.h
> >  create mode 100644 fs/ntfs/collate.c
> >  create mode 100644 fs/ntfs/collate.h
> >  create mode 100644 fs/ntfs/compress.c
> >  create mode 100644 fs/ntfs/debug.c
> >  create mode 100644 fs/ntfs/debug.h
> >  create mode 100644 fs/ntfs/dir.c
> >  create mode 100644 fs/ntfs/dir.h
> >  create mode 100644 fs/ntfs/endian.h
> >  create mode 100644 fs/ntfs/file.c
> >  create mode 100644 fs/ntfs/index.c
> >  create mode 100644 fs/ntfs/index.h
> >  create mode 100644 fs/ntfs/inode.c
> >  create mode 100644 fs/ntfs/inode.h
> >  create mode 100644 fs/ntfs/layout.h
> >  create mode 100644 fs/ntfs/lcnalloc.c
> >  create mode 100644 fs/ntfs/lcnalloc.h
> >  create mode 100644 fs/ntfs/logfile.c
> >  create mode 100644 fs/ntfs/logfile.h
> >  create mode 100644 fs/ntfs/malloc.h
> >  create mode 100644 fs/ntfs/mft.c
> >  create mode 100644 fs/ntfs/mft.h
> >  create mode 100644 fs/ntfs/mst.c
> >  create mode 100644 fs/ntfs/namei.c
> >  create mode 100644 fs/ntfs/ntfs.h
> >  create mode 100644 fs/ntfs/quota.c
> >  create mode 100644 fs/ntfs/quota.h
> >  create mode 100644 fs/ntfs/runlist.c
> >  create mode 100644 fs/ntfs/runlist.h
> >  create mode 100644 fs/ntfs/super.c
> >  create mode 100644 fs/ntfs/sysctl.c
> >  create mode 100644 fs/ntfs/sysctl.h
> >  create mode 100644 fs/ntfs/time.h
> >  create mode 100644 fs/ntfs/types.h
> >  create mode 100644 fs/ntfs/unistr.c
> >  create mode 100644 fs/ntfs/upcase.c
> >  create mode 100644 fs/ntfs/volume.h
> >
>
> Namje,
>
> This is a partial revert, something that should be mention in commit
> message.
>
> But also, I think you should include more of the original revert, like
> the docs and MAINTAINERS entry, which you added later, sometimes inside
> unrelated patches.
>
> The only think that you need to omit from the revert in the Makefile and
> Kconfig changes, so that ntfs code remains dormant until the end of the
> series.
Okay, Understood. I will do that in the next version.
Thanks!
>
> Thanks,
> Amir.

