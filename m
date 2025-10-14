Return-Path: <linux-fsdevel+bounces-64127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A7EBD96CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 14:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E14071927DB0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 12:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC45313E24;
	Tue, 14 Oct 2025 12:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="GyyEVF0D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C17211491
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 12:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760445827; cv=none; b=e3F9sRAGeoQi+PKSFtnXDWH7+3eg7DrThfHxoucTKDE5RlMHLwa3sHaXAcCvrSb15Dd4a7AGyYIK/Mv6RGmCJx4+mct8oxI7sjxAWGGNE7HRr5JEnQa26E6dNuYuRXsYNH5zqBBE5/0q9/yCbWjsxNhzOlztvZFSPBpvYHVENuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760445827; c=relaxed/simple;
	bh=NCSyvzFqsRWIwdb2ZFV3sGd2UxItcJXGY/fYHe854rU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GkO6bhI1WYq6LSOM99mkMBAJZkNvaixnTOgYNZHoGuIUpMZVhZ5eunmpeQavRCxGsuvy/TV9/XMumix/zdRWD5jYMFIZKAzJlw1IOw09bb0Hnqv2kqQChiSSJVZExOhrwN5Ynb+hIhNenfafAnysacLF3+GpTM9/i/qovcR9hOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=GyyEVF0D; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-858183680b4so879125285a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 05:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1760445824; x=1761050624; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zg5nDf1lU2Lu0yIBtEqem77SfqDoSZE4X/mwOikYVIk=;
        b=GyyEVF0DDTTdvwCVv2ibU3JOhpQM/aJZbAPC3UiWsSZxWYmRDXy51XwioW0slwzJhm
         nLRpOx1V8gDtZV7aBIZA57VWemRU4u0m7WRQlQNHQd3BZZAG+rk8EDrW47t/sdhyANQZ
         yviC40kJVb0oIusyexg+OlEYJ+M7FDOlfGYe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760445824; x=1761050624;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zg5nDf1lU2Lu0yIBtEqem77SfqDoSZE4X/mwOikYVIk=;
        b=ogwLNV8wz7V4o0WT9qR50/4H2jQpXmVlb1RoPIm0m3dZ2pGciUEh+gOptm1TXTn+2h
         9qBbXow89fCGREviRWJ9iabIm6py3mjaAewnUovNK8xOSJZIkW9W13FmR9hqv8fKjZ4h
         TI5CEKIGSdCdqiFvNHZK1aMl+OeYKzaodjY92/VDM5a/d+spKeagBq3mFv33sRX5cboW
         ajiTBt1BxtAd7onT6nqLVC7WH+MMBztAqPWwboITeHuAeO/E8yGFF+QmDR0MTKnHjsiG
         ODxhohqXSyLXWnBL0l4+x3MUwDoAulTu+r0dsjMaLLg65qcR6FhaNmyXLkDWX2qQrCJ4
         IBWw==
X-Forwarded-Encrypted: i=1; AJvYcCVUMMFTuepIvDXkP1nhH7Ua75aMFHG+1QrQl3pXQLlCgDMLzofvR6bHx5l5y59sbTk3XGMGJt/8rYqI3BhS@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa+NrWOMJ4Bwuub6+n84D6mDG1YGc0P5W5+HTFW/shftoV5J6x
	BwZshpZw1jqpCFnQ9Ity1TId7MTxt8UUwKPuvPKcJ3P7FEcv3gx9sn6HtlAS6GxIP7hGReWvqkh
	OaV4Uctr9FV6ABnMgf9JjWS/UH+lFabSLVqtHYwdr0Q==
X-Gm-Gg: ASbGncuRxUZNQQrH9MzNltykNhdTv1nQO4Skm156VpSfM8KT/GKoXhG+Ad2Efa7KLnD
	6VFbKHIZ8z2a9P9Pzr9knxDAFvhfZx/azLzCG711oV1Q0h5SduJJIT3BSXYwDh+/J5HoKS4qCx2
	I1PBWwfO8LXuo9iYwFQvlsY26CLVG1nqFtkKqLjJugIyV9/DmOuJL5tSEhi5staZoDO/N4kgUtS
	S8tXNoMJDl7+d4JZjvX8VwgO8G2JZYwusw0dw35YSapAetqZ31gdakm4hPArboffImFnQ==
X-Google-Smtp-Source: AGHT+IFotZagUXmwunsrc6F0qIh8XxOAKfcZN39gGs0upydesG0aZnr0ML2n9PTQ8qPprd/tdeaQBA7Ie3ng4BHYjF8=
X-Received: by 2002:a05:622a:1e87:b0:4b5:e8c2:78d2 with SMTP id
 d75a77b69052e-4e6ead56981mr319904511cf.62.1760445824246; Tue, 14 Oct 2025
 05:43:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009110623.3115511-1-giveme.gulu@gmail.com>
 <CAJnrk1aZ4==a3-uoRhH=qDKA36-FE6GoaKDZB7HX3o9pKdibYA@mail.gmail.com>
 <CAFS-8+VcZn7WZgjV9pHz4c8DYHRdP0on6-er5fm9TZF9RAO0xQ@mail.gmail.com>
 <CAFS-8+V1QU8kCWV1eF3-SZtpQwWAuiSuKzCOwKKnEAjmz+rrmw@mail.gmail.com>
 <CAJfpegsFCsEgG74bMUH2rb=9-72rMGrHhFjWik2fV4335U0sCw@mail.gmail.com>
 <CAJfpegs85DzZjzyCNQ+Lh8R2cLDBG=GcMbEfr5PGSS531hxAeA@mail.gmail.com>
 <aO06hoYuvDGiCBc7@bfoster> <CAJfpegs0eeBNstSc-bj3HYjzvH6T-G+sVra7Ln+U1sXCGYC5-Q@mail.gmail.com>
 <aO1Klyk0OWx_UFpz@bfoster> <CAJfpeguoN5m4QVnwHPfyoq7=_BMRkWTBWZmY8iy7jMgF_h3uhA@mail.gmail.com>
In-Reply-To: <CAJfpeguoN5m4QVnwHPfyoq7=_BMRkWTBWZmY8iy7jMgF_h3uhA@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 14 Oct 2025 14:43:33 +0200
X-Gm-Features: AS18NWBEZq5lIkJh6Ip5P4ktSAZRhNTSUeKj8YqirfcTTiqThkysrWbf-5HPY1w
Message-ID: <CAJfpegt-OEGLwiBa=dJJowKM5vMFa+xCMZQZ0dKAWZebQ9iRdA@mail.gmail.com>
Subject: Re: [PATCH 5.15] fuse: Fix race condition in writethrough path A race
To: Brian Foster <bfoster@redhat.com>
Cc: lu gu <giveme.gulu@gmail.com>, Joanne Koong <joannelkoong@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bernd Schubert <bernd@bsbernd.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 Oct 2025 at 09:48, Miklos Szeredi <miklos@szeredi.hu> wrote:

> Maybe the solution is to change the write-through to regular cached
> write + fsync range?  That could even be a complexity reduction.

While this would be nice, it's impossible to guarantee requests being
initiated in the context of the original write(2), which means that
the information about which open file it originated from might be
lost.   This could result in regressions, so I don't think we should
risk it.

Will try the idea of marking folios writeback for the duration of the write.

Thanks,
Miklos

