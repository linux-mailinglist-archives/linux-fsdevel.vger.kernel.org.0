Return-Path: <linux-fsdevel+bounces-10608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6D484CC6B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 15:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 896C81F234C9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 14:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669DB77F12;
	Wed,  7 Feb 2024 14:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="AEM1TaGG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0817A727
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 14:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707315226; cv=none; b=uBQwYvLO/4olPcPK8Hu7teOLxXXEmfX0tRPf9HpL5koQY9AW675yKDBRIblbr9/msuXoCFCYAc6o27uE9/2rMI14dWMNHPjH7Wl4yuSHSb0mWar16bGHXG76NU7bmOQu5Dz4ooy6l1LidPqUlMIrn0r6RT2ogOQ7UCxxKpgrP6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707315226; c=relaxed/simple;
	bh=uDMXyMG6j9ONbezTC0mpLsB4ibSrcJDdL0htrYl1dP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YKEJRjWhJeGa1pMHXpiH3XddwyqG0PzS93uJYEFm4FrllVE1Cce3pspot3nE+QsBsWDhLorMYXcLVKo6WncQTc9Q1fKKn9BHszZC4KvG+w456SWtZhFJFEDmfpQQJ8hCnnY6q98nC60YCeT7z5X4F2olz0hwQFyB7aSa5DiYIg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=AEM1TaGG; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d0ce2222a6so2785321fa.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Feb 2024 06:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1707315223; x=1707920023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDMXyMG6j9ONbezTC0mpLsB4ibSrcJDdL0htrYl1dP8=;
        b=AEM1TaGGJL4wfEqm+2q9peXuocQIkjrQDjqZWUgmrqbKh2c6echwGBVUOkHYGtL1Jp
         02AhZevn+De6PN7zGsB819FgrNnk/pvSqHSCA7PPW//BH4iRu3GtCxMeDnF34BH9WieF
         R1hLL0ZneyOMPuS0eERh9ZDVSUIzkN/ZJ2rKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707315223; x=1707920023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uDMXyMG6j9ONbezTC0mpLsB4ibSrcJDdL0htrYl1dP8=;
        b=IXMONDD+Vwaufrj60kb4kh5NYm/WhtrU3tseg3KssrQ9vvHp4iEzvK2Efy3M8qSGYP
         GBqRCZ8ohr+tyfV+34IBvZ/+SAmeEunXcKGPEAl31ZXryXlorskwmNyh1gh7v8Poyj7A
         MfCukz/pSX7qJOFbV8sHb1POAdXi6C++lZELRopJyLXwUyLmu8f4glBYCKPsz6GBCmFl
         jxbkeyvWc3ENpJsSJ8GJnGkGA1cwDq1LWib+elkCFBTOImIqdYG5JylcbMpA7PZcIwWu
         jBnD1mdlVlFtLgdcm8pp1LreGS6U9Og9P0eEnCpu0FbmU2xFW34sizb/Z3aVT0zHizYe
         gXsA==
X-Gm-Message-State: AOJu0YykJW1X/tUC1VPv5I2YOAYEGWtbiWOAbnsOZtf3szlKZGAneBAf
	CBz0SLwWOkwRN6JkgAW3K5hoJ/nAuzRf5Kg8DCEBklhh974UQBB4r9rpqazFbxZtFCHRanPagVw
	rkYm3mVrCXqsL/8HVbDIRwYRyBnxUoBFrMNimnJ01Nj/R76qK
X-Google-Smtp-Source: AGHT+IED9YAP6IjuLO7QGzwihwwoadtsQqIErozgRiEhzKfXYz5J89hbN3mS6Tn00zxP0ae3LMxLBAw1f4m1Z4XB0YY=
X-Received: by 2002:a2e:2206:0:b0:2d0:5f90:2b29 with SMTP id
 i6-20020a2e2206000000b002d05f902b29mr4579555lji.12.1707315222978; Wed, 07 Feb
 2024 06:13:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206094650.1696566-1-quic_hyiwei@quicinc.com>
 <50cdbe95-c14c-49db-86aa-458e87ae9513@joelfernandes.org> <20240207061429.3e29afc8@rorschach.local.home>
In-Reply-To: <20240207061429.3e29afc8@rorschach.local.home>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Wed, 7 Feb 2024 09:13:30 -0500
Message-ID: <CAEXW_YSUD-CW_=BHbfrfPZAfRUtk_hys5r06uJP2TJJeYJb-1g@mail.gmail.com>
Subject: Re: [PATCH v4] tracing: Support to dump instance traces by ftrace_dump_on_oops
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Huang Yiwei <quic_hyiwei@quicinc.com>, mhiramat@kernel.org, mark.rutland@arm.com, 
	mcgrof@kernel.org, keescook@chromium.org, j.granados@samsung.com, 
	mathieu.desnoyers@efficios.com, corbet@lwn.net, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, quic_bjorande@quicinc.com, quic_tsoni@quicinc.com, 
	quic_satyap@quicinc.com, quic_aiquny@quicinc.com, kernel@quicinc.com, 
	Ross Zwisler <zwisler@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 6:14=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Wed, 7 Feb 2024 05:24:58 -0500
> Joel Fernandes <joel@joelfernandes.org> wrote:
>
> > Btw, hopefully the "trace off on warning" and related boot parameters a=
lso apply
> > to instances, I haven't personally checked but I often couple those wit=
h the
> > dump-on-oops ones.
>
> Currently they do not. It would require an updated interface to do so,
> as sometimes instances can be used to continue tracing after a warning,
> so I don't want to make it for all instances.

Thanks for clarifying.

> Perhaps we need an option for these too, and have all options be
> updated via the command line. That way we don't need to make special
> boot line parameters for this. If we move these to options (keeping the
> proc interface for backward compatibility) it would make most features
> available to all with one change.

Agreed, that would be nice!!

 - Joel

