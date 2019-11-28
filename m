Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70C2310C8C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2019 13:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfK1Mj3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Nov 2019 07:39:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:45470 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726227AbfK1Mj2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Nov 2019 07:39:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8169FABF4;
        Thu, 28 Nov 2019 12:39:26 +0000 (UTC)
Date:   Thu, 28 Nov 2019 13:39:24 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH v2 1/3] sched/numa: advanced per-cgroup numa statistic
Message-ID: <20191128123924.GD831@blackbody.suse.cz>
References: <743eecad-9556-a241-546b-c8a66339840e@linux.alibaba.com>
 <207ef46c-672c-27c8-2012-735bd692a6de@linux.alibaba.com>
 <9354ffe8-81ba-9e76-e0b3-222bc942b3fc@linux.alibaba.com>
 <20191127101932.GN28938@suse.de>
 <3ff78d18-fa29-13f3-81e5-a05537a2e344@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OaZoDhBhXzo6bW1J"
Content-Disposition: inline
In-Reply-To: <3ff78d18-fa29-13f3-81e5-a05537a2e344@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--OaZoDhBhXzo6bW1J
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

My primary concern is still the measuring of per-NUMA node execution
time.

First, I think exposing the aggregated data into the numa_stat file is
loss of information. The data are collected per-CPU and then summed over
NUMA nodes -- this could be easily done by the userspace consumer of the
data, keeping the per-CPU data available.

Second, comparing with the cpuacct implementation, yours has only jiffy
granularity (I may have overlooked something or I miss some context,
then it's a non-concern).

IOW, to me it sounds like duplicating cpuacct job and if that is deemed
useful for cgroup v2, I think it should be done (only once) and at
proper place (i.e. how cputime is measured in the default hierarchy).

The previous two are design/theoretical remarks, however, your patch
misses measuring of other than fair_sched_class policy tasks. Is that
intentional?

My last two comments are to locality measurement but are based on no
experience or specific knowledge.

The seven percentile groups seem quite arbitrary to me, I find it
strange that the ratio of cache-line size and u64 leaks and is fixed in
the generally visible file. Wouldn't such a form be better hidden under
a _DEBUG config option?


On Thu, Nov 28, 2019 at 10:09:13AM +0800, =E7=8E=8B=E8=B4=87 <yun.wang@linu=
x.alibaba.com> wrote:
> Consider it as load_1/5/15 which not accurate but tell the trend of system
I understood your patchset provides cumulative data over time, i.e. if
a user wants to see an immediate trend, they have to calculate
differences. Have I overlooked some back-off or regular zeroing?

Michal

--OaZoDhBhXzo6bW1J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAl3fv/YACgkQia1+riC5
qSgj9Q/+I2TOZZ+nPAuxua7tVrpl21jtNgWwoNQOZpN84ZSwGCk2tlwRdhnu/SMz
pUGu1JJqcIQcuYBob+tHafkvyMQ0xBvAzpAQWbc4rGNJNSiIrqWzl+Kn/E82Wqz+
Jxbwude/xvITRvac3VjZbVkr0Ml49sJ/hxXXJfdSrKdWJYo2Rt1WTDjrU7dWQ027
FVuJKmrlzn20y53MBgNo7WZ5NV5IP/GpXUp1GHq42taJT79McycuxDs7JSt55cq4
BrYiLWL+vrFG3fkPt8InEnR89+cZY7ZDk+x5kxwtljyPjGHdZDGIqyiuZSH/S2XX
4uZQtk2hXVAyhixUbu5ktRqg0FfmwXOz3BAltsm2iJQETl7JjCILTLVTu3OJYHtB
FONUEwTZAiOEFFIZdmhGAdJRlqNaEi0iMWS7qBfKJTKbG7ZA4R1UdfjhxFgOH+Ag
dyr19qa//q+FT9yp3Lxwk/jbkvEcGZvom+AY1A6AyirlhvdmcfbDDqLK1wgstWaM
N0Nyv10sbNsYMHW8h72d9rcgatD+O0hLPYbOtSSntlo4nlh2FaD6/TA1ml7qXNDo
QtPyfalbhNYru9zrjkcv9PQYXNj7vCrLNkXtJ6ksuFRfyz4LgAtZiX5EVyBf9FGb
YCENs8Yw25crUt6H1vdfMZCE6HigJbJKgn4X+1N3bCJ0uwLPci8=
=YWb4
-----END PGP SIGNATURE-----

--OaZoDhBhXzo6bW1J--
