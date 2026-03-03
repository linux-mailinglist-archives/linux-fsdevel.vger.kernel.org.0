Return-Path: <linux-fsdevel+bounces-79130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Jq5Ju6tpmn9SgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 10:46:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0092D1EC119
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 10:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8677F311580B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 09:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2268A332EBB;
	Tue,  3 Mar 2026 09:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LZX9ekDG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WxPywm04"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B57326C38C
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 09:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772530953; cv=pass; b=kfaKfZgNimaT72FVffDMLjWnghG0/UwFXIYM2/vhOz0/X60l3r+Xvro8QrgvUmlluaX3vDJenqHe837iNdvAmasaIQo5TLqESbeyR9RqfcNia2cyA4DEDnjymrJWezzu6Fr7gf8SdwcoJM/MO3aN4Cr2EmILWkh6QdT61zWM66o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772530953; c=relaxed/simple;
	bh=/yj2mW0NBVKsw8Lzty5GF5IiC48Z0uRzqpsfTB7QeQQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=tiQ2KJZxvaiFVqoKeV57ydw2O45mYJ3WURpHhVfKc8WNE5eF43U2GKjgVtqNU2kgZ6OnRukbtgG0Lr06tmL75FSBgsAL+UY8le48iKhMW2QWhfev6VN8n1f5Xj5zWIntMswfAARGdYcoXwuKjWilm/ez3fWKrNZ1mnl234YYkMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LZX9ekDG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WxPywm04; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772530951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=280O4eJ/wV+tCznStLFLW+f7jjqPyV02bSsKWxFTH3o=;
	b=LZX9ekDGc+D5FS6G9seNcpHB1Mr/NkVUWA0XbSpL/yBzfz0G3B+nOUAA/sMtb3+WBPeq9G
	AnuepC8MjdqPCqqmSsnuxMui3syksiXBAzsZFsk9YujVGoIxvpq9Jx4Mkf9A7NtT012j5y
	wnrgzAUegtpv6aQKYZPjzvpm6v78ZH4=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-C78ixg6dMR6lCGHRziDy0w-1; Tue, 03 Mar 2026 04:42:30 -0500
X-MC-Unique: C78ixg6dMR6lCGHRziDy0w-1
X-Mimecast-MFC-AGG-ID: C78ixg6dMR6lCGHRziDy0w_1772530950
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7982c466ee1so109745477b3.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Mar 2026 01:42:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772530950; cv=none;
        d=google.com; s=arc-20240605;
        b=Qpn+tlqfOylpP8UoG9oZ/PG8Nr5vICLtVoYWE3H2P0ggWXl48ccTLcnXbTOBv/SS92
         WWAru5Dbg3lgkFHhTX6Nk3F4lyj7kcycyLlfayInEsbuaoKVqsTS3gIDb1W8xsgjtn06
         G57i2oIgIPAdicn6ISDM1kUpNh5d1rz/OmBYAhFXdoPWeJkKzU/bYuQXXvczCVbRgUzd
         HJVW8h9KjRnD4sstIFCjvyE4pSsSivuK08bxfyARqwsYiHUfsQfcOJdgQpUMP2IsTizs
         jLXT+93KFTggfscb+bcDn1bmCnYJeLDtYx3FdW28SdMZcJeevDjFRZdvZ5jK52QTFhVd
         JP5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=280O4eJ/wV+tCznStLFLW+f7jjqPyV02bSsKWxFTH3o=;
        fh=Ul1ibFIA5d8C+V+fI/Io25E/dNkXLHBHCs4XwiqLL+w=;
        b=SV8YbGuGhcl67ouRDZ7SFiEZTpfxnx168xMEdPyG0tw/778h2rhgkFUo0CI4GYEux2
         adEmDntd5gvt5q0LVZspFrprc6+sqRVrOzFA1DF1VotulppaByh8Fd+8UTVqFwbKpLzp
         tQSVsdZU+bOcSOAI/4scJluDCZRYOhfUgXd0mrHqd3MjB2XNb2BEG97F2pk0GAwsj6yU
         y2Ns0VxDScvdKpS2shrJcNFZupCa/7wd7u8A89f0C2UxQlO1ZjRZ63hyK/nLPsOO5ULF
         7vH/zilXQLBMJpPMzwtOQIpcv7C6v4ZbrO2gNZWEbEf+ky5KDyFsHie8EBN5NXKf4ZkE
         BJBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772530950; x=1773135750; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=280O4eJ/wV+tCznStLFLW+f7jjqPyV02bSsKWxFTH3o=;
        b=WxPywm04zcNWMfgMPm9fGyTPbUGs0DFPmQF1OP4djXpQXz5Dc/DP+LwDzjN/3kfnL3
         RKbGupFzeB0gXdRqz/6d93jhb736mhvLgdld4IQeZAWLYgMD9KmG/o2sW4gwHBZQajDM
         0ReYoVfTxR7J89mK0gPc+Ww+noCe81pwCW8fcS8MnkM/7lxO1Iq1cGD1ImoIE4MUbd3f
         drD1xoBiBexgN0msD72BsKm95PvTp0WNmzYNUbmTzXj/g8IkADT8HBSUQ2N7XABRp+iq
         9uPVcun0CYiLXm0mcwOq8KhKsXz49xTGe9b/ogLXo1M7XQcoq8eygVmCqDF8VhOVHW6J
         zqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772530950; x=1773135750;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=280O4eJ/wV+tCznStLFLW+f7jjqPyV02bSsKWxFTH3o=;
        b=GZS88m55WMYSdpj46BfN+yL7UHb0iV3NcahAzGb4hfP7fTG6URR2apdwGsoeaca1uj
         ofPJsgKBJhB5dGP4BXi4l9KnudHHplOK+gPdM0Mx5MalW3IGIeBkEdDz3BqLoBmkf4tF
         lvb1D9Aov8SPI2MmxtlnVN6VpRoYglA05yJdNnscBVZOr5+EqhRMbmPtMcs6LbqvRVe0
         omEWPjLlnQWQs8ycBMtzS8pXvtx8KxlzjaEmYEmanK1XUtOTgOOMCC3sLwUSuoEZh12w
         mCtaDMHffuQir6Qlo60S5EOaW1KyuZj14XUeoaBqvj3fGZJwWtb653u4Ha5nM/JjmgPJ
         MwPA==
X-Forwarded-Encrypted: i=1; AJvYcCVVMw40bGBD43VHbeW6Gc+zRbzHpVGm9v8POFJkmmKUXJXOTIJYDFsZefRD0wp2DV4UlyNV8mAcmWjv3g/Y@vger.kernel.org
X-Gm-Message-State: AOJu0YxiSFzSAli8MxBLDrXMtv/hz/UyAo7kpb0DYYc140uottUhsHZ6
	DiPfkSI0eOqWMH/UWGnenei4qEgvChe1x3fYyhGFZrKj4TiU8HoHd3tbK5pP4XNoob4w+Jw6LyY
	orgxx2Luwv61INclkAjdnOym5y2VXXzX9zBBzdrC0b566/PIjQJ/TDtPK1LJt4ZB5HZ8F8PCk3w
	VKAxvlxjCT3z80BN8zYa7V2brfhixiDNITGidjlNQWvA==
X-Gm-Gg: ATEYQzylZi8Ty6PBTCZjch1Yiz2ZjUtIGmiuk9yOJsqYka9jJkfmt7yu2pHuzqE74UX
	fyIUWEu9MNmZXFStKKey7AUhtvH90tRMd976aYlpXNLC6NYe8oggac+T9/8lePVtVIKfr+rEXP2
	Q5AynyUdYCLymfW+hVYicLZVP992KF8MshkgtTjdZ9gXaIghj3m3IO2pBe7IY2sre+1OUgcoCyI
	oaPKkA=
X-Received: by 2002:a05:690c:e:b0:797:ce9d:5c71 with SMTP id 00721157ae682-798855c6320mr145284087b3.45.1772530949802;
        Tue, 03 Mar 2026 01:42:29 -0800 (PST)
X-Received: by 2002:a05:690c:e:b0:797:ce9d:5c71 with SMTP id
 00721157ae682-798855c6320mr145283957b3.45.1772530949457; Tue, 03 Mar 2026
 01:42:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 3 Mar 2026 10:42:18 +0100
X-Gm-Features: AaiRm51ZULYt-vLs6o1MyOGTDebdiHIeo2M9vqVZ7FwXgbPhxa9AQgGMccX0isk
Message-ID: <CAF6piCKbxHF7DASK47-q3DFdtKgvheAGdLUaTwYsfg3ikZAi-w@mail.gmail.com>
Subject: Re: [PATCH net-next] net: datagram: Bypass usercopy checks for kernel iterators
To: Chuck Lever <cel@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Network Development <netdev@vger.kernel.org>, 
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>, Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 0092D1EC119
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	FAKE_REPLY(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-79130-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,oracle.com:email]
X-Rspamd-Action: no action

On 2/25/26 5:25 PM, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>
> Profiling NFSD under an iozone workload showed that hardened
> usercopy checks consume roughly 1.3% of CPU in the TCP receive path.
> These checks validate memory regions during copies, but provide no
> security benefit when both source (skb data) and destination (kernel
> pages in BVEC/KVEC iterators) reside in kernel address space.

Are you sure? AFAICS:

size_t copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
{
        if (check_copy_size(addr, bytes, false))
                return _copy_from_iter(addr, bytes, i);

calls check_copy_size() on the source address, and the latter:

static __always_inline __must_check bool
check_copy_size(const void *addr, size_t bytes, bool is_source)
{
        int sz = __builtin_object_size(addr, 0);
        if (unlikely(sz >= 0 && sz < bytes)) {
        if (!__builtin_constant_p(bytes))
                        copy_overflow(sz, bytes);
                else if (is_source)$
                        __bad_copy_from();
                else
                        __bad_copy_to();
                return false;
        }
        if (WARN_ON_ONCE(bytes > INT_MAX))
                return false;

Validates vs overflow regardless of the source address being in kernel
space or user-space.

FTR, I also observe a relevant overhead in check_copy_size(), especially
for oldish CPUs.

/P


