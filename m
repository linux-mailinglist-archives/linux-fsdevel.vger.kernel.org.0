Return-Path: <linux-fsdevel+bounces-54075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4A9AFB10A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 12:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88D3E166486
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 10:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F5A292B51;
	Mon,  7 Jul 2025 10:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="svZyXDrS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D6D2E3712
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Jul 2025 10:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751883640; cv=none; b=IEg3fHsUxzSLBN46kG46Tq1amcJP2u/8xOhV633GLSlqXSPA9/9w4hYp6Or+IKBPiy13wEnpDdavl/GRa/njGLOx6KMqBPApcg3WOyV9awVfRnkczbEDT2VX8+gTMQbH7aQ4+0CHzXgTulN8V46KLKhrqcvJfEXPgoTxIUW7B7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751883640; c=relaxed/simple;
	bh=X/+JjVDk6jamKn/Gk9Er3ydLQkFJ+z2OMs9ZF1Uo9fA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZm/zgrlUPhDmH8tZe6T4JKX2VdR3Rgy5pi/gvbjXHi5EeW84pZynnIGGbGhQE5BvcXJ+82yonShtVD1O9bcEZRYZ9uon8adEsZVzEtT+FFunRnjvKkZBFSmkMdhcrZQpTczYaC7bbrIPx9p40js+Y2aY55QdSfBXxn5A6YkabU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=svZyXDrS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE04C4CEE3;
	Mon,  7 Jul 2025 10:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751883640;
	bh=X/+JjVDk6jamKn/Gk9Er3ydLQkFJ+z2OMs9ZF1Uo9fA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=svZyXDrSLObnnsoVUyat4YlANST7oab9f8eIg2p31lVys/0EYF12QVZRzL8YiE/+N
	 XtIFpafKrFnlpqjE0DXfXkCQYGfSf7834XcQmKt7vfXDsNodcYpDl64PTAtTbV5SE8
	 bhrUbaUZgmpjVbmLnTy/7n7sWEU/fyuBhvcJeg60ksMHUqlWx19SLEoWvothaBbVoy
	 kbyg9yiNIILkLinm8r8KjzVt07uvdlkIob2fk0B2IbhtJ6IQrOmhQbtHxyAKXY54wI
	 CWeKARx7Kl3VOvJjmIU+WkaLu10fwgrQt7btGQxdGIMYPrAdJdT9X32THZSMQfRZak
	 5YJ/A1dtzWBwg==
Date: Mon, 7 Jul 2025 12:20:36 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Polensky <japo@linux.ibm.com>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [BUG] linux-next: Signal handling and coredump regression in LTP
 coredump_pipe()
Message-ID: <20250707-irrtum-aufblasbar-5226d9d544ea@brauner>
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

Very odd because I run the coredump tests. Can you please give me the
exact LTP command so I can make sure I'm running those tests?

> Only a suggestion for a fix:
>  fs/coredump.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/coredump.c b/fs/coredump.c
> index 081b5e9d16e2..f4f7f0a0ae40 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -1019,7 +1019,7 @@ static bool coredump_pipe(struct core_name *cn, struct coredump_params *cprm,
>  	if (!sub_info)
>  		return false;
> 
> -	if (!call_usermodehelper_exec(sub_info, UMH_WAIT_EXEC)) {
> +	if (call_usermodehelper_exec(sub_info, UMH_WAIT_EXEC)) {
>  		coredump_report_failure("|%s pipe failed", cn->corename);
>  		return false;
>  	}
> --
> 2.48.1
> 

