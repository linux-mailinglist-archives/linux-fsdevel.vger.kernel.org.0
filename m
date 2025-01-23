Return-Path: <linux-fsdevel+bounces-40012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36773A1AC24
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 22:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08CF91884C8E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 21:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D641CAA8B;
	Thu, 23 Jan 2025 21:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="qJ1TwlPF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028CB1ADC62
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 21:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737669244; cv=none; b=cg0q102yC24Skw5xVDKjd1URl8CMZ4btm/4fJIMgGADkpejE97fYfn6rOPO7wE3Tf401nSPShhsvb9cGWNiiBj31+fDAvIpQxh5vOnsJMCC3N8+lvRU9aSnMYgwjjRBTdkYaxv0hZN3uofK4j++z0cTot8poRaf0EEDms+OpQtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737669244; c=relaxed/simple;
	bh=/gvZ50F2+mhmL9TV2IEVgsfyqYZ7q2HBFUD5yAR02bI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sLzxc11PulD5SkeiOz7wANknUpcmXBZLHBi5Qf1TqBfKjL0SyTmR5gFiSdJMVNMkc0OH+ohkr+8HRgqkOa4jeJNgDZGj/oUixQbUiR4VT8XLaG57gYi0mDujjz20dIV6zsxgECFgSVACwhCFR7kbSOVw9OygqLHaGg5RpHooYTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=qJ1TwlPF; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=3lWB74luNQJLvDNLTbKiiWs/mpSTuDjPsP8k7Gu2cVk=; b=qJ1TwlPFDH3g6uJ939nn3N04EO
	Lc78dNRSHdB0ljJ/gQmXJiuVL8poA+AloZDdEOgWotOIeq9Bjw5PuLnkUDqbhmcQsRCzb0T/VWfpU
	WjRm3n/HSGmrrYKJSXo9WfOkhoKyHjIZ1REU4KnFdS9IhpLxESA6yrN4C0AlsXoGXhokYOnLYa6SX
	scPqeoZ2GQ6iivd3L0ukpylaAyDUuvflsTV4uC0kzLoyl/jgy4X2Ksd5Cu9pB4Z50KSvICeYe9Asg
	nH5RWMEqp0QVZUe7OOU5Wg9Q9mqvq6rH+McFPblhCJgqDcFIXykNdidCEqgi3G9nv5HBTnsNTFnRg
	aVnPQP8A==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tb596-001RvY-Tb; Thu, 23 Jan 2025 22:53:52 +0100
From: Luis Henriques <luis@igalia.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu,  linux-fsdevel@vger.kernel.org,
  bernd.schubert@fastmail.fm,  jefflexu@linux.alibaba.com,
  laoar.shao@gmail.com,  jlayton@kernel.org,  senozhatsky@chromium.org,
  tfiga@chromium.org,  bgeffon@google.com,  etmartin4313@gmail.com,
  kernel-team@meta.com,  Bernd Schubert <bschubert@ddn.com>,  Josef Bacik
 <josef@toxicpanda.com>
Subject: Re: [PATCH v12 2/2] fuse: add default_request_timeout and
 max_request_timeout sysctls
In-Reply-To: <CAJnrk1aNyk6meJObQKgQ3Szv6aws7QJqYJS5bGYYVApOBqWOcw@mail.gmail.com>
	(Joanne Koong's message of "Thu, 23 Jan 2025 09:18:51 -0800")
References: <20250122215528.1270478-1-joannelkoong@gmail.com>
	<20250122215528.1270478-3-joannelkoong@gmail.com>
	<87ikq5x4ws.fsf@igalia.com>
	<CAJnrk1aNyk6meJObQKgQ3Szv6aws7QJqYJS5bGYYVApOBqWOcw@mail.gmail.com>
Date: Thu, 23 Jan 2025 21:54:43 +0000
Message-ID: <874j1pkxgc.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Joanne,

On Thu, Jan 23 2025, Joanne Koong wrote:

> On Thu, Jan 23, 2025 at 1:21=E2=80=AFAM Luis Henriques <luis@igalia.com> =
wrote:
>>
>> Hi Joanne,
>>
>> On Wed, Jan 22 2025, Joanne Koong wrote:
>>
>> > Introduce two new sysctls, "default_request_timeout" and
>> > "max_request_timeout". These control how long (in seconds) a server can
>> > take to reply to a request. If the server does not reply by the timeou=
t,
>> > then the connection will be aborted. The upper bound on these sysctl
>> > values is 65535.
>> >
>> > "default_request_timeout" sets the default timeout if no timeout is
>> > specified by the fuse server on mount. 0 (default) indicates no default
>> > timeout should be enforced. If the server did specify a timeout, then
>> > default_request_timeout will be ignored.
>> >
>> > "max_request_timeout" sets the max amount of time the server may take =
to
>> > reply to a request. 0 (default) indicates no maximum timeout. If
>> > max_request_timeout is set and the fuse server attempts to set a
>> > timeout greater than max_request_timeout, the system will use
>> > max_request_timeout as the timeout. Similarly, if default_request_time=
out
>> > is greater than max_request_timeout, the system will use
>> > max_request_timeout as the timeout. If the server does not request a
>> > timeout and default_request_timeout is set to 0 but max_request_timeout
>> > is set, then the timeout will be max_request_timeout.
>> >
>> > Please note that these timeouts are not 100% precise. The request may
>> > take roughly an extra FUSE_TIMEOUT_TIMER_FREQ seconds beyond the set m=
ax
>> > timeout due to how it's internally implemented.
>> >
>> > $ sysctl -a | grep fuse.default_request_timeout
>> > fs.fuse.default_request_timeout =3D 0
>> >
>> > $ echo 65536 | sudo tee /proc/sys/fs/fuse/default_request_timeout
>> > tee: /proc/sys/fs/fuse/default_request_timeout: Invalid argument
>> >
>> > $ echo 65535 | sudo tee /proc/sys/fs/fuse/default_request_timeout
>> > 65535
>> >
>> > $ sysctl -a | grep fuse.default_request_timeout
>> > fs.fuse.default_request_timeout =3D 65535
>> >
>> > $ echo 0 | sudo tee /proc/sys/fs/fuse/default_request_timeout
>> > 0
>> >
>> > $ sysctl -a | grep fuse.default_request_timeout
>> > fs.fuse.default_request_timeout =3D 0
>> >
>> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>> > Reviewed-by: Bernd Schubert <bschubert@ddn.com>
>> > Reviewed-by: Josef Bacik <josef@toxicpanda.com>
>> > Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
>> > ---
>> >  Documentation/admin-guide/sysctl/fs.rst | 25 ++++++++++++++++++++++
>> >  fs/fuse/fuse_i.h                        | 10 +++++++++
>> >  fs/fuse/inode.c                         | 28 +++++++++++++++++++++++--
>> >  fs/fuse/sysctl.c                        | 24 +++++++++++++++++++++
>> >  4 files changed, 85 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/a=
dmin-guide/sysctl/fs.rst
>> > index f5ec6c9312e1..35aeb30bed8b 100644
>> > --- a/Documentation/admin-guide/sysctl/fs.rst
>> > +++ b/Documentation/admin-guide/sysctl/fs.rst
>> > @@ -347,3 +347,28 @@ filesystems:
>> >  ``/proc/sys/fs/fuse/max_pages_limit`` is a read/write file for
>> >  setting/getting the maximum number of pages that can be used for serv=
icing
>> >  requests in FUSE.
>> > +
>> > +``/proc/sys/fs/fuse/default_request_timeout`` is a read/write file for
>> > +setting/getting the default timeout (in seconds) for a fuse server to
>> > +reply to a kernel-issued request in the event where the server did not
>> > +specify a timeout at mount. If the server set a timeout,
>> > +then default_request_timeout will be ignored.  The default
>> > +"default_request_timeout" is set to 0. 0 indicates no default timeout.
>> > +The maximum value that can be set is 65535.
>> > +
>> > +``/proc/sys/fs/fuse/max_request_timeout`` is a read/write file for
>> > +setting/getting the maximum timeout (in seconds) for a fuse server to
>> > +reply to a kernel-issued request. A value greater than 0 automaticall=
y opts
>> > +the server into a timeout that will be set to at most "max_request_ti=
meout",
>> > +even if the server did not specify a timeout and default_request_time=
out is
>> > +set to 0. If max_request_timeout is greater than 0 and the server set=
 a timeout
>> > +greater than max_request_timeout or default_request_timeout is set to=
 a value
>> > +greater than max_request_timeout, the system will use max_request_tim=
eout as the
>> > +timeout. 0 indicates no max request timeout. The maximum value that c=
an be set
>> > +is 65535.
>> > +
>> > +For timeouts, if the server does not respond to the request by the ti=
me
>> > +the set timeout elapses, then the connection to the fuse server will =
be aborted.
>> > +Please note that the timeouts are not 100% precise (eg you may set 60=
 seconds but
>> > +the timeout may kick in after 70 seconds). The upper margin of error =
for the
>> > +timeout is roughly FUSE_TIMEOUT_TIMER_FREQ seconds.
>> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
>> > index 1321cc4ed2ab..e5114831798f 100644
>> > --- a/fs/fuse/fuse_i.h
>> > +++ b/fs/fuse/fuse_i.h
>> > @@ -49,6 +49,16 @@ extern const unsigned long fuse_timeout_timer_freq;
>> >
>> >  /** Maximum of max_pages received in init_out */
>> >  extern unsigned int fuse_max_pages_limit;
>> > +/*
>> > + * Default timeout (in seconds) for the server to reply to a request
>> > + * before the connection is aborted, if no timeout was specified on m=
ount.
>> > + */
>> > +extern unsigned int fuse_default_req_timeout;
>> > +/*
>> > + * Max timeout (in seconds) for the server to reply to a request befo=
re
>> > + * the connection is aborted.
>> > + */
>> > +extern unsigned int fuse_max_req_timeout;
>> >
>> >  /** List of active connections */
>> >  extern struct list_head fuse_conn_list;
>> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
>> > index 79ebeb60015c..4e36d99fae52 100644
>> > --- a/fs/fuse/inode.c
>> > +++ b/fs/fuse/inode.c
>> > @@ -37,6 +37,9 @@ DEFINE_MUTEX(fuse_mutex);
>> >  static int set_global_limit(const char *val, const struct kernel_para=
m *kp);
>> >
>> >  unsigned int fuse_max_pages_limit =3D 256;
>> > +/* default is no timeout */
>> > +unsigned int fuse_default_req_timeout =3D 0;
>> > +unsigned int fuse_max_req_timeout =3D 0;
>> >
>> >  unsigned max_user_bgreq;
>> >  module_param_call(max_user_bgreq, set_global_limit, param_get_uint,
>> > @@ -1268,6 +1271,24 @@ static void set_request_timeout(struct fuse_con=
n *fc, unsigned int timeout)
>> >                          fuse_timeout_timer_freq);
>> >  }
>> >
>> > +static void init_server_timeout(struct fuse_conn *fc, unsigned int ti=
meout)
>> > +{
>> > +     if (!timeout && !fuse_max_req_timeout && !fuse_default_req_timeo=
ut)
>> > +             return;
>> > +
>> > +     if (!timeout)
>> > +             timeout =3D fuse_default_req_timeout;
>> > +
>> > +     if (fuse_max_req_timeout) {
>> > +             if (timeout)
>> > +                     timeout =3D min(fuse_max_req_timeout, timeout);
>>
>> Sorry for this late comment (this is v12 already!), but I wonder if it
>> would be worth to use clamp() instead of min().  Limiting this value to
>> the range [FUSE_TIMEOUT_TIMER_FREQ, fuxe_max_req_timeout] would prevent
>> accidentally setting the timeout to a very low value.
>
> I don't think we need to clamp to FUSE_TIMEOUT_TIMER_FREQ. If the user
> sets a timeout value lower than FUSE_TIMEOUT_TIMER_FREQ (15 secs), imo
> that should be supported. For example, if the user sets the timeout to
> 10 seconds, then the connection should be aborted if the request takes
> 13 seconds. I don't see why we need to have the min bound be
> FUSE_TIMEOUT_TIMER_FREQ. imo, the user-specified timeout value and
> FUSE_TIMEOUT_TIMER_FREQ value are orthogonal. But I also don't feel
> strongly about this and am fine with whichever way we go.

Sure, my comment was just a suggestion too.  I just thought it would be
easy to accidentally set the timeout to '1' instead of '10', and that this
very low value could cause troubles.  On the other hand, I understand that
15 secondss is probably too high for using as a minimum.  Anyway, this was
just my 2=C2=A2.

Cheers,
--=20
Luis

>
> Thanks,
> Joanne
>
>>
>> There are also some white-spaces/tabs issues with the other patch, which
>> are worth fixing before merging.  Other than that, feel free to add my
>>
>> Reviewed-by: Luis Henriques <luis@igalia.com>
>>
>> Cheers,
>> --
>> Lu=C3=ADs
>>
>> > +             else
>> > +                     timeout =3D fuse_max_req_timeout;
>> > +     }
>> > +
>> > +     set_request_timeout(fc, timeout);
>> > +}
>> > +
>> >  struct fuse_init_args {
>> >       struct fuse_args args;
>> >       struct fuse_init_in in;
>> > @@ -1286,6 +1307,7 @@ static void process_init_reply(struct fuse_mount=
 *fm, struct fuse_args *args,
>> >               ok =3D false;
>> >       else {
>> >               unsigned long ra_pages;
>> > +             unsigned int timeout =3D 0;
>> >
>> >               process_init_limits(fc, arg);
>> >
>> > @@ -1404,14 +1426,16 @@ static void process_init_reply(struct fuse_mou=
nt *fm, struct fuse_args *args,
>> >                       if (flags & FUSE_OVER_IO_URING && fuse_uring_ena=
bled())
>> >                               fc->io_uring =3D 1;
>> >
>> > -                     if ((flags & FUSE_REQUEST_TIMEOUT) && arg->reque=
st_timeout)
>> > -                             set_request_timeout(fc, arg->request_tim=
eout);
>> > +                     if (flags & FUSE_REQUEST_TIMEOUT)
>> > +                             timeout =3D arg->request_timeout;
>> >               } else {
>> >                       ra_pages =3D fc->max_read / PAGE_SIZE;
>> >                       fc->no_lock =3D 1;
>> >                       fc->no_flock =3D 1;
>> >               }
>> >
>> > +             init_server_timeout(fc, timeout);
>> > +
>> >               fm->sb->s_bdi->ra_pages =3D
>> >                               min(fm->sb->s_bdi->ra_pages, ra_pages);
>> >               fc->minor =3D arg->minor;
>> > diff --git a/fs/fuse/sysctl.c b/fs/fuse/sysctl.c
>> > index b272bb333005..3d542ef9d889 100644
>> > --- a/fs/fuse/sysctl.c
>> > +++ b/fs/fuse/sysctl.c
>> > @@ -13,6 +13,12 @@ static struct ctl_table_header *fuse_table_header;
>> >  /* Bound by fuse_init_out max_pages, which is a u16 */
>> >  static unsigned int sysctl_fuse_max_pages_limit =3D 65535;
>> >
>> > +/*
>> > + * fuse_init_out request timeouts are u16.
>> > + * This goes up to ~18 hours, which is plenty for a timeout.
>> > + */
>> > +static unsigned int sysctl_fuse_req_timeout_limit =3D 65535;
>> > +
>> >  static struct ctl_table fuse_sysctl_table[] =3D {
>> >       {
>> >               .procname       =3D "max_pages_limit",
>> > @@ -23,6 +29,24 @@ static struct ctl_table fuse_sysctl_table[] =3D {
>> >               .extra1         =3D SYSCTL_ONE,
>> >               .extra2         =3D &sysctl_fuse_max_pages_limit,
>> >       },
>> > +     {
>> > +             .procname       =3D "default_request_timeout",
>> > +             .data           =3D &fuse_default_req_timeout,
>> > +             .maxlen         =3D sizeof(fuse_default_req_timeout),
>> > +             .mode           =3D 0644,
>> > +             .proc_handler   =3D proc_douintvec_minmax,
>> > +             .extra1         =3D SYSCTL_ZERO,
>> > +             .extra2         =3D &sysctl_fuse_req_timeout_limit,
>> > +     },
>> > +     {
>> > +             .procname       =3D "max_request_timeout",
>> > +             .data           =3D &fuse_max_req_timeout,
>> > +             .maxlen         =3D sizeof(fuse_max_req_timeout),
>> > +             .mode           =3D 0644,
>> > +             .proc_handler   =3D proc_douintvec_minmax,
>> > +             .extra1         =3D SYSCTL_ZERO,
>> > +             .extra2         =3D &sysctl_fuse_req_timeout_limit,
>> > +     },
>> >  };
>> >
>> >  int fuse_sysctl_register(void)
>> > --
>> > 2.43.5
>> >
>>

