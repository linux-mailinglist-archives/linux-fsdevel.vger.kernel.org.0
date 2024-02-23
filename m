Return-Path: <linux-fsdevel+bounces-12526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A6A860873
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 02:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4C9F1C21F4C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 01:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34500B66C;
	Fri, 23 Feb 2024 01:45:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01ABAD53;
	Fri, 23 Feb 2024 01:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708652712; cv=none; b=cQgycTtw5w7fMyH80AD+0P8SguxmDZn6eirE0EaTVUZ26fRv9nLHKXJA04uUyO8KJVBSqK8kt0grthnvZ0bUp88L+PZ/fqAeHCiBfRRHZDykZicuIEGnZ9Q8GhGdzvQ3EsZ374k6k574lfN6TMwHEZrJU2a3yF33qCMoPwh6Vn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708652712; c=relaxed/simple;
	bh=n6RPnC6yufWY3n3pn0vWSMZ9igCtwEYuAlgxz4yas28=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pnqhgnz1FFbs/Gt/Px/+2ZrSoWvMQh7e2wdf3hsBOeoBZM+EbdFmxnaAPOnh6fjgJN6ievapZ1JC/aWhXzgvswbr9vCj9HUck8/v2ECVemLJhda2X/hvnIvhMqlrcSKG791Ep8fGs0+YprOtq4scPGZR8wuzOzARrHeTCth2tVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8AFC433C7;
	Fri, 23 Feb 2024 01:45:10 +0000 (UTC)
Date: Thu, 22 Feb 2024 20:47:01 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Huang Yiwei <quic_hyiwei@quicinc.com>
Cc: <mhiramat@kernel.org>, <mark.rutland@arm.com>, <mcgrof@kernel.org>,
 <keescook@chromium.org>, <j.granados@samsung.com>,
 <mathieu.desnoyers@efficios.com>, <corbet@lwn.net>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <quic_bjorande@quicinc.com>, <quic_tsoni@quicinc.com>,
 <quic_satyap@quicinc.com>, <quic_aiquny@quicinc.com>, <kernel@quicinc.com>,
 Ross Zwisler <zwisler@google.com>, Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v5] tracing: Support to dump instance traces by
 ftrace_dump_on_oops
Message-ID: <20240222204701.6b9de71e@gandalf.local.home>
In-Reply-To: <20240208131814.614691-1-quic_hyiwei@quicinc.com>
References: <20240208131814.614691-1-quic_hyiwei@quicinc.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 8 Feb 2024 21:18:14 +0800
Huang Yiwei <quic_hyiwei@quicinc.com> wrote:

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
>   - ftrace_dump_on_oops[=3D2/orig_cpu],<instance1_name>[=3D2/orig_cpu],
>   <instrance2_name>[=3D2/orig_cpu]: new behavior -- dump the global trace
>   buffer and multiple instance buffer on all CPUs, or only dump on CPU
>   that triggered the oops if =3D2 or =3Dorig_cpu is given
>=20
> Also, the sysctl node can handle the input accordingly.
>=20
> Cc: Ross Zwisler <zwisler@google.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Huang Yiwei <quic_hyiwei@quicinc.com>

This patch failed with the following warning:

  kernel/trace/trace.c:10029:6: warning: no previous prototype for =E2=80=
=98ftrace_dump_one=E2=80=99 [-Wmissing-prototypes]

-- Steve

