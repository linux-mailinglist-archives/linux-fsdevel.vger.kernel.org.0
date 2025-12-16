Return-Path: <linux-fsdevel+bounces-71460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 29048CC1FD0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 11:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9BF4330220D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 10:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB0833CE95;
	Tue, 16 Dec 2025 10:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="FSOF8UYL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E05C313E17;
	Tue, 16 Dec 2025 10:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765881382; cv=none; b=U7Eo3M7uxviOkPLcu7iOB2pSm2GGNzk/2Sz89dQBUrs0PtA9lRIDZlmrnL2iS1BSwIaQY3TTXobqusnWPSbhS2A41z2c3sAv9TMCLWyTXS80ChGfE9Uc3X2dAkaatGKN5x5+vLFzYlxuLKcTreo4OR01PgMl81IYLv7U126mNK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765881382; c=relaxed/simple;
	bh=q06U7v7JeXssf1n1fmvO/x0bCigbtnHVuXJczJNIiTw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QreS1hJNbroqQKfOpxZQ78OmQoLU/7T4GphbUKZJ+EXKb46JyRYupEFB0CWjOxssdTemsA2TM/4l3czXOhtobrmy148Q680RSXbcdICXVxxIKlqAj6hjUG5vDk7V3ou7UkpHdzuwr7Zr8Iidza8zXMGUfBHdnkdilRrgaT5jXgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=FSOF8UYL; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=oIjfkjjCOq5FhBC2I+orpnkRDvoExxJPIVGvERd6bSA=; b=FSOF8UYLKyuLxN1MqwOcSzfjU/
	z9qtdtpM3iQOYq7So5zlJ/r5FvGWK2JJQu6MXF9ygD7YprLkhF825jYI+vP+SmPa4b5RB4nRS3FNr
	t/H6j3tVTg1DXvJe1r41rGAVAeJqk/79VvyQWl/lHqWcCloPGbzml7XV/6tH695gNxjB3R0LinEiS
	BkzcgQusdR3VTPKBxtg4s3CPyO2d5FJNb1ujCgOaK6dNE4dPPekO3WmjD8o+pAfiEZW+Xy18mJAi1
	beUMMqInalAR8pxQ8LpnzHibrZ2UF7Nhow7rSj3FAzxOhctEEBtPpbOM+jOrEM7jCFuVnWJPJOSA9
	vm9JRoqQ==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vVSPb-00DLgf-0R; Tue, 16 Dec 2025 11:36:11 +0100
From: Luis Henriques <luis@igalia.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>,  Miklos Szeredi <miklos@szeredi.hu>,
  "Darrick J. Wong" <djwong@kernel.org>,  Kevin Chen <kchen@ddn.com>,
  Horst Birthelmer <hbirthelmer@ddn.com>,  "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,  Matt Harvey <mharvey@jumptrading.com>,
  "kernel-dev@igalia.com" <kernel-dev@igalia.com>
Subject: Re: [RFC PATCH v2 3/6] fuse: initial infrastructure for
 FUSE_LOOKUP_HANDLE support
In-Reply-To: <CAOQ4uxh-+S_KMSjH6CYRGa--aLfQOeqCTt=22DGSRQUJTJ2bPw@mail.gmail.com>
	(Amir Goldstein's message of "Mon, 15 Dec 2025 19:09:41 +0100")
References: <20251212181254.59365-1-luis@igalia.com>
	<20251212181254.59365-4-luis@igalia.com>
	<87f48f32-ddc4-4c57-98c1-75bc5e684390@ddn.com>
	<CAOQ4uxj_-_zbuCLdWuHQj4fx2sBOn04+-6F2WiC9SRdmcacsDA@mail.gmail.com>
	<8bae31f2-37fc-4a87-98c8-4aa966c812af@ddn.com>
	<CAOQ4uxh-+S_KMSjH6CYRGa--aLfQOeqCTt=22DGSRQUJTJ2bPw@mail.gmail.com>
Date: Tue, 16 Dec 2025 10:36:10 +0000
Message-ID: <87wm2md885.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15 2025, Amir Goldstein wrote:

> On Mon, Dec 15, 2025 at 6:11=E2=80=AFPM Bernd Schubert <bschubert@ddn.com=
> wrote:
>>
>> On 12/15/25 18:06, Amir Goldstein wrote:
>> > On Mon, Dec 15, 2025 at 2:36=E2=80=AFPM Bernd Schubert <bschubert@ddn.=
com> wrote:
>> >>
>> >> Hi Luis,
>> >>
>> >> I'm really sorry for late review.
>> >>
>> >> On 12/12/25 19:12, Luis Henriques wrote:
>> >>> This patch adds the initial infrastructure to implement the LOOKUP_H=
ANDLE
>> >>> operation.  It simply defines the new operation and the extra fuse_i=
nit_out
>> >>> field to set the maximum handle size.
>> >>>
>> >>> Signed-off-by: Luis Henriques <luis@igalia.com>
>> >>> ---
>> >>>    fs/fuse/fuse_i.h          | 4 ++++
>> >>>    fs/fuse/inode.c           | 9 ++++++++-
>> >>>    include/uapi/linux/fuse.h | 8 +++++++-
>> >>>    3 files changed, 19 insertions(+), 2 deletions(-)
>> >>>
>> >>> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
>> >>> index 1792ee6f5da6..fad05fae7e54 100644
>> >>> --- a/fs/fuse/fuse_i.h
>> >>> +++ b/fs/fuse/fuse_i.h
>> >>> @@ -909,6 +909,10 @@ struct fuse_conn {
>> >>>        /* Is synchronous FUSE_INIT allowed? */
>> >>>        unsigned int sync_init:1;
>> >>>
>> >>> +     /** Is LOOKUP_HANDLE implemented by fs? */
>> >>> +     unsigned int lookup_handle:1;
>> >>> +     unsigned int max_handle_sz;
>> >>> +
>
> The bitwise section better be clearly separated from the non bitwise sect=
ion,
> but as I wrote, the bitwise one is not needed anyway.
>
>> >>>        /* Use io_uring for communication */
>> >>>        unsigned int io_uring;
>> >>>
>> >>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
>> >>> index ef63300c634f..bc84e7ed1e3d 100644
>> >>> --- a/fs/fuse/inode.c
>> >>> +++ b/fs/fuse/inode.c
>> >>> @@ -1465,6 +1465,13 @@ static void process_init_reply(struct fuse_mo=
unt *fm, struct fuse_args *args,
>> >>>
>> >>>                        if (flags & FUSE_REQUEST_TIMEOUT)
>> >>>                                timeout =3D arg->request_timeout;
>> >>> +
>> >>> +                     if ((flags & FUSE_HAS_LOOKUP_HANDLE) &&
>> >>> +                         (arg->max_handle_sz > 0) &&
>> >>> +                         (arg->max_handle_sz <=3D FUSE_MAX_HANDLE_S=
Z)) {
>> >>> +                             fc->lookup_handle =3D 1;
>> >>> +                             fc->max_handle_sz =3D arg->max_handle_=
sz;
>> >>
>> >> I don't have a strong opinion on it, maybe
>> >>
>> >> if (flags & FUSE_HAS_LOOKUP_HANDLE) {
>> >>          if (!arg->max_handle_sz || arg->max_handle_sz > FUSE_MAX_HAN=
DLE_SZ) {
>> >>                  pr_info_ratelimited("Invalid fuse handle size %d\n, =
arg->max_handle_sz)
>> >>          } else {
>> >>                  fc->lookup_handle =3D 1;
>> >>                  fc->max_handle_sz =3D arg->max_handle_sz;

Right, having some warning here also makes sense.

>> >
>> > Why do we need both?
>> > This seems redundant.
>> > fc->max_handle_sz !=3D 0 is equivalent to fc->lookup_handle
>> > isnt it?
>>
>> I'm personally always worried that some fuse server implementations just
>> don't zero the entire buffer. I.e. areas they don't know about.
>> If all servers are guaranteed to do that the flag would not be needed.
>>
>
> I did not mean that we should not use the flag FUSE_HAS_LOOKUP_HANDLE
> we should definitely use it, but why do we need both
> bool fc->lookup_handle and unsigned fc->max_handle_sz in fuse_conn?
> The first one seems redundant.

OK, I'll drop the ->lookup_handle.  At some point it seemed to make sense
to have both, but it doesn't anymore (maybe I had max_handle_sz stored
somewhere else, not sure).  Thank you for your comments.

Cheers,
--=20
Lu=C3=ADs

