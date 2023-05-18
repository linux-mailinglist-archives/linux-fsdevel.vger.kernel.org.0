Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC103707E02
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 12:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjERK0H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 06:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjERK0E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 06:26:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F27D1BD3
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 May 2023 03:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684405520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6xmnqCUmlj/I0BvrHuTlZLbsSYHg9a6q/upj2RAlWxA=;
        b=Jyjwqoe029YaoGYSqOz23CGHAQANcb4CorIfKKdqZAhWpE7ZVXzjZgqPP2E2fi4Uo5HxSO
        OWoOEcO5DGQtszrjF18t01yjxQHOYv7Iqh2lmrHsoHBInlPqBHyT9gGjoUimbCZewj9Ibn
        urHeryIBttAUMehRBntF/dwEp/x5eDc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-MPeGOjAxPPuMyJSDwnIv7g-1; Thu, 18 May 2023 06:25:19 -0400
X-MC-Unique: MPeGOjAxPPuMyJSDwnIv7g-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-3f393bf5546so3767671cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 May 2023 03:25:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684405518; x=1686997518;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6xmnqCUmlj/I0BvrHuTlZLbsSYHg9a6q/upj2RAlWxA=;
        b=MvrzKwad+y9KjdeEy15vUQ/cQfAj6Y/jbtmeywKVFM2Rh9r0yrteAX8m7ky3CYl7oz
         jdNrjXRZdylNudXUo4whbMgNf8vnRFmyq1JC/DtkVablZLsPiJp96AqMCs6JQbySCbA9
         z5LxZOWaJE/1ZRX2ZMozeXzwzpcsY60p9BCr7YXZdFkt5TN2zmkS56GzVHvX5XjJP+Jk
         wq3HNeomIwhW+vpT6vjjgDwLZ5Os2CadFebPl6Nd8AOwhqMHDWn0S1CvHqVZokTbYXWY
         joQt42MBHamHM4yBJ9ePFCiaYzxrMy3IL5IkWJe+sIy49JKGATmdcL3rcOWDoM0lYnfk
         MNKw==
X-Gm-Message-State: AC+VfDyDULVeiPyRcw85J6nmFLLG6m0ofjR4I+G9G5ULp7LliI7IevN0
        7ndUazCNo37IIVKvasrDtMoN3xWHAOUrEhFeQSqlBvSJltE2jK/8Nvb8vm5CI0JVjCHR1LFc3x4
        L/7pPjaljg/VjYku6OclH1qkc6A==
X-Received: by 2002:a05:622a:189e:b0:3f5:99e:d7d4 with SMTP id v30-20020a05622a189e00b003f5099ed7d4mr9488889qtc.1.1684405518582;
        Thu, 18 May 2023 03:25:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5vVUy4XQOlJynE8YysOcW2S/5uZ+qJZq+mNZLAgczr7XKKTu5+UffO+tItf8IX5m/BZmFVTg==
X-Received: by 2002:a05:622a:189e:b0:3f5:99e:d7d4 with SMTP id v30-20020a05622a189e00b003f5099ed7d4mr9488859qtc.1.1684405518248;
        Thu, 18 May 2023 03:25:18 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-239-175.dyn.eolo.it. [146.241.239.175])
        by smtp.gmail.com with ESMTPSA id m7-20020a05620a13a700b00759342c9e77sm311947qki.16.2023.05.18.03.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 03:25:17 -0700 (PDT)
Message-ID: <47caea363e844bf716867c6a128d374cae4a5772.camel@redhat.com>
Subject: Re: [PATCH net-next v7 03/16] net: Add a function to splice pages
 into an skbuff for MSG_SPLICE_PAGES
From:   Paolo Abeni <pabeni@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Date:   Thu, 18 May 2023 12:25:13 +0200
In-Reply-To: <1347187.1684403608@warthog.procyon.org.uk>
References: <93aba6cc363e94a6efe433b3c77ec1b6b54f2919.camel@redhat.com>
         <20230515093345.396978-1-dhowells@redhat.com>
         <20230515093345.396978-4-dhowells@redhat.com>
         <1347187.1684403608@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2023-05-18 at 10:53 +0100, David Howells wrote:
> Paolo Abeni <pabeni@redhat.com> wrote:
>=20
> > Minor nit: please respect the reverse x-mas tree order (there are a few
> > other occurrences around)
>=20
> I hadn't come across that.  Normally I only apply that to the types so th=
at
> the names aren't all over the place.  But whatever.
>=20
> > > +		if (space =3D=3D 0 &&
> > > +		    !skb_can_coalesce(skb, skb_shinfo(skb)->nr_frags,
> > > +				      pages[0], off)) {
> > > +			iov_iter_revert(iter, len);
> > > +			break;
> > > +		}
> >=20
> > It looks like the above condition/checks duplicate what the later
> > skb_append_pagefrags() will perform below. I guess the above chunk
> > could be removed?
>=20
> Good point.  There used to be an allocation between in the case sendpage_=
ok()
> failed and we wanted to copy the data.  I've removed that for the moment.
>=20
> > > +			ret =3D -EIO;
> > > +			if (!sendpage_ok(page))
> > > +				goto out;
> >=20
> > My (limited) understanding is that the current sendpage code assumes
> > that the caller provides/uses pages suitable for such use. The existing
> > sendpage_ok() check is in place as way to try to catch possible code
> > bug - via the WARN_ONCE().
> >=20
> > I think the same could be done here?
>=20
> Yeah.
>=20
> Okay, I made the attached changes to this patch.
>=20
> David
> ---
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 56d629ea2f3d..f4a5b51aed22 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -6923,10 +6923,10 @@ static void skb_splice_csum_page(struct sk_buff *=
skb, struct page *page,
>  ssize_t skb_splice_from_iter(struct sk_buff *skb, struct iov_iter *iter,
>  			     ssize_t maxsize, gfp_t gfp)
>  {
> +	size_t frag_limit =3D READ_ONCE(sysctl_max_skb_frags);
>  	struct page *pages[8], **ppages =3D pages;
> -	unsigned int i;
>  	ssize_t spliced =3D 0, ret =3D 0;
> -	size_t frag_limit =3D READ_ONCE(sysctl_max_skb_frags);
> +	unsigned int i;
> =20
>  	while (iter->count > 0) {
>  		ssize_t space, nr;
> @@ -6946,20 +6946,13 @@ ssize_t skb_splice_from_iter(struct sk_buff *skb,=
 struct iov_iter *iter,
>  			break;
>  		}
> =20
> -		if (space =3D=3D 0 &&
> -		    !skb_can_coalesce(skb, skb_shinfo(skb)->nr_frags,
> -				      pages[0], off)) {
> -			iov_iter_revert(iter, len);
> -			break;
> -		}
> -
>  		i =3D 0;
>  		do {
>  			struct page *page =3D pages[i++];
>  			size_t part =3D min_t(size_t, PAGE_SIZE - off, len);
> =20
>  			ret =3D -EIO;
> -			if (!sendpage_ok(page))
> +			if (WARN_ON_ONCE(!sendpage_ok(page)))

FWIS the current TCP code also has a 'IS_ENABLED(CONFIG_DEBUG_VM) &&'
guard, but I guess the plain WARN_ON_ONCE should be ok.

Side node: we need the whole series alltogether, you need to repost
even the unmodified patches.

Thanks!

Paolo

