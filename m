Return-Path: <linux-fsdevel+bounces-39996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACE2A1A9BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 19:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A130F163E91
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 18:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5647615ECDF;
	Thu, 23 Jan 2025 18:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsiP6H+3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5322615625A
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 18:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737657768; cv=none; b=r4ocYwuFXXJoVimmdFNIQgc/zl88YaYFg8veL6iiG26pWv5EmJVRkkaGrQ4T18kqjkpoPRoCdtDQR1P4qMPd3+OmAkvlwVQeFXvR3VCuqe/ngvh+9AyUiNAGuIhvmhu2/LSv+6zsURv1kK1c8DNq6iHgHLV5hu+nw8SxcUdT6mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737657768; c=relaxed/simple;
	bh=GEqdJa+AeKnUwDKe+tUgZ8vQ7eysbeHuoBrqdotrsxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P/6efiXO9HNIY20OtitluNNBt5NmUDyzwkVOBLLZH7xasr6rZWEzoqd5Ss/xCGggpzazfK+3FWx7mIH1jXgVrWRcM4T8QyX6/B4zpUx7rf0OR3O+zwx8F0pYek+I+ywLK4Qhm7SMwnYyQp13iuewaHDRSzLwEfLMldKP+4YdI8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VsiP6H+3; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-467a3f1e667so8013211cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 10:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737657766; x=1738262566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCV9DApketHSZ2g5q+smESMpefS/mxazHMm0SjRO8wo=;
        b=VsiP6H+3GcNTw0FqgbO3B7vtMqeuw9NCatQWcJo9dV7dqATWwdz3ahw5+wb3AzpBpn
         6qNZPFjb2g1ZtlfH0zfmjrK1NQ4KOOrh2iPwzFL4+Y63Rbls3QwXOaQ+FnnV8e1Z8Jw0
         L840zM0+ryAemqRAzcnV/bnlEH0MAP/n9embj5AtnGiUXMsNp0+u2c79dFJzARi3Mej+
         GUr1lpJdVaHd7JmTZjeyQFydLZcYDWQ91G8DlTndkiE4Egq1iVMkpTAZRdUpI0YDOOPZ
         X06izhlBWOk3j30HLD7PHXTtu1le7md82SSiL4Nen0qOAhctlO56ynRfTZhfe1GkJZ7H
         e8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737657766; x=1738262566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jCV9DApketHSZ2g5q+smESMpefS/mxazHMm0SjRO8wo=;
        b=CbXiTPW078y/ij7HLUwLxuKX4x/nDN4cl23VPPnetSV9RXSIRqPEEqMlAMzVrVNi30
         0MApdNgXicu7SJH35yABHQES6nsOlJj3I1buQwyWZ+7BIPVre9l/rUB14KEHiwNULS6B
         aNDsaBR1fyDdgxR25cXhE9Uuwlhx6A/kR9vUYfi0xdkegJi5fvC0ubcyu98iH/h/5gbs
         VKTW9bT1b14q6gciPfGZp9EZ6GDbG6KBdJKsujtDuFh6GmcXLIlP28CNI1y7slCco3Od
         LJE7p3QLVyt/Rr4J7vdhRrSmmjRX87kPObMldNdeL5qYd8ROqB4xHuL7q0drPO13xkxC
         PVDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVH7KaEv+GPoq2MOeeasKm0iBUVQTCgEtOEys5n8x8qfPDHbA32Un93zGheF/DX5l1Drgzb2uVPQlWEi+Kp@vger.kernel.org
X-Gm-Message-State: AOJu0YwLKauXVPPoqGfzwJBPuIGsSLhyc9SSTFd2wBJ40LWN/uBpEpLV
	xHl05H7L2cuFI2Lv3XT/8wQztL0FB0/UKjJtqRY33L6qcUHZA3w8SFV4WLEtTTBFRWLbzMVfA23
	rFwjD3p1lENAlC1E4oCi2C1BPEtk=
X-Gm-Gg: ASbGncufuZ/jOAYMYYO2wjKRhKJUMX1eltiG0+DFcEvonNOUqQPQcaCKXfFm7FVtvsN
	trRw+gpN7ZRQtCIAnLIi/sQCiigseQxYNXrRiV6qPnaLf5GbOfA5/v+95WLL/lGKKj8SmvVGERW
	Fm2A==
X-Google-Smtp-Source: AGHT+IF9lhmCMATnI4kOq8hxdbFjow/TC0QxZ17dKYqiMvEXlGrgqO4euCB6ycTAgBxOkdAanrXjAXWj7r8ECPW/Itc=
X-Received: by 2002:a05:622a:549:b0:467:86a9:f7d4 with SMTP id
 d75a77b69052e-46e12a55d3dmr432903011cf.16.1737657766100; Thu, 23 Jan 2025
 10:42:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213221818.322371-1-joannelkoong@gmail.com>
 <CAJnrk1a8fP7JQRWNhq7uvM=k=RbKrW+V9bOj1CQo=v4ZoNGQ3w@mail.gmail.com> <Z5KJVtXwNsLdzLSz@casper.infradead.org>
In-Reply-To: <Z5KJVtXwNsLdzLSz@casper.infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 23 Jan 2025 10:42:35 -0800
X-Gm-Features: AbW1kva-kUEr_W2yjtDCULM2zS_zaJVWdIVzu65QekjmE0L13HC6t21Kl7OK1Ew
Message-ID: <CAJnrk1ZXQ87Mhiajmy7dev1P06T_j7we9MHB6H1bEXSWjXkKww@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] fuse: support large folios
To: Matthew Wilcox <willy@infradead.org>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, 
	shakeel.butt@linux.dev, jlayton@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 10:24=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Wed, Jan 22, 2025 at 03:23:08PM -0800, Joanne Koong wrote:
> > * I'm going to remove the writeback patch (patch 11/12) in this series
> > and resubmit, and leave large folios writeback to be done as a
> > separate future patchset. Getting writeback to work with large folios
> > has a dependency on [1], which unfortunately does not look like it'll
> > be resolved anytime soon. If we cannot remove tmp pages, then we'll
> > likely need to use a different data structure than the rb tree to
> > account for large folios w/ tmp pages. I believe we can still enable
> > large folios overall even without large folios writeback, as even with
> > the inode->i_mapping set to a large folio order range, writeback will
> > still only operate on 4k folios until fgf_set_order() is explicitly
> > set in fuse_write_begin() for the __filemap_get_folio() call.
>
> Maybe you already understand this and just expressed yourself badly,
> but what you've said isn't true.
>
> The fgf_set_order() call is about creating large folios during write().
> If instead you do a large read() (or do consecutive read() calls which
> get turned into large readaheads), you'll get large clean folios.
> If you then dirty those folios, we won't split them.  Writeback will
> still see large folios in this case.
>
> It depends on your workload how common a scenario this is.

Hi Matthew,

Thanks for the correction. I realized my misassumption after I sent
the email, so for v4 [1] I ended up dropping both patch 11 (writeback)
and 12 (turning large folios on).


[1] https://lore.kernel.org/linux-fsdevel/20250123012448.2479372-1-joannelk=
oong@gmail.com/

Thanks,
Joanne

