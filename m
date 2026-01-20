Return-Path: <linux-fsdevel+bounces-74754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJY9DecTcGlyUwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 00:46:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFB34E10F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 00:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 463F29A544C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 23:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7ED3D3CFF;
	Tue, 20 Jan 2026 23:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aCResqxK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="uG4Sgw7w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1CA34253B
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 23:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768952031; cv=none; b=DYDNXRjoynW6ZlM2gT8i3qiHgDnuejrR2NVqDs7zBw1dQQMX61B8XA233LdTz+g/uDnWF3zRkR+QJtdji/gPzcP1XBJQpXLDCLzpIfL2qrKVQNb82qqJxwdKE6KZ8lB2m0q4sHgn0behvTDplhhcHyhVw1o+ZwAAZiK7EQJqTS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768952031; c=relaxed/simple;
	bh=EsWk2mKZbN6Ckz6hJiKhhckPpT9Wz80tzbr1yst4jkg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SDADrX1+sLAfDVZOeGW2CTHrCbI14Y/ZjhLkHyBgg0BxH6RxeDLr6XpjHWoxk/j6qA916M5UAZSLKpBl5w45hBgjSN45mPDQ3BqRPm5VGUOlMjjdrcYXRYZMSeneFlXa3t8urGK+4q1einBjWUCNvV5pRBCAj6DBNvkrCOSQPss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aCResqxK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=uG4Sgw7w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768952026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fDsXmcpUm6cHCoLqokCAaUaEGs7as9oep4yg59dybrs=;
	b=aCResqxKZlm+rXFmbeVYh8lzdYHO1KM6b+fBTrI9tbsLgHw43QnRQODMMp10vBkiPbiqzm
	00v1oM+9qPe54NK9qtfCNnpkWpCEf+gukyFUhGl8jQ0LJbn/ygb0txPS9JrqYNkzT7uhjK
	s5Nt9qXj1++ChpTU4O49hHGvZM05Bo0=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-hzmIS-mpMuqDxLeXxB3Fyg-1; Tue, 20 Jan 2026 18:33:45 -0500
X-MC-Unique: hzmIS-mpMuqDxLeXxB3Fyg-1
X-Mimecast-MFC-AGG-ID: hzmIS-mpMuqDxLeXxB3Fyg_1768952025
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7927ce1d097so76018127b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 15:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768952025; x=1769556825; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fDsXmcpUm6cHCoLqokCAaUaEGs7as9oep4yg59dybrs=;
        b=uG4Sgw7wE63h7dbx8798y7srpXTaNHdXE/Yv/vMl11/kdeyIyMFGstJIVuExc2Hqce
         yWBO6CI11l6uqGQZUewM3N5W9RUEbKTmINDQaJAjADGMuGQnt3CpkIoxkZCeE1oiPLbG
         lel4lMqVWyB+QRKHhHKWSMA7BdY0i0Qisi7b6jC/heKqAJtK833QjSmFUrPgwyNQDTN/
         jVbAHWuBQSAXM/f+tB3+0CiokIor0akk1OVxWj8Riqx09eKSKBpvqjd+TyeFXHOPK1PY
         1jhe7hY202/Q9tIr/RuBgJL/BHq4ktlt7K9R3LpzZm6FEvGJ5ZhPBQbasB3Biyp7awuH
         BwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768952025; x=1769556825;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fDsXmcpUm6cHCoLqokCAaUaEGs7as9oep4yg59dybrs=;
        b=eS1n4ELhqyA/OqjoDzn4AFNodIUOeSSC0+lYtvixAGkVWhrVp1p46jCnZdt86EqW+n
         3xYkna3A9J90u8lEEJnArNUWRR4qCLFH9zDWsX1PpMivaZuvXJ5tyq0YtMXQyjiTZSO6
         Ij3xKvKkAfkRUGhlzB2w8nO4kDLEkIL5nWgdbZFIi5Mj3oMcomb1EtJFdxCejIdoNVxq
         Q0ZZ19oNff6Hr1VWqa5QGyofNEEArK6ZRhnXtWDP8QpBm4TICK5yOFz3eDh49Sam7KNr
         rjWwNGAM8hnLlrUrLbDdgS21V6vCq+vO8QyaTb0BtkWoJbx6GAqI+lKO99A/dEefLy0v
         AW1g==
X-Forwarded-Encrypted: i=1; AJvYcCVMUwSX9W6k9hTuIyiVXagiWkGwFGwIr5OtEgYQWZTW1ImNrmjU0J/Ty4FnpCKCDbehyBpRuBftiW5UMbVf@vger.kernel.org
X-Gm-Message-State: AOJu0YwSpNwhplWwLlEPp6DkWZJn9fnVOuFN+d00XxJAUldIrO1DHT2d
	kPuuBzklKk5KSk8ByT83RMonfkUVcDfXm5IX2IG9jjqeS1GTKiuDiT4PlK+RdEHl/WjOhyXAXph
	JhbKRyPCBD+sjoBRYShNzNEqge5P5/kmWjM8+6Y4HrWQoOLiHCrh/lUjrwOIKbn14m8U=
X-Gm-Gg: AZuq6aL2rrkar3SBa9WxecguZ7eTd77+hHS+n4PAaQd7kXlbGPT7PzT3P5mMnHwEDkS
	DRqqLsvVSW095xudiNIKmUHBe5oCSkzpj+Y5Ct81rKBXYqiyhhbSnk2ZiaHA4X6o5choyVZKBei
	KyhES4WIWqT8BXKGJMl48mMLc8kn8jZeS/CIhO5jkbOmfa6c7MA0HqJZKZLcEAs5YLQFy0XkPRx
	ll6DwjaKrwOwo1cTrnmcnxOQ7cFWw+wS0Ciz2UBD5z8OYTjkVyNYLiE+s+rnhq+t9oYBq4jtRd5
	yNhuByUzWq9rvq+wdxJgCl9Stj33NIy1JyJnymrCRg7Wwj7Au9fc2kiP69Gs/SIU0vf65MmMAvA
	JhS09+aqUwKs18ML/x+0cwtKa3Sn6aEOleKcO3wct
X-Received: by 2002:a05:690c:6:b0:783:7143:d825 with SMTP id 00721157ae682-793c671d3eamr131648727b3.25.1768952024976;
        Tue, 20 Jan 2026 15:33:44 -0800 (PST)
X-Received: by 2002:a05:690c:6:b0:783:7143:d825 with SMTP id 00721157ae682-793c671d3eamr131648477b3.25.1768952024605;
        Tue, 20 Jan 2026 15:33:44 -0800 (PST)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::41])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-794153c9a1dsm6580437b3.17.2026.01.20.15.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 15:33:44 -0800 (PST)
Message-ID: <ee742d795d357f2726518b15d4fb131c0f6627db.camel@redhat.com>
Subject: Re: [PATCH v5 1/3] ceph: handle InodeStat v8 versioned field in
 reply parsing
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, linux-fsdevel@vger.kernel.org
Date: Tue, 20 Jan 2026 15:33:43 -0800
In-Reply-To: <20260118182446.3514417-2-amarkuze@redhat.com>
References: <20260118182446.3514417-1-amarkuze@redhat.com>
	 <20260118182446.3514417-2-amarkuze@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74754-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vdubeyko@redhat.com,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: CEFB34E10F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 2026-01-18 at 18:24 +0000, Alex Markuze wrote:
> Add forward-compatible handling for the new versioned field introduced
> in InodeStat v8. This patch only skips the field without using it,
> preparing for future protocol extensions.
>=20
> The v8 encoding adds a versioned sub-structure that needs to be properly
> decoded and skipped to maintain compatibility with newer MDS versions.
>=20
> Signed-off-by: Alex Markuze <amarkuze@redhat.com>
> ---
>  fs/ceph/mds_client.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 1740047aef0f..d7d8178e1f9a 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -231,6 +231,26 @@ static int parse_reply_info_in(void **p, void *end,
>  						      info->fscrypt_file_len, bad);
>  			}
>  		}
> +
> +		/*
> +		 * InodeStat encoding versions:
> +		 *   v1-v7: various fields added over time
> +		 *   v8: added optmetadata (versioned sub-structure containing
> +		 *       optional inode metadata like charmap for case-insensitive
> +		 *       filesystems). The kernel client doesn't support
> +		 *       case-insensitive lookups, so we skip this field.
> +		 *   v9: added subvolume_id (parsed below)
> +		 */
> +		if (struct_v >=3D 8) {
> +			u32 v8_struct_len;
> +
> +			/* skip optmetadata versioned sub-structure */
> +			ceph_decode_skip_8(p, end, bad);  /* struct_v */
> +			ceph_decode_skip_8(p, end, bad);  /* struct_compat */
> +			ceph_decode_32_safe(p, end, v8_struct_len, bad);
> +			ceph_decode_skip_n(p, end, v8_struct_len, bad);
> +		}
> +
>  		*p =3D end;
>  	} else {
>  		/* legacy (unversioned) struct */

Looks good!

Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

Thanks,
Slava.


