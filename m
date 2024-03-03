Return-Path: <linux-fsdevel+bounces-13388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E599586F437
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Mar 2024 10:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D9FE281E79
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Mar 2024 09:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FC1B658;
	Sun,  3 Mar 2024 09:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dTvRrUGK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C4BEDC;
	Sun,  3 Mar 2024 09:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709459700; cv=none; b=nhmgEdzx4lNkh4kE5QE5gvtid6LePoC/uVhCRi4y6tNMay6jy1CRa8lK/FG3gZT9dWeCrBZl+7xMLdwIg56bo3NrV/6zziUAESHcutbzP6pjwpBerJU2yukoNHAhCdE+NOIOc+obxFp+YjYP04oxd/69Dao5dYowaYKkisITJUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709459700; c=relaxed/simple;
	bh=h272zxK0n0G1eld3WEHlzK73GxqIQ9Tye5g3ClUnbkk=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=oTA2lI0rL0l5P/lSMyj4RhHK//hHo77tG1NBHly7uswtrUPTX81/uCLNp/ImKhQYZego+vKcsvtTzpIFO5FTnxHo6T8+UD/hoDMSVW+VhQkWV5TIhUF71tGdSsR8py0OZMAk3evtXnDmsltRmI8ry2kNpDXmzeQ890JqTwf/Q8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=dTvRrUGK; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240303095448euoutp010e9fd0b819fdf515536c0ef2282fc7e9~5OIeXC3Fz3150031500euoutp01J;
	Sun,  3 Mar 2024 09:54:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240303095448euoutp010e9fd0b819fdf515536c0ef2282fc7e9~5OIeXC3Fz3150031500euoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1709459688;
	bh=KpNc9L4F8FZsTqrWl3P2G11qTscQtvUQDQH4QBSDhW4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=dTvRrUGK5cCJbuB46jtugcdLYjXjatlpknKukyW4UEItPamJ3dbYXzjTxYyG1i5KN
	 5KFq3Gh0JqVuDNPnbLtivgZuhDb8GRFkT59c85AQUPLBKQ/qL7oAW1eh5qRLkXnQRi
	 YTvjGZSAFC1lRkLZjiEmgbEK/L6+MaCdgM/WtLuU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240303095447eucas1p2286105723ee5500c16e27dfcb4902614~5OIdU3ttP1764017640eucas1p2B;
	Sun,  3 Mar 2024 09:54:47 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 69.3F.09814.6E844E56; Sun,  3
	Mar 2024 09:54:46 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240303095445eucas1p1b171bed2f027a663bc9bd6e176162427~5OIbUGfe22866428664eucas1p1t;
	Sun,  3 Mar 2024 09:54:45 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240303095445eusmtrp159b67d03b4a6793a9608a8f2873961f8~5OIbTX2r22476424764eusmtrp1u;
	Sun,  3 Mar 2024 09:54:45 +0000 (GMT)
X-AuditID: cbfec7f4-727ff70000002656-37-65e448e6886e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 53.8E.09146.5E844E56; Sun,  3
	Mar 2024 09:54:45 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240303095444eusmtip22855a12ab1077b5150deaf648fff72c2~5OIa-O4CU1341813418eusmtip2S;
	Sun,  3 Mar 2024 09:54:44 +0000 (GMT)
Received: from localhost (106.210.248.8) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Sun, 3 Mar 2024 09:54:43 +0000
Date: Sun, 3 Mar 2024 10:54:41 +0100
From: Joel Granados <j.granados@samsung.com>
To: Huang Yiwei <quic_hyiwei@quicinc.com>
CC: <rostedt@goodmis.org>, <mhiramat@kernel.org>, <mark.rutland@arm.com>,
	<mcgrof@kernel.org>, <keescook@chromium.org>,
	<mathieu.desnoyers@efficios.com>, <corbet@lwn.net>,
	<linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<quic_bjorande@quicinc.com>, <quic_tsoni@quicinc.com>,
	<quic_satyap@quicinc.com>, <quic_aiquny@quicinc.com>, <kernel@quicinc.com>,
	Ross Zwisler <zwisler@google.com>
Subject: Re: [PATCH v7] tracing: Support to dump instance traces by
 ftrace_dump_on_oops
Message-ID: <20240303095441.rvgcyxyljqix2l63@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="paf7qqks7mvup3rn"
Content-Disposition: inline
In-Reply-To: <20240301103913.934946-1-quic_hyiwei@quicinc.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBJsWRmVeSWpSXmKPExsWy7djP87rPPJ6kGmy6amPx5EA7o8WZ7lyL
	WeumMFosbFvCYrFn70kWi8u75rBZHFl/lsVi6fWLTBabz55htrgx4SmjxeLlahb93/8yWTQ+
	nsFo8fn2b2aLnbs3MVncvr2T1WJfxwMmiy2fHzA5CHmsmbeG0WN2w0UWj6Wn37B5tOy7xe6x
	YFOpx6ZVnWwei/sms3pM3FPn8XmTXABnFJdNSmpOZllqkb5dAlfG2TNb2Ar2dTBWrNk/hbWB
	8WluFyMnh4SAicSCH/tYuxi5OIQEVjBKvPh4Acr5wijx+8g0FgjnM6PEvzPv2GFanh+ZCFW1
	nFHi7uvJrHBVBze9Y4NwNjFKXLu9gAmkhUVAReL3sgnMIDabgI7E+Td3wGwRAU2JUyd+MoI0
	MAs8YpY4eeQr2A5hgUiJxrZzbCA2r4CDxO+dq6BsQYmTM5+wgNjMAhUSh6d1AdkcQLa0xPJ/
	HCBhTgE7ibvTQGaCnKoo0f99AxuEXStxasstJpBdEgJNXBJHr36CKnKRuPH4GwuELSzx6vgW
	qD9lJE5P7mGBaJjMKLH/3wd2CGc1o8Syxq9MEFXWEi1XnkB1OEpsPzCNEeQiCQE+iRtvBSEO
	5ZOYtG06M0SYV6KjTQiiWk1i9b03LBMYlWcheW0WktdmIbwGEdaRWLD7ExuGsLbEsoWvmSFs
	W4l1696zLGBkX8UonlpanJueWmyUl1quV5yYW1yal66XnJ+7iRGYYE//O/5lB+PyVx/1DjEy
	cTAeYlQBRcGG1RcYpVjy8vNSlUR497M+TBXiTUmsrEotyo8vKs1JLT7EKM3BoiTOq5oinyok
	kJ5YkpqdmlqQWgSTZeLglGpgcnsvc2XPZR6xbV2qL3ceNFDY29X9521o8asDx3b+KbdaM+Xv
	y7QoNcN1Fx9XqBgvm3Pg/AExaxMfk/QnE6s5Zp5K9rm4vZRP0uNvaeXC6efSGravfa8s9XFq
	Se5ivZa1nr6TezR5uVf9d+J5IPo06FVGxV7fV387Jz+1WPPP5Q/3wX0WrgfCF583tVxzwMv/
	zxLfRSYl+2a1caQs2Puwpj5KaoPxuSe14gb6adZOu6Zeqlg6+1uGqsyKozpnE+b+Zfx6mGXi
	lbozr2+FeK27yTap7lHv7nChXawbFzMuLV3Pc47zwc/ea6fPNkifnr7S3rr2i6N76NTJKbOu
	He2YWSHfy1buonlkd1b1k5dK4RuVWIozEg21mIuKEwFa5O6kKwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsVy+t/xe7pPPZ6kGpz+ymbx5EA7o8WZ7lyL
	WeumMFosbFvCYrFn70kWi8u75rBZHFl/lsVi6fWLTBabz55htrgx4SmjxeLlahb93/8yWTQ+
	nsFo8fn2b2aLnbs3MVncvr2T1WJfxwMmiy2fHzA5CHmsmbeG0WN2w0UWj6Wn37B5tOy7xe6x
	YFOpx6ZVnWwei/sms3pM3FPn8XmTXABnlJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGx
	eayVkamSvp1NSmpOZllqkb5dgl7G5/X7mQr2dDBWvNhg1MD4OLeLkZNDQsBE4vmRiaxdjFwc
	QgJLGSVuX/zFBJGQkdj45SorhC0s8edaFxtE0UdGiTXzDzJBOJsYJa6e3wxWxSKgIvF72QRm
	EJtNQEfi/Js7YLaIgKbEqRM/GUEamAUeMUucPPKVHSQhLBAp0dh2jg3E5hVwkPi9cxXUiomM
	EteePWKESAhKnJz5hAXEZhYok2hftgUozgFkS0ss/8cBEuYUsJO4O+0nI8SpihL93zewQdi1
	Ep//PmOcwCg8C8mkWUgmzUKYBBHWkrjx7yUThrC2xLKFr5khbFuJdevesyxgZF/FKJJaWpyb
	nltsqFecmFtcmpeul5yfu4kRmGK2Hfu5eQfjvFcf9Q4xMnEwHmJUAfl9w+oLjFIsefl5qUoi
	vPtZH6YK8aYkVlalFuXHF5XmpBYfYjQFBuNEZinR5Hxg8ssriTc0MzA1NDGzNDC1NDNWEuf1
	LOhIFBJITyxJzU5NLUgtgulj4uCUamCqCJvJ8qeK97+U07GfWsGr7FTEd2hzpa+b1dGv1alV
	6uS31//buX2Bm6NUPW9++yYgs/E637GtU/xPHu1MuOX8wFjtQcfRuPN+Dn+8VtkrFu6zO1TH
	5vJ8tdeFS5n2kVe3ahquWnNi4nqeTuuSl782Xiu8cvzbjQcNmRxia47wrH1jwspms3G/8edW
	h8+d1Q/zm7PkkkO+THMr3Ml78WtUyJ0bC14mvlzJ1vj05v6pT+MW+T886nw5PP7PNkEnjx+7
	9+mcbKi4LsO/vvV8gW7nY8+mZqmsxsu2a9VZH/88O2uLa0Pt/tOrlrJ41RkuP7Binq3Oysnx
	KccnCAUeSGtTMBcNCTxfGrTQXP7t6tBuJZbijERDLeai4kQA4g369sYDAAA=
X-CMS-MailID: 20240303095445eucas1p1b171bed2f027a663bc9bd6e176162427
X-Msg-Generator: CA
X-RootMTR: 20240301103955eucas1p2819ec263ca1fb10e01f6495066e465ca
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240301103955eucas1p2819ec263ca1fb10e01f6495066e465ca
References: <CGME20240301103955eucas1p2819ec263ca1fb10e01f6495066e465ca@eucas1p2.samsung.com>
	<20240301103913.934946-1-quic_hyiwei@quicinc.com>

--paf7qqks7mvup3rn
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 01, 2024 at 06:39:13PM +0800, Huang Yiwei wrote:
> Currently ftrace only dumps the global trace buffer on an OOPs. For
> debugging a production usecase, instance trace will be helpful to
> check specific problems since global trace buffer may be used for
> other purposes.
>=20
> This patch extend the ftrace_dump_on_oops parameter to dump a specific
> or multiple trace instances:
>=20
>   - ftrace_dump_on_oops=3D0: as before -- don't dump
>   - ftrace_dump_on_oops[=3D1]: as before -- dump the global trace buffer
>   on all CPUs
>   - ftrace_dump_on_oops=3D2 or =3Dorig_cpu: as before -- dump the global
>   trace buffer on CPU that triggered the oops
>   - ftrace_dump_on_oops=3D<instance_name>: new behavior -- dump the
>   tracing instance matching <instance_name>
>   - ftrace_dump_on_oops[=3D[<0|1|2|orig_cpu>,][<instance_name>[=3D<1|2|
>   orig_cpu>][,...]]]: new behavior -- dump the global trace buffer
>   and/or multiple instance buffer on all CPUs, or only dump on CPU
>   that triggered the oops if =3D2 or =3Dorig_cpu is given
>=20
> Also, the sysctl node can handle the input accordingly.
>=20
> Cc: Ross Zwisler <zwisler@google.com>
> Signed-off-by: Huang Yiwei <quic_hyiwei@quicinc.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  26 ++-
>  Documentation/admin-guide/sysctl/kernel.rst   |  30 +++-
>  include/linux/ftrace.h                        |   4 +-
>  include/linux/kernel.h                        |   1 +
>  kernel/sysctl.c                               |   4 +-
>  kernel/trace/trace.c                          | 156 +++++++++++++-----
>  kernel/trace/trace_selftest.c                 |   2 +-
>  7 files changed, 168 insertions(+), 55 deletions(-)
>=20
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index 31b3a25680d0..15298de387be 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1561,12 +1561,28 @@
>  			The above will cause the "foo" tracing instance to trigger
>  			a snapshot at the end of boot up.
> =20
> -	ftrace_dump_on_oops[=3Dorig_cpu]
> +	ftrace_dump_on_oops[=3D[<0|1|2|orig_cpu>,][<instance_name>[=3D<1|2|orig=
_cpu>]
> +			  [,...]]]
>  			[FTRACE] will dump the trace buffers on oops.
> -			If no parameter is passed, ftrace will dump
> -			buffers of all CPUs, but if you pass orig_cpu, it will
> -			dump only the buffer of the CPU that triggered the
> -			oops.
> +			If no parameter is passed, ftrace will dump global
> +			buffers of all CPUs, if you pass 2 or orig_cpu, it
> +			will dump only the buffer of the CPU that triggered
> +			the oops, or the specific instance will be dumped if
> +			its name is passed. Multiple instance dump is also
> +			supported, and instances are separated by commas. Each
> +			instance supports only dump on CPU that triggered the
> +			oops by passing 2 or orig_cpu to it.
> +
> +			ftrace_dump_on_oops=3Dfoo=3Dorig_cpu
> +
> +			The above will dump only the buffer of "foo" instance
> +			on CPU that triggered the oops.
> +
> +			ftrace_dump_on_oops,foo,bar=3Dorig_cpu
> +
> +			The above will dump global buffer on all CPUs, the
> +			buffer of "foo" instance on all CPUs and the buffer
> +			of "bar" instance on CPU that triggered the oops.
> =20
>  	ftrace_filter=3D[function-list]
>  			[FTRACE] Limit the functions traced by the function
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/=
admin-guide/sysctl/kernel.rst
> index 6584a1f9bfe3..ea8e5f152edc 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -296,12 +296,30 @@ kernel panic). This will output the contents of the=
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
> -
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +0                       Disabled (default).
> +1                       Dump buffers of all CPUs.
> +2(orig_cpu)             Dump the buffer of the CPU that triggered the
> +                        oops.
> +<instance>              Dump the specific instance buffer on all CPUs.
> +<instance>=3D2(orig_cpu)  Dump the specific instance buffer on the CPU
> +                        that triggered the oops.
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Multiple instance dump is also supported, and instances are separated
> +by commas. If global buffer also needs to be dumped, please specify
> +the dump mode (1/2/orig_cpu) first for global buffer.
> +
> +So for example to dump "foo" and "bar" instance buffer on all CPUs,
> +user can::
> +
> +  echo "foo,bar" > /proc/sys/kernel/ftrace_dump_on_oops
> +
> +To dump global buffer and "foo" instance buffer on all
> +CPUs along with the "bar" instance buffer on CPU that triggered the
> +oops, user can::
> +
> +  echo "1,foo,bar=3D2" > /proc/sys/kernel/ftrace_dump_on_oops
> =20
>  ftrace_enabled, stack_tracer_enabled
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index e8921871ef9a..54d53f345d14 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -1151,7 +1151,9 @@ static inline void unpause_graph_tracing(void) { }
>  #ifdef CONFIG_TRACING
>  enum ftrace_dump_mode;
> =20
> -extern enum ftrace_dump_mode ftrace_dump_on_oops;
> +#define MAX_TRACER_SIZE		100
Small question here: This is 100 because the instance name can span
several characters. Right? Is there a possibility that the instance name
span more than 100 chars? Is the instance name length capped somewhere?

Thx for the clarification

> +extern char ftrace_dump_on_oops[];
> +extern int ftrace_dump_on_oops_enabled(void);
>  extern int tracepoint_printk;
> =20
>  extern void disable_trace_on_warning(void);
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index d9ad21058eed..b142a4f41d34 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -255,6 +255,7 @@ enum ftrace_dump_mode {
>  	DUMP_NONE,
>  	DUMP_ALL,
>  	DUMP_ORIG,
> +	DUMP_PARAM,
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
> index 8198bfc54b58..71e420514b99 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -131,9 +131,12 @@ cpumask_var_t __read_mostly	tracing_buffer_mask;
>   * /proc/sys/kernel/ftrace_dump_on_oops
>   * Set 1 if you want to dump buffers of all CPUs
>   * Set 2 if you want to dump the buffer of the CPU that triggered oops
> + * Set instance name if you want to dump the specific trace instance
> + * Multiple instance dump is also supported, and instances are seperated
> + * by commas.
>   */
> -
> -enum ftrace_dump_mode ftrace_dump_on_oops;
> +/* Set to string format zero to disable by default */
> +char ftrace_dump_on_oops[MAX_TRACER_SIZE] =3D "0";
> =20
>  /* When set, tracing will stop when a WARN*() is hit */
>  int __disable_trace_on_warning;
> @@ -179,7 +182,6 @@ static void ftrace_trace_userstack(struct trace_array=
 *tr,
>  				   struct trace_buffer *buffer,
>  				   unsigned int trace_ctx);
> =20
> -#define MAX_TRACER_SIZE		100
>  static char bootup_tracer_buf[MAX_TRACER_SIZE] __initdata;
>  static char *default_bootup_tracer;
> =20
> @@ -202,19 +204,33 @@ static int __init set_cmdline_ftrace(char *str)
>  }
>  __setup("ftrace=3D", set_cmdline_ftrace);
> =20
> +int ftrace_dump_on_oops_enabled(void)
> +{
> +	if (!strcmp("0", ftrace_dump_on_oops))
> +		return 0;
> +	else
> +		return 1;
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
> +	if (*str =3D=3D ',') {
> +		strscpy(ftrace_dump_on_oops, "1", MAX_TRACER_SIZE);
> +		strscpy(ftrace_dump_on_oops + 1, str, MAX_TRACER_SIZE - 1);
> +		return 1;
> +	}
> +
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
> @@ -10245,14 +10261,14 @@ static struct notifier_block trace_die_notifier=
 =3D {
>  static int trace_die_panic_handler(struct notifier_block *self,
>  				unsigned long ev, void *unused)
>  {
> -	if (!ftrace_dump_on_oops)
> +	if (!ftrace_dump_on_oops_enabled())
>  		return NOTIFY_DONE;
> =20
>  	/* The die notifier requires DIE_OOPS to trigger */
>  	if (self =3D=3D &trace_die_notifier && ev !=3D DIE_OOPS)
>  		return NOTIFY_DONE;
> =20
> -	ftrace_dump(ftrace_dump_on_oops);
> +	ftrace_dump(DUMP_PARAM);
> =20
>  	return NOTIFY_DONE;
>  }
> @@ -10293,12 +10309,12 @@ trace_printk_seq(struct trace_seq *s)
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
> @@ -10318,22 +10334,19 @@ void trace_init_global_iter(struct trace_iterat=
or *iter)
>  	iter->fmt_size =3D STATIC_FMT_BUF_SIZE;
>  }
> =20
> -void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
> +void trace_init_global_iter(struct trace_iterator *iter)
> +{
> +	trace_init_iter(iter, &global_trace);
> +}
> +
> +static void ftrace_dump_one(struct trace_array *tr, enum ftrace_dump_mod=
e dump_mode)
>  {
>  	/* use static because iter can be a bit big for the stack */
>  	static struct trace_iterator iter;
> -	static atomic_t dump_running;
> -	struct trace_array *tr =3D &global_trace;
>  	unsigned int old_userobj;
>  	unsigned long flags;
>  	int cnt =3D 0, cpu;
> =20
> -	/* Only allow one dump user at a time. */
> -	if (atomic_inc_return(&dump_running) !=3D 1) {
> -		atomic_dec(&dump_running);
> -		return;
> -	}
> -
>  	/*
>  	 * Always turn off tracing when we dump.
>  	 * We don't need to show trace output of what happens
> @@ -10342,12 +10355,12 @@ void ftrace_dump(enum ftrace_dump_mode oops_dum=
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
> @@ -10358,21 +10371,15 @@ void ftrace_dump(enum ftrace_dump_mode oops_dum=
p_mode)
>  	/* don't look at user memory in panic mode */
>  	tr->trace_flags &=3D ~TRACE_ITER_SYM_USEROBJ;
> =20
> -	switch (oops_dump_mode) {
> -	case DUMP_ALL:
> -		iter.cpu_file =3D RING_BUFFER_ALL_CPUS;
> -		break;
> -	case DUMP_ORIG:
> +	if (dump_mode =3D=3D DUMP_ORIG)
>  		iter.cpu_file =3D raw_smp_processor_id();
> -		break;
> -	case DUMP_NONE:
> -		goto out_enable;
> -	default:
> -		printk(KERN_TRACE "Bad dumping mode, switching to all CPUs dump\n");
> +	else
>  		iter.cpu_file =3D RING_BUFFER_ALL_CPUS;
> -	}
> =20
> -	printk(KERN_TRACE "Dumping ftrace buffer:\n");
> +	if (tr =3D=3D &global_trace)
> +		printk(KERN_TRACE "Dumping ftrace buffer:\n");
> +	else
> +		printk(KERN_TRACE "Dumping ftrace instance %s buffer:\n", tr->name);
> =20
>  	/* Did function tracer already get disabled? */
>  	if (ftrace_is_dead()) {
> @@ -10414,15 +10421,84 @@ void ftrace_dump(enum ftrace_dump_mode oops_dum=
p_mode)
>  	else
>  		printk(KERN_TRACE "---------------------------------\n");
> =20
> - out_enable:
>  	tr->trace_flags |=3D old_userobj;
> =20
>  	for_each_tracing_cpu(cpu) {
>  		atomic_dec(&per_cpu_ptr(iter.array_buffer->data, cpu)->disabled);
>  	}
> -	atomic_dec(&dump_running);
>  	local_irq_restore(flags);
>  }
> +
> +static void ftrace_dump_by_param(void)
> +{
> +	bool first_param =3D true;
> +	char dump_param[MAX_TRACER_SIZE];
> +	char *buf, *token, *inst_name;
> +	struct trace_array *tr;
> +
> +	strscpy(dump_param, ftrace_dump_on_oops, MAX_TRACER_SIZE);
> +	buf =3D dump_param;
> +
> +	while ((token =3D strsep(&buf, ",")) !=3D NULL) {
> +		if (first_param) {
> +			first_param =3D false;
> +			if (!strcmp("0", token))
> +				continue;
> +			else if (!strcmp("1", token)) {
> +				ftrace_dump_one(&global_trace, DUMP_ALL);
> +				continue;
> +			}
> +			else if (!strcmp("2", token) ||
> +			  !strcmp("orig_cpu", token)) {
> +				ftrace_dump_one(&global_trace, DUMP_ORIG);
> +				continue;
> +			}
> +		}
> +
> +		inst_name =3D strsep(&token, "=3D");
> +		tr =3D trace_array_find(inst_name);
> +		if (!tr) {
> +			printk(KERN_TRACE "Instance %s not found\n", inst_name);
> +			continue;
> +		}
> +
> +		if (token && (!strcmp("2", token) ||
> +			  !strcmp("orig_cpu", token)))
> +			ftrace_dump_one(tr, DUMP_ORIG);
> +		else
> +			ftrace_dump_one(tr, DUMP_ALL);
> +	}
> +}
> +
> +void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
> +{
> +	static atomic_t dump_running;
> +
> +	/* Only allow one dump user at a time. */
> +	if (atomic_inc_return(&dump_running) !=3D 1) {
> +		atomic_dec(&dump_running);
> +		return;
> +	}
> +
> +	switch (oops_dump_mode) {
> +	case DUMP_ALL:
> +		ftrace_dump_one(&global_trace, DUMP_ALL);
> +		break;
> +	case DUMP_ORIG:
> +		ftrace_dump_one(&global_trace, DUMP_ORIG);
> +		break;
> +	case DUMP_PARAM:
> +		ftrace_dump_by_param();
> +		break;
> +	case DUMP_NONE:
> +		break;
> +	default:
> +		printk(KERN_TRACE "Bad dumping mode, switching to all CPUs dump\n");
> +		ftrace_dump_one(&global_trace, DUMP_ALL);
> +	}
> +
> +	atomic_dec(&dump_running);
> +}
>  EXPORT_SYMBOL_GPL(ftrace_dump);
> =20
>  #define WRITE_BUFSIZE  4096
> diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
> index 529590499b1f..e9c5058a8efd 100644
> --- a/kernel/trace/trace_selftest.c
> +++ b/kernel/trace/trace_selftest.c
> @@ -768,7 +768,7 @@ static int trace_graph_entry_watchdog(struct ftrace_g=
raph_ent *trace)
>  	if (unlikely(++graph_hang_thresh > GRAPH_MAX_FUNC_TEST)) {
>  		ftrace_graph_stop();
>  		printk(KERN_WARNING "BUG: Function graph tracer hang!\n");
> -		if (ftrace_dump_on_oops) {
> +		if (ftrace_dump_on_oops_enabled()) {
>  			ftrace_dump(DUMP_ALL);
>  			/* ftrace_dump() disables tracing */
>  			tracing_on();
> --=20
> 2.25.1
>=20

--=20

Joel Granados

--paf7qqks7mvup3rn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmXkSOAACgkQupfNUreW
QU+mVwv5AdRCAJZPl4qzX9pLfPeEu8gQJB5MGMtpT+YCYYG7iUWnZqzR9rQcCu7w
pmhrekaoCY8Qx2+ff3kP9oxNaP00E9mfhYa8NZgKpTdfvKuEAYihvkrSreXc7s/M
gdNLSGKsEYkMgv8dNcEc3ZEhBh3YUAPTVEhGQLKMearqVEzz/MEXotTq69OZ4PyL
Gg/Ne2TcWXSFyttyw7jB7ZKM2Zlsb9m2djeIZOHYDOHabyax/vQ8GwM4iieLpdWo
IL6y1XMzSRv6w4ECG+/OkMIveekfR9UQWc7vS7nU2BojQbupt7v+0EU1/KpDO1xM
KSLQTTZL1vcjIrItZELZVJyK6rbi5p72FUHnv8Qsqr4dh28EoQMM0U//d8qvAfb/
/uv7rGyrabrtGxBkSFv6w6NRrKgR7SRJZaQppR8Tq4Q63nESEc5qYSRwT126vROc
eJyxIoSPH/yJRn4esyH9frfEuk0K6GRzQM5zmZ+nAf1iJBFAruW23dANXwvZ2Ue6
dAxBvqMc
=GZLI
-----END PGP SIGNATURE-----

--paf7qqks7mvup3rn--

