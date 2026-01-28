Return-Path: <linux-fsdevel+bounces-75779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGKJHn5EemkM5AEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 18:16:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C650A6AF0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 18:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 241B530143C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 17:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAB7330B15;
	Wed, 28 Jan 2026 17:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SD5BuJZ6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="j6LWtr7g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABF932D0D8
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 17:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769620548; cv=pass; b=mXMquOKdvQLbRH4gCNJf/Q5D30bUdj2YTBrDcUekLBKj2aRQrc3Pg56cCKPSMPDETgQ+wTtifKm3cgJqUn1z9T92FDe0F+x0SK/zxFe4BBp1o9XDadSIaXpfh4W63RzbYNQgdUUjEM/faRxUAhuMHpi3XrZkJE4ThmzpduPmsFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769620548; c=relaxed/simple;
	bh=ozzCNthC9ZT9opoN0bPVJ8O6Pkhz3Qxn/xVikU9Uqyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oj1J4AWUm5e5js7/tE9E5Ih5Bisa9L0lMBJSiTYwY9mDgmfcdYlMoK7vy0DExT+Dvs22C0aD25WaMcDBc2YSb9+gCEBd1KsrUuJj8FWksIQDlqwaAYeGqtEW5RewkTuN6fk0uv1FzzoI8SJ+a/7gv8E6bYR8fm+H+iMkaKHYit4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SD5BuJZ6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=j6LWtr7g; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769620545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DAqniIgPFIzJFrM2PeTRXeg9D8CzK5RsdNaDEumqRgM=;
	b=SD5BuJZ6nHEPK1vszPCE/y5RnlcXtZVOi96CY7P26cnew96PLimrnLdRRa6swq/t3jBuh7
	wdNNBPE7u2SEbE/wMlPXR/BqQQ+GNwu3n2b0r2Q6lleYCO28mYXZUMKz6dPfJJg2TYRN1m
	/mBUYKuEuJOXkR8fcjZssg9N2oF+Pz0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-o7LofxlMOJG7D7BWK-OWmw-1; Wed, 28 Jan 2026 12:15:44 -0500
X-MC-Unique: o7LofxlMOJG7D7BWK-OWmw-1
X-Mimecast-MFC-AGG-ID: o7LofxlMOJG7D7BWK-OWmw_1769620544
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5033b4d599eso159881cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 09:15:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769620544; cv=none;
        d=google.com; s=arc-20240605;
        b=d9lPrMwE0BpDZDwYteFAIas5En11RnpRVzFUZLWbvnZ/Fr21YjAxTR1X6i1w6OVJN6
         DFbQGyT2+pHUmENQqI3GvIPDwX5QW6kX+zWNVQ2s2OBgmA2k4SsnarjfADbVQaQnc9qM
         VB2E04dJu3Ao8NlI60gHwPE5SFEAIH3VddanJ4FM+7vn9tSqg1mXxizJodQaC682YNxH
         QFYdriFV6B6keg2RYIdiXVTWpU4GocsNYUVv5Aoy286g8DRG3smryOVq7pJcOENvWaZK
         P+rZVUCDJL1Asz2A9jplL9MZ7vLvO8Xsj0XFswJO32ZUdFPwn0PiOLsUmOD8y6KfYdEv
         ZK7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DAqniIgPFIzJFrM2PeTRXeg9D8CzK5RsdNaDEumqRgM=;
        fh=ZlAZaoJEud2N70kcriLNIXjc7N0yR3JYRdiHskzjFoE=;
        b=kN+reLSmNQ08pEu77D2COaNwxJ9g2O6oBR9wgc1xVnhxMZIAFMdB6oBWTgwNmx9PKt
         EizHYkel3ZewkK57K2eNAuQkK4hve3SaUOHOQF1b5rdd9A/haU76hEXY2JqMp8ghpaKX
         fiAI4KTc84KmMkVu/oaHeMnXz/W9GNrsH4zXFARXpqYR3XEnJ10KV8/bKVH+o+N/Kpp4
         kyatZyLoXmZyiEz/5n4LCohoWUI967t3Led1kAQAD4KUIUtKWdoR50pSE+z0D9ETlEyJ
         zZfNI2jQ+NVnqRH9Kszmi6RE7IoMT0wyQAX0ie6Kq/eCHtlh8CJqOsPjiiaFAC/KHIjW
         RYvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769620544; x=1770225344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAqniIgPFIzJFrM2PeTRXeg9D8CzK5RsdNaDEumqRgM=;
        b=j6LWtr7gYeZq6vKGx2BGd8I54IUYUgJXm5JwzmDGKL7TtxVM/b+fxxuSxl+bPKTUYB
         vHBtLMTXr+vxjkTaduWugjMiyiBTa5J7HdDNYKD33cTbthQLMtVw+ByTw7FT625uYPie
         KCVL6KGZhK0esa4jBfAhvikq8GkukwrSf3jJHUHj9xiXpgMLlfO/RKB3nV0m9iOoM+iH
         t998j72sLDprRJRxerCAFpEsypHP4+MiFdS1/sRW+9aJQUYiRC5z9PlrzOdJd0lTqXpc
         qpu+0a9FLZFxWBrOFwVl7cJh8ysHYfQfJSadHd+U4VjZ9kBP8w6Jsw1+ZkrBCh9x/hsG
         3pMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769620544; x=1770225344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DAqniIgPFIzJFrM2PeTRXeg9D8CzK5RsdNaDEumqRgM=;
        b=DTW1TD5lmmmD5M050fldYLIW5DDf+MvYudnumhsXVuVfT9j41v+25goP+NZMopSoQr
         u0JlYqm2nB4ZohicU3MDoE78o1DSs+bz20emjCI3dYLp7IsaVuPU5uPpX7s5RPb+lybd
         qqVks7U2K+X/rb25rlo8jULbqWCUJQh0ci/lXz/khWRspjnqS1D9yw5t5fqoU6zDo0zj
         khzTfKizaJlxDHQIUcKV7XYsWRa7bp+LLJP44pOjhugdKDKHlzmMDnThX5lALKGl1wdS
         V0easZSf66AVkdtBoIEwCZYlIkDOGzDcw3ERJGTZm3OufYjMR3vCgxsvcIXLzvF0ph06
         FJyg==
X-Forwarded-Encrypted: i=1; AJvYcCUEYzNCxDiLa3Ylbcx3KAyU0B5IbhK+OHxDvRf6FyI+SXKrU+F3gUS2DLNuvk5ulEmUjvpOZNTgPoaafC8W@vger.kernel.org
X-Gm-Message-State: AOJu0YzE8bLGeKeKcr9FiUzsCGvBueeig+vEjKsNcWICNfuaCzguF1fK
	rO8nvYi5D3UEDlutWQoc8WLgwXpl8z81UFq1hUYU2ptskvnN6XL757a4IxGFrbblAn0Sb8yRu0j
	RK6qlDcXgTYWNYY5Yj01075O6IEraxI4vanr81DLm7Sz/f+UAF9IF1c9+SNSXbH7RrY2zT5LbKG
	Y9F0V1VSWIMoJYnNpGD9FeWj/TJ2lylALOz42CWyx4Bw==
X-Gm-Gg: AZuq6aJpBgygPTb307uNweC3IZR32Gy7oBt1+yHb+XhGHmHSUNnwiUWhs5wYobcSYP+
	7fRZLlTwnBR4M2VzU4T72AuNEN2Rj1A7ogpnt8ezRMueA5Oxs3nOn6gsi6Kvx8l6i82sNgcOkwK
	IemkveVXLsRekore+4F0LXXi4+D/rb4aqnpNHj+spTeKW0PNTNM0N6kswc4jkd+IXjp7t6wsxBV
	8H6dx4zqNcrD/DLkglp4wgKPw==
X-Received: by 2002:a05:622a:14b:b0:4f1:dddb:db6c with SMTP id d75a77b69052e-5032f76fc40mr72501291cf.17.1769620543580;
        Wed, 28 Jan 2026 09:15:43 -0800 (PST)
X-Received: by 2002:a05:622a:14b:b0:4f1:dddb:db6c with SMTP id
 d75a77b69052e-5032f76fc40mr72500821cf.17.1769620543126; Wed, 28 Jan 2026
 09:15:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114195524.1025067-2-slava@dubeyko.com> <CAOi1vP8CwX5T_R4gdZ0egg2oxCwFGAvoi6Us2k4=QFKmtqHmjQ@mail.gmail.com>
In-Reply-To: <CAOi1vP8CwX5T_R4gdZ0egg2oxCwFGAvoi6Us2k4=QFKmtqHmjQ@mail.gmail.com>
From: Patrick Donnelly <pdonnell@redhat.com>
Date: Wed, 28 Jan 2026 12:15:16 -0500
X-Gm-Features: AZwV_Qh1D9HTxJTZ2ETbSTxP8Wo-ChUJ-aostCjWfCpYhDfIOBZuVWfVdl4_WW0
Message-ID: <CA+2bHPa+NK1eBo56ryJ-_4=FK-xRRcbyGsEUOE09wb6U8muVRQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75779-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pdonnell@redhat.com,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3C650A6AF0
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 7:36=E2=80=AFAM Ilya Dryomov <idryomov@gmail.com> w=
rote:
> Hi Slava,
>
> How was this tested?  In particular, do you have a test case covering
> an MDS auth cap that specifies a particular fs_name (i.e. one where
> auth->match.fs_name wouldn't be NULL or CEPH_NAMESPACE_WILDCARD)?
>
> I'm asking because it looks like ceph_namespace_match() would always
> declare a mismatch in that scenario due to the fact that NAME_MAX is
> passed for target_len and
>
>     if (strlen(pattern) !=3D target_len)
>             return false;
>
> condition inside of ceph_namespace_match().

Yes, passing NAME_MAX looks like a bug. Is this parameter even useful?
Why not just rely on string comparisons without any length
restrictions?

>This in turn means that
> ceph_mds_check_access() would disregard the respective cap and might
> allow access where it's supposed to be denied.

From what I can tell, it will always consider the cap invalid for the
fsname. So it's the reverse?


--=20
Patrick Donnelly, Ph.D.
He / Him / His
Red Hat Partner Engineer
IBM, Inc.
GPG: 19F28A586F808C2402351B93C3301A3E258DD79D


