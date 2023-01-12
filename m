Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480B6668432
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 21:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240147AbjALUr3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 15:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240221AbjALUq4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 15:46:56 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81E0BC93;
        Thu, 12 Jan 2023 12:15:27 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id az7so19222592wrb.5;
        Thu, 12 Jan 2023 12:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ioOXl34VLzTy8PWkypTLZzOP5yVDq5ecCNgcBHDa6WI=;
        b=BinQEcudtyrVYQorZ1Xc0qlCGaoLXXXhQdR/vg5MAbBfEpSJ7OzjLd8LPJVV2+SLaL
         jPO69xEndO/H6gkGgmIOv3OTL2rcMwfMHGK8HtmCSspux+aaNs7chTkch21ZCfie1DU1
         kJ56l3hRI39NhBVL+nqxR1mwAz+ScjEC0HsuShjgaqYGlgFZuEV9MaFYLe3BjlKAZI11
         k+PzEzHnNgqNsK4BIxEB78evcLVNdIAcjknw+obH1d9GN/uRM2mhba5Qn679OYxqvUML
         vNTV4pJVt2AVLsRsI07VVP4y+mS5LFb+B0f8ZgOPkrRE2o9QXah2TGdihfH6UgoFwtkx
         lgTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ioOXl34VLzTy8PWkypTLZzOP5yVDq5ecCNgcBHDa6WI=;
        b=JSZFyp7hze4QFYE6GN4Vj3fTHNZMZNxiTxcHdYEjX3i2TFWm8jgEny5ohYBcCrPCyM
         jnmkI9Z+Tm6MBsdXDKwxO3fnKH5w/e1JIlmCYull57QhJDsTdOjdSYEaqVwLzi3il3dE
         JKs5DXwAJMLVlFbdfFx9o2O31cIi6Aow8nU/OR60O1HA1SAQJik7kTwcUxVQgjWlCCe8
         J4ReEiCy2DsOY2xee3TQAGPA/mqJvvz3f4wPsUw0fVuTl8RfR6/urITEPNrzUrqSbzud
         yqBV8xVjgV6DtSmq9KBIxFH1RBCyInFoLzibulN+nSeWe4TN4lKYTaZmgOUA9dRfjeT8
         8jeQ==
X-Gm-Message-State: AFqh2koTmeGGHNt+zvKmJphRaSCSkv0YMW5MVuau+EuEsdp/q7thQeCo
        tgCDugD+B31k2oMev8LM31Y=
X-Google-Smtp-Source: AMrXdXtOwUJVLHA0oe5ZBy611e5s1ACzshDGzDZsnGVBwr/7k/njieWmGDzaa5GzFGBOGi6UDX/ZfA==
X-Received: by 2002:a5d:680a:0:b0:2bd:c690:2e66 with SMTP id w10-20020a5d680a000000b002bdc6902e66mr4524671wru.5.1673554526300;
        Thu, 12 Jan 2023 12:15:26 -0800 (PST)
Received: from suse.localnet (host-79-42-161-127.retail.telecomitalia.it. [79.42.161.127])
        by smtp.gmail.com with ESMTPSA id s2-20020adff802000000b00241bd7a7165sm17207728wrp.82.2023.01.12.12.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 12:15:25 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v2 2/4] fs/sysv: Change the signature of dir_get_page()
Date:   Thu, 12 Jan 2023 21:15:24 +0100
Message-ID: <4773794.GXAFRqVoOG@suse>
In-Reply-To: <Y74gRx6jLf2RHgdq@ZenIV>
References: <20230109170639.19757-1-fmdefrancesco@gmail.com>
 <20230109170639.19757-3-fmdefrancesco@gmail.com> <Y74gRx6jLf2RHgdq@ZenIV>
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

On mercoled=EC 11 gennaio 2023 03:34:47 CET Al Viro wrote:
> On Mon, Jan 09, 2023 at 06:06:37PM +0100, Fabio M. De Francesco wrote:
> > -struct sysv_dir_entry * sysv_dotdot (struct inode *dir, struct page **=
p)
> > +struct sysv_dir_entry *sysv_dotdot(struct inode *dir, struct page **p)
> >=20
> >  {
> >=20
> > -	struct page *page =3D dir_get_page(dir, 0);
> > -	struct sysv_dir_entry *de =3D NULL;
> > +	struct page *page =3D NULL;
> > +	struct sysv_dir_entry *de =3D dir_get_page(dir, 0, &page);
> >=20
> > -	if (!IS_ERR(page)) {
> > -		de =3D (struct sysv_dir_entry*) page_address(page) + 1;
> > +	if (!IS_ERR(de)) {
> >=20
> >  		*p =3D page;
> >=20
> > +		return (struct sysv_dir_entry *)page_address(page) + 1;
> >=20
> >  	}
> >=20
> > -	return de;
> > +	return NULL;
> >=20
> >  }
>=20
> Would be better off with
>=20
> 	struct sysv_dir_entry *de =3D dir_get_page(dir, 0, p);
>=20
> 	if (!IS_ERR(de))
> 		return de + 1;	// ".." is the second directory entry
> 	return NULL;
>=20
> IMO...

I totally agree with you...

1) This comment is a good way to explain why we return "de + 1".
2) "*p =3D page" is redundant, so it's not necessary because we assign the =
out=20
argument in dir_get_page() if and only if read_mapping_page() doesn't fail.

I will send v3 asap.

Thanks for your suggestions.

=46abio



