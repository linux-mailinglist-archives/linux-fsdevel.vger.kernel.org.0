Return-Path: <linux-fsdevel+bounces-45363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B550A768CF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 16:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0491188ED83
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 14:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E665121C9E7;
	Mon, 31 Mar 2025 14:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="fimggTkT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43269219A90
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Mar 2025 14:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431872; cv=none; b=mGTfisig/EnPLp54KC3xGGQeSVyxxDs44axZYmm+QrukV3dI17+VhGu3aUz7dAFq3ku/b29Hi92EYJnvE8HvmyFTL8y7+JbMWnKxYsqDt2izDMGSoTE/x43IGShMKj9QFeUOy06yLACzAlZRzR7FIYanLVi+1TJMSAVXr1gw7CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431872; c=relaxed/simple;
	bh=71ViRkEbimtS68hEM0zCoPE5dIe42SS6+H+37bl/+78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QXjcqAEOjJGSMPMcHMKRvKSqUW9sQ1fIGgWI6pPSVzH1TGyf/zWbICNCq5lErAIMVg2L6Twja/wy2IQLER9FXg9axxPTc/YnvvgI3AdbCDcQQjYa/T9e+TWC0cr3CDoUwv/B4vR3XQpCtood4ZA9IrMRtyL3pu5n8BDcLuV9DoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=fimggTkT; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-476805acddaso49846201cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Mar 2025 07:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1743431869; x=1744036669; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CnXlPhrVT4wOniSOMU9J1q7+7W5L95cti0eD8SRQe8o=;
        b=fimggTkTWlhA6iBc4SA+aH9CJNoTCefyUgtTkfFMOzns+UEAkg4fPOj+2+p7OhOgvx
         p8iZuHm2pQt/BF/davaeJ+vw710AM54kI567Wqq2fz6ANMQyaTi92cUgICll94oyo2fH
         V5BSmz2JUuJkBWr88VL72GPE2LQTaOVzB90Hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743431869; x=1744036669;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CnXlPhrVT4wOniSOMU9J1q7+7W5L95cti0eD8SRQe8o=;
        b=V+h2ulQpCe87SC0w6i6Ya2M6QosNvMhXcz57vyANwEfHn2CcEsb5QvqcHLd4aLu06W
         LqCRzRwcFLP2ifjtKj83YeFXXudcM13FaQIT6M+hG2WZfFmU/1tc5f0OLwzUoF0wvVOw
         r8aG2j0TJKJwlCFb1uI89Xgz+JBDnLUgv1AIVuyhwgNwu2DVnH27bYYkhRj9m53VqRaO
         h9x3JIidHm5gSx6jQiVOmDXlxplIqxdbnqObQhIbV/ipC7K5OLKryN6xRiTVWMGXxLYG
         gWTkvCkvkWeVy7idNgsEIluVg39hjz0EGjIBZCssS+nqLVdTFd0uswQP5wR4FNzMzc5p
         Hz5A==
X-Forwarded-Encrypted: i=1; AJvYcCWI9FTfmKXsYR5C23NDneHF6p49iENwk4thSdOXjj4wH5NDWkoggpA0yhf66G3rh8xqvoGhFS0euGFeMAws@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx+53HJhkVUXCPHuVOg/Ym5+7qn9xTSW8t0iqzTwhn40C7tPMa
	b1f1LCXCAIhdbcFzjKTgrsMyM9TLitFCju+HEf3hH4HTzmlAWp97/uax0vaHh1yg5OFTPrqCQga
	s8aT1Gm9ZxBNT8H6NQBkyxPjK9A7c0J80JKVdAA==
X-Gm-Gg: ASbGncthmLsDrb3y12TsU94icGiPa2w/U+OzGvDmKsKZNd+5lP+h1TQvJtqzWAFKTXw
	U7qzobWf6Bq1Nwh9y9OkVms3D2gD+WNUJV9j8giCF+GCj/dRmydPbm1+WdB+laK3b71vbNj16zn
	rkaCacReydifypfS/LhzAwkUi23w==
X-Google-Smtp-Source: AGHT+IEkBtF6DxJsAOmt7pllervm4RbDQDU2pWRUVXX+g4joezBSh5bLHINtLSXf5x69ZDzR9B+6JxI/JcXzVbfuEj0=
X-Received: by 2002:a05:622a:19a0:b0:476:9483:feaf with SMTP id
 d75a77b69052e-477e4b4c5c1mr132914261cf.19.1743431869092; Mon, 31 Mar 2025
 07:37:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331135101.1436770-1-amir73il@gmail.com>
In-Reply-To: <20250331135101.1436770-1-amir73il@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 31 Mar 2025 16:37:37 +0200
X-Gm-Features: AQ5f1JoWhv7XoIQP7RwdVOIOm9srcRdTPQrUwCzk_3sXQKJ2Xu1yQu--3bOWOyo
Message-ID: <CAJfpegsXBvQuJO29ESrED1CnccKSrcWrQw0Dk0XnuxoGOygwjQ@mail.gmail.com>
Subject: Re: [PATCH] fanotify: Document mount namespace events
To: Amir Goldstein <amir73il@gmail.com>
Cc: Alejandro Colomar <alx@kernel.org>, Miklos Szeredi <mszeredi@redhat.com>, Jan Kara <jack@suse.cz>, 
	Christian Brauner <brauner@kernel.org>, linux-man@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 31 Mar 2025 at 15:51, Amir Goldstein <amir73il@gmail.com> wrote:

> @@ -99,6 +100,20 @@ If the filesystem object to be marked is not a directory, the error
>  .B ENOTDIR
>  shall be raised.
>  .TP
> +.BR FAN_MARK_MNTNS " (since Linux 6.14)"
> +.\" commit 0f46d81f2bce970b1c562aa3c944a271bbec2729
> +Mark the mount namespace of the path specified by
> +.IR pathname .
> +If
> +.I pathname
> +is not itself a mount point,
> +the mount namespace of the mount containing
> +.I pathname
> +will be marked.

This was the original version, but it was changed to take an nsfs path
(/proc/$PID/ns/mnt) instead.

Looks good otherwise.  Thanks for working on this!

Miklos

