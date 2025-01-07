Return-Path: <linux-fsdevel+bounces-38582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC72CA043B1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 16:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 165D8166179
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 15:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5B31F2C4F;
	Tue,  7 Jan 2025 15:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BuK/brj0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8ED21F1921
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jan 2025 15:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736262264; cv=none; b=ji0kUFzThsSbH7T0fo/jLUVfbj09DCmI7Uz+r062bNkYQGnPEGiVZ8N95K/dTXVLIP3OeBOH+QBcRy4LiDWJO3L3HUorXYlXR6yknYkIG3mFx0s2iz+x4q9S/2UvQGAkE3IbrVzM3gZFDt6MRIGWFnWwlleYpP/gwfuqQnhWw6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736262264; c=relaxed/simple;
	bh=3zLSbbxbVmZkkCVuDfrtTMuFWiMDOzvUE9K2ecGKmls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BRz9gaH1CfVs9g1FvOiK+wi4XX1coT2v0D2dI4+8IhTh1eeaoGzeS3X0FGxfcnlUEFiN6dJNNnNIIvIsD64TX4Y1wWkSFeRyNhIcaXEgubZHogSRtgzgDxzzk7MULnkKOpWrknqjhOPKyp7VsN9E1koxedVEwy9FlSKCSCiuBrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BuK/brj0; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aab6fa3e20eso2582138366b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jan 2025 07:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736262259; x=1736867059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3zLSbbxbVmZkkCVuDfrtTMuFWiMDOzvUE9K2ecGKmls=;
        b=BuK/brj0GCttSMvwkSmcGnbVwe+4PzvpCBCfjCzkINnAE7E6jxsJ5JLUlL5UgOtMwI
         W9q+F6MYJjoeXFF42rFpgxNsVuNB6NdMVGzsFzWD3G7me3cFimjwi9SJsJp/u3PD77xv
         ZnHndZBaCSiaRtusCFaO84bwMPIV90cM+d1KvbxtU3/h8Fe81DvhhRufJff1lwRM10Md
         /7/EONXg80dXEM2cEozCHLgQe1YKMWQXTzLU2P7spbWDiHF7uhfa6YHWeGQgyrzlawBX
         MWd7HMbmUteCdVxlRjH/6/SVxjgfqQ14Q6YtFXGOd3dl2uP3ZH+qjXW3SU3eSYQ1dxwJ
         yiyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736262259; x=1736867059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3zLSbbxbVmZkkCVuDfrtTMuFWiMDOzvUE9K2ecGKmls=;
        b=aNOCHxHSw2EP3V3/pSmx+2tzY5kHtQjOQslnk6pcXYnFlU4oYl9T11YtLPktMKfbFZ
         jmNb8V3vEmSXqdqCtRj8cS0IGaa/8QsySnstS8YozSycrzAKqvSvHd6WRbaVgOZe/z5g
         9bJQcQFp8sTbAYiAZAhjUgHiIfagFcjbSowkQCy+TEAVp2HhuUnhWB0OtfxzvYCGCl7m
         Ja+KyC6F+YB9bzLgAR3aG9fSI5Twr9mg6zxcsEnfwUXMiyNS210fuHPB7JC270SiE9np
         bwkfe1b62R22Fww/KMJAkQ9Xyvli5jZAwkKlOif13okVJvCfpr+L4DYQscZ9GX79I112
         FVrA==
X-Forwarded-Encrypted: i=1; AJvYcCVfPaI8dv3WdtXsfz5z3kz450CCwLVnNrlxnDP7hq8aaiwfL3c8KSrxPdm0Tq03eisD0BS2uuvodWdU42+f@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm0n6G9OXhR/J5aNFiuwN9f9sEmtu9SIwUZS6qGIrzClHFunvI
	FeL5fQAT4KYsDf61cFjq37X+6mojUxo4nsdhBllkbaFiAMdqaM1ex7ZyLMFZZy0Vft9OxHOwsca
	NA0MXWi+NWuBOrVvoaE/USaD98IA8xR6OZmJ5Lw==
X-Gm-Gg: ASbGnctLGyPTTul4vhybzXzQ7OBlutbWeZ6ljIfrcB5/gvR//aroNqnU8eZZfqTGT7+
	gWU9vYhAZVm7OuSE7QkM2W/93fKmfNLZUbRZI3vMwcJ5R8vZoSM+9asy5WHJbMeOo0n6Ja4Y=
X-Google-Smtp-Source: AGHT+IGmTCd5YHsFph8t/UWhoGaC2Q/1DgFp4D1LmOF+O85L7z0mW1Q+UNHB289bpUXaUg8KNqd8OFE/AuRY9NS0TR0=
X-Received: by 2002:a17:907:86a5:b0:aa6:423c:850e with SMTP id
 a640c23a62f3a-aac334bc14amr5638224166b.27.1736262258818; Tue, 07 Jan 2025
 07:04:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ec6784ed-8722-4695-980a-4400d4e7bd1a@gmx.com> <324cf712-7a7e-455b-b203-e221cb1ed542@gmx.com>
 <20250104-gockel-zeitdokument-59fe0ff5b509@brauner> <6f5f97bc-6333-4d07-9684-1f9bab9bd571@suse.com>
 <CAPjX3FcG5ATWuC1v7_W9szX=VNx-S2PnFSBEgeZ0BKFmPViKqQ@mail.gmail.com> <1d0788af-bbac-44e6-8954-af7810fbb101@suse.com>
In-Reply-To: <1d0788af-bbac-44e6-8954-af7810fbb101@suse.com>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 7 Jan 2025 16:04:07 +0100
Message-ID: <CAPjX3FcbhvB=qzeJjNkW+XdS3_Xrxn_K6e7vyzMqS0WLbXFgNg@mail.gmail.com>
Subject: Re: mnt_list corruption triggered during btrfs/326
To: Qu Wenruo <wqu@suse.com>
Cc: Christian Brauner <brauner@kernel.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>, 
	linux-fsdevel@vger.kernel.org, linux-btrfs <linux-btrfs@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 6 Jan 2025 at 23:00, Qu Wenruo <wqu@suse.com> wrote:
> =E5=9C=A8 2025/1/7 08:20, Daniel Vacek =E5=86=99=E9=81=93:
> > On Sat, 4 Jan 2025 at 23:26, Qu Wenruo <wqu@suse.com> wrote:
> >> =E5=9C=A8 2025/1/4 21:56, Christian Brauner =E5=86=99=E9=81=93:
> >>> Can you please try and reproduce this with
> >>> commit 211364bef4301838b2e1 ("fs: kill MNT_ONRB")
> >>> from the vfs-6.14.mount branch in
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git ?
> >>>
> >>
> >> After the initial 1000 runs (with 951a3f59d268 ("btrfs: fix mount
> >> failure due to remount races") cherry picked, or it won't pass that te=
st
> >> case), there is no crash nor warning so far.
> >>
> >> It's already the best run so far, but I'll keep it running for another
> >> day or so just to be extra safe.
> >>
> >> So I guess the offending commit is 2eea9ce4310d ("mounts: keep list of
> >> mounts in an rbtree")?
> >
> > This one was merged in v6.8 - why would it cause crashes only now?
>
> Because in v6.8 btrfs also migrated to the new mount API, which caused
> the ro/rw mount race which can fail the mount.
>
> That's exactly why the test case is introduced.
>
> Before the recent ro/rw mount fix, the test case won't go that far but
> error out early so we don't have enough loops to trigger the bug.

So the bug has been there since v6.8, IIUC. In that case I think
211364bef430 ("fs: kill MNT_ONRB") should add Fixes: 2eea9ce4310d
("mounts: keep list of mounts in an rbtree") and CC stable?

--nX

