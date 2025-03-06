Return-Path: <linux-fsdevel+bounces-43353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2FDA54BD1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 14:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31C83175058
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 13:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CFB20F096;
	Thu,  6 Mar 2025 13:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="c8ESAFFV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9871220E30A;
	Thu,  6 Mar 2025 13:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741266975; cv=none; b=lYmG/Gea+lQ0P/ynurcUveK2N1E+5MIGi90XM2J6Hx+uJBOegL1YO2yWcXQVrmHcmJh3+z8jKNc/poo8Mzx23fV1BHe6cVvR/gGhaKCNTDDN2GdF+J11gb2grCJcvRWGCP6OzGTMl+wCW5XFwoQv4V6ex1wqwXGUTfCRdMFhE+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741266975; c=relaxed/simple;
	bh=RPvn/9JHKv0KUET0yq7JeqWzZgiTqKGfU9kbzBYO3Aw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lXLrssDE0FbviUvoZ7ZXsKAAGbxyIv9bs2ejUgdvwAkq09LvipbaEu45Nv3vjlvcyxM4fj2zgd201li1RRwv1OGo8JnJksAwE9Ifa7v2BnixIke+ClxVu3DuZxz5s5z/W2+FjtsE1qdkE9IA0JNM/NsZeyoOgaMtWlZXiqN2I3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=c8ESAFFV; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=2oMXT75K3tzJGkfzmknyPEa8yvFgjeDBRC2ukbCyplw=; b=c8ESAFFVd02/xr5SomVhTmc89w
	YoUUchGt/lkfyW2b09wdC10EQCGMHV6KeL5v6yLZiWlR7+U0HLnRv6XhiOmmVbk2ffwsrBPlkemBF
	nU668o8bpTsXIAWBbK1RsoqAbRD6z7rDWPuHi06+FlITALCNFMoycse38x+0scUPa/YeVVWR2wxfU
	ZP4TjBOaWz4xEK/9eQoMJXiNRmCoVTUpcCZ1IhXiEgA27S+WM9yQ4qvdFJe00/jVhdk0xXLR6bTMD
	sfupizO8tLft/pF2tlSXjE2GJ5L8lQVLb58Tr4AhPrBei/Fs9ezNpdWUXK4lwfkgKLbSyHcNmGhlZ
	5VSCaxaw==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tqB4u-004kVa-Vw; Thu, 06 Mar 2025 14:16:02 +0100
From: Luis Henriques <luis@igalia.com>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  kernel-dev@igalia.com
Subject: Re: [PATCH] fuse: fix possible deadlock if rings are never initialized
In-Reply-To: <1dc28f9d-c453-42f4-8edb-1d5c8084d576@bsbernd.com> (Bernd
	Schubert's message of "Thu, 6 Mar 2025 12:45:59 +0100")
References: <20250306111218.13734-1-luis@igalia.com>
	<1dc28f9d-c453-42f4-8edb-1d5c8084d576@bsbernd.com>
Date: Thu, 06 Mar 2025 13:16:02 +0000
Message-ID: <87bjue2tbh.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 06 2025, Bernd Schubert wrote:

> On 3/6/25 12:12, Luis Henriques wrote:
>> When mounting a user-space filesystem using io_uring, the initialization
>> of the rings is done separately in the server side.  If for some reason
>> (e.g. a server bug) this step is not performed it will be impossible to
>> unmount the filesystem if there are already requests waiting.
>>=20
>> This issue is easily reproduced with the libfuse passthrough_ll example,
>> if the queue depth is set to '0' and a request is queued before trying to
>> unmount the filesystem.  When trying to force the unmount, fuse_abort_co=
nn()
>> will try to wake up all tasks waiting in fc->blocked_waitq, but because =
the
>> rings were never initialized, fuse_uring_ready() will never return 'true=
'.
>>=20
>> Fixes: 3393ff964e0f ("fuse: block request allocation until io-uring init=
 is complete")
>> Signed-off-by: Luis Henriques <luis@igalia.com>
>> ---
>>  fs/fuse/dev.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>> index 7edceecedfa5..2fe565e9b403 100644
>> --- a/fs/fuse/dev.c
>> +++ b/fs/fuse/dev.c
>> @@ -77,7 +77,7 @@ void fuse_set_initialized(struct fuse_conn *fc)
>>  static bool fuse_block_alloc(struct fuse_conn *fc, bool for_background)
>>  {
>>  	return !fc->initialized || (for_background && fc->blocked) ||
>> -	       (fc->io_uring && !fuse_uring_ready(fc));
>> +	       (fc->io_uring && fc->connected && !fuse_uring_ready(fc));
>>  }
>>=20=20
>>  static void fuse_drop_waiting(struct fuse_conn *fc)
>>=20
>
> Oh yes, I had missed that.
>
> Reviewed-by: Bernd Schubert <bschubert@ddn.com>

Thanks!  And... by the way, Bernd:

I know io_uring support in libfuse isn't ready yet, but I think there's
some error handling missing in your uring branch.  In particular, the
return of fuse_uring_start() is never checked, and thus if the rings
initialization fails, the server will not get any error.

I found that out because I blindly tried the patch below, and I was
surprised that the server was started just fine.

Cheers,
--=20
Lu=C3=ADs

diff --git a/lib/fuse_uring.c b/lib/fuse_uring.c
index 312aa5dbc735..2258cf0d4259 100644
--- a/lib/fuse_uring.c
+++ b/lib/fuse_uring.c
@@ -498,6 +498,11 @@ static struct fuse_ring_pool *fuse_create_ring(struct =
fuse_session *se)
 		fuse_log(FUSE_LOG_DEBUG, "starting io-uring q-depth=3D%d\n",
 			 se->uring.q_depth);
=20
+	if (!se->uring.q_depth) {
+		fuse_log(FUSE_LOG_ERR, "Invalid ring queue depth value\n");
+		goto err;
+	}
+
 	fuse_ring =3D calloc(1, sizeof(*fuse_ring));
 	if (fuse_ring =3D=3D NULL) {
 		fuse_log(FUSE_LOG_ERR, "Allocating the ring failed\n");

