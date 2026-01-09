Return-Path: <linux-fsdevel+bounces-73044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E48D09317
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 13:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90D3B30A4267
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 11:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF613590C6;
	Fri,  9 Jan 2026 11:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="WTCq4LCt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D749432BF21;
	Fri,  9 Jan 2026 11:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767959867; cv=none; b=Ly942SbNL9mMdJpBTCdmShNyDIuO+N+9ZrTUJ42s/wUQp//k5a7Bhr7D8Nq9X8+sBTynrNWdDDlywfmKWVris2Jh9qckngZYkeUYEtXoUMCHAD4qcwVmUD6/mtbHtkD4aD0b2WsgB39sIFzi6hsyqc3tKDlMTUh90EDjmP9QqHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767959867; c=relaxed/simple;
	bh=QCZB8ASOw0589HqfkX15FUualvIn1+xleT0q12mvSFs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I0yyQv56hNJmFrLIjowzFUVb8xEspl22dvPVtv7yjCAtSmMfBgPbaQmmlJWvmbjeElTLCuX9NcpjXSSDdjPn2owZszYevzcNoPntcvIwxs4h27k6WqGJubKfSNKgG7O8Fi1x5BOoubl76lS2f7sywH545oQ3dfiWg93oezfb2jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=WTCq4LCt; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=i5sSJksnYgQS7OmiThH7LGvbiWHBznpFnHcSqiUZKlA=; b=WTCq4LCtXcfMLvlhTir6pffNZJ
	JR9QwZF2Y8ZjMj7wNZ0hMm0rpSpjTKbjJPxH6NxDJjyoGVRyTF8Gp7TQVWahY1aWfvOt4WjKBVQTr
	llL60ywyMDnHOSwk8KZECExBX7zkzKg7txeIkaj+ibDQfnoyrjepbfrJ6+0ufRO5cMWjiY9aWhYvo
	GAkLjIrCjuA8ZnfqiyMHnOHWVnk2psqiZtDHFYYOlDnOnR9zAlWHKIYwaisNzxgWi6/ar4KdBdNj0
	Zx5OaJqz0clHLROQi7gchXGwn5Wejy0u1yml9XQOF4XBu7FT7horoIcheH4Zo4HiDVyOQx2q5hk/3
	gOITwENQ==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1veB7U-003Own-2c; Fri, 09 Jan 2026 12:57:32 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>,  "Darrick J. Wong"
 <djwong@kernel.org>,  Bernd Schubert <bschubert@ddn.com>,  Kevin Chen
 <kchen@ddn.com>,  Horst Birthelmer <hbirthelmer@ddn.com>,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,  Matt
 Harvey <mharvey@jumptrading.com>,  kernel-dev@igalia.com
Subject: Re: [RFC PATCH v2 4/6] fuse: implementation of the
 FUSE_LOOKUP_HANDLE operation
In-Reply-To: <CAJfpegszP+2XA=vADK4r09KU30BQd-r9sNu2Dog88yLG8iV7WQ@mail.gmail.com>
	(Miklos Szeredi's message of "Tue, 16 Dec 2025 11:39:54 +0100")
References: <20251212181254.59365-1-luis@igalia.com>
	<20251212181254.59365-5-luis@igalia.com>
	<CAJfpegszP+2XA=vADK4r09KU30BQd-r9sNu2Dog88yLG8iV7WQ@mail.gmail.com>
Date: Fri, 09 Jan 2026 11:57:31 +0000
Message-ID: <87zf6nov6c.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Miklos,

On Tue, Dec 16 2025, Miklos Szeredi wrote:

> On Fri, 12 Dec 2025 at 19:12, Luis Henriques <luis@igalia.com> wrote:
>>
>> The implementation of LOOKUP_HANDLE modifies the LOOKUP operation to inc=
lude
>> an extra inarg: the file handle for the parent directory (if it is
>> available).  Also, because fuse_entry_out now has a extra variable size
>> struct (the actual handle), it also sets the out_argvar flag to true.
>
> How about adding this as an extension header (FUSE_EXT_HANDLE)?  That
> would allow any operation to take a handle instead of a nodeid.
>
> Yeah, the infrastructure for adding extensions is inadequate, but I
> think the API is ready for this.
>
>> @@ -181,8 +182,24 @@ static void fuse_lookup_init(struct fuse_conn *fc, =
struct fuse_args *args,
>>         args->in_args[2].size =3D 1;
>>         args->in_args[2].value =3D "";
>>         args->out_numargs =3D 1;
>> -       args->out_args[0].size =3D sizeof(struct fuse_entry_out);
>> +       args->out_args[0].size =3D sizeof(*outarg) + outarg->fh.size;
>> +
>> +       if (fc->lookup_handle) {
>> +               struct fuse_inode *fi =3D NULL;
>> +
>> +               args->opcode =3D FUSE_LOOKUP_HANDLE;
>> +               args->out_argvar =3D true;
>
> How about allocating variable length arguments on demand?  That would
> allow getting rid of max_handle_size negotiation.
>
>         args->out_var_alloc  =3D true;
>         args->out_args[1].size =3D MAX_HANDLE_SZ;
>         args->out_args[1].value =3D NULL; /* Will be allocated to the act=
ual size of the handle */

I've been trying to wrap my head around all the suggested changes, and
experimenting with a few options.  Since there are some major things that
need to be modified, I'd like to confirm that I got them right:

1. In the old FUSE_LOOKUP, the args->in_args[0] will continue to use the
   struct fuse_entry_out, which won't be changed and will continue to have
   a static size.

2. FUSE_LOOKUP_HANDLE will add a new out_arg, which will be dynamically
   allocated (using your suggestion: 'args->out_var_alloc').  This will be
   a new struct fuse_entry_handle_out, similar to fuse_entry_out, but
   replacing the struct fuse_attr by a struct fuse_statx, and adding the
   file handle struct.

3. FUSE_LOOKUP_HANDLE will use the args->in_args[0] as an extension header
   (FUSE_EXT_HANDLE).  Note that other operations (e.g. those in function
   create_new_entry()) will actually need to *add* an extra extension
   header, as extension headers are already being used there.
   This extension header will use the new struct fuse_entry_handle_out.

The above items seem to require some heavy changes on my current design.
That's why I'd like to make sure I got those right so that v3 is on the
right path.

Thanks in advance for any feedback!

Cheers,
--=20
Lu=C3=ADs

