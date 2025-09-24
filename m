Return-Path: <linux-fsdevel+bounces-62662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A6AB9B90D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 20:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23A0B19C4BBC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 18:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF3A3191CD;
	Wed, 24 Sep 2025 18:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="aCCgyhyn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412A720B800
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 18:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758739965; cv=none; b=ZQ88hPFSrKXLVEQIuPZmxjC89y/u0qCylw80BP1fHFn/EH7fC0eucVSNB2mzbM6n2Wk+qGD8gP2twVcLtUdDWOKRqYPHLBtOgOSh/3cNcSCJXRfBjaOlyt15LKjLEzWh81/sY0fikS8XtXNWZNY5SJLi8DRR/n//bEOmRJS9h00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758739965; c=relaxed/simple;
	bh=TrnfCbO733+lCXZrSFS09BJmX3fVRMEKZIVSt3/d0Dk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wpz3qKCio+uOb316YbjsY37HbHLa9uhxXHWDQRHkBOVFvVPD+0SkWJD/FXdTIW8heq2m0N782CEIV/UkNtIhLe5ftxkUlrgzaNVkWs+uN1lMDYODU7cro7oahFUVWCGjBxEnp+k//7SUSh71vuxJU7uy32bYg5C5WaApXjaaA6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=aCCgyhyn; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b2d92b52149so37310566b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 11:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1758739962; x=1759344762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GxaSlzLAtScN1zJhK9/qnO+REZ+0VCMj1JhA1WOFJSg=;
        b=aCCgyhynB3igypdVb3DPqjVcgWPnxv3ckeJreBI2LsAqX1tEbBcKqhazbLqacQCulP
         ixOeKFxJjcpMGY9bF+gc9KT+AgLAdGfiOqxfUPiN7d7CdkooNa++nhvma1e4O9iq0LCI
         JUADA9NJcDs1PSug+0z5oVsf3cd3ulS4TYGPDdcbK16CzKi3mcrlP3wlYTBtppzsjrYJ
         JesSyvkOD/09Sfllou60fBch+xUVDkE7KPhhui6aqbZoTfCT1MwoZK0s+VKmb6vh7JQj
         6QcMx7Tst7asfDqW+lmQHqlgzK4MnswKquyhGhwj4xgHvh2zKXd4y1T987R90DkggR+X
         bX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758739962; x=1759344762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GxaSlzLAtScN1zJhK9/qnO+REZ+0VCMj1JhA1WOFJSg=;
        b=nlUf2IR0ARLiqpGreztSByxxbEIgXotF1JpWP7PFBTXzscX2criZM/cFM7dThQMX8r
         n2oAmVDC2rmjTB5GlW2n27DLXeDDRbpTg8RpkLBoJC3h1HJpn30USouTZRT4D2Watf6m
         shvoFCUN3l5A7/a2h0xJW7fdy1rQ9cX/nJrFiItnICorW1gNbEK7iRdagmnWIyiXiKAn
         1bfwroUWs5A4heLoJ933Y6W4sS9jhcqh9MXpJ5XfC51zEJnE/f82W6XEMJz49JdlQ00B
         TltgpAjPNzyqnzgxJF3eIh1E3ijs4BN8nQ4WFjxRL6IflKa+qVr4b12TwhBTdtyNKZHx
         qlSw==
X-Forwarded-Encrypted: i=1; AJvYcCVs7ysZ+DPrh+bZL5BRsc44wmiV0oWMPq/+JwjMMAi6t0abT7w8JLsEMAHZtxHSQ4EiL5JQaf7awPgKG/BX@vger.kernel.org
X-Gm-Message-State: AOJu0YyybT9wKtJB/0BBBLegRgt/0P/taE0kI2CoHVeb1AWJ8LjFbVm0
	WxsZUqEbAiuPJDqAhqUMqcXRTEo2DSJHW580meJ5J1WYBcuKUyhqvwyjAgS3h+PDHcw2S2Xd4P4
	W4gDi90wG0Y0CFhnzJeNv0F1PPdyX3Oj+9+eQHvCO7haIaFKN4Rip
X-Gm-Gg: ASbGncuU15wDDIa+PZ2Yx/KiCnfvBM6GVWlZordFApP5uculy8dgoX+V1W1CC2/dDBB
	5jYmj49NzHGqBJvG0D1X3SRzDDaU92qawH3YE3RTVtLJYVPCsewN0GIlOnbQacfTxVUm1fB1ttQ
	vtil7WUHNpaDcEq30/kMgZEZhEje2Y3a9eKzk0VM83mCefSDW2Ml2jtD7ol7Lf14cDlKO4zp4y+
	YXkoQENEArf6LqUyiaWKZVXRTdiWctpNtc=
X-Google-Smtp-Source: AGHT+IEfLas0BqTe4LbLvHMPVeWuRAoGKff3BYuwff4/8Ek1I05jBqtCoUMSm2S1LlFiIk3FPlHI234+b1Girt9Hnx0=
X-Received: by 2002:a17:907:7e88:b0:b0c:6cae:51f5 with SMTP id
 a640c23a62f3a-b34bb8f1a7amr87587566b.43.1758739961642; Wed, 24 Sep 2025
 11:52:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911222501.1417765-1-max.kellermann@ionos.com>
 <745741.1758727499@warthog.procyon.org.uk> <755695.1758728366@warthog.procyon.org.uk>
In-Reply-To: <755695.1758728366@warthog.procyon.org.uk>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 24 Sep 2025 20:52:30 +0200
X-Gm-Features: AS18NWBX90PDeUbc5D76CTwvxhtp7GglnV1Nwwby_YGspEvXUsJA3vS2rse6AAs
Message-ID: <CAKPOu+9Ym+dRHQiMvjvdisnb5jwca4_2ECbzOMLYso=xNvxeQQ@mail.gmail.com>
Subject: Re: [PATCH] fs/netfs: fix reference leak
To: David Howells <dhowells@redhat.com>
Cc: Paulo Alcantara <pc@manguebit.org>, Christian Brauner <brauner@kernel.org>, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 5:39=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
> > > ... and frees the allocation (without the "call_rcu" indirection).
> >
> > Unfortunately, this isn't good.  The request has already been added to =
the
> > proc list and is removed in netfs_deinit_request() by netfs_proc_del_rr=
eq() -
> > but that means that someone reading /proc/fs/netfs/requests can be look=
ing at
> > it as you free it.

Oh, right. I saw the linked list operations were protected by a
spinlock, but I missed that this lock is not taken for traversal while
reading proc. I'll send v2 with your suggested fix.

> >
> > You still need the call_rcu() - or you have to call synchronize_rcu().
> >
> > I can change netfs_put_failed_request() to do the call_rcu() rather tha=
n
> > mempool_free()/netfs_stat_d().
>
> How about:
>
> /*
>  * Free a request (synchronously) that was just allocated but has failed =
before
>  * it could be submitted.
>  */
> void netfs_put_failed_request(struct netfs_io_request *rreq)
> {
>         int r;
>
>         /* New requests have two references (see netfs_alloc_request(), a=
nd
>          * this function is only allowed on new request objects
>          */
>         if (!__refcount_sub_and_test(2, &rreq->ref, &r))
>                 WARN_ON_ONCE(1);

You changed the refcount_read() check to an atomic decrement, but at
this point, nobody cares for the reference counter anymore (and my
check was just for bug-catching purposes).
Why bother doing the decrement?

