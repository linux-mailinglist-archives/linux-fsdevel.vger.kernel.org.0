Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A09780EFE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 17:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378093AbjHRPUm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 11:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378111AbjHRPUX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:20:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A559E3C31
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 08:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692371978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4OGLm1Ji2zPIND+DM8hgK8fLQyP0EOw8FXAzm3TjU6k=;
        b=XJ5sMuOktrgcwQsbB/jBanxfK+G45usxMd8D+i4tKVI+TJ2fajmXu3fCECQAUy+7+vb1zY
        vPJqAASCnCSd4X3whq+hT7oNyNk4JCufJKvgSZajKN8h4Zcota0CCMWRUTSkqFZ+nrLzAc
        LODFGRRHSf0vEN0e3CY8IDe78fF3eFg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-111-_dky-kfcO7yXblC5erPVLw-1; Fri, 18 Aug 2023 11:19:34 -0400
X-MC-Unique: _dky-kfcO7yXblC5erPVLw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B100A80006E;
        Fri, 18 Aug 2023 15:19:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DE7B440D2843;
        Fri, 18 Aug 2023 15:19:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wi4wNm-2OjjhFEqm21xTNTvksmb5N4794isjkp9+FzngA@mail.gmail.com>
References: <CAHk-=wi4wNm-2OjjhFEqm21xTNTvksmb5N4794isjkp9+FzngA@mail.gmail.com> <03730b50cebb4a349ad8667373bb8127@AcuMS.aculab.com> <20230816120741.534415-1-dhowells@redhat.com> <20230816120741.534415-3-dhowells@redhat.com> <608853.1692190847@warthog.procyon.org.uk> <3dabec5643b24534a1c1c51894798047@AcuMS.aculab.com> <CAHk-=wjFrVp6srTBsMKV8LBjCEO0bRDYXm-KYrq7oRk0TGr6HA@mail.gmail.com> <665724.1692218114@warthog.procyon.org.uk> <CAHk-=wg8G7teERgR7ExNUjHj0yx3dNRopjefnN3zOWWvYADXCw@mail.gmail.com> <d0232378a64a46659507e5c00d0c6599@AcuMS.aculab.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, David Laight <David.Laight@aculab.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@list.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iov_iter: Don't deal with iter->copy_mc in memcpy_from_iter_mc()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 18 Aug 2023 16:19:31 +0100
Message-ID: <2058762.1692371971@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> > Although I'm not sure the bit-fields really help.
> > There are 8 bytes at the start of the structure, might as well
> > use them :-)
>=20
> Actually=C3=A7 I wrote the patch that way because it seems to improve code
> generation.
>=20
> The bitfields are generally all set together as just plain one-time
> constants at initialization time, and gcc sees that it's a full byte
> write. And the reason 'data_source' is not a bitfield is that it's not
> a constant at iov_iter init time (it's an argument to all the init
> functions), so having that one as a separate byte at init time is good
> for code generation when you don't need to mask bits or anything like
> that.
>=20
> And once initialized, having things be dense and doing all the
> compares with a bitwise 'and' instead of doing them as some value
> compare again tends to generate good code.

Actually...  I said that switch(enum) seemed to generate suboptimal code...
However, if the enum is renumbered such that the constants are in the same
order as in the switch() it generates better code.

So we want this order:

	enum iter_type {
		ITER_UBUF,
		ITER_IOVEC,
		ITER_BVEC,
		ITER_KVEC,
		ITER_XARRAY,
		ITER_DISCARD,
	};

to match:

	switch (iov_iter_type(iter)) {
	case ITER_UBUF:
		progress =3D iterate_ubuf(iter, len, priv, priv2, ustep);
		break;
	case ITER_IOVEC:
		progress =3D iterate_iovec(iter, len, priv, priv2, ustep);
		break;
	case ITER_BVEC:
		progress =3D iterate_bvec(iter, len, priv, priv2, step);
		break;
	case ITER_KVEC:
		progress =3D iterate_kvec(iter, len, priv, priv2, step);
		break;
	case ITER_XARRAY:
		progress =3D iterate_xarray(iter, len, priv, priv2, step);
		break;
	case ITER_DISCARD:
	default:
		progress =3D len;
		break;
	}

then gcc should be able to generate a ternary tree, which it does here:

	<+77>:	mov    (%rdx),%al
	<+79>:	cmp    $0x2,%al
	<+81>:	je     0xffffffff81779bcc <_copy_from_iter+394>
	<+87>:	ja     0xffffffff81779aa9 <_copy_from_iter+103>

though it really split the number space in the wrong place.  It can then use
one CMP (or TEST) to split again:

	<+89>:	test   %al,%al
	<+91>:	mov    0x8(%rdx),%rdx
	<+95>:	jne    0xffffffff81779b48 <_copy_from_iter+262>
	<+101>:	jmp    0xffffffff81779b17 <_copy_from_iter+213>

It then should only require one CMP at this point, since AL can only be 4, 5
or 6+:

	<+103>:	cmp    $0x3,%al
	<+105>:	je     0xffffffff81779c6e <_copy_from_iter+556>
	<+111>:	cmp    $0x4,%al
	<+113>:	jne    0xffffffff81779dd2 <_copy_from_iter+912>

The end result being that it should have at most two CMP instructions for a=
ny
number in the range 0 to 5 - though in this case, it will have three for AL=
>3.

However, it doesn't do this with if-if-if with a number sequence or a bitma=
sk,
but rather generates an chain of cmp-cmp-cmp or test-test-test, presumably
because it fails to spot the if-conditions are related.

I should log a gcc bug on this on the poor switch() behaviour.

Also, if we renumber the enum to put UBUF and IOVEC first, we can get rid of
iter->user_backed in favour of:

	static inline bool user_backed_iter(const struct iov_iter *i)
	{
		return iter_is_ubuf(i) || iter_is_iovec(i);
	}

which gcc just changes into something like a "CMP $1" and a "JA".


Comparing Linus's bit patch (+ is better) to renumbering the switch (- is
better):

__iov_iter_get_pages_alloc               inc 0x32a -> 0x331 +0x7
_copy_from_iter                          dcr 0x3c7 -> 0x3bf -0x8
_copy_from_iter_flushcache               inc 0x364 -> 0x370 +0xc
_copy_from_iter_nocache                  inc 0x33e -> 0x347 +0x9
_copy_mc_to_iter                         dcr 0x3bc -> 0x3b6 -0x6
_copy_to_iter                            inc 0x34a -> 0x34b +0x1
copy_page_from_iter_atomic.part.0        dcr 0x424 -> 0x41c -0x8
copy_page_to_iter_nofault.part.0         dcr 0x3a9 -> 0x3a5 -0x4
csum_and_copy_from_iter                  inc 0x3e5 -> 0x3e8 +0x3
csum_and_copy_to_iter                    dcr 0x449 -> 0x448 -0x1
dup_iter                                 inc 0x34 -> 0x37 +0x3
fault_in_iov_iter_readable               dcr 0x9c -> 0x9a -0x2
fault_in_iov_iter_writeable              dcr 0x9c -> 0x9a -0x2
iov_iter_advance                         dcr 0xde -> 0xd8 -0x6
iov_iter_alignment                       inc 0xe0 -> 0xe3 +0x3
iov_iter_extract_pages                   inc 0x416 -> 0x418 +0x2
iov_iter_gap_alignment                   dcr 0x69 -> 0x67 -0x2
iov_iter_init                            inc 0x27 -> 0x31 +0xa
iov_iter_is_aligned                      dcr 0x104 -> 0xf5 -0xf
iov_iter_npages                          inc 0x119 -> 0x11d +0x4
iov_iter_revert                          dcr 0x93 -> 0x86 -0xd
iov_iter_single_seg_count                dcr 0x41 -> 0x3c -0x5
iov_iter_ubuf                            inc 0x39 -> 0x3a +0x1
iov_iter_zero                            dcr 0x338 -> 0x32e -0xa
memcpy_from_iter_mc                      inc 0x2a -> 0x2b +0x1

I think there may be more savings to be made if I go and convert more of the
functions to using switch().

David

