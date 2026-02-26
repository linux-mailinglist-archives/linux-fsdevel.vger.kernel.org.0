Return-Path: <linux-fsdevel+bounces-78593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOAkHYuBoGn6kQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 18:23:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B8B1AC462
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 18:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A574B3223017
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 16:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B3643637A;
	Thu, 26 Feb 2026 16:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="GUiYnQYn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493E2334C14;
	Thu, 26 Feb 2026 16:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772122656; cv=none; b=eYQR18UfaAyKTr+X1GQjblykQNz/yaJEgXDWlqTG660y2tLEbSZhMgRon41p+wqAt1NcjxFwPGI1/Ua939RqV9myH8IRP2rlwnBIXnVKrvEYrdRBLp2tr5PzeyVy6rh9X/ldpT8DvqdxgnsY8EpDoG4k043irVeWifNGNdsb/OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772122656; c=relaxed/simple;
	bh=nBmLPdp9zs/2AXPEHn/NG3O34E5FiOQ8cJEuKJobRQI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K/FQHXmgulnLZHKLrexB9bjoXU4MZvih8lPqsZH65PTHqLJezjdYI4v1BRHAn60FfY3RKrbBck7WotwrZCaThx9qjnXkSexJkyIE0U2sdCDTI4RCjQRe2PSXJyQ7G5VuL/BZ5q7eZKWwrxIGRAYFJ2GylJlKMTgb/9pRnguz3YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=GUiYnQYn; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=u6AgP5pipvVOWL4qpnGMAGPV/x86TFzUGqkGo+lbCYg=; b=GUiYnQYnchESiKW/9JHU49cCAT
	unzqYqvuJZ8VcVeSoBIshCxOWeMvmu0F5bQjx5e42Dju7B86Xs4PckgUjOOqfnHDG0V7WQCV/f+mj
	6ucIoLwJSMIFP8JCKKXT9Vq6W5yndk/MdByuk1OnrMQ/qrPNsCUwx3EcFz4SLE4nNpUeDdsPvbP7i
	TvUrd2cYM9VpqJ3iyMTw2Uc2uiRHO10qdo1M4uFEiv4GPMsCRSHfCnYNMfDqjTfMIN7pcUFzrKIls
	6w7S8ZqWCOkN2sAHtU/6nZop+j4HPnoYCU5+wm6AKrzFEX1UsdQPZ96MY0Gyh1GPhtgi9nlLJRvfM
	4PUgAhLw==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vve3E-005kkK-NF; Thu, 26 Feb 2026 17:17:20 +0100
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
In-Reply-To: <CAJfpegvb61zh6ErJ0Hs9wRdLVmeBMOLrJKUyBMiQcpQoxXGPOA@mail.gmail.com>
	(Miklos Szeredi's message of "Thu, 26 Feb 2026 16:44:45 +0100")
References: <20260225112439.27276-1-luis@igalia.com>
	<20260225112439.27276-7-luis@igalia.com>
	<CAOQ4uxgvgRwfrHX3OMJ-Fvs2FXcp7d7bexrvx0acsy3t3gxv5w@mail.gmail.com>
	<87zf4v7rte.fsf@wotan.olymp>
	<CAOQ4uxj-uVBvLQZxpsfNC+AR8+kFGUDEV6tOzH76AC0KU_g7Hg@mail.gmail.com>
	<CAJfpegspUg_e9W7k5W7+eJxJscvtiCq5Hvt6CTDVCbijqP0HyA@mail.gmail.com>
	<87fr6n7ddg.fsf@wotan.olymp>
	<CAJfpegvb61zh6ErJ0Hs9wRdLVmeBMOLrJKUyBMiQcpQoxXGPOA@mail.gmail.com>
Date: Thu, 26 Feb 2026 16:17:20 +0000
Message-ID: <87bjhb7a3z.fsf@wotan.olymp>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78593-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[gmail.com,ddn.com,bsbernd.com,kernel.org,vger.kernel.org,jumptrading.com,igalia.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luis@igalia.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[igalia.com:-];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,igalia.com:email,wotan.olymp:mid]
X-Rspamd-Queue-Id: 08B8B1AC462
X-Rspamd-Action: no action

On Thu, Feb 26 2026, Miklos Szeredi wrote:

> On Thu, 26 Feb 2026 at 16:07, Luis Henriques <luis@igalia.com> wrote:
>
>> Are you saying that outargs should also use extensions for getting the
>> file handle in a lookup_handle?
>
> No.
>
> I'm saying that extend_arg() thing is messy and a using vectored args
> for extensions (same as we do for normal input arguments) might be
> better.

It is indeed a messy interface.  I'll have a look into it and see how to
modify it to accommodate your suggestion.  And thanks for your patience ;-)

Cheers,
--=20
Lu=C3=ADs

