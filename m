Return-Path: <linux-fsdevel+bounces-8040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 787EB82EB72
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 10:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F9D71C20EF7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 09:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E91134D1;
	Tue, 16 Jan 2024 09:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNNbE1/i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAE7134B3;
	Tue, 16 Jan 2024 09:25:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8EFCC433F1;
	Tue, 16 Jan 2024 09:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705397124;
	bh=30xm4MZoJSMEwfTJqHYMt6ZkXYEadXTojiW8Fi0Rh4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VNNbE1/i7rydiUKZgcGDTvh+3AbB73wLGn72Lz5rT12itOOjy54xzh7TylyD/++O1
	 xSoTvNsdxMpMSgdN8CzC9/Um4nEUTRyp8JA0oC2MtuqL+EbrJFQTgknUhIO4o58B5V
	 M3dSACCnjbsmV9LqsqCh9fSgOnhF/HOvxbflB2tpwIRPlre50kdIlFWIJX3pzL7UKa
	 M8jHTqCn7m1d2cvbTdfZk84pXBIq7vScYz7ig/kJPpu3Vrj1grPkWg2kOmDHW7LcjM
	 xbZsNqiLdaJXW0Gl4M6++fmfiHAneAX4E2wudqrtlhMew4oeCkcdY7jJM9DGytJS7W
	 +aiNHz3Whpu9A==
Date: Tue, 16 Jan 2024 10:25:19 +0100
From: Christian Brauner <brauner@kernel.org>
To: dai.ngo@oracle.com
Cc: Jorge Mora <Jorge.Mora@netapp.com>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: nfstest_posix failed with 6.7 kernel (resend)
Message-ID: <20240116-hauch-unpraktisch-8bb7760c04ef@brauner>
References: <feef41c7-b640-4616-908f-9d8eb97904aa@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <feef41c7-b640-4616-908f-9d8eb97904aa@oracle.com>

On Mon, Jan 15, 2024 at 01:05:37PM -0800, dai.ngo@oracle.com wrote:
> (resend with correct Jorge Mora address)
> 
> The 'open' tests of nfstest_posix failed with 6.7 kernel with these errors:
> 
>     FAIL: open - opening existent file should return an error when O_EXCL|O_CREAT is used (256 passed, 256 failed)
>     FAIL: open - opening symbolic link should return an error when O_EXCL|O_CREAT is used (256 passed, 256 failed)
> 
> The problem can be reproduced with both client and server running
> 6.7 kernel.
> 
> Bisecting points to commit 43b450632676:
> 43b450632676: open: return EINVAL for O_DIRECTORY | O_CREAT
> 
> This commit was introduced in 6.4-rc1 and back ported to LTS kernels.
> I'm not sure if the fix for this should be in the fs or in nfstest_posix.
> The commit 43b450632676 makes sense to me. No one should expect open(2)
> to create the directory so the error returned should be EINVAL instead of
> EEXIST as nfstest_posix expects.

Please change the test. The EINVAL fix for open is a really important
fix to the general vfs api.

Christian

