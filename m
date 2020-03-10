Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 132341805CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Mar 2020 19:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgCJSHZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Mar 2020 14:07:25 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44281 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726437AbgCJSHY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:07:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583863644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HtdZDSB9VGAI7D1yhnmNJX0tN7XLkk/JV9iMCSI2TFo=;
        b=My/uKnzKnn002sPkeyMOnj/wSYvZI4ziKy3viIxBOmsdd+9qfTlqv83MtlXJuZTwvmSIeN
        mAON5ufg5nzUpxx29F9IODqfO35MaS9WwheRlLYYzqqecGFUmGkY+FhJ4w43IjrK0xRdFs
        in1T71u2WCiuIXPa8r3eT4/H9/4vrD8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-MTcNXNR0PEifXEEHLcJJKA-1; Tue, 10 Mar 2020 14:07:21 -0400
X-MC-Unique: MTcNXNR0PEifXEEHLcJJKA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F04CC800D4E;
        Tue, 10 Mar 2020 18:07:19 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BDEAD19C7F;
        Tue, 10 Mar 2020 18:07:19 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 463E022021D; Tue, 10 Mar 2020 14:07:19 -0400 (EDT)
Date:   Tue, 10 Mar 2020 14:07:19 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Michael Stapelberg <michael+lkml@stapelberg.ch>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kyle Sanderson <kyle.leet@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Still a pretty bad time on 5.4.6 with fuse_request_end.
Message-ID: <20200310180719.GB38440@redhat.com>
References: <CAJfpegtUAHPL9tsFB85ZqjAfy0xwz7ATRcCtLbzFBo8=WnCvLw@mail.gmail.com>
 <20200209080918.1562823-1-michael+lkml@stapelberg.ch>
 <CAJfpegv4iL=bW3TXP3F9w1z6-LUox8KiBmw7UBcWE-0jiK0YsA@mail.gmail.com>
 <CANnVG6kYh6M30mwBHcGeFf=fhqKmWKPeUj2GYbvNgtq0hm=gXQ@mail.gmail.com>
 <CAJfpegtX0Z3_OZFG50epWGHkW5aOMfYmn61WmqYC67aBmJyDMA@mail.gmail.com>
 <CANnVG6=s1C7LSDGD1-Ato-sfaKi1LQvW3GM5wfAiUqWXibEohw@mail.gmail.com>
 <CAJfpegvBguKcNZk-p7sAtSuNH_7HfdCyYvo8Wh7X6P=hT=kPrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegvBguKcNZk-p7sAtSuNH_7HfdCyYvo8Wh7X6P=hT=kPrA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 12, 2020 at 08:36:11PM +0100, Miklos Szeredi wrote:
> On Wed, Feb 12, 2020 at 10:38 AM Michael Stapelberg
> <michael+lkml@stapelberg.ch> wrote:
> >
> > Unfortunately not: when I change the code like so:
> >
> >     bool async;
> >     uint32_t opcode_early =3D req->args->opcode;
> >
> >     if (test_and_set_bit(FR_FINISHED, &req->flags))
> >         goto put_request;
> >
> >     async =3D req->args->end;
> >
> > =E2=80=A6gdb only reports:
> >
> > (gdb) bt
> > #0  0x000000a700000001 in ?? ()
> > #1  0xffffffff8137fc99 in fuse_copy_finish (cs=3D0x20000ffffffff) at
> > fs/fuse/dev.c:681
> > Backtrace stopped: previous frame inner to this frame (corrupt stack?=
)
> >
> > But maybe that=E2=80=99s a hint in and of itself?
>=20
> Yep, it's a stack use after return bug.   Attached patch should fix
> it, though I haven't tested it.

I think I have noticed couple of crashes in fuse_request_end() while
it was trying to call req->args->end() and I suspect this patch might
fix the issue.

Just that I have not been able to reproduce it reliably to be able test
it.

Vivek

>=20
> Thanks,
> Miklos

> ---
>  fs/fuse/dev.c    |    6 +++---
>  fs/fuse/fuse_i.h |    2 ++
>  2 files changed, 5 insertions(+), 3 deletions(-)
>=20
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -276,12 +276,10 @@ static void flush_bg_queue(struct fuse_c
>  void fuse_request_end(struct fuse_conn *fc, struct fuse_req *req)
>  {
>  	struct fuse_iqueue *fiq =3D &fc->iq;
> -	bool async;
> =20
>  	if (test_and_set_bit(FR_FINISHED, &req->flags))
>  		goto put_request;
> =20
> -	async =3D req->args->end;
>  	/*
>  	 * test_and_set_bit() implies smp_mb() between bit
>  	 * changing and below intr_entry check. Pairs with
> @@ -324,7 +322,7 @@ void fuse_request_end(struct fuse_conn *
>  		wake_up(&req->waitq);
>  	}
> =20
> -	if (async)
> +	if (test_bit(FR_ASYNC, &req->flags))
>  		req->args->end(fc, req->args, req->out.h.error);
>  put_request:
>  	fuse_put_request(fc, req);
> @@ -471,6 +469,8 @@ static void fuse_args_to_req(struct fuse
>  	req->in.h.opcode =3D args->opcode;
>  	req->in.h.nodeid =3D args->nodeid;
>  	req->args =3D args;
> +	if (args->end)
> +		set_bit(FR_ASYNC, &req->flags);
>  }
> =20
>  ssize_t fuse_simple_request(struct fuse_conn *fc, struct fuse_args *ar=
gs)
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -301,6 +301,7 @@ struct fuse_io_priv {
>   * FR_SENT:		request is in userspace, waiting for an answer
>   * FR_FINISHED:		request is finished
>   * FR_PRIVATE:		request is on private list
> + * FR_ASYNC:		request is asynchronous
>   */
>  enum fuse_req_flag {
>  	FR_ISREPLY,
> @@ -314,6 +315,7 @@ enum fuse_req_flag {
>  	FR_SENT,
>  	FR_FINISHED,
>  	FR_PRIVATE,
> +	FR_ASYNC,
>  };
> =20
>  /**

