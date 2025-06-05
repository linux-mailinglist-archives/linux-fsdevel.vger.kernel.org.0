Return-Path: <linux-fsdevel+bounces-50706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E19ACE971
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 07:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5B243AAC88
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 05:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB371AD3E5;
	Thu,  5 Jun 2025 05:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjGhekro"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E111DE3DC;
	Thu,  5 Jun 2025 05:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749102614; cv=none; b=iOTHemXFTBOaaCzKXLRZmdw3/0794Fvk0LKFPQI0c8T1P1psZGY9R+2gNVzrtKkQfYt8lgLxxHm4UgtpdCcnaR7NuAtVKtIvGWNjQtZnzl2vPG+zVnCsg3AcL8ZB0mpPuYAddKpAR/DwoXzbUO3/QZ1H3Gt3XPuZ/5qrW6MgaY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749102614; c=relaxed/simple;
	bh=qs0L8RWOQrfH+BuAGm8VA2+QF4D9DsqgbCCykmbS7hM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rki0E11GooIXvc8dJpHGIz4QVBppwVrcVf71vtdnNHrdFpbjmrlm6OU7tIaCDmbKW788X34A8KizFDoSulxrEgop9JEt8w6EnwCminGDpzDyvAkmVQOYKTXfT4ECt9OVMjhC/5VrW2fvK6mq48PtLPZL8/fMhPl0toQpBg1n/9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjGhekro; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4845C4CEE7;
	Thu,  5 Jun 2025 05:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749102613;
	bh=qs0L8RWOQrfH+BuAGm8VA2+QF4D9DsqgbCCykmbS7hM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PjGhekro9i0u1SPcGCom4gAb48wNARMXn6A6gaDblDsaK7HYDJf/JD6QaWG46YBs6
	 TCAPUsLofAma+mUXCkwb73LupFQtXJzt34OSmd8fIufYmJCjDqolgHV3SH+yI3jfR/
	 rfPzn9UpcUjNklg9SPRqagfw4CpXPB+HkhG9+/MutkpU+GDNoNDUD8/THQScpcRrzc
	 Q2kLuCyIGvZGf7ihWVGZYPtxALsBLwknrrnVz7RjvqGlsVanzWbK7euwEhqJQV0BR7
	 fp+Tw4rT0h6FMLbUayWl5q2On0P85sraYAKGvGLSjoc6iiV68atTmA+L5Vnv4Htlnr
	 TCKTY7u+facQw==
Date: Thu, 5 Jun 2025 08:49:44 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Ackerley Tng <ackerleytng@google.com>,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-fsdevel@vger.kernel.org, aik@amd.com, ajones@ventanamicro.com,
	akpm@linux-foundation.org, amoorthy@google.com,
	anthony.yznaga@oracle.com, anup@brainfault.org,
	aou@eecs.berkeley.edu, bfoster@redhat.com,
	binbin.wu@linux.intel.com, brauner@kernel.org,
	catalin.marinas@arm.com, chao.p.peng@intel.com,
	chenhuacai@kernel.org, dave.hansen@intel.com, david@redhat.com,
	dmatlack@google.com, dwmw@amazon.co.uk, erdemaktas@google.com,
	fan.du@intel.com, fvdl@google.com, graf@amazon.com,
	haibo1.xu@intel.com, hch@infradead.org, hughd@google.com,
	ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz,
	james.morse@arm.com, jarkko@kernel.org, jgg@ziepe.ca,
	jgowans@amazon.com, jhubbard@nvidia.com, jroedel@suse.de,
	jthoughton@google.com, jun.miao@intel.com, kai.huang@intel.com,
	keirf@google.com, kent.overstreet@linux.dev,
	kirill.shutemov@intel.com, liam.merwick@oracle.com,
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name,
	maz@kernel.org, mic@digikod.net, michael.roth@amd.com,
	mpe@ellerman.id.au, muchun.song@linux.dev, nikunj@amd.com,
	nsaenz@amazon.es, oliver.upton@linux.dev, palmer@dabbelt.com,
	pankaj.gupta@amd.com, paul.walmsley@sifive.com, pbonzini@redhat.com,
	pdurrant@amazon.co.uk, peterx@redhat.com, pgonda@google.com,
	pvorel@suse.cz, qperret@google.com, quic_cvanscha@quicinc.com,
	quic_eberman@quicinc.com, quic_mnalajal@quicinc.com,
	quic_pderrin@quicinc.com, quic_pheragu@quicinc.com,
	quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com,
	richard.weiyang@gmail.com, rick.p.edgecombe@intel.com,
	rientjes@google.com, roypat@amazon.co.uk, seanjc@google.com,
	shuah@kernel.org, steven.price@arm.com, steven.sistare@oracle.com,
	suzuki.poulose@arm.com, tabba@google.com, thomas.lendacky@amd.com,
	vannapurve@google.com, vbabka@suse.cz, viro@zeniv.linux.org.uk,
	vkuznets@redhat.com, wei.w.wang@intel.com, will@kernel.org,
	willy@infradead.org, xiaoyao.li@intel.com, yan.y.zhao@intel.com,
	yilun.xu@intel.com, yuzenghui@huawei.com, zhiquan1.li@intel.com
Subject: Re: [PATCH 1/2] fs: Provide function that allocates a secure
 anonymous inode
Message-ID: <aEEv-A1ot_t8ePgv@kernel.org>
References: <cover.1748890962.git.ackerleytng@google.com>
 <c03fbe18c3ae90fb3fa7c71dc0ee164e6cc12103.1748890962.git.ackerleytng@google.com>
 <aD_8z4pd7JcFkAwX@kernel.org>
 <CAHC9VhQczhrVx4YEGbXbAS8FLi0jaV1RB0kb8e4rPsUOXYLqtA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhQczhrVx4YEGbXbAS8FLi0jaV1RB0kb8e4rPsUOXYLqtA@mail.gmail.com>

On Wed, Jun 04, 2025 at 05:13:35PM -0400, Paul Moore wrote:
> On Wed, Jun 4, 2025 at 3:59 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > (added Paul Moore for selinux bits)
> 
> Thanks Mike.
> 
> I'm adding the LSM and SELinux lists too since there are others that
> will be interested as well.
> 
> > On Mon, Jun 02, 2025 at 12:17:54PM -0700, Ackerley Tng wrote:
> > > The new function, alloc_anon_secure_inode(), returns an inode after
> > > running checks in security_inode_init_security_anon().
> > >
> > > Also refactor secretmem's file creation process to use the new
> > > function.
> > >
> > > Suggested-by: David Hildenbrand <david@redhat.com>
> > > Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> > > ---
> > >  fs/anon_inodes.c   | 22 ++++++++++++++++------
> > >  include/linux/fs.h |  1 +
> > >  mm/secretmem.c     |  9 +--------
> > >  3 files changed, 18 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
> > > index 583ac81669c2..4c3110378647 100644
> > > --- a/fs/anon_inodes.c
> > > +++ b/fs/anon_inodes.c
> > > @@ -55,17 +55,20 @@ static struct file_system_type anon_inode_fs_type = {
> > >       .kill_sb        = kill_anon_super,
> > >  };
> > >
> > > -static struct inode *anon_inode_make_secure_inode(
> > > -     const char *name,
> > > -     const struct inode *context_inode)
> > > +static struct inode *anon_inode_make_secure_inode(struct super_block *s,
> > > +             const char *name, const struct inode *context_inode,
> > > +             bool fs_internal)
> > >  {
> > >       struct inode *inode;
> > >       int error;
> > >
> > > -     inode = alloc_anon_inode(anon_inode_mnt->mnt_sb);
> > > +     inode = alloc_anon_inode(s);
> > >       if (IS_ERR(inode))
> > >               return inode;
> > > -     inode->i_flags &= ~S_PRIVATE;
> > > +
> > > +     if (!fs_internal)
> > > +             inode->i_flags &= ~S_PRIVATE;
> > > +
> > >       error = security_inode_init_security_anon(inode, &QSTR(name),
> > >                                                 context_inode);
> > >       if (error) {
> > > @@ -75,6 +78,12 @@ static struct inode *anon_inode_make_secure_inode(
> > >       return inode;
> > >  }
> > >
> > > +struct inode *alloc_anon_secure_inode(struct super_block *s, const char *name)
> > > +{
> > > +     return anon_inode_make_secure_inode(s, name, NULL, true);
> > > +}
> > > +EXPORT_SYMBOL_GPL(alloc_anon_secure_inode);
> > > +
> > >  static struct file *__anon_inode_getfile(const char *name,
> > >                                        const struct file_operations *fops,
> > >                                        void *priv, int flags,
> > > @@ -88,7 +97,8 @@ static struct file *__anon_inode_getfile(const char *name,
> > >               return ERR_PTR(-ENOENT);
> > >
> > >       if (make_inode) {
> > > -             inode = anon_inode_make_secure_inode(name, context_inode);
> > > +             inode = anon_inode_make_secure_inode(anon_inode_mnt->mnt_sb,
> > > +                                                  name, context_inode, false);
> > >               if (IS_ERR(inode)) {
> > >                       file = ERR_CAST(inode);
> > >                       goto err;
> > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > index 016b0fe1536e..0fded2e3c661 100644
> > > --- a/include/linux/fs.h
> > > +++ b/include/linux/fs.h
> > > @@ -3550,6 +3550,7 @@ extern int simple_write_begin(struct file *file, struct address_space *mapping,
> > >  extern const struct address_space_operations ram_aops;
> > >  extern int always_delete_dentry(const struct dentry *);
> > >  extern struct inode *alloc_anon_inode(struct super_block *);
> > > +extern struct inode *alloc_anon_secure_inode(struct super_block *, const char *);
> > >  extern int simple_nosetlease(struct file *, int, struct file_lease **, void **);
> > >  extern const struct dentry_operations simple_dentry_operations;
> > >
> > > diff --git a/mm/secretmem.c b/mm/secretmem.c
> > > index 1b0a214ee558..c0e459e58cb6 100644
> > > --- a/mm/secretmem.c
> > > +++ b/mm/secretmem.c
> > > @@ -195,18 +195,11 @@ static struct file *secretmem_file_create(unsigned long flags)
> > >       struct file *file;
> > >       struct inode *inode;
> > >       const char *anon_name = "[secretmem]";
> > > -     int err;
> > >
> > > -     inode = alloc_anon_inode(secretmem_mnt->mnt_sb);
> > > +     inode = alloc_anon_secure_inode(secretmem_mnt->mnt_sb, anon_name);
> > >       if (IS_ERR(inode))
> > >               return ERR_CAST(inode);
> >
> > I don't think we should not hide secretmem and guest_memfd inodes from
> > selinux, so clearing S_PRIVATE for them is not needed and you can just drop
> > fs_internal parameter in anon_inode_make_secure_inode()
> 
> It's especially odd since I don't see any comments or descriptions
> about why this is being done.  The secretmem change is concerning as
> this is user accessible and marking the inode with S_PRIVATE will
> bypass a number of LSM/SELinux access controls, possibly resulting in
> a security regression (one would need to dig a bit deeper to see what
> is possible with secretmem and which LSM/SELinux code paths would be
> affected).

secretmem always had S_PRIVATE set because alloc_anon_inode() clears it
anyway and this patch does not change it.
I'm just thinking that it makes sense to actually allow LSM/SELinux
controls that S_PRIVATE bypasses for both secretmem and guest_memfd.
 
-- 
Sincerely yours,
Mike.

