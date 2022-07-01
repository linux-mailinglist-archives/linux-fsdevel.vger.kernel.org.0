Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0A356312A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 12:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbiGAKQ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jul 2022 06:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbiGAKQ4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jul 2022 06:16:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCD37696D;
        Fri,  1 Jul 2022 03:16:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CA726239A;
        Fri,  1 Jul 2022 10:16:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF727C3411E;
        Fri,  1 Jul 2022 10:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656670613;
        bh=jgstxL+Vf+2Db8pwLyt5WhpasNddzLD46KvT1LJmSh4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=rXexbPKt1T320j0Hwb1KCz5Rt/JdG4GQqyhbFk2+4Hjcu4d3PfC/vtOqATNR3Ha8c
         Zf023qyN+TXrW+RUuSelkwmKxWDayiuFPhExqQYgslm1hZ0EQiWnufZKZ5a3WIT42t
         RILPQRJMC1CitCgxOeoe1i9juQ3AfX3H9AEMN57T+x26TAByF4iw7GiYW/++gdDctq
         uL17+K7yA6do2pygzxtM0JL33DfBMISzYI9/lOtpwmDF4tIIRX59SgISIhnWV/YwbN
         B01DzoQ3eZSPlWfG1khUkGvbQIflL0E44UnFBHsGc/w9HSAFs64G8I+JUbx8bQQG+R
         quHDLfwdVncqw==
Message-ID: <2431ec5495612912399471c94dbec6246866359a.camel@kernel.org>
Subject: Re: [PATCH v2 1/2] libceph: add new iov_iter-based
 ceph_msg_data_type and ceph_osd_data_type
From:   Jeff Layton <jlayton@kernel.org>
To:     Xiubo Li <xiubli@redhat.com>, idryomov@gmail.com
Cc:     ceph-devel@vger.kernel.org, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Date:   Fri, 01 Jul 2022 06:16:51 -0400
In-Reply-To: <86b15eae-66f8-2865-bca4-74c207b30100@redhat.com>
References: <20220627155449.383989-1-jlayton@kernel.org>
         <20220627155449.383989-2-jlayton@kernel.org>
         <86b15eae-66f8-2865-bca4-74c207b30100@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2022-07-01 at 10:04 +0800, Xiubo Li wrote:
> On 6/27/22 11:54 PM, Jeff Layton wrote:
> > Add an iov_iter to the unions in ceph_msg_data and ceph_msg_data_cursor=
.
> > Instead of requiring a list of pages or bvecs, we can just use an
> > iov_iter directly, and avoid extra allocations.
> >=20
> > We assume that the pages represented by the iter are pinned such that
> > they shouldn't incur page faults, which is the case for the iov_iters
> > created by netfs.
> >=20
> > While working on this, Al Viro informed me that he was going to change
> > iov_iter_get_pages to auto-advance the iterator as that pattern is more
> > or less required for ITER_PIPE anyway. We emulate that here for now by
> > advancing in the _next op and tracking that amount in the "lastlen"
> > field.
> >=20
> > In the event that _next is called twice without an intervening
> > _advance, we revert the iov_iter by the remaining lastlen before
> > calling iov_iter_get_pages.
> >=20
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Cc: David Howells <dhowells@redhat.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >   include/linux/ceph/messenger.h  |  8 ++++
> >   include/linux/ceph/osd_client.h |  4 ++
> >   net/ceph/messenger.c            | 85 ++++++++++++++++++++++++++++++++=
+
> >   net/ceph/osd_client.c           | 27 +++++++++++
> >   4 files changed, 124 insertions(+)
> >=20
> > diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messen=
ger.h
> > index 9fd7255172ad..2eaaabbe98cb 100644
> > --- a/include/linux/ceph/messenger.h
> > +++ b/include/linux/ceph/messenger.h
> > @@ -123,6 +123,7 @@ enum ceph_msg_data_type {
> >   	CEPH_MSG_DATA_BIO,	/* data source/destination is a bio list */
> >   #endif /* CONFIG_BLOCK */
> >   	CEPH_MSG_DATA_BVECS,	/* data source/destination is a bio_vec array *=
/
> > +	CEPH_MSG_DATA_ITER,	/* data source/destination is an iov_iter */
> >   };
> >  =20
> >   #ifdef CONFIG_BLOCK
> > @@ -224,6 +225,7 @@ struct ceph_msg_data {
> >   			bool		own_pages;
> >   		};
> >   		struct ceph_pagelist	*pagelist;
> > +		struct iov_iter		iter;
> >   	};
> >   };
> >  =20
> > @@ -248,6 +250,10 @@ struct ceph_msg_data_cursor {
> >   			struct page	*page;		/* page from list */
> >   			size_t		offset;		/* bytes from list */
> >   		};
> > +		struct {
> > +			struct iov_iter		iov_iter;
> > +			unsigned int		lastlen;
> > +		};
> >   	};
> >   };
> >  =20
> > @@ -605,6 +611,8 @@ void ceph_msg_data_add_bio(struct ceph_msg *msg, st=
ruct ceph_bio_iter *bio_pos,
> >   #endif /* CONFIG_BLOCK */
> >   void ceph_msg_data_add_bvecs(struct ceph_msg *msg,
> >   			     struct ceph_bvec_iter *bvec_pos);
> > +void ceph_msg_data_add_iter(struct ceph_msg *msg,
> > +			    struct iov_iter *iter);
> >  =20
> >   struct ceph_msg *ceph_msg_new2(int type, int front_len, int max_data_=
items,
> >   			       gfp_t flags, bool can_fail);
> > diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_c=
lient.h
> > index 6ec3cb2ac457..ef0ad534b6c5 100644
> > --- a/include/linux/ceph/osd_client.h
> > +++ b/include/linux/ceph/osd_client.h
> > @@ -108,6 +108,7 @@ enum ceph_osd_data_type {
> >   	CEPH_OSD_DATA_TYPE_BIO,
> >   #endif /* CONFIG_BLOCK */
> >   	CEPH_OSD_DATA_TYPE_BVECS,
> > +	CEPH_OSD_DATA_TYPE_ITER,
> >   };
> >  =20
> >   struct ceph_osd_data {
> > @@ -131,6 +132,7 @@ struct ceph_osd_data {
> >   			struct ceph_bvec_iter	bvec_pos;
> >   			u32			num_bvecs;
> >   		};
> > +		struct iov_iter		iter;
> >   	};
> >   };
> >  =20
> > @@ -501,6 +503,8 @@ void osd_req_op_extent_osd_data_bvecs(struct ceph_o=
sd_request *osd_req,
> >   void osd_req_op_extent_osd_data_bvec_pos(struct ceph_osd_request *osd=
_req,
> >   					 unsigned int which,
> >   					 struct ceph_bvec_iter *bvec_pos);
> > +void osd_req_op_extent_osd_iter(struct ceph_osd_request *osd_req,
> > +				unsigned int which, struct iov_iter *iter);
> >  =20
> >   extern void osd_req_op_cls_request_data_pagelist(struct ceph_osd_requ=
est *,
> >   					unsigned int which,
> > diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> > index 6056c8f7dd4c..604f025034ab 100644
> > --- a/net/ceph/messenger.c
> > +++ b/net/ceph/messenger.c
> > @@ -964,6 +964,69 @@ static bool ceph_msg_data_pagelist_advance(struct =
ceph_msg_data_cursor *cursor,
> >   	return true;
> >   }
> >  =20
> > +static void ceph_msg_data_iter_cursor_init(struct ceph_msg_data_cursor=
 *cursor,
> > +					size_t length)
> > +{
> > +	struct ceph_msg_data *data =3D cursor->data;
> > +
> > +	cursor->iov_iter =3D data->iter;
> > +	cursor->lastlen =3D 0;
> > +	iov_iter_truncate(&cursor->iov_iter, length);
> > +	cursor->resid =3D iov_iter_count(&cursor->iov_iter);
> > +}
> > +
> > +static struct page *ceph_msg_data_iter_next(struct ceph_msg_data_curso=
r *cursor,
> > +						size_t *page_offset,
> > +						size_t *length)
> > +{
> > +	struct page *page;
> > +	ssize_t len;
> > +
> > +	if (cursor->lastlen)
> > +		iov_iter_revert(&cursor->iov_iter, cursor->lastlen);
> > +
> > +	len =3D iov_iter_get_pages(&cursor->iov_iter, &page, PAGE_SIZE,
> > +				 1, page_offset);
> > +	BUG_ON(len < 0);
> > +
> > +	cursor->lastlen =3D len;
> > +
> > +	/*
> > +	 * FIXME: Al Viro says that he will soon change iov_iter_get_pages
> > +	 * to auto-advance the iterator. Emulate that here for now.
> > +	 */
> > +	iov_iter_advance(&cursor->iov_iter, len);
> > +
> > +	/*
> > +	 * FIXME: The assumption is that the pages represented by the iov_ite=
r
> > +	 * 	  are pinned, with the references held by the upper-level
> > +	 * 	  callers, or by virtue of being under writeback. Eventually,
> > +	 * 	  we'll get an iov_iter_get_pages variant that doesn't take page
> > +	 * 	  refs. Until then, just put the page ref.
> > +	 */
> > +	VM_BUG_ON_PAGE(!PageWriteback(page) && page_count(page) < 2, page);
> > +	put_page(page);
> > +
> > +	*length =3D min_t(size_t, len, cursor->resid);
> > +	return page;
> > +}
> > +
> > +static bool ceph_msg_data_iter_advance(struct ceph_msg_data_cursor *cu=
rsor,
> > +					size_t bytes)
> > +{
> > +	BUG_ON(bytes > cursor->resid);
> > +	cursor->resid -=3D bytes;
> > +
> > +	if (bytes < cursor->lastlen) {
> > +		cursor->lastlen -=3D bytes;
> > +	} else {
> > +		iov_iter_advance(&cursor->iov_iter, bytes - cursor->lastlen);
> > +		cursor->lastlen =3D 0;
> > +	}
> > +
> > +	return cursor->resid;
> > +}
> > +
> >   /*
> >    * Message data is handled (sent or received) in pieces, where each
> >    * piece resides on a single page.  The network layer might not
> > @@ -991,6 +1054,9 @@ static void __ceph_msg_data_cursor_init(struct cep=
h_msg_data_cursor *cursor)
> >   	case CEPH_MSG_DATA_BVECS:
> >   		ceph_msg_data_bvecs_cursor_init(cursor, length);
> >   		break;
> > +	case CEPH_MSG_DATA_ITER:
> > +		ceph_msg_data_iter_cursor_init(cursor, length);
> > +		break;
> >   	case CEPH_MSG_DATA_NONE:
> >   	default:
> >   		/* BUG(); */
> > @@ -1038,6 +1104,9 @@ struct page *ceph_msg_data_next(struct ceph_msg_d=
ata_cursor *cursor,
> >   	case CEPH_MSG_DATA_BVECS:
> >   		page =3D ceph_msg_data_bvecs_next(cursor, page_offset, length);
> >   		break;
> > +	case CEPH_MSG_DATA_ITER:
> > +		page =3D ceph_msg_data_iter_next(cursor, page_offset, length);
> > +		break;
> >   	case CEPH_MSG_DATA_NONE:
> >   	default:
> >   		page =3D NULL;
> > @@ -1076,6 +1145,9 @@ void ceph_msg_data_advance(struct ceph_msg_data_c=
ursor *cursor, size_t bytes)
> >   	case CEPH_MSG_DATA_BVECS:
> >   		new_piece =3D ceph_msg_data_bvecs_advance(cursor, bytes);
> >   		break;
> > +	case CEPH_MSG_DATA_ITER:
> > +		new_piece =3D ceph_msg_data_iter_advance(cursor, bytes);
> > +		break;
> >   	case CEPH_MSG_DATA_NONE:
> >   	default:
> >   		BUG();
> > @@ -1874,6 +1946,19 @@ void ceph_msg_data_add_bvecs(struct ceph_msg *ms=
g,
> >   }
> >   EXPORT_SYMBOL(ceph_msg_data_add_bvecs);
> >  =20
> > +void ceph_msg_data_add_iter(struct ceph_msg *msg,
> > +			    struct iov_iter *iter)
> > +{
> > +	struct ceph_msg_data *data;
> > +
> > +	data =3D ceph_msg_data_add(msg);
> > +	data->type =3D CEPH_MSG_DATA_ITER;
> > +	data->iter =3D *iter;
> > +
> > +	msg->data_length +=3D iov_iter_count(&data->iter);
> > +}
> > +EXPORT_SYMBOL(ceph_msg_data_add_iter);
> > +
>=20
> Will this be used outside the libceph.ko ? It seem will never ? And also=
=20
> some other existing ones like 'ceph_msg_data_add_bvecs'.
>=20

No, I don't think it will. We can probably remove that.

> >   /*
> >    * construct a new message with given type, size
> >    * the new msg has a ref count of 1.
> > diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> > index 75761537c644..2a7e46524e71 100644
> > --- a/net/ceph/osd_client.c
> > +++ b/net/ceph/osd_client.c
> > @@ -171,6 +171,13 @@ static void ceph_osd_data_bvecs_init(struct ceph_o=
sd_data *osd_data,
> >   	osd_data->num_bvecs =3D num_bvecs;
> >   }
> >  =20
> > +static void ceph_osd_iter_init(struct ceph_osd_data *osd_data,
> > +			       struct iov_iter *iter)
> > +{
> > +	osd_data->type =3D CEPH_OSD_DATA_TYPE_ITER;
> > +	osd_data->iter =3D *iter;
> > +}
> > +
> >   static struct ceph_osd_data *
> >   osd_req_op_raw_data_in(struct ceph_osd_request *osd_req, unsigned int=
 which)
> >   {
> > @@ -264,6 +271,22 @@ void osd_req_op_extent_osd_data_bvec_pos(struct ce=
ph_osd_request *osd_req,
> >   }
> >   EXPORT_SYMBOL(osd_req_op_extent_osd_data_bvec_pos);
> >  =20
> > +/**
> > + * osd_req_op_extent_osd_iter - Set up an operation with an iterator b=
uffer
> > + * @osd_req: The request to set up
> > + * @which: ?
>=20
> For this could you explain more ?
>=20
>=20

Sure. I'll respin and flesh out this comment.

> > + * @iter: The buffer iterator
> > + */
> > +void osd_req_op_extent_osd_iter(struct ceph_osd_request *osd_req,
> > +				unsigned int which, struct iov_iter *iter)
> > +{
> > +	struct ceph_osd_data *osd_data;
> > +
> > +	osd_data =3D osd_req_op_data(osd_req, which, extent, osd_data);
> > +	ceph_osd_iter_init(osd_data, iter);
> > +}
> > +EXPORT_SYMBOL(osd_req_op_extent_osd_iter);
> > +
> >   static void osd_req_op_cls_request_info_pagelist(
> >   			struct ceph_osd_request *osd_req,
> >   			unsigned int which, struct ceph_pagelist *pagelist)
> > @@ -346,6 +369,8 @@ static u64 ceph_osd_data_length(struct ceph_osd_dat=
a *osd_data)
> >   #endif /* CONFIG_BLOCK */
> >   	case CEPH_OSD_DATA_TYPE_BVECS:
> >   		return osd_data->bvec_pos.iter.bi_size;
> > +	case CEPH_OSD_DATA_TYPE_ITER:
> > +		return iov_iter_count(&osd_data->iter);
> >   	default:
> >   		WARN(true, "unrecognized data type %d\n", (int)osd_data->type);
> >   		return 0;
> > @@ -954,6 +979,8 @@ static void ceph_osdc_msg_data_add(struct ceph_msg =
*msg,
> >   #endif
> >   	} else if (osd_data->type =3D=3D CEPH_OSD_DATA_TYPE_BVECS) {
> >   		ceph_msg_data_add_bvecs(msg, &osd_data->bvec_pos);
> > +	} else if (osd_data->type =3D=3D CEPH_OSD_DATA_TYPE_ITER) {
> > +		ceph_msg_data_add_iter(msg, &osd_data->iter);
> >   	} else {
> >   		BUG_ON(osd_data->type !=3D CEPH_OSD_DATA_TYPE_NONE);
> >   	}
>=20

--=20
Jeff Layton <jlayton@kernel.org>
