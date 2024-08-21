Return-Path: <linux-fsdevel+bounces-26559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F72B95A6F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 23:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3161A1F23BED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 21:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C2A17A589;
	Wed, 21 Aug 2024 21:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftOBDwal"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACD413A3E8;
	Wed, 21 Aug 2024 21:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724276603; cv=none; b=RBjaYA80XzUJXnYhdelQy+Z7LAyz0nOCjlK9NdNHqC8StrshnsSmcqkAAFZfczku586xuLClTQ6SEUriuXafLcxxCbdznGjcW8uC23L+KHI1b8MuLpkwNGlB8sSdhf5y7kiN+w8oVZK3GsCa9BCndZ7nAXXsVyHRQRKfSPHcN1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724276603; c=relaxed/simple;
	bh=dqkPkh3UKBPCiYLlN55NAMuQyrCpfqQeTQecLm/Wbr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRB1qWfHXwVnNRNgi42RjeO3kDmGjx+cVBCVPv71lqLgx7/UlcyvIuS60FLClF12GL+y+jIvtQhqAQMpRkzpWLvCvAfGl8V05LUOxYAH6CBV7E/a6nOJpZGzKoKa8LE+0BGeohicczfTWM/NmWBq0aB3w/ZpHtZzu83kYv0D3LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftOBDwal; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8278EC32781;
	Wed, 21 Aug 2024 21:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724276602;
	bh=dqkPkh3UKBPCiYLlN55NAMuQyrCpfqQeTQecLm/Wbr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ftOBDwalwaCnok3MFOigLdjUigPY3u3yQpEvG5e3XAkSNBLmg1v6hpGrWSy7NVsWJ
	 Q3iuFq3p+TR17+AgUWnAyiNIGW1nXd+lViB9AdUszlhDdR2JbsJuAlOIc/58ee95Ac
	 dAz0qH+GVkTKwj3QrUDlOjsJzt/ubVfiMLI2ZNRF031Tw7ILA44AYyWE7T7i7rdWq+
	 zrvVnSTFhMErRozodqAxKPCJPZB1/+aLfsTKXjHOdjiJw/LXrYf77/yugoDu9FS5u0
	 F9v78aDJqy94fgBMnnMABQESIYAoATVkCgunHtnoV/wsbD+Suk5N2UiduSHoXvWVYL
	 za/dpcpBUL69g==
Date: Wed, 21 Aug 2024 17:43:21 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v12 12/24] SUNRPC: replace program list with program array
Message-ID: <ZsZfeUhwb7BCXjBZ@kernel.org>
References: <20240819181750.70570-1-snitzer@kernel.org>
 <20240819181750.70570-13-snitzer@kernel.org>
 <56ffc1da7b6b40e8bc2795dcefc623a19dd364d7.camel@kernel.org>
 <ZsZQqmvbyWGSuybH@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZsZQqmvbyWGSuybH@kernel.org>

On Wed, Aug 21, 2024 at 04:40:10PM -0400, Mike Snitzer wrote:
> On Wed, Aug 21, 2024 at 02:31:07PM -0400, Jeff Layton wrote:
> > On Mon, 2024-08-19 at 14:17 -0400, Mike Snitzer wrote:
> > > From: NeilBrown <neil@brown.name>
> > > 
> > > A service created with svc_create_pooled() can be given a linked list of
> > > programs and all of these will be served.
> > > 
> > > Using a linked list makes it cumbersome when there are several programs
> > > that can be optionally selected with CONFIG settings.
> > > 
> > > After this patch is applied, API consumers must use only
> > > svc_create_pooled() when creating an RPC service that listens for more
> > > than one RPC program.
> > > 
> > > Signed-off-by: NeilBrown <neil@brown.name>
> > > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > > ---
> > >  fs/nfsd/nfsctl.c           |  2 +-
> > >  fs/nfsd/nfsd.h             |  2 +-
> > >  fs/nfsd/nfssvc.c           | 67 +++++++++++++++++--------------------
> > >  include/linux/sunrpc/svc.h |  7 ++--
> > >  net/sunrpc/svc.c           | 68 ++++++++++++++++++++++----------------
> > >  net/sunrpc/svc_xprt.c      |  2 +-
> > >  net/sunrpc/svcauth_unix.c  |  3 +-
> > >  7 files changed, 79 insertions(+), 72 deletions(-)
> > > 
> > > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > > index 1c9e5b4bcb0a..64c1b4d649bc 100644
> > > --- a/fs/nfsd/nfsctl.c
> > > +++ b/fs/nfsd/nfsctl.c
> > > @@ -2246,7 +2246,7 @@ static __net_init int nfsd_net_init(struct net *net)
> > >  	if (retval)
> > >  		goto out_repcache_error;
> > >  	memset(&nn->nfsd_svcstats, 0, sizeof(nn->nfsd_svcstats));
> > > -	nn->nfsd_svcstats.program = &nfsd_program;
> > > +	nn->nfsd_svcstats.program = &nfsd_programs[0];
> > >  	for (i = 0; i < sizeof(nn->nfsd_versions); i++)
> > >  		nn->nfsd_versions[i] = nfsd_support_version(i);
> > >  	for (i = 0; i < sizeof(nn->nfsd4_minorversions); i++)
> > > diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> > > index f87a359d968f..232a873dc53a 100644
> > > --- a/fs/nfsd/nfsd.h
> > > +++ b/fs/nfsd/nfsd.h
> > > @@ -85,7 +85,7 @@ struct nfsd_genl_rqstp {
> > >  	u32			rq_opnum[NFSD_MAX_OPS_PER_COMPOUND];
> > >  };
> > >  
> > > -extern struct svc_program	nfsd_program;
> > > +extern struct svc_program	nfsd_programs[];
> > >  extern const struct svc_version	nfsd_version2, nfsd_version3, nfsd_version4;
> > >  extern struct mutex		nfsd_mutex;
> > >  extern spinlock_t		nfsd_drc_lock;
> > > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > > index 1bec3a53e35f..5f8680ab1013 100644
> > > --- a/fs/nfsd/nfssvc.c
> > > +++ b/fs/nfsd/nfssvc.c
> > > @@ -35,7 +35,6 @@
> > >  #define NFSDDBG_FACILITY	NFSDDBG_SVC
> > >  
> > >  atomic_t			nfsd_th_cnt = ATOMIC_INIT(0);
> > > -extern struct svc_program	nfsd_program;
> > >  static int			nfsd(void *vrqstp);
> > >  #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
> > >  static int			nfsd_acl_rpcbind_set(struct net *,
> > > @@ -87,16 +86,6 @@ static const struct svc_version *localio_versions[] = {
> > >  
> > >  #define NFSD_LOCALIO_NRVERS		ARRAY_SIZE(localio_versions)
> > >  
> > > -static struct svc_program	nfsd_localio_program = {
> > > -	.pg_prog		= NFS_LOCALIO_PROGRAM,
> > > -	.pg_nvers		= NFSD_LOCALIO_NRVERS,
> > > -	.pg_vers		= localio_versions,
> > > -	.pg_name		= "nfslocalio",
> > > -	.pg_class		= "nfsd",
> > > -	.pg_authenticate	= &svc_set_client,
> > > -	.pg_init_request	= svc_generic_init_request,
> > > -	.pg_rpcbind_set		= svc_generic_rpcbind_set,
> > > -};
> > >  #endif /* CONFIG_NFSD_LOCALIO */
> > >  
> > >  #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
> > > @@ -109,23 +98,9 @@ static const struct svc_version *nfsd_acl_version[] = {
> > >  # endif
> > >  };
> > >  
> > > -#define NFSD_ACL_MINVERS            2
> > > +#define NFSD_ACL_MINVERS	2
> > >  #define NFSD_ACL_NRVERS		ARRAY_SIZE(nfsd_acl_version)
> > >  
> > > -static struct svc_program	nfsd_acl_program = {
> > > -#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
> > > -	.pg_next		= &nfsd_localio_program,
> > > -#endif /* CONFIG_NFSD_LOCALIO */
> > > -	.pg_prog		= NFS_ACL_PROGRAM,
> > > -	.pg_nvers		= NFSD_ACL_NRVERS,
> > > -	.pg_vers		= nfsd_acl_version,
> > > -	.pg_name		= "nfsacl",
> > > -	.pg_class		= "nfsd",
> > > -	.pg_authenticate	= &svc_set_client,
> > > -	.pg_init_request	= nfsd_acl_init_request,
> > > -	.pg_rpcbind_set		= nfsd_acl_rpcbind_set,
> > > -};
> > > -
> > 
> > You just added this code in patch 11.
> > 
> > I think it'd be clearer to reverse the order of patches 11 and 12. That
> > way you don't have this interim version of the localio program that
> > lives on the linked list.
> 
> You may recall that these changes developed over time.  This patch
> from Neil came after because he saw a way to make things better.
> Inverting/inserting patches earlier to reduce "churn" loses the
> development history.  (It also introduces possibility to cause some
> regression or break bisect-ability.)
> 
> It'd be one thing if I wrote every patch in this series, but I built
> on others' work and then others upon that.  Preserving development
> history and attribution is something I've always tried to do.
> Otherwise changes get attributed to the wrong person.
> 
> SO in this instance, I'd prefer to keep Neil's contribution as-is and
> avoid switching patch 12 and 11.

Looked closer, Neil is a co-developer on the preceding patch (happened
as side-effect of a different rebase some iterations ago).  So I'm
fine with switching patches 11 and 12 like you suggested.  It does
make things cleaner.

Thanks,
Mike

