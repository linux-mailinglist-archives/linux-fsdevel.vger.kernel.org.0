Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78A1910CC43
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2019 16:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfK1P6Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Nov 2019 10:58:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:44502 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726401AbfK1P6X (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Nov 2019 10:58:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B593BB1FB;
        Thu, 28 Nov 2019 15:58:20 +0000 (UTC)
Date:   Thu, 28 Nov 2019 16:58:18 +0100
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
Message-ID: <20191128155818.GE831@blackbody.suse.cz>
References: <743eecad-9556-a241-546b-c8a66339840e@linux.alibaba.com>
 <207ef46c-672c-27c8-2012-735bd692a6de@linux.alibaba.com>
 <9354ffe8-81ba-9e76-e0b3-222bc942b3fc@linux.alibaba.com>
 <20191127101932.GN28938@suse.de>
 <3ff78d18-fa29-13f3-81e5-a05537a2e344@linux.alibaba.com>
 <20191128123924.GD831@blackbody.suse.cz>
 <e008fef6-06d2-28d3-f4d3-229f4b181b4f@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9l24NVCWtSuIVIod"
Content-Disposition: inline
In-Reply-To: <e008fef6-06d2-28d3-f4d3-229f4b181b4f@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--9l24NVCWtSuIVIod
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2019 at 09:41:37PM +0800, =E7=8E=8B=E8=B4=87 <yun.wang@linu=
x.alibaba.com> wrote:
> There are used to be a discussion on this, Peter mentioned we no longer
> expose raw ticks into userspace and micro seconds could be fine.
I don't mean the unit presented but the precision.

> Basically we use this to calculate percentages, for which jiffy could be
> accurate enough :-)
You also report the raw times.

Ad percentages (or raw times precision), on average, it should be fine
but can't there be any "aliasing" artifacts when only an unimportant
task is regularly sampled, hence not capturing the real pattern on the
CPU? (Again, I'm not confident I'm not missing anything that prevents
that behavior.)

> But still, what if folks don't use v2... any good suggestions?
(Note this applies to exectimes not locality.) On v1, they can add up
per CPU values from cpuacct. (So it's v2 that's missing the records.)


> Yes, since they don't have NUMA balancing to do optimization, and
> generally they are not that much.
Aha, I didn't realize that.

> Sorry but I don't get it... at first it was 10 regions, as Peter suggested
> we pick 8, but now to insert member 'jiffies' it become 7,
See, there are various arguments for different values :-)

I meant that the currently chosen one is imprinted into the API file.
That is IMO fixable by documenting (e.g. the number of bands may change,
assume uniform division) or making all this just a debug API. Or, see
below.

> Yes, here what I try to highlight is the similar usage, but not the way of
> monitoring ;-) as the docs tell, we monitoring increments.
I see, the docs give me an idea what's the supposed use case.

What about exposing only the counters for local, remote and let the user
do their monitoring based on =CE=94local/(=CE=94local + =CE=94remote)?

That would avoid the partitioning question completely, exposed values
would be simple numbers and provided information should be equal. A
drawback is that such a sampling would be slower (but sufficient for the
illustrating example).

Michal

--9l24NVCWtSuIVIod
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAl3f7pIACgkQia1+riC5
qSh1eA/7B1Pr1I/nxQSY3n0NbVS3hJW2czHc9vMnQ9IykuHUc3DNgsugiQ382l4a
Kh46uyGXbOyj5k8OCSCAihN/OSPz8Xv5PMYfsgLshhIHN6konY6LE7yOTCJYvgUM
/n7+pHXvFVFmyU/1giGpfOsOPNRlB92ohm0VG9b56Oo5GjWjQbXbHKUT8GkOST3k
Ef7p2f/pJVnucYVlHMwDYdTK0j5a7eorEr6tZ/vSMldadrLgrGSGZAZY7d5yLwsH
SjyAoSdJf/dknjE/BeIpKTHX7OeNd42g4QutjMiQZ+3YyMeRiB7UN+ZDh0TVmt47
zxqiLdGkGQu6rDkDqIPgfTiUgfGSOY2/WpeHvuwKylb6+mPp92gfA9S8aaINs5ZM
nfMF8dWTGkZq86y/XLEYtDQrD/C8UUNSY3APyfO9PoXgYFlC51SS32SDASwYcX8o
Z/T1vOxwXGOBUCy+5gxDKy1x5bWwUNMvMZSON622ZxL2pXYFdHEhqqw4dGOfzFRX
NlXurxlGVkdRo053A9SnZiA4xINYZ37wPjUdchPni3R/qsaSdKGyqdAQEwR8STvL
KmHBZaVId4TQt1XrUVDPTIHwUiQjaPHxhfvctfoTIhrE0xHGmvJsZAWJbcIdkv5A
jfHzpZWdOHcxAbEew5C+Rs8JyAqw8d84hoopeBBMj5A8lhgOwEg=
=PQHj
-----END PGP SIGNATURE-----

--9l24NVCWtSuIVIod--
