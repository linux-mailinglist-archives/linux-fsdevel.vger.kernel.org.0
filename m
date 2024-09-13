Return-Path: <linux-fsdevel+bounces-29267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DA19775EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 02:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D05C51C24238
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 00:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B69065C;
	Fri, 13 Sep 2024 00:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUAw7PGd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31E9376;
	Fri, 13 Sep 2024 00:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726186272; cv=none; b=W3R0UsZYpnJRURmmFeKUyvPo2A8uFasnh3hcTPM3TZGWNx+ag2BBQHEcaev54iu1qYe9ihlcvHBsQdd3xnbEz4xrHWqVnEhFWlFMIkt+pvzdtSQQqQlrKgPaXm9xLFYgHSzgfTT/+BFmOlCLBLw1nXE2akUzb5mRLOz62ypJXls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726186272; c=relaxed/simple;
	bh=XfRHFDU4FJI/R9IN98AXlBoU/Vl1+7rYh72q/bCCODE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lO/f5uE+8ZvLZuCObq/QZvBBmWDE/h7AIhMD/eCqK3cBwUSmBrUmwtMZqFPM72k6b4cSFldf1UMREGdg7I25FRW5YalHxESfTJRVGx3TtrCj4+/b6iCJJD3nmsp5qOr1PKv8DC+k84NJpJKMY8vk+a1Zi6xpFbHoaeMXKF5k90I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUAw7PGd; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-205722ba00cso13869005ad.0;
        Thu, 12 Sep 2024 17:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726186270; x=1726791070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hunM+homjKfciqv8HXlw0L4zBrfQkDM7ZfUEqbnP27E=;
        b=SUAw7PGdpu2v6kU3OyDCz5SJXNNlN2fCsZlklSyRaf8tWG5dkXAf2GCm5MwRriozHQ
         5gQFdV3uAtaYIeYH7ZZXUI2QnJNDDWz5VRwS6qySmZqOQBSReA42us8oMA3Bpit0Z5G+
         dOfhMAALAqDNlV9F+ZBv9oX8ps3HspI0Q2UXdPENOHfRGEUcS3xkQaRDhubzgg+hH5dZ
         j3Tfhl6izGyL9pmlzShaAIpG3+8XOfpLsFPj6EIA0HFBabb5cBYA4cpe0aXclM567JpD
         aSFC7euUTSQfahL2rT1IPqsZ2xOH4/jH1gQ4JS/LV3rWWx9Zk7QGk+oN7bL3dRKE4B3U
         kcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726186270; x=1726791070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hunM+homjKfciqv8HXlw0L4zBrfQkDM7ZfUEqbnP27E=;
        b=Ex0xsI/ocDqTE+eLBr+XMZNDEXfvw/exyx/XJNJGSMLS43b93ZWNk15Sx2C5JKLu5B
         Yh4YDKe95tabOY+Pn1CEAvwVrusYjSViLbzlYLzZ/Ht09WCU2PyLFK1TlEwYIMse+ncm
         4SZBZq8JsIcJAA3BejbyG3XoMkEZ1kA8GRf5XV28rMHBPacpX8XKT4uAsCCKt1oimPvs
         oZzr831NyGUWi7DlMtozkHrpvoQkPRaQOdy+0crx6QvzpgH0m11T56K20ABKlhSSjXAo
         5ZSwBhQzeGGAxZXyCbCHCQetBV399Pv3QgiL37QOR3ZIs5q+zIdEz6te3ZHIQlb48HjI
         y2gA==
X-Forwarded-Encrypted: i=1; AJvYcCVQD9Fif4yJYZkl0UHP1s4QsED66T0qV8OANytouxKHc7FmwrixNeS9NWc5wi1fMW/B1rSpsTSK411OhiSwsA==@vger.kernel.org, AJvYcCWqkdDNfj3qG1P0kh0Cx4a2xhwRnM0lSQXX2obexIxQjpwUUOprVCWnFX57A8kPMo2a1Zo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOp6IPhNuzate+3b1mANutgvnsro5ADuxoMpsV+huwhf5mMug6
	57ONdo8zoOUdLfnYnL/aYoR44lu2n/vMA+2VNECv6V6mRFCfH2XN/4yrN7itNQEBvXeTdw/q2dG
	Bj7exZg0TsYcR96V1I5MUXrydfiA=
X-Google-Smtp-Source: AGHT+IGNFFfSV5AzoVUb/VGoH+gT5VlSx5Gqh8PNNpR4tywpDctd12k3INIS11n0dR68OD3hIeEPgk/AcLgJPxGH7Lo=
X-Received: by 2002:a17:902:b48f:b0:1fc:57b7:995c with SMTP id
 d9443c01a7336-2076e36cc53mr58325655ad.7.1726186269844; Thu, 12 Sep 2024
 17:11:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813230300.915127-1-andrii@kernel.org> <CAEf4BzY4v6D9gusa+fkY1qg4m-yT8VVFg2Y-++BdrheQMp+j6Q@mail.gmail.com>
 <20240912235756.GN1049718@ZenIV>
In-Reply-To: <20240912235756.GN1049718@ZenIV>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Sep 2024 17:10:57 -0700
Message-ID: <CAEf4BzZpkZfkpHozso8myJ=2kOxto0fXPew=XVLu=wXi8bi4iw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/8] BPF follow ups to struct fd refactorings
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: viro@kernel.org, brauner@kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, linux-fsdevel@vger.kernel.org, 
	torvalds@linux-foundation.org, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 4:57=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Tue, Aug 27, 2024 at 03:55:28PM -0700, Andrii Nakryiko wrote:
> > > They were also merged into bpf-next/for-next so they can get early te=
sting in
> > > linux-next.
>
> Umm...  I see that stuff in bpf-next/struct_fd, but not in your for-next.

We have a new process with for-next and my merge was probably
accidentally dropped at some point... But there was definitely a
period of time when these patches were in for-next, so they got some
compile-testing already and should be good to go.

>
> > Can you guys please take a look and let us know if this looks sane and
> > fine to you? I kept Al's patches mostly intact (see my notes in the
> > cover letter above), and patch #3 does the refactoring I proposed
> > earlier, keeping explicit fdput() temporarily, until Al's
> > __bpf_map_get() refactoring which allows and nice and simple CLASS(fd)
> > conversion.
> >
> > I think we end up at exactly what the end goal of the original series
> > is: using CLASS(fd, ...) throughout with all the benefits.
>
> Looks sane.

Alright, good to know. I'll follow up with BPF maintainers on the best
way to land all that, thanks.

