Return-Path: <linux-fsdevel+bounces-24584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38410940A00
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 09:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A1491C233E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 07:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4AC19005A;
	Tue, 30 Jul 2024 07:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oj+8dJpz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73618190053;
	Tue, 30 Jul 2024 07:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722325041; cv=none; b=QSFRLTI0C1r8ZX4WwbZTQ9kUwtYe5e0eiC6mvc3+5PgACoprjenprI2Wuzo59ePoFrLp3xBLun9KCP749dPTVlFHlhl8cS9VDOwh+FbcMC17H0XFDem/gX6/grNWPyJkhnbn0LQLpjvnUpMSD15JZNI07L9CamQkXR10Rja74Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722325041; c=relaxed/simple;
	bh=znTDB6DL1BD7xXSGD66QD621R5HDkK/elzxqSHLf5C4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgcLqduENohC0nlBcLHVVcv8omZIMaj8TPIaFOKWs6hwDDZbSNmFulQE9MVdxcFJOaRhLYwMdIjP0/6HqnzkGGimiB2xATznFPcNyQyYVirwM5tF+4KwtB5W4mj6Y+fD7zhouioINkcI4VXSrbq4Yn6FS3s9khMecd9c9dWfevU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oj+8dJpz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34AC0C4AF0B;
	Tue, 30 Jul 2024 07:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722325041;
	bh=znTDB6DL1BD7xXSGD66QD621R5HDkK/elzxqSHLf5C4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oj+8dJpzYClkP52pSG+C45dV8Wr9F4KivUI+DsMcyokOb8eg7xIOxbPrPsngfN5us
	 L2abDqcIyJjxTBekZ0lGUEws+sQdv99aHPDIE1C3MD9tzTYasy2ajf8xXAuEjpr8G/
	 l4EPK7Zdy//w5Ywgq6Bbz3nSzwIJeuk9IDos3k1ydVEGkpeHLPZQQaSiNJpIkbQ6hW
	 Ds0PAYyToj0yABPVsIVr1zxSs4Y4xgw9jg0Lbn+zgQrneUDHPACvfR0JIjsbRAGQHu
	 qi2ayHG+gvxaWXiltevG0UfQ+8AHaPEPUbXVyCXWXNQQsDGMo8mLPfPbnOWDuMUMZo
	 PLkkaf9HmzfDw==
Date: Tue, 30 Jul 2024 09:37:15 +0200
From: Christian Brauner <brauner@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Matt Bobrowski <mattbobrowski@google.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Jann Horn <jannh@google.com>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [PATCH v3 bpf-next 0/3] introduce new VFS based BPF kfuncs
Message-ID: <20240730-bahnnetz-kritik-daac8caaefc8@brauner>
References: <20240726085604.2369469-1-mattbobrowski@google.com>
 <20240726-clown-geantwortet-eb29a17890c3@brauner>
 <CAADnVQK2GkwEqg_KtFha69wWjPKi-9Q6eS_OMWQ9QtGYgUEz3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAADnVQK2GkwEqg_KtFha69wWjPKi-9Q6eS_OMWQ9QtGYgUEz3A@mail.gmail.com>

Acked-by: Christian Brauner <brauner@kernel.org>

