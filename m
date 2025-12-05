Return-Path: <linux-fsdevel+bounces-70842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D881CA8A14
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 18:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E63DB301C665
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 17:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A386C34FF77;
	Fri,  5 Dec 2025 17:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d9229qsw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cLt4jolz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406AE34FF57
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Dec 2025 17:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764954945; cv=none; b=gAOrYF0u1++xV284FcfV+0OfEcQyG2WUrcaJHNCoczyhZpk90/2rmOt/VMMc2BwSHWae4e72s0wA4yIVLdkSsfyokObsKVKGCekp4qmrAuMbrG1I3QQyb5kBpc5+OygEvwMB2CsSyZB6GtF3qNLWqYCdx+WEXnk5wvg4zTm+EXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764954945; c=relaxed/simple;
	bh=VFm9/wEwpYxv1x5c+/Piu7JL1s2sVKnrIthzARcaupU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RgBFVtwYAOT4BZJe/DgfpO77vun07kufOmc1YKJ9BAi439ol+EO+ZPQwTcOmpXRlumqb8nd8sn1yhM8gLGnfsJdZW1KCfN1rxacqu0CC4H+crTW9D2MSxRdEkC2gGVTey/ZqoHB1JITUJkPslGr1Som7JN7T7tlHJ+tnutkdyyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d9229qsw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cLt4jolz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764954939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bkd5J+Sj63gkXA1YlpSxvVVZzZxeST16/MvTUpQnEfs=;
	b=d9229qsw2sTkA6iGe5Ovszl4ftD3Q9RJ0Vx31+2qnoNkyBcsF0+3tWMIOF8fnG10Jw6ny7
	75q7yZiwE0fGwde+v8oAz4ZZ6x5rnCLwrdiEC4NwncUotTRY6z4nzAN26sAH7tGOA5J+H2
	ALwkAzAe/U7/x7CS6rbqj8mApVH33tY=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-UGEN7L84OG2GOPrOwpRUpw-1; Fri, 05 Dec 2025 12:15:37 -0500
X-MC-Unique: UGEN7L84OG2GOPrOwpRUpw-1
X-Mimecast-MFC-AGG-ID: UGEN7L84OG2GOPrOwpRUpw_1764954936
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-29845b18d1aso40300595ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Dec 2025 09:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764954936; x=1765559736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bkd5J+Sj63gkXA1YlpSxvVVZzZxeST16/MvTUpQnEfs=;
        b=cLt4jolzpuFMNXFyJyb1wFv/UwCxJ0YUAXSBxYmeh+IlJpXvQ6bL5ALvRzWw2E2bSV
         Y7P9O1LD9wvBJmvMhiMMd6drsjhxZ5Kykc6QNN3bFkFr26Ls7ckwEubYweDiV/TR3e2f
         2zVKJlledXen+VeglKXG63PjF7OF6CEYtJj3htubrMCNERdXqehscyE/AkfUqENm6JI4
         gpxRRrYDD0Hc7GqUCvxB5N/qdZVO1GBJ9XlYdXI5rWn2I0/vR5de8B6nnxlyTYGXgQoc
         O0f5QQ9l0V7azLpnBtNbDBw024z/0f6GvV5zdKvyzQiM39Kf7DWcpiRwO7tQJgM4/mc6
         1Myg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764954936; x=1765559736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bkd5J+Sj63gkXA1YlpSxvVVZzZxeST16/MvTUpQnEfs=;
        b=SQrfutQekj+hiWrA09e2GZpGREcj0iuHhlLCRCK4oHaqxBRemsTj/q9PgKnjvWXbh3
         OHuUSQGr8jqoto37lpbuuJJl8zVglejgQdw31MuMG3Gv+hG47sUMyQQcPdzTy4kvhDUx
         PEo0bjf6f867LdbK+frnKUg4PIEqracUQY6Vjjq/2JDIugr2Sj+mkQHkCBDPeM42CTZI
         kx8iZ6qFRWIuoT8r/MzoZrke2zYKl+iCgDQQUOG7FZrtv5nbMMNhRwE1VMwAOBVK3x3s
         1W6QsHUq7Jqm0ZgonB+5vRyhZyH6xwQyFYQac8t2gInhfeTWl3aeIEf3ocks+VUbH5XW
         CnqA==
X-Forwarded-Encrypted: i=1; AJvYcCXv/bUwT1euEH67msc7GVEzIhJijKXyMhQifSA+nWE5ash2YTVbFcBOa17IHl6QGSf912nvvXyNbGs1zrNr@vger.kernel.org
X-Gm-Message-State: AOJu0YzAC3Qi9TpmI4KdIxGNgzrG+xu79jcmaSQL95VkIGb01IfVsmFS
	B2SZJPwlvk2CJNSb7wK+560qJRGfLJ+7sB/yPA1IRciJwLconkfeJSY5dA1U7Z5B4p1UpeQbdB9
	H35beRHpqjvqSG9X1k4PWvDBoWrmsgFvgP9xd/En5zQu6V8s50OT09+HRRo97WgOzuog=
X-Gm-Gg: ASbGnctyIHvYG63Qf9l++DCQqNaPcm71FwNNoX8jh3rb4SCxC/AXbHUzVtP83NprayZ
	AzRQV0SZ3VPedYT7SyUwbhu+XoicpeHC/wx3W1NmPRqBhP5vfG3AMWpSyvJ53h02diix0ye3EaJ
	IuvqToZb6KY43bA14URlhNKUcHg8GUT4+Md6+lHjF/WorpG6jkO8ZBSrR2QK7MY11jSakgZXJjQ
	sFUvpy3ywty1f8wEwmkL/r40pt1tKmTG5t6LD5ga9+oACWXtgPRAseaJ/n54lVlJh1nCsjEFHsf
	k6pM+vVPPeGaX9ce8IisbS2rn5rD8+/7GLWgymq44Uya/vpGtIunqsGLa+K4Hlv8vsSH+bCDjs3
	1sMAkXt1fsqplADCfXEZLBmhYqFj0sbwmgtkNFZzrOsyNlZ88Aw==
X-Received: by 2002:a17:903:1209:b0:296:3f23:b909 with SMTP id d9443c01a7336-29d68401104mr137343385ad.39.1764954936076;
        Fri, 05 Dec 2025 09:15:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGeAemsmkjATDBZh/2vYM6eN1PvtmQpLFktHr8msWbg2T7SYAudguuOGEW84Jhvz/Pvm8hgow==
X-Received: by 2002:a17:903:1209:b0:296:3f23:b909 with SMTP id d9443c01a7336-29d68401104mr137342585ad.39.1764954935355;
        Fri, 05 Dec 2025 09:15:35 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae49ca50sm53843865ad.20.2025.12.05.09.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 09:15:34 -0800 (PST)
Date: Sat, 6 Dec 2025 01:15:30 +0800
From: Zorro Lang <zlang@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH fstests v3 2/3] generic: add tests for directory
 delegations
Message-ID: <20251205171530.ri45hwsc6gahyrns@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251203-dir-deleg-v3-0-be55fbf2ad53@kernel.org>
 <20251203-dir-deleg-v3-2-be55fbf2ad53@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203-dir-deleg-v3-2-be55fbf2ad53@kernel.org>

On Wed, Dec 03, 2025 at 10:43:08AM -0500, Jeff Layton wrote:
> With the advent of directory delegation support coming to the kernel,
> add support for testing them to the existing locktest.c program, and add
> testcases for all of the different ways that they can be broken.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---

This version is good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/locktest       |  14 +-
>  common/rc             |  10 ++
>  src/locktest.c        | 423 ++++++++++++++++++++++++++++++++++++++++++++++++--
>  tests/generic/783     |  19 +++
>  tests/generic/783.out |   2 +
>  5 files changed, 453 insertions(+), 15 deletions(-)
> 
> diff --git a/common/locktest b/common/locktest
> index 61e7dd42785dd3d4f21050e10bd5ec9d76a3b15a..12b5c27e0c03ad4c60985e3882026fce04e7330e 100644
> --- a/common/locktest
> +++ b/common/locktest
> @@ -6,6 +6,7 @@ SERVER_LOG=$TEST_DIR/server.out
>  SERVER_PORT=$TEST_DIR/server.port
>  CLIENT_LOG=$TEST_DIR/client.out
>  TESTFILE=$TEST_DIR/lock_file
> +DELEGDIR=$TEST_DIR/dirdeleg
>  client_pid=""
>  server_pid=""
>  
> @@ -13,7 +14,7 @@ _cleanup()
>  {
>  	kill $client_pid > /dev/null 2>&1
>  	kill $server_pid > /dev/null 2>&1
> -	rm -f $TESTFILE
> +	rm -rf $TESTFILE $DELEGDIR
>  }
>  
>  _dump_logs_fail()
> @@ -42,8 +43,6 @@ _run_generic() {
>  	rm -f $CLIENT_LOG
>  	touch $CLIENT_LOG
>  
> -	touch $TESTFILE
> -
>  	# Start the server
>  	$here/src/locktest $mode $TESTFILE 2> $SERVER_LOG 1> $SERVER_PORT &
>  	server_pid=$!
> @@ -87,9 +86,18 @@ _run_generic() {
>  }
>  
>  _run_locktest() {
> +	touch $TESTFILE
> +
>  	_run_generic ""
>  }
>  
>  _run_leasetest() {
> +	touch $TESTFILE
> +
>  	_run_generic "-L"
>  }
> +
> +_run_dirdelegtest() {
> +	TESTFILE=$DELEGDIR
> +	_run_generic "-D"
> +}
> diff --git a/common/rc b/common/rc
> index 116216ca8aeb4e53f3e0d741cc99a050cb3a7462..8df2b387a8a85c7dafeea02f9f9422f52a7d0d01 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4662,6 +4662,16 @@ _require_test_fcntl_setlease()
>  		_notrun "NFS requires delegation before setlease"
>  }
>  
> +_require_test_fcntl_setdeleg()
> +{
> +	_require_test_program "locktest"
> +	mkdir $TEST_DIR/setdeleg_testdir
> +	$here/src/locktest -t -D $TEST_DIR/setdeleg_testdir >/dev/null 2>&1
> +	local ret=$?
> +	rm -rf $TEST_DIR/setdeleg_testdir
> +	[ $ret -eq 22 ] && _notrun "Require fcntl setdeleg support"
> +}
> +
>  _require_ofd_locks()
>  {
>  	# Give a test run by getlk wrlck on testfile.
> diff --git a/src/locktest.c b/src/locktest.c
> index a6cf3b1d5a99dc2cf78f7ceb79622e1ab135c42c..eb40dce3f1b28ef34752518808ec2f3999cd4257 100644
> --- a/src/locktest.c
> +++ b/src/locktest.c
> @@ -28,6 +28,7 @@
>  #include <errno.h>
>  #include <string.h>
>  #include <signal.h>
> +#include <limits.h>
>  
>  #define     HEX_2_ASC(x)    ((x) > 9) ? (x)-10+'a' : (x)+'0'
>  #define 	FILE_SIZE	1024
> @@ -60,8 +61,6 @@ extern int h_errno;
>  #define SOCKET_CLOSE(S)     (close(S))
>  #define INVALID_SOCKET      -1
>  
> -#define O_BINARY            0
> -       
>  #define HANDLE              int
>  #define INVALID_HANDLE      -1
>  #define SEEK(H, O)          (lseek(H, O, SEEK_SET))
> @@ -78,6 +77,17 @@ extern int h_errno;
>  #define ALLOC_ALIGNED(S)    (memalign(65536, S)) 
>  #define FREE_ALIGNED(P)     (free(P)) 
>  
> +#ifndef F_GETDELEG
> +#define F_GETDELEG	(1024 + 15)
> +#define F_SETDELEG	(1024 + 16)
> +
> +struct delegation {
> +	uint32_t d_flags;
> +	uint16_t d_type;
> +	uint16_t __pad;
> +};
> +#endif
> +
>  static char	*prog;
>  static char	*filename = 0;
>  static int	debug = 0;
> @@ -86,11 +96,14 @@ static int	port = 0;
>  static int 	testnumber = -1;
>  static int	saved_errno = 0;
>  static int      got_sigio = 0;
> +static int	lease_is_deleg = 0;
>  
>  static SOCKET	s_fd = -1;              /* listen socket    */
>  static SOCKET	c_fd = -1;	        /* IPC socket       */
>  static HANDLE	f_fd = INVALID_HANDLE;	/* shared file      */
>  
> +static char *child[] = { "child0", "child1" };
> +
>  #define 	CMD_WRLOCK	0
>  #define 	CMD_RDLOCK	1
>  #define		CMD_UNLOCK	2
> @@ -103,9 +116,19 @@ static HANDLE	f_fd = INVALID_HANDLE;	/* shared file      */
>  #define		CMD_SIGIO	9
>  #define		CMD_WAIT_SIGIO	10
>  #define		CMD_TRUNCATE	11
> -
> -#define		PASS 	1
> -#define		FAIL	0
> +#define		CMD_GETDELEG	12
> +#define		CMD_SETDELEG	13
> +#define		CMD_CREATE	14
> +#define		CMD_UNLINK	15
> +#define		CMD_RENAME	16
> +#define		CMD_SYMLINK	17
> +#define		CMD_MKNOD	18
> +#define		CMD_CHMOD	19
> +#define		CMD_MKDIR	20
> +#define		CMD_RMDIR	21
> +
> +#define		PASS 	0
> +#define		FAIL	1
>  
>  #define		SERVER	0
>  #define		CLIENT	1
> @@ -119,6 +142,7 @@ static HANDLE	f_fd = INVALID_HANDLE;	/* shared file      */
>  #define		FLAGS		2 /* index 2 is also used for do_open() flag, see below */
>  #define		ARG		FLAGS /* Arguments for Lease operations */
>  #define		TIME		FLAGS /* Time for waiting on sigio */
> +#define		ARG2		3 /* second argument for dir operations */
>  
>  static char *get_cmd_str(int cmd)
>  {
> @@ -135,6 +159,16 @@ static char *get_cmd_str(int cmd)
>  		case CMD_SIGIO:    return "Setup SIGIO"; break;
>  		case CMD_WAIT_SIGIO: return "Wait for SIGIO"; break;
>  		case CMD_TRUNCATE: return "Truncate"; break;
> +		case CMD_SETDELEG: return "Set Delegation"; break;
> +		case CMD_GETDELEG: return "Get Delegation"; break;
> +		case CMD_CREATE: return "Create"; break;
> +		case CMD_UNLINK: return "Remove"; break;
> +		case CMD_RENAME: return "Rename"; break;
> +		case CMD_SYMLINK: return "Symlink"; break;
> +		case CMD_MKNOD: return "Mknod"; break;
> +		case CMD_CHMOD: return "Chmod"; break;
> +		case CMD_MKDIR: return "Mkdir"; break;
> +		case CMD_RMDIR: return "Rmdir"; break;
>  	}
>  	return "unknown";
>  }
> @@ -682,6 +716,123 @@ static int64_t lease_tests[][6] =
>  		{0,0,0,0,0,CLIENT}
>  	};
>  
> +char *dirdeleg_descriptions[] = {
> +    /*  1 */"Take Read Lease",
> +    /*  2 */"Write Lease Should Fail",
> +    /*  3 */"Dir Lease Should Be Broken on Create",
> +    /*  4 */"Dir Lease Should Be Broken on Unlink",
> +    /*  5 */"Dir Lease Should Be Broken on Rename",
> +    /*  6 */"Dir Lease Should Be Broken on Symlink",
> +    /*  7 */"Dir Lease Should Be Broken on Mknod",
> +    /*  8 */"Dir Lease Should Be Broken on Chmod",
> +    /*  9 */"Dir Lease Should Be Broken on Mkdir",
> +    /* 10 */"Dir Lease Should Be Broken on Rmdir",
> +};
> +
> +static int64_t dirdeleg_tests[][6] =
> +	/*	test #	Action	[offset|flags|arg]	length		expected	server/client */
> +	/*			[sigio_wait_time]						*/
> +{
> +	/* Various tests to exercise leases */
> +
> +/* SECTION 1: Simple verification of being able to take leases */
> +	/* Take Read Lease, and release it */
> +	{1,	CMD_OPEN,	O_DIRECTORY|O_RDONLY,	0,	PASS,		SERVER	},
> +	{1,	CMD_SETDELEG,	F_RDLCK,		0,	PASS,		SERVER	},
> +	{1,	CMD_GETDELEG,	F_RDLCK,		0,	PASS,		SERVER	},
> +	{1,	CMD_SETDELEG,	F_UNLCK,		0,	PASS,		SERVER	},
> +	{1,	CMD_CLOSE,	0,			0,	PASS,		SERVER	},
> +
> +	/* Write Lease should fail */
> +	{2,	CMD_OPEN,	O_DIRECTORY|O_RDONLY,	0,	PASS,		SERVER	},
> +	{2,	CMD_SETDELEG,	F_WRLCK,		0,	FAIL,		SERVER	},
> +	{2,	CMD_CLOSE,	0,			0,	PASS,		SERVER	},
> +
> +	/* Get SIGIO when dir lease is broken by a create */
> +	{3,	CMD_OPEN,	O_DIRECTORY|O_RDONLY,	0,	PASS,		SERVER	},
> +	{3,	CMD_SETDELEG,	F_RDLCK,		0,	PASS,		SERVER	},
> +	{3,	CMD_GETDELEG,	F_RDLCK,		0,	PASS,		SERVER	},
> +	{3,	CMD_SIGIO,	0,			0,	PASS,		SERVER	},
> +	{3,	CMD_CREATE,	0,			0,	PASS,		CLIENT	},
> +	{3,	CMD_WAIT_SIGIO,	5,			0,	PASS,		SERVER	},
> +	{3,	CMD_UNLINK,	0,			0,	PASS,		SERVER	},
> +	{3,	CMD_CLOSE,	0,			0,	PASS,		SERVER	},
> +
> +	/* Get SIGIO when dir lease is broken by unlink */
> +	{4,	CMD_OPEN,	O_DIRECTORY|O_RDONLY,	0,	PASS,		SERVER	},
> +	{4,	CMD_CREATE,	0,			0,	PASS,		SERVER	},
> +	{4,	CMD_SETDELEG,	F_RDLCK,		0,	PASS,		SERVER	},
> +	{4,	CMD_GETDELEG,	F_RDLCK,		0,	PASS,		SERVER	},
> +	{4,	CMD_SIGIO,	0,			0,	PASS,		SERVER	},
> +	{4,	CMD_UNLINK,	0,			0,	PASS,		CLIENT	},
> +	{4,	CMD_WAIT_SIGIO,	5,			0,	PASS,		SERVER	},
> +	{4,	CMD_CLOSE,	0,			0,	PASS,		SERVER	},
> +
> +	/* Get SIGIO when dir lease is broken by rename */
> +	{5,	CMD_OPEN,	O_DIRECTORY|O_RDONLY,	0,	PASS,		SERVER	},
> +	{5,	CMD_CREATE,	0,			0,	PASS,		SERVER	},
> +	{5,	CMD_SETDELEG,	F_RDLCK,		0,	PASS,		SERVER	},
> +	{5,	CMD_GETDELEG,	F_RDLCK,		0,	PASS,		SERVER	},
> +	{5,	CMD_SIGIO,	0,			0,	PASS,		SERVER	},
> +	{5,	CMD_RENAME,	0,			1,	PASS,		CLIENT	},
> +	{5,	CMD_WAIT_SIGIO,	5,			0,	PASS,		SERVER	},
> +	{5,	CMD_UNLINK,	1,			0,	PASS,		CLIENT	},
> +	{5,	CMD_CLOSE,	0,			0,	PASS,		SERVER	},
> +
> +	/* Get SIGIO when dir lease is broken by symlink */
> +	{6,	CMD_OPEN,	O_DIRECTORY|O_RDONLY,	0,	PASS,		SERVER	},
> +	{6,	CMD_SETDELEG,	F_RDLCK,		0,	PASS,		SERVER	},
> +	{6,	CMD_GETDELEG,	F_RDLCK,		0,	PASS,		SERVER	},
> +	{6,	CMD_SIGIO,	0,			0,	PASS,		SERVER	},
> +	{6,	CMD_SYMLINK,	0,			1,	PASS,		CLIENT	},
> +	{6,	CMD_WAIT_SIGIO,	5,			0,	PASS,		SERVER	},
> +	{6,	CMD_UNLINK,	0,			0,	PASS,		CLIENT	},
> +	{6,	CMD_CLOSE,	0,			0,	PASS,		SERVER	},
> +
> +	/* Get SIGIO when dir lease is broken by mknod */
> +	{7,	CMD_OPEN,	O_DIRECTORY|O_RDONLY,	0,	PASS,		SERVER	},
> +	{7,	CMD_SETDELEG,	F_RDLCK,		0,	PASS,		SERVER	},
> +	{7,	CMD_GETDELEG,	F_RDLCK,		0,	PASS,		SERVER	},
> +	{7,	CMD_SIGIO,	0,			0,	PASS,		SERVER	},
> +	{7,	CMD_MKNOD,	0,			0,	PASS,		CLIENT	},
> +	{7,	CMD_WAIT_SIGIO,	5,			0,	PASS,		SERVER	},
> +	{7,	CMD_UNLINK,	0,			0,	PASS,		CLIENT	},
> +	{7,	CMD_CLOSE,	0,			0,	PASS,		SERVER	},
> +
> +	/* Get SIGIO when dir lease is broken by chmod */
> +	{8,	CMD_OPEN,	O_DIRECTORY|O_RDONLY,	0,	PASS,		SERVER	},
> +	{8,	CMD_SETDELEG,	F_RDLCK,		0,	PASS,		SERVER	},
> +	{8,	CMD_GETDELEG,	F_RDLCK,		0,	PASS,		SERVER	},
> +	{8,	CMD_SIGIO,	0,			0,	PASS,		SERVER	},
> +	{8,	CMD_CHMOD,	0775,			0,	PASS,		CLIENT	},
> +	{8,	CMD_WAIT_SIGIO,	5,			0,	PASS,		SERVER	},
> +	{8,	CMD_CLOSE,	0,			0,	PASS,		SERVER	},
> +
> +	/* Get SIGIO when dir lease is broken by mkdir */
> +	{9,	CMD_OPEN,	O_DIRECTORY|O_RDONLY,	0,	PASS,		SERVER	},
> +	{9,	CMD_SETDELEG,	F_RDLCK,		0,	PASS,		SERVER	},
> +	{9,	CMD_GETDELEG,	F_RDLCK,		0,	PASS,		SERVER	},
> +	{9,	CMD_SIGIO,	0,			0,	PASS,		SERVER	},
> +	{9,	CMD_MKDIR,	0,			0,	PASS,		CLIENT	},
> +	{9,	CMD_WAIT_SIGIO,	5,			0,	PASS,		SERVER	},
> +	{9,	CMD_RMDIR,	0,			0,	PASS,		SERVER	},
> +	{9,	CMD_CLOSE,	0,			0,	PASS,		SERVER	},
> +
> +	/* Get SIGIO when dir lease is broken by rmdir */
> +	{10,	CMD_OPEN,	O_DIRECTORY|O_RDONLY,	0,	PASS,		SERVER	},
> +	{10,	CMD_MKDIR,	0,			0,	PASS,		SERVER	},
> +	{10,	CMD_SETDELEG,	F_RDLCK,		0,	PASS,		SERVER	},
> +	{10,	CMD_GETDELEG,	F_RDLCK,		0,	PASS,		SERVER	},
> +	{10,	CMD_SIGIO,	0,			0,	PASS,		SERVER	},
> +	{10,	CMD_RMDIR,	0,			0,	PASS,		CLIENT	},
> +	{10,	CMD_WAIT_SIGIO,	5,			0,	PASS,		SERVER	},
> +	{10,	CMD_CLOSE,	0,			0,	PASS,		SERVER	},
> +
> +	/* indicate end of array */
> +	{0,0,0,0,0,SERVER},
> +	{0,0,0,0,0,CLIENT}
> +};
> +
>  static struct {
>      int32_t		test;
>      int32_t		command;
> @@ -763,9 +914,14 @@ again:
>  
>  void release_lease(int fd)
>  {
> +	struct delegation deleg = { .d_type = F_UNLCK };
>  	int rc;
>  
> -	rc = fcntl(fd, F_SETLEASE, F_UNLCK);
> +	if (lease_is_deleg)
> +		rc = fcntl(fd, F_SETDELEG, &deleg);
> +	else
> +		rc = fcntl(fd, F_SETLEASE, F_UNLCK);
> +
>  	if (rc != 0)
>  		fprintf(stderr, "%s Failed to remove lease %d : %d %s\n",
>  			__FILE__, rc, errno, strerror(errno));
> @@ -826,9 +982,39 @@ int do_wait_sigio(int32_t time)
>      return (got_sigio ? PASS: FAIL);
>  }
>  
> +int create_directory(void)
> +{
> +	int ret;
> +	struct stat st;
> +
> +	ret = mkdir(filename, 0777);
> +	if (ret == 0)
> +		return PASS;
> +
> +	if (errno != EEXIST) {
> +		perror("directory create");
> +		return FAIL;
> +	}
> +
> +	ret = stat(filename, &st);
> +	if (ret < 0) {
> +		perror("stat");
> +		return FAIL;
> +	}
> +
> +	if (S_ISDIR(st.st_mode))
> +		return PASS;
> +
> +	fprintf(stderr, "%s is not a directory\n", filename);
> +	return FAIL;
> +}
> +
>  int do_open(int flag)
>  {
> -    int flags = flag|O_CREAT|O_BINARY;
> +    int flags = flag;
> +
> +    if (!(flag & O_DIRECTORY))
> +	flags |= O_CREAT;
>  
>      if(debug > 1)
>  	fprintf(stderr, "do_open %s 0x%x\n", filename, flags);
> @@ -841,6 +1027,103 @@ int do_open(int flag)
>      return PASS;
>  }
>  
> +int do_create(int idx)
> +{
> +	int fd;
> +
> +	fd = openat(f_fd, child[idx], O_WRONLY|O_CREAT, 0666);
> +	if (fd < 0) {
> +		perror("openat");
> +		return FAIL;
> +	}
> +	close(fd);
> +	return PASS;
> +}
> +
> +int do_unlink(int idx)
> +{
> +	int ret;
> +
> +	ret = unlinkat(f_fd, child[idx], 0);
> +	if (ret < 0) {
> +		perror("unlink");
> +		return FAIL;
> +	}
> +	return PASS;
> +}
> +
> +int do_rename(int old, int new)
> +{
> +	int ret;
> +
> +	ret = renameat(f_fd, child[old], f_fd, child[new]);
> +	if (ret < 0) {
> +		perror("rename");
> +		return FAIL;
> +	}
> +	return PASS;
> +}
> +
> +int do_symlink(int path, int target)
> +{
> +	int ret;
> +
> +	ret = symlinkat(child[target], f_fd, child[path]);
> +	if (ret < 0) {
> +		perror("symlink");
> +		return FAIL;
> +	}
> +	return PASS;
> +}
> +
> +int do_mknod(int idx)
> +{
> +	int ret;
> +
> +	ret = mknodat(f_fd, child[idx], S_IFREG, 0);
> +	if (ret < 0) {
> +		perror("mknod");
> +		return FAIL;
> +	}
> +	return PASS;
> +}
> +
> +int do_mkdir(int idx)
> +{
> +	int ret;
> +
> +	ret = mkdirat(f_fd, child[idx], 0777);
> +	if (ret < 0) {
> +		perror("mkdir");
> +		return FAIL;
> +	}
> +	return PASS;
> +}
> +
> +int do_rmdir(int idx)
> +{
> +	int ret;
> +
> +	ret = unlinkat(f_fd, child[idx], AT_REMOVEDIR);
> +	if (ret < 0) {
> +		perror("mkdir");
> +		return FAIL;
> +	}
> +	return PASS;
> +}
> +
> +int do_chmod(int mode)
> +{
> +	int ret;
> +
> +	ret = chmod(filename, mode);
> +	if (ret < 0) {
> +		perror("chmod");
> +		return FAIL;
> +	}
> +	return PASS;
> +}
> +
>  static int do_lock(int cmd, int type, int start, int length)
>  {
>      int ret;
> @@ -884,6 +1167,7 @@ static int do_lease(int cmd, int arg, int expected)
>  
>      errno = 0;
>  
> +    lease_is_deleg = 0;
>      ret = fcntl(f_fd, cmd, arg);
>      saved_errno = errno;
>  
> @@ -897,6 +1181,37 @@ static int do_lease(int cmd, int arg, int expected)
>      return(ret==0?PASS:FAIL);
>  }
>  
> +static int do_deleg(int cmd, unsigned short arg, int expected)
> +{
> +    struct delegation deleg = { .d_type = arg };
> +    int ret;
> +
> +    if(debug > 1)
> +	fprintf(stderr, "do_deleg: cmd=%d arg=%d exp=%X\n",
> +		cmd, arg, expected);
> +
> +    if (f_fd < 0)
> +	return f_fd;
> +
> +    errno = 0;
> +
> +    lease_is_deleg = 1;
> +    ret = fcntl(f_fd, cmd, &deleg);
> +    saved_errno = errno;
> +
> +    if (cmd == F_GETDELEG && ret == 0)
> +	    ret = deleg.d_type;
> +
> +    if (expected && (expected == ret))
> +	    ret = 0;
> +
> +    if(ret)
> +	fprintf(stderr, "%s do_deleg: ret = %d, errno = %d (%s)\n",
> +		__FILE__, ret, errno, strerror(errno));
> +
> +    return(ret==0?PASS:FAIL);
> +}
> +
>  int do_close(void)
>  {	
>      if(debug > 1) {
> @@ -1020,6 +1335,7 @@ main(int argc, char *argv[])
>  {
>      int		i, sts;
>      int		c;
> +    int		openflags;
>      struct sockaddr_in	myAddr;
>      struct linger	noLinger = {1, 0};
>      char	*host = NULL;
> @@ -1030,6 +1346,7 @@ main(int argc, char *argv[])
>      extern int	optind;
>      int fail_count = 0;
>      int run_leases = 0;
> +    int run_dirdelegs = 0;
>      int test_setlease = 0;
>      
>      atexit(cleanup);
> @@ -1043,13 +1360,17 @@ main(int argc, char *argv[])
>  	    prog = p+1;
>      }
>  
> -    while ((c = getopt(argc, argv, "dLn:h:p:t?")) != EOF) {
> +    while ((c = getopt(argc, argv, "dDLn:h:p:t?")) != EOF) {
>  	switch (c) {
>  
>  	case 'd':	/* debug flag */
>  	    debug++;
>  	    break;
>  
> +	case 'D':
> +	    run_dirdelegs = 1;
> +	    break;
> +
>  	case 'L':	/* Lease testing */
>  	    run_leases = 1;
>  	    break;
> @@ -1090,13 +1411,29 @@ main(int argc, char *argv[])
>      }
>  
>      filename=argv[optind];
> +
> +    if (run_dirdelegs && create_directory() == FAIL)
> +	    exit(1);
> +
>      if (debug)
>  	fprintf(stderr, "Working on file : %s\n", filename);
> -    if (do_open(O_RDWR) == FAIL)
> +
> +    if (run_dirdelegs) {
> +	openflags = O_RDONLY | O_DIRECTORY;
> +    } else {
> +	openflags = O_RDWR;
> +    }
> +
> +    if (do_open(openflags) == FAIL)
>  	exit(1);
>  
>      if (test_setlease == 1) {
> -	fcntl(f_fd, F_SETLEASE, F_UNLCK);
> +	struct delegation deleg = { .d_type = F_UNLCK };
> +
> +	if (run_dirdelegs)
> +		fcntl(f_fd, F_SETDELEG, &deleg);
> +	else
> +		fcntl(f_fd, F_SETLEASE, F_UNLCK);
>  	saved_errno = errno;
>  	close(f_fd);
>  	exit(saved_errno);
> @@ -1220,7 +1557,7 @@ main(int argc, char *argv[])
>  	SRAND(6789L);
>      }
>  
> -    if (server)
> +    if (server && !run_dirdelegs)
>  	/* only server need do shared file */
>  	initialize(f_fd);
>  
> @@ -1229,7 +1566,9 @@ main(int argc, char *argv[])
>       *
>       * real work is in here ...
>       */
> -    if (run_leases)
> +    if (run_dirdelegs)
> +	fail_count = run(dirdeleg_tests, dirdeleg_descriptions);
> +    else if (run_leases)
>  	fail_count = run(lease_tests, lease_descriptions);
>      else
>  	fail_count = run(lock_tests, lock_descriptions);
> @@ -1304,6 +1643,36 @@ int run(int64_t tests[][6], char *descriptions[])
>  			case CMD_TRUNCATE:
>  			    result = do_truncate(tests[index][OFFSET]);
>  			    break;
> +			case CMD_SETDELEG:
> +			    result = do_deleg(F_SETDELEG, tests[index][ARG], 0);
> +			    break;
> +			case CMD_GETDELEG:
> +			    result = do_deleg(F_GETDELEG, tests[index][ARG], tests[index][ARG]);
> +			    break;
> +			case CMD_CREATE:
> +			    result = do_create(tests[index][ARG]);
> +			    break;
> +			case CMD_UNLINK:
> +			    result = do_unlink(tests[index][ARG]);
> +			    break;
> +			case CMD_RENAME:
> +			    result = do_rename(tests[index][ARG], tests[index][ARG2]);
> +			    break;
> +			case CMD_SYMLINK:
> +			    result = do_symlink(tests[index][ARG], tests[index][ARG2]);
> +			    break;
> +			case CMD_MKNOD:
> +			    result = do_mknod(tests[index][ARG]);
> +			    break;
> +			case CMD_CHMOD:
> +			    result = do_chmod(tests[index][ARG]);
> +			    break;
> +			case CMD_MKDIR:
> +			    result = do_mkdir(tests[index][ARG]);
> +			    break;
> +			case CMD_RMDIR:
> +			    result = do_rmdir(tests[index][ARG]);
> +			    break;
>  		    }
>  		    if( result != tests[index][RESULT]) {
>  			fail_flag++;
> @@ -1418,6 +1787,36 @@ int run(int64_t tests[][6], char *descriptions[])
>  		case CMD_TRUNCATE:
>  		    result = do_truncate(ctl.offset);
>  		    break;
> +		case CMD_SETDELEG:
> +		    result = do_deleg(F_SETDELEG, ctl.offset, 0);
> +		    break;
> +		case CMD_GETDELEG:
> +		    result = do_deleg(F_GETDELEG, ctl.offset, ctl.offset);
> +		    break;
> +		case CMD_CREATE:
> +		    result = do_create(ctl.offset);
> +		    break;
> +		case CMD_UNLINK:
> +		    result = do_unlink(ctl.offset);
> +		    break;
> +		case CMD_RENAME:
> +		    result = do_rename(ctl.offset, ctl.length);
> +		    break;
> +		case CMD_SYMLINK:
> +		    result = do_symlink(ctl.offset, ctl.length);
> +		    break;
> +		case CMD_MKNOD:
> +		    result = do_mknod(ctl.offset);
> +		    break;
> +		case CMD_CHMOD:
> +		    result = do_chmod(ctl.offset);
> +		    break;
> +		case CMD_MKDIR:
> +		    result = do_mkdir(ctl.offset);
> +		    break;
> +		case CMD_RMDIR:
> +		    result = do_rmdir(ctl.offset);
> +		    break;
>  	    }
>  	    if( result != ctl.result ) {
>  		fprintf(stderr,"Failure in %d:%s\n",
> diff --git a/tests/generic/783 b/tests/generic/783
> new file mode 100755
> index 0000000000000000000000000000000000000000..92cd1fe83b6f8d80f7449a91d03a8dfd0238e826
> --- /dev/null
> +++ b/tests/generic/783
> @@ -0,0 +1,19 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Jeff Layton <jlayton@kernel.org>.  All Rights Reserved.
> +#
> +# FS QA Test 783
> +#
> +# Test directory delegation support
> +#
> +. ./common/preamble
> +_begin_fstest auto locks quick
> +
> +. ./common/filter
> +. ./common/locktest
> +
> +_require_test
> +_require_test_fcntl_setdeleg
> +
> +_run_dirdelegtest
> +_exit 0
> diff --git a/tests/generic/783.out b/tests/generic/783.out
> new file mode 100644
> index 0000000000000000000000000000000000000000..4577997e1ff1fa2062e88f88bf94337db37a2e34
> --- /dev/null
> +++ b/tests/generic/783.out
> @@ -0,0 +1,2 @@
> +QA output created by 783
> +success!
> 
> -- 
> 2.52.0
> 


