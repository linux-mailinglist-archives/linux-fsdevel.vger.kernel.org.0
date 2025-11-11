Return-Path: <linux-fsdevel+bounces-67899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB58C4D077
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 11:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD52E189DB51
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 10:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462F234B68A;
	Tue, 11 Nov 2025 10:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="S677OMUs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67BE34B674
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 10:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762856911; cv=none; b=IOW0Zm+BYHuIv2pJmmny+EBdrYELswPlQkH4u9Ry4QREyPMzudR3g4DrnyeTmEqfZsMfRPgf9PgJc6HL1dIA0I0wb4DL/F3TRr7ObSzM88l80zR6eIriv7SwnmrtSX45+9yQPrO1KsPqAHMXZYqig/C0z3yXHurTz0/pSAjLp1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762856911; c=relaxed/simple;
	bh=AFJjiFOvGyHo0S6e8akF06HQkuXboJRcqUguRvorBaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qo1nD7SYtRLDnO6MlXtbOqCjHbC1rFuXtsMXNMMt0KMzl6H9XTlgARTo466MW8MDyRz+i/kkX5IbIzkVC+7aKTOLLF1ql8P0H9DjBrW4DsGUvktFMR5ZCKcXfiwxHwYG6WP+johiqwuBJcxSuGPBb3m28sqxgT54V1aUx/trv+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=S677OMUs; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4edaeb11634so20277981cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 02:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1762856909; x=1763461709; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h/p7mEepN8jUuWyprYCkVkbNxCuAN/nU2Y/T4HHlQA0=;
        b=S677OMUsTqJF1qJWtI73xM3czE842pFDa4Z3u6wgcHg/XV9/ynva0/WZAQSUJTVye3
         RAw/yyuEH0ysJcdYdNkFWVhuAC6gwvAe/aOJifEx4sjXEwAkhG5vctExTDyw9eYdZTpx
         KoJTGHwJutDyzWwASbXuKTO+L6tY34jBFFhG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762856909; x=1763461709;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/p7mEepN8jUuWyprYCkVkbNxCuAN/nU2Y/T4HHlQA0=;
        b=jH8Z71YlIYRQXZn+QNq+/veJE8up8MF5NA5Bdozkbt0gLFWM51NGb96bUiscgkCQC6
         loYWBRZHWCDqxMS6qXVM7w5gWvm40bBCyhonh67JAUWHh9npMwVi+3aFm+smhQ56s+QD
         oOg8gyvV2HTmty+ufvgKGpbTBVbJcSscbf/oP2d38+udPIeO+7ns+0GeBpXUSzoGpPOK
         3sG3qRQpDfv0ydBw+FWGAUppSlL55C3GtG1RhCOfv8nvdbr6uu3WXA7oPMMjJnYj3LVV
         BcV67BJSbE7oVU3HjAL87vgbINhhwZTjKKMRA69cpIr3RaxMdTFT8giN4n/GBdv4N69J
         ut+w==
X-Gm-Message-State: AOJu0Yx9iWCWc1DlMAsp2XfwqXoaT5RFbtH6SgQHhgQtecRAbLdlYRmd
	WqJtUqeee+K4/A5hIixOs1NPvGqJIW+lHwQgktXklpYUciJ7yJFrJs3scHBJvNBm4PiOa3eSYgb
	10IhlvCRb2OWSgkffu5rNiasqmUlWKe/EAFi+sWqk/A==
X-Gm-Gg: ASbGncuqEnPpD1NrFbvXUUwNvHMfmLF3gbgVfZFP8j5ogX3vhY7nXcA03HK1aqauggd
	KTgJgNs2l4+Q5ru3oR3FgI8GN2dPFHl34TVFO/Wnnc2JAiK3aWLK77d5ifn7eqjri0givnNm4qo
	G+M2hripkuBvFOHekJ2xLNyrd+xvQBRDCGzvOHGNooFoHkVJ+df1cIRXjB4coE5B3bIalAfdjGi
	QaijQitVtEBVm13hG3sgg55mvvkEMOCeMN33vubtUfZc60c+jdPKAbAKI8=
X-Google-Smtp-Source: AGHT+IF2jsXtOYznzAlKiswAAYjfBT86jbKpGaMbobTgICmObIV//j5aCRxdPYkP+19MfGrAnajQvcSXxRuiu1TbWoM=
X-Received: by 2002:a05:622a:1898:b0:4ed:602d:dfb8 with SMTP id
 d75a77b69052e-4eda5043040mr135933731cf.82.1762856908949; Tue, 11 Nov 2025
 02:28:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111065520.2847791-1-viro@zeniv.linux.org.uk> <20251111065520.2847791-18-viro@zeniv.linux.org.uk>
In-Reply-To: <20251111065520.2847791-18-viro@zeniv.linux.org.uk>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 11 Nov 2025 11:28:17 +0100
X-Gm-Features: AWmQ_bl7He3VQsld2UXN2E831Naa9ot3hmwpZMaWScQnQVWsufspzsog6zo2yMQ
Message-ID: <CAJfpegv0jMq96xD8gSbMBydj=1wRixVGy+qd3feC2vSSn7v_rg@mail.gmail.com>
Subject: Re: [PATCH v3 17/50] convert fuse_ctl
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	brauner@kernel.org, jack@suse.cz, raven@themaw.net, neil@brown.name, 
	a.hindborg@kernel.org, linux-mm@kvack.org, linux-efi@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, kees@kernel.org, rostedt@goodmis.org, 
	gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, paul@paul-moore.com, 
	casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Nov 2025 at 07:55, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> objects are created in fuse_ctl_add_dentry() by d_alloc_name()+d_add(),
> removed by simple_remove_by_name().
>
> What we return is a borrowed reference - it is valid until the call of
> fuse_ctl_remove_conn() and we depend upon the exclusion (on fuse_mutex)
> for safety.  Return value is used only within the caller
> (fuse_ctl_add_conn()).
>
> Replace d_add() with d_make_persistent() + dput().  dput() is paired
> with d_alloc_name() and return value is the result of d_make_persistent().
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: Miklos Szeredi <mszeredi@redhat.com>

