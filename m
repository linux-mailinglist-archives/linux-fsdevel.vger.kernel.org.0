Return-Path: <linux-fsdevel+bounces-58283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA42B2BE77
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 12:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 660FF7B8F89
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 10:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AA931B12D;
	Tue, 19 Aug 2025 10:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OeUekBQh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5365214A94;
	Tue, 19 Aug 2025 10:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755597967; cv=none; b=qr2YLCNC/m5LU1crOM2b3l+bqHc3IpGON7736BiIkfn/A+hBfq2Ka3hZf1fn6XZk8SW49aWzq4UlzTvSjwj/QhzTh4jPMzSBeutov+TDQx//UpjqkjIhG+FCB+BAoULrCZPMBTSqD79K6hCauw+EPWl/elLoEJT2gbr4lgt9FMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755597967; c=relaxed/simple;
	bh=f11Nx1TP9s58QGMUEaL0dUNWCcSlCF3s7K3LOMVa4Sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHh9X5+3Yzqclgw7Eg8SfCe8w1/OIvDPKIsVqQOEEr+wry0TW5tEY/M7fy2vh4ofBalMw1tksJt5rEzwswHdDj4vT2up0jouyU22kvvZJmGHunPMJPekKhehSJHzIqaFPsIiVsg/qBqnAUfC79FGKNzrYU9Hia+Xx9qtqBQk+KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OeUekBQh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32BB8C4CEF1;
	Tue, 19 Aug 2025 10:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755597967;
	bh=f11Nx1TP9s58QGMUEaL0dUNWCcSlCF3s7K3LOMVa4Sk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OeUekBQhoKymirQThWTQEUSmYYDqL0zpi6B3Ib4UAq3xnwHAWPbwoz0k1VYryWLn0
	 yD30OJJeQtEwe8gdRIJWv+g1OMyvJBWtCGsSfMmHCzRBrQ5PlIJB6eRKT1u1fO9w/U
	 G7+zck9mUM9Q2g24o05MB+OX51y7ELkCM/6u4a++l8nCC89xx4v6mlrKDw0/n5njb7
	 aMXoBPe3YqNdc0Sbl4xL97yIZfpuTZolYVwXU9BcvU63MBWPAbYzSc2q2AAxg9N/oU
	 9jBt2xBByNtZVpNDjiaEYRhtTqKFGfaJZHGrhhRFquay3tkFoWSqb3u26l8G9cM4X7
	 x5PorQse9sWKQ==
Date: Tue, 19 Aug 2025 12:05:58 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: =?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>, 
	Song Liu <song@kernel.org>, bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, kernel-team@meta.com, 
	andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, viro@zeniv.linux.org.uk, jack@suse.cz, kpsingh@kernel.org, 
	mattbobrowski@google.com, amir73il@gmail.com, gregkh@linuxfoundation.org, tj@kernel.org, 
	daan.j.demeyer@gmail.com, Will McVicker <willmcvicker@google.com>, 
	Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	kernel-team@android.com
Subject: Re: [PATCH v3 bpf-next 1/4] kernfs: remove iattr_mutex
Message-ID: <20250819-tonstudio-abgas-7feaac93f501@brauner>
References: <20250623063854.1896364-1-song@kernel.org>
 <20250623063854.1896364-2-song@kernel.org>
 <78b13bcdae82ade95e88f315682966051f461dde.camel@linaro.org>
 <20250702-hochmoderne-abklatsch-af9c605b57b2@brauner>
 <8f53c544-fd4a-4526-957f-9264a36aead6@siemens.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8f53c544-fd4a-4526-957f-9264a36aead6@siemens.com>

> ...but it looks like v3 was merged as-is in the end, without this fixup.
> Is there some separate patch in the pipeline, or was this forgotten?

This is a result of the trees diverging which we discussed earlier.
I sent a fix.

