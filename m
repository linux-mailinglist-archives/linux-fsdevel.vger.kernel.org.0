Return-Path: <linux-fsdevel+bounces-75780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mK1VAJpEemkM5AEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 18:17:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A96FFA6B14
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 18:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1E3E30117B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 17:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1346E3321D4;
	Wed, 28 Jan 2026 17:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ViuoqMBM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rRgZcidK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E441F31DD97
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 17:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769620625; cv=pass; b=mfVlKqco1LMc66TLxvyk/yeVq9S6dP1QHBVGzf84IMZDNY4PT7FZA9x/2Av9vwKpu4mFwI7EdikPKqeaiT40njZabQfuPmJnqf18YXnOSm+1ArSXaB5KXMyNZx7e38H+Vyz7bmF4G9G5HY0tDurKNT/S700sNl2WFuMQtPUyyRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769620625; c=relaxed/simple;
	bh=+IiWs5X+1vdZhz1rpr1SW3QzXxMw0rt6UdXQMw0zzVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KeZOaW7LSm9JP/mACX1STgkyO1Qb9djg4wJ0Z28KcONCaS434sL7eNk7Des0zGNQrLaltCZkQBW9m6bl5Hb+taSc0si5SUZFmNLQGAWZy3wef/8Vj2Cffh4uJbSimHFUn3pVL9HVf08wFgZAO981PGiqUJS63Q7EI5OM+PObvQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ViuoqMBM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rRgZcidK; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769620622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MbfrzMkcR+UNo9AHIJTdeDBLR3pjra3jZ2ltU2ToXps=;
	b=ViuoqMBM1Eimlxmhsx0daNyWkF4lBb/oz8TKG8uOdyFXNuwNGY2znHR/IOZFr+kqstf7aG
	G7ZYnV9hSjq4ED/LvcPPk27Sq57bHdCywTHoYn60Qpk9VnOfT5eNxazJc+xU7+3mI/CMr9
	0PNx68VWbX7YMJcOQqJSjjItWmfI2us=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-Ozxxh9hoOc6l87X305aZ9Q-1; Wed, 28 Jan 2026 12:17:01 -0500
X-MC-Unique: Ozxxh9hoOc6l87X305aZ9Q-1
X-Mimecast-MFC-AGG-ID: Ozxxh9hoOc6l87X305aZ9Q_1769620621
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50335bd75bdso889161cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 09:17:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769620621; cv=none;
        d=google.com; s=arc-20240605;
        b=Q3eYg0k635JVCyxOnfuwwR/zYpOPh9mFhUf2a/Fi9BO4KMtRRlL+ejZVOc1DkOh6k1
         JxoSJ9gvqT97dRzolMUMlRzEafPEtdRbgBw7/Xxb+La7aiG0ElHcO6tU5J+ZamILTFbz
         l2Xx1kE0YsCFfUVvGXnqP4sHSkoELhF5JWUXFAiTWA99VmE2cN/fjnSOTk446QEVFeTW
         sttbmxy6cl/a1DXBun52H8VTeyruOFf2DEvDcv9NKC85sUAeHKn28uiNxBtM1hcGV86L
         pR3FmkvmjILV9xpovDshd6qYOvSAbTxjaEKxrpI43D5rNgPP88nLSCNLc98gVIcHiKYr
         xcSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MbfrzMkcR+UNo9AHIJTdeDBLR3pjra3jZ2ltU2ToXps=;
        fh=sRhB7tpVV1U7dmm5e6alNPUtE9NeB3cTLhZ8H2utfzc=;
        b=c1HT+dztWX+cSPKGbG2FVxyEAMjSkxx7iQkGHfp5LSWUG2rNOwRZ36cQTcPhDO1+2X
         sUAfoBLhaKcdvWxX/xi6A9umNcBi0nuyNchzuM8hAe1kRip+r6rNSvKJVfGztFWzK30U
         cOZ02annYT+VwLqiRcGFqZBrOoGjByf+uWtaIOLeTlDPk9Um6wJhsaiuig40R8An476f
         98Zt8KHzuUr6LWLvH4pZbkNi3fuZ90eajCGxgWv29ukr7ILX7pvgZo17sRDKOdOqsN0l
         PwE27BgFkF37vHJfdIb9OS3Iyw7+RdLr0oDrW7DSBpAh78JUHQQB0jghKQx+y/I1+qNw
         V+NA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769620621; x=1770225421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MbfrzMkcR+UNo9AHIJTdeDBLR3pjra3jZ2ltU2ToXps=;
        b=rRgZcidKtfaPRAoWdKu53gCV2Lxh3XRijcVdMVgRIktmErJZ8QLvaKRSityiKP00rH
         9YuS7VoDCwKjc908v1LYyqWhYrwOTeCFBE7X3axlTe8ItzJvbi/B2lihfUy5YduSfmQH
         U43oXLUwJuqS031+7NA+MK9ySPIZPGSRRey8O2MXWdE0a0uckULZ+WzmN0iPkxEa120j
         LxDFc70z23dxZftFB0jKX321Ji4cDLJMtIMlvkL+Q4ATu2p+KhGl/I8u7JSxxIC7PGEL
         izqLfCZZKc0zj4m2kk3nUtCBtTmTxaAK8iwbET3biD6QB5dnRyYCDy7E12EfismtBQwN
         scLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769620621; x=1770225421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MbfrzMkcR+UNo9AHIJTdeDBLR3pjra3jZ2ltU2ToXps=;
        b=illKpPhKN9VqVgX1WsOSu+8Wjm1PqlfYhblj1p0tVbtIJkMHpcv64aDc29f/MRWi/t
         oeXRUuZVKf6BcVtyjCb7D2bCNHIToqdrQjptd4Edw5BvjLaiCvSv1IKY4w1k8CKwJEYf
         dQn23Gxq+03VbODZc2n6ESNSHJ7CxGS+bNPddo4wZJDJ42YV+ZAXdmerrVvC7o68xthF
         g8W3kKoWSWslkfj0BSZ/OPZK9faGZmso1UnI+sLxAuPQuexfFnOalZKTm3Wice7YVCnu
         xTkhCe0GZbuqSr2RLz9gG7i982JpxgArcb78RmoVv5ZrsEDaZ8MtYKqfM4t9gITcEOG4
         Ob3g==
X-Forwarded-Encrypted: i=1; AJvYcCWn4OFnSOgYUWJjVp7F0XjvwtpTx0QvjeFg6Ytakb+t9Q09h2uz5cwDrc1bjCY2qieII6Qu5Jmxw1higdTM@vger.kernel.org
X-Gm-Message-State: AOJu0YwRLdDYv61o/bNgIIsVRrDKhjiHWmGdTHAMc9LIL7JXC0RQhh7/
	7T5PqGQNQT8NU229YVD4ToDb+ioDujfJQdD4PKr+fP+VwquRNeY7ZF9bYJ/Uz86zrHKsOloJNQc
	3GfQhHo5dcrXnvukLEQ0+/K1bTQ37ymPUj+k+Q3PGS5L1qfYdhDO65fvToYZVrM+wAbkWrqk/+y
	pTHHbK7scPlaXbTGVok26dTf90Q6P4gOPBiTDYqtzSQw==
X-Gm-Gg: AZuq6aKj3arXrCj69LKocLm0lhKMns1EcIXgiyz4UG98Tjxg0O2dUwFC6FLOjb2yzi0
	sVJ93npBLBn12r61u1qpKyFiRI3f5QW1jOUm5TMWbNmcr8zUf/fkS73dghJTyvb1eS1Jtgl1oJF
	HFCCBWmu1teKO+q+xKLiagYhw6yBgAKQjqupBt7QCvqJTVKoUyZtfhl6d3mJ8Z1dMHBz+8dbgYm
	b6PT0nT5AGfbnmYWGtic1TYYA==
X-Received: by 2002:a05:622a:1116:b0:501:4e87:70a3 with SMTP id d75a77b69052e-5032fa1a7f1mr75723121cf.68.1769620620741;
        Wed, 28 Jan 2026 09:17:00 -0800 (PST)
X-Received: by 2002:a05:622a:1116:b0:501:4e87:70a3 with SMTP id
 d75a77b69052e-5032fa1a7f1mr75722801cf.68.1769620620320; Wed, 28 Jan 2026
 09:17:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114195524.1025067-2-slava@dubeyko.com> <CA+2bHPb66HKDZ2DX7TvzvfjW_Ym1TBeVNcPn9w_tnwytje85Nw@mail.gmail.com>
 <CAOi1vP-G_0vPyMOyx6HvJX7VwN8_9FCe9V4Vg9zvg8gbbJNNHw@mail.gmail.com>
In-Reply-To: <CAOi1vP-G_0vPyMOyx6HvJX7VwN8_9FCe9V4Vg9zvg8gbbJNNHw@mail.gmail.com>
From: Patrick Donnelly <pdonnell@redhat.com>
Date: Wed, 28 Jan 2026 12:16:33 -0500
X-Gm-Features: AZwV_QgYxRhrIHrM75G39qUToqwLkdG2j3zCs0ZghqydpwcTesEEeCkzdejbaLg
Message-ID: <CA+2bHPapiqj4xEobqcxmW6b1YChMLBBKaVzxdbEMw+DDZEG1NQ@mail.gmail.com>
Subject: Re: [PATCH v5] ceph: fix kernel crash in ceph_open()
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, amarkuze@redhat.com, Slava.Dubeyko@ibm.com, 
	vdubeyko@redhat.com, khiremat@redhat.com, Pavan.Rallabhandi@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75780-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pdonnell@redhat.com,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A96FFA6B14
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 8:02=E2=80=AFAM Ilya Dryomov <idryomov@gmail.com> w=
rote:
> Hi Patrick,
>
> Has your
>
>     > > I think we agreed that the "*" wildcard should have _no_ special
>     > > meaning as a glob for fsopt->mds_namespace?
>     >
>     > Frankly speaking, I don't quite follow to your point. What do
> you mean here? :)
>
>     --mds_namespace=3D* is invalid.
>
>     vs.
>
>     And mds auth cap: mds 'allow rw fsname=3D*'  IS valid.
>
> stance [1] changed?  I want to double check because I see your
> Reviewed-by, but this patch _does_ apply the special meaning to "*" for
> fsopt->mds_namespace by virtue of having namespace_equals() just
> forward to ceph_namespace_match() which is used for the MDS auth cap.
> As a result, all checks (including the one in ceph_mdsc_handle_fsmap()
> which is responsible for filtering filesystems on mount) do the MDS
> auth cap thing and "-o mds_namespace=3D*" would mount the filesystem that
> happens to be first on the list instead of failing with ENOENT.
>
> [1] https://lore.kernel.org/ceph-devel/CA+2bHPYqT8iMJrSDiO=3Dm-dAvmWd3j+c=
o6Sq0gZ+421p8KYMEnQ@mail.gmail.com/

Sigh, yes this is still a problem. Slava, `--mds_namespace=3D*` should
not be treated as a glob.

--=20
Patrick Donnelly, Ph.D.
He / Him / His
Red Hat Partner Engineer
IBM, Inc.
GPG: 19F28A586F808C2402351B93C3301A3E258DD79D


