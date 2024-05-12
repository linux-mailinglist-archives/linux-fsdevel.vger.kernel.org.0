Return-Path: <linux-fsdevel+bounces-19341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B128C34F5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 May 2024 05:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2677281740
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 May 2024 03:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA165CA40;
	Sun, 12 May 2024 03:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNNRjOml"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B04B656
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 May 2024 03:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715485028; cv=none; b=aU0A3EbLq/a20+NC8dAZiDGt8iGpzvsm2UNHC5ufZF0sW7t3P5V9tSpuBmTDIj2UYfKz1kdcxnmZdDjohQhTzn2BTJa/tiqT8w020zObcMzwoEppkeYeCv5bGlrS9D5yINGb8kQcbF9kfNmIcHCOz4GTzMZKJhsO4xI+r3BPJfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715485028; c=relaxed/simple;
	bh=R59Y5LxnSORnHDXqkwtdRO9F4ZW+yXcwka0oie9fnhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VosAjPXxcYxr5sBum+/iCcxhDXbdwcmFQ/jPlBHrsvy4uyycYy9O/82FEG8L1esXXkSKCdKPv4Q+izeLiClEsvT13Svq4+lC6hzf9KCscwQs2CH42BFP56mjXKV2NJNZBMzvFJrXjYrqUGBDZ1VdBKlKcqQmTq7B9JnV3jbS73w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNNRjOml; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-792b8bf806fso269442585a.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 May 2024 20:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715485026; x=1716089826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mzhEdqsZjmpOetLlD2+yruIF/33EUuUUb3RnT/hNwQ=;
        b=gNNRjOmlvf3G1JwHMaTeC1sM4tHrSsVxj0E63yN1L0jvrI2npqpDLxMC+oIhzOQSv1
         SGTneXrqY/7E2G+pO0/rg0jtqhMP4u3FXEsyqcUKbUBH41hXjv/ADyJhtgx4hiPl0kEt
         GejCq6Lvm8sU45A7P/6TQomKoCW5bXfI5Qn1sC4otQSs7aRr7dfnTM06Stxo1lp35nep
         +Pazi3dRiCOo9PO+Ui/2ahr/qKF66DQC/L3Uck3Of6Rsefoalc/S5oG8JbyV3Oi5fqin
         xI+sXJLAyiKmQYc3dhr1xH4OGtoLA00Ef5q21rZwvb59mRAKHe1kqJ8B5gcbOphdCswR
         r2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715485026; x=1716089826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5mzhEdqsZjmpOetLlD2+yruIF/33EUuUUb3RnT/hNwQ=;
        b=nIJfqLrgDzziNVASNXG4z87cD84YY1hiAmGeuKwxkDl6VJ1IlAwTHRcYf+911O7QA1
         MKuV1RGaDldl2+rZ2t3QJNuo8oAFYBOUhVui0F4YEdgD2KONHDiAAd+iT0aXP2cNkD5P
         GqEEFneoRgL4j5YR3QZKYFX6ZgqE/1E51pBPfl7b5sFU2Vzyzwkbboj2SfHZn1BMKuXO
         +uKsNxvMKP7HFOlG+zekk1Lr847l5VRSxq2dtTdUefsLDGPNTyKrmULqzmv8WW3GaO4L
         wKUVnIUhkdljeax6OVnTbRwa63HBSpSUFd1EU4eoufcIEbr3OqC7Sf+uwalNpgrw+8D5
         G2Nw==
X-Forwarded-Encrypted: i=1; AJvYcCU81qSSW3StpIAfU4uoFioXeDCDCgsF2kKC74ZVA4QyWvn86wUuUkBrSHmDs5GNfe0+thNNLhbIDph3rc57A/AO9m3g3Nzt7Iwyg5iqpw==
X-Gm-Message-State: AOJu0YyQzC1tCfh0d6GiIWZfjBWmWEl44YIbC9udNR8YoEfcE7CrlenJ
	v+ytII5Rqcjpi1dhjD4lNCFiPA0X4zNIOYLiuRkdrRYTMg+TDlVPCM9fPk5ZsnW1W4+LA+odpcL
	7ec5DRNX6uNmR52vEALjjZNPk4GM=
X-Google-Smtp-Source: AGHT+IH8fl9sdYHCpHc2vEDtwqEHLUiePGS+fl4NfOmrMM+x1ABDFQSDpKciILUwk9uX3y5Kq9TjUkf21N6df+NDVOI=
X-Received: by 2002:a05:6214:5d05:b0:69b:2523:fcd3 with SMTP id
 6a1803df08f44-6a16825d79dmr81619836d6.60.1715485025718; Sat, 11 May 2024
 20:37:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wijTRY-72qm02kZAT_Ttua0Qwvfms5m5NbR4EWbS02NqA@mail.gmail.com>
 <20240511200240.6354-2-torvalds@linux-foundation.org> <CALOAHbBSRGViePQm45upEJnUNnOa1=ZjkvAT_tR6jXMTEKUSkw@mail.gmail.com>
 <20240512033053.GF2118490@ZenIV>
In-Reply-To: <20240512033053.GF2118490@ZenIV>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 12 May 2024 11:36:27 +0800
Message-ID: <CALOAHbBRARKu3Z95qWVaHZbPwKMcVqDr8EKb4FVF=MJzoigRSg@mail.gmail.com>
Subject: Re: [PATCH v2] vfs: move dentry shrinking outside the inode lock in 'rmdir()'
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, longman@redhat.com, walters@verbum.org, 
	wangkai86@huawei.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 12, 2024 at 11:30=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
>
> On Sun, May 12, 2024 at 11:06:07AM +0800, Yafang Shao wrote:
> > This could resolve the secondary concern.
> > Tested-by: Yafang Shao <laoar.shao@gmail.com>
> >
> > Might it be feasible to execute the vfs_rmdir_cleanup() within a
> > kwoker? Such an approach could potentially mitigate the initial
> > concern as well.
>
>         I'm honestly not sure I understood you correctly; in case I
> have and you really want to make that asynchronous,

Exactly, that's precisely my point.

> the answer's "we
> can't do that".  What's more, we can not even delay that past the call
> of mnt_drop_write() in do_rmdir().

Thanks for your explanation.

--=20
Regards
Yafang

