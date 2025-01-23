Return-Path: <linux-fsdevel+bounces-39937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A42A1A5BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 15:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96C9F169437
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 14:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59193211464;
	Thu, 23 Jan 2025 14:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="XeTQsSu/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968E313212A
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 14:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737642499; cv=none; b=A1/YmjoMNpOXLoLciqYl0AYsVjLHj8XdERb0xse+4WQ9j9+y6AiiLSXL8Y+ZFnZQxOC8Mbxt2RTXRmn46IXoN0tLX5TjuOB8ZVkIdJQQPcpRiO9ejZvxmpziWwa0cVFUsNmNReQteTI12xbxvrADWrcHyth711sgVv9iWbquCBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737642499; c=relaxed/simple;
	bh=4HNonndWgNRc+n2MqNkc8AOofKkvioSnQVyCSJcpztE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bhpnNcr8eqFXmKPDGHHtgp4YAci9U80oRSJBdpDL0F/9AJtcOUfO058UHzoluAghVAdirQ7kgU874NWQt1T1703Um2QG/xaHCcCmKDfxjDuT39ul/CQMC/kaqXRsoEqM+6tlkPSuL980CFTDvxJ8Yf6awZX/5Clk33mU7Nm50ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=XeTQsSu/; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4678cce3d60so9547561cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 06:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1737642495; x=1738247295; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4HNonndWgNRc+n2MqNkc8AOofKkvioSnQVyCSJcpztE=;
        b=XeTQsSu/z+bX/92dI0eJqMa3Quc4Ixgsw50t/l1kLUfPFcGqYXGq5QNmwiqGahKhRK
         K7ed6fE7z4B8FrUUTb8oP2SH56327/jZaKtkcGHJ/DwaJFXLPKVux/tJtSUPbFadJ7i8
         NCjHOtSKvb/W+GaS+bLlZ1Vg1iGpPEzxHOPHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737642495; x=1738247295;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4HNonndWgNRc+n2MqNkc8AOofKkvioSnQVyCSJcpztE=;
        b=LHrRKQ8RpBqR0CfS1lG+txCbJg9uJAIEfhpQ1fw6ybwlCrww+sxgado4bIhN7s3Kuq
         125gpCpnih2/w6mbxC6jkTrOCyMPsb81EbVvVhki+39ZKpjy2XTFglV9tDYYO3PqT2JO
         dS5J+sCL6RbOccfdurv5+zNGutjRW8fIqj1qYSqpNgBtHaB+4m6+vdLlrRwKORCUKnLt
         JOc3O4jnn+Wtb4LvqLVm49YXzk0J2aj5F++6kGVvTmdblxEP449A3NA7E/OdcsHmqmtv
         PsjCEI8b5zITFyfr/FuGOnPgKAr392bcp9m/GKy9wxGXrK3ESoAWLqPeTipV/MVnTf/H
         EM0A==
X-Forwarded-Encrypted: i=1; AJvYcCWrkotToAzZvzLCOAzGLdK1nFGdLe7zMhvagxYk8MPQWdMrrWJYFUBYt58PyxE29t4WNQyg2Z7j4jcDdNrF@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5QoT5bZRkW9YiJQj3Kt9xT4/6vKb0u0Qw2wezN2ikCCErOaDz
	gTkQxN8HLzcXs4zby1u+N31Z+7c7ttBmjlQoSoy3ucXpGWl2B8RqMnIoLEp+17GLm61Xv9Fr/mI
	AvAsbOrPydT/nnqo9e81ukcmWsmNHGLS8QzemFw==
X-Gm-Gg: ASbGncu1Sa6E0TQz0XK7mDjI57HUJTturzqXleWVlJgc1okWOIMYzDxcBGZn+SCm0Ul
	vmW8SQ2j8f+O8ew7obR3aCp5CbmDXLw/A2Xerevn8aQRyIMj1azT6xtKXYPzS
X-Google-Smtp-Source: AGHT+IELipZ0rSTsUriIVTxYEJ6hdJoaBkrxk5z+Drz+L6Nn4D0G/VhskqFDKE42gyjKl14sgCQvsk557Dd9r/nA6cM=
X-Received: by 2002:a05:622a:1820:b0:466:a824:751c with SMTP id
 d75a77b69052e-46e12a9cabcmr348452161cf.29.1737642495404; Thu, 23 Jan 2025
 06:28:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122215528.1270478-1-joannelkoong@gmail.com>
 <20250122215528.1270478-3-joannelkoong@gmail.com> <87ikq5x4ws.fsf@igalia.com>
In-Reply-To: <87ikq5x4ws.fsf@igalia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 23 Jan 2025 15:28:03 +0100
X-Gm-Features: AbW1kvZ-h-up3M47ByIxcXde9gefokGZjwBFDsrdaSjXzfgIWXqo2L_pSXPU1Hg
Message-ID: <CAJfpegtNrTrGUNrEKrcxEc-ecybetAqQ9fF60bCf7-==9n_1dg@mail.gmail.com>
Subject: Re: [PATCH v12 2/2] fuse: add default_request_timeout and
 max_request_timeout sysctls
To: Luis Henriques <luis@igalia.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, laoar.shao@gmail.com, 
	jlayton@kernel.org, senozhatsky@chromium.org, tfiga@chromium.org, 
	bgeffon@google.com, etmartin4313@gmail.com, kernel-team@meta.com, 
	Bernd Schubert <bschubert@ddn.com>, Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Jan 2025 at 10:21, Luis Henriques <luis@igalia.com> wrote:
>
> Hi Joanne,
>
> On Wed, Jan 22 2025, Joanne Koong wrote:
>
> > Introduce two new sysctls, "default_request_timeout" and
> > "max_request_timeout". These control how long (in seconds) a server can
> > take to reply to a request. If the server does not reply by the timeout,
> > then the connection will be aborted. The upper bound on these sysctl
> > values is 65535.
> >
> > "default_request_timeout" sets the default timeout if no timeout is
> > specified by the fuse server on mount. 0 (default) indicates no default
> > timeout should be enforced. If the server did specify a timeout, then
> > default_request_timeout will be ignored.
> >
> > "max_request_timeout" sets the max amount of time the server may take to
> > reply to a request. 0 (default) indicates no maximum timeout. If
> > max_request_timeout is set and the fuse server attempts to set a
> > timeout greater than max_request_timeout, the system will use
> > max_request_timeout as the timeout. Similarly, if default_request_timeout
> > is greater than max_request_timeout, the system will use
> > max_request_timeout as the timeout. If the server does not request a
> > timeout and default_request_timeout is set to 0 but max_request_timeout
> > is set, then the timeout will be max_request_timeout.
> >
> > Please note that these timeouts are not 100% precise. The request may
> > take roughly an extra FUSE_TIMEOUT_TIMER_FREQ seconds beyond the set max
> > timeout due to how it's internally implemented.
> >
> > $ sysctl -a | grep fuse.default_request_timeout
> > fs.fuse.default_request_timeout = 0
> >
> > $ echo 65536 | sudo tee /proc/sys/fs/fuse/default_request_timeout
> > tee: /proc/sys/fs/fuse/default_request_timeout: Invalid argument
> >
> > $ echo 65535 | sudo tee /proc/sys/fs/fuse/default_request_timeout
> > 65535
> >
> > $ sysctl -a | grep fuse.default_request_timeout
> > fs.fuse.default_request_timeout = 65535
> >
> > $ echo 0 | sudo tee /proc/sys/fs/fuse/default_request_timeout
> > 0
> >
> > $ sysctl -a | grep fuse.default_request_timeout
> > fs.fuse.default_request_timeout = 0
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > Reviewed-by: Bernd Schubert <bschubert@ddn.com>
> > Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> > Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Thanks, applied and pushed with some cleanups including Luis's clamp idea.

Miklos

