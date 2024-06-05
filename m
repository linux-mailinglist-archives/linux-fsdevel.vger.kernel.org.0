Return-Path: <linux-fsdevel+bounces-21012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C35738FC229
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 05:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80613285057
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 03:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBC17345C;
	Wed,  5 Jun 2024 03:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Qqk+zrTb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0642056470;
	Wed,  5 Jun 2024 03:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717557933; cv=none; b=X1X2IcEU3VW7Pjlh9IBNFQlGqAK6TJiQopRT7qDazw9v+unG0ttM26RJNgdaUOv6cdtah7ZQtihiYHy2kngAF5nvGyrhaIPYwp0tl+bCJpn33aitg+YQ6kpz/EUW8oTFYVs//DTMRjDXmoW5JftbsL3+UGpmwzqspCeR0WUoQ1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717557933; c=relaxed/simple;
	bh=kSrIVEn5+ULziH4lIqSRZBF9y1SbsW1rFOIKZRGUYMY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Pa+/GZZ0invzHaUlBADMPdIUoh+riZ7zELqbwbDNlIZ+phRBN5mww8Ub8PfhvQ7JyWg0Yi34M/3TAY4K+W5olmbCZa8tUNzmuEgHVw623302gWojHm0+fODTD0jfdOb5ReuvhmXxwnRHalWUwHA3GwHDPlx38ThGEXVuydiwpCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Qqk+zrTb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB8BC32781;
	Wed,  5 Jun 2024 03:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1717557932;
	bh=kSrIVEn5+ULziH4lIqSRZBF9y1SbsW1rFOIKZRGUYMY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qqk+zrTb3qN0u7nr+Ltb8BGII6GpqS9r3xPSvfVItICcFbPgKyQdNoxG25i7GOTg8
	 aS+pj1Ao1N1lbuNg24jqF+JAEi/vN4E+gsPVlAUMF6t2DjeVFQ1oY1v/nxzdpxSBJu
	 W8lxcEcDUrdIu5pH0BiEVOB4oHcVD/m3+rkLB2v4=
Date: Tue, 4 Jun 2024 20:25:31 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Amer Al Shanawany <amer.shanawany@gmail.com>, Shuah Khan
 <shuah@kernel.org>, Swarup Laxman Kotiaklapudi
 <swarupkotikalapudi@gmail.com>, Hugh Dickins <hughd@google.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] selftests: proc: remove unreached code and fix build
 warning
Message-Id: <20240604202531.5d559ec4daed484a7a23592c@linux-foundation.org>
In-Reply-To: <14f55053-2ff8-4086-8aac-b8ee2d50a427@p183>
References: <202404010211.ygidvMwa-lkp@intel.com>
	<20240603124220.33778-1-amer.shanawany@gmail.com>
	<14f55053-2ff8-4086-8aac-b8ee2d50a427@p183>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 3 Jun 2024 17:24:47 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:

> On Mon, Jun 03, 2024 at 02:42:20PM +0200, Amer Al Shanawany wrote:
> > fix the following warning:
> > proc-empty-vm.c:385:17: warning: ignoring return value of ‘write’
> 
> > --- a/tools/testing/selftests/proc/proc-empty-vm.c
> > +++ b/tools/testing/selftests/proc/proc-empty-vm.c
> > @@ -381,9 +381,6 @@ static int test_proc_pid_statm(pid_t pid)
> 
> > -	if (0) {
> > -		write(1, buf, rv);
> > -	}
> 
> no thanks

Why not?

Why does that code exist anyway?  It at least needs a comment.

