Return-Path: <linux-fsdevel+bounces-69516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 56794C7E250
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6746E343867
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 15:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D832D6E61;
	Sun, 23 Nov 2025 15:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFeRk4Wr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093A821B918
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 15:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763910930; cv=none; b=Bvgjzc8v17nqq497kXtGAAeXAm5JVrR2166Zkih2YelfD0iNhTfX7bbVCE9mz+nGcIXcUvyuWIx5lqUcGTSUSrlBWmcqGSPbhDnSCbga+5H96EQ6SWmsAosVEH8XjSaVJrcBgMN5K5v1r3jBm1u53Q+Zl0mX2EtsI1AwQAUQGok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763910930; c=relaxed/simple;
	bh=uCQ6YvH8ba/+FZqf0rbD+2j35fRM3fz4euFVrqfjpNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tooz5nJC/CZjQEviT5QV9aZZy7QwZPgnxp9RmoWnZ4B+BwrcVP9YRPTSUeCYpjdkP6JPe5pte0dmmQ7ObqKD73A7NjLtOzgpXgKyALtSIytR2UPakZq92kr502ATMH0/TfHPtxdSwL8hPfg9Lf6LfOTb/QGbQbij88ODx23dXsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFeRk4Wr; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-656b0bd47b8so621020eaf.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 07:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763910928; x=1764515728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=De/lPsfFO53vKha/biqmSP9tZEdy3W0okeCE/GphGhM=;
        b=YFeRk4Wr24s8L6ZDxo/RO+HKhbl8ryZW2yZkNw8ErPANSn1mt2frVsNCys730EREhF
         a9t+FZZU2+zev7VMvB/G9gbNwXlgsT2v+rVIpvJ+DW4ZJNzLrauj0Q6u4aqcnyOSmazp
         85vR1WvDHsDONuKPSZRKleOhhnT30k81aZq1q0NqclKW12TVUr55GaVZ7cWwi/dWkfTL
         deVO1KpwDDhy6+2LaX4fBYoU2uuP9bj1mmZbUsXVsz/0M1x9ChvrIyQkC+Kx4lgtfmnc
         aPSrBrnyon+AIDlp8bro+ypxBI3Yp93eh3eTXqQzdHBRfIeFrN+V+iH66JeolO6YCpnF
         WDlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763910928; x=1764515728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=De/lPsfFO53vKha/biqmSP9tZEdy3W0okeCE/GphGhM=;
        b=PzRwO2RKOmMn2u8B7krcLPL6jCIWHPTqrmy1a64VIdbfCTib2gxW+ChFQJgt9ghxts
         FAU5WQFa5GcoHY3NhViPC+ZU06SHKpk2uC093F/UxSq0Z5V0/MIRgbaS9wZCRHzMu/Jd
         jtRUEnbns98QRV3cfE+NhiNurmuXz4cdWCvkWEby1Z/ingHylRByLk/TKDosEh/jJIqc
         JA5r0oXll3UaReGHz7OT1FVe6h9ZLXk20fiPKho5DLwrXHTkAZfWKY9DajsNMba6fUJH
         drlouQAfy0H2mYtBewqsGo+hZzD7MbzR6b1u6jzg24W+gqDXiWOeRlSJ2ruTNPptIfpb
         HC/g==
X-Forwarded-Encrypted: i=1; AJvYcCXKVZqsKTs4I2pUaPmabXPabUVbLi8ODZXvCfqDU1n/l/s/5qmBmkckk6J9R34QDG/fNAySbTJwHrY29dW2@vger.kernel.org
X-Gm-Message-State: AOJu0Yw55L1WLF5UXCWTVsVkIa7TqMe7If+sRzfPrC7yRhLphMncLh0Q
	VyCGzRU7uoPuhbfqNSJ7oCFVgQqOSmc2HBR0eIrNHMAOziFh48I3ixbpiT+epQy2UHzH8KUfpsi
	4fsNYeajjto0+X4cc65H1nyBI+VOTbaM=
X-Gm-Gg: ASbGncs9ezsMtlVwOOTHMIXNo68PGGAESCtL279MG4/ZJCUy+ZhDzOpMjiN+6xsJ4eR
	qsiTUBQ4uyIjWPCpJvNqivUJM3QF8SXZBeOQLtoqnyekWK1FCMsDeZNLeEOHqMNczXcepJJq/xL
	INQDaahAxw/QgZl4Z2Zq7m8J3SJs0Z3D5aB2Q1wo+i+nlxzFupeonE9R/Wt7IAmIV7jkwTOam6N
	FAO7lOefcPZ+TICu7LXfAW1gT408MBmvXBb+QEWtjoxhFTdUgpkAwiWtjnvMPjLvjI2zCHq
X-Google-Smtp-Source: AGHT+IHvWXOULpjTnyOCyW2NFzpljrltbD247PnGTGMy3ro5N0Z6qorbiksLkAjgb8vJXTaUnEzamhQdO9qmE/RzCLU=
X-Received: by 2002:a05:6830:91d:b0:7c7:b28:227c with SMTP id
 46e09a7af769-7c798f63a43mr3953526a34.4.1763910928120; Sun, 23 Nov 2025
 07:15:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111062815.2546189-1-avagin@google.com> <aSMDTEAih_QgdLBg@sirena.co.uk>
In-Reply-To: <aSMDTEAih_QgdLBg@sirena.co.uk>
From: Andrei Vagin <avagin@gmail.com>
Date: Sun, 23 Nov 2025 07:15:16 -0800
X-Gm-Features: AWmQ_bl2v5sJFABGLYRwmtumlYiR_86NymH2jq5gZv99YjbFFF2BUPG2EIo0Cdk
Message-ID: <CANaxB-wmgGt3Mt+B3LJc4ajVUdTZEQBUaDPcJnDGStgSD0gtbQ@mail.gmail.com>
Subject: Re: [PATCH] fs/namespace: correctly handle errors returned by grab_requested_mnt_ns
To: Mark Brown <broonie@kernel.org>
Cc: Andrei Vagin <avagin@google.com>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 23, 2025 at 4:51=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Tue, Nov 11, 2025 at 06:28:15AM +0000, Andrei Vagin wrote:
> > grab_requested_mnt_ns was changed to return error codes on failure, but
> > its callers were not updated to check for error pointers, still checkin=
g
> > only for a NULL return value.
>
> I'm seeing regressions in mainline in the LTP listmount04 test on some
> arm64 platforms:
>
> tst_test.c:1953: TINFO: LTP version: 20250530
> tst_test.c:1956: TINFO: Tested kernel: 6.18.0-rc6-00270-g89edd36fd801 #1 =
SMP PREEMPT @1763835814 aarch64
> tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
> tst_test.c:1774: TINFO: Overall timeout per run is 0h 05m 24s
> listmount04.c:128: TPASS: request points to unaccessible memory : EFAULT =
(14)
> listmount04.c:128: TPASS: mnt_ids points to unaccessible memory : EFAULT =
(14)
> listmount04.c:128: TPASS: invalid flags : EINVAL (22)
> listmount04.c:128: TPASS: insufficient mnt_id_req.size : EINVAL (22)
> listmount04.c:128: TFAIL: invalid mnt_id_req.spare expected EINVAL: EBADF=
 (9)
> listmount04.c:128: TPASS: invalid mnt_id_req.param : EINVAL (22)
> listmount04.c:128: TPASS: invalid mnt_id_req.mnt_id : EINVAL (22)
> listmount04.c:128: TPASS: non-existant mnt_id : ENOENT (2)
>
> which bisect to this patch.  I'm not sure if the change in error code
> here is actually a real issue or not, this feels like an overly
> sensitive test, but perhaps there's some spec requirement or something
> so it seemed reasonable to report.

The merged patch is slightly different from what you can see on the
mailing list, so it's better to look at commit 78f0e33cd6c93
("fs/namespace: correctly handle errors returned by
grab_requested_mnt_ns") to understand what is going on here.

With this patch, the spare field can be used as the `mnt_ns_fd`. EINVAL
is returned if both mnt_ns_fd and mnt_ns_id are set. A non-zero
mnt_ns_fd (the old spare) is interpreted as a namespace file descriptor.

Thanks,
Andrei

