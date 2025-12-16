Return-Path: <linux-fsdevel+bounces-71459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEB4CC1F79
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 11:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC26130248B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 10:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADD52D7388;
	Tue, 16 Dec 2025 10:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="dIkVJd2y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143AE2BDC00;
	Tue, 16 Dec 2025 10:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765881042; cv=none; b=hMEFTaRhTMsvwfBg9K/YsT70GOtg2bZ51euRCqDv9RdPFW6SIDZ2mYrNYmnWan78emtoYi5SoHt8FQSKmRFIJG0GIeuPfXJl+ScxB+kQ3N6JRnQx4l93sXf/dy4oL6O9Syn7h92Q4rPF1KDzZm99z2bfffmxissjTCWZsvhcEnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765881042; c=relaxed/simple;
	bh=xiqKtYcl14zEzcOS52kVYQUTIhwCZ2yOY1FkGKsV8qw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xa5BxZFNTFbMWk3nSHt7NFDXJHh/SXzBdK5J6ZUwIk0khKuEO2mI3iEMWqTZBDJQ9ZgASSsHngS9NbjBpp0OBDZ4gfVJq3KeWjBigGiEm53vBSeO9AWeNJtLCgrvAZ7dfVSnIjhtr+JcfuaC5cWygKhGb+JzaO8FGJKJ/UoVZOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=dIkVJd2y; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=TIWo+wAIx6AZ+1dw5o7fs7F2gJZqMNp8ncz3IjSoC3s=; b=dIkVJd2yE1l4DYA1JoFZEhsdg3
	JCvJiA+OLhlhPHomwJeCdxUhKT+lCyQS8Wv0e3/J5GUVlgz9CIx8lw1p7GpgjJcEafEEZNeeFOc+D
	9RzBFoU6PdwJClbxf9OQpg+T0lOTd1CmUqjhidXLu8jsUd39as660T+AhtjBUqTpvgLFLjKGGmD/H
	vCWs+u/eHdcZ5kSz9FC/oPSAYjgFD91R/g3CggWmKCCuFiZVBVpcraDgGqMbOIAzC44NriyoQ0xco
	yrid85w6fqItR5AIeCI+1Kl9kWk/nZ2h1O2FtDwlGLYRNlN0Lia9iFRWMyIYksfaeR9dlymak89QH
	Vc+HB5og==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vVSK3-00DLau-Rm; Tue, 16 Dec 2025 11:30:27 +0100
From: Luis Henriques <luis@igalia.com>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  Amir Goldstein
 <amir73il@gmail.com>,  "Darrick J. Wong" <djwong@kernel.org>,  Kevin Chen
 <kchen@ddn.com>,  Horst Birthelmer <hbirthelmer@ddn.com>,
  "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,  Matt
 Harvey <mharvey@jumptrading.com>,  "kernel-dev@igalia.com"
 <kernel-dev@igalia.com>
Subject: Re: [RFC PATCH v2 2/6] fuse: move fuse_entry_out structs out of the
 stack
In-Reply-To: <834d6546-a87b-44b9-8f1e-53346a9bb7e6@ddn.com> (Bernd Schubert's
	message of "Mon, 15 Dec 2025 14:03:35 +0000")
References: <20251212181254.59365-1-luis@igalia.com>
	<20251212181254.59365-3-luis@igalia.com>
	<834d6546-a87b-44b9-8f1e-53346a9bb7e6@ddn.com>
Date: Tue, 16 Dec 2025 10:30:21 +0000
Message-ID: <871pkuen2a.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15 2025, Bernd Schubert wrote:

> On 12/12/25 19:12, Luis Henriques wrote:
>> This patch simply turns all struct fuse_entry_out instances that are
>> allocated in the stack into dynamically allocated structs.  This is a
>> preparation patch for further changes, including the extra helper functi=
on
>> used to actually allocate the memory.
>>=20
>> Also, remove all the memset()s that are used to zero-out these structure=
s,
>> as kzalloc() is being used.
>>=20
>> Signed-off-by: Luis Henriques <luis@igalia.com>
>> ---
>>   fs/fuse/dir.c    | 139 ++++++++++++++++++++++++++++++-----------------
>>   fs/fuse/fuse_i.h |   9 +++
>>   fs/fuse/inode.c  |  20 +++++--
>>   3 files changed, 114 insertions(+), 54 deletions(-)
>>=20
>> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
>> index 4dfe964a491c..e3fd5d148741 100644
>> --- a/fs/fuse/dir.c
>> +++ b/fs/fuse/dir.c
>> @@ -172,7 +172,6 @@ static void fuse_lookup_init(struct fuse_conn *fc, s=
truct fuse_args *args,
>>   			     u64 nodeid, const struct qstr *name,
>>   			     struct fuse_entry_out *outarg)
>>   {
>> -	memset(outarg, 0, sizeof(struct fuse_entry_out));
>>   	args->opcode =3D FUSE_LOOKUP;
>>   	args->nodeid =3D nodeid;
>>   	args->in_numargs =3D 3;
>> @@ -213,7 +212,7 @@ static int fuse_dentry_revalidate(struct inode *dir,=
 const struct qstr *name,
>>   		goto invalid;
>>   	else if (time_before64(fuse_dentry_time(entry), get_jiffies_64()) ||
>>   		 (flags & (LOOKUP_EXCL | LOOKUP_REVAL | LOOKUP_RENAME_TARGET))) {
>> -		struct fuse_entry_out outarg;
>> +		struct fuse_entry_out *outarg;
>
>
> How about using __free(kfree) for outarg? I think it would simplify
> error handling a bit?
> (Still reviewing other parts.)

Ah, good suggestion.  I'll try to include the usage of that that clean-up
construct in the code.

Cheers,
--=20
Lu=C3=ADs

