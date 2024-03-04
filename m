Return-Path: <linux-fsdevel+bounces-13435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED7486FC7F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 09:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 612B3B229E8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 08:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73516224C2;
	Mon,  4 Mar 2024 08:53:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333A61AADE;
	Mon,  4 Mar 2024 08:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709542393; cv=none; b=AfrH2ZbxTkSxHWrrZ4sWTrGYqwVlz9yg9nlGi7dwZDjA7YAOSbHqELS9Kgx2Vpuo5PnKjv2gQpWxStn0aLgXSMb1hmKWE2pfBFDqu4l/vAbT2KqNbLTtqzXM5VY5hqw3awaJ+3pDUrB5RTZHWPnG2dZ5rFzCv4eTN/OLgAdq+5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709542393; c=relaxed/simple;
	bh=lZjS9KQIklaHVo9RkVEZuFyeCOlTaULg5xVUzMo42g8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EQ1NQ3wO6Gwth6QvYrgyn6XOCr+4BwbQBPJtbuN1CjvWRvwCUT9N6w7CjByimBsxwjFWgBKmwM+/sLd45+vjfM0wpsky6fwnLLF/y7gmc4x0XLWMXqz7KQc8/awWvKnIeqFXntz8MAieOClHkg8+P5TOA/bjKEhjOyx3IEdxNDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4TpBQV4KnCz9xGgj;
	Mon,  4 Mar 2024 16:17:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id ABC0A14068C;
	Mon,  4 Mar 2024 16:33:26 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwAH9CdGh+VluhunAw--.56753S2;
	Mon, 04 Mar 2024 09:33:26 +0100 (CET)
Message-ID: <be91c7158b1b9bed35aa9c3205e8f8e467778a5f.camel@huaweicloud.com>
Subject: Re: [PATCH v2 06/25] capability: provide helpers for converting
 between xattrs and vfs_caps
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Serge Hallyn <serge@hallyn.com>,
  Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>, James
 Morris <jmorris@namei.org>,  Alexander Viro <viro@zeniv.linux.org.uk>, Jan
 Kara <jack@suse.cz>, Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>,  Casey Schaufler
 <casey@schaufler-ca.com>, Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
 <roberto.sassu@huawei.com>,  Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Jonathan Corbet <corbet@lwn.net>, Miklos Szeredi
 <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, audit@vger.kernel.org, 
 selinux@vger.kernel.org, linux-integrity@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-unionfs@vger.kernel.org
Date: Mon, 04 Mar 2024 09:33:06 +0100
In-Reply-To: <ZeIlwkUx5lNBrdS9@do-x1extreme>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
	 <20240221-idmap-fscap-refactor-v2-6-3039364623bd@kernel.org>
	 <7633ab5d5359116a602cdc8f85afd2561047960e.camel@huaweicloud.com>
	 <ZeIlwkUx5lNBrdS9@do-x1extreme>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwAH9CdGh+VluhunAw--.56753S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJF1Uur1fKFWxWryDZw1UKFg_yoW8WFyDpF
	y3K3Z8KFs2qr1Ygr48Jr45Aa1SkFyrJry7WayUCas0y3Wqgr13AFy09a48uFy5uw4kGr15
	XFs0yas8Cry3AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFYFCUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAMBF1jj5rvqQACsm

On Fri, 2024-03-01 at 13:00 -0600, Seth Forshee (DigitalOcean) wrote:
> On Fri, Mar 01, 2024 at 05:30:55PM +0100, Roberto Sassu wrote:
> > > +/*
> > > + * Inner implementation of vfs_caps_to_xattr() which does not return=
 an
> > > + * error if the rootid does not map into @dest_userns.
> > > + */
> > > +static ssize_t __vfs_caps_to_xattr(struct mnt_idmap *idmap,
> > > +				   struct user_namespace *dest_userns,
> > > +				   const struct vfs_caps *vfs_caps,
> > > +				   void *data, size_t size)
> > > +{
> > > +	struct vfs_ns_cap_data *ns_caps =3D data;
> > > +	struct vfs_cap_data *caps =3D (struct vfs_cap_data *)ns_caps;
> > > +	kuid_t rootkuid;
> > > +	uid_t rootid;
> > > +
> > > +	memset(ns_caps, 0, size);
> >=20
> > size -> sizeof(*ns_caps) (or an equivalent change)
>=20
> This is zeroing out the passed buffer, so it should use the size passed
> for the buffer. sizeof(*ns_caps) could potentially be more than the size
> of the buffer.

Uhm, then maybe the problem is that you are passing the wrong argument?

ssize_t
do_getxattr(struct mnt_idmap *idmap, struct dentry *d,
	struct xattr_ctx *ctx)
{
	ssize_t error;
	char *kname =3D ctx->kname->name;

	if (is_fscaps_xattr(kname)) {
		struct vfs_caps caps;
		struct vfs_ns_cap_data data;
		int ret;

		ret =3D vfs_get_fscaps(idmap, d, &caps);
		if (ret)
			return ret;
		/*
		 * rootid is already in the mount idmap, so pass nop_mnt_idmap
		 * so that it won't be mapped.
		 */
		ret =3D vfs_caps_to_user_xattr(&nop_mnt_idmap, current_user_ns(),
					     &caps, &data, ctx->size);


ctx->size in my case is 1024 bytes.

Roberto

> Maybe it would be clearer if it was memset(data, 0, size)?
>=20
> > I was zeroing more (the size of the buffer passed to vfs_getxattr()).
> >=20
> > Roberto


