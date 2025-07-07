Return-Path: <linux-fsdevel+bounces-54077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 071B0AFB125
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 12:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F8B63A67CD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 10:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20212989BF;
	Mon,  7 Jul 2025 10:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtU3YsPn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A83298995
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Jul 2025 10:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751883907; cv=none; b=Zmrk84N5mOJQsp8N6LLBsMjlG7WdSsKtVoJNSC+oQAts1lSWPGrUC5NdUthCFuUBHkAetJZ+k+ApsjGYvwHC63ccXYhCG1xmwnkVt0viZixL9J+7EyyLh39nSdRj/DE3icJoF3eXfivv/saLEWgx3sJ9LDV3ZcrOVDR0NDRQMO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751883907; c=relaxed/simple;
	bh=4L9YecGp7iFrDBCxrR2hAgj7F4m3+DkRgcrdIFevAuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tr07EcqwZp7dvOaDd1ZSJHFLorLaLO7wWk7BHqDDkgMmsfUpsOems7f5lNpKuHnK5UDXE9qcRNUsFhW6UftpkLxeLxz+lfJwB+jhkfGk+BMHuw+kwtkeF7YaKTkSy7n9A2+CPix18BNuYrbeQ8xIwWCFFtS5cncX4uw/o/Vc0Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JtU3YsPn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10759C4CEE3;
	Mon,  7 Jul 2025 10:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751883906;
	bh=4L9YecGp7iFrDBCxrR2hAgj7F4m3+DkRgcrdIFevAuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JtU3YsPnJaJykY9a8TnhDJONGZFAtkb451gNB2L+Mow0Ri5ndwiBF4ke8RwjVi+Ow
	 wTkfAegxScisaFdEDXFAQwDoR0+xP5q8gENcd52eWQ2gUdcfpovofaAhAhhgv6sDod
	 vOprat3GYcxqSseUttT1DZL2/MnmRSU9mEyWdCAapadnaUZKnvVqNInA3ZfNNtvYMq
	 CYxhCAgP0HzjVisQ3mzt/ArpwAd3ZguKEQT8PjObfuK7P0kwdTy+qo1tj0UfMLfXmo
	 SLmUya+tGjJII050xez90DLtCksQb0kwDahXTyI8pgWdZ00uz0350939Pz3F9K8HCN
	 O0B0nWzTvdxww==
Date: Mon, 7 Jul 2025 12:25:03 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Polensky <japo@linux.ibm.com>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [BUG] linux-next: Signal handling and coredump regression in LTP
 coredump_pipe()
Message-ID: <20250707-kahlschlag-nachdenken-6e98737f112e@brauner>
References: <20250707095539.820317-1-japo@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250707095539.820317-1-japo@linux.ibm.com>

On Mon, Jul 07, 2025 at 11:55:39AM +0200, Jan Polensky wrote:
> Hi all,
> 
> While testing the latest linux-next kernel (next-20250704), I encountered a
> reproducible issue during LTP (Linux Test Project) runs related to signal
> handling and core dumps.
> 
> The issue appears to be introduced by commit:
> 
>     ef4744dc9960 ("coredump: split pipe coredumping into coredump_pipe()")
> 
> This commit seems to contain a typo or logic error that causes several LTP tests
> to fail due to missing or incorrect core dump behavior.
> 
> ### Affected LTP tests and output:
> 
> - abort01:
>     abort01.c:58: TFAIL: abort() failed to dump core
> 
> - kill11:
>     kill11.c:84: TFAIL: core dump bit not set for SIGQUIT
>     kill11.c:84: TFAIL: core dump bit not set for SIGILL
>     kill11.c:84: TFAIL: core dump bit not set for SIGTRAP
>     kill11.c:84: TFAIL: core dump bit not set for SIGIOT/SIGABRT
>     kill11.c:84: TFAIL: core dump bit not set for SIGBUS
>     kill11.c:84: TFAIL: core dump bit not set for SIGFPE
>     kill11.c:84: TFAIL: core dump bit not set for SIGSEGV
>     kill11.c:84: TFAIL: core dump bit not set for SIGXCPU
>     kill11.c:84: TFAIL: core dump bit not set for SIGXFSZ
>     kill11.c:84: TFAIL: core dump bit not set for SIGSYS/SIGUNUSED
> 
> - waitpid01:
>     waitpid01.c:140: TFAIL: Child did not dump core when expected
> 
> Best regards,
> Jan
> 
> Signed-off-by: Jan Polensky <japo@linux.ibm.com>
> ---

Folded, thank you!

