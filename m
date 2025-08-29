Return-Path: <linux-fsdevel+bounces-59658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF96B3C06A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 18:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB0281C803B5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 16:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C7C322C9A;
	Fri, 29 Aug 2025 16:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="WHbTlLIZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC2A1C3F0C
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 16:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756484125; cv=none; b=DyZA8ivQmWxeZmt5QT8fhDZc7BoGTTHfPqvLEc5RAmC+2lcyS2suJlDqqDtiXqWyijGU+d++/JCz4WLoh6gwuS/PqPirSJchH41FkkhAo4BQs2kb1gb4ZxvFslHtFonEGHsFeOh6vdsaVwchWI1k7fJyvFh2qVKE1hB3oetUC3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756484125; c=relaxed/simple;
	bh=cGIShlSkFXeStjyVhMb1hrSwe8JZHH5VE1B5wRTXKfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nbhrtVgUsrpnJIOit9aVFOZSOhE2KXZI7bgZ5/yFVnEzURwWE0H87SIDH7a11a+2YfcP3vFnJRJFEFSSFI/BfcDz7eSAKlCYcZRYpwWRTro5MxRt+Ftf0zPLrgwaEScq1mPGaCMrsacXE/j/oBlDVXmm1cFsd/XQ+zS7hBcQs1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=WHbTlLIZ; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b2fd85d912so22430971cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 09:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1756484122; x=1757088922; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JUGOCOZBjlnFe3DbEhpUz4YJxkdtvxH3BB+qLZ8aIxI=;
        b=WHbTlLIZYja7J5WyEVh9BCcYRofiskpQE1jKlKSj1Pxb8LfGXOHCjsIcxbFR+PuTpv
         JJLmniywbNMuCzB2Rfy9aMFXCc5lLzjYCOqaat+jfqXpRBGUPGib5kcSmbSZ+QdXF2Hj
         ZkupohgZVmRbe2uUV5MSvibrivlXStKOOdVyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756484122; x=1757088922;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JUGOCOZBjlnFe3DbEhpUz4YJxkdtvxH3BB+qLZ8aIxI=;
        b=VoKeJVY6hl1kQ9Y8BJs6WleJcpBqnBvL2OZ6mOQmOz/eyQ3DMj0fFvHHSLC0sTvrOl
         q24VyvvsM2GEHrd6c6+BvFb0VkgmKmszLChMsf+HQ+d8nN0gqOtkeTxOCv7dlSXyMi2K
         X+srHjwVDZOWygn0rpaDYFwhAcW1cwbxvZ17OxO75MbjwBOGoTrxzH+cPeuOuSFMn659
         i2/rQRb39b8Dpx2YchmUklHSO6KSBu0ACCJlOIy06lGZEESV37sQovw0NBY61AI4W+dM
         uY6KXATeEzgY6Pqfl9Qqu7HGP0nNwEHeDLR6HDnWeO9zJaK8GAIbpP/YzA1rs0b/NADu
         fhVg==
X-Forwarded-Encrypted: i=1; AJvYcCWo/KUPgVStYDkllQvNfCQdfErhk++m1LjPkgCUjTrgNh8tD93M8vlEhAr3ETEWPqB0zAX9kwxJwMEDcU5E@vger.kernel.org
X-Gm-Message-State: AOJu0YzFFvXx7e94JGM4GHlcNNxqH8ICnK/js2Ata4stMJVNTa98Vb62
	BdVsChzXycan6GQIk/XvRKX2+cUhp73w0wS+l8sQVo1YWl4Md8SdJTv0t5iI37a6qzdjMVEcGCa
	jImaCoRNhzdf19OFSVTvavylCdJPLP7gSawNyrIbQlA==
X-Gm-Gg: ASbGncsa2GTjfAFPrljaPH1D7chF2ZfHM+tjTPSy2lECMAax7Ufa1Nomt+LpQRRL3JF
	hJo0L9/JGqhXHMxdh7HBSrrKJlGQptglfoUdsz2sUojZf9eZFku6DyA/PhMuhpEoW2xPAF6XEEI
	AUNw8rHn4EsISeddPTNpJ5PiH4BxAbsr/IijTr3n2nZy29LBMXMISd4W4EU4rutQmYwQEtqqECN
	/ePKMMCgMiPf93Er7satXggx6yJD0Le+dzkpGxe
X-Google-Smtp-Source: AGHT+IHETizgPNLBF19unAyNnYbf4a7rpjPFXKlVK82QUxjRoq/wCAjoHVrD3FtVBTEPSrZg4KwjfztUDHRiimB1wHE=
X-Received: by 2002:ac8:6f07:0:b0:4b2:8ac4:ef5f with SMTP id
 d75a77b69052e-4b2aab06840mr422258341cf.66.1756484121551; Fri, 29 Aug 2025
 09:15:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827110004.584582-1-mszeredi@redhat.com> <20250829154317.GA1587915@frogsfrogsfrogs>
In-Reply-To: <20250829154317.GA1587915@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 29 Aug 2025 18:15:09 +0200
X-Gm-Features: Ac12FXwDyWVhE-05U5Kp4FEV9B5Ij8wy2FFSydnW_ona4Cb3p6CwikJLR5u2lg0
Message-ID: <CAJfpegsxM+-OpNcfuoe4tThvULtDpyQpyB0MA6t4Bei1LChTrg@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: allow synchronous FUSE_INIT
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Joanne Koong <joannelkoong@gmail.com>, John Groves <John@groves.net>, 
	Bernd Schubert <bernd@bsbernd.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Aug 2025 at 17:45, Darrick J. Wong <djwong@kernel.org> wrote:

> By the way, how is libfuse supposed to use SYNC_INIT?  I gather libfuse
> will have to start up the background fuse workers threads to listen for
> events /before/ the actual mount() call?

Not necessarily before, but obviously in parallel with mount.  Just
needs two threads, one fires off the mount and the other the read.  No
other synchronizations necessary.

Thanks,
Miklos

