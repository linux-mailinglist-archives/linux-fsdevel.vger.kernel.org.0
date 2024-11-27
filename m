Return-Path: <linux-fsdevel+bounces-35972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A179DA6C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 12:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBE6B164AD3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 11:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE291F6675;
	Wed, 27 Nov 2024 11:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRn4FAAc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A337F1EE012;
	Wed, 27 Nov 2024 11:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732706517; cv=none; b=VD66z1jje1+igg59a1wnPBpyCJgwgjziFtdbRBDvKmNCUs8mUK+bF/IeDXi1OkY3GVmYFLfKmAxg5XIe2sgM1Poa3zMn6bp8Fu5gxDVgm0L3Mv1CHerNxe69wM+bqxrH8DjfYP/QCBuH26MyP4KE8eC5FT4DF9Tvh5dNcj0dHHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732706517; c=relaxed/simple;
	bh=8+jxdjMxeCxAwzyVZxUV+2/WcnmyC99hPA5a29GYKl8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMYnuId7M954m1WArLPc/c0A9rtdXApYPjsTujGTBMigCTj1xEkCUzh3/4yn7uNDp6UsfYSaPthMaOXMK4WJWa2miYonTiPlFrnFuNrY4tx2p0nqG6UORPuiENpTHorKB4ZO8dt80f2V0seE2S+N8zbk1C0tq+/qKd334ATifcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRn4FAAc; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9a68480164so909049366b.3;
        Wed, 27 Nov 2024 03:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732706514; x=1733311314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=elVChWAOghJtOr2/9ffIty1GUC4j4pc0XNnLNMpNrcU=;
        b=nRn4FAAcgu6pKlL93uzV2g2lvtDzfMEkgJFRIxeR/X4C80vY4MmTzwZ/mYl1FzyBpn
         n1ssAB+B8qj39gOTKtSlawRTwwZCJ0RaNgL5+RIIPeg/Lk/1Y1XC7gHZBZphSwSLOCj1
         YpNwZruFCKfQ/GwuE8BLHdSGCg/zGfsCfkqdGOYVHEudRHdsIh4qu6aE8vZzbz44LtB4
         zAsxdTMalFCwWpLbLiG/KmX0SyoFPsbJ5qqJIiu7lYmmjHasJsK/QAoejwCWy4ytrJox
         +q5FztfNd8ANZFXyJ0jfBZzFHTKypE1EgnQdai4x8jJj8Vig9x1SVtwnD0TecgHR15eR
         KnLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732706514; x=1733311314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elVChWAOghJtOr2/9ffIty1GUC4j4pc0XNnLNMpNrcU=;
        b=qZepVaIMgUdAaELQ2xMHeXAvFsaUQRjYXyAflRYfJusFoiaDeycZFvucJcrGFW3tJ4
         NbSQBbva4/q44kN8+73KJ35P3EYRtTqLLWOdbQxi2bDrq/AT2wJQ/8JkqP7kEl6tfMsm
         HEKu95aD+Ld+BTIPkZpMUNaWpCnE4lNQC/APHB3LrsI0NIal63Ot+nf0d3lMHVX7oq8R
         r6WSk5g1nPMWgDIrg/EeYSRv7f99xZ/Q5LxGHSS4j3gnOJCErEioYHmxB/2b/jsjy8e1
         eIRtAL23640gZMCD0pyfe+OBS+mPsCxYDBD2Cp1o3xEs8P+slNN2au1YHYDPXute8KEC
         eCrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiuldWss8Tmv+wVOohADbfoyVYTMTsmM+bcTvC7lLjhKwg0Q9KkO8fxDeDr+iNyAL4PF6PZfDM1087PZzDPg==@vger.kernel.org, AJvYcCVelMaoEn5++KT3/NxDC8MAm+F/u3xvdsfbTjUm0N+bOdDSphHvCNHG6AakorWuVQ7jY3jAs3m8xIlLVv5R@vger.kernel.org, AJvYcCXojN+T12ne6EXYXYy36RnMzNNM7+v+b0/zhqEzx55lUn9tfV5LdACErQil1lGTEwOBu7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVPlXSBHKpv/sl04y9gBXtwVKP+qnXafg5YtAm617Mo7N8EqUv
	nS5HzEmIYk/IQppl1BULleTnDcYyo4ZOuq3E16zAVtlxcnw7rQpE
X-Gm-Gg: ASbGncuKnNMZEx7micJGkyAmwnWajfi8whpTj43Yc63qBQmBZKahNXG+Dg9CduVCo6X
	MecdD8G9dNILppUZEZSu1UThJGjezI3EPSo5FcpX0Fbo1Zf2SQAVZzFmmaofZjRwX/6CgQnUqY2
	VR7wiP18df3srFxZbmCZHqj7IZyam/kOsOTyvCPgdUGlz8iaaYfojGsiAxvQMbpoCob+Efy3WUT
	GY1/qYCdoCk8e9nSsnic0baNIZ5BuJqhXUNORRPzYWcju1Eft52HPkBRJff8WJ5ebGyJpZlNoym
	A8GGmDmioXODuthmdrkrug8=
X-Google-Smtp-Source: AGHT+IFRBr5mN/dgP2KN/EIsb6j1zyc0+OcOueX2C2ho08DvnIw4RstkuXnVlQQq3zOGoyXDEmtlqA==
X-Received: by 2002:a17:907:618f:b0:a9a:c651:e7d9 with SMTP id a640c23a62f3a-aa581057f6fmr128727366b.46.1732706513796;
        Wed, 27 Nov 2024 03:21:53 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa54a6db906sm414525466b.41.2024.11.27.03.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 03:21:53 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 27 Nov 2024 12:21:51 +0100
To: Juntong Deng <juntong.deng@outlook.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	memxor@gmail.com, snorcht@gmail.com, brauner@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 2/5] selftests/bpf: Add tests for open-coded
 style process file iterator
Message-ID: <Z0cAz3uOGRcl36Eu@krava>
References: <AM6PR03MB50804C0DF9FB1E844B593FDB99202@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB50809E5CD1B8DE0225A85B6B99202@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <Zz3HjT24glXY-8AF@krava>
 <AM6PR03MB5080FB540DD0BBFA48C20325992F2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR03MB5080FB540DD0BBFA48C20325992F2@AM6PR03MB5080.eurprd03.prod.outlook.com>

On Tue, Nov 26, 2024 at 10:24:07PM +0000, Juntong Deng wrote:
> On 2024/11/20 11:27, Jiri Olsa wrote:
> > On Tue, Nov 19, 2024 at 05:53:59PM +0000, Juntong Deng wrote:
> > 
> > SNIP
> > 
> > > +static void subtest_task_file_iters(void)
> > > +{
> > > +	int prog_fd, child_pid, wstatus, err = 0;
> > > +	const int stack_size = 1024 * 1024;
> > > +	struct iters_task_file *skel;
> > > +	struct files_test_args args;
> > > +	struct bpf_program *prog;
> > > +	bool setup_end, test_end;
> > > +	char *stack;
> > > +
> > > +	skel = iters_task_file__open_and_load();
> > > +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
> > > +		return;
> > > +
> > > +	if (!ASSERT_OK(skel->bss->err, "pre_test_err"))
> > > +		goto cleanup_skel;
> > > +
> > > +	prog = bpf_object__find_program_by_name(skel->obj, "test_bpf_iter_task_file");
> > > +	if (!ASSERT_OK_PTR(prog, "find_program_by_name"))
> > > +		goto cleanup_skel;
> > > +
> > > +	prog_fd = bpf_program__fd(prog);
> > > +	if (!ASSERT_GT(prog_fd, -1, "bpf_program__fd"))
> > > +		goto cleanup_skel;
> > 
> > I don't think you need to check on this once we did iters_task_file__open_and_load
> > 
> > > +
> > > +	stack = (char *)malloc(stack_size);
> > > +	if (!ASSERT_OK_PTR(stack, "clone_stack"))
> > > +		goto cleanup_skel;
> > > +
> > > +	setup_end = false;
> > > +	test_end = false;
> > > +
> > > +	args.setup_end = &setup_end;
> > > +	args.test_end = &test_end;
> > > +
> > > +	/* Note that there is no CLONE_FILES */
> > > +	child_pid = clone(task_file_test_process, stack + stack_size, CLONE_VM | SIGCHLD, &args);
> > > +	if (!ASSERT_GT(child_pid, -1, "child_pid"))
> > > +		goto cleanup_stack;
> > > +
> > > +	while (!setup_end)
> > > +		;
> > 
> > I thin kthe preferred way is to synchronize through pipe,
> > you can check prog_tests/uprobe_multi_test.c
> > 
> 
> Thanks for your reply.
> 
> Do we really need to use pipe? Currently this test is very simple.
> 
> In this test, all files opened by the test process will be closed first
> so that there is an empty file description table, and then open the
> test files.
> 
> This way the test process has only 3 newly opened files and the file
> descriptors are always 0, 1, 2.
> 
> Although using pipe is feasible, this test will become more complicated
> than it is now.

I see, I missed the close_range call.. anyway I'd still prefer pipe to busy waiting

perhaps you could use fentry probe triggered by the task_file_test_process
and do the fd/file iteration in there? that way there'be no need for the sync

jirka

