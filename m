Return-Path: <linux-fsdevel+bounces-70824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60529CA868E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 17:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BD7ED301C7AA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 16:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63D52BD5A1;
	Fri,  5 Dec 2025 16:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="J8Q0vB6w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC10A1397;
	Fri,  5 Dec 2025 16:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764952801; cv=none; b=c2MRhow9nAjGLqDkXHdj0YUUY2zjgIPFbpqMIR+cZivm+jvH3BZja1mDKi/dw7TvchtLc7oISTY28HzC6avf7ZbGM6saZ69jZzUiruODcq0kXngvL5RNYFBOJwtrr74DC9i6m/TNcnzut19oxbn87z1xakO8BdXOdxRi27LrLvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764952801; c=relaxed/simple;
	bh=6w28E7ainKujFwd66eIL3EljHzx3KE/Li7q3fyuQugk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIZGVbIE5zso/cr6quc8h+t//Cu86iq/DqZ3ykXf0SJWNrGhjEFRF0Vmli5uBLnvTE9tREsW3Txd6yCakCKghsIZuRokggkTiLbtQ4ndeExv1+t2F+3u6xrGhUvfRLTH/6SJ/39yYVL3uW5OoYi+2JtT0eq5CDHnst52IaNktUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=J8Q0vB6w; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:To:From:Date:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vSjA3LsvzRnVJv7HESY2bgCSLnmFxximUy5O0wMCEh4=; b=J8Q0vB6wcQq80bpncvaXQpD2qh
	cFCP6J49RaBg56lLPcsfDdkrkbOYDbOD8kwMiiNvmH69S169YhbUAN2rGx/BVwxoaN+s9iAn+59Zx
	wWs9NbJ4MeLD/UHpIQweStkpOlZ4jQNVBSfXIGlPFESH9De3P7g4zCWj+WS4EMKeVuZxSdEpVtBIf
	NT1nGtqIgWmnLCeSDTi+wkJkE3k11g7uPnYg9SLGZuGRoF+fvEKwAH3Qs4zwb57Bnyw7uI7SRj+Ft
	dt10dosI5z15Uo/J3ZaHTSO4i2YxkheoCyghosjEy84ORnwv7ZYr8CLKa64VG/0QmHgnnkDt9xowc
	UoKVF9Ag==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vRYqA-00412q-LQ; Fri, 05 Dec 2025 16:39:31 +0000
Date: Fri, 5 Dec 2025 08:39:25 -0800
From: Breno Leitao <leitao@debian.org>
To: Andreas Hindborg <a.hindborg@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, hch@infradead.org, 
	linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org, gustavold@gmail.com, asantostc@gmail.com, 
	calvin@wbinvd.org, kernel-team@meta.com
Subject: Re: [PATCH RFC 1/2] configfs: add kernel-space item registration API
Message-ID: <ecmqj4utxhgaq5pp2mwb7g6kx6lmc4wx2dtsiusrsij5fihkw5@ptp55nqquget>
References: <20251202-configfs_netcon-v1-0-b4738ead8ee8@debian.org>
 <20251202-configfs_netcon-v1-1-b4738ead8ee8@debian.org>
 <aTCTAqEh0qppzVPn@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTCTAqEh0qppzVPn@google.com>
X-Debian-User: leitao

Hello Joel,

First of all, thanks for thre review,

On Wed, Dec 03, 2025 at 11:44:02AM -0800, Joel Becker wrote:
> On Tue, Dec 02, 2025 at 07:29:01AM -0800, Breno Leitao wrote:
> > Add configfs_register_item() and configfs_unregister_item() functions
> > to allow kernel modules to register configfs items whose lifecycle is
> > controlled by kernel space rather than userspace.
> > 
> > This is useful for subsystems that need to expose configuration items
> > that are created based on kernel events (like boot parameters) rather
> > than explicit userspace mkdir operations. The items registered this
> > way are marked as default items (CONFIGFS_USET_DEFAULT) and cannot be
> > removed via rmdir.
> > 
> > The API follows the same pattern as configfs_register_group() but for
> > individual items:
> > - configfs_register_item() links the item into the parent group's
> >   hierarchy and creates the filesystem representation
> > - configfs_unregister_item() reverses the registration, removing the
> >   item from configfs
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  fs/configfs/dir.c        | 134 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/configfs.h |   4 +++
> >  2 files changed, 138 insertions(+)
> > 
> > diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
> > index 81f4f06bc87e..f7224bc51826 100644
> > --- a/fs/configfs/dir.c
> > +++ b/fs/configfs/dir.c
> > @@ -1866,6 +1866,140 @@ void configfs_unregister_default_group(struct config_group *group)
> >  }
> >  EXPORT_SYMBOL(configfs_unregister_default_group);
> >  
> > +/**
> > + * configfs_register_item() - registers a kernel-created item with a parent group
> > + * @parent_group: parent group for the new item
> > + * @item: item to be registered
> > + *
> > + * This function allows kernel code to register configfs items whose lifecycle
> > + * is controlled by kernel space rather than userspace (via mkdir/rmdir).
> > + * The item must be already initialized with config_item_init_type_name().
> > + *
> > + * Return: 0 on success, negative errno on failure
> > + */
> > +int configfs_register_item(struct config_group *parent_group,
> > +			   struct config_item *item)
> > +{
> > +	struct configfs_subsystem *subsys = parent_group->cg_subsys;
> > +	struct configfs_fragment *frag;
> > +	struct dentry *parent, *child;
> > +	struct configfs_dirent *sd;
> > +	int ret;
> > +
> > +	if (!subsys || !item->ci_name)
> > +		return -EINVAL;
> > +
> > +	frag = new_fragment();
> > +	if (!frag)
> > +		return -ENOMEM;
> > +
> > +	parent = parent_group->cg_item.ci_dentry;
> > +	/* Allocate dentry for the item */
> > +	child = d_alloc_name(parent, item->ci_name);
> > +	if (!child) {
> > +		put_fragment(frag);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	mutex_lock(&subsys->su_mutex);
> > +	link_obj(&parent_group->cg_item, item);
> > +	mutex_unlock(&subsys->su_mutex);
> > +
> > +	inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
> > +	d_add(child, NULL);
> > +
> > +	/* Attach the item to the filesystem */
> > +	ret = configfs_attach_item(&parent_group->cg_item, item, child, frag);
> > +	if (ret)
> > +		goto err_out;
> 
> The behavior here is significantly different than the flow in
> configfs_mkdir().  How do we a) ensure we're getting the right outcome
> b) make sure that commensurate changes in one are propagated to the
> other?
> 
> For example, we take pains to get module pinning right in
> configfs_mkdir(), both for the parent_item and the child item.  I see no
> pinning here.

You're absolutely right about the missing module pinning and race
protection. 

On my example (netconsole), the items were added during module
initialization and removed during device tear down, which is not an
excuse, given the interface should be generic enough.

I suppose I want to try_module_get(subsys_owner) and
try_module_get(type->ct_owner) at the beginning of
configfs_register_item(), and then put them back in
configfs_unregister_item(). Would it be enough?


  int configfs_register_item(struct config_group *parent_group,
                             struct config_item *item)
	...
         /*
           * Pin the subsystem module first. The subsystem may belong to a
           * different module than the item being registered. We need to pin
           * both to prevent the subsystem from being unloaded while the item
           * exists.
           */
          if (!subsys->su_group.cg_item.ci_type) {
                  ret = -EINVAL;
                  goto out;
          }
          subsys_owner = subsys->su_group.cg_item.ci_type->ct_owner;
          if (!try_module_get(subsys_owner)) {
                  ret = -EINVAL;
                  goto out;
          }

          /*
           * Pin the item's module. This prevents the module providing the
           * item's type (and its operations) from being unloaded.
           */
          item_owner = type->ct_owner;
          if (!try_module_get(item_owner)) {
                  ret = -EINVAL;
                  goto out_subsys_put;
          }

> I see no handling of races with unregister (like the
> teardown races with rmdir).
> Some of these things are just different with kernel-registered items.

Would CONFIGFS_USET_IN_MKDIR be enought in this case?

> I presume you are declaring the child item must be fully created, which is
> why this code doesn't call ->make_item().  But there is no documentation
> of that requirement.

Right, do you think a kdoc would be enough in this case?

This is the new functions I am coming up with, in case you want to read the full functions.

Thanks for the review!!

-- 

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 81f4f06bc87e..73aa4e4a0966 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -1866,6 +1866,248 @@ void configfs_unregister_default_group(struct config_group *group)
 }
 EXPORT_SYMBOL(configfs_unregister_default_group);
 
+/**
+ * configfs_register_item() - registers a kernel-created item with a parent group
+ * @parent_group: parent group for the new item
+ * @item: item to be registered
+ *
+ * This function allows kernel code to register configfs items whose lifecycle
+ * is controlled by kernel space rather than userspace (via mkdir/rmdir).
+ *
+ * Unlike configfs_mkdir(), which creates the item via ->make_item() callback,
+ * this function expects the item to be FULLY INITIALIZED by the caller before
+ * registration. This means:
+ *  - The item must be initialized with config_item_init_type_name()
+ *  - The item->ci_type must be set and valid
+ *  - The item->ci_type->ct_owner (module) must be valid
+ *  - Any item-specific initialization must be complete
+ *
+ * This function follows the same module pinning and locking semantics as
+ * configfs_mkdir() to ensure proper synchronization with rmdir and module
+ * unloading.
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+int configfs_register_item(struct config_group *parent_group,
+			   struct config_item *item)
+{
+	struct configfs_subsystem *subsys = parent_group->cg_subsys;
+	struct module *subsys_owner = NULL, *item_owner = NULL;
+	const struct config_item_type *type;
+	struct configfs_fragment *frag;
+	struct dentry *parent, *child;
+	struct configfs_dirent *sd;
+	int ret;
+
+	if (!subsys || !item->ci_name)
+		return -EINVAL;
+
+	/*
+	 * Validate that the item is fully initialized. Unlike configfs_mkdir(),
+	 * we don't call ->make_item(), so the caller must provide a complete
+	 * item with a valid type.
+	 */
+	type = item->ci_type;
+	if (!type) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * Pin the subsystem module first. The subsystem may belong to a
+	 * different module than the item being registered. We need to pin
+	 * both to prevent the subsystem from being unloaded while the item
+	 * exists.
+	 */
+	if (!subsys->su_group.cg_item.ci_type) {
+		ret = -EINVAL;
+		goto out;
+	}
+	subsys_owner = subsys->su_group.cg_item.ci_type->ct_owner;
+	if (!try_module_get(subsys_owner)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * Pin the item's module. This prevents the module providing the
+	 * item's type (and its operations) from being unloaded.
+	 */
+	item_owner = type->ct_owner;
+	if (!try_module_get(item_owner)) {
+		ret = -EINVAL;
+		goto out_subsys_put;
+	}
+
+	frag = new_fragment();
+	if (!frag) {
+		ret = -ENOMEM;
+		goto out_item_put;
+	}
+
+	parent = parent_group->cg_item.ci_dentry;
+	/* Allocate dentry for the item */
+	child = d_alloc_name(parent, item->ci_name);
+	if (!child) {
+		ret = -ENOMEM;
+		put_fragment(frag);
+		goto out_item_put;
+	}
+
+	/*
+	 * Link the item into the parent group's hierarchy under the subsystem
+	 * mutex. This must be done before attaching to the filesystem.
+	 */
+	mutex_lock(&subsys->su_mutex);
+	link_obj(&parent_group->cg_item, item);
+	mutex_unlock(&subsys->su_mutex);
+
+	/*
+	 * From here on, errors must unlink the item since link_obj() has
+	 * been called.
+	 */
+	inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
+
+	/*
+	 * Protect against racing with configfs_unregister_item() or rmdir.
+	 * The CONFIGFS_USET_IN_MKDIR flag will cause configfs_detach_prep()
+	 * to fail, preventing concurrent teardown.
+	 */
+	sd = parent->d_fsdata;
+	spin_lock(&configfs_dirent_lock);
+	sd->s_type |= CONFIGFS_USET_IN_MKDIR;
+	spin_unlock(&configfs_dirent_lock);
+
+	d_add(child, NULL);
+
+	/* Attach the item to the filesystem */
+	ret = configfs_attach_item(&parent_group->cg_item, item, child, frag);
+	/* if ret > 0, it will end up in err_unlink after unlocking everything */
+
+	spin_lock(&configfs_dirent_lock);
+	sd->s_type &= ~CONFIGFS_USET_IN_MKDIR;
+	if (!ret) {
+		struct configfs_dirent *child_sd = child->d_fsdata;
+		/*
+		 * Mark as CONFIGFS_USET_DEFAULT to indicate this is a
+		 * kernel-created item that cannot be removed via rmdir.
+		 */
+		child_sd->s_type |= CONFIGFS_USET_DEFAULT;
+		configfs_dir_set_ready(child_sd);
+	}
+	spin_unlock(&configfs_dirent_lock);
+	inode_unlock(d_inode(parent));
+
+	/* in case configfs_attach_item() has failed */
+	if (ret)
+		goto err_unlink;
+
+	put_fragment(frag);
+	return 0;
+
+err_unlink:
+	/* Tear down everything we built up */
+	d_drop(child);
+	dput(child);
+	mutex_lock(&subsys->su_mutex);
+	unlink_obj(item);
+	mutex_unlock(&subsys->su_mutex);
+	put_fragment(frag);
+
+out_item_put:
+	module_put(item_owner);
+out_subsys_put:
+	module_put(subsys_owner);
+out:
+	return ret;
+}
+EXPORT_SYMBOL(configfs_register_item);
+
+/**
+ * configfs_unregister_item() - unregisters a kernel-created item
+ * @item: item to be unregistered
+ *
+ * This function reverses the effect of configfs_register_item(), removing
+ * the item from the configfs filesystem and releasing associated resources.
+ * The item must have been previously registered with configfs_register_item().
+ *
+ * This function releases the module references acquired during registration,
+ * following the same teardown semantics as configfs_rmdir().
+ */
+void configfs_unregister_item(struct config_item *item)
+{
+	struct config_group *group = item->ci_group;
+	struct dentry *dentry = item->ci_dentry;
+	struct configfs_subsystem *subsys;
+	struct configfs_fragment *frag;
+	struct configfs_dirent *sd;
+	struct dentry *parent;
+	struct module *subsys_owner = NULL, *item_owner = NULL;
+
+	if (!group || !dentry)
+		return;
+
+	subsys = group->cg_subsys;
+	if (!subsys)
+		return;
+
+	parent = item->ci_parent->ci_dentry;
+	sd = dentry->d_fsdata;
+	frag = get_fragment(sd->s_frag);
+
+	if (WARN_ON(!(sd->s_type & CONFIGFS_USET_DEFAULT))) {
+		put_fragment(frag);
+		return;
+	}
+
+	/*
+	 * Retrieve module owners before detaching. These were pinned during
+	 * configfs_register_item() and must be released.
+	 */
+	if (subsys->su_group.cg_item.ci_type)
+		subsys_owner = subsys->su_group.cg_item.ci_type->ct_owner;
+	if (item->ci_type)
+		item_owner = item->ci_type->ct_owner;
+
+	/* Mark fragment as dead */
+	down_write(&frag->frag_sem);
+	frag->frag_dead = true;
+	up_write(&frag->frag_sem);
+
+	inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
+	/*
+	 * Take configfs_symlink_mutex to prevent racing with symlink
+	 * creation/removal, matching the locking in configfs_rmdir().
+	 */
+	mutex_lock(&configfs_symlink_mutex);
+	spin_lock(&configfs_dirent_lock);
+	configfs_detach_prep(dentry, NULL);
+	spin_unlock(&configfs_dirent_lock);
+	mutex_unlock(&configfs_symlink_mutex);
+
+	configfs_detach_item(item);
+	d_inode(dentry)->i_flags |= S_DEAD;
+	dont_mount(dentry);
+	d_drop(dentry);
+	fsnotify_rmdir(d_inode(parent), dentry);
+	dput(dentry);
+	inode_unlock(d_inode(parent));
+
+	mutex_lock(&subsys->su_mutex);
+	unlink_obj(item);
+	mutex_unlock(&subsys->su_mutex);
+
+	put_fragment(frag);
+
+	/*
+	 * Release module references that were acquired during registration.
+	 * This mirrors the cleanup in configfs_rmdir().
+	 */
+	module_put(item_owner);
+	module_put(subsys_owner);
+}
+EXPORT_SYMBOL(configfs_unregister_item);
+
 int configfs_register_subsystem(struct configfs_subsystem *subsys)
 {
 	int err;
diff --git a/include/linux/configfs.h b/include/linux/configfs.h
index 698520b1bfdb..70f2d113b4b3 100644
--- a/include/linux/configfs.h
+++ b/include/linux/configfs.h
@@ -244,6 +244,10 @@ int configfs_register_group(struct config_group *parent_group,
 			    struct config_group *group);
 void configfs_unregister_group(struct config_group *group);
 
+int configfs_register_item(struct config_group *parent_group,
+			   struct config_item *item);
+void configfs_unregister_item(struct config_item *item);
+
 void configfs_remove_default_groups(struct config_group *group);
 
 struct config_group *

