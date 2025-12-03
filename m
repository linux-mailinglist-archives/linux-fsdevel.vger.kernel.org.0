Return-Path: <linux-fsdevel+bounces-70591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFAECA172C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 20:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB8DD30139BD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 19:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553E129E109;
	Wed,  3 Dec 2025 19:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=infradead.org header.i=@infradead.org header.b="h5YH1vSU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99682641CA;
	Wed,  3 Dec 2025 19:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764791058; cv=none; b=F7hligciqngPFx9usbmYXCJLZnc2EUDao2X+ABa9xnghEtBRNwjovaTzKDhR41kl7/F0K/el674V8gMqJw46McXcPo+dR4oC5wtAya3owoY3HPwGPpEc0TprOQpWzRGVl1LKzOjnL28n1NlM8+IypIG/dw1b7WC796cOg5ER4gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764791058; c=relaxed/simple;
	bh=+GteTJITDJWUPgxSb5K+cQRISKDwdQ2z7K0PjUokVNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZAWod02aNPZMwtxP4RAG9rw/u32BrvGGTGbPGP0rDURH6cy/HXbiAnRBdZvK1ycSTcaskkXAa7yxLAVZBQy3X7hAWdVwoHJweBdYLwyxKCqCBsrty/gk/Sj9mMmG7Hd/0nhFE0rh+X/5jv1IaDNFG6CbU1Ql5QNxw/IfKGWq6Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=evilplan.org; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=fail (0-bit key) header.d=infradead.org header.i=@infradead.org header.b=h5YH1vSU reason="key not found in DNS"; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=evilplan.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=66RqrQBWZlK0e+Y9teUD6nm1X7l+MEUOdypfNKGmHo8=; b=h5YH1vSU2vK7HFcW72fd0Nj0b3
	tUDNsQjmAhPRqj+CsmtRTkjRPA/U1lCf4S4y+veK4YEbTLPchnNFpFw3QvmlKtguKmzDnvq/qx1Op
	jm8SrNi1jM7ie0r7wp8cqVoYMwjQi5BWS3lK0a3nyIzAfc7z9quS6ErK2yxM/g14oAdfP4EAxP9YW
	wqXjJlzThUj//30/8uKH3h0eJCJ68SpZyuIbseeQEPSyfimlw3jXjWIp8yyI+vA3ztx4HXJCipGRB
	SDUjxbeFCZH0ZI25JNdh3zNI8vAGSq51y13tV66xwJfuFJb0zeKb1ymnCKSrjhjJNSwLoKF6taEvN
	1yrGdqmQ==;
Received: from jlbec by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vQslz-0000000Ds9R-10IH;
	Wed, 03 Dec 2025 19:44:23 +0000
Date: Wed, 3 Dec 2025 11:44:02 -0800
From: Joel Becker <jlbec@evilplan.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, hch@infradead.org,
	linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
	gustavold@gmail.com, asantostc@gmail.com, calvin@wbinvd.org,
	kernel-team@meta.com
Subject: Re: [PATCH RFC 1/2] configfs: add kernel-space item registration API
Message-ID: <aTCTAqEh0qppzVPn@google.com>
Mail-Followup-To: Breno Leitao <leitao@debian.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, hch@infradead.org,
	linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
	gustavold@gmail.com, asantostc@gmail.com, calvin@wbinvd.org,
	kernel-team@meta.com
References: <20251202-configfs_netcon-v1-0-b4738ead8ee8@debian.org>
 <20251202-configfs_netcon-v1-1-b4738ead8ee8@debian.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202-configfs_netcon-v1-1-b4738ead8ee8@debian.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever
 come to perfection.
Sender: Joel Becker <jlbec@ftp.linux.org.uk>

On Tue, Dec 02, 2025 at 07:29:01AM -0800, Breno Leitao wrote:
> Add configfs_register_item() and configfs_unregister_item() functions
> to allow kernel modules to register configfs items whose lifecycle is
> controlled by kernel space rather than userspace.
> 
> This is useful for subsystems that need to expose configuration items
> that are created based on kernel events (like boot parameters) rather
> than explicit userspace mkdir operations. The items registered this
> way are marked as default items (CONFIGFS_USET_DEFAULT) and cannot be
> removed via rmdir.
> 
> The API follows the same pattern as configfs_register_group() but for
> individual items:
> - configfs_register_item() links the item into the parent group's
>   hierarchy and creates the filesystem representation
> - configfs_unregister_item() reverses the registration, removing the
>   item from configfs
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  fs/configfs/dir.c        | 134 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/configfs.h |   4 +++
>  2 files changed, 138 insertions(+)
> 
> diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
> index 81f4f06bc87e..f7224bc51826 100644
> --- a/fs/configfs/dir.c
> +++ b/fs/configfs/dir.c
> @@ -1866,6 +1866,140 @@ void configfs_unregister_default_group(struct config_group *group)
>  }
>  EXPORT_SYMBOL(configfs_unregister_default_group);
>  
> +/**
> + * configfs_register_item() - registers a kernel-created item with a parent group
> + * @parent_group: parent group for the new item
> + * @item: item to be registered
> + *
> + * This function allows kernel code to register configfs items whose lifecycle
> + * is controlled by kernel space rather than userspace (via mkdir/rmdir).
> + * The item must be already initialized with config_item_init_type_name().
> + *
> + * Return: 0 on success, negative errno on failure
> + */
> +int configfs_register_item(struct config_group *parent_group,
> +			   struct config_item *item)
> +{
> +	struct configfs_subsystem *subsys = parent_group->cg_subsys;
> +	struct configfs_fragment *frag;
> +	struct dentry *parent, *child;
> +	struct configfs_dirent *sd;
> +	int ret;
> +
> +	if (!subsys || !item->ci_name)
> +		return -EINVAL;
> +
> +	frag = new_fragment();
> +	if (!frag)
> +		return -ENOMEM;
> +
> +	parent = parent_group->cg_item.ci_dentry;
> +	/* Allocate dentry for the item */
> +	child = d_alloc_name(parent, item->ci_name);
> +	if (!child) {
> +		put_fragment(frag);
> +		return -ENOMEM;
> +	}
> +
> +	mutex_lock(&subsys->su_mutex);
> +	link_obj(&parent_group->cg_item, item);
> +	mutex_unlock(&subsys->su_mutex);
> +
> +	inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
> +	d_add(child, NULL);
> +
> +	/* Attach the item to the filesystem */
> +	ret = configfs_attach_item(&parent_group->cg_item, item, child, frag);
> +	if (ret)
> +		goto err_out;

The behavior here is significantly different than the flow in
configfs_mkdir().  How do we a) ensure we're getting the right outcome
b) make sure that commensurate changes in one are propagated to the
other?

For example, we take pains to get module pinning right in
configfs_mkdir(), both for the parent_item and the child item.  I see no
pinning here.  I see no handling of races with unregister (like the
teardown races with rmdir).

Some of these things are just different with kernel-registered items.  I
presume you are declaring the child item must be fully created, which is
why this code doesn't call ->make_item().  But there is no documentation
of that requirement.

Thanks,
Joel

-- 

"Baby, even the losers
 Get luck sometimes.
 Even the losers
 Keep a little bit of pride."

			http://www.jlbec.org/
			jlbec@evilplan.org

