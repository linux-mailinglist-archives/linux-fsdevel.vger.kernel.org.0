Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD1652D7DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 17:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbiESPg4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 11:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241170AbiESPgq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 11:36:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAD857126;
        Thu, 19 May 2022 08:36:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EE8661AF9;
        Thu, 19 May 2022 15:36:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9DDC385AA;
        Thu, 19 May 2022 15:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652974569;
        bh=4l+f8/FsvKGSq0ZcLXOKryvIIq/q/PQxFRhzHWMgZcs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=l/jTg5jDJVgM03BwlhMc1p10Ck8YAHV7/MQxqf7bvxAyNTDHvEPCS5lRUddcXMp23
         rYOb5BZo5UsWeKntebmb8qJqVsJa4Fta3b64HWRYI5KaZ8BbvOBctniPinr2yVUpxA
         2ysQeYJkTb3SdTXon6SXGpbVlm4BECd/Oohrp2+L5nHk03wqaFlP/pe91GyS2hk3S5
         3bbIn5g9KNRh3s2Dv7WCBrJhh/X6no338KzTXHb1Cg7PLz673Yv3QBKGayywZlm8fA
         SLbcLRyPUF8O4ZgwWnVK8Gy3ipSlGRn9BhIgZKl9rFJHBJ6khQTuEunc7dcyB1c1Op
         Z7vFRzzROBA2w==
Message-ID: <e5f6fee5518ce8e1b4fc5aa7038de1617a341c2f.camel@kernel.org>
Subject: Re: [PATCH 1/2] netfs: ->cleanup() op is always given a rreq
 pointer now
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        David Wysochanski <dwysocha@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        v9fs-developer@lists.sourceforge.net, ceph-devel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 19 May 2022 11:36:07 -0400
In-Reply-To: <165296980082.3595490.3561111064004493810.stgit@warthog.procyon.org.uk>
References: <165296980082.3595490.3561111064004493810.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2022-05-19 at 15:16 +0100, David Howells wrote:
> As the ->init() netfs op is now used to set up the netfslib I/O request
> rather than passing stuff in, thereby allowing the netfslib functions to =
be
> pointed at directly by the address_space_operations struct, we're always
> going to be able to pass an I/O request pointer to the cleanup function.
>=20
> Therefore, change the ->cleanup() function to take a pointer to the I/O
> request rather than taking a pointer to the network filesystem's
> address_space and a piece of private data.
>=20
> Also, rename ->cleanup() to ->free_request() to match the ->init_request(=
)
> function.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: Steve French <sfrench@samba.org>
> cc: Dominique Martinet <asmadeus@codewreck.org>
> cc: Jeff Layton <jlayton@redhat.com>
> cc: David Wysochanski <dwysocha@redhat.com>
> cc: Ilya Dryomov <idryomov@gmail.com>
> cc: v9fs-developer@lists.sourceforge.net
> cc: ceph-devel@vger.kernel.org
> cc: linux-afs@lists.infradead.org
> cc: linux-cifs@vger.kernel.org
> cc: linux-cachefs@redhat.com
> cc: linux-fsdevel@vger.kernel.org
> ---
>=20
>  fs/9p/vfs_addr.c      |   11 +++++------
>  fs/afs/file.c         |    6 +++---
>  fs/ceph/addr.c        |    9 ++++-----
>  fs/netfs/objects.c    |    8 +++++---
>  include/linux/netfs.h |    4 +++-
>  5 files changed, 20 insertions(+), 18 deletions(-)
>=20
> diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
> index 501128188343..002c482794dc 100644
> --- a/fs/9p/vfs_addr.c
> +++ b/fs/9p/vfs_addr.c
> @@ -66,13 +66,12 @@ static int v9fs_init_request(struct netfs_io_request =
*rreq, struct file *file)
>  }
> =20
>  /**
> - * v9fs_req_cleanup - Cleanup request initialized by v9fs_init_request
> - * @mapping: unused mapping of request to cleanup
> - * @priv: private data to cleanup, a fid, guaranted non-null.
> + * v9fs_free_request - Cleanup request initialized by v9fs_init_rreq
> + * @rreq: The I/O request to clean up
>   */
> -static void v9fs_req_cleanup(struct address_space *mapping, void *priv)
> +static void v9fs_free_request(struct netfs_io_request *rreq)
>  {
> -	struct p9_fid *fid =3D priv;
> +	struct p9_fid *fid =3D rreq->netfs_priv;
> =20
>  	p9_client_clunk(fid);
>  }
> @@ -94,9 +93,9 @@ static int v9fs_begin_cache_operation(struct netfs_io_r=
equest *rreq)
> =20
>  const struct netfs_request_ops v9fs_req_ops =3D {
>  	.init_request		=3D v9fs_init_request,
> +	.free_request		=3D v9fs_free_request,
>  	.begin_cache_operation	=3D v9fs_begin_cache_operation,
>  	.issue_read		=3D v9fs_issue_read,
> -	.cleanup		=3D v9fs_req_cleanup,
>  };
> =20
>  /**
> diff --git a/fs/afs/file.c b/fs/afs/file.c
> index 26292a110a8f..b9ca72fbbcf9 100644
> --- a/fs/afs/file.c
> +++ b/fs/afs/file.c
> @@ -383,17 +383,17 @@ static int afs_check_write_begin(struct file *file,=
 loff_t pos, unsigned len,
>  	return test_bit(AFS_VNODE_DELETED, &vnode->flags) ? -ESTALE : 0;
>  }
> =20
> -static void afs_priv_cleanup(struct address_space *mapping, void *netfs_=
priv)
> +static void afs_free_request(struct netfs_io_request *rreq)
>  {
> -	key_put(netfs_priv);
> +	key_put(rreq->netfs_priv);
>  }
> =20
>  const struct netfs_request_ops afs_req_ops =3D {
>  	.init_request		=3D afs_init_request,
> +	.free_request		=3D afs_free_request,
>  	.begin_cache_operation	=3D afs_begin_cache_operation,
>  	.check_write_begin	=3D afs_check_write_begin,
>  	.issue_read		=3D afs_issue_read,
> -	.cleanup		=3D afs_priv_cleanup,
>  };
> =20
>  int afs_write_inode(struct inode *inode, struct writeback_control *wbc)
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index b6edcf89a429..ee8c1b099c4f 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -392,11 +392,10 @@ static int ceph_init_request(struct netfs_io_reques=
t *rreq, struct file *file)
>  	return 0;
>  }
> =20
> -static void ceph_readahead_cleanup(struct address_space *mapping, void *=
priv)
> +static void ceph_netfs_free_request(struct netfs_io_request *rreq)
>  {
> -	struct inode *inode =3D mapping->host;
> -	struct ceph_inode_info *ci =3D ceph_inode(inode);
> -	int got =3D (uintptr_t)priv;
> +	struct ceph_inode_info *ci =3D ceph_inode(rreq->inode);
> +	int got =3D (uintptr_t)rreq->netfs_priv;
> =20
>  	if (got)
>  		ceph_put_cap_refs(ci, got);
> @@ -404,12 +403,12 @@ static void ceph_readahead_cleanup(struct address_s=
pace *mapping, void *priv)
> =20
>  const struct netfs_request_ops ceph_netfs_ops =3D {
>  	.init_request		=3D ceph_init_request,
> +	.free_request		=3D ceph_netfs_free_request,
>  	.begin_cache_operation	=3D ceph_begin_cache_operation,
>  	.issue_read		=3D ceph_netfs_issue_read,
>  	.expand_readahead	=3D ceph_netfs_expand_readahead,
>  	.clamp_length		=3D ceph_netfs_clamp_length,
>  	.check_write_begin	=3D ceph_netfs_check_write_begin,
> -	.cleanup		=3D ceph_readahead_cleanup,
>  };
> =20
>  #ifdef CONFIG_CEPH_FSCACHE
> diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
> index e86107b30ba4..d6b8c0cbeb7c 100644
> --- a/fs/netfs/objects.c
> +++ b/fs/netfs/objects.c
> @@ -75,10 +75,10 @@ static void netfs_free_request(struct work_struct *wo=
rk)
>  	struct netfs_io_request *rreq =3D
>  		container_of(work, struct netfs_io_request, work);
> =20
> -	netfs_clear_subrequests(rreq, false);
> -	if (rreq->netfs_priv)
> -		rreq->netfs_ops->cleanup(rreq->mapping, rreq->netfs_priv);
>  	trace_netfs_rreq(rreq, netfs_rreq_trace_free);
> +	netfs_clear_subrequests(rreq, false);
> +	if (rreq->netfs_ops->free_request)
> +		rreq->netfs_ops->free_request(rreq);
>  	if (rreq->cache_resources.ops)
>  		rreq->cache_resources.ops->end_operation(&rreq->cache_resources);
>  	kfree(rreq);
> @@ -140,6 +140,8 @@ static void netfs_free_subrequest(struct netfs_io_sub=
request *subreq,
>  	struct netfs_io_request *rreq =3D subreq->rreq;
> =20
>  	trace_netfs_sreq(subreq, netfs_sreq_trace_free);
> +	if (rreq->netfs_ops->free_subrequest)
> +		rreq->netfs_ops->free_subrequest(subreq);
>  	kfree(subreq);
>  	netfs_stat_d(&netfs_n_rh_sreq);
>  	netfs_put_request(rreq, was_async, netfs_rreq_trace_put_subreq);
> diff --git a/include/linux/netfs.h b/include/linux/netfs.h
> index c7bf1eaf51d5..1970c21b4f80 100644
> --- a/include/linux/netfs.h
> +++ b/include/linux/netfs.h
> @@ -204,7 +204,10 @@ struct netfs_io_request {
>   */
>  struct netfs_request_ops {
>  	int (*init_request)(struct netfs_io_request *rreq, struct file *file);
> +	void (*free_request)(struct netfs_io_request *rreq);
> +	void (*free_subrequest)(struct netfs_io_subrequest *rreq);

Do we need free_subrequest? It looks like nothing defines it in this
series.

>  	int (*begin_cache_operation)(struct netfs_io_request *rreq);
> +
>  	void (*expand_readahead)(struct netfs_io_request *rreq);
>  	bool (*clamp_length)(struct netfs_io_subrequest *subreq);
>  	void (*issue_read)(struct netfs_io_subrequest *subreq);
> @@ -212,7 +215,6 @@ struct netfs_request_ops {
>  	int (*check_write_begin)(struct file *file, loff_t pos, unsigned len,
>  				 struct folio *folio, void **_fsdata);
>  	void (*done)(struct netfs_io_request *rreq);
> -	void (*cleanup)(struct address_space *mapping, void *netfs_priv);
>  };
> =20
>  /*
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
