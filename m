Return-Path: <linux-fsdevel+bounces-44195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E9FA64C81
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 12:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFED23AFABA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 11:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCF823770D;
	Mon, 17 Mar 2025 11:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TkCrpq6X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ABD237179
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Mar 2025 11:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742210869; cv=none; b=AbTo5YEZlkcpcyuXU/rl/hXOcXYhu8sbb+kfNf5t49KiZfBv0/Vz+33OMS18iXA/O5vPSMybdPHGJy8Sp5/vIc8y4OJJV322Y3PP0tkevGwnevTjMiAHQlbnvtNt67CbvuvN2oABbC+twMxGiS72o1I1a0+F9tAAg3Z6dyPQSIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742210869; c=relaxed/simple;
	bh=Qmdw44/Y9/OgfNp31AlBCDtokgDg/kGkmfVHIvL4bZM=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=gUkmKvh6bDbNsFYWxHw1p2iIQZ6wkBh4wtUcuLnBYpHrz9tREuT/e/BAyg/usirscqIgLQCzYkyEx9ta9uhj2n7fyd2KXm5S7Qhuj0l0CMArWXjxec+pyA4Cqa4y0ry1ZZIuD9rgl9zMR7+USwDb0KAbIMZaQRUhwUpOyjQBCpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TkCrpq6X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742210866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pmb1M6YuJLZPZhb6X3kxk0iHal+/a9cYjzs9Ehglbdg=;
	b=TkCrpq6XrRZMDtCY2CWNZbP8YgiQio8bWJruF1vE+HYRUYs/wS1XpH7QhmMN2Yl7eg7HUa
	+LLkw5lUqMocJYjGN04FogpdZ/pZ9i4gBVxFJww3NqoqHmWQ+VUuOjKsCb4GCrKVLByzkM
	x6Jz5OUiN2//n+Hz0rsGNYuniqI4NNo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-u8BecNH2NaG6uI5h4Zt1Sg-1; Mon,
 17 Mar 2025 07:27:43 -0400
X-MC-Unique: u8BecNH2NaG6uI5h4Zt1Sg-1
X-Mimecast-MFC-AGG-ID: u8BecNH2NaG6uI5h4Zt1Sg_1742210862
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A4D221956087;
	Mon, 17 Mar 2025 11:27:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.61])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5E9371955BE1;
	Mon, 17 Mar 2025 11:27:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1bab7ad752df6f2fa953fbf8eed8370e10344ff7.camel@ibm.com>
References: <1bab7ad752df6f2fa953fbf8eed8370e10344ff7.camel@ibm.com> <20250313233341.1675324-1-dhowells@redhat.com> <20250313233341.1675324-4-dhowells@redhat.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: dhowells@redhat.com, Alex Markuze <amarkuze@redhat.com>,
    "slava@dubeyko.com" <slava@dubeyko.com>,
    "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
    "idryomov@gmail.com" <idryomov@gmail.com>,
    "jlayton@kernel.org" <jlayton@kernel.org>,
    "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
    "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
    "dongsheng.yang@easystack.cn" <dongsheng.yang@easystack.cn>,
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 03/35] libceph: Add a new data container type, ceph_databuf
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2160749.1742210857.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Mar 2025 11:27:37 +0000
Message-ID: <2160750.1742210857@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Viacheslav Dubeyko <Slava.Dubeyko@ibm.com> wrote:

> > +struct ceph_databuf {
> > +	struct bio_vec	*bvec;		/* List of pages */
> =

> So, maybe we need to think about folios now?

Yeah, I know...  but struct bio_vec has a page pointer and may point to
non-folio type pages.  This stuff is still undergoing evolution as Willy w=
orks
on reducing struct page.

What I'm pondering is changing struct folio_queue to take a list of { foli=
o,
offset, len } rather than using a folio_batch with a simple list of folios=
.
It doesn't necessarily help with DIO, though, but there we're given an
iterator we're required to use.

One of the things I'd like to look at for ceph as well is using the page f=
rag
allocator[*] to get small pieces of memory for stashing protocol data in
rather than allocating full-page buffers.

[*] Memory allocated from the page frag allocator can be used with
MSG_SPLICE_PAGES as its lifetime is controlled by the refcount.  Now, we c=
ould
probably have a page frag allocator that uses folios rather than non-folio
pages for network filesystem use.  That could be of use to afs and cifs al=
so.

As I mentioned, in a previous reply, how to better integrate folioq/bvec i=
s
hopefully up for discussion at LSF/MM next week.

> > +static inline void ceph_databuf_append_page(struct ceph_databuf *dbuf=
,
> > +					    struct page *page,
> > +					    unsigned int offset,
> > +					    unsigned int len)
> > +{
> > +	BUG_ON(dbuf->nr_bvec >=3D dbuf->max_bvec);
> > +	bvec_set_page(&dbuf->bvec[dbuf->nr_bvec++], page, len, offset);
> > +	dbuf->iter.count +=3D len;
> > +	dbuf->iter.nr_segs++;
> =

> Why do we assign len to dbuf->iter.count but only increment
> dbuf->iter.nr_segs?

Um, because it doesn't?  It adds len to dbuf->iter.count.

> >  enum ceph_msg_data_type {
> >  	CEPH_MSG_DATA_NONE,	/* message contains no data payload */
> > +	CEPH_MSG_DATA_DATABUF,	/* data source/destination is a data buffer *=
/
> >  	CEPH_MSG_DATA_PAGES,	/* data source/destination is a page array */
> >  	CEPH_MSG_DATA_PAGELIST,	/* data source/destination is a pagelist */
> =

> So, the final replacement on databuf will be in the future?

The result of each patch has to compile and work, right?  But yes, various=
 of
the patches in this series reduce the use of those other data types.  I ha=
ve
patches in progress to finally remove PAGES and PAGELIST, but they're not
quite compiling yet.

> > +	dbuf =3D kzalloc(sizeof(*dbuf), gfp);
> > +	if (!dbuf)
> > +		return NULL;
> =

> I am guessing... Should we return error code here?

The only error this function can return is ENOMEM, so it just returns NULL
like many other alloc functions.

> > +	} else if (min_bvec) {
> > +		min_bvec =3D umax(min_bvec, 16);
> =

> Why 16 here? Maybe, do we need to introduce some well explained constant=
?

Fair point.

> > +		dbuf->max_bvec =3D min_bvec;
> =

> Why do we assign min_bvec to max_bvec? I am simply slightly confused why
> argument of function is named as min_bvec, but finally we are saving min=
_bvec
> value into max_bvec.

The 'min_bvec' argument is the minimum number of bvecs that the caller nee=
ds
to be allocated.  This may get rounded up to include all of the piece of
memory we're going to be given by the slab.

'dbuf->max_bvec' is the maximum number of entries that can be used in
dbuf->bvec[] and is a property of the databuf object.

> > +struct ceph_databuf *ceph_databuf_get(struct ceph_databuf *dbuf)
> =

> I see the point here. But do we really need to return pointer? Why not s=
imply:
> =

> void ceph_databuf_get(struct ceph_databuf *dbuf)

It means I can do:

	foo->databuf =3D ceph_databuf_get(dbuf);

rather than:

	ceph_databuf_get(dbuf);
	foo->databuf =3D dbuf;

> > +static int ceph_databuf_expand(struct ceph_databuf *dbuf, size_t req_=
bvec,
> > +			       gfp_t gfp)
> > +{
> > +	struct bio_vec *bvec =3D dbuf->bvec, *old =3D bvec;
> =

> I think that assigning (*old =3D bvec) looks confusing if we keep it on =
the same
> line as bvec declaration and initialization. Why do not declare and not
> initialize it on the next line?
> =

> > +	size_t size, max_bvec, off =3D dbuf->iter.bvec - old;
> =

> I think it's too much declarations on the same line. Why not:
> =

> size_t size, max_bvec;
> size_t off =3D dbuf->iter.bvec - old;

A matter of personal preference, I guess.

> > +	bvec =3D dbuf->bvec;
> > +	while (dbuf->nr_bvec < req_bvec) {
> > +		struct page *pages[16];
> =

> Why do we hardcoded 16 here but using some well defined constant?

Because this is only about stack usage.  alloc_pages_bulk() gets an straig=
ht
array of page*; we have a bvec[], so we need an intermediate.  Now, I coul=
d
actually just overlay the array over the tail of the bvec[] and do a singl=
e
bulk allocation since sizeof(struct page*) > sizeof(struct bio_vec).

> And, again, why not folio?

I don't think there's a bulk folio allocator.  Quite possibly there *shoul=
d*
be so that readahead can use it - one that allocates different sizes of fo=
lios
to fill the space required.

> > +		size_t want =3D min(req_bvec, ARRAY_SIZE(pages)), got;
> > +
> > +		memset(pages, 0, sizeof(pages));
> > +		got =3D alloc_pages_bulk(gfp, want, pages);
> > +		if (!got)
> > +			return -ENOMEM;
> > +		for (i =3D 0; i < got; i++)
> =

> Why do we use size_t for i and got? Why not int, for example?

alloc_pages_bulk() doesn't return an int.  Now, one could legitimately arg=
ue
that I should use "unsigned long" rather than "size_t", but I wouldn't use=
 int
here.  int is smaller and signed.  Granted, it's unlikely we'll be asked >=
2G
pages, but if we're going to assign it down to an int, it probably needs t=
o be
checked first.

> > +			bvec_set_page(&bvec[dbuf->nr_bvec + i], pages[i],
> > +				      PAGE_SIZE, 0);
> > +		dbuf->iter.nr_segs +=3D got;
> > +		dbuf->nr_bvec +=3D got;
> =

> If I understood correctly, the ceph_databuf_append_page() uses slightly
> different logic.

Can you elaborate?

> +	dbuf->iter.count +=3D len;
> +	dbuf->iter.nr_segs++;
> =

> But here we assign number of allocated pages to nr_segs. It is slightly
> confusing. I think I am missing something here.

Um - it's an incremement?

I think part of the problem might be that we're mixing two things within t=
he
same container: Partial pages that get kmapped and accessed directly
(e.g. protocol bits) and pages that get accessed indirectly (e.g. data
buffers).  Maybe this needs to be made more explicit in the API.

David


