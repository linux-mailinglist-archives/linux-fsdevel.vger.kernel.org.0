Return-Path: <linux-fsdevel+bounces-1529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF907DB52D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 09:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F6C6B20DAE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 08:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FD2D30E;
	Mon, 30 Oct 2023 08:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tlpbA/4T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC255D305
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 08:32:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2553FC433C8;
	Mon, 30 Oct 2023 08:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698654766;
	bh=YJ9ZZit0sb1xELvhkWLuVnRRKf6RLGvT2DxscVJLozk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tlpbA/4TO5VHBgETbcAPiGKDPbNXs1JbWvLVf0sCApqjpLQrfwQLy15BZEuUvLsyd
	 xpECLgMazOZnIUv5uxfQ2aGy76CyelEg+9R6zhxlIgRJKMFQVDvBcZ7b2XZE+Moi8O
	 0JVRNX9t11/eI6UoXzsnYHYUjsl6ga4zHTKyy/XZNLMvGV5WFYwTMMNAg3Kwc+EGSg
	 l97WYD6nNCEthkwBxqEKPCvJR72QHAFm/FnZrnuwcEQNOw6zYyKiGXYOG2mAsi/zVD
	 /etK+sanWgtWhhCIZBotD2cJQ5P0kxyH5CS9rVWvfpI4SP1ocnxQVR87V1UGi1fZY0
	 n2FzHGfdyGMiA==
Date: Mon, 30 Oct 2023 09:32:37 +0100
From: Christian Brauner <brauner@kernel.org>
To: gaoyusong <a869920004@163.com>
Cc: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] fs: Fix typo in access_override_creds()
Message-ID: <20231030-debatten-nachrangig-f58abcdac530@brauner>
References: <20231030015235.840410-1-a869920004@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231030015235.840410-1-a869920004@163.com>

On Mon, Oct 30, 2023 at 01:52:35AM +0000, gaoyusong wrote:
> From: Yusong Gao <a869920004@163.com>
> 
> Fix typo in access_override_creds(), modify non-RCY to non-RCU.
> 
> Signed-off-by: gaoyusong <a869920004@163.com>
> ---
>  fs/open.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/open.c b/fs/open.c
> index 98f6601fbac6..72eb20a8256a 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -442,7 +442,7 @@ static const struct cred *access_override_creds(void)
>  	 * 'get_current_cred()' function), that will clear the
>  	 * non_rcu field, because now that other user may be
>  	 * expecting RCU freeing. But normal thread-synchronous
> -	 * cred accesses will keep things non-RCY.
> +	 * cred accesses will keep things non-RCU.

I think this might have been intended as a joke aka "non-RCY" as in
"non-racy" here. I think best would be to change it to something like
"cred accesses will keep things non-racy and allows to avoid rcu freeing"
if you care enough.

