Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4274B678279
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 18:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbjAWRDR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 12:03:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbjAWRDN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:03:13 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043525BA6;
        Mon, 23 Jan 2023 09:03:10 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d14so7768503wrr.9;
        Mon, 23 Jan 2023 09:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmcGCovKWoRqq2F+VMSTIsRo9UCMjhopg+3ZEUt6f+o=;
        b=Xslrww+a6Bq/rwpmnp23G4Kmxfor9N/l8wMFYT0fzUsINj7EY+xGRqSD5O385LejIt
         7EvpAqXaRjDpzlHp/W1xb7Va5Dy+r9W39IYHAfBb7xueSjCDVyutHOMnRqqOEor8Xs3E
         7+7sc1y9HdftNpG3XJXw+IkHNmGPw7T/Lww/1LN44uS7h13zwQiUbYHw/2AZRxwwY93y
         PT5o/vlUaSxJmHEAJJfKoCx+G6btAO2QVZfMfvdf6qRDA83otU3qskK3k0LGkEgzuIoz
         g7dRBoh6t/0Xu/hNSB2waNMH//dQcNupsvqxxrYIq3hJRPZupnpi61ix/zZYg+zosTCL
         JuKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kmcGCovKWoRqq2F+VMSTIsRo9UCMjhopg+3ZEUt6f+o=;
        b=yN0GhOYjwKkK84e5zhlkcNqYLc25fGn6P5/8EoNisKM8gtwBy6bHE/pfcNCFKucHYq
         kDjWLAMs1JnK8bJcMyXbNQx5EPaHsBv24e3vg3RZE+rx+leNAXZ+wGrf3kL+9A6W+jCr
         YA+eW+KzV9x4Kc34V+po7tjdBXlzlxnobBvc28JRnYDmIqo2TPAncCPfWv37WHdSQAsV
         G1Jjwoct5pDz0GRBiQZf9EIThiq0ZoIuptvfI6WOh/Y8xa3wUdxNvnhxBZUZQZK+4g+3
         Y1ixpN/Z2PimWFt0BbZNIJT+G2VbgqTxqdpsnzTd+5NrNpQ/zjy1hAPaf+FQ46mx7B63
         VKNg==
X-Gm-Message-State: AFqh2koP8CCW/54Z2VPhPkAo0QzcYt5jSSugbzQDTKeoA9XEuAQKvcDT
        qufHWYs9xuM50z7Q0Q46Tw4=
X-Google-Smtp-Source: AMrXdXuVHAJezatpBfF+fVqJMb8rHsWkwqgEPHi2zWDR8IEDhZ+sROe1uba+noVQXnsJQoRiqDbTsQ==
X-Received: by 2002:adf:fc83:0:b0:2bd:dbf7:1db5 with SMTP id g3-20020adffc83000000b002bddbf71db5mr18714920wrr.31.1674493389243;
        Mon, 23 Jan 2023 09:03:09 -0800 (PST)
Received: from suse.localnet (host-79-36-37-176.retail.telecomitalia.it. [79.36.37.176])
        by smtp.gmail.com with ESMTPSA id c24-20020adfa318000000b002366e3f1497sm5641744wrb.6.2023.01.23.09.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 09:03:08 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v3 4/4] fs/sysv: Replace kmap() with kmap_local_page()
Date:   Mon, 23 Jan 2023 18:03:07 +0100
Message-ID: <8172994.T7Z3S40VBb@suse>
In-Reply-To: <Y8oWsiNWSXlDNn5i@ZenIV>
References: <20230119153232.29750-1-fmdefrancesco@gmail.com>
 <20230119153232.29750-5-fmdefrancesco@gmail.com> <Y8oWsiNWSXlDNn5i@ZenIV>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 19, 2023 at 04:32:32PM +0100, Fabio M. De Francesco wrote:
> @@ -228,6 +239,12 @@ int sysv_delete_entry(struct sysv_dir_entry *de, str=
uct=20
page *page)
> {
> struct inode *inode =3D page->mapping->host;
> loff_t pos =3D page_offset(page) + offset_in_page(de);
> +       /*
> +        * The "de" dentry points somewhere in the same page whose we nee=
d=20
the
> +        * address of; therefore, we can simply get the base address "kad=
dr"=20
by
> +        * masking the previous with PAGE_MASK.
> +        */
> +       char *kaddr =3D (char *)((unsigned long)de & PAGE_MASK);

er...  ITYM "therefore we can pass de to dir_put_page() and get rid of that=
=20
kaddr
thing"...

Anyway, with that change the series rebased and applied on top of Christoph=
's=20
sysv
patch.

On venerd=EC 20 gennaio 2023 05:21:06 CET Al Viro wrote:
> On Thu, Jan 19, 2023 at 04:32:32PM +0100, Fabio M. De Francesco wrote:
> > -inline void dir_put_page(struct page *page)
> > +inline void dir_put_page(struct page *page, void *page_addr)
> >=20
> >  {
> >=20
> > -	kunmap(page);
> > +	kunmap_local(page_addr);
>=20
> ... and that needed to be fixed - at some point "round down to beginning =
of
> page" got lost in rebasing...

Sorry for this late reply.
Unfortunately, at the moment, I have too little free time for kernel=20
development.

@Al...

I merged the two messages from you because they are related to changes to t=
he=20
same patch. I would like to know if I am interpreting both correctly or not.

=46rom your posts it sounds like you're saying you made the necessary chang=
es=20
and then applied this series on top of Christoph's latest patch to fs/sysv,=
 so=20
don't expect me to push a new version.

Did I understand correctly or am I missing something?
Anyway, if my interpretation is correct, thank you very much.

Can you please confirm that I understood correctly or not?

Thank you,

=46abio


