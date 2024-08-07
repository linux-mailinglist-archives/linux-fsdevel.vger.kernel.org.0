Return-Path: <linux-fsdevel+bounces-25209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA8E949D46
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 03:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEC94B2332D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 01:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DB81EB29;
	Wed,  7 Aug 2024 01:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rto8fesf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E71818EBF;
	Wed,  7 Aug 2024 01:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722993063; cv=none; b=Jv/OYNM9ONSYu7b7SYS0QlDtIarWLio/pmNpUWlIkpA8DPgtLpycinF2b7kwiKMkDeeZd7HU0RTtqZx48TzAQ1T1aT/VQzRJkQOrb9GXNUsRBYNHhXrddz2BQkF+1pHc1x6seo1HdHZokWY88ute+DKLrVmd00nVVA2XP98UiJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722993063; c=relaxed/simple;
	bh=9IpgKyEBlO61F/leSfjOrBSRUu9FJivf4kC8bqcMMTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PKZY3xgFOgfLXAD6t7kkH8qRzobesu3khA2A72bs/TyCwij1YetUVpS56K5xz2CvWshdUotuLN1rzZI+8p65XzaXhCdGJH+YHMNLed6IBZjW3IiBU72cVmlJaydsliyiLhpEagrOUNqgvNBJHOtMeDFYoeOY59rXKQw8odWJ7CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rto8fesf; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4929fd67c7bso349931137.0;
        Tue, 06 Aug 2024 18:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722993061; x=1723597861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9IpgKyEBlO61F/leSfjOrBSRUu9FJivf4kC8bqcMMTQ=;
        b=Rto8fesf52SU3B6oXhCsexUfxxV8zesqM5NqM50Arr1KqieSIyPat2LH0A6DuMtxb6
         FXIASRwn2cv+MJw7u0YoqM0uIq3SgkipkuhasS0k+jkWidTahNlylcXY519PKk1qD/lv
         fBOvVlxbVgRdWx1koB8jSp+RWomOIke3uP8KDd3V0gwnpkcCU5XyRIzPec+Qhwnc9AWP
         tB+jFWtz85ISrIkyGWor1TVnF+GIslUSQD8dSgz8ss1Ywy3X6TigQhy0gF8UEvBYaO81
         USXep5q26j7SJmoSWOmIKPnQDHypBRWZSl4JKm4JVKKdaUly4OMexVVQJPbETGj3BC38
         CVpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722993061; x=1723597861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9IpgKyEBlO61F/leSfjOrBSRUu9FJivf4kC8bqcMMTQ=;
        b=FJE0oH+32osung8P9gSalsQNwVmEeX3MVO6O/1cjj/RygXASPUst1QalbZjcMx/oQ1
         lIjTcQ2DDW2AN8nkph3rlunq6ujkQFogfKr5/WzNUPq+xeKTBnLrqK6Gwv/eu5BX9yXS
         hnB0WYssWPUwmpbC7VUcr0veXBiSVS5/pNW+h7aCMhn86Zrq4frIDmceUzqYeqXeRql4
         9RohihwOMJteqPL74LUCv/uaxaC4p+V6N79JJdYvX90SOVfKlggns7kXqlu8PHJolKHD
         6jMzWa7BJi0oSPzcBGhiPzVRXwoi1OWU+ny34QlaOB1LNxD5ve/0yqz19ZNiMQOqPMR2
         fIYA==
X-Forwarded-Encrypted: i=1; AJvYcCXP9pPIjQLeTTzhOpesM7b+SLLzEg+Qk4d+nQoOkPW0wqothFKJXo+jR6/BczEZ89hYkELaW1MwuSuZ+zo+3PlC1jFfC1Tgk7KgYuwp6G0TLV8WM+oBrUmJXDu9dHHUpihD0Eff96me0LWWaA==
X-Gm-Message-State: AOJu0YyjnoO92+Qgb3rJYbk80qB19hTLli6JusqB2UkiN6eRhRW+GwJY
	XXXuwCRRZ2yVB92seEG1OX4veaRvikik0I2KDQKNEcZjsqze3NpKDt66AsPVrDq4q03DsgR8IdT
	Dv0N5KLSSbl9R8j80MM/ELJghL5AdI8vj
X-Google-Smtp-Source: AGHT+IGXLTgSWfFw9XCYVXEZz+oLd2KJ++MOve/yUtf5+Nk352XREPSsMKL/zBTwhp+GsMHhFQrguEHsZJHS8y2L2DQ=
X-Received: by 2002:a05:6102:c8c:b0:48f:4898:f2a9 with SMTP id
 ada2fe7eead31-4945bf14ca1mr20606061137.25.1722993061343; Tue, 06 Aug 2024
 18:11:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805100109.14367-1-rgbi3307@gmail.com> <2024080635-neglector-isotope-ea98@gregkh>
 <CAHOvCC4-298oO9qmBCyrCdD_NZYK5e+gh+SSLQWuMRFiJxYetA@mail.gmail.com>
 <2024080615-ointment-undertone-9a8e@gregkh> <CAHOvCC7OLfXSN-dExxSFrPACj3sd09TAgrjT1eC96idKirrVJw@mail.gmail.com>
In-Reply-To: <CAHOvCC7OLfXSN-dExxSFrPACj3sd09TAgrjT1eC96idKirrVJw@mail.gmail.com>
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Wed, 7 Aug 2024 02:10:49 +0100
Message-ID: <CAKbZUD08vPU8iv0s-t5_Jigoybq9DMvZtTvFc7LfDkoBCziiMg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] lib/htree: Add locking interface to new Hash Tree
To: JaeJoon Jung <rgbi3307@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Sasha Levin <levinsasha928@gmail.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Matthew Wilcox <willy@infradead.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	maple-tree@lists.infradead.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 1:21=E2=80=AFAM JaeJoon Jung <rgbi3307@gmail.com> wr=
ote:
>
> Please check again considering the above.

That's not the point, your hash tree has no users. Please find a user
and show those big performance wins you're talking about.
XArray had the IDR and the page cache, maple came with the mmap tree
conversion :)

--=20
Pedro

