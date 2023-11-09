Return-Path: <linux-fsdevel+bounces-2622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9F87E71A2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 19:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65387B20AAD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 18:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98BD37143;
	Thu,  9 Nov 2023 18:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="mmSeIQ+U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B5AD275
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 18:40:20 +0000 (UTC)
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083F32D44;
	Thu,  9 Nov 2023 10:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ULD1o8HAQA2e01odwC++rslK041lXV0jsWzE+hlK8Vs=;
	t=1699555220; x=1700764820; b=mmSeIQ+U2o8ntltkPIma6cMqrSMEbufzQMKMR0IcxjhcNb/
	s+lDUZhWEKBUeAdv8azTY/c6CIwt2xzbzUB3sQqR4Yt64XYvEFlGzmp2DZoK8phgv9z36vl9uucwM
	Haz11BppNOs14/6FrRcqe7ZX/w1X6AJm3hjGPYnx5j8itTyuYWj+VGU73040rnHpP7oWfp+AfUCkA
	6kS2kqltcM0f7ayFXEVoyqVw90BbceYI957COpncHblmlMl0q+DHcIYlpGEjG6Tkz4ok7uYJO/XyT
	gSXM67rjvT6qQVMfDeyE7XaCEOqzuMQNQTM99t1cIZGRHTLMnfSOFNnA/BLkwvcQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r19wv-00000001v0g-18Yh;
	Thu, 09 Nov 2023 19:40:17 +0100
Message-ID: <33254d48b38755e924cdae30bffdf5bc9b6bccd1.camel@sipsolutions.net>
Subject: Re: [PATCH] debugfs: only clean up d_fsdata for d_is_reg()
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Nicolai Stange <nicstange@gmail.com>
Date: Thu, 09 Nov 2023 19:40:16 +0100
In-Reply-To: <20231109160639.514a2568f1e7.I64fe5615568e87f9ae2d7fb2ac4e5fa96924cb50@changeid>
References: 
	<20231109160639.514a2568f1e7.I64fe5615568e87f9ae2d7fb2ac4e5fa96924cb50@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2023-11-09 at 16:06 +0100, Johannes Berg wrote:
>=20
> @@ -734,6 +725,11 @@ static void __debugfs_file_removed(struct dentry *de=
ntry)
>  		return;
>  	if (!refcount_dec_and_test(&fsd->active_users))
>  		wait_for_completion(&fsd->active_users_drained);
> +
> +	/* this no longer matters */
> +	dentry->d_fsdata =3D NULL;
>=20

That's not true, and therefore this patch is wrong -
full_proxy_release() still happens later.

Not sure why I didn't see that originally, even in tests.

I'll try again :)

johannes

