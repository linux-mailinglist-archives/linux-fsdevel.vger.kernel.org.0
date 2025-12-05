Return-Path: <linux-fsdevel+bounces-70845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E624CA8A02
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 18:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 884F130E92DE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 17:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD3C35A92B;
	Fri,  5 Dec 2025 17:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P7uvYngT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YNlrBZUv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BD5327C16
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Dec 2025 17:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764955566; cv=none; b=HG2lcK4bQ66RmtQDicMfF52b2SvpMwOb9CCVC9bBqDZWzRx3AVACxrmP7AJ7/qKvJLaIe6X0DL4DDSQU2/aTgf6AOpB4C2nl2yuVOH4UK+Nwm3yQKBk+xjFJZx79omqWlgageenkeU3CmLzN3CDD7g6nRF1ACgGaJKfWWaz0+Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764955566; c=relaxed/simple;
	bh=3gB6ZiHyUEQCw49IQksu27s7lYXRNxD9491qDl5iZRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mprz+lZjhF9V3/4a9ft9ULwvSL6npLyrW7KyvnWYtehw5jdqcdMGDBxg0mH8SYbqyCGf/biDtfMprgJNxHj0Qx21k/fbUHA4s+37RiLb2SxCWDiueRw5Ox/YP2Ae/PKDBSiqiAqdsFAFtk07LWpwOYHlJHAvwVtuXNOe0qCtbek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P7uvYngT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YNlrBZUv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764955563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nizd43vafz8AJJREFByleh9tHgBqbitMHQ1IeHGNNBI=;
	b=P7uvYngTW/a8dCsslkIVorWMW7BE2vL5JegzWWJwRgdN/pp6IMTWkXPbIZZTTRLEAfyLNQ
	hx9rAaZRGWoKet5owrZUzqwJAVjHeu/JPVn3xutUBmQXSZPxvS9/JzkmPQXTKOoV3hAntK
	7C6l0rEymAV1tXWajrJW7g5/HFVA2OU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-OnKVTdMTPOKF_8eA5O-Dqg-1; Fri, 05 Dec 2025 12:26:01 -0500
X-MC-Unique: OnKVTdMTPOKF_8eA5O-Dqg-1
X-Mimecast-MFC-AGG-ID: OnKVTdMTPOKF_8eA5O-Dqg_1764955560
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3438744f11bso4380545a91.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Dec 2025 09:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764955560; x=1765560360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nizd43vafz8AJJREFByleh9tHgBqbitMHQ1IeHGNNBI=;
        b=YNlrBZUvuWjlZ3zWLqRm5vDImCsHyaH0D6FGBPyvznl9yDp9BnUKxgRBCAyO2yIMxl
         1xIHSFG7/9RgKj0WSpUTp1F3Bp6/Vvz9Yj6TDWW5eLEtvop64j2HFx/49rw8le8R9eEg
         BIrTaYpWujWv5qJwNVMFgU1kPG3VcmTAhoAX1lYC9Opdcn+1lnOstldiD/52BI7axJ9s
         mlEb7s6coKQkaVHi3UqTMTMj0sT7BWreFs0pDaYuzHibRNM3/WdA/+m/68mrsz2aABld
         jHfOYs6Tq9XwI1fQVd8ReG+plFNxRR3KnEm/55eeMGnZnZj+3+0kfNleln8eCc9jMsqe
         g/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764955560; x=1765560360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nizd43vafz8AJJREFByleh9tHgBqbitMHQ1IeHGNNBI=;
        b=AUDloDPtMVVT9bMqPv/kFUk79rH06TJP57zjNoF80tOTMkUV84ToukLLQqPoTVm/cZ
         i448J9L7LDfUfOUQkurGMvb/OEnSQURseT1pno1x4broG7T3UwYg5jviz/9AtgDji0U8
         knhybGXZjpjymRcmPKZjNgG7A83Ez3vYu/EtrODFT7vZFZjy8+2QRPJHmSfjNn2WnZss
         tkXPqi4chAe3FR8DmlWR7KorpcutvcfNOt8Ki6sgGsLXkvmv3WWruRmd0DY/hWDu+xi4
         hr0+eMe52KrNoVrUl3izdu9yV3a/cEwfJjtNv90Z8YNWD8t+Z+r0xQzJhfHwhS2P2lSF
         yC8A==
X-Forwarded-Encrypted: i=1; AJvYcCX2oP3SOCO32n/FGlkw5eMAL1AXna9rXe+V0KDbH39XumCnWuq4kR+oJK5JPGzu+zkcfrhrDmyhK3wQDTvH@vger.kernel.org
X-Gm-Message-State: AOJu0YwLJ0Kf8CGbeY2h0dQ4zJicmy1KukIZpp1iCSIElQVsWNJ4fjn2
	gIVz+4OTSNzsuPTCRv4xG8ZQaUcIWgQ7oUbcitwq6CY2H4GZYc94cs3EK3x4kBhp+GVCiVtDNX1
	6f9AQb2SB1vZ2WZCu5SzJz/+B65lB/hbKikoO1Gyx+U6SE1NQSC5FMAwA0/8UbZp4Z/c=
X-Gm-Gg: ASbGnctqf2SihKgx8x/Wd6TJs0koFykD5a9JKIuwZ23sr/RwNJleASUsg+JFZzYmkAf
	XnYBQIC6O3uoe1jkOqrWkixhMFwPXBbykTdn0xj+vD0TIAhIbLvc5rjld0EqLvJvwpOrI5kMX3r
	cmgSxvAjEe7OXchW/PC3wvLnPTHyMzHFknVkctRiTCpmVCdliXJKCEagiAwJweaIamkmjBYvgaQ
	ge49vCzga2NpJML1plIhmVjy/jeoj3h85VQMg/dxRnGMBJiz11qs4qgUu9iO8dh5wix1xJDtOU8
	auzT/rbzpvLN1S/UO9kuCHT+IFWBL93ZnJBnPkjELpPCqAi4ueNiYrOywAOVtwEAoQ37GOFK/QR
	W40NHxyWY5JKONACQuOsaRDnUSSVuJi7/eHBWwekVoILgBbVvFA==
X-Received: by 2002:a17:90b:4f4c:b0:340:b06f:7134 with SMTP id 98e67ed59e1d1-34912689118mr11170389a91.20.1764955559940;
        Fri, 05 Dec 2025 09:25:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlqY+kJbcA2M9kW3V7LeJzPXzGuf1eehTaDYTTAZXunn0kStE5X1VS8kMQTFuRy9B1BcDbMQ==
X-Received: by 2002:a17:90b:4f4c:b0:340:b06f:7134 with SMTP id 98e67ed59e1d1-34912689118mr11170369a91.20.1764955559343;
        Fri, 05 Dec 2025 09:25:59 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3494f398f80sm5103517a91.6.2025.12.05.09.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 09:25:58 -0800 (PST)
Date: Sat, 6 Dec 2025 01:25:54 +0800
From: Zorro Lang <zlang@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH fstests v3 3/3] generic: add tests for file delegations
Message-ID: <20251205172554.pmzqzdmwpmflh5bi@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251203-dir-deleg-v3-0-be55fbf2ad53@kernel.org>
 <20251203-dir-deleg-v3-3-be55fbf2ad53@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203-dir-deleg-v3-3-be55fbf2ad53@kernel.org>

On Wed, Dec 03, 2025 at 10:43:09AM -0500, Jeff Layton wrote:
> Mostly the same ones as leases, but some additional tests to validate
> that they are broken on metadata changes.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---

This version is good to me. But this test fails without the:
https://lore.kernel.org/linux-fsdevel/20251201-dir-deleg-ro-v1-1-2e32cf2df9b7@kernel.org/

So maybe we can mark that:

  _fixed_by_kernel_commit xxxxxxxxxxxx ...

or

  _wants_kernel_commit xxxxxxxxxxxx ...

Anyway, we can add that after the patchset get merged. I'll merge this patchset
at first.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/locktest       |   5 ++
>  src/locktest.c        | 202 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  tests/generic/784     |  20 +++++
>  tests/generic/784.out |   2 +
>  4 files changed, 227 insertions(+), 2 deletions(-)
> 
> diff --git a/common/locktest b/common/locktest
> index 12b5c27e0c03ad4c60985e3882026fce04e7330e..9344c43d8ee97679b49357b4e75de89ad56221ff 100644
> --- a/common/locktest
> +++ b/common/locktest
> @@ -101,3 +101,8 @@ _run_dirdelegtest() {
>  	TESTFILE=$DELEGDIR
>  	_run_generic "-D"
>  }
> +
> +_run_filedelegtest() {
> +	TESTFILE=$DELEGDIR
> +	_run_generic "-F"
> +}
> diff --git a/src/locktest.c b/src/locktest.c
> index eb40dce3f1b28ef34752518808ec2f3999cd4257..54ee1f07539ef08e768d2c809c40327f315d43e7 100644
> --- a/src/locktest.c
> +++ b/src/locktest.c
> @@ -126,6 +126,8 @@ static char *child[] = { "child0", "child1" };
>  #define		CMD_CHMOD	19
>  #define		CMD_MKDIR	20
>  #define		CMD_RMDIR	21
> +#define		CMD_UNLINK_S	22
> +#define		CMD_RENAME_S	23
>  
>  #define		PASS 	0
>  #define		FAIL	1
> @@ -169,6 +171,8 @@ static char *get_cmd_str(int cmd)
>  		case CMD_CHMOD: return "Chmod"; break;
>  		case CMD_MKDIR: return "Mkdir"; break;
>  		case CMD_RMDIR: return "Rmdir"; break;
> +		case CMD_UNLINK_S: return "Remove Self"; break;
> +		case CMD_RENAME_S: return "Rename Self"; break;
>  	}
>  	return "unknown";
>  }
> @@ -716,6 +720,150 @@ static int64_t lease_tests[][6] =
>  		{0,0,0,0,0,CLIENT}
>  	};
>  
> +char *filedeleg_descriptions[] = {
> +    /*  1 */"Take Read Deleg",
> +    /*  2 */"Take Write Deleg",
> +    /*  3 */"Fail Write Deleg if file is open somewhere else",
> +    /*  4 */"Fail Read Deleg if opened with write permissions",
> +    /*  5 */"Read deleg gets SIGIO on write open",
> +    /*  6 */"Write deleg gets SIGIO on read open",
> +    /*  7 */"Read deleg does _not_ get SIGIO on read open",
> +    /*  8 */"Read deleg gets SIGIO on write open",
> +    /*  9 */"Write deleg gets SIGIO on truncate",
> +    /* 10 */"Read deleg gets SIGIO on truncate",
> +    /* 11 */"Read deleg gets SIGIO on chmod",
> +    /* 12 */"Read deleg gets SIGIO on unlink",
> +    /* 13 */"Read deleg gets SIGIO on rename",
> +};
> +
> +static int64_t filedeleg_tests[][6] =
> +	/*	test #	Action	[offset|flags|arg]	length		expected	server/client */
> +	/*			[sigio_wait_time]						*/
> +	{
> +	/* Various tests to exercise delegs */
> +
> +	/* SECTION 1: Simple verification of being able to take delegs */
> +	/* Take Read Deleg */
> +	{1,	CMD_CLOSE,	0,		0,	PASS,		CLIENT	},
> +	{1,	CMD_OPEN,	O_RDONLY,	0,	PASS,		CLIENT	},
> +	{1,	CMD_CLOSE,	0,		0,	PASS,		SERVER	},
> +	{1,	CMD_OPEN,	O_RDONLY,	0,	PASS,		SERVER	},
> +	{1,	CMD_SETDELEG,	F_RDLCK,	0,	PASS,		SERVER	},
> +	{1,	CMD_GETDELEG,	F_RDLCK,	0,	PASS,		SERVER	},
> +	{1,	CMD_SETDELEG,	F_UNLCK,	0,	PASS,		SERVER	},
> +	{1,	CMD_CLOSE,	0,		0,	PASS,		SERVER	},
> +	{1,	CMD_CLOSE,	0,		0,	PASS,		CLIENT	},
> +
> +	/* Take Write Deleg */
> +	{2,	CMD_OPEN,	O_RDWR,		0,	PASS,		SERVER	},
> +	{2,	CMD_SETDELEG,	F_WRLCK,	0,	PASS,		SERVER	},
> +	{2,	CMD_GETDELEG,	F_WRLCK,	0,	PASS,		SERVER	},
> +	{2,	CMD_SETDELEG,	F_UNLCK,	0,	PASS,		SERVER	},
> +	{2,	CMD_CLOSE,	0,		0,	PASS,		SERVER	},
> +	/* Fail Write Deleg with other users */
> +	{3,	CMD_OPEN,	O_RDONLY,	0,	PASS,		CLIENT  },
> +	{3,	CMD_OPEN,	O_RDWR,		0,	PASS,		SERVER	},
> +	{3,	CMD_SETDELEG,	F_WRLCK,	0,	FAIL,		SERVER	},
> +	{3,	CMD_GETDELEG,	F_WRLCK,	0,	FAIL,		SERVER	},
> +	{3,	CMD_CLOSE,	0,		0,	PASS,		SERVER	},
> +	{3,	CMD_CLOSE,	0,		0,	PASS,		CLIENT	},
> +	/* Fail Read Deleg if opened for write */
> +	{4,	CMD_OPEN,	O_RDWR,		0,	PASS,		SERVER	},
> +	{4,	CMD_SETDELEG,	F_RDLCK,	0,	FAIL,		SERVER	},
> +	{4,	CMD_GETDELEG,	F_RDLCK,	0,	FAIL,		SERVER	},
> +	{4,	CMD_CLOSE,	0,		0,	PASS,		SERVER	},
> +
> +	/* SECTION 2: Proper SIGIO notifications */
> +	/* Get SIGIO when read deleg is broken by write */
> +	{5,	CMD_OPEN,	O_RDONLY,	0,	PASS,		CLIENT	},
> +	{5,	CMD_SETDELEG,	F_RDLCK,	0,	PASS,		CLIENT	},
> +	{5,	CMD_GETDELEG,	F_RDLCK,	0,	PASS,		CLIENT	},
> +	{5,	CMD_SIGIO,	0,		0,	PASS,		CLIENT	},
> +	{5,	CMD_OPEN,	O_RDWR,		0,	PASS,		SERVER	},
> +	{5,	CMD_WAIT_SIGIO,	5,		0,	PASS,		CLIENT	},
> +	{5,	CMD_CLOSE,	0,		0,	PASS,		SERVER	},
> +	{5,	CMD_CLOSE,	0,		0,	PASS,		CLIENT	},
> +
> +	/* Get SIGIO when write deleg is broken by read */
> +	{6,	CMD_OPEN,	O_RDWR,		0,	PASS,		CLIENT	},
> +	{6,	CMD_SETDELEG,	F_WRLCK,	0,	PASS,		CLIENT	},
> +	{6,	CMD_GETDELEG,	F_WRLCK,	0,	PASS,		CLIENT	},
> +	{6,	CMD_SIGIO,	0,		0,	PASS,		CLIENT	},
> +	{6,	CMD_OPEN,	O_RDONLY,	0,	PASS,		SERVER	},
> +	{6,	CMD_WAIT_SIGIO,	5,		0,	PASS,		CLIENT	},
> +	{6,	CMD_CLOSE,	0,		0,	PASS,		SERVER	},
> +	{6,	CMD_CLOSE,	0,		0,	PASS,		CLIENT	},
> +
> +	/* Don't get SIGIO when read deleg is taken by read */
> +	{7,	CMD_OPEN,	O_RDONLY,	0,	PASS,		CLIENT	},
> +	{7,	CMD_SETDELEG,	F_RDLCK,	0,	PASS,		CLIENT	},
> +	{7,	CMD_GETDELEG,	F_RDLCK,	0,	PASS,		CLIENT	},
> +	{7,	CMD_SIGIO,	0,		0,	PASS,		CLIENT	},
> +	{7,	CMD_OPEN,	O_RDONLY,	0,	PASS,		SERVER	},
> +	{7,	CMD_WAIT_SIGIO,	5,		0,	FAIL,		CLIENT	},
> +	{7,	CMD_CLOSE,	0,		0,	PASS,		SERVER	},
> +	{7,	CMD_CLOSE,	0,		0,	PASS,		CLIENT	},
> +
> +	/* Get SIGIO when Read deleg is broken by Write */
> +	{8,	CMD_OPEN,	O_RDONLY,	0,	PASS,		CLIENT	},
> +	{8,	CMD_SETDELEG,	F_RDLCK,	0,	PASS,		CLIENT	},
> +	{8,	CMD_GETDELEG,	F_RDLCK,	0,	PASS,		CLIENT	},
> +	{8,	CMD_SIGIO,	0,		0,	PASS,		CLIENT	},
> +	{8,	CMD_OPEN,	O_RDWR,		0,	PASS,		SERVER	},
> +	{8,	CMD_WAIT_SIGIO,	5,		0,	PASS,		CLIENT	},
> +	{8,	CMD_CLOSE,	0,		0,	PASS,		SERVER	},
> +	{8,	CMD_CLOSE,	0,		0,	PASS,		CLIENT	},
> +
> +	/* Get SIGIO when Write deleg is broken by Truncate */
> +	{9,	CMD_OPEN,	O_RDWR,		0,	PASS,		CLIENT	},
> +	{9,	CMD_SETDELEG,	F_WRLCK,	0,	PASS,		CLIENT	},
> +	{9,	CMD_GETDELEG,	F_WRLCK,	0,	PASS,		CLIENT	},
> +	{9,	CMD_SIGIO,	0,		0,	PASS,		CLIENT	},
> +	{9,	CMD_TRUNCATE,	FILE_SIZE/2,	0,	PASS,		CLIENT	},
> +	{9,	CMD_WAIT_SIGIO,	5,		0,	PASS,		CLIENT	},
> +	{9,	CMD_CLOSE,	0,		0,	PASS,		CLIENT	},
> +
> +	/* Get SIGIO when Read deleg is broken by Truncate */
> +	{10,	CMD_OPEN,	O_RDONLY,	0,	PASS,		CLIENT	},
> +	{10,	CMD_SETDELEG,	F_RDLCK,	0,	PASS,		CLIENT	},
> +	{10,	CMD_GETDELEG,	F_RDLCK,	0,	PASS,		CLIENT	},
> +	{10,	CMD_SIGIO,	0,		0,	PASS,		CLIENT	},
> +	{10,	CMD_TRUNCATE,	FILE_SIZE/2,	0,	PASS,		SERVER	},
> +	{10,	CMD_WAIT_SIGIO,	5,		0,	PASS,		CLIENT	},
> +	{10,	CMD_CLOSE,	0,		0,	PASS,		CLIENT	},
> +
> +	/* Get SIGIO when Read deleg is broken by Chmod */
> +	{11,	CMD_OPEN,	O_RDONLY,	0,	PASS,		SERVER	},
> +	{11,	CMD_SETDELEG,	F_RDLCK,	0,	PASS,		SERVER	},
> +	{11,	CMD_GETDELEG,	F_RDLCK,	0,	PASS,		SERVER	},
> +	{11,	CMD_SIGIO,	0,		0,	PASS,		SERVER	},
> +	{11,	CMD_CHMOD,	0644,		0,	PASS,		CLIENT	},
> +	{11,	CMD_WAIT_SIGIO,	5,		0,	PASS,		SERVER	},
> +	{11,	CMD_CLOSE,	0,		0,	PASS,		SERVER	},
> +
> +	/* Get SIGIO when file is unlinked */
> +	{12,	CMD_OPEN,	O_RDONLY,	0,	PASS,		SERVER	},
> +	{12,	CMD_SETDELEG,	F_RDLCK,	0,	PASS,		SERVER	},
> +	{12,	CMD_GETDELEG,	F_RDLCK,	0,	PASS,		SERVER	},
> +	{12,	CMD_SIGIO,	0,		0,	PASS,		SERVER	},
> +	{12,	CMD_UNLINK_S,	0,		0,	PASS,		CLIENT	},
> +	{12,	CMD_WAIT_SIGIO,	5,		0,	PASS,		SERVER	},
> +	{12,	CMD_CLOSE,	0,		0,	PASS,		SERVER	},
> +
> +	/* Get SIGIO when file is renamed */
> +	{13,	CMD_OPEN,	O_RDONLY,	0,	PASS,		SERVER	},
> +	{13,	CMD_SETDELEG,	F_RDLCK,	0,	PASS,		SERVER	},
> +	{13,	CMD_GETDELEG,	F_RDLCK,	0,	PASS,		SERVER	},
> +	{13,	CMD_SIGIO,	0,		0,	PASS,		SERVER	},
> +	{13,	CMD_RENAME_S,	0,		0,	PASS,		CLIENT	},
> +	{13,	CMD_WAIT_SIGIO,	5,		0,	PASS,		SERVER	},
> +	{13,	CMD_CLOSE,	0,		0,	PASS,		SERVER	},
> +
> +	/* indicate end of array */
> +	{0,0,0,0,0,SERVER},
> +	{0,0,0,0,0,CLIENT}
> +};
> +
>  char *dirdeleg_descriptions[] = {
>      /*  1 */"Take Read Lease",
>      /*  2 */"Write Lease Should Fail",
> @@ -1124,6 +1272,37 @@ int do_chmod(int mode)
>  	return PASS;
>  }
>  
> +int do_unlink_self(void)
> +{
> +	int ret;
> +
> +	ret = unlink(filename);
> +	if (ret < 0) {
> +		perror("unlink");
> +		return FAIL;
> +	}
> +	return PASS;
> +}
> +
> +int do_rename_self(void)
> +{
> +	int ret;
> +	char target[PATH_MAX];
> +
> +	ret = snprintf(target, sizeof(target), "%s2", filename);
> +	if (ret >= sizeof(target)) {
> +		perror("snprintf");
> +		return FAIL;
> +	}
> +
> +	ret = rename(filename, target);
> +	if (ret < 0) {
> +		perror("unlink");
> +		return FAIL;
> +	}
> +	return PASS;
> +}
> +
>  static int do_lock(int cmd, int type, int start, int length)
>  {
>      int ret;
> @@ -1347,6 +1526,7 @@ main(int argc, char *argv[])
>      int fail_count = 0;
>      int run_leases = 0;
>      int run_dirdelegs = 0;
> +    int run_filedelegs = 0;
>      int test_setlease = 0;
>      
>      atexit(cleanup);
> @@ -1360,7 +1540,7 @@ main(int argc, char *argv[])
>  	    prog = p+1;
>      }
>  
> -    while ((c = getopt(argc, argv, "dDLn:h:p:t?")) != EOF) {
> +    while ((c = getopt(argc, argv, "dDFLn:h:p:t?")) != EOF) {
>  	switch (c) {
>  
>  	case 'd':	/* debug flag */
> @@ -1371,6 +1551,10 @@ main(int argc, char *argv[])
>  	    run_dirdelegs = 1;
>  	    break;
>  
> +	case 'F':
> +	    run_filedelegs = 1;
> +	    break;
> +
>  	case 'L':	/* Lease testing */
>  	    run_leases = 1;
>  	    break;
> @@ -1430,7 +1614,7 @@ main(int argc, char *argv[])
>      if (test_setlease == 1) {
>  	struct delegation deleg = { .d_type = F_UNLCK };
>  
> -	if (run_dirdelegs)
> +	if (run_dirdelegs || run_filedelegs)
>  		fcntl(f_fd, F_SETDELEG, &deleg);
>  	else
>  		fcntl(f_fd, F_SETLEASE, F_UNLCK);
> @@ -1568,6 +1752,8 @@ main(int argc, char *argv[])
>       */
>      if (run_dirdelegs)
>  	fail_count = run(dirdeleg_tests, dirdeleg_descriptions);
> +    else if (run_filedelegs)
> +	fail_count = run(filedeleg_tests, filedeleg_descriptions);
>      else if (run_leases)
>  	fail_count = run(lease_tests, lease_descriptions);
>      else
> @@ -1673,6 +1859,12 @@ int run(int64_t tests[][6], char *descriptions[])
>  			case CMD_RMDIR:
>  			    result = do_rmdir(tests[index][ARG]);
>  			    break;
> +			case CMD_UNLINK_S:
> +			    result = do_unlink_self();
> +			    break;
> +			case CMD_RENAME_S:
> +			    result = do_rename_self();
> +			    break;
>  		    }
>  		    if( result != tests[index][RESULT]) {
>  			fail_flag++;
> @@ -1817,6 +2009,12 @@ int run(int64_t tests[][6], char *descriptions[])
>  		case CMD_RMDIR:
>  		    result = do_rmdir(ctl.offset);
>  		    break;
> +		case CMD_UNLINK_S:
> +		    result = do_unlink_self();
> +		    break;
> +		case CMD_RENAME_S:
> +		    result = do_rename_self();
> +		    break;
>  	    }
>  	    if( result != ctl.result ) {
>  		fprintf(stderr,"Failure in %d:%s\n",
> diff --git a/tests/generic/784 b/tests/generic/784
> new file mode 100755
> index 0000000000000000000000000000000000000000..6c20bac9b7fb719af05afd507849213359f9ca0f
> --- /dev/null
> +++ b/tests/generic/784
> @@ -0,0 +1,20 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Jeff Layton <jlayton@kernel.org>.  All Rights Reserved.
> +#
> +# FS QA Test 784
> +#
> +# Test file delegation support
> +#
> +. ./common/preamble
> +_begin_fstest auto quick locks
> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/locktest
> +
> +_require_test
> +_require_test_fcntl_setdeleg
> +
> +_run_filedelegtest
> +_exit 0
> diff --git a/tests/generic/784.out b/tests/generic/784.out
> new file mode 100644
> index 0000000000000000000000000000000000000000..7b499e08fed85d0430ecad03c824f745cb42ec44
> --- /dev/null
> +++ b/tests/generic/784.out
> @@ -0,0 +1,2 @@
> +QA output created by 784
> +success!
> 
> -- 
> 2.52.0
> 


