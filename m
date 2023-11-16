Return-Path: <linux-fsdevel+bounces-2993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A97807EE8F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 22:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38E76B20B03
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 21:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB49495CE;
	Thu, 16 Nov 2023 21:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="U8mhgwgV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [IPv6:2001:1600:4:17::190a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC319182
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Nov 2023 13:50:12 -0800 (PST)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4SWYc31g7ZzMpnrh;
	Thu, 16 Nov 2023 21:50:11 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4SWYc151SjzMpp9t;
	Thu, 16 Nov 2023 22:50:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1700171411;
	bh=DQeutq0PnWuuJRiZB+PkhdAbusXi+wTyq1bikPE9m14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U8mhgwgVE3n/rNEVco9AEhLf3LUdcpctkI3855mIeMYHOO+UrtqCKZ8uOKzsg8LFp
	 6l84DpGwc6ynIGjSKKB9dJE+pxi/zFQNKjYqfvjyZlIWB5e7NjuW6mq9pjFZjyIqnM
	 J6RggDi7h8anhFkl2d+P5ky7tPtpQ41r9cOAT64k=
Date: Thu, 16 Nov 2023 16:50:03 -0500
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 6/7] samples/landlock: Add support for
 LANDLOCK_ACCESS_FS_IOCTL
Message-ID: <20231103.zoxol9ahthaW@digikod.net>
References: <20231103155717.78042-1-gnoack@google.com>
 <20231103155717.78042-7-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231103155717.78042-7-gnoack@google.com>
X-Infomaniak-Routing: alpha

On Fri, Nov 03, 2023 at 04:57:16PM +0100, Günther Noack wrote:
> Add ioctl support to the Landlock sample tool.
> 
> The ioctl right is grouped with the read-write rights in the sample
> tool, as some ioctl requests provide features that mutate state.
> 
> Signed-off-by: Günther Noack <gnoack@google.com>
> ---
>  samples/landlock/sandboxer.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
> index 08596c0ef070..a4b2bebaf203 100644
> --- a/samples/landlock/sandboxer.c
> +++ b/samples/landlock/sandboxer.c
> @@ -81,7 +81,8 @@ static int parse_path(char *env_path, const char ***const path_list)
>  	LANDLOCK_ACCESS_FS_EXECUTE | \
>  	LANDLOCK_ACCESS_FS_WRITE_FILE | \
>  	LANDLOCK_ACCESS_FS_READ_FILE | \
> -	LANDLOCK_ACCESS_FS_TRUNCATE)
> +	LANDLOCK_ACCESS_FS_TRUNCATE | \
> +	LANDLOCK_ACCESS_FS_IOCTL)
>  
>  /* clang-format on */
>  
> @@ -199,7 +200,8 @@ static int populate_ruleset_net(const char *const env_var, const int ruleset_fd,
>  	LANDLOCK_ACCESS_FS_MAKE_BLOCK | \
>  	LANDLOCK_ACCESS_FS_MAKE_SYM | \
>  	LANDLOCK_ACCESS_FS_REFER | \
> -	LANDLOCK_ACCESS_FS_TRUNCATE)
> +	LANDLOCK_ACCESS_FS_TRUNCATE | \
> +	LANDLOCK_ACCESS_FS_IOCTL)
>  
>  /* clang-format on */
>  

#define LANDLOCK_ABI_LAST 5

> @@ -317,6 +319,10 @@ int main(const int argc, char *const argv[], char *const *const envp)
>  		ruleset_attr.handled_access_net &=
>  			~(LANDLOCK_ACCESS_NET_BIND_TCP |
>  			  LANDLOCK_ACCESS_NET_CONNECT_TCP);

__attribute__((fallthrough));

> +	case 4:
> +		/* Removes LANDLOCK_ACCESS_FS_IOCTL for ABI < 5 */
> +		ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_IOCTL;
> +
>  		fprintf(stderr,
>  			"Hint: You should update the running kernel "
>  			"to leverage Landlock features "
> -- 
> 2.42.0.869.gea05f2083d-goog
> 

