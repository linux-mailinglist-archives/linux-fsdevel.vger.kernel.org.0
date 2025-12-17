Return-Path: <linux-fsdevel+bounces-71549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6A3CC74EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 12:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2BB6304B4C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 11:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463A234EF13;
	Wed, 17 Dec 2025 10:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+LrCfPW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0690B34EEF2
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Dec 2025 10:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765966417; cv=none; b=Av9BfArpGe5Ryolt8icfksVOIYBatCzYey7QXS00Lmv7PGT58X5+F9mWDctZ/TE3O3LvqNIK0cylzibXK6YPIC/0POZD4ZlIPYx3JLR4ghynXjJ3MM2M0Lrez+ZD7SI6xOmnlb39Cb9R6kXBK3QsJJADg7Ux6/0aO2g880V172g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765966417; c=relaxed/simple;
	bh=JQFddqkMWDuWZ2Xi4rVFiagLrT8W4R0QRnAJPB2Trsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eqD6/6dPVrHPpN0U65/93KrtGeOVgorxb++1EiUnit6fPelnLbEYAsSkDeewK2GtdB+4PWsPuij5wWNNRY3Km+Ok21oK6fhfQ/PQuKLY0ICkew5Ci+dgcAPB2xkTKgDalD0lKQib8rNp4Torw4CBBK24xJmvNsPoGb+RAEj/sbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+LrCfPW; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b7636c96b9aso933249466b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Dec 2025 02:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765966414; x=1766571214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUoGSYTe+FS5AaErlZtyPoy8kNGwFXNU4tlHBIPgces=;
        b=P+LrCfPWYH2aQk1d0ofIicyhBoI5X0D/bZ07//1wKxgrUTv9Aqu6XDQf02IdJFTTAY
         L1dBqh5FtebIl4B5xsIl8a06QTa1xrachpxz5QhaiB8sTnaReRF0N58UyAcBh1EinjVL
         HnyStkXfsmqikgyldFaFF1N/8eK5AL5RZFGdqHCr0PKifh9VeJjT2Yqq3ftuMAYjRog8
         LxR548MHd8+R+s4aoVH2VQYWk9ZEF9aoqYcYhwfJDKFgoiGEqJnJ2kNyqDzszgVBRjTf
         ehwSi4TsbY2c3Vh1adZ79e6R18XQ21tfZul+3SC171t29nWU9/iY1liGV++Y4/5hbFTy
         JRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765966414; x=1766571214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DUoGSYTe+FS5AaErlZtyPoy8kNGwFXNU4tlHBIPgces=;
        b=lu8JMMJy1aKzOzgN5b9D2tkHNg3xJ3wTk78l9VZL3D6LiW4alpZ6u6YauGrel+uEci
         1d3JzzhIaFgP6QphYfjKr3iHc50Cfy8Rb1f+6cbNF2Ldi/s2eZj7X8UxtSfjbZGI5zrn
         Mp9Iy+0mDBBDRVOM0RWlsITzY4WxRLriERlPYFa652oxQ9XKrWI2Dv7Abtg3f6LXaeJ8
         MAmQ15OAgrg3DOcM1UTD/LpRAmqzSnKC3VNXlFUhbGW8NmvHNaoVtJOgTPGlOtxOVZrH
         EXZQnIUDGob1txO/XaxaZEV7Wktz/VLGSfFU/CAYfjW3NMy36Bv4RueYQmzknlg3e9pP
         USPA==
X-Forwarded-Encrypted: i=1; AJvYcCXPTXKHee0iqh91DUZRuI18eLbKDloynLyMChtwr+Ft0loMvFRFHQWRaBJ+D+9PTDQTYRuG0n2Z31Xpmyjc@vger.kernel.org
X-Gm-Message-State: AOJu0YwtPFKfJmgs7KSNSkwxmvFX5kiBdiGdBdxq34SR7g+XtfViKxHo
	y8aEzb5kftCf3ZcDL0evGSRp4xciCh1Yqaxhpk5bmeucogGx7C5+OmzLXJNcoHKb+FvXGCndTVp
	uNmnrrDlazdOXXvAxtB6jYnHKoK+OaSQ=
X-Gm-Gg: AY/fxX6CcRBxN19HSet1y5Ssh2uZmteG96RhAl0A19e5yA3i8cLMAa8zjYvPzzXVp/N
	Q/3ApVawpPkTAUBE+sGqTJb81dIsIYmxOQDXUeA2LH42DvSanPeOYUMwBF0MnzgJal9tygnPTIs
	zwZC+5aeRZK5iP3bMw1TCf9O66xyyW7w4c4qntv0gJlIXYQVOeUvIhTnB15m8VKW1ORf4FqIl9I
	vkSbvtr8tEtgDhgAoblBO02zT2ITmKwe98ovLaNsaUVsw/tZrqfFzDt11sBsalFiMeeh88D71o2
	eUBN5GYJ+XvhqieOCi0OlhoyYuM=
X-Google-Smtp-Source: AGHT+IG6s7fGfl5xgdL2X8L6BPMSIzCd7eX87HT2CY3zKpnjp6mvIE4xTgb1EM7aUn7/1SWbG9i8OlbIZAwUNsMpyWk=
X-Received: by 2002:a17:907:9629:b0:b79:f63b:e15c with SMTP id
 a640c23a62f3a-b7d2356ae0cmr1925063766b.13.1765966413998; Wed, 17 Dec 2025
 02:13:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217084704.2323682-1-mjguzik@gmail.com> <20251217090833.GS1712166@ZenIV>
 <CAGudoHE5SrcUbUU8AuMCE1F_+wEUfM4o_Bp9eiYjX0jtJPUUmA@mail.gmail.com> <20251217100605.GT1712166@ZenIV>
In-Reply-To: <20251217100605.GT1712166@ZenIV>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 17 Dec 2025 11:13:22 +0100
X-Gm-Features: AQt7F2pUk1oWMzZieCp1YdadDWPVqHW5Kbu6faimiwqG_TC7DuDXTMnpD7igUNw
Message-ID: <CAGudoHFLV5sHE1UBXR5BtPHUghnroA=m59D6yBknWnZz0mkS7A@mail.gmail.com>
Subject: Re: [PATCH v2] fs: make sure to fail try_to_unlazy() and
 try_to_unlazy() for LOOKUP_CACHED
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, clm@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 11:05=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
>
> On Wed, Dec 17, 2025 at 10:11:04AM +0100, Mateusz Guzik wrote:
> > On Wed, Dec 17, 2025 at 10:07=E2=80=AFAM Al Viro <viro@zeniv.linux.org.=
uk> wrote:
> > >
> > > On Wed, Dec 17, 2025 at 09:47:04AM +0100, Mateusz Guzik wrote:
> > > > One remaining weirdness is terminate_walk() walking the symlink sta=
ck
> > > > after drop_links().
> > >
> > > What weirdness?  If we are not in RCU mode, we need to drop symlink b=
odies
> > > *and* drop symlink references?
> >
> > One would expect a routine named drop_links() would handle the
> > entirety of clean up of symlinks.
> >
> > Seeing how it only handles some of it, it should be renamed to better
> > indicate what it is doing, but that's a potential clean up for later.
>
> Take a look at the callers.  All 3 of them.
>
> 1) terminate_walk(): drop all symlink bodies, in non-RCU mode drop
> all paths as well.
>
> 2) a couple in legitimize_links(): *always* called in RCU mode.  That's
> the whole point - trying to grab references to a bunch of dentries/mounts=
,
> so that we could continue in non-RCU mode from that point on.  What shoul=
d
> we do if we'd grabbed some of those references, but failed halfway throug=
h
> the stack?
>
> We *can't* do path_put() there - not under rcu_read_lock().  And we can't
> delay dropping the link bodies past rcu_read_unlock().
>
> Note that this state has
>         nd->depth link bodies in stack, all need to be droped before
> rcu_read_unlock()
>         first K link references in stack that need to be dropped after
> rcu_read_unlock()
>         nd->depth - K link references in stack that do _not_ need to
> be dropped.
>
> Solution: have link bodies dropped, callbacks cleared and nd->depth
> reset to K.  The caller of legitimate_links() immediately drops out
> of RCU mode and we proceed to terminate_walk(), same as we would
> on an error in non-RCU mode.
>
> This case is on a slow path; we could microoptimize it, but result
> would be really harder to understand.

I'm not arguing for drop_links() to change behavior, but for it to be
renamed to something which indicates there is still potential
symlink-related clean up to do.

As an outsider, a routine named drop_${whatever} normally suggests the
${whatever} is fully taken care of after the call, which is not the
case here.

