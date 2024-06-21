Return-Path: <linux-fsdevel+bounces-22140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BB1912C74
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 19:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD7881F21FF9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 17:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C74E1607A4;
	Fri, 21 Jun 2024 17:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OKGZ5AGK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FA6B67D
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jun 2024 17:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718991021; cv=none; b=Ol3EEk3BsAjecumsBjDDX8gCaNXK953HoWnWIlu5s4YsuPhx8lspLnbsSMBzZmojY7+wj3Ub+5M8AJYYtLRjw5VmPArZUj4RGzys3QOK+duNVs3516wm8D/zd6o7ewrhnKO+eY2TSZWGq0mjgImq1AHC8q+eIA8rtVYvx45QWDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718991021; c=relaxed/simple;
	bh=/1Z/V3pCZr27z4StOe08+bblvWTsckN3Z08VsiKU84U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N4ngPSko0hNv0wmvLeEGIQ95X8r22x/heYGEPtUwACvXIfw78faNP0O1KPHIQVRb1yITqAzGDnaV9Wyj8ufM333Iky9VmYt+Vdqijj5gO+TptGQ/JLJjw2ZA7c04AYM02VqSv7uZ8DaOLBB6RAVOLVK9LSbsz9Jv9X1SWKL2lFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OKGZ5AGK; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso22750a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jun 2024 10:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718991018; x=1719595818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1Z/V3pCZr27z4StOe08+bblvWTsckN3Z08VsiKU84U=;
        b=OKGZ5AGKhDo6Ma9m5lWJ0jJT9ILWTBYl2RT3O4GGsDNAr7Kks4EltrlKzkcXrinONv
         jrakJPAnbvZtXFJQFeex22xLZJvRZJg4Z/yQr/hyj6Ji2DVQvtlbc3DT9osyndEpPaHA
         KmFd0yUhlxdn0ECV8P+KENMvAJfYB2t4mw9T9uRP+3XaQdmxaArOB56o6HJ7+jRuZs8+
         BO36UTPJ0f0I4Pa1DlJ+o2MmOufKy6oOOjndB4YspAFppY3enabjsyCwS1jiYNGA5EOF
         dmjf40V8icmisAE11QrLq69Tw/zQ1pcrteRELBCFLUX3RcRYg1D4ot7rcZwXUZlK4A57
         ALaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718991018; x=1719595818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/1Z/V3pCZr27z4StOe08+bblvWTsckN3Z08VsiKU84U=;
        b=STyDb6zS8EP8TMcjoRemEw+GJqnqbRWne+FuaZyQG2yehnr6Q9nJc+itc9TgwmVMNW
         yfjLHgjXNj2TijDqdU/A/6a8PoVGa8AR4x1H/WMEkAgHp6S7RKRMSOa+N4ZZhLRlm1C1
         UBPlCQyoQCtlMIDWVtr9V4iXSZlZGN1WL3CecfN4MDBo9CWzu2jA7/n2bFFktdGhXCuG
         09ZCqkkLXGz9qZIImJLZbystJZfDioWpOBROqkaj9hRHD7XAGLNiTzJmA7dzigXpHCSv
         FyEmC+jFrBIMQmU46aIZsfEihYVeGMNNr8su1Szuuac05QC30wWeQOL80sFyYFlzMrVw
         L0Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUACzAqwB8IWiwT+JJ4JN6kfqN4PlZc5DzR+6enCCaGZ7psb4lMKBvz5/gyKhTx57dqIYUjxZYViqvVKB+TqlpxaFX2h/cCZz3tVXKynA==
X-Gm-Message-State: AOJu0YxoyYqOQqd3BiJTc6NOySSCaHVSaGmVaS5R/8nf5nB70sqinUjH
	gAWpMPbkL2gRqqWvWowuzX6HdH2NlZabShayjxzL+GlgU1C/UVccHWlN8Y3oYvcFqTkLjbHs1bE
	aHLFdNr9YHZpx2KZ2DDFnmulrSPKwdv3YaAwWB0j7TZurxTlcQyBS
X-Google-Smtp-Source: AGHT+IFCqhqWyFw06uhWIdpoEoci5WQ84TqCrDo7xDu6Un3b/I5G1wLJTN4tyEMXlmp7ovol4oJY7zRNpVLDwuLsN0Q=
X-Received: by 2002:a05:6402:26d4:b0:57c:b712:47b5 with SMTP id
 4fb4d7f45d1cf-57d3f5fbf99mr20040a12.4.1718991017488; Fri, 21 Jun 2024
 10:30:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621144017.30993-1-jack@suse.cz> <20240621144246.11148-2-jack@suse.cz>
 <20240621101058.afff9eb37e99fd48452599b7@linux-foundation.org>
In-Reply-To: <20240621101058.afff9eb37e99fd48452599b7@linux-foundation.org>
From: "Zach O'Keefe" <zokeefe@google.com>
Date: Fri, 21 Jun 2024 10:29:39 -0700
Message-ID: <CAAa6QmRev5nwPKnr72rpmi4vjMsbJSR4eGfA_-Bf6hZx-M8adQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: Avoid overflows in dirty throttling logic
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jan Kara <jack@suse.cz>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 10:11=E2=80=AFAM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Fri, 21 Jun 2024 16:42:38 +0200 Jan Kara <jack@suse.cz> wrote:
>
> > The dirty throttling logic is interspersed with assumptions that dirty
> > limits in PAGE_SIZE units fit into 32-bit (so that various
> > multiplications fit into 64-bits). If limits end up being larger, we
> > will hit overflows, possible divisions by 0 etc. Fix these problems by
> > never allowing so large dirty limits as they have dubious practical
> > value anyway. For dirty_bytes / dirty_background_bytes interfaces we ca=
n
> > just refuse to set so large limits. For dirty_ratio /
> > dirty_background_ratio it isn't so simple as the dirty limit is compute=
d
> > from the amount of available memory which can change due to memory
> > hotplug etc. So when converting dirty limits from ratios to numbers of
> > pages, we just don't allow the result to exceed UINT_MAX.
> >
>
> Shouldn't this also be cc:stable?

+1 for stable, following previous attempts to address this.

Either way, it seems this closes the door on the particular overflow
issue encountered previously. Thanks for the proper fix.

Reviewed-By: Zach O'Keefe <zokeefe@google.com>

