Return-Path: <linux-fsdevel+bounces-78520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEs7L4NioGk0jAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 16:10:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C8D1A84A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 16:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 90C8130A02C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 15:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2560D3C199F;
	Thu, 26 Feb 2026 15:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Mfn1hrHG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1759C313546;
	Thu, 26 Feb 2026 15:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772118440; cv=none; b=Q7rF6bHz+xwBDajs/8jZtVd1kWsUhRKNNNn49y8Z1g3qDwf95XHQci8G2xVWtEzoW1vWEabicxVxJoJNu7plCSgblOgy9OqXr6T5rS9gt20CLFFnRHJ0aw3D/BAPiTaPopJk30LNIKdddhejtTwRrIOrXpbTUiuFwbgC4zC/wJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772118440; c=relaxed/simple;
	bh=o/4xltha1jxOlXukHYJTieLTzZdF6ef3l836NJoVbes=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EOgxayJLhBTj4Eox4/+mE5CXv0ztJkghdQ6klGxwStpb7Y7j2nal3Dj2eZvU+PTLZZ0lB1kHReV/FMmI4oCKZmFGGrM5ZWbxyCqQbZfDTVt0eHiwrQRnPqH0X68QwZSEngbDzX+UrP/Nd76Pu/Ez6VLFuD9M27xEJcEYDe1Cvvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Mfn1hrHG; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=XTv4xfQ192B0SmuHRteHD40H6b8pM1j6mC75DTcCkv8=; b=Mfn1hrHGj9UMGHExnxV0wbx/5y
	SmiN+vkvLsNsLCZgBxC3K51H0PqFdQlVmJgkuj93fguUKT7vF0FQ5GbF/FYjmfjCUsuWu0cHu7Mcl
	Vqeoz20AVaGPH6k0MEgGtw1yJfX7ZoXoxfrO7L/cocZPOtanePDtFYp14Lh2HtoofP+7I/khLtzFl
	ZrccrtthAxho/O+opZRFthBzuPNFfCVznRSIrEYORw6SGoILVaeLNFNquuysrbspL+6vpDI3g0OC0
	zfR3iPYqiZntMkop0EyS9vkWnKCXREXKfJtJBOxTD7nla3kce4xCzla1LoXiI7wpoKDCENNNelpXO
	JsN6TdGQ==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vvcx7-005j0y-EU; Thu, 26 Feb 2026 16:06:57 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>,  Bernd Schubert
 <bschubert@ddn.com>,  Bernd Schubert <bernd@bsbernd.com>,  "Darrick J.
 Wong" <djwong@kernel.org>,  Horst Birthelmer <hbirthelmer@ddn.com>,
  Joanne Koong <joannelkoong@gmail.com>,  Kevin Chen <kchen@ddn.com>,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,  Matt
 Harvey <mharvey@jumptrading.com>,  kernel-dev@igalia.com
Subject: Re: [RFC PATCH v3 6/8] fuse: implementation of lookup_handle+statx
 compound operation
In-Reply-To: <CAJfpegspUg_e9W7k5W7+eJxJscvtiCq5Hvt6CTDVCbijqP0HyA@mail.gmail.com>
	(Miklos Szeredi's message of "Thu, 26 Feb 2026 11:29:42 +0100")
References: <20260225112439.27276-1-luis@igalia.com>
	<20260225112439.27276-7-luis@igalia.com>
	<CAOQ4uxgvgRwfrHX3OMJ-Fvs2FXcp7d7bexrvx0acsy3t3gxv5w@mail.gmail.com>
	<87zf4v7rte.fsf@wotan.olymp>
	<CAOQ4uxj-uVBvLQZxpsfNC+AR8+kFGUDEV6tOzH76AC0KU_g7Hg@mail.gmail.com>
	<CAJfpegspUg_e9W7k5W7+eJxJscvtiCq5Hvt6CTDVCbijqP0HyA@mail.gmail.com>
Date: Thu, 26 Feb 2026 15:06:51 +0000
Message-ID: <87fr6n7ddg.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78520-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[gmail.com,ddn.com,bsbernd.com,kernel.org,vger.kernel.org,jumptrading.com,igalia.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	FROM_NEQ_ENVFROM(0.00)[luis@igalia.com,linux-fsdevel@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,wotan.olymp:mid]
X-Rspamd-Queue-Id: 47C8D1A84A0
X-Rspamd-Action: no action

On Thu, Feb 26 2026, Miklos Szeredi wrote:

> On Thu, 26 Feb 2026 at 11:08, Amir Goldstein <amir73il@gmail.com> wrote:
>
>> file handle on stack only makes sense for small pre allocated size.
>> If the server has full control over handle size, then that is not releva=
nt.
>
> I thought the point was that the file handle is available in
> fi->handle and doesn't need to be allocated/copied.   Instead
> extensions could be done with an argument vector, like this:

Right now the code is using extensions in the lookup_handle operation
inargs, and only if a file handle is available for the parent inode.

Are you saying that outargs should also use extensions for getting the
file handle in a lookup_handle?

Cheers,
--=20
Lu=C3=ADs

> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -326,6 +326,12 @@ struct fuse_folio_desc {
>         unsigned int offset;
>  };
>
> +struct fuse_ext_arg {
> +       u32 type;
> +       u32 size;
> +       const void *value;
> +};
> +
>  struct fuse_args {
>         uint64_t nodeid;
>         uint32_t opcode;
> @@ -346,6 +352,7 @@ struct fuse_args {
>         bool is_pinned:1;
>         bool invalidate_vmap:1;
>         struct fuse_in_arg in_args[4];
> +       struct fuse_ext_arg ext_args[2];
>         struct fuse_arg out_args[2];
>         void (*end)(struct fuse_mount *fm, struct fuse_args *args, int er=
ror);
>         /* Used for kvec iter backed by vmalloc address */
>
> Thanks,
> Miklos


