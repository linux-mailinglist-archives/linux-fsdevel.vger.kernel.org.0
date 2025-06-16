Return-Path: <linux-fsdevel+bounces-51798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAD7ADB971
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 21:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7273E16D43F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 19:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D40289837;
	Mon, 16 Jun 2025 19:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrqBp/8p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A111C700D;
	Mon, 16 Jun 2025 19:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750101515; cv=none; b=YhcDcQZ4zzdlM25/0Bc94LZwYYso5qqGPWO4RQqEmxqmwpM8O3F0HSl9DchYWxl+2NZysaW9VJSkfxQYIPmlLAeV/ezN3SzGbGKeN4/16JoymKycHxJyPPmolDOLl6P4O3u+Op+ZwJsyXrYeEsYT7F9dPmiTkRJxpOfc2uwzLLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750101515; c=relaxed/simple;
	bh=i3usSHq05lye4YAButT+z5zjsiYafSPrxVulHWX24jY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ITqaCMFGyzzS13T8tXVARISk0/H+DFM8lln6PSruEof8D8Q/4KMXbrSX5oSdCpCQZikl1Qgq20ZBsd6VwiIrdV3rCNTlTuXCLveWyY6X/uHl5Ug6cMzzaEYrPdBZdrZaamDL8tJUaWPZ1Stas4uuU5hHSqapoomJBCRGukrKbmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CrqBp/8p; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a44b9b2af8so29061261cf.3;
        Mon, 16 Jun 2025 12:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750101513; x=1750706313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MRscOyiPDdIukuM1LuwvCupynaovV01bVsU6lmvejUI=;
        b=CrqBp/8p49R0vC+7L5002kQ/xVhSE+LPmxqXbGy0c0TKUcCgYpJYisYVUO1ixf1QhT
         yYNkrb1MnMy2k7z8CwwJUqtsOIPIYbAK4DrfP67KpGEfePxKzrI31SRtiXLczOMxU6J3
         z3ygFOBRfdCMnuSUjkmOTFc12pi/rL7xD/RHkupzr0gTCrL/h2l6DSfa0bayXHmDSejM
         tqTfAZf4tkbBccousGGi8cPpx/L2Gt0QscmfLn8rLEvHjsSqv9yo70VjpVLGdttrxuo+
         ezZ31YGfSAU/ty9ZNxPyHx/TXytD2EsiBaj/aOlXzLTrqLK2W+1XytpHEBp1paYZlYFn
         GeVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750101513; x=1750706313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MRscOyiPDdIukuM1LuwvCupynaovV01bVsU6lmvejUI=;
        b=Isu/hitaXLyXinvDOhDLBmvQKMCmu2P29WGut5PvBk4RuBnX4jH8NibGq2ZhGtXK7X
         z7cq9jHauHM5r8moAM4r7ujHCWEQnxLdRAE+vkW4oUEAGavKcphqNuxyJlbY3Mo3VXNM
         TKpyyIxkUPskD8iY/0v5K0E0mhD8gETJAXbbqlG03ZhhT8RoZXyswUvhDoSfAYx/VLqG
         68kmmwxOJ9am5kWrRyd4j1AUluLJiEoNj6j7pDEFYC93G5g6zSQyAA5cbhB/EwbPrnVc
         TNbEhmRxOwy3MvMU21bB5GOBMaYeNaSWH91lK0CmzkZBnXwXg8GSYquu4CEFej8sCrmZ
         4+Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUegslpC5byuVEAkulOf0nv2PPMovafAAVba0nNVw8REcqGneTZXeqd/ogboc/KcszyFWj/Kqv3R6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5S0m279nJtZltAbC1097tx0fKrJmbYBMxrtnqS7shZqUh8nvA
	8xeNlZ1KkqMm5oaVhttqTBKVGX8BAHao3OQJHLePhlBFbhsukTUmJErJKFjWjNrRCRBA4t7OFJR
	47I/lg2Bga8bcqv1NtOpmX0yS4zPZ9UY=
X-Gm-Gg: ASbGnct0P4BHtb5bkgsm61+6YK/q458/PP5+H/pEV13s6qKr/uVIjPWfgL6JrRT0D7E
	ETj2LOfVrNiEsSU4DjOZ6TxBqu63cgDi01yOQGgHXlsbMFWd2L/mHVWk2Z1SobaNI7brBd5kiLi
	xYAsXULuE1H6zOtNBQdMp5R6FpkxuENxH+22KH77I8GOeKwgjK/A8pdoHwT1o=
X-Google-Smtp-Source: AGHT+IGanSFdRr8alb8GIG7qh8kKZrwi+dTnT8UozhNrNun6ozqmwD/7HzwczW9L51UIK/OrPnB5rwdNNKqCRXC9Jfc=
X-Received: by 2002:ac8:5f48:0:b0:494:b258:abbf with SMTP id
 d75a77b69052e-4a73c5cb7e8mr171859261cf.52.1750101513062; Mon, 16 Jun 2025
 12:18:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613214642.2903225-1-joannelkoong@gmail.com>
 <20250613214642.2903225-5-joannelkoong@gmail.com> <aFAS9SMi1GkqFVg2@infradead.org>
In-Reply-To: <aFAS9SMi1GkqFVg2@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 16 Jun 2025 12:18:21 -0700
X-Gm-Features: AX0GCFsQrajJX7sQSu2P1t4Ggo8n2ojaWd77hr2Ye9txQywDhy1VBaDBGUadOK8
Message-ID: <CAJnrk1ZCeeVumEaMy+kxqqwn3n1gtSBjtCGUrT1nctjnJaKkZA@mail.gmail.com>
Subject: Re: [PATCH v2 04/16] iomap: add wrapper function iomap_bio_readpage()
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, djwong@kernel.org, anuj1072538@gmail.com, 
	miklos@szeredi.hu, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 5:49=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Fri, Jun 13, 2025 at 02:46:29PM -0700, Joanne Koong wrote:
> > Add a wrapper function, iomap_bio_readpage(), around the bio readpage
> > logic so that callers that do not have CONFIG_BLOCK set may also use
> > iomap for buffered io.
>
> As far as I can tell nothing in this series actually uses the non-block
> read path, and I also don't really understand how the current split
> would facilitate that.  Can you explain a bit more where this is going?
>

Nothing in this series uses the iomap read path, but fuse might be
used in environments where CONFIG_BLOCK isn't set. What I'm trying to
do with this patch is move the logic in iomap readpage that's block /
bio dependent out of buffered-io.c and gate that behind a #ifdef
CONFIG_BLOCK check so that fuse can use buffered-io.c without breaking
compilation for non-CONFIG_BLOCK environments

