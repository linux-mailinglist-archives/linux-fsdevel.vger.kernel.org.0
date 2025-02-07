Return-Path: <linux-fsdevel+bounces-41223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5148CA2C740
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 16:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B52DF3A3970
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 15:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959BE238D50;
	Fri,  7 Feb 2025 15:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="a6oVpXPr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB235238D30;
	Fri,  7 Feb 2025 15:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738942310; cv=none; b=B6ke8GOrNyF+ggPCZp0mnuS4uteitzrXzQhe3fvi87HZaPelhiQhSolMRXSKT/lyaMCW2RjkzhYMn0sn8ALI4vKZTbyJfWERzJdGaOM94E++XCvSSZIPmpSmxniedhCrGzke1alkI8g7oq9m5kWGmwaXvGUUfdll4Qt34vCorw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738942310; c=relaxed/simple;
	bh=ymXvOQPwdm5toj3iobwpCZe0PgIJsArx2RWLz1/0jNU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YbgHB7V56/YIf+jNZAc1WGEcGMTDUHDXd6h3eWHnemRZQEQuUEnnjYRlK5QUJ+SRT8x+GbbRKI8czFJzoJTakoQAh9bm2A+80rKr2Tc4U7uyUhvupV1jMnIJyfneVQ7W55FiVD1/tvu9RMcfzh05yiJ0LkCPnA9p7HpMRdluQpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=a6oVpXPr; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=vI3tIMBcaHOOYPCe7qgECQUuYfisDEy/4We+vIauTvw=; b=a6oVpXPrGOMCJ9UpjU7C200xwB
	E5kBdQZIVrU3AMcGpmkcj43ggqvFiUN4SxAeI3frskLKQfQB4y324g0xDaQ3Ik1oEJOdS4j5J29c0
	VKereIrph3NjoWoeT9NrLiWA+H1giISKWSfN4gJOWeTC+CWLHRXqOOrpR/lvf5q/jXRAsB43dfWjR
	+sjpcfYKhCyPU4g+1lwK8aHCMB37NWq0fddfbs4HwasRWKFnfFkympQTcNlciSE/gy9+0Kmzy76rN
	gtx5yAwjavQs5Hr5Av6YmVTCy/By7JilXD9+/aJh5LvEMQM4cIQqNxRpj/Qxa4mLflZZM27dMM2n8
	rWZS278w==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tgQKN-005u9y-PH; Fri, 07 Feb 2025 16:31:41 +0100
From: Luis Henriques <luis@igalia.com>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Matt Harvey <mharvey@jumptrading.com>,
  Dave Chinner <david@fromorbit.com>
Subject: Re: [RFC PATCH] fuse: add new function to invalidate cache for all
 inodes
In-Reply-To: <d3ee362c-accf-4ad9-99a6-5834b1c0b438@bsbernd.com> (Bernd
	Schubert's message of "Fri, 7 Feb 2025 15:29:13 +0100")
References: <20250115163253.8402-1-luis@igalia.com>
	<d3ee362c-accf-4ad9-99a6-5834b1c0b438@bsbernd.com>
Date: Fri, 07 Feb 2025 15:31:34 +0000
Message-ID: <878qqhpy95.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Bernd,

On Fri, Feb 07 2025, Bernd Schubert wrote:

> On 1/15/25 17:32, Luis Henriques wrote:
>> Currently userspace is able to notify the kernel to invalidate the cache
>> for an inode.  This means that, if all the inodes in a filesystem need to
>> be invalidated, then userspace needs to iterate through all of them and =
do
>> this kernel notification separately.
>>=20
>> This patch adds a new option that allows userspace to invalidate all the
>> inodes with a single notification operation.  In addition to invalidate =
all
>> the inodes, it also shrinks the superblock dcache.
>>=20
>> Signed-off-by: Luis Henriques <luis@igalia.com>
>> ---
>> Just an additional note that this patch could eventually be simplified if
>> Dave Chinner patch to iterate through the superblock inodes[1] is merged.
>>=20
>> [1] https://lore.kernel.org/r/20241002014017.3801899-3-david@fromorbit.c=
om
>>=20
>>  fs/fuse/inode.c           | 53 +++++++++++++++++++++++++++++++++++++++
>>  include/uapi/linux/fuse.h |  3 +++
>>  2 files changed, 56 insertions(+)
>>=20
>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
>> index 3ce4f4e81d09..1fd9a5f303da 100644
>> --- a/fs/fuse/inode.c
>> +++ b/fs/fuse/inode.c
>> @@ -546,6 +546,56 @@ struct inode *fuse_ilookup(struct fuse_conn *fc, u6=
4 nodeid,
>>  	return NULL;
>>  }
>>=20=20
>> +static int fuse_reverse_inval_all(struct fuse_conn *fc)
>> +{
>> +	struct fuse_mount *fm;
>> +	struct super_block *sb;
>> +	struct inode *inode, *old_inode =3D NULL;
>> +	struct fuse_inode *fi;
>> +
>> +	inode =3D fuse_ilookup(fc, FUSE_ROOT_ID, NULL);
>> +	if (!inode)
>> +		return -ENOENT;
>> +
>> +	fm =3D get_fuse_mount(inode);
>> +	iput(inode);
>> +	if (!fm)
>> +		return -ENOENT;
>> +	sb =3D fm->sb;
>> +
>> +	spin_lock(&sb->s_inode_list_lock);
>> +	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
>> +		spin_lock(&inode->i_lock);
>> +		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) ||
>> +		    !atomic_read(&inode->i_count)) {
>> +			spin_unlock(&inode->i_lock);
>> +			continue;
>> +		}
>> +
>> +		__iget(inode);
>> +		spin_unlock(&inode->i_lock);
>> +		spin_unlock(&sb->s_inode_list_lock);
>> +		iput(old_inode);
>> +
>> +		fi =3D get_fuse_inode(inode);
>> +		spin_lock(&fi->lock);
>> +		fi->attr_version =3D atomic64_inc_return(&fm->fc->attr_version);
>> +		spin_unlock(&fi->lock);
>> +		fuse_invalidate_attr(inode);
>> +		forget_all_cached_acls(inode);
>> +
>> +		old_inode =3D inode;
>> +		cond_resched();
>> +		spin_lock(&sb->s_inode_list_lock);
>> +	}
>> +	spin_unlock(&sb->s_inode_list_lock);
>> +	iput(old_inode);
>> +
>> +	shrink_dcache_sb(sb);
>> +
>> +	return 0;
>> +}
>
> Just a suggestion, assuming Daves patch gets merged, maybe you coud move
> the actual action into into a sub function? Makes it better visible
> what is actually does and would then make it easier to move the iteration
> part to the generic approach?

Good point, I can created a helper function for that.  It may eventually
be reused if Dave's patchset moves forward.  Thanks for the suggestion.

Cheers,
--=20
Lu=C3=ADs

> Alternatively, maybe updates Daves patch and add fuse on top of it? Dave?
>
>
> Thanks,
> Bernd
>
>


