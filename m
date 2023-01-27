Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F8E67ED49
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 19:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbjA0SS2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Jan 2023 13:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235053AbjA0SSK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Jan 2023 13:18:10 -0500
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD054D510;
        Fri, 27 Jan 2023 10:17:48 -0800 (PST)
Received: from imladris.home.surriel.com ([10.0.13.28] helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <riel@shelob.surriel.com>)
        id 1pLTHL-0004Bm-1p;
        Fri, 27 Jan 2023 13:16:47 -0500
Message-ID: <77ee6f62f1a10ea4a5e054059ab98a252246a891.camel@surriel.com>
Subject: Re: [PATCH 2/2] ipc,namespace: batch free ipc_namespace structures
From:   Rik van Riel <riel@surriel.com>
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, linux-fsdevel@vger.kernel.org,
        Chris Mason <clm@meta.com>
Date:   Fri, 27 Jan 2023 13:16:46 -0500
In-Reply-To: <878rhome8h.fsf@redhat.com>
References: <20230127011535.1265297-1-riel@surriel.com>
         <20230127011535.1265297-3-riel@surriel.com> <878rhome8h.fsf@redhat.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-4pC1S5nf5hOpBJ/rDJxK"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--=-4pC1S5nf5hOpBJ/rDJxK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2023-01-27 at 12:03 +0100, Giuseppe Scrivano wrote:
> Rik van Riel <riel@surriel.com> writes:
>=20
> >=20
> > +++ b/ipc/namespace.c
> > @@ -145,10 +145,11 @@ void free_ipcs(struct ipc_namespace *ns,
> > struct ipc_ids *ids,
> > =C2=A0
> > =C2=A0static void free_ipc_ns(struct ipc_namespace *ns)
> > =C2=A0{
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* mq_put_mnt() waits for a =
grace period as kern_unmount()
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * uses synchronize_rcu().
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Caller needs to wait for =
an RCU grace period to have
> > passed
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * after making the mount po=
int inaccessible to new
> > accesses.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mq_put_mnt(ns);
>=20
> mq_put_mnt() is not needed anymore, should it be removed?

Yes, indeed. Thank you!

I'll send a v3 of the series :)


--=20
All Rights Reversed.

--=-4pC1S5nf5hOpBJ/rDJxK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmPUFQ4ACgkQznnekoTE
3oMS3Qf/QIkJAZFqDy+nwVMoh/81YM5YJq8wBLaczZ5F89M9gBtzxyoh/uWPd/Qn
qB1UpkwPOc8bX+Ig8frrjVU/gcnwwaBlBMlJDQBRbSF45se3Vq+h6BffRI37jtLo
VMWSfc4d0+P66E1Inr0nqEsU0OneozQNCrTt15bYHVLt04a95p8hdozlvrZ7+sfJ
YXpd4+ob/ToBvhnP1NX9cg80xISMCRmEW6FI25L+8hF2N5Zfdy9Gez2LEDlygjAI
EG1n4XhiPW9Wg42FfpdCc6JACjsetK3MfW/X5DMS1y1tJQnLRFWPtNsPmbjfo0N1
42hZHKlhgPyIbKpXiXYmBMtdYdl2ew==
=ASG8
-----END PGP SIGNATURE-----

--=-4pC1S5nf5hOpBJ/rDJxK--
