Return-Path: <linux-fsdevel+bounces-31613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFABF998E9C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 19:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89ECF1F23D94
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 17:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C2F198831;
	Thu, 10 Oct 2024 17:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BsMb11HG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FAC6F31E;
	Thu, 10 Oct 2024 17:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728582262; cv=none; b=V4MoBn4lRMHqYDJl/Xku/iKLFOJ+jD6rWjQpxPTjT3E372McS+Yk58Y/NFJEvSUjKsT0ygPe/320VG+bPUAmibFfm2vuQi5jUP8dvXIqOhrUXr0PyVpb8cTVHU7VpqYsSsN4N0NmZ0sR4LcMtIEiqD5PsMDapp2Ci3OkF3DBp8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728582262; c=relaxed/simple;
	bh=37GGWu/s5Z2dkq9fNFTORJKZFKH+r2s/jxmIM1ZSt5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dI0E3JflyezwE2f8+hOzrHZJKv7ck3WyoF7YKFDBP4P7BYiLRD5D0d0ayOFVrNFJShD9mYVaWuUSohb3wVQZ6jE2SmyKdIWXpbS46XlujwlHvP9tF6zuPtgVD4Qz1E784Wh78AiDq8Tk0alERieYr3+tDjK6pzDaLp4fch6MdWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=BsMb11HG; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.106.151] (unknown [131.107.174.23])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7C5E620DEAB1;
	Thu, 10 Oct 2024 10:44:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7C5E620DEAB1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1728582260;
	bh=s9li9/lQT0Mv9iHbplaiiwCd6D5LARymcCbjl8AR22I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BsMb11HG+V/nmLInZ7DLrZRdan9d733k1XO36ZCDd9ZKm67SsPwU0TmU3WJZ06dmq
	 e7ebM9811x2clPsAQepAfK+HBm8tdYZo+vsnvVYUlu17DxoGFNydnM7j1GvR09s37u
	 wg31f5VkgSqnDPci2kp8FrNsxidBd5ea4rwi0mDY=
Message-ID: <49b54afe-e662-4f96-8c47-ee0b5671d741@linux.microsoft.com>
Date: Thu, 10 Oct 2024 10:44:20 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 5/7] ipe: Fix inode numbers in audit records
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-security-module@vger.kernel.org, audit@vger.kernel.org
References: <20241010152649.849254-1-mic@digikod.net>
 <20241010152649.849254-5-mic@digikod.net>
Content-Language: en-US
From: Fan Wu <wufan@linux.microsoft.com>
In-Reply-To: <20241010152649.849254-5-mic@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Acked-by: Fan Wu <wufan@linux.microsoft.com>

On 10/10/2024 8:26 AM, Mickaël Salaün wrote:
> Use the new inode_get_ino() helper to log the user space's view of
> inode's numbers instead of the private kernel values.
> 
> Cc: Fan Wu <wufan@linux.microsoft.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>   security/ipe/audit.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/ipe/audit.c b/security/ipe/audit.c
> index f05f0caa4850..72d3e02c2b5f 100644
> --- a/security/ipe/audit.c
> +++ b/security/ipe/audit.c
> @@ -150,7 +150,7 @@ void ipe_audit_match(const struct ipe_eval_ctx *const ctx,
>   		if (inode) {
>   			audit_log_format(ab, " dev=");
>   			audit_log_untrustedstring(ab, inode->i_sb->s_id);
> -			audit_log_format(ab, " ino=%lu", inode->i_ino);
> +			audit_log_format(ab, " ino=%llu", inode_get_ino(inode));
>   		} else {
>   			audit_log_format(ab, " dev=? ino=?");
>   		}


