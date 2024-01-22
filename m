Return-Path: <linux-fsdevel+bounces-8435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A494F8364E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 14:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF5E31C21FC3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 13:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF283D0DA;
	Mon, 22 Jan 2024 13:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EHUdOVzg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930B33D546;
	Mon, 22 Jan 2024 13:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705931817; cv=none; b=D4jnhRDuR+fSgCj1eCsAZysv3gYnYArhLzZGufqVaSo7Uc9ZeX5XlmHiTvn5uiw8H5wyGxXeOXAtc+AERriaj61LoALCrS+cXSwk199a/MU55RocHzv54jm2VR+B1tOEa2v0s7RqcXvqLrqZrKkg9wpqRwqcFniq3zEvQVxdyco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705931817; c=relaxed/simple;
	bh=ERv68mc0kAOOBrrsOQrSCKbNHTqfl4niUvp0iKwBJmk=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=WTXHL0+cRYAys/r9vfL5ZbDnOySR8lfiKyQ2Qcf2c9ctIBGcW2YMUgd3/Zq66mOKu+LW6Q50feHxg4GWcE+uhN5DUtKb2hGE4gyqD3wgofj5OhuUrwg/M8n5SyshudPjqcv8LjKKDVeUjtl6zP9NnZNT+oOAmoyQzOrp52Lm3gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=EHUdOVzg; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240122135646euoutp02b2c04da39b6dd049ed94f6df9fa59afd~sr-CHuuo00164801648euoutp02M;
	Mon, 22 Jan 2024 13:56:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240122135646euoutp02b2c04da39b6dd049ed94f6df9fa59afd~sr-CHuuo00164801648euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1705931806;
	bh=lwXHUo3YOPn1e8acuxHZCDouH7gmWyeeZ78kTv3eatQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=EHUdOVzg5Cm7vMHaYYez4LrCYX/E6YDM9hvpDrupuOcyM8AA03wmS4fz67K21J6Cn
	 I7tzPGfEEhjICgFLgQcbyvVX2kf1/jzKqdOBFPkQEcYNV3qBCrvX3NVJ0jdFbl+DoT
	 mBhFBXjfkt8VfpOo3cHFRjDzndFt4glaN5H6aqV4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240122135646eucas1p18bf3873c150cdec6b7b96e195e8415e8~sr-B4F3PS1433914339eucas1p1A;
	Mon, 22 Jan 2024 13:56:46 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 58.00.09539.D147EA56; Mon, 22
	Jan 2024 13:56:46 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240122135645eucas1p124f0705306531c0355ad222391c83e8b~sr-BRveqT2326523265eucas1p1e;
	Mon, 22 Jan 2024 13:56:45 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240122135645eusmtrp1acfbecd5a701c4c205fa636bdc1b2dd3~sr-BQ3ySJ0064000640eusmtrp1_;
	Mon, 22 Jan 2024 13:56:45 +0000 (GMT)
X-AuditID: cbfec7f2-52bff70000002543-7c-65ae741d492e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 83.51.10702.D147EA56; Mon, 22
	Jan 2024 13:56:45 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240122135645eusmtip2bc20b6093e3b90c9e046a19826774474~sr-A_SoW81403014030eusmtip2d;
	Mon, 22 Jan 2024 13:56:45 +0000 (GMT)
Received: from localhost (106.110.32.133) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 22 Jan 2024 13:56:44 +0000
Date: Mon, 22 Jan 2024 14:56:45 +0100
From: Joel Granados <j.granados@samsung.com>
To: Huang Yiwei <quic_hyiwei@quicinc.com>
CC: <rostedt@goodmis.org>, <mhiramat@kernel.org>, <mark.rutland@arm.com>,
	<mcgrof@kernel.org>, <keescook@chromium.org>,
	<mathieu.desnoyers@efficios.com>, <corbet@lwn.net>,
	<linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<quic_bjorande@quicinc.com>, <quic_tsoni@quicinc.com>,
	<quic_satyap@quicinc.com>, <quic_aiquny@quicinc.com>, <kernel@quicinc.com>,
	Ross Zwisler <zwisler@google.com>, Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v3] tracing: Support to dump instance traces by
 ftrace_dump_on_oops
Message-ID: <20240122135645.danb777cc5e7i77z@localhost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="b6jh6rk622azxbdb"
Content-Disposition: inline
In-Reply-To: <20240119080824.907101-1-quic_hyiwei@quicinc.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7djPc7pyJetSDT5MZrZ4cqCd0WJZg6rF
	me5ci1nrpjBaLGxbwmKxZ+9JFovLu+awWRxZf5bFYun1i0wWm8+eYba4MeEpo8Xi5WoW/d//
	Mlk0Pp7BaPH59m9mi527NzFZ3L69k9ViX8cDJostnx8wOQh7rJm3htFjdsNFFo+lp9+webTs
	u8XusWBTqcfCT19ZPTat6mTzWNw3mdVj4p46j8+b5AK4orhsUlJzMstSi/TtErgypvz8xFjw
	Obli9alGlgbGu4FdjJwcEgImEk9a2tm7GLk4hARWMEqs6JoC5XxhlGi6OZkRwvnMKLHz1Bt2
	mJbD/e3MEInljBI9P6aBJcCq3rfbQCS2MEo8v7EELMEioCrRMqmBEcRmE9CROP/mDjOILSKg
	KXHqxE+wOLNAN4vEjysaILawQKTE2wl3wOK8AuYSTQ/fMEHYghInZz5h6WLkAKqvkJh9LxTC
	lJZY/o8DpIJTwE7i4oReFog7lSS+vullhbBrJU5tucUEcpqEQBeXxJmvL6GKXCTedD+BKhKW
	eHV8C9STMhKnJ/ewQDRMZpTY/+8DO4SzmlFiWeNXJogqa4mWK0+gOhwlps6dwgpykYQAn8SN
	t4IQf/FJTNo2nRkizCvR0SYEUa0msfreG5YJjMqzkHw2C+GzWQifzQKboyOxYPcnNgxhbYll
	C18zQ9i2EuvWvWdZwMi+ilE8tbQ4Nz212DAvtVyvODG3uDQvXS85P3cTIzDRnv53/NMOxrmv
	PuodYmTiYDzEqALU/GjD6guMUix5+XmpSiK8NyTXpQrxpiRWVqUW5ccXleakFh9ilOZgURLn
	VU2RTxUSSE8sSc1OTS1ILYLJMnFwSjUwmbIyrl8RqKq4t0grJd5n6YWSoPMcHo0sJ0MPH6s0
	331dwqKL/8S/k4lMi77fPKPS3PHGqM/5waJ4s2bu0H7JDF+939umTW0UtWX8Vnu3pOVb/2/5
	d5FrDnzu2RjBwFxxdccTY4PCecyZ1ZMSDqpOrrooOHn3e17jifMLWPY//bYzo+QIm/R9aenZ
	+yarp7vuTH/pPlVWydJqfpxH25ueq3FfDz9KaORmYjDoezpbwL9aIdBeN35HM+faPkaRcPPy
	+x/ne0WUPPk3VSbdyWran2tTCtM/h245+CWAvXjXl4SA1zpW6wMynS73CdYknxeTSJa+zuVu
	JXj/j7uRm0pS1emktKP/+hIyD/349UWJpTgj0VCLuag4EQCCRfaeLwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFKsWRmVeSWpSXmKPExsVy+t/xe7qyJetSDQ41SVk8OdDOaLGsQdXi
	THeuxax1UxgtFrYtYbHYs/cki8XlXXPYLI6sP8tisfT6RSaLzWfPMFvcmPCU0WLxcjWL/u9/
	mSwaH89gtPh8+zezxc7dm5gsbt/eyWqxr+MBk8WWzw+YHIQ91sxbw+gxu+Eii8fS02/YPFr2
	3WL3WLCp1GPhp6+sHptWdbJ5LO6bzOoxcU+dx+dNcgFcUXo2RfmlJakKGfnFJbZK0YYWRnqG
	lhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZW+ZvZi34mFzx+dsatgbG24FdjJwcEgIm
	Eof725m7GLk4hASWMkqsOL6dESIhI7Hxy1VWCFtY4s+1LjaIoo+MEpderGGBcLYwSmw69JsJ
	pIpFQFWiZVIDWDebgI7E+Td3mEFsEQFNiVMnfoLFmQW6WSR+XNEAsYUFIiXeTrgDFucVMJdo
	evgGbI6QwERGibNbdCHighInZz5hgegtk3i3up+9i5EDyJaWWP6PAyTMKWAncXFCLwvEoUoS
	X9/0Qh1dK/H57zPGCYzCs5BMmoVk0iyESRBhLYkb/14yYQhrSyxb+JoZwraVWLfuPcsCRvZV
	jCKppcW56bnFRnrFibnFpXnpesn5uZsYgQln27GfW3Ywrnz1Ue8QIxMH4yFGFaDORxtWX2CU
	YsnLz0tVEuG9IbkuVYg3JbGyKrUoP76oNCe1+BCjKTAQJzJLiSbnA1NhXkm8oZmBqaGJmaWB
	qaWZsZI4r2dBR6KQQHpiSWp2ampBahFMHxMHp1QDU5Vm9w+Haf/yvqexXtk7SThXRepKx8TH
	xWEXP5yc3tt5caM2959ZHG2zAz4mL7xiLdx6sbgvKn/TJvOWDxOtncvmWBhvq9xSoJ5jcbhb
	8deUhdN+7923UyjZ0f/H7qZLIpuNLa3mzzVkuWBpVyqx/7bGnQsvbv9YV/jyVPwPj6M39+6Q
	idHUXN0tvOZT3tSAPd+d1JMlj9/d6yYfcjyEwWxvtsFUKbUDs3q38MQt+lMWuVT/5yTW+26n
	xTvWVrZxvDTxV2iwrV/E/3ZL1eyDvSKHz/c9Uwr9sWDmxAwxwZYPt5vKF7vcDO4XvGayPenZ
	kpi0A6kLmUodS93nbGOZvCwvs9+osTxw7RLHZ+ekgpRYijMSDbWYi4oTAWRivTfNAwAA
X-CMS-MailID: 20240122135645eucas1p124f0705306531c0355ad222391c83e8b
X-Msg-Generator: CA
X-RootMTR: 20240119080907eucas1p12c357eae722d3a60d82c66b81cfc05ba
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240119080907eucas1p12c357eae722d3a60d82c66b81cfc05ba
References: <CGME20240119080907eucas1p12c357eae722d3a60d82c66b81cfc05ba@eucas1p1.samsung.com>
	<20240119080824.907101-1-quic_hyiwei@quicinc.com>

--b6jh6rk622azxbdb
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 04:08:24PM +0800, Huang Yiwei wrote:
> Currently ftrace only dumps the global trace buffer on an OOPs. For
> debugging a production usecase, instance trace will be helpful to
> check specific problems since global trace buffer may be used for
> other purposes.
>=20
> This patch extend the ftrace_dump_on_oops parameter to dump a specific
> trace instance:
>=20
>   - ftrace_dump_on_oops=3D0: as before -- don't dump
>   - ftrace_dump_on_oops[=3D1]: as before -- dump the global trace buffer
>   on all CPUs
>   - ftrace_dump_on_oops=3D2 or =3Dorig_cpu: as before -- dump the global
>   trace buffer on CPU that triggered the oops
>   - ftrace_dump_on_oops=3D<instance_name>: new behavior -- dump the
>   tracing instance matching <instance_name>
>=20
> Also, the sysctl node can handle the input accordingly.
>=20
> Cc: Ross Zwisler <zwisler@google.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Huang Yiwei <quic_hyiwei@quicinc.com>
> ---
> Link: https://lore.kernel.org/linux-trace-kernel/20221209125310.450aee97@=
gandalf.local.home/
>=20
>  .../admin-guide/kernel-parameters.txt         |  9 +--
>  Documentation/admin-guide/sysctl/kernel.rst   | 11 ++--
>  include/linux/ftrace.h                        |  4 +-
>  include/linux/kernel.h                        |  1 +
>  kernel/sysctl.c                               |  4 +-
>  kernel/trace/trace.c                          | 64 ++++++++++++++-----
>  kernel/trace/trace_selftest.c                 |  2 +-
>  7 files changed, 65 insertions(+), 30 deletions(-)
>=20
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index a36cf8cc582c..b3aa533253f1 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1559,12 +1559,13 @@
>  			The above will cause the "foo" tracing instance to trigger
>  			a snapshot at the end of boot up.
> =20
> -	ftrace_dump_on_oops[=3Dorig_cpu]
> +	ftrace_dump_on_oops[=3Dorig_cpu | =3D<instance>]
>  			[FTRACE] will dump the trace buffers on oops.
> -			If no parameter is passed, ftrace will dump
> -			buffers of all CPUs, but if you pass orig_cpu, it will
> +			If no parameter is passed, ftrace will dump global
> +			buffers of all CPUs, if you pass orig_cpu, it will
>  			dump only the buffer of the CPU that triggered the
> -			oops.
> +			oops, or specific instance will be dumped if instance
> +			name is passed.
> =20
>  	ftrace_filter=3D[function-list]
>  			[FTRACE] Limit the functions traced by the function
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/=
admin-guide/sysctl/kernel.rst
> index 6584a1f9bfe3..ecf036b63c48 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -296,11 +296,12 @@ kernel panic). This will output the contents of the=
 ftrace buffers to
>  the console.  This is very useful for capturing traces that lead to
>  crashes and outputting them to a serial console.
> =20
> -=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> -0 Disabled (default).
> -1 Dump buffers of all CPUs.
> -2 Dump the buffer of the CPU that triggered the oops.
> -=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +0           Disabled (default).
> +1           Dump buffers of all CPUs.
> +2(orig_cpu) Dump the buffer of the CPU that triggered the oops.
> +<instance>  Dump the specific instance buffer.
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> =20
>  ftrace_enabled, stack_tracer_enabled
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index e8921871ef9a..f20de4621ec1 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -1151,7 +1151,9 @@ static inline void unpause_graph_tracing(void) { }
>  #ifdef CONFIG_TRACING
>  enum ftrace_dump_mode;
> =20
> -extern enum ftrace_dump_mode ftrace_dump_on_oops;
> +#define MAX_TRACER_SIZE		100
> +extern char ftrace_dump_on_oops[];
> +extern enum ftrace_dump_mode get_ftrace_dump_mode(void);
>  extern int tracepoint_printk;
> =20
>  extern void disable_trace_on_warning(void);
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index d9ad21058eed..de4a76036372 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -255,6 +255,7 @@ enum ftrace_dump_mode {
>  	DUMP_NONE,
>  	DUMP_ALL,
>  	DUMP_ORIG,
> +	DUMP_INSTANCE,
>  };
> =20
>  #ifdef CONFIG_TRACING
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 157f7ce2942d..81cc974913bb 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1710,9 +1710,9 @@ static struct ctl_table kern_table[] =3D {
>  	{
>  		.procname	=3D "ftrace_dump_on_oops",
>  		.data		=3D &ftrace_dump_on_oops,
> -		.maxlen		=3D sizeof(int),
> +		.maxlen		=3D MAX_TRACER_SIZE,
>  		.mode		=3D 0644,
> -		.proc_handler	=3D proc_dointvec,
> +		.proc_handler	=3D proc_dostring,
>  	},
>  	{
>  		.procname	=3D "traceoff_on_warning",
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index a0defe156b57..9a76a278e5c3 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -130,9 +130,10 @@ cpumask_var_t __read_mostly	tracing_buffer_mask;
>   * /proc/sys/kernel/ftrace_dump_on_oops
>   * Set 1 if you want to dump buffers of all CPUs
>   * Set 2 if you want to dump the buffer of the CPU that triggered oops
> + * Set instance name if you want to dump the specific trace instance
>   */
> -
> -enum ftrace_dump_mode ftrace_dump_on_oops;
> +/* Set to string format zero to disable by default */
> +char ftrace_dump_on_oops[MAX_TRACER_SIZE] =3D "0";
> =20
>  /* When set, tracing will stop when a WARN*() is hit */
>  int __disable_trace_on_warning;
> @@ -178,7 +179,6 @@ static void ftrace_trace_userstack(struct trace_array=
 *tr,
>  				   struct trace_buffer *buffer,
>  				   unsigned int trace_ctx);
> =20
> -#define MAX_TRACER_SIZE		100
>  static char bootup_tracer_buf[MAX_TRACER_SIZE] __initdata;
>  static char *default_bootup_tracer;
> =20
> @@ -201,19 +201,32 @@ static int __init set_cmdline_ftrace(char *str)
>  }
>  __setup("ftrace=3D", set_cmdline_ftrace);
> =20
> +enum ftrace_dump_mode get_ftrace_dump_mode(void)
> +{
> +	if (!strcmp("0", ftrace_dump_on_oops))
Would using a strncmp be better in this case? And this question goes for
all the strcmp in the patch. Something like strncmp("0",
ftrace_dump_on_oops, 1); when they are equal, it would avoid 2
assignments and two comparisons. Also might avoid runaway comparisons if
the first string constant changes in the future.

Or maybe strncmp("0", ftrace_dump_on_oops, 2); if you want to check if
they are both null terminated.

> +		return DUMP_NONE;
> +	else if (!strcmp("1", ftrace_dump_on_oops))
> +		return DUMP_ALL;
> +	else if (!strcmp("orig_cpu", ftrace_dump_on_oops) ||
> +			!strcmp("2", ftrace_dump_on_oops))
> +		return DUMP_ORIG;
> +	else
> +		return DUMP_INSTANCE;
> +}
> +
>  static int __init set_ftrace_dump_on_oops(char *str)
>  {
> -	if (*str++ !=3D '=3D' || !*str || !strcmp("1", str)) {
> -		ftrace_dump_on_oops =3D DUMP_ALL;
> +	if (!*str) {
> +		strscpy(ftrace_dump_on_oops, "1", MAX_TRACER_SIZE);
>  		return 1;
>  	}
> =20
> -	if (!strcmp("orig_cpu", str) || !strcmp("2", str)) {
> -		ftrace_dump_on_oops =3D DUMP_ORIG;
> -                return 1;
> -        }
> +	if (*str++ =3D=3D '=3D') {
> +		strscpy(ftrace_dump_on_oops, str, MAX_TRACER_SIZE);
> +		return 1;
> +	}
> =20
> -        return 0;
> +	return 0;
>  }
>  __setup("ftrace_dump_on_oops", set_ftrace_dump_on_oops);
> =20
> @@ -10085,14 +10098,16 @@ static struct notifier_block trace_die_notifier=
 =3D {
>  static int trace_die_panic_handler(struct notifier_block *self,
>  				unsigned long ev, void *unused)
>  {
> -	if (!ftrace_dump_on_oops)
> +	enum ftrace_dump_mode dump_mode =3D get_ftrace_dump_mode();
> +
> +	if (!dump_mode)
>  		return NOTIFY_DONE;
> =20
>  	/* The die notifier requires DIE_OOPS to trigger */
>  	if (self =3D=3D &trace_die_notifier && ev !=3D DIE_OOPS)
>  		return NOTIFY_DONE;
> =20
> -	ftrace_dump(ftrace_dump_on_oops);
> +	ftrace_dump(dump_mode);
> =20
>  	return NOTIFY_DONE;
>  }
> @@ -10133,12 +10148,12 @@ trace_printk_seq(struct trace_seq *s)
>  	trace_seq_init(s);
>  }
> =20
> -void trace_init_global_iter(struct trace_iterator *iter)
> +static void trace_init_iter(struct trace_iterator *iter, struct trace_ar=
ray *tr)
>  {
> -	iter->tr =3D &global_trace;
> +	iter->tr =3D tr;
>  	iter->trace =3D iter->tr->current_trace;
>  	iter->cpu_file =3D RING_BUFFER_ALL_CPUS;
> -	iter->array_buffer =3D &global_trace.array_buffer;
> +	iter->array_buffer =3D &tr->array_buffer;
> =20
>  	if (iter->trace && iter->trace->open)
>  		iter->trace->open(iter);
> @@ -10158,6 +10173,11 @@ void trace_init_global_iter(struct trace_iterato=
r *iter)
>  	iter->fmt_size =3D STATIC_FMT_BUF_SIZE;
>  }
> =20
> +void trace_init_global_iter(struct trace_iterator *iter)
> +{
> +	trace_init_iter(iter, &global_trace);
> +}
> +
>  void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
>  {
>  	/* use static because iter can be a bit big for the stack */
> @@ -10168,6 +10188,15 @@ void ftrace_dump(enum ftrace_dump_mode oops_dump=
_mode)
>  	unsigned long flags;
>  	int cnt =3D 0, cpu;
> =20
> +	if (oops_dump_mode =3D=3D DUMP_INSTANCE) {
> +		tr =3D trace_array_find(ftrace_dump_on_oops);
> +		if (!tr) {
> +			printk(KERN_TRACE "Instance %s not found\n",
> +				ftrace_dump_on_oops);
> +			return;
> +		}
> +	}
> +
>  	/* Only allow one dump user at a time. */
>  	if (atomic_inc_return(&dump_running) !=3D 1) {
>  		atomic_dec(&dump_running);
> @@ -10182,12 +10211,12 @@ void ftrace_dump(enum ftrace_dump_mode oops_dum=
p_mode)
>  	 * If the user does a sysrq-z, then they can re-enable
>  	 * tracing with echo 1 > tracing_on.
>  	 */
> -	tracing_off();
> +	tracer_tracing_off(tr);
> =20
>  	local_irq_save(flags);
> =20
>  	/* Simulate the iterator */
> -	trace_init_global_iter(&iter);
> +	trace_init_iter(&iter, tr);
> =20
>  	for_each_tracing_cpu(cpu) {
>  		atomic_inc(&per_cpu_ptr(iter.array_buffer->data, cpu)->disabled);
> @@ -10200,6 +10229,7 @@ void ftrace_dump(enum ftrace_dump_mode oops_dump_=
mode)
> =20
>  	switch (oops_dump_mode) {
>  	case DUMP_ALL:
> +	case DUMP_INSTANCE:
>  		iter.cpu_file =3D RING_BUFFER_ALL_CPUS;
>  		break;
>  	case DUMP_ORIG:
> diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
> index 529590499b1f..a9750a680324 100644
> --- a/kernel/trace/trace_selftest.c
> +++ b/kernel/trace/trace_selftest.c
> @@ -768,7 +768,7 @@ static int trace_graph_entry_watchdog(struct ftrace_g=
raph_ent *trace)
>  	if (unlikely(++graph_hang_thresh > GRAPH_MAX_FUNC_TEST)) {
>  		ftrace_graph_stop();
>  		printk(KERN_WARNING "BUG: Function graph tracer hang!\n");
> -		if (ftrace_dump_on_oops) {
> +		if (get_ftrace_dump_mode()) {
>  			ftrace_dump(DUMP_ALL);
>  			/* ftrace_dump() disables tracing */
>  			tracing_on();
> --=20
> 2.25.1
>=20

--=20

Joel Granados

--b6jh6rk622azxbdb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmWudBYACgkQupfNUreW
QU/Zqwv/UjKk+jF6A+KqQnvRrJSXNadeNCtlKCzVBzNn0nEVBNZ5fxm5pSCAMhC6
mvAYTUkLw1p/fS4xyo8NJnjdr2davTii/xgBi59VORZoSmoM9MIJV/g/3/WeTHZ7
5gCMZT9EsknmkX2MawqdrFqqObCljB+B8s0NJLHeGyP0YDNnDvE901pihdcnMyYd
UfGOAN536WT/8+3IMgzL09JS2xvdhLDlgcEd+II4pyQR67+GDz0KWqTbYW+3Dnv4
yh04q0oK+KCTm2MLV/RaJ9H54yiI03cKviNHk/GmDObs1pIbUXHi5e8LyMxJIXhr
rYBQjX7BWDBuXWJSwHxQ9UGXWmenFAk2qSXhL2s3JApjBm4p6+brWp0eEjMlkfjb
BCJWsTRIpxgqo+6ElKUOubgUo5v7RAOqj5NnhBPn4vsmoFc5UHPMTUiy8ei6CeTD
P7mI92IDyy/+eJ6pqCcJoSPfrOGP4kmblOIlSeakVI6AnnCL4qm+3m/Z4Y1fy4gS
FzL7uGST
=C0pm
-----END PGP SIGNATURE-----

--b6jh6rk622azxbdb--

