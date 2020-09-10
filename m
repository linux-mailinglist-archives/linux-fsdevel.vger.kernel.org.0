Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0141F264F9E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 21:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgIJTrS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 15:47:18 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:39477 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731269AbgIJPZR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 11:25:17 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-193-SwYyQJkFN1CKNX6P6arlLA-1; Thu, 10 Sep 2020 16:23:41 +0100
X-MC-Unique: SwYyQJkFN1CKNX6P6arlLA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 10 Sep 2020 16:23:40 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 10 Sep 2020 16:23:40 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Rich Felker' <dalias@libc.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] vfs: add fchmodat2 syscall
Thread-Topic: [PATCH] vfs: add fchmodat2 syscall
Thread-Index: AQHWh4NogO4zJqm73EG5GUWCltp+Valh+9/A
Date:   Thu, 10 Sep 2020 15:23:40 +0000
Message-ID: <1111806ca0344527a8855616e46346c5@AcuMS.aculab.com>
References: <20200910142335.GG3265@brightrain.aerifal.cx>
In-Reply-To: <20200910142335.GG3265@brightrain.aerifal.cx>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Rich Felker
> Sent: 10 September 2020 15:24
...
> index 9af548fb841b..570a21f4d81e 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -610,15 +610,30 @@ SYSCALL_DEFINE2(fchmod, unsigned int, fd, umode_t, mode)
>  	return err;
>  }
> 
> -static int do_fchmodat(int dfd, const char __user *filename, umode_t mode)
> +static int do_fchmodat(int dfd, const char __user *filename, umode_t mode, int flags)
>  {
>  	struct path path;
>  	int error;
>  	unsigned int lookup_flags = LOOKUP_FOLLOW;
> +
> +	if (flags & AT_SYMLINK_NOFOLLOW)
> +		lookup_flags &= ~LOOKUP_FOLLOW;
> +	if (flags & ~AT_SYMLINK_NOFOLLOW)
> +		return -EINVAL;

I think I'd swap over those two tests.
So unsupported flags are clearly errored.

>  retry:
>  	error = user_path_at(dfd, filename, lookup_flags, &path);
>  	if (!error) {
> -		error = chmod_common(&path, mode);
> +		/* Block chmod from getting to fs layer. Ideally the
> +		 * fs would either allow it or fail with EOPNOTSUPP,
> +		 * but some are buggy and return an error but change
> +		 * the mode, which is non-conforming and wrong.
> +		 * Userspace emulation of AT_SYMLINK_NOFOLLOW in
> +		 * glibc and musl blocked it too, for same reason. */
> +		if (S_ISLNK(path.dentry->d_inode->i_mode)
> +		    && (flags & AT_SYMLINK_NOFOLLOW))
> +			error = -EOPNOTSUPP;

Again swap the order of the tests. I think it reads better as:
		if ((flags & AT_SYMLINK_NOFOLLOW)
		    && S_ISLNK(path.dentry->d_inode->i_mode))
			error = -EOPNOTSUPP;
As well as saving a few clock cycles.

> +		else
> +			error = chmod_common(&path, mode);
>  		path_put(&path);
>  		if (retry_estale(error, lookup_flags)) {
>  			lookup_flags |= LOOKUP_REVAL;
...

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

