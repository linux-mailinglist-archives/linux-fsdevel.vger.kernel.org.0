Return-Path: <linux-fsdevel+bounces-21253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 162EC90087E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 17:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F9891C21CE2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 15:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC64194AC2;
	Fri,  7 Jun 2024 15:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ei1PZ7Mt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754E518FC63
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 15:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717773417; cv=none; b=EWob7BnlmApONxridTn4KPGNzMVexQAS52WY61T51j3hBsi6tl5AukOuIg3cRADTl8mysX4P1XsuthFv5aQSoWQS23rya6kFRMl8DBgYoDcZMOOpNBb36HE6uape2jCcI4KAuHXnPcheb3AnEhRzU0cyY8JyKBuugiWJkwB3jRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717773417; c=relaxed/simple;
	bh=a47KL8BVN8QYudt3JPAneuT8m9r7k3I9JMJ0JhmonoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzShYJG0OLXUIFVyHLe9GbFGuxpsANlpolCVFDN/wrAEJxIe0ZXgGAyVpToCXYS3WcrrP3JEqllaWFZ5G9BEi6GjfCDJ0JsbxZpNl2RgpM264FzigkJF6kZ6273OPhLIXV5otdR/P9xag5hcbKuR9lsX2DnM2zrzvfh3LcggZUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ei1PZ7Mt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA434C2BBFC;
	Fri,  7 Jun 2024 15:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717773417;
	bh=a47KL8BVN8QYudt3JPAneuT8m9r7k3I9JMJ0JhmonoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ei1PZ7MtMHoXJFvhQumvOxgjkjK9uhlmXNQ6vBg8yYqGBYBfc++POSPu50ecIZ4Rw
	 fYTjUJ5tJ4bfpaLEkCfL+Mmj3OxxxSH+sSIodBBwmPPYRJv8dQaN1SQJIXqDhLi+HF
	 juLm1Ex2ca/u72hFIK/Eorpeex8UgVLtWQE0XhwzYdaQ6FMSPPQU/G0S9dOohk8Dds
	 kXJNrlHhT37in0FWdorCgkH6Fr+Km3429rsQMMaI5D0T1LWaDsW7Q1oKlnu+N6kvSu
	 PtABYAtsXVprWv5plGtOfTOCkGRbeE6eK38qAC70FMpdN78C1I0s0/2cIUUxLwTMY9
	 Ekbby/Wb671Kg==
Date: Fri, 7 Jun 2024 17:16:53 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH 01/19] powerpc: fix a file leak in
 kvm_vcpu_ioctl_enable_cap()
Message-ID: <20240607-lackieren-reitunterricht-52d0620999d5@brauner>
References: <20240607015656.GX1629371@ZenIV>
 <20240607015957.2372428-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240607015957.2372428-1-viro@zeniv.linux.org.uk>

On Fri, Jun 07, 2024 at 02:59:39AM +0100, Al Viro wrote:
> missing fdput() on one of the failure exits
> 
> Fixes: eacc56bb9de3e # v5.2
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

