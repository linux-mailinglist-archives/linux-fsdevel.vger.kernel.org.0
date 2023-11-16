Return-Path: <linux-fsdevel+bounces-2944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2517EDCC9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 09:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46273280FF3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 08:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B77A111A5;
	Thu, 16 Nov 2023 08:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hwunZvox"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89031AB;
	Thu, 16 Nov 2023 00:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=KWSUxhA1Oe74ysp9fs9nW8FRTQcU3EMf4gVGsq6IKw0=; b=hwunZvoxdDucA0oaNtZJUVOuVi
	5KEcSLIhgMRGlnyr4jDmdugMH8egOaq5IECwOW0JGVjP9laNiiEjTw/oRbTSVMXWH1jwqdL6AuW3Z
	AYCBXQtTbMJR9s2nh0t8C96+iCjogsChpuqQga3b0EZg5Hrxf9vo5Ma0nyQE3LynKY9MucHl+pqoi
	NguxO3ood6uxDzPkmqsmVtjwFt+A/PFl4SUOfUKK86Vo3yW5Eaou68ywuCNIOpjIr57LnlECuviGa
	o7uwsi3/A+v4wnDSrHWtOHg1omA/HZuNkY/0GFtddeGmpV1A7JOeAhUSJkitGU8Wv9BWM6ozkSv/Q
	wchcQq3Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r3Xap-00GVyv-0A;
	Thu, 16 Nov 2023 08:19:19 +0000
Date: Thu, 16 Nov 2023 08:19:19 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: jlayton@kernel.org
Cc: linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org
Subject: [deadlock or dead code] ceph_encode_dentry_release() misuse of dget()
Message-ID: <20231116081919.GZ1957730@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

This
        spin_lock(&dentry->d_lock);
        if (di->lease_session && di->lease_session->s_mds == mds)
                force = 1;
        if (!dir) {
                parent = dget(dentry->d_parent);
                dir = d_inode(parent);
        }
        spin_unlock(&dentry->d_lock);
has a problem if we ever get called with dir == NULL.

The thing is, dget(dentry->d_parent) will spin if dentry->d_parent->d_lock
is held.  IOW, the whole thing is an equivalent of
	spin_lock(&dentry->d_lock);
	spin_lock(&dentry->d_parent->d_lock);
which takes them in the wrong order.

Said that, I'm not sure it ever gets called with dir == NULL;
we have two callers -
        if (req->r_dentry_drop) {
                ret = ceph_encode_dentry_release(&p, req->r_dentry,
                                req->r_parent, mds, req->r_dentry_drop,
                                req->r_dentry_unless);
                if (ret < 0)
                        goto out_err;
                releases += ret;
        }
and
        if (req->r_old_dentry_drop) {
                ret = ceph_encode_dentry_release(&p, req->r_old_dentry,
                                req->r_old_dentry_dir, mds,
                                req->r_old_dentry_drop,
                                req->r_old_dentry_unless);
                if (ret < 0)
                        goto out_err;
                releases += ret;
        }
Now, ->r_dentry_drop is set in ceph_mknod(), ceph_symlink(), ceph_mkdir(),
ceph_link(), ceph_unlink(), all with
        req->r_parent = dir;
        ihold(dir);
ceph_rename(), with
        req->r_parent = new_dir;
        ihold(new_dir);
and ceph_atomic_open(), with
        req->r_parent = dir;
        if (req->r_op == CEPH_MDS_OP_CREATE)
                req->r_mnt_idmap = mnt_idmap_get(idmap);
        ihold(dir);
All of that will oops if ->r_parent set to NULL.
->r_old_dentry_drop() is set in ceph_rename(), with
        struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(old_dir->i_sb);
	...
        req->r_old_dentry_dir = old_dir;
which also can't manage to leave ->r_old_dentry_dir set to NULL.

Am I missing something subtle here?  Looks like that dget() is never
reached...

